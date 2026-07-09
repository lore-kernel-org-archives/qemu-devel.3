Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2525EC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkGj-0001Fz-PV; Thu, 09 Jul 2026 04:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1whkGh-0001Fc-Jo
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:38:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1whkGf-0002WI-BR
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:38:03 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6696ISph1154923; Thu, 9 Jul 2026 08:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3MNrVL
 DIguZ8+WXT4R5LsbdrW/uCpZnZGFs8D1sBjDQ=; b=KpEYEwfl51nOzKhfw3sKUk
 cxIUbPvWiQ/3aSgoshxl5kFDnyWA8+xxldBhaAUXPCiBuTm/Myc7/lvgRThV/Ogr
 9gevBcn0yD+mLb0DyB0+ne9rLsmsy+lmBNLhtkOXc1I6Bc5ehxC3M/jXQc/x8gqS
 nhRclzsy7eRPPbJiJZv6WqR1Xt1P4GrgfMxIeO4p5fvdxsVYZSwxI34cNVOeY9+1
 hyLbz2z+64yBiV5px22a70Kz2USqY/orcYXMo1Xxy3SCYS5qOcJ0/k/ILJHXXz9Y
 WLZ41JRBeYkpcRzoBmgTzP5Mfib7WyyO4bGcUx0nov1HvfnprPA2Nij1GP462ULA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw50tas-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 08:37:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6698YlXZ022616;
 Thu, 9 Jul 2026 08:37:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqch5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 08:37:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6698bt3M29164138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Jul 2026 08:37:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 125FA20040;
 Thu,  9 Jul 2026 08:37:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EFD492004B;
 Thu,  9 Jul 2026 08:37:54 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.224.75.238])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Jul 2026 08:37:54 +0000 (GMT)
Message-ID: <b4c289b6-3b64-4dd9-84d8-a73c7648d092@linux.ibm.com>
Date: Thu, 9 Jul 2026 10:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aQOhjngocz3dgmgx_OQVWr2CeIHW8Wnc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3OCBTYWx0ZWRfX+XGCI836SWv/
 TUt75CXsOO2QoTtGciIDHkbDXKiTB4yGR3a89dwaxNiWbWVNUY2p9YQpxyCay3OyQOg7i6C+0Ot
 twGBY4O8Ysn2hKAtq0YV2GHI1ssM4dXmKtpjujUIfSEvGlbuvYUhAuR6oWr6Xjwnh0647My+wXo
 hN1sayrEeFTnocynO3d8m2TdGvstLjEbXCEhbeLfKE0Wko6m46sJSFFZAAqBXWgAQbxWV8GvKQb
 UrXlI7w9THJbeOLBOdChaCaKr5hZa7oQiu/mAd3MbCdIhdSMBVmkw3h9rtBj1NlXbaUecFbGfCJ
 r3heUAaxckUI33NIIsQBGb12QRZlLvnRDkAvLV0IItMaTtgH+5PZdQlfe8hNqMB0YAHsdYDusDN
 jOrI5qkQTIMwB8qsA+fXQMZyhEui1ASX9kyo5dxFovsp0mk6yo2TL0rBHLNgHvjgQa43hXpvLbb
 PkFucYdiD7YnVVmFDDA==
X-Proofpoint-ORIG-GUID: SFNB4LxRAbmvOFi3ianHluGGW2u0Jkx5
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f5de6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=cryIHRqGAZNLDTTz9SAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3OCBTYWx0ZWRfX9KztGs3/AsUH
 o5zUIIxU+R7MHm8Mhauacyu/OV6ZDkQszO3D+rJ4O2/PoEPI5lBAGZfmm3W3S9ZVHX3QG1MoWhc
 AcZki+Dq2C2MFQGPSZXTdezPDF4X9kU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090078
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 7/8/26 17:05, Max Filippov wrote:
> Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> which matches the way it's used to store `argc + 2` pointers.
> 
> This fixes the test for me, which otherwise fails on xtensa with the
> following message
> 
>    linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>   tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> index a7059aacd9cb..b5ea65f3d393 100644
> --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> @@ -39,7 +39,7 @@ int main(int argc, char **argv)
>       assert(qemu);
>   
>       if (!getenv("QEMU_RTSIG_MAP")) {
> -        char **new_argv = malloc((argc + 2) + sizeof(char *));
> +        char **new_argv = malloc((argc + 2) * sizeof(char *));
>           int tsig1, hsig1, count1, tsig2, hsig2, count2;
>           char rt_sigmap[64];
>   

Whoops, a silly typo on my part.
Thanks for taking the time to fix it!

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

