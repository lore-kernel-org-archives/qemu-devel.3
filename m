Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF42606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jUTY5i9t;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BmzbPO/Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVqw-0007Ks-It; Mon, 09 Nov 2026 15:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVqv-0007KW-2r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVqt-00068v-IS
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:28 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9JfwvA1830390
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6reDuVj5y8a5z6eEUR4mOox+pRjZIbEHjck8wUX3gnY=; b=jUTY5i9tuxb7bHaB
 cjGuqPNskSg7PvKhFq600nTYucIm9KiZX9pWlxZ/crn/Bi3VbSAGLTfZcQXC7Mvm
 ILEZbAG6QVMbN+VhVqMl7tdgQv0sF8uhUxgZGKkBStik4kSa/YwMeXFSKBI/BXty
 F6PhlSnLYO+Bxzjt3kGxwfMV/kncOrX0CGiRcutq2oOFu1s+7jkyNbwhOAmcgB3M
 3HbVTG2GGa+Wt1S/Woc4CsnXFCV73TB6nKiOloCrKAmAC6zBWBiW1BdrNWZgzQGh
 3j0nyK32VHpuyOjzTr007C63fxRNZCyWgMjxgKEMqOZD6hPlyZvME1WfLI7DkCti
 /XlbgQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg044c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:20:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91eb16ea5c3so37079796d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255626; x=1794860426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6reDuVj5y8a5z6eEUR4mOox+pRjZIbEHjck8wUX3gnY=;
 b=BmzbPO/YORGaqoYX7BWLXwouGwr3oPQTxkcKGcve7HTfEi+LrnHvAjWJUvVKoHrk1P
 p7Aw8xkjWhpn5JIcALPh0XwtgR85kbBCDT0MOsQVZcCmXS1dZalouOfa5FFN3VFWXZYD
 uHcwluM0fTmld0NgchtQo9u18667L+k67kQZA0z9KjXUfAlVOgL2+gIqWbLLX2O/SyNt
 W64INAVImA3WwjzXx7P66f52o0+bwYke7O4qKPcHMUeC+0Y0OSiwrQo9eoR1TuXTv1Dd
 NGTlUqNdEKGNOsNhy32LEllR4sc/PWR+205EpNn27Fr5mt8HRJ8MMccSAkxTZ/HtqC3k
 IZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255626; x=1794860426;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6reDuVj5y8a5z6eEUR4mOox+pRjZIbEHjck8wUX3gnY=;
 b=kfT8fxLzsBDfxcL65UbvDNkrlHfau83YeVhCh2bfExXTa3alhcSi6PfaJqIHDmIzlx
 KWCTfgqnWJUBSz0PFWqzZrS72isBE0UH9qb0vvIft+O33sijcVZJZvVqBECvMmRkPdrk
 0jFvHW0onXHIR/ognO5qf6fuhqjb/2uusBRjZ0U6kkxeDNKsr9Ch724xFYFo2MjNVux4
 Rc3I8gqMdLqiLSYpfamYYrQTnG1qORVH1otJC25Skrvl79JjnnSPeRhT4FuzWhp5IFw5
 pcXR013WHbG37hmEIz7LUJFzgUXlqR4bhftEb68CP/p35MTWg+xJ87j2JFJHI50YUPMx
 hzFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE44VqOAlXiW/WVN2gbK/4K597IAs3J6D76uiFD6rD9wIrTY5LaEqtZUZ4uqB4/dp4tgZUSwGOe4Qj4@nongnu.org
X-Gm-Message-State: APuU4Z+2HLJVpIIp6NO3UrT5s36Jv6cap0w2z3ospr1Xvgd6mXkxNslV
 sYT7wCiJhcWdG3W0KPSmQHofGMdG/EBTfb2DDffYiYjZkt691EI7031LJHr4Pmqi6Jv1Gh08NR6
 qRr73kC7LmYf4sY53l/5ImBZMnfv1zRgUHyM2mLdR7fRAxIKPb9dxK3GG+g==
X-Gm-Gg: AYBFou2IbhRDj8qhLg1gD0is1QcdCOo/wPbKHszk2Iuiesu77Mf6xCHYHkx0/a6Umdd
 Lg2TA6wnf+ojIhOblyhIURly28/CNXOO7iyxYZtdyPv2f8qYyGGi1HVUhbVm7+dozanEGj7WsXo
 ORwqTiOaYZELHl1UfhZq7CrtGRii0lDVjVS1b6VbNgqBIlNQHbGq4pcOvfmyRif4KMJl9KEDvF1
 920F6WJMYaYzmyuQZmDoJwgx0Sbo5xY9hSnSNwJ/VBaOgewqEN+qe1HKg0A527CIwGfIi/vMAKq
 dhjM6TvSZPhyBVblr5Q/WAH+X7I+qv0EOXf4ozwdNcirsP+rt0qnHcxLADK81Y0uh60dBNyNoSX
 qNUh9dQ5ejG8qIoX0NuCfPIG7p4/E7bQ5MEjlHI/kvwWT0jveAxoPrAy8UtVrVVvI2zFOVfzXvt
 vw0GKSJ1NU
X-Received: by 2002:a05:6214:8403:b0:91c:7c1c:da3d with SMTP id
 6a1803df08f44-91eef8662bcmr8858836d6.43.1794255625683; 
 Mon, 09 Nov 2026 12:20:25 -0800 (PST)
X-Received: by 2002:a05:6214:8403:b0:91c:7c1c:da3d with SMTP id
 6a1803df08f44-91eef8662bcmr8858526d6.43.1794255624986; 
 Mon, 09 Nov 2026 12:20:24 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef052383asm4045306d6.35.2026.11.09.12.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:20:24 -0800 (PST)
Message-ID: <29e5d5da-efc6-4829-aece-d9f516179b0e@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:20:21 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/38] disas/riscv: Support Zvfqwdota8f extension
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
 <20261104194155.679241-19-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-19-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX7UabPCBDI3AC
 j7ICuzasTMUEqN0/rA9412VeACiBkpngwfWihULGoCExbnI1BM18pe2wmmWhitJV3D/2FhWcsmB
 iJMHmLMkB4VzskqsgetrtCZIJgFjVk+rTmQglfjEiAEOofriFigYXxN0a776ip7vmLLDS0OOOta
 QIiLgGypM4FjnEzDDCqvit5SddxLSLviwnkU+bY/VO7zrbMJlo4UwKTBxEyDi9DTtpaDXFB+tOT
 OZ1Nm6q+M+v94ravNwOocpmFAN6UOCHRa/cvaCekqXZiPQNs6aIhbTOGK0zjURL/HB7Ysuny80c
 1dTDkOvMGh7Gvohj9auWMfkC79k4e0Q+Xc88LqGq2ljlk4WMjMG0iTwcQ4Dr/rkpiodBikooYiE
 i52Cp6dq+4/bFqK8+KuKlwTVQFx3O39iFE/ndGyG5iJp4Zfn5VXY5PKYpwXhOJbl42ksLhj6WYE
 tzE7mX3RwSMsk5G+1aQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfXwd7wATI5m3Ke
 MxI4xZld6nntMWEAhBGQ+opXyJONlId//UgunzfqnWQ+j+AJx0UrRL9/lxmSW9ZTs3G/6FXGxK/
 Eza0uLH6Qmvs+SydsfOVGRd9xQ4hURk=
X-Proofpoint-GUID: TV_2jqQi-LARQ06OeHm9RA0Omvxy-iyE
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af22b0a cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=JQTPU3wg1eTVZYZx9qIA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: TV_2jqQi-LARQ06OeHm9RA0Omvxy-iyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Adds support to disassemble Zvfqwdota8f instructions.
> - vfqwdota.vv
> - vfqwdota.alt.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-op.c.inc | 2 ++
>   disas/riscv.c        | 9 ++++++---
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index aeb9423f130..5ba29f52976 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -583,6 +583,8 @@ OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>   OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
>   OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
>   OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfqwdota_alt_vv, "vfqwdota.alt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfqwdota_vv, "vfqwdota.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
>   OP(vfrec7_v, "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2)
>   OP(vfredmax_vs, "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 62feb4c653e..0f609cc06b4 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2640,9 +2640,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>                   case 39: return &op_vqwdotas_vv;
>                   }
>               }
> -            if (((inst >> 12) & 0b111) == 1 &&
> -                ((inst >> 26) & 0b111111) == 36) {
> -                return &op_vfwdota_vv;
> +            if (((inst >> 12) & 0b111) == 1) {
> +                switch ((inst >> 26) & 0b111111) {
> +                case 36: return &op_vfwdota_vv;
> +                case 38: return &op_vfqwdota_vv;
> +                case 39: return &op_vfqwdota_alt_vv;
> +                }
>               }
>               if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
>                   switch ((inst >> 26) & 0b111111) {


