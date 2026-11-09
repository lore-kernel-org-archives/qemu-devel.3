Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65050606A335
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Wj22tbJv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CmvRlORY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVaw-0007Wg-RO; Mon, 09 Nov 2026 15:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVau-0007W2-V1
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:03:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVat-0004b1-3d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:03:56 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHNNY846810
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ByQ8UyKnLfnRpawtxW3v535hjn03Gu+vdpl4miyG7bc=; b=Wj22tbJv3L+iUHXM
 ZrusBPDLB4aBQI7suKXEVDqha2U6/7u5THL/eExf0v2Nsfso/LVU3gDGLMusf7tI
 UQ0rzqYDXEVLdEELgqnUtx1C4WiQNJ3XtB2JSsMYw9iYdgpEImrZ6ROC9O6zwer0
 TM1tI6xVefcM3wZEd4Pdx/zY+D+XVUeN+TCw3XNx4GcQF3SAIOYB1+xJ2V451CUi
 oUcaCL+bi9TBRhF9ZGI15tJJrze/vdwDHPePYxdseVGAWRIwzc1ZKS7+K2LqxKPZ
 F5gywBkHyxnU8+wvqDMdmwBdhEIK7Xxpqu7uTqMM6i+ebSVeUOV4MhRz/cIk4z9K
 83kkgg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapa27v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:03:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-945c60b470dso192452185a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254632; x=1794859432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ByQ8UyKnLfnRpawtxW3v535hjn03Gu+vdpl4miyG7bc=;
 b=CmvRlORYVGPrSKizltVowRwyjgfs+IltnV0YjHGdTw8a4+YYcRvghTLV+zhMp6fnBy
 jLW/JGQbGGoBdEeTH+7MhmPRBoTuJwGzBT/ocr35QMdELvnZuB+QWm/3PAIaxrfjt83R
 ZDuD/TqDM8P5PyYPqpUCiNIvZ+sl2vP3G2Us+Z93ju1ai2G+eYinHXkp4SlSxr5arzYZ
 ZQ0+nUmYq09pJLIFJRutq51rYZO0+D/N/sbxasC2v9YOqCSfeLX3tZ+69ewybXc8NkA/
 RliCnOV7WGESTVrvq2tE07cnLIyivHV/L+ZwmueYjUblBCthiGPwaK6/OpJCc7SpAF2k
 L+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254632; x=1794859432;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ByQ8UyKnLfnRpawtxW3v535hjn03Gu+vdpl4miyG7bc=;
 b=cSK2cTEKMoDMT0gRK7A6QvzU82qx4zdtSTF6NS1fIt7d+zDZwXw8opySYihi9guR4c
 t3dGFJOUrZZC9Oy/KNf51/H5NdX+juHjYlZ8nIcgMdoWdk5AuaH3k8An43Prm6PtFrCE
 cwQHM2iM1OugpbR09fABqXdqDk3asZmkQzD6EBWlCA63HgbKgjM6gUtv42+kYQ8wHkSM
 +59jfh0Uu5zjRt6RYfDo5uRx11mCwifr+vhPmtAB90ulaNRM2DPUdYBDTBQzcdqwduEg
 cNjDF16NpV5X/c4LJhSzJ+A4knDv0yvn6aZogRqUNiB9j0xcBlOro059qw3SWekh1aZZ
 Dyaw==
X-Forwarded-Encrypted: i=1;
 AL+hErHjK5R2rf8sWQ4S7txDYUc+92RRnPztU3Ncud/T0w8yvbQCfdZ6RisRAKebrelveImN62gTiApdTtn3@nongnu.org
X-Gm-Message-State: APuU4Z8xxML7+eTJiZJpjlCE/I1ekcB0viO8ofDicYpcfEWQctWCIZid
 q4NnSvipGuHp/oR2a1aZhbymq13YQJF1YnNTBPnsVcZWRLNqoga8tayf+CSHATr5wZT8+zUzcq8
 ZL/tHa5d9r8EHc5xAj02212QlJCL77YAq5mNxHuvZfqWQimvtQlFC4QSiCA==
X-Gm-Gg: AYBFou39sWPXcxJdGXYB+kuhs0MVNcUqoTUJkgHL8vEBIhPGTaSrohkG3j/QLqd28Ig
 47gWkx88DGuZ8oAlbJQLzZa4XUhVDRR7hBh7frLN0efVUR4wc0r5vnSRhPTBkg1tqTU5we4p8Rh
 AFTMBRxAB1ttiCSViqHZmYyZ9pCFR+3I2DxlC+gyhKtU410/P2gE2yPqsZqhlsriVd8RbvwKi8j
 Ar84xf/hP8pIza76IcQHiAx8i5Qy0bYDTWPlA699sOLVMLEC/N/MQBaxyzE0Ji/HKAomcYMy0hL
 pxSFsg5mnmb9fVXYRiSXBphcMnFkV0ITtQDYzu/K4d/pWYnu0NOWEWnafMvM5aq6It5zqm21aaA
 aMOoMP+lq2nDuf3lFx55RJBzLyezdZGBv/uf3zjqJmz+ysPXUiHEv4iZ1LEDkWqETvM9jIApx4k
 2QxOo6kiPi
X-Received: by 2002:a05:620a:1d0b:b0:93f:6375:aaa0 with SMTP id
 af79cd13be357-9479f394e07mr80696085a.80.1794254632264; 
 Mon, 09 Nov 2026 12:03:52 -0800 (PST)
X-Received: by 2002:a05:620a:1d0b:b0:93f:6375:aaa0 with SMTP id
 af79cd13be357-9479f394e07mr80690785a.80.1794254631665; 
 Mon, 09 Nov 2026 12:03:51 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e61c150sm55728585a.2.2026.11.09.12.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:03:51 -0800 (PST)
Message-ID: <6bbe820e-32f7-46c8-b7c0-197a61d24fda@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:03:47 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/38] target/riscv: Add cfg property for Zvfwdota16bf
 extension
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
 <20261104194155.679241-12-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-12-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX5WI06R+Gxcru
 t/WWEoGzi6cPlbfvwKpGNsUAIHJFDJE/p4BgG4wRUiPf4mbWKaU0FXmmB2Z+ipwyK8r2gbRVyKc
 TptDltq5Qg8zNwt9EYYVUfyhUxZBF7EXPVI9HVsdOlLWII4nCnTPIPIa50zE80nsXFjNkpCX3KY
 V9tC1ISlB3MdR+ABoqBI4sh+ozJ5NG4h5oVvzMR1VZ8WGy7ZJpjMo5i3UhdMHfF/0KXuAMX5rIO
 hzBWyaenM6sE6ZKIQv1QbrMAcf3R4vDD0jvGB8Xx9LHDs88uklAnO+8QPtLGzgCuOZTR/F725XO
 VXdAXKF9BkXuuUt/Dq1jPTvVNa6/J/ce09kUToCdCcTV+IAk8MtHPB++6gsOdLTlNBoaPQ7f1zx
 gru89XTYY91ZSOJitG/z8SgLt7PgQCc6UUjAXrp5HMEvaIfF5tz31twKaSoSys8Pf0siI8vugFN
 h1LTmKwL7KFQlL0ayFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX97cxq1rC69xE
 YSVmkX9nrDy7SLOteg9NaKFkbdqzxsGo4pSH1JoynNVdlCP4I2ME8CH9cdKVBbZt7RqUuvcHH28
 5ndxIZyP4veQhmv44czWHCPbZFvVMVM=
X-Proofpoint-ORIG-GUID: S8tGuM4Ar8t8qxnCcHyaS5VjibYh23DW
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af22729 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=cyZchcy-x6cUBInBKMkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-GUID: S8tGuM4Ar8t8qxnCcHyaS5VjibYh23DW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090079
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> Add CPU configuration property of Zvfwdota16bf extension which depends on
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
> index ae859128d30..d6e2b07c401 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -236,6 +236,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>       ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
>       ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(zvfwdota16bf, PRIV_VERSION_1_13_0,
> +                                    ext_zvfwdota16bf),
>       ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
>       ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
>       ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 8bac69a17f7..30c404863c8 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -106,6 +106,7 @@ BOOL_FIELD(ext_zvfbfmin)
>   BOOL_FIELD(ext_zvfbfwma)
>   BOOL_FIELD(ext_zvfh)
>   BOOL_FIELD(ext_zvfhmin)
> +BOOL_FIELD(ext_zvfwdota16bf)
>   BOOL_FIELD(ext_zvqwdota16i)
>   BOOL_FIELD(ext_zvqwdota8i)
>   BOOL_FIELD(ext_sdext)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 54749125acf..91e009072e6 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -701,6 +701,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvfwdota16bf && !cpu->cfg.ext_zve32f) {
> +        error_setg(errp, "Zvfwdota16bf extension depends on Zve32f extension");
> +        return;
> +    }
> +
>       if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
>           error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
>           return;
> diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
> index 57a381098f6..41b526d25ef 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -40,6 +40,7 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
>       target_ulong reserved = 0;
>   
>       if (riscv_cpu_cfg(env)->ext_zvfbfa ||
> +        riscv_cpu_cfg(env)->ext_zvfwdota16bf ||
>           riscv_cpu_cfg(env)->ext_zvqwdota16i ||
>           riscv_cpu_cfg(env)->ext_zvqwdota8i) {
>           reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
> @@ -95,6 +96,7 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
>           break;
>       case MO_16:
>           ill_altfmt &= !(cpu->cfg.ext_zvfbfa ||
> +                        cpu->cfg.ext_zvfwdota16bf ||
>                           cpu->cfg.ext_zvqwdota16i);
>           break;
>       default:


