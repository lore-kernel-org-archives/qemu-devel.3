Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23DAC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96I2-0008LU-7j; Tue, 22 Sep 2026 15:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x96I0-0008Ke-66; Tue, 22 Sep 2026 15:36:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x96Hy-0003sd-HM; Tue, 22 Sep 2026 15:36:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7NoA3447412; Tue, 22 Sep 2026 19:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PJRap+
 a6/wYD2lXvgiihjowd5/NdvyU1U5dL5WLd2rk=; b=VSRypRg131l8CL/5tnLMe6
 WDVwr842botDnrn8IdEA/W+MfUQ37NSzroXaHixUF9L8mHos3VoEQO2GIzBvJbjt
 K6gmgp8icbIReyn3oIV99WtLzT0zd2/WOa1oiJautWnA31F2u0GloZXrP9vSJcOg
 xq/53L1pQ/ykHIP8Hp8Xaewl238jbLhv+9Sm+v/DlV5vqGNe6KcliHGAYFsoyXrs
 tTtoHLp4Qm/wVtxJEmo+V/4tDJD9yj+hhKTZck8tw+MS0XTTDJeZ+qEGN8GxHE1T
 ukOG6hLeITXsF6RH1XAG2sNv7IrtfD/IH4rkQjWiC3kAMr174R31h1BGkMlrEJLQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qn3s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:36:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHWup3239737; Tue, 22 Sep 2026 19:36:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gu4ub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:36:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJaM3q24052268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:36:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F35758043;
 Tue, 22 Sep 2026 19:36:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 890CA58055;
 Tue, 22 Sep 2026 19:36:21 +0000 (GMT)
Received: from [9.61.131.16] (unknown [9.61.131.16])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:36:21 +0000 (GMT)
Message-ID: <fa4e3ab3-c42f-49dc-8f19-37ee006aab24@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:36:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hw/intc/s390x: Fix check after g_try_realloc
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260921184305.3791311-1-farman@linux.ibm.com>
 <20260921184305.3791311-8-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260921184305.3791311-8-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vh5sU-czgsu2ipr5e_09EnfLhMxKe8MU
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2d8b8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=DdrnoSRpkw2cHQbIOW4A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX4EHMAHU1TZ14
 5v9L/nGjxqwNKSYA28GrOU4pxW9uikyKI8G/tgMG84W0PcjAaUNHyuo66Sr28oZxl5cW6c2H/od
 tNdmqgPx1rfCL2Tf3IcUE8vNBLnag2g=
X-Proofpoint-GUID: vh5sU-czgsu2ipr5e_09EnfLhMxKe8MU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX8+klsIu5B3Ha
 kmXRoxlix9tm2kc1RXOiTZzKHrweojueHFG7NYWcqTqjKHgHqxyV9cbnrYrz21o7Q31wir4FgM/
 CNtOqDPVJwjcQFfAo3MIsLzByXQ0w1ChhAkr4rknCTWAspYl9mrleKvvGtHgQOnLfZzp269oMXM
 M34wuBbNC0+5JZqHRXIld/qzsk9bav4FMznGEZCZedocBMw3ATZle1XSOe1j8nZJRWwPK+Kkauv
 9+fs6hoNrK3duAwdldnLJ6yQYUk3hZsSHxfGKluHU4ftBKCOSBuUgx/CVaZex+IdX0rv52CDAPi
 GCl7ozupC9VV/K/HblQnmJy6sytzinGnf5dVGcoMsEgdWqQGTH3Fen2RfVyTlS3dusOkHN8gnpa
 oGduQEAKvhdrjegKWoDpFsuro5CUiRvpYHMJDv1HURIsYJzrnbpxKttmdNTqqwkjknt2vHHY8Lz
 B2+XY1rudX56jCe5gHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/21/26 2:43 PM, Eric Farman wrote:
> The loop to store pending IRQs uses g_try_realloc() to expand the
> buffer being used, but the returned address is stored in a
> pointer-to-pointer, thus the check is supposed to be examining
> the contents of the pointer, and not the pointer itself.
> 
> Define a temporary variable to catch and test the returned pointer.
> If it's NULL, return to the caller to perform the free on the
> unmodified buffer. If it's not NULL, store it in the caller's
> pointer and restart the loop against the new struct.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 3a553fc658 ("s390x/kvm: implement floating-interrupt controller device")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
With Christian's suggestion addressed:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

