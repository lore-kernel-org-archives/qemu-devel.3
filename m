Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E80E83830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 20:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs4wX-0006Qk-1R; Mon, 16 Feb 2026 15:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vs4wS-0006Q8-Hb; Mon, 16 Feb 2026 15:11:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1vs4wQ-0001AT-NJ; Mon, 16 Feb 2026 15:11:36 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GEqhMP3526026; Mon, 16 Feb 2026 19:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zd6B2N
 Iec2MKTrQknnfEfVqb1JuAWmjCZoGLgdlRh24=; b=B5ccpVsMgggGsxxhmUrmqb
 +bRvuNPhzey56ScxwFxu2DMlhaAa/d4IYgGuL/M5S9yjb62TkkS5i1RBZVrAQUiC
 tIZ++Uf9+3EW+L4vsFp9UuOPbRslU+S4PHioy4biT75PVE3v5v5yFWBkBEY+KAgA
 T90pKB7Szp4Yv8qCU+ifO8jQ61W8f3sH3bqx7TU4x8eg5RGL+Ca79sZepr/Dxt1c
 IHWb8JzcxYz2ztt25lbMfwYQmjwd9yj73aA57v1wZESSM+ftM3+1aF0vSlG6JRWV
 E3AOD6dkPNTE/f9Zq8yaNZh+bplJwrnYPVUjaBjVZ2dNB0eHwjzuBawe3Pb/VE8Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj8hpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 19:44:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GGjOHl004035;
 Mon, 16 Feb 2026 19:44:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4cmxmcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 19:44:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61GJilp551314946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Feb 2026 19:44:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B5D620043;
 Mon, 16 Feb 2026 19:44:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B61A20040;
 Mon, 16 Feb 2026 19:44:46 +0000 (GMT)
Received: from [9.87.132.244] (unknown [9.87.132.244])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Feb 2026 19:44:46 +0000 (GMT)
Message-ID: <8f5f2131-b5cc-4a9a-84f7-57586c3df928@linux.ibm.com>
Date: Mon, 16 Feb 2026 20:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/kvm: Add ASTFLE facility 2 for nested virtualization
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org
References: <20260211-astfleie2-v1-1-cfa11f422fd8@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260211-astfleie2-v1-1-cfa11f422fd8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9sM1BSp6PJco8Z1Nslvk5YLzI2EHDmPU
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=699373b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=PTbICRZ3nymfZhTA7ioA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE2NCBTYWx0ZWRfX8FMS/CMi/THg
 2VfOUEJrAQaiL9iEBy8YFT1YZRfjUxU7Bqj4o2cfn0afzTpfbG/Au3OXVl42mZkFGQ99KOj5O3i
 JTZ4WmnXYiXVHV6GJeIVZf+ZJbsGWB06Zp4p3ccpWWV1Yq5q06Qpg3XCYvCnwR/gXz9744ZgWei
 ywgXXWg7LWX8ITI62KHGvUgCQ2PxO+QeyyqbhBHj6xppsiiLtl29w07ydfkgDor3wd0znluwari
 41bFx9N/m5KxhQrsQNiXWNr7O8/felT4K/rYdHpUcjLqGAim+MxNf9/Z5wxjuGN4uYI78KvYXkA
 QBvmvDLqIWr0zN3clBrWfUxBnYJsQNh6+Zyq95UZmfzQukB8bnj6i2/rUPGhZI+4H0pWEEiH8X3
 Ap6+bqtxeTxN9NrAwQXx916/3kV9fG0GmWv5H2RXgfqT9lP1eI/9OKweVO8L+82jBC/SqzIkMrd
 ZyxHB/sl39WpDnEQdjg==
X-Proofpoint-GUID: 9sM1BSp6PJco8Z1Nslvk5YLzI2EHDmPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_06,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160164
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 11.02.26 um 15:56 schrieb Christoph Schlameuss:
> Allow propagation of the ASTFLEIE2 feature bit.
> 
> If the host does have the ASTFLE Interpretive Execution Facility 2 the
> guest can enable the ASTFLE format 2 for its guests.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
> Cc: qemu-devel@nongnu.org
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> To: qemu-s390x@nongnu.org
> Cc: kvm@vger.kernel.org
> ---
> 
> @Christian, @Hendrik: Please confirm that we want to add ASTFLEIE2 to
> the Z16 default facilities.

This depends on the sie facility (sie format2) so I guess it should not be default
but rather FULL model.

