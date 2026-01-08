Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290F9D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqJM-0002yG-IY; Thu, 08 Jan 2026 08:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdqJK-0002vz-OO
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:44:22 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdqJI-0006OC-UL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:44:22 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6088T6QO2239351
 for <qemu-devel@nongnu.org>; Thu, 8 Jan 2026 13:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J9Z+KyeIcck1eoliV+89SwfPuTWpSjS56jAneXwB/tw=; b=EQPtYY7XUeRyqAJU
 nhYE7LnOIImPP6jOsieLlW9dwl4Kn558OZXjBgb5efeoXeSsEP8aHoDskmxpBSwy
 JnOGuVzmc77tQSWneMWNSvXpq10952yv2MegkzsOVZ68Tj5enOj08J/fyGPwJBMU
 w/CBJyzbq/nEfhCdx0YlJl4Dk0TRjuNuq+IV8JYzuZJmHYS/XUUr+ZlC0vIIj7IQ
 pKkuGYvWDWRZIcDuETnwcWbsQOWIXpUFgJ12hhi1iSUgCql6kO3TpJWGaGpSfk5m
 83JMe8dIYF5o8G/uQIwjbThp8AeIocu15XpMHGYAx+A4V125GVJLV0CTz/R+vFA+
 Rb9YAQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhqwg4669-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:44:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ffb40c0272so51637021cf.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767879859; x=1768484659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9Z+KyeIcck1eoliV+89SwfPuTWpSjS56jAneXwB/tw=;
 b=WdHNLclEhlcUXHNUHVuISfcpaqSwQYJRpV2+FZU8EG50NoD5wNpVitL9N7QCJjKBFJ
 HCCW6pjRQXENrLeHsQr6GkYCQWkqk5AqmzrGg/b/TM9upy6w7qgfAnz2q2S2g8UNLXco
 y+pB66zPUzlkhsxx9i7WxQR4/I1yu4i/YQnMdD0UoPMP6tczIXBVtDHrIT9CcTPSvwtx
 TM589dKD1949c3B9qozpp/c13QGKEAtflOtWQjZuEFawwBMcR8p6+5UHtcsXylPv1SAJ
 xuWAQijT6+0ro13x+BDv2TiTQxvdC6AdXGAMWXsQk1TUVKkH9spK8AAPOmvlnS32ffzO
 t4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767879859; x=1768484659;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9Z+KyeIcck1eoliV+89SwfPuTWpSjS56jAneXwB/tw=;
 b=Rs+hi/QWNcynH/jJ1SwkRlSwEjYSnHDNGIciUKDsH3e4cThJdApLAbHaKnDeviSrZT
 yVhdarGbA4UPYTCNwNMufo3zNQSWbZININ6DF/98MEbAQv8Jr89heQ2WHsiIH+ja2p5/
 feMaMHSAViMg8WElbH9btL3W8KKMw650u0Y/2vspsJ+DnlQRp77ajeO1F7X9ZuDi8m4G
 cOA3RBvPQj+nrp+Kequj6HInXIq55ASabp4yFQX0MWDztOhLUI+V++CZzqYrdyBI0alO
 HU9giABBBxoJ+Bzf4r+VAnFxdZXTwjfMqoaJlPieTmcg0fZOvCNwkUDLtJ911/yY9TPp
 7JmQ==
X-Gm-Message-State: AOJu0Yypc6pg/VTUqCrW5Wyf0/I+GEfgBBHp5rkTJfj/h7+PVHGs8+o0
 On1YYqtoyVWsZFyCVXAQL2guC5VS8hBJa9OEQJN6Jss4JkJzwNbvjaaB97kMxJtVgzI/fw4p/Do
 YYBptPQR9C/B8T9tP8RhTOLbnDRjlTod3tRsxUTc8c2aNbSQ10MMM7aiWTZZ40XJWhA==
X-Gm-Gg: AY/fxX4FXybMVFArwdGI+laSyc0/RMsDfcz71LFc5D0l8cqPiwXH5PKB0bzaMtDz2M9
 GgrM6S7KmHA9cG0ASCEb/4Bo91xX/n+aGD3bORuPzuFvAE5Y1kRwkKhhRApWYzEOzG2bJ0aKz0V
 NrhBx9eZye12ildi/xF2bFhjfy7Mc329exDgVY8jUREsa6rU4Bef8UQD6dYpovEz1VjlsgLG0vJ
 Yp1xvPzyCICmUGwaBU8S3i27JZcoVMPV5aSOR3rcXoHDPaXk4WS9gNwtIrj4PaNtnddyS9p3RUn
 NGIYXuT/qoUw6DY2XxuhpBbslSGkNtNwzQ+adaKr6ILHlwBT2AttTM7HsJLerN3iwmu7SwjCk7u
 9YrE90dzsQP8JCyx59ClR2Ry5/B78ux0x/P8GdVZVoNdLbhMR9WZGfPwSuOU0H2LFcr2PH0lvcE
 JlIhVhkl/xWiWNz4Dp
X-Received: by 2002:a05:622a:48f:b0:4f1:e0fc:343e with SMTP id
 d75a77b69052e-4ffb499ad6amr84030171cf.37.1767879858695; 
 Thu, 08 Jan 2026 05:44:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeFvK/Yhnu/XVwf9QuVzjRqikPY0MMaZSQfpiItB+ZwJfPFJcPowsd3wGGrB0iMhIN5AL2Kw==
X-Received: by 2002:a05:622a:48f:b0:4f1:e0fc:343e with SMTP id
 d75a77b69052e-4ffb499ad6amr84029691cf.37.1767879858132; 
 Thu, 08 Jan 2026 05:44:18 -0800 (PST)
Received: from [192.168.68.101] (200-162-225-127.static-corp.ajato.com.br.
 [200.162.225.127]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-890770e2833sm51798196d6.18.2026.01.08.05.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 05:44:17 -0800 (PST)
Message-ID: <905164b9-edd9-42a4-8589-70afb79f2f35@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 10:44:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] roms/opensbi: Update to v1.8
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
References: <20260106211112.3752298-1-daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260106211112.3752298-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: R9VM58-NjTPNDinUkrzr-a2fFYGHnLS6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5NiBTYWx0ZWRfX1yRJY+Qf9EvF
 SNlCc5PmGQ9B9O3qPW5ezfMFrQubd3KIRGI5BCE6hkR1lJx/DwlaS9Xc/Qn9ovemy722+k2zNLR
 sHSUg62hDLVh3+k7Bw6KWiO+0q9XjiOr3ls+y1Y56Bf8QH/kUGSJMwG5G1IMFpA9b/lwyVp/TeN
 lDuj9iHdxg/44HZG1tpbbN7auTBVm1qGgq43seB+catWidd5dT4PViHtiiMJOUaYKbeE8u2zxmd
 zLgErMvfJ+XvA/XSK469q4S4uS2zd8wgNbmumU5l7P9iJmnmo22mW1RGKs5XmAJuL9MV17ScwVc
 +6awGQyNgytsqmYBQ8hSRLWo9YA9C8u9QHHdCaiFPKKtiMKwz690KsvkiWNx6WHpph+AdocbE2K
 jiuelMo23N04cTB5vHeri5j8t4UxQ3uVwuAdYbimQx47KCqyFJATUKddpDxYWY0B1IikSJgRykN
 8Ii0kSUpTN9669KF9CA==
X-Authority-Analysis: v=2.4 cv=Pa7yRyhd c=1 sm=1 tr=0 ts=695fb4b3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ewOVoc8TSmC0cCmMeNMfEg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8
 a=q5PiPEggbDlLcngMGysA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: R9VM58-NjTPNDinUkrzr-a2fFYGHnLS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080096
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

We just got a drop for OpenSBI v.1.8.1 that addresses a PMP related 
issue that is present on v.1.8.1.

Let's skip this update. I'll send an OpenSBI update to v1.8.1 instead. 
Thanks,


Daniel

On 1/6/2026 6:11 PM, Daniel Henrique Barboza wrote:
> Update OpenSBI and the pre-built opensbi32 and opensbi64 images to
> version 1.8.
> 
> I had to build and compile OpenSBI v1.8 to verify an error message that
> started to appear with this new version and existing RISC-V profile CPUs.
> Figured I might as well go ahead and update the roms while I was at it.
> 
> This new OpenSBI version features, among other things:
> 
> - IPI device ratings
> - SiFive CLINT v2 support
> - SiFive PL2 cache controller driver
> - SiFive Extensible Cache (EC) driver
> - SiFive TMC0 based HSM driver
> - SiFive SMC0 based system suspend driver
> - MPXY RPMI mailbox driver for voltage service group
> - MPXY RPMI mailbox driver for device power service group
> - MPXY RPMI mailbox driver for performance service group
> 
> Check out the full release log at [1] for more info.
> 
> [1] https://github.com/riscv-software-src/opensbi/releases/tag/v1.8
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
> 
> Alistair,
> 
> Images are located at:
> 
> https://gitlab.com/danielhb/qemu/-/tree/opensbi_v1.8
> 
> Thanks!
> 
> 
>   .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268752 -> 270384 bytes
>   .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 273048 -> 275928 bytes
>   roms/opensbi                                  |   2 +-
>   3 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
> index 02be3a72a8..eb63a39e46 100644
> Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
> diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
> index cce35c65c2..edd60ae528 100644
> Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
> diff --git a/roms/opensbi b/roms/opensbi
> index a32a910691..e7fa66c216 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
> +Subproject commit e7fa66c2160ec139de1853a00f669c09320a9256


