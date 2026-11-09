Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06710606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IuiBpcNw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d3jdYjmv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW9S-0008NS-Ea; Mon, 09 Nov 2026 15:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW9L-0008Gc-6x
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:39:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQW9J-0008Ng-CA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:39:30 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHPsW370468
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T0JMvw1YCN1tlF4hgAFYOVN5tY2jGKjaxFrBMJk6AG8=; b=IuiBpcNwpswWNHrc
 I9V4zpF3EFibbfv5iwKKJ6lf61/iJAHHBIbdZn6x0xJnuXLz/Q/zT2HdSSEIKcdY
 DGov+/n2LpcjRkwlaeDoGt/HEp6tHqxeZxntq1CRi1SOIBQJrJbvCwJqOlIk96NV
 jf2maUpSAcC5RRU9VY2wdHxUp4p/jD2vHQ7eD7L7EaASRgnncqxxA+zP7QkaIgAL
 t6AiSFLRz2kLUlah09XtN6ojNjbFKQsA8qw3tAJyrh23/HMoOWAKsO1ho0SksusT
 KBZ7gY6YrYQjVu32cSdjZCM4Wwq5MrJzjuDQyzpf/v32h0c1r4WsZVKVsqKLo6gP
 BWq9XA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua58apt9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:39:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5364605e74bso36233151cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256765; x=1794861565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T0JMvw1YCN1tlF4hgAFYOVN5tY2jGKjaxFrBMJk6AG8=;
 b=d3jdYjmvZylGH7FaiIaHHu9bu9ow1OzepVNxC+vtUq3pDfNYjifYBFi2Dv+WHmZzUm
 kNvibASIzUrouo+V228VA56zPFlfE17cj7VYyzLsdqyRZIQU76WG41mwQhmYppcdoOm2
 d2wQZkvsZ70agimLtI3udfUFvlRaZm5d03pIokNsLp1b4Lm5RL+3SAdfQ6w5ewJd18RQ
 WkmXRE/N0pZOfEGEYT1f6qvWj+xG4vOxVFS58YjCC8cR+zROT2CNvKzseLxmNpsovFSA
 CUa8oAfAvOPp1ZqmFBjlYgE+fsAV+xgsjFHQju+KtFAQiTrdES28uQd4/nCxeaohQrlU
 u/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256765; x=1794861565;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T0JMvw1YCN1tlF4hgAFYOVN5tY2jGKjaxFrBMJk6AG8=;
 b=IBXm77hisBt+Sz+Lh3ihpWeuIHYreKlSYDtR3L93uAoG0Gf6Ttt96MfkCvPlAkjNK5
 mM8fgmB989MiG84rUEwUAZQk3xiR1ZcgddRch+pYURXO3i+8Bysfy/83nR/2WaPDgyNd
 a3rApHfppBE5ZYfA6g74VCD3LYgIt6wmPrUyFar6qtfO48XQSmt3q5nBbE1qicuHnN00
 uOlQpRZDT+tMmtDNUkWUa5Tgx/DYPRa7sH+J1G9hJrLwbJnsOg0ctRbuERu9Jl4WHhzn
 +j/G1uZv7jwgvZsM2RgSZ+VXbDqH8EyXgOHSTpvboTGsAOZ7dWvx62SQxWjsJkBpDxxL
 +zHg==
X-Forwarded-Encrypted: i=1;
 AL+hErEmQWRGa3L+4WJysMT09RJC64zitRaoPSBPdKbTOZzFZGVkFl0BijeF6Q9ohE+gTNdMB72v7oF6B7i2@nongnu.org
X-Gm-Message-State: APuU4Z+B70nAaGt4ZRvoQ1FDlpxqa6uhwLU7JLI7J3TRrMW31nBW2iUC
 hn00JtsKuf7GBvM9lpp1FMyxyxOOj3VQIZNTWZMZwSNZGfo2qo7nUYMOeG5qr4R+hLyBMa3lsJK
 LLaasBB95JpKRiF9C5HCe1lf2havDwcEqjyBklZnelqR27L7FX5bjdMDKoA==
X-Gm-Gg: AYBFou1fi2+4JboBkx4XsoC8BBpBLgDwHzujTcstYrWb+YFN2awt+VvondHfzC8zZw/
 3KYwXY3j6j2M/mCTRQWpEV28kfN6dQKJcjAhGpuJ3K1mIdVsjkZoWtUfwWboE98vv8IoONAMH8w
 qbAGOnNcT8hldUiEXu9BANDzjAUcA1c1MT7qjr4K6mGkauze3rw1dfSaYsqx9/am5hllEpoC7Kh
 wer0AjiFJpmAQtZ0IRl5HI05JA1eY2kPsAdJHm2ucARsYbQcn+opZ3xNLDS9Hm46TMPPCXcrKhJ
 GM3HcuPyfqUm4YSKlQebyUvcoaLHHCp+k2seg3G+bMUk/7AyodDZo+A8GY18prIv5avyeoCVoHS
 ut22oVX7YWogz+epUl4D4o7+db0qPjP+VAd3sHGZ8xz1XMoGIRvUnRpls1EV/i/Nc0flqJzvLjM
 bp5eN0Mfwg
X-Received: by 2002:a05:622a:1f12:b0:535:8518:a4ae with SMTP id
 d75a77b69052e-555297a1d2fmr7041531cf.61.1794256764773; 
 Mon, 09 Nov 2026 12:39:24 -0800 (PST)
X-Received: by 2002:a05:622a:1f12:b0:535:8518:a4ae with SMTP id
 d75a77b69052e-555297a1d2fmr7041121cf.61.1794256763978; 
 Mon, 09 Nov 2026 12:39:23 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550be2e592sm6148181cf.24.2026.11.09.12.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:39:23 -0800 (PST)
Message-ID: <f7033a94-6f57-40c3-bc12-f90f5ff90e0b@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:39:18 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 26/38] target/riscv: Add cfg property for
 Zvfwbdota16bf extension
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
 <20261104194155.679241-27-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-27-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX16TjvXQbOkwA
 F2+1/Biph7hb1Mlo5s0BmKEdV2DGsiGKm2vSCyTCvX3tFupgfKxWcAnv0ft4gGw1LjMDi/otZGM
 xZnwdHlPOaTa2R8V5aXX1TYTzG+TUWrHfRGJIywcdJNqD1aU4xdZ7pKlhm3AIm7135hlciJmd8Q
 Eva8HxEWkoMDQu4nYwvm98mKSilVOL6BanCDPrJmupzZLVEaUa9b4LUxuf4TQbvkrvxH8YiMex3
 WdBFfpSO1Praa3e25Zb8Ros3jTJ6X+niXXmKYUybf8qISBONkv1Disd88E01vgpnfykAdLOiOnr
 63shFCJqL2Nv60dfXh+gc2tu/0/td3U4ADppgTXDEHw0dUmNi/iXJYO2OEDWquof/LHlx81j0VS
 d1Ug6EkDwz3LYZiKiKbe6rj5tSLizHSIy1f55FLSSisjRJgnTjX7BeUKxgy2CUb74H0dRPhEWp5
 bP2EgLsUZ8GEOYNB/Qw==
X-Proofpoint-ORIG-GUID: LwBiKxz0b4gcGLB34cQZdNfWYgiIvc-3
X-Proofpoint-GUID: LwBiKxz0b4gcGLB34cQZdNfWYgiIvc-3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfX6Z8JFBibE0Ec
 YIk1GwalSwFO0VwCABDjVHbVJPTmyYnrdIZfVp2RgfGkp5k8cB2j8T59C1P8QfP6qz7tc+nE2Ms
 d6wP3/vHRlQkWf/tbfqQJvBa7AuFsVs=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af22f7d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=Ya5jKuBqKQPJWbtsfvwA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add CPU configuration property of Zvfwbdota16bf extension which depends on
> the Zve32f extension per the specification.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c                | 2 ++
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   target/riscv/tcg/tcg-cpu.c        | 5 +++++
>   target/riscv/tcg/vector_helper.c  | 2 ++
>   4 files changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 95bba330e06..c33885542f5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -238,6 +238,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfqwdota8f, PRIV_VERSION_1_13_0,
>                                       ext_zvfqwdota8f),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwbdota16bf, PRIV_VERSION_1_13_0,
> +                                    ext_zvfwbdota16bf),
>       ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
>                                       ext_zvfwdota16bf),
>       ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 83a3d8a7f9d..80750db1ccd 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -107,6 +107,7 @@ BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
>   BOOL_FIELD(ext_zvfqwdota8f)
> +BOOL_FIELD(ext_zvfwbdota16bf)
>   BOOL_FIELD(ext_zvfwdota16bf)
>   BOOL_FIELD(ext_zvqwbdota16i)
>   BOOL_FIELD(ext_zvqwbdota8i)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8735cf94f35..8684e4c709c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -721,6 +721,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvfwbdota16bf && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfwbdota16bf extension depends on Zve32f extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 683b14f28f3..873adf4d7a6 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -41,6 +41,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>   
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
>           riscv_cpu_cfg(env)->ext_zvfqwdota8f ||
> +        riscv_cpu_cfg(env)->ext_zvfwbdota16bf ||
>           riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>           riscv_cpu_cfg(env)->ext_zvqwbdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwbdota8i ||
> @@ -101,6 +102,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>           break;
>       case MO_16:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfwbdota16bf ||
>                           cpu->cfg.ext_zvfwdota16bf ||
>                           cpu->cfg.ext_zvqwbdota16i ||
>                           cpu->cfg.ext_zvqwdota16i);


