Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40613C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rop-0005qi-0T; Tue, 08 Sep 2026 05:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3ron-0005qL-Jw
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:08:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x3rol-0002pQ-QB
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:08:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886Lmce2502331
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 09:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=jFFitPRe4wNJZ4ZqOFkWmgqJ
 5U2V2YXksYnkHPpRTwY=; b=pUkZ/3YqQ5rLBc/oDRP6We6oGfS811Io7zo8z5UW
 2prk2pzRr1E4zDMfttTDgSSpoRwwcy3DiEydJA5iXNpHGj/qy1MkrIWAMVj9avdR
 enOMAn6VJPnVa/KbX6IalpjDZLwpqlPf7x5PRJ7LR4+3IcIN5/1p2d/KNZQUrpXE
 zni01/bnmQzj0SnYu1lwAI+zyZjfhjOCZA5p6zR7SYWx1gfazaKWl9Z2D+seU34J
 pIV3QfHmxAoPyPZyR2+AppyjGNCOmGQSqgdRIUCp9+B0t2U7mfqjqmBlrWMw/Yrr
 auHoEd4NMiOR3ivkdcoyc0IzCf0DsqwGlxrBtlQohMHbpw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjcv7gr04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:08:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e4f946461so787495085a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788858516; x=1789463316; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jFFitPRe4wNJZ4ZqOFkWmgqJ5U2V2YXksYnkHPpRTwY=;
 b=VXZ7/lsLxg+cbdNv/NC1eEtL4GyerLJuUOgsSMAnvzkOrDYrARlpLBb5pQC8A9HWeg
 0Rrixl0eYfC2zwgLqFVvZrq5X9ZHKOY0c+U1MXo1uj2v6vfxjW1+Ef/kTZHiZ4s3QQZ9
 XoY4gZ/0AYPg6hYuwp2UN91IOOpp2kRbBIiy65td3aSI2N/j3Lpi8NAi31a1ieJU4x4H
 D2tjYBk1y7wBQbdvnRAMbVMwdY0oHa2xOZjBlw0BpxUKDCWPklVvuWxz+LKDh8DUXATr
 YOJm8ruvrGhiYqOW/MF8spbavgNXo6rcfMQqjZvTt4Gfrkozno2WCByB0/pGXf0l4hju
 gpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858516; x=1789463316;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jFFitPRe4wNJZ4ZqOFkWmgqJ5U2V2YXksYnkHPpRTwY=;
 b=tSa+H/uaJmZkbl25DUaUXrs5e2ymj1iwJVYYPoLyeHtHauZItdpZDs4bjnMK2yVGJy
 VrPgAg2daCG61b8QfjhTEjgUiFaonsOa47LV2+lgEy83SkinnCQjJlhOns8/vRUORhiA
 PmuqvL+wPYmzSSP/qQLSIlBsTKpR2F36aYat3GEDWJxXZwaFLcbxlrH7FqLloyoRyv1+
 ECLnMSE/HuRWheMGRJg+INiI+J4GS8ZFtmlq5cakDp+Z+IFZ7DraqiXMcMQq0Dkb/l0y
 WP0enEOPpBqPBjZtNECGe6HBcpZH4RmrUHsyi1sTIbqUiBnfKuR12eLs8RHUjikKx8eE
 o2/g==
X-Gm-Message-State: AFuF++nLi56YO7aNVlgvch+20v3q+EoAzAwrBra3KgRgn0w9oSLthcm5
 SlqkxjxEVeKYsZ2nSkUPu1Ml4YsL0ceQyePAcog6VaN6gTxTaISZ2ch3AqpS7RMczf8PLxdP60Z
 O+6NLkSH9Cr/YbfxH0Zn0OgCIt98B3hXFsR/F2MakdGAbiIv9dbEOTzyRew==
X-Gm-Gg: AYBFou3xUwzM551p9gDrvcFxoolLcg9xs6GNSVuZfQlOiReFgU2g362OOjtZu2+CxzI
 4ymE0ttwOXYuXQUSCYmT2peaBmZYywi920X/S7zUw/g3WOAuflVCjYqVRQxE9uJhU1lOlY5bpSP
 H0MDbHEpVSV5SyL5GTe9+R134x2zlo+gqk/4KFS0+rTXZSv8IBUy8kcddbruvkXb2I+qMp4DOlH
 4WqkoR7YHokqlQM5jMEEu7tY/46r+groHJ9QOcK5I/6z3bg5eivUt28eEbAz9NJIFIWYCH/GCkj
 ys2zBsQ8cuTInmBEjhxvJZelLKzPZoNWui57v4FXsAraQtw18l8kcIOw/zf8TbTbNyVPYeIJuEP
 PzrGbf2sssUeSjCwcm6DNA2uTEL70lzfhYU7DQg==
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-939803292a1mr2973174785a.8.1788858515674; 
 Tue, 08 Sep 2026 02:08:35 -0700 (PDT)
X-Received: by 2002:a05:620a:370e:b0:939:5f4d:67b0 with SMTP id
 af79cd13be357-939803292a1mr2973170385a.8.1788858515063; 
 Tue, 08 Sep 2026 02:08:35 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a7e68e9700sm5533226a12.21.2026.09.08.02.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:08:33 -0700 (PDT)
Date: Tue, 8 Sep 2026 11:08:32 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v10 2/5] target/riscv: add riscv-server-ref CPU
Message-ID: <qe5iku7uldi7ok4tnfmph64mns62uz26vgbokn657rajjblfzr@k4tyenhmhuwb>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904195610.964829-3-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a9fd094 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8
 a=FRSEYCzRAAAA:8 a=DdpuajOAZS452ExD0-8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5NSBTYWx0ZWRfX/IYZ2nap7xof
 B52xc+ijV2C/fgjEDgcPkqpTunPHUcSTOS3k/U/UTYj+kzC5pEnpw4/apFGo4KMWxLJVeeqJsdi
 MlMwTAcRKdm/ziJnoWf+mb6F2+cq264=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5NSBTYWx0ZWRfX1yWQHXz9Vexc
 7uVG7iT04p0vsJMTd5NjXjlmk040/JrIgEdUs8X6+Az+8ekHpygvDCZ8c7TV6OHY679B2INCUBB
 BUE3hjtkxQyPv/VqqX/GaPEw3CuuhHZ61xvoFphlEI6kPhqEF64lS60LrPVTevPPxBKyl5WYUlg
 DGh2rQ2X3pyfuB3v7N2+3Ic6uRsEoMRU5tOmuF7vDRDCBhJ1YflFT6NztKRDEWPEhi4xZStXN0G
 0vCSvqMEXABalPuhYIHWkdQJw68f0KB09N+FimuSduXm5+0wHpr9/SIuLnKG/xT1c6Io6uRW4uE
 Z44tK2e90vVeCrulnm77P+Sws4u9z/iOeje0pFvIY9VsPcZryaGXz5cDD1cLtqB2/+E34SvZTZ3
 J7qed++bxche3xfToMc3pUdEGPhJg46JwfYPFruc1BlQj6QkufzqlO7aJpZaJstsZHtmXxAVrq3
 KW0fbwLS5okeqAJFeAg==
X-Proofpoint-ORIG-GUID: WXnFcLBHsIsWT45R4qCxznuiSGm7ozWs
X-Proofpoint-GUID: WXnFcLBHsIsWT45R4qCxznuiSGm7ozWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080095
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 04, 2026 at 04:56:07PM -0300, Daniel Henrique Barboza wrote:
> The harts requirements of RISC-V server platform [1] require RVA23 ISA
> profile support and others.
> 
> We're going for a profile-based implementation, instead of a regular CPU
> that can inherit RVA23, to allow future CPUs to use it internally as a
> starting base for their own extension sets.  There's also a new
> 'rvserver-ref-1.0' flag that can be used to set the extensions in the
> command line for other CPUs, which can be used for testing/debugging
> purposes.
> 
> Note that for all intents and purposes "riscv-server-ref" is a regular
> CPU and no, we're not trying to set a precedent of calling the riscv
> server platform spec a profile.
> 
> [1] defines in rule SEE_020 that we must support at least 11 debug
> triggers (4 for insn address, 4 for insn load/store, 1 for icount,
> one for int, one for excp).  We're going for the minimum.  If more
> triggers are needed users can set any trigger amount with:
> 
> -cpu riscv-server-ref,trigger-count=N
> 
> Note that N must be <= 128.
> 
> [1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc
> 
> Suggested-by: Icenowy Zheng <uwu@icenowy.me>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1a28f1369c..61234842e3 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
>  #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
>  #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
>  #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF     RISCV_CPU_TYPE_NAME("riscv-server-ref")
>  #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
>  #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
>  #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 185474a8cf..b5a75fbc1c 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2417,11 +2417,35 @@ static RISCVCPUProfile RVA23S64 = {
>      }
>  };
>  
> +/*
> + * The riscv-server-ref spec isn't a profile per se but its

spec?

> + * CPU definition can be modelled as a profile that extends
> + * RVA23, with additional things on top of it, and allowing
> + * future CPUs to derive from it via
> + * ".profile = &RVServerRef1_0;".
> + */
> +static RISCVCPUProfile RVServerRef1_0 = {
> +    .s_parent = &RVA23S64,
> +    .name = "rvserver-ref-1.0",

The commit message and comment call this "riscv-server-ref"

> +    .satp_mode = VM_1_10_SV48,
> +    .ext_offsets = {
> +        CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_sdtrig),
> +        CPU_CFG_OFFSET(ext_ssaia),
> +        CPU_CFG_OFFSET(ext_ssccfg),

The cover letter says that the sdext patches need to be merged first.
Don't we need to configure it here?

> +        /* ssstrict is always enabled for PRIV_VER_1_12 */
> +
> +        RISCV_PROFILE_EXT_LIST_END
> +    }
> +};
> +
> +
>  RISCVCPUProfile *riscv_profiles[] = {
>      &RVA22U64,
>      &RVA22S64,
>      &RVA23U64,
>      &RVA23S64,
> +    &RVServerRef1_0,
>      NULL,
>  };
>  
> @@ -3759,6 +3783,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  #endif
>      ),
>  
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF, TYPE_RISCV_BARE_CPU,
> +        .profile = &RVServerRef1_0,
> +        .misa_mxl_max = MXL_RV64,
> +        .cfg.max_satp_mode = VM_1_10_SV57,
> +        .num_triggers = 11,
> +    ),
> +
>  #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode = VM_1_10_SV57,
> -- 
> 2.43.0
>

Thanks,
drew

