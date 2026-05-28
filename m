Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F0DCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgVJ-0001Aj-Qd; Thu, 28 May 2026 15:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgVI-0001AK-89
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:34:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgVG-00048z-Jb
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:34:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SIOMZ11237069
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/I4u5xzTdL/Xg8iJLQXX5JeYjnoJH3C01m6gStYZ5c=; b=gvE83P4ZpB1LI+z0
 bTw+gHsU7c0XPxnN4yIRKpP1tg5hQtq2CzwBixRBc6Ky9KAbIT3nHdHl2orvNxB7
 ObBXmgZNloiGvV+IsvVbGEHKXo5D2JPIhPfIZ9zWyxG/d3NlMdymwRsGfer/5pI1
 LN1FfpPJBi4PaV8s469O1hFEYiYJJX9rxHOmYq7byzr0QRgdHKTVbJbw4JtRgirI
 gOBeTM83UAKSLXIflATkFvNJy9QQIwlo57ebNyHe82dKpsBNRQBG2/m3rNq+YASi
 AtmbdlYKI7jXR9t6tp9nlrkxFqsPK50vO+51D6iRHeIc4QXl4TmxN/ZItnzgEQBz
 b5d5Ng==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety4r9f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:34:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d8e9563eso2758733eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779996888; x=1780601688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/I4u5xzTdL/Xg8iJLQXX5JeYjnoJH3C01m6gStYZ5c=;
 b=GNT5SBaA7c+zcd94xWGJRZUKgeHT+x20JZOMmjbs/fdp4SRXK4srSWyNQx0ROe4Aag
 W92VrF9CUhMe4rSGHMDDv39D4RrDbzcNPiMMErOnQPq3X5xtgSDKa0St55GRaOXRx37b
 AEygSygu9DKk0+5JyEx0k53bSFZhprd1nen9kdc1GgoJzpIGh7V63WTz7TuoX/ATNJnE
 7lfVYhaYT9+h9BAj4vaUVpABAkEokSdo9xPsYHPlIMLka3j9fEX8ZnIJ2eIxgwUqyQc0
 IAEF/VYdFOiKesBt+6/7QQYLa77h+fPa4sfCWhJyROtbUbaxrfmh2bdbxaDC7zjQAVii
 UdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779996888; x=1780601688;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/I4u5xzTdL/Xg8iJLQXX5JeYjnoJH3C01m6gStYZ5c=;
 b=PCn3tkJytn47Oz7ssLF4xVIKlALaZRkgGIduVq6phHlqs3Jf4GC/F1AbeVPjT0Ki/T
 7f9I6fXDfzI1AWzLBIh4dTyCeTGAp8Aqdi+mQ4bgvCNuMx/EGvfwQQNtEoq4s4zxLJtD
 xpV4c7aCZFIIcAsejl5dherixOB+6Q9914NDGXmJOHjkTsF+/N9d7rB69UiF8OQCtacV
 yRZTRtrJ+mdjHTlYqcPdB+q69Z0Y/mB0koBmX8z1klSBUW+byGjij47A5nDO32k6pvHI
 8Gc/nd0er1a+wGFMiUN2Tdara6abc7vGqWd1Yhu6rrWsmvLpHLSE3qorGEkvlR3J51xh
 WYoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DoV2rDJtcIanvMUOerseWoijY7D6E/qDwH8FyMTzEuof8V2GRU3qv4m0deeJGz788Couz4gTi6btl@nongnu.org
X-Gm-Message-State: AOJu0Yw8QtK4d92XlRGM/7R3RS+HEkM+2X0qC3GL8yquWgf7cy+wTSc1
 Oq89D/3ZUtO1Rl07TCZc1r1vSoBvuLYuT6irh0OS6zZKUvcCPNOLzlpiuRWZ7tCu6lvBeWeoiRx
 HAeGl/V6E1z8l+QTaHArA+RUBQS14XW9dWq2PIQztEKZUSlrWkzEafHT9kQ==
X-Gm-Gg: Acq92OGWASGGknwQuhiO9KVzmPh2H/iC4UH7kWahFI/JCLJIPQyjld1M4S0hVXj/93q
 rKH5nZBFJHXMmlmk5N/j56nPu+9G8OH/CWG7nZU7OT1flvOvTzM9fgAHOifQZlUjEbaCxCqJdos
 hJNKkeCS5UG+p8/Z6BZqo60IbkhumiO+jpAL0h31rvgMnwimH6pwVm9udGY02Wz0s0Bg3I7FL6O
 V8WwYwAfXFznT4oqYXVykweXhXkBRpivrxqA0TJ67RZCja1xl9GEUupnylklFNgrPG7IO9go6Fu
 C0gYIYggMA4URwUW+wnHs7EQzStp2i3EVFhvY3wUbff2HgTZjiZXIogGZjXTR8yOjEBUZasE4JH
 Eu6Rekt9aZBri6l2OLDTgCku4sDxGF1nF6+RuPcsM+Hf2irambbBTPjEMCdl0JcPsN3STETYwXb
 SzW6dQ3FQLkjqJYWUqnnMoprY2
X-Received: by 2002:a05:7300:fd8a:b0:304:d32e:65e5 with SMTP id
 5a478bee46e88-304e8f652c3mr181100eec.8.1779996888423; 
 Thu, 28 May 2026 12:34:48 -0700 (PDT)
X-Received: by 2002:a05:7300:fd8a:b0:304:d32e:65e5 with SMTP id
 5a478bee46e88-304e8f652c3mr181074eec.8.1779996887894; 
 Thu, 28 May 2026 12:34:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304e94e54besm147866eec.4.2026.05.28.12.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:34:47 -0700 (PDT)
Message-ID: <aebe9798-232e-4aa9-829b-2b850cdbc818@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 12/12] tests/functional: Add RISC-V endianness test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Thomas Huth <thuth@redhat.com>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 08nL6JQCK_z98Je1FikSYy-QsVolPhrS
X-Proofpoint-GUID: 08nL6JQCK_z98Je1FikSYy-QsVolPhrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NyBTYWx0ZWRfX3hKA+ndxIsee
 LBxh9OuijBZ6P7O/PLkBKq3xSYDv8wDoRS9x3VBdT+DyZmoTpujHnEFtUSXmHxBeD87MdPAmODl
 b7SBXIuaT13IiqOGagSEZPDcm0mIfxDhFv/AyjOdEUTTOJ4PcFw3Yja0DCqApvL6UhOhhKUOck3
 3qVK9aZ7sHgJYcCLbN0gvjcWYTdPlG12gELFiNdMKvyKmkRm9/V/jc/tSDqFAKFQNj8opjRSpoF
 zsBDEdGzf36cvdh4U6pAQTDnWchN8Ynw0J/tSFZ5wb4TYqbXzqxNp+WSQtln580cIfwx/V24Zhs
 GssJuJuLClh0OzTpH7Umts6BDmAvMDTx+U9CXa/CvUUpoKGV1Nyodwaz+3T/Rq2JGfoQVniIOLX
 FvgAd+2eTXNQV7m/6+O3+9htiq0JwfaRv+V0IZQqJD9ZzNkhLrp7XJ2Nu0BMK245u1GtIFRRjHv
 w+RQvBfQwGAZnhAE1Gg==
X-Authority-Analysis: v=2.4 cv=S+TpBosP c=1 sm=1 tr=0 ts=6a1898d9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=ALku5c8DAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=WaUXwePNmJxjUM3X3IgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=Skunnq644UPbuD6fT1yj:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280197
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
> 
> Add functional test for the RISC-V 'big-endian' CPU property.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/functional/riscv64/meson.build        |  1 +
>  tests/functional/riscv64/test_endianness.py | 57 +++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 tests/functional/riscv64/test_endianness.py
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

