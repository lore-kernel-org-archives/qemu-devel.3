Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816B3C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvwvM-0002aH-0u; Mon, 17 Aug 2026 08:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1wvvYB-0006Kx-JC; Mon, 17 Aug 2026 07:31:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tasmiya@linux.ibm.com>)
 id 1wvvY9-0004sR-NF; Mon, 17 Aug 2026 07:30:43 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HBA1nB3685351; Mon, 17 Aug 2026 11:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=d0Qk79J7x78ch+ZEgVNnp9klfeeXmh
 fZcuDfGlemCHA=; b=cxe1fkPtmSUIruyNPlESaopI7bD23dYxVxvSXYxa0QaJS6
 Mp8VgH49BVEPF2lSU3gwEfCyWhp36MnFzl4Vtgs3YT+9HkN/fl2XC8gRq2RLFlOY
 zwDcq8RllbKBMk4IM1m5uvcxOrW+SeLaW8O8achjD1yAps3Fny81k72BGZED4FU+
 51MTDoGWJdMSWaz8sIl2bIZ4Uqp05grwy4w1PV96P1UhftXDw2maO0obWM1NcNbq
 pp2pB7xqqFH+cBo742p1/5Y6NrkE49TUs/FmWTVTVlneDqKUhz/5lcoTJcezSgIg
 n8xOpi6zd97L/fdLsnPIZ2lGECFVvthF0blHHajA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3hypy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:30:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HBQNjQ032694;
 Mon, 17 Aug 2026 11:30:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvwwvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 11:30:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HBUSfO46793106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 11:30:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6647B2004B;
 Mon, 17 Aug 2026 11:30:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CE6C20040;
 Mon, 17 Aug 2026 11:30:24 +0000 (GMT)
Received: from [9.61.253.76] (unknown [9.61.253.76])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 11:30:23 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------JzPKCB9A3JpqCa5IjS1335Jp"
Message-ID: <d528bed4-fa37-490c-8562-cdf7e0d609af@linux.ibm.com>
Date: Mon, 17 Aug 2026 17:00:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: tasmiya <tasmiya@linux.ibm.com>
Subject: Re: [PATCH 7/7] target/ppc: Add ICBT support for ISA version 2.07
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, milesg@linux.ibm.com, shivangu@linux.ibm.com
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-8-rathc@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260715125634.2107320-8-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 5zPltG9T0yVXgwR4KnkHbXmvIRQgwO8z
X-Proofpoint-ORIG-GUID: JoUe8kOaTFyJIcYQwEH3e1p0uuh-qx4p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA4MiBTYWx0ZWRfX2wyTO+5OX9HH
 hqKhXt/Jt/w1cAlEY11XcvkJQlAwVrfuNJJ95lUOJH/KjRaMEacf4EPUuDaeEaD4Ik1mSPIEf+i
 uvLHCOVZ8PIHrnkcTSX55c0KCtQpe0U=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a82f0d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=Pp8WnITD-ZstDvzC6fAA:9 a=QEXdDO2ut3YA:10 a=OnGLaWPSZAZnKT-RGIgA:9
 a=73M0mSZGDu8vpsm-:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA4MiBTYWx0ZWRfX9SI/AM5oHs8Y
 j4PUru86ChvYtcipWNYn1+L5PXl0ShswWAulUMEeNp3AYZdBzYAnMrIA+N7SwOCbV9td3iTWLEd
 HDjEi7f2VqjNCKjsSgiftO9CbFQ4AY0n4NAr14Kgrw3KO6BnDtUkzNLPebBRPTwU6xeSQhqy8c5
 igoxktvDlnF9GGxopDkKVX0ful+TSuCtESHpz9B6zx1qUl0e/J0fmPn3VVrRA3tx3IK+vJ0UKmt
 wcomUgW3DnYRSM1IStLeNnOcSykEDmhcjfPU2Bv3GkfpJRqaOg07qP3dA2ZtQJqJHJM+tieRMjR
 kHSbH2YjulxsbBvffDITia7a2zcHnJcD4zodBv25OOa5nTxxriA5ALskG8BXskTrWbiDiZp0u1H
 SdqRK3LZDfvT9B66vEq6BnLGwRnMtt4uqXI3MuNXNxKaxyHLHxT/JIicBHGFTsVUf7ftu7iyTAF
 0oOk3CtGYqqlreolk7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=tasmiya@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Aug 2026 08:58:42 -0400
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

This is a multi-part message in MIME format.
--------------JzPKCB9A3JpqCa5IjS1335Jp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,

I tested the patch on my setup and can confirm it fixes the "illegal 
instruction" issue I was seeing with HTX mdt.all on a KVM guest.

*Issue observed (before patch) :*
With HTX mdt.all running on the guest, hxecpu would crash with:

/"hxecpu[7487]: illegal instruction (4) at 7fffbc401054 nip 7fffbc401054 
lr 7fffbc400adc code 1"/

*After applying this patch:*
The illegal instruction errors are no longer seen in dmesg, and hxecpu 
runs cleanly through HTX.


Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>



On 15/07/26 6:26 pm, Chinmay Rath wrote:
> The summary of changes in Power ISA version 2.07B mentions :
> "ICBT instruction has been moved from the Embedded category
> to the Base category".
> Updating ICBT flag for the same.
>
> While we are at it, correct the invalid mask as per the ISA as well.
>
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8dab54ccee..3cd849c706 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
>   GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>   GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>   GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> -GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> -               PPC_BOOKE, PPC2_BOOKE206),
> +GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
> +               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
>   GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
>                PPC_440_SPEC),
>   GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
--------------JzPKCB9A3JpqCa5IjS1335Jp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Greetings,</p>
    <p>I tested the patch on my setup and can confirm it fixes the
      "illegal instruction" issue I was seeing with HTX mdt.all on a KVM
      guest.</p>
    <p><b>Issue observed (before patch) :</b><br>
      With HTX mdt.all running on the guest, hxecpu would crash with:<br>
      <br>
      <i>"hxecpu[7487]: illegal instruction (4) at 7fffbc401054 nip
        7fffbc401054 lr 7fffbc400adc code 1"</i></p>
    <b>After applying this patch:</b><br>
    The illegal instruction errors are no longer seen in dmesg, and
    hxecpu runs cleanly through HTX.
    <p><br>
    </p>
    <p>Tested-by: Tasmiya Nalatwad <a class="moz-txt-link-rfc2396E" href="mailto:tasmiya@linux.ibm.com">&lt;tasmiya@linux.ibm.com&gt;</a></p>
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 15/07/26 6:26 pm, Chinmay Rath
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260715125634.2107320-8-rathc@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">The summary of changes in Power ISA version 2.07B mentions :
"ICBT instruction has been moved from the Embedded category
to the Base category".
Updating ICBT flag for the same.

While we are at it, correct the invalid mask as per the ISA as well.

Signed-off-by: Chinmay Rath <a class="moz-txt-link-rfc2396E"
      href="mailto:rathc@linux.ibm.com">&lt;rathc@linux.ibm.com&gt;</a>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 8dab54ccee..3cd849c706 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
 GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
 GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
-GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
-               PPC_BOOKE, PPC2_BOOKE206),
+GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
+               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
              PPC_440_SPEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
</pre>
    </blockquote>
  </body>
</html>

--------------JzPKCB9A3JpqCa5IjS1335Jp--


