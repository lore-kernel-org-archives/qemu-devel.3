Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1F606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c7UAdPtw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmhFntAA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWCP-00042m-Ih; Mon, 09 Nov 2026 15:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBt-0003UH-75
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:42:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBq-0000J4-Gg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:42:08 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHGOV899570
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ic06gkENK7FYwrAGOzINuDl/piIHOOKh8+hDLiik7g0=; b=c7UAdPtwL3wWsUEU
 EiX0aASC4keceMRQKvlXWddgPIwfe0nH6SuRycfEqbaXNo31lHXhLrn0qBNuhbXB
 qDanCcY1bg0IGbEqV3lONfX0PxZefwcAHFb7oFHdnIudJcDkrH5Fxzs8eJfJ5/Ad
 V5Njaol5pGRuANYFWwW/B4LDWkrFo9yjvUGyXIFztrRof2gdwCFXc7MNr35uFtGj
 61Vp6vrjmojsOslTpyweP9NWHkjUDbKCtq6JWJ2Pm549rBFe9PAkA8FI4YjgQvn+
 klbD32lIsEFkgPf15voM4D+6ZyOHspkFyOHybHMVI/uftORnxS7Ap+9erbcaNq5X
 Cl68rg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kfn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:42:05 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91e83f5b4b6so20499926d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256925; x=1794861725; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ic06gkENK7FYwrAGOzINuDl/piIHOOKh8+hDLiik7g0=;
 b=TmhFntAAJe9OONU+4TFGWyNvObY2XQ/tB7bavOtyRUY82N++4FVYNZRQoiHb2sCnt6
 S9PxMalJ8r8FC3xotb/iLrfzGwrxit6PO8pXssvFSDYLtQqj32Y5E+otklm04jevvmxc
 IuaOIcVJR47S5MsK0Qin2o3OGGAlFn4urWzGelDXl72IVcvSjIKM6dsfbGu0eVstoLEk
 6U5fegAryKvTYMFvzFXwegOQDMeZ1FmN+SuOraXnLYqGpUETs8XSDLnCgFO3SfaJuxgB
 8HMGk85cX8//MYq6PcS2TKn61f9XS0p9V4K1NfFClHm/vZ22qB0X1GUUNJGng8SOUlS1
 YWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256925; x=1794861725;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ic06gkENK7FYwrAGOzINuDl/piIHOOKh8+hDLiik7g0=;
 b=Q9INlBMN/wnNLtMKU5+vZ31TPKACLKoGP88ByT0Xbc3295ArHVLUupOf4JAoABrSkO
 VLOle5yZZ95nhq3DqsjFlpaZRqSvzhpmU+8k63UwjAlUFQvD2tEnMk4l93QX7Fqm1ff7
 EuTnfDitUtXR48SfBepdMBudLN3R6rbiQYGz9sASueSw8z7rbTzzI+PfxxERyaZAbXd6
 lTZsG3AnEXmFeDEaRwLLvJ3StzjodytfKazotdTxoMNFahh5E8bDmj5/LP1Vs63p/Z+O
 KZ63KYG+s7GwUeJ7WiuOAA2GXSQe5nZ67yryWoPbpoEKfqh9R8VZwjlhT4dOyxdl4OAH
 rgsA==
X-Forwarded-Encrypted: i=1;
 AL+hErHmisxfOFHNx+aR1KiYZNyepaEdSBoUU3NVGGlc+Va/Q3RPzu7pMiaMpWQjJNYTlYYUPh1BK97qPgls@nongnu.org
X-Gm-Message-State: APuU4Z+2wKhClkAqJ+X6MdIcOv9dseUH0hZLpuuAIYEALzZcntWhgCvY
 IQoIUJTBWRYaUy/ollbdhXSSSKkJA0hzBEUBqlsOPhUmQblcrNYCU7B1qHLYhrd3gSZ+6pmyAbk
 GAdRmj7CRJTbom/i9Vo64+OtaG+OgJGW3SANd0vICnlJ6d7x8OJeedMtfjg==
X-Gm-Gg: AYBFou06M/WRtsCt6sTADr4/OQSwlNBZUuE6jGmkOWxQrLSxzQX2aoVpnZVa6B8h+8N
 duBjSKckPkGG+Ra2gfG/2uAqyXtec8mWRzLEoN7RiIqXYv3sLXEZPlcI5bjViTrxRua5TtHAu9q
 IPgCdfD/Ewy+BYgk3cy+7yoc6/k6zpy3wS1YZLRvLcz9fnkKf0VbsuMe9y45ttSTL9IF5e9OiwQ
 hyxhoZwDuVx+kJHfrBzneDbJz4eztfKOYitgi+1IQZqYHivlgQpMQ6sgxG+tR0t1o2k8Hpk2t23
 xLLZmjqP4x3KhrHB/WbBoPJ1lR9VRhBupn/2lkgWfvvqxFMMExAE7aA8f5TOzlUjRuKD3JkfIfQ
 Ld3PiA7PPHuJDetbWhXuVMbuMEAR1PoHDADb38FsGi2MdLhWTkW0alEABtFeGRtL63EOF1Rk8gz
 nW8arcygFE
X-Received: by 2002:ad4:5aeb:0:b0:91e:7e89:c8fa with SMTP id
 6a1803df08f44-91eef8cf4e5mr15086706d6.12.1794256924490; 
 Mon, 09 Nov 2026 12:42:04 -0800 (PST)
X-Received: by 2002:ad4:5aeb:0:b0:91e:7e89:c8fa with SMTP id
 6a1803df08f44-91eef8cf4e5mr15086256d6.12.1794256923859; 
 Mon, 09 Nov 2026 12:42:03 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04ace42sm4697696d6.13.2026.11.09.12.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:42:03 -0800 (PST)
Message-ID: <f1c04ca4-8281-4624-8b93-b0b8943261a7@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:42:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 33/38] disas/riscv: Support Zvfqwbdota8f extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-34-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-34-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af2301d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=vq4rhS0DSI_N1f-mmVAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXwYRP3Od3KrwO
 zr5/KsDPa02kX6aPnytku/xYrZ8yERhE7sNyOnoJtwGB0eEC2OwNBmbLZ4xyPgSFLju/t9ro5+5
 s2PBiHd3aKJIrQl0jxiVFEC3C4Ns4vo0jQzpioMH2ejfc6YCQO3e63ersdau5DQc5uXFngg2tOA
 4b5YFAy5tx0rIKLreK0NCSASnkTZRTRRm+dlt8hVRSN97zYzECIjZAR/7vxnGgmrfnHEAbdMSGZ
 cA1418+68Y84SMu5XYPlLRsZSLL31vs8UZTSo4EC7TU+t8lcjhPEHtOpcDu+7hxDhWBChockBUN
 oJueG9GeEzPcOuUfxfeNRSks+MiwNIGR//oaK8hBRXziKLeQWlzCQwg4dCzkqFHv0G+kxSJVBQA
 8GPL2fnKqrijCYOBJRu1fMBbv6EhE50Dc7CsZnQP+79DjzJH/yAXDcCILhRX1vroD51r9KNV+kp
 MBKrI6NSN6rZYtgD8lg==
X-Proofpoint-GUID: aoX_tPs0tXEZnJ6MupjoDk-up784_k_m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX5K6rqqIONMRE
 mPnCrX/H6RihzcOOB4FNsw6YxdfUYR3SUOk8kxJifYi8dlMWJ+1D9gujRuUvig9VPjQZRW261MP
 vhd/bTmRcjpoPuUKKb0Wxc+qDufh6Hg=
X-Proofpoint-ORIG-GUID: aoX_tPs0tXEZnJ6MupjoDk-up784_k_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Adds support to disassemble Zvfqwbdota8f instructions.
> - vfqwbdota.vv
> - vfqwbdota.alt.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-op.c.inc | 3 +++
>   disas/riscv.c        | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index b24ffb45d8e..58f6ddac35a 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -583,6 +583,9 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>   OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
>   OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>   OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfqwbdota_alt_vv, "vfqwbdota.alt.vv", rv_codec_v_r_ci,
> +   rv_fmt_vd_vs2_vs1_ci_vm)
> +OP(vfqwbdota_vv, "vfqwbdota.vv", rv_codec_v_r_ci, rv_fmt_vd_vs2_vs1_ci_vm)
>   OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index af41c2204f5..a124cbb4bbe 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2648,6 +2648,8 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 38: return &op_vfqwdota_vv;
>                   case 39: return &op_vfqwdota_alt_vv;
>                   case 44: return &op_vfwbdota_vv;
> +                case 46: return &op_vfqwbdota_vv;
> +                case 47: return &op_vfqwbdota_alt_vv;
>                   }
>               }
>               if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {


