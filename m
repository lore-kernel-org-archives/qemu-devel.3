Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3260A2603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F1BrHMFt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fV6Z2hNb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVX4-00041I-4I; Mon, 09 Nov 2026 14:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVVT-00032R-5B
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:58:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVVQ-00045v-2K
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 14:58:17 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HH64t1525255
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 19:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k8s1kli3QS4w6J4igCm2SG55neSxU1XlmvU6mXPmBLA=; b=F1BrHMFtx7oakTF+
 KpA9klvf9HyijTVJmqNT/N+RDuqiKMtsLAMZarhvle+k6UYU+oZ+yNuiwW9JXyef
 SA1VTEfqsMDjX+i2qj21LmO+eHKNRPETGDb60gf4JmPaF2j3ijkIUxoSRiGSbh9b
 Y9gHZ+Y0fMpkge+Y/N/6DF/6MHdSiM92Z3RArfNkAaN6ut7CvUqBZYRWqPkNrSFw
 L+fzkeq6OQgDh5dveXloBKLNltkWpOvtmw11sv84V9ZWhJx93L8Foj6fZ1XwVHpb
 TT2LUwf3It4G6hqk3N37jzNa9iQDxvmMfGb7FLHoy26rZjNGR2E5JCZNzKzzZve1
 EUiiBQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx819gx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 19:58:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5383c05fb2fso44462541cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254292; x=1794859092; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=k8s1kli3QS4w6J4igCm2SG55neSxU1XlmvU6mXPmBLA=;
 b=fV6Z2hNbUEMMNbDbMsiSJ1XS4B4Md0h2Qyh44oIYyPyciLf/h0ht2qq2m+VmqUmgAJ
 nQSDDrsm89unEz82Ebnu72S9B6WesLmnU5vSvYWadfdqsO0YDgo/lRYEhg5sEKcqqWQU
 X4NWsjzJ4j8F08D4zqxUfmGTN/Uls+BeAcCDgfa/eyEVAYW/hJW2/kC/RUcypEU6S1zi
 gKcdp4pZVjJIJozZMhhvZcU9yucQDOJFGfCu4UkhGh7BE4lqjAIXCE0Y9tEtRMGcI7O3
 gWuCpAigfSoqpOJ+jg/EPGhO9c1kQw1eGm8I3oW8lhXZKylN5GMic00LwGVK0Zo2vb6q
 GnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254292; x=1794859092;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k8s1kli3QS4w6J4igCm2SG55neSxU1XlmvU6mXPmBLA=;
 b=OctTfYmSeD9h5Aw/o0vTJRTM6U4dCHRt564Gt2xOqBE6IGXh5J32Gi9GJQxs6glMal
 hi7qsHLnTHY0uBMJCyS2i72hP9cdRQFUEQ1mF+wQKRNeSyEY57KH+yQKwdgpUnFEMjsx
 19XESoZG+kaVoYTUvSV7Ywr9UFgv1KgL3WkMCtPqD8TYDdqhu4TJ4t3Xel8DisMByYKF
 9t6eKSWaRaYfhTloM9SAHzilD4ktLvScJyxUKDgurY9TKqleDoq33el5U1GJ8zdB33qu
 aYTpWKmRdNn1ZvoTeFhaYQ4oFO5Vl/2uzE29d1poW5q76zxORToyjoVOcFT648wf8zsI
 IwPw==
X-Forwarded-Encrypted: i=1;
 AL+hErEudTiF3VlFtCbCNaBLXfsMLS+H+Vrd0qJJ67iNt54xm6yr/sWplT+7DZLIu546EUSHU+5Isvk4b5hc@nongnu.org
X-Gm-Message-State: APuU4Z8O8yuc6ngZS0lqpuT0EKGkMtF1KZGHK8WeYfFlSc7xUjt/M8Qo
 YP8LB39dxvFa+obYDvMPMj5BMYQ88epadjCBMvlx08SNXnnoOasN0YYhAkiDoMc6MxPavgck5oj
 f5+AD5KKGAOfrD+t0jBKW20CNSgEjh/iO3nzpcufnkuNXG5paxc0VEdsXGQ==
X-Gm-Gg: AYBFou1hcFaz3kYegALu7jNaqHFkf+wMeKioJKHGMCUkqwdjzcRvFz0KBEUsfX6HNHp
 OhmcOahwAEeP6b31prn6ojQycJ7n/oM/AaMw/ZP6Idztuu1Zj4HWQN0nMlM1fIt1MKrwUM5hbBV
 rHIhFhgXhPXvc76BpNI+p5LrlKiGM6s/Y2ur3PHuTVgEBSMWyGHGbB4IPv/Zuh0LqzXlUdYD4Qv
 aOiqavbjm/fIX4nNFy8dwBiA2D2CHbZ91C0vbD5GWpo73ivS//WzzWO8Iu1U7Gr5J8qZShEcJ3e
 Du4qashYbwU/zQz5ok87uJ58IK6PI48DzGHoqvaw1qw495Sj3HyCkvdT8aPoGEe2Im8iIQmw//r
 NVb3JxSUcFMsDh8n6Wg6f4fBeDNV2BhF8Kj/bz6BybTZF9cRoB88Uact3O0UuAmd79v9XWXYBEo
 kXDeO5A5kD
X-Received: by 2002:a05:622a:1247:b0:535:84e3:b165 with SMTP id
 d75a77b69052e-555257c5c5dmr8198121cf.9.1794254292460; 
 Mon, 09 Nov 2026 11:58:12 -0800 (PST)
X-Received: by 2002:a05:622a:1247:b0:535:84e3:b165 with SMTP id
 d75a77b69052e-555257c5c5dmr8197801cf.9.1794254291869; 
 Mon, 09 Nov 2026 11:58:11 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04ceadcsm3785256d6.19.2026.11.09.11.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 11:58:11 -0800 (PST)
Message-ID: <4cad77b2-f5ec-42c5-b499-3d00d37dcc05@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:58:07 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/38] disas/riscv: Support Zvqwdota8i extension
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
 <20261104194155.679241-8-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-8-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af225d5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=9igOfUfchdEoLShCGswA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: 6BqPP_wrFKbvehOytAUiU1y541K2SpY1
X-Proofpoint-ORIG-GUID: 6BqPP_wrFKbvehOytAUiU1y541K2SpY1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX8JPRWatKtArh
 is/KqIe4btZM/XFRLBdPRwo5RmG+eLWivkgxrkkvqcXyDEjqxIwJoIWKtHAMZXtYDWUmeymZx8t
 9gbbtmZDiZcwgbXucQze5E6B8YfA2Ik=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OCBTYWx0ZWRfX3nXUjku7npHo
 PyZ7AvCwmtODSZpQs7sppfF0FU5DFiOfh1KwIjvtmB+HJIBA5/BTfac6aiukvY1B9C6v7tIgoZD
 kts8Zy8wuBcAgdI7zqQlLYvCUwoswIG+2shxdqhBIabMH3gGNJULNEA+oIdS5IWmSTptEeypl1c
 hClKL0KEnE4ygnm5cpycIw34OmOlpl4DTClJ2LERk124bfGziiI3w1cL0H4plGpQJC+Vn0629UK
 iD+CIRudCtEqonIf+l7CAS5OjfeTNJPP2rB43M0cMnv3U+uJ2MhLuHtN4Rg4VQ1m9tWzL5aFj3F
 kzzXYdDXFfxb6Vwhhly3XJLGp4degjPOnYgdOA/xEL8fd+8mtI7Z+yyCorOqnWuaqD2fyR5Po5J
 M/UYy6J+PG15V1xcL4a+1Dk08SEOKNxv+QRoMMEb/lhqUMU3kjOn3+a1dZuR4l9KmG7UMWAHSC4
 XF4fGZsZJ+iHmrQZZ6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Adds support of Zvqwdota8i extensions:
> - vqwdotau.vv
> - vqwdotas.vv
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   disas/riscv-op.c.inc | 2 ++
>   disas/riscv.c        | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> index 425473ee61b..ec767ccbf8b 100644
> --- a/disas/riscv-op.c.inc
> +++ b/disas/riscv-op.c.inc
> @@ -770,6 +770,8 @@ OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
>   OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
>   OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vqwdotas_vv, "vqwdotas.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vqwdotau_vv, "vqwdotau.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vredmax_vs, "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
>   OP(vredmaxu_vs, "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> diff --git a/disas/riscv.c b/disas/riscv.c
> index ca0d6e90b37..2acded0c915 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2634,6 +2634,12 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
>               }
>               break;
>           case 29:
> +            if (((inst >> 12) & 0b111) == 0) {
> +                switch ((inst >> 26) & 0b111111) {
> +                case 38: return &op_vqwdotau_vv;
> +                case 39: return &op_vqwdotas_vv;
> +                }
> +            }
>               if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
>                   switch ((inst >> 26) & 0b111111) {
>                   case 32: return &op_vsm3me_vv;


