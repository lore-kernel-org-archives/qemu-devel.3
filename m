Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD1606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UMcgq835;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jqWJfXtc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsIx-0008KA-3A; Fri, 30 Oct 2026 15:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMsIr-0008JT-J7
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:30:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMsIp-0007Ps-Qk
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:30:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIijsm913436
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 19:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oc3vafEuIgTYR52IiQNwdGVnWq5Te91EPEd+9/gTHV4=; b=UMcgq835FmEBJJZW
 1e3G+kGgLyL6N9am4iNghVbkcH5asZMTVONe0gktwZ2zMPeQGscGA67QW7pxgtYm
 JcCFyowLEYxiWizhhSJSqD+M0DwHtv9G93gqKA9rR9dx0/q8Yj4kmRU73G5mxuRh
 OTQaocmP2/dZSo3I6atBwAqADgUg4Tbh/jflFauQy6Q9zuQp70nMFSr0NCVGPcZt
 A7umV32criFgncApZbFZho1OWkYJWmBnHfLlwtb6Pen1wQ0jhbyp3KGcTtFsPmjy
 m+D9GmzZf7+CircjARjqdhefDZ0X7BivGY/okXrql4Cb/T8nHKpYjp+hw2AKzP9C
 25FTrg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0snr4vf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 19:30:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso1655728c88.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793388613; x=1793993413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oc3vafEuIgTYR52IiQNwdGVnWq5Te91EPEd+9/gTHV4=;
 b=jqWJfXtclKGc2mUpFhxqP6MVzKPFTp9XW5QU4366RtLcpbmHSw6g+E3szWJ0JUSLBh
 mqQImAqcoYROcBDAAADR2GsdA1FOhQsaCHZG0tCIIpbhKMViKG6z541G8LOKuOVK/HdY
 lAeq/fxnz+H/SDQP7T1GWUQp2MBzFAYEq9ykZG1qPFfC2Lr5TeX5j8wwBeEbi+8+GOVm
 fM/3dLCsIiBNnJ6NX4bi49FQ99AhCBr+yWVoyMT9FSvHXFeJ86t6PnCZPRucKlwQF8dt
 CFfF1Pd6da984gR5yofn0qLeft9GNWjWDTukjI/Pev0H8lHUKFCEGv5uv9/TbcV5WJyF
 Q9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793388613; x=1793993413;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oc3vafEuIgTYR52IiQNwdGVnWq5Te91EPEd+9/gTHV4=;
 b=uVfJOccLLCcGOeVGfBOf8gV+QMki1rkqRPK24mijqL9WkC3F1MCNsMM0+xqU2fbeRW
 7c4uUyBIb424wwUeQSMznDtpxNKOd99OUCRp3nI0H6A29i+JO6K6V9zboa0KJp0oWkZJ
 fWTdchmVpQTKzHD65Xtpc+rNpvG97f3jONutkkafUVD5TY4D0odAtIL5KvXaCwkr47Dg
 KqklB+jGORen4aP/Akb5sGhZkXKYhKh/AnnkNyt6Ox4sJwJzXUqKIglHOW7y9bGSlFkU
 BFqHsOPcIPlq/SVk7bdbu1J5RSZpDuKmtp0FrhpEhCTfcJ/lCm89wq+FAUJh4l+Ggnap
 EKGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYDjs0BFENvp9xI1heLkjaCJarQkwn6bdmlfdkwlND5vuuCsc/gKuWbQmTXtvSreieCSKVg9C7AgHu@nongnu.org
X-Gm-Message-State: AFq9FYJRtV9VbDZGkks5wtXymifIP74+eHgEf23yWb4SAHq643QgGto1
 Tkw8DVnUGsq9CLGmb2zvzZpimBH/AWtxSEroUVeOqEs1/kd39QOGLOW3ZVmtHYscTUxjy6gTr6n
 izR/yK/0CW13Qxi7C84pGrY7ru9qkRXS7DIGjKLFvXgysxihhm9U9fxHswQ==
X-Gm-Gg: AYBFou35T93mL5eobJr1u/UEY+B7D8AF6QZ32DFixBIlF9CMvVe13ixWGyd/j/38jqo
 aF+CtJQ2nE80e9vFk3x3OnpEeE/j6s4GxKQrqCWQl+AvO/clGvjphy8mkulYss7yC+WIJsjuHkx
 HVtJu0gOklju08TBmDfEL1ef7zQQkdBJgD0lXUTgaThYNrikQwr4NxYMH4ztYhPeKZ5YiuMSVsG
 5u5Srj0T3EuSAkVxPrGqJ/YPhitu4xiD1OcXJjzRWTbXPpWHWRJgVWjI/f4gVrtTDlyptxdKYBS
 8FZnpiLE2XVyH+MTCZ3yozkx4xaDHctTHyvUBKt0UwHoDlUXLNXgGMum8qljaO20uJ1upsykOvH
 XxLrH0D0BbCDPKwyYjt4XEEd2YnSiKSXs2qKZkyHaRH7Z/bj3MmWL/7gJh9RLU+2cItpPQZBRL3
 2T4Sho/VJjzstqFkQQztMBQsOcUL8Attdmp+UHy2CEGtQ=
X-Received: by 2002:a05:7022:2097:b0:1a0:b650:5c93 with SMTP id
 a92af1059eb24-1ac5e8e1e16mr4181006c88.41.1793388612608; 
 Fri, 30 Oct 2026 12:30:12 -0700 (PDT)
X-Received: by 2002:a05:7022:2097:b0:1a0:b650:5c93 with SMTP id
 a92af1059eb24-1ac5e8e1e16mr4180953c88.41.1793388611793; 
 Fri, 30 Oct 2026 12:30:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac192c27cdsm14705021c88.10.2026.10.30.12.30.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 12:30:11 -0700 (PDT)
Message-ID: <d891786b-c502-4c7a-8930-ba654d002a2d@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:30:10 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] tests/tcg: Add MIPS32 Release 6 tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3NyBTYWx0ZWRfX+LfEX+2+Lz2U
 JamE6waNYj+nrPNgFHroqTGBP1iwJXpFsIZNsN3qNXlp0t2rPUu+qHPrTx8nRWLTk83B4Y68Ldt
 JT6hTkCB474UXbuTDXSOJbx2JvefJGI=
X-Authority-Analysis: v=2.4 cv=dNozC+Zb c=1 sm=1 tr=0 ts=6ae4f045 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=591RKU-4F7BtIbgKApYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: CYiQY4s01aJHnaTe4x4NI_AqrKp1d3rV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3NyBTYWx0ZWRfXz0LbEztSxE6p
 5lfDAGoa/teavWdwVq2hfB1PHZp46lWB00aEOKZYB07R2r7aQBKzgKKjj5+lFY2QdOYUP8hUPnk
 XtJHfkXAeePwgL5M18VMJQHJNKhwbGCAoPW/DFDX2Fc66I9HhGureqsb3lux/ph/03QC1mMiGg1
 ueHVsWZLjYH6VKAGdLlfEqlpxjrtvygiNsd+2byHHVmyzvnWVf/GQHP5slMHYNKKPK/tbPZVKs2
 doBYaVzJVXt4Q+yr9anMZBVkjT/I9QBcy92YEXv1pmG7V2LGaSNwiYwQ8ivBXFZGKpe3WbsonbG
 4WkVO6Udfh/8lwUJ/p82jUL+9eAdxbfk75zY4loVLPU27HNobPnm8L5ndcsX1TWqZY8e250YP51
 qL6aabFZwYBv1tayRnz8pQUG8kcsMHGnVRkQdszYrt1WomTW7sGqdAKv9Epi00HVW3MlngUsCFa
 unIYEsEfldH6GNmhr/A==
X-Proofpoint-GUID: CYiQY4s01aJHnaTe4x4NI_AqrKp1d3rV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 10:25 AM, Philippe Mathieu-Daudé wrote:
> v2:
> - Use Debian toolchain instead of Bootlin (pbo)
> - Convert to TAP
> 
> v1:
> - Include Bootlin mips32r6el toolchain in debian-all-test container
> - Wire it to meson
> - Cover all the 32-bit opcodes tested in MIPS64 Rel6 (using TAP)
> 
> Based-on: <20261030175357.99684-1-philmd@oss.qualcomm.com>
> 
> Philippe Mathieu-Daudé (12):
>   tests/docker: Add the mips32r6el toolchain on Debian cross container
>   meson: Add the tcg_tests_cross_cc/cflags options for mips32r6el
>   tests/tcg/mipsel: Add MIPS32R6 logic tests
>   tests/tcg/mipsel: Add MIPS32R6 shift tests
>   tests/tcg/mipsel: Add MIPS32R6 bit operation tests
>   tests/tcg/mipsel: Add MIPS32R6 multiply tests
>   tests/tcg/mipsel: Add MIPS32R6 PC-relative tests
>   tests/tcg/mipsel: Test MIPS32R6 SELEQZ and SELNEZ
>   tests/tcg/mipsel: Test MIPS32R6 DIV, MOD, DIVU and MODU
>   tests/tcg/mipsel: Test MIPS32R6 LSA
>   tests/tcg/mipsel: Test MIPS32R6 BALC
>   tests/tcg/mipsel: Test MIPS32R6 JIALC and JIC
> 
>  tests/tcg/mips/include/wrappers_mips32r6.h    |  91 +++++++++++++
>  tests/tcg/mipsel/test_mips32r6_bitops.c       |  79 +++++++++++
>  tests/tcg/mipsel/test_mips32r6_branch.c       | 124 ++++++++++++++++++
>  tests/tcg/mipsel/test_mips32r6_logic.c        |  65 +++++++++
>  tests/tcg/mipsel/test_mips32r6_multiply.c     | 104 +++++++++++++++
>  tests/tcg/mipsel/test_mips32r6_pcrel.c        |  88 +++++++++++++
>  tests/tcg/mipsel/test_mips32r6_shift.c        |  81 ++++++++++++
>  .../dockerfiles/debian-all-test-cross.docker  |   3 +
>  meson_options.txt                             |   4 +
>  scripts/meson-buildoptions.sh                 |   2 +
>  tests/tcg/mipsel/meson.build                  |  34 +++++
>  11 files changed, 675 insertions(+)
>  create mode 100644 tests/tcg/mips/include/wrappers_mips32r6.h
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_bitops.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_branch.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_logic.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_multiply.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_pcrel.c
>  create mode 100644 tests/tcg/mipsel/test_mips32r6_shift.c
> 

For series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Just remove the binutils dep in dockerfile, as I think it's not
mandatory to compile the tests.

Regards,
Pierrick

