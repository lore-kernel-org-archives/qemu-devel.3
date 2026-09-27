Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E2BC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqyG-0006vG-0L; Sun, 27 Sep 2026 11:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqyB-0006um-DY
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:39:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqy9-0002i8-Sr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:39:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1reXc1788180
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J+OdeoCxOs31GnuF8M/IvXlwILKsfQG8F46diaY283A=; b=Pk3hb1VtC8ak21pC
 vHnMm8aTshBW68q6odT0b8o6t6ccCPoQECYerMYPVimPPJWtNvUOOUB3wMHCDWJw
 IWISQJ2E1VId4Mcu3Mf680igz22t1zcMwwyb4xIdM6/o5N/Mw3tT7v0RIuHyoWfE
 1qqi/w38JZCIDOscLydAQkJY4cv+JIQzVm849l0p5W+sytJmxvChucjVVeWIjKUv
 PJaX40X/1ZWOMcFbheiTnl8S9iXkxryGmfxXeMy7gRQJcl0KkdbyMB+lcqQNTszu
 BNecVfOqVgUridKkC6+4YVEwRfre+w2g42LPSXdr47OCv9WA8V858n6rE4u6/g8i
 onkhWg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526ka4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:39:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93909014c85so482610685a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523552; x=1791128352; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J+OdeoCxOs31GnuF8M/IvXlwILKsfQG8F46diaY283A=;
 b=buXv7R5wsS8cjTWtaldI5y8GUNl6Lbc1720FUp5Z/JwQGLkDafWm3OoVSF3BYQoMU0
 1vwgMoUYDeVozuudjfwnysuRlU/PPRfwkCpdfBZloAPKy0fmVXONMUIjdgwQPw8E+gtO
 ynrKYii2QkDjGChGusFbtYfiIwVx3/Fo4QLc22gK7n0v65yIzbrJaO4xFQNK9M9TtxMg
 z1XYfgoKumWXPPCQVd/V7rZ70wdqu/x4lUjecHQucfT8wrDaWH9jaZLxcUmpOzvoRfIh
 gd2uQH96AX1kp5zxmAUM3t/OSnVItESCi5GcSNFB6kMWdq00N5nfS4bBmZxnJj7F8JR+
 Yuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523552; x=1791128352;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J+OdeoCxOs31GnuF8M/IvXlwILKsfQG8F46diaY283A=;
 b=zbdMPi9W4xuF+G65asdRLSu0HkLzmLWjjidFgn9MiN/F/oMiTns26p+di+3EFKyWZI
 EqBl7O39D5GdIZXldyjMw7b7Axjo7jW8+HuutrAKHvZJ2QzzJ/ceuRCA2xvW/ozhculv
 5x5Ic6gkI+iW3cylTMMqcEsfpno+tl0CPxIJ2yj0Kn66ADtpbEv5SCEqz+Ya+OG/PX4+
 s0JnRcbZtujNc0a6V8Uuuy6m87xCSVSleDRSD4nDPX5pOFjSS7VsVfBfymUbGUAcIFht
 VPoot8DQq8iMleFVxTaRG6KzdM5+Ud7WbBUxl9KeIjLAKzseajgJfe0lKKnsvr+cbunm
 NTZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg+DrY91WidKLWmyx/L7b9Uq9g7+9c1ryPZpOX/e8T7od/N7HbWLvwTsW/LGoR0SKgcZOO2zdBgwbk@nongnu.org
X-Gm-Message-State: AFuF++kH18TiUUEjtyys/dP7m9NLIGTGaGikogterZpX7HWBWnfay325
 tQRGXYaIMOQr1oBRGwUzgFuJv6qj9d1A3kQIfrEMNUtcZXqSBv2Dv5Spnc/Mi2R69sl5i/wmzvm
 FJVEgOQohUj0DwsMeA6eiJQI8tvdwb/33zQFUSLrRLoPRKVivkPj9EtNTYwKdFm1YFA==
X-Gm-Gg: AYBFou0BU3Lai/9FQOgHQEJGRoMfdy5fssMInMELjFlUQQYqDdhCh8gF79Ij9AQcPKW
 IbUuytTicIDKxbQBLnjruTk7yvQFjVnjaXym8Ck1m2OmB7UIanQAW0O99h1dc7eG3hw+GJFa2My
 uzvw4nxErMPf26xngAgO5ISt1OuPo9wR4dkU3WUG0HrMjDHsnMyLlFqzW5NuFM23S/uf7++QYf2
 ZrEKSmzm7eE5YQ/cTf0e/H64NURbwLeMvNJy9D1jLPkaPcKQYS1Ff6KX/+fkOkQn1VCyB5vtiOV
 q1e4CyoajZCUQxn/vMQNHisEe27CkMQiXLYO9lAkHzAz+wkFK48U1lpNij1D2Q6g6N3URCWnWcc
 Zl3YNiWMkVmow13/Rc0FRYD7aMMLSuDvGsQ==
X-Received: by 2002:a05:620a:700a:b0:93b:d79e:18f9 with SMTP id
 af79cd13be357-93c43d2cf62mr1660182485a.60.1790523551626; 
 Sun, 27 Sep 2026 08:39:11 -0700 (PDT)
X-Received: by 2002:a05:620a:700a:b0:93b:d79e:18f9 with SMTP id
 af79cd13be357-93c43d2cf62mr1660176485a.60.1790523551111; 
 Sun, 27 Sep 2026 08:39:11 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm19627596f8f.5.2026.09.27.08.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:39:10 -0700 (PDT)
Message-ID: <ed0fca58-afbe-4474-bd5e-f9a4ab01a3ef@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 029/101] tcg: Generic expansion of tcg_gen_ori_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab938a0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UglF7nYIC-e-TdrAGu5hddpspGcPdV_k
X-Proofpoint-ORIG-GUID: UglF7nYIC-e-TdrAGu5hddpspGcPdV_k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX7fk2bM9DVuMJ
 dUUoDbuSRZwNbtyZglOD3d7h8BdKXVJ29C4sltmCYjjP6MkI1XZz88PtfsCp7khqSjLT3KljPz3
 xjb77ub90oOY9T7yGFny2KL5RA2Ms8+GoPwgn96N51ZDfrqpM9Cedk7uvK9AOPFIkUh8QN5nMOK
 MsDRaGHUc9e+Ll5dV7JLrTqQiXinxNYfh7vNokdhE0Y8bm5G+Uzu46UgQgwwo1shIHqUE4WVTLj
 sUAdkutfAEwm0JNi+G8AoxQQ3SNOTBr9mszwfO12vU4o2ddqduS8a8W07drXiUQcR6h10G3skyw
 x40/hN1vpFlwglPk+Dq1/3Ij13EdXYFTWe2+E71rSGe46UrMYCB9n7jM452sa1B0lMBcbScx3lZ
 YApyq/c7glaVu4GxoyKsRUHlSvP6XGPAqZS2IvWsHTuNqg98+Hp290e7GhidfTAcjLCxihFfl1k
 EoC/6v3Ox1yTSdqtb6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfXxv/d7/1fThZY
 I83tLiqaGS0WOWotaDtdWhhUXRcu4OgSpIdSTlzL7FMnVC2nI/M28AJ3JPl0yzhmcFUmtESLCvN
 nyeA98fg+uGNbsbBVmlO4HqlwsZQ+1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 35 +++++++++++------------------------
>   3 files changed, 12 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

