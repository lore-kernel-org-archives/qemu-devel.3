Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FDE606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xua5Qa3n;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D4VvJwf6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJhd-0005Or-1R; Thu, 29 Oct 2026 02:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJhP-0005O5-3q
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:33:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMJhL-0004iL-L2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 02:33:18 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T5HXA01793388
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Utxo98EYBTfs9NgDuSCtm9Zr43x25lI5UikFpaoBcvk=; b=Xua5Qa3nKcKwON4r
 1tgWUvNg5t6XuZ78hYP2AHf2a2y2yfCqvWCXVwYqpX//mjH2k4BTARoUn+LOIkaJ
 QHd/6/Vv4pK/ieN+8+20BdkisSg33WPMxuIY1iJFXfl/1Dy2Vxz87HI0WhfouT3p
 gI/Qrf4tdvzlZpVWAbH3GrU4RjCgIGjRnlyxoCRzhNvNx9s2S/o5ieUCUJCJxxUz
 4RvSjfX17FjfUM07NL5mkgALbZNciqIuB5y9wFWI8CDj+ZcmOaNdv6436Fn8qeN4
 bwlZOYuC9vKK06+V/LDeEkm5saDIAmZ2g2wdoOgwApNy8V6WBj7r4hao+EUsHWrL
 I94uTA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtnkntr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:33:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eb00825063so3007445ad.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793255592; x=1793860392; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Utxo98EYBTfs9NgDuSCtm9Zr43x25lI5UikFpaoBcvk=;
 b=D4VvJwf6bGsAhmoP5VIxMi7mXl4pEFsPl7MjnVBgxj06ZOL9mnJ0PxMPhi9EXLdB5p
 WCvsnb7iv5s+0Ty0Q/yotbQzuMz+2NOzdimYAhUir2PyXgDo6+zIOaK6CpHy6s70DVQq
 Q/4ZD8XKW0BTjA8rUWisIIuPyj4KzAxgg8ovVGj+ni31vYRTJ047b52gEUtvoF1v/6Rj
 9Lpj1TUFVtqeDM3b2IYJYZacZYyi0Bg4W4x965SIlfa4j8g4CXXCqI/bvxVioVk86q1n
 azyRq2IzHdNOUgje03kcv8ZVv96rGCdCs0KaCLyx5KeH29/JKF+OBpase0TRHB00QS6N
 q6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793255592; x=1793860392;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Utxo98EYBTfs9NgDuSCtm9Zr43x25lI5UikFpaoBcvk=;
 b=SV/+QXndRjtJ2S7EBZBrHtAdKkEF57Ehrr7yqGHailyddgvAlvqqaNHMUVnR8+BZFX
 Ln9vruJEhAoo//sOM6M7t2c9yuDW5MDLIC8wGkGkjL3IiYkNExDdKbusrXcpaOE1hqqb
 3wAnKpyxZ/YiAgD+QTg81f4d/WF8+BMC7DFigHBoGbL1GQdzzs3zqRGN9kg4Qx9pzia7
 PWZyqBb+HtZExSaOF6Y/jLw70QRPaSDGE1aU6Sp+E1fK3lERETM1LAJ6LZ6qvoVxMr0X
 D8dwFQxYJDIE3VKYbTJ3dsDUB/tQZ/h/5wz7yeDvLdspiAcFpG/238tMZOaMi1NTtn66
 533Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzhgfZHHz/haGaglcX0mdlC8fbzZgk0uDvDx9dTzQArSRgXWFRWwMy48eMx/mY/ClOJZBHvZyOmLzU@nongnu.org
X-Gm-Message-State: AFq9FYKAbIOfjO5LXNQbLOPM5k2m5QdJD/7+TMgiys9khau0g2HXX/cM
 3794vHEozutaapxBbGIRQCNG1KVXYtRpI9LDA424F9Qx52KwIu3C0BoCJmH65NJ1SOKZ4B3wPab
 7A7yuBF61F5zCLlWMIZVABrWoqaKtTY2Rm6AVuc5CczQFzlWQM0ZKxkauxA==
X-Gm-Gg: AYBFou2J1cOJB2scFdTQnGOGrekQkB6FKdOMGSE9lBoo9wPmbYgR5VNmNAhHeDrU3Zm
 qcnxOtNC5k6o9prwO/3LmkY+UxOYDaDP9CAahtnd/0fCnqvZUFelW7qwpl21If9PqXbbt7UxHJt
 BGmPzXiWR3gAY8r/6mpZdci6I6MK1zpDF4xnu67mLqxWzWyX71W8MzPVEnUOELukkx+XQrPoens
 XyTOaWbagmSNIT2DoKKMSH6KVqgLv1B/saTjLN1pJcGPlKQv9ptbzbno34mKTDzvswD6dopsPxp
 DPWfFQIoaEJ8h6ElBRkB1QtjE3Y3DEd2Uf1vdj3dC6+ks0Yg2m0AFAp4L9E5IJYtxhGADCU6u0f
 LDjgYTRVJMlBk5bftsmJm9z6eMv4Gi3xTrHlzacQ8JG1lEOHs99GDcsgrumJQDUcjRUUc/zYf0w
 XDUxeZXC3YoxC3/3X0T4hfuop9aEoiOA==
X-Received: by 2002:a17:903:120b:b0:2e9:5313:8f7b with SMTP id
 d9443c01a7336-2eb1abcf63fmr11280855ad.9.1793255590760; 
 Wed, 28 Oct 2026 23:33:10 -0700 (PDT)
X-Received: by 2002:a17:903:120b:b0:2e9:5313:8f7b with SMTP id
 d9443c01a7336-2eb1abcf63fmr11280745ad.9.1793255590307; 
 Wed, 28 Oct 2026 23:33:10 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a216sm28667505ad.16.2026.10.28.23.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 23:33:09 -0700 (PDT)
Message-ID: <7837d052-4f45-4f9b-b4c1-cd32b5ff8d05@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 23:33:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] target/mips: Re-introduce the R5900 CPU (system) +
 sort tcg tests
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gustavo Romero <gromero@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <28e90058-6b1d-40ad-9aed-590107f3f77f@oss.qualcomm.com>
 <a3555348-c24c-4df5-95a4-b4ab0a7490c1@oss.qualcomm.com>
 <4ef98888-b13d-4033-aa02-f48482fc0b7a@oss.qualcomm.com>
 <8628b8e5-7138-4f2c-bd32-ce8a8cb9acff@oss.qualcomm.com>
 <6d7bb396-7f1a-4732-81ca-adb16b8baeda@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <6d7bb396-7f1a-4732-81ca-adb16b8baeda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JAPlFMVsni5fsV2qP4muDyukoH5M8s3W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXxDGsmQHl91G4
 QqvU3Kw0dhXCkuIRYq0cu9Hgx+TbWTa7ike0kDKZuCsrlmXMoumXO77/Rl6ZZ2xo3DuAlLBA0Rx
 KdgcU07jQe0LOlx6PtwH8eHPwnR09TKiXQ36F4RSoGqpCfyyNyZ0lS+phh1/b7FvqoSGjd/Au0l
 GlWcscZJHYHmDfVGBx/5zqsdN73g9XbJ2KqS5BUmOZ5fNw681yyZNXWM+Pxpt7oeW1gIx65Jc9g
 jJXtjEbEYjEIR/6sSNMEUm6p0kfwdISgUGhHYFrF4VFeH4MSACqMzjTBZgT6FioasKIFPWohIB1
 zQWRRxw1EZZzoFGjqFCdLk7o+ujdZuDb/2DUN5lpKNaAOWgzRvzp6DTzNMkIpmPxaiRz3NJWRNo
 dubw4lIgPKuxLHlAbRcPA3/1xMNBW5uYRypq54sl5ZyujuE2gUPBAhxRkteU4MAyBhK1VFTi89m
 vq252w8qpv9Vi1gRpuA==
X-Authority-Analysis: v=2.4 cv=c/A+0h9l c=1 sm=1 tr=0 ts=6ae2e8a9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VnVxtJmZcLNGcI3DWpsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: JAPlFMVsni5fsV2qP4muDyukoH5M8s3W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAyNCBTYWx0ZWRfXyLxqZaVYFqJD
 5FZL8Otrgs4EqPQwLD0KyG6/E8fCbU8t1F/AeAiJN/ble5CgCYxI5q6x4/Q7ESvq9w/7MWSuSVE
 GJZ33ueQ0qvewW31vYOtoXEBZRB5n/g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 11:10 PM, Philippe Mathieu-Daudé wrote:
> On 29/10/26 06:51, Pierrick Bouvier wrote:
>> On 10/28/26 10:46 PM, Philippe Mathieu-Daudé wrote:
>>> On 29/10/26 06:39, Philippe Mathieu-DaudÃ© wrote:
>>>> On 29/10/26 06:33, Pierrick Bouvier wrote:
>>>>> On 10/28/26 12:25 PM, Philippe Mathieu-Daudé wrote:
>>>>>> Add R5900 system tests, code is covered, CPU can come back,
>>>>>> allowing to fix a bug on PCGT opcode.
>>>
>>>
>>>>> See some test failures, related to gdb:
>>>>> https://github.com/p-b-o/qemu-ci/actions/runs/40776744817/
>>>>> job/123131480244
>>>>
>>>> Ah hmm I had similar failures due to too old gdb, I might have
>>>> missed to check the version in that container image. IIRC
>>>> Gustavo had similar problem with ARM I'll see how he fixed
>>>> that (I suppose check gdb version and skip the tests).
>>>
>>> Found it, this is 'gdb_feat_version' :)
>>>
>> That's the right way to deal with it indeed.
>>
>> That said, the gdb used in this test (on GitHub) comes from debian
>> stable, which is fairly recent (16.3).
>>
>> Is a more recent version needed for complete mips support?
>> If yes, I can update to the latest gdb so we can get full coverage on
>> GitHub. Meanwhile, you can find which minimum version is needed.
> 
> Indeed, the problem is simpler, located in the
> tests/tcg/multiarch/gdbstub/registers.py.
> 
> Before there were no register descriptions for MIPS and the test was
> skipping (registers with no names). Now it runs for real. Apparently
> this is what commit 6ef164188d00 ("tests/tcg: finesse the registers
> check for "hidden" regs") aimed to resolve but was a bit too
> restrictive, this fixes it:
> 
> -- >8 --
> diff --git a/tests/tcg/multiarch/gdbstub/registers.py
> b/tests/tcg/multiarch/gdbstub/registers.py
> index b3d13cb077f1..8d886413eb28 100644
> --- a/tests/tcg/multiarch/gdbstub/registers.py
> +++ b/tests/tcg/multiarch/gdbstub/registers.py
> @@ -180,10 +180,13 @@ def complete_and_diff(reg_map):
> 
>        for e in reg_map.values():
> -        if "initial" in e and "hidden" not in e:
> +        if "initial" in e:
>                name = e["name"]
>                old_val = e["initial"]
> 
>                try:
> -                new_val = frame.read_register(name)
> +                if "hidden" in e:
> +                    new_val = frame.read_register(e["regnum"])
> +                else:
> +                    new_val = frame.read_register(name)
>                except ValueError:
>                    report(False, f"failed to read {name} at end of run")
> ---

Great. Let's add this patch in next version and ship this before the freeze!

Regards,
Pierrick

