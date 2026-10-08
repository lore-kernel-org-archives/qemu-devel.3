Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD31CA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEx00-0008NS-M5; Thu, 08 Oct 2026 18:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEwzo-0008Mq-Ni; Thu, 08 Oct 2026 18:53:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xEwzn-00029O-84; Thu, 08 Oct 2026 18:53:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L5i2W1222769; Thu, 8 Oct 2026 22:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HSUhK0
 C64ehpb7nz+XWvIzSkA4Bou+FsMSwWbfcIE7k=; b=aZI8+xqCWzdvXunlXZxV7i
 x0NzBsLwb6NJm7cAlL3qYKhJ1W7NROailph7FIbn+POfpeJ8NV9V2RZ/5Silzz7b
 okAJcweMAfCDCoDmqe0UM2HEHsKDH6oZqoOyRG0DTpNFgBMw2S6aIqdnv6WO9zTG
 ULfAIFeJTLeCnELCuoFdI/XyIc0hj2qVWS+QNEMgAivIORb4qHTQe4PiJ7WhYrKw
 cTyZM5kG4XavBekCNrnGtuckZj2UXTidH0uILzRWn1XoZQGVHNWWRBBc6+6MXCAV
 DiLuq4+DpHBAC2itZB7vLXlblcULBrIKaZ/DDi6ZaUkvx6S71lDo6mj0G9WUFpVA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xk1ejq4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:53:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2XIX4078983; Thu, 8 Oct 2026 22:53:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dsdhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:53:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698Mrhmu17760984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 22:53:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 124C358065;
 Thu,  8 Oct 2026 22:53:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19E6958052;
 Thu,  8 Oct 2026 22:53:42 +0000 (GMT)
Received: from [9.61.81.219] (unknown [9.61.81.219])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 22:53:42 +0000 (GMT)
Message-ID: <9d0a930c-9dbe-47a2-9424-3ad0190c2b74@linux.ibm.com>
Date: Thu, 8 Oct 2026 18:53:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] target/s390x: mark feats dependent on deprecated
 feats as deprecated
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
References: <20261008215956.164881-1-walling@linux.ibm.com>
 <20261008215956.164881-3-walling@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261008215956.164881-3-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YtCa1IYX c=1 sm=1 tr=0 ts=6ac81ef8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=0Aa6-ysIQ_LWr-g1Ir8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MCBTYWx0ZWRfX7YHRgUlyk398
 cNuoh5nZuhQo5vr/OfI6VCYI7OnAC8eQgfrTjLx2cVu+ku6ca2mwBRkPGMuyRxSE035BvK/Q9Na
 FVdajWniZNdSL+b6/IvhJOYTQxuJtYWt9f1TtT9kNWKpEpgq1yiJirc26AhFGwlRKPBsB06LmEZ
 0WcZwu9B7fTtiU0TEfadw16Q3Lc1uhGBiSWP6N6vPZLCHPPpSWKAg64MI/eJ+RlJu1gHLbi4EeC
 RM2wuxYKUtbMSCEfyzA7IWhagEQPTG8eBDiV4rOASo+A7uNtBFBclaHTiMlmO5ryF0A8JnL7d4i
 0uPSuxPgANluO8vQxmtwKgDQN+3BPlVAiat4Ff2d5L3guV+5UwTpSleJ4+3OLewfKC691GA3Xv8
 GXM2ak/rtxYSVoNaKbXzBCTA/uDAMyXaDPzkCux53PkmJaY09+KiaYF528MAiMo+gB7BxiPMGTV
 3Cm7VwKx+xi8dz1quAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MCBTYWx0ZWRfXzlG2QNKsSoLd
 2jH1H11ozrbw12qIxLgla1N6yCh9nWGGro5dUDHquFC1lIEdBuSr/muEMhvR9LsQly3sc4qr8lA
 sIfnYm0UoUYGAPXHxLe401JcciYsj+U=
X-Proofpoint-GUID: 4-aTUOzqS9qMKfq3QhQSU5rkcbmYG-TV
X-Proofpoint-ORIG-GUID: 4-aTUOzqS9qMKfq3QhQSU5rkcbmYG-TV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080090
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/8/26 5:59 PM, Collin Walling wrote:
> There are certain CPU model features that depend on other features
> that are flagged for deprecation. For example `ineff_nc_tx` depends
> on the `te` deprecated feature.
> 
> If a user defines a VM with the current list of deprecated features
> disabled, the following is observed:
> 
> 	warning: 'ineff_nc_tx' requires 'te'
> 
> In some cases, this will cause a VM to crash or it may refuse to
> start.

Does this need cc stable and/or a fixes tag then?



