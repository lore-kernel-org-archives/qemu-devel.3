Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5F7C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ZVS-00078A-DA; Thu, 10 Sep 2026 03:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4ZVQ-00077R-KY
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:47:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1x4ZVO-0007jP-3j
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 03:47:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A5H4AY3656080
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=9QzctfesIz2/8zhFNiFvmwFJ
 McrNV/icdBW7FZZCuP4=; b=ZGsq2WJb/JNbKZth+H73r5eQi8BmAZgYGQf+gg2a
 SI3RNkFIfxRqSuvbqAaigm6mR94uCw7d4L1QYJuu6eVrZiCVE/KmrRCCiZwkfPv1
 IKLsJQiBOwZJfJauUfNW6I+ohP9JvYWRGSgQS8A7GJiDhHk5mxxfrMwnScQ8SFhG
 TiOgz2bfI7nWezsTL2MJg88dWVvVCMkO2oOxQgczOu1opHsPiO9yu2B1Nn3O5wVh
 7GCHswG5xHzXVR1V/cgUbCxxlcfkaMgB2Jmvn8on0g0cMsPgBsoD1ASRa06jOwcS
 NCYmQUU6e5biB97QVWGlItCcf+lfzgQwsQN0dZqEvWSPvw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtps1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 07:47:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939c30aa9a0so251403185a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789026450; x=1789631250; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9QzctfesIz2/8zhFNiFvmwFJMcrNV/icdBW7FZZCuP4=;
 b=ETUxiEifn1QviTetChwocDpNVM490T9BwZQyU3pLofyxP3BZtAmn8dL8XMwS/z2lmf
 XKZMI5LBHg8i5rOAzJ2uHASuXXz9904/o/zIp4SbPwuz5p9l3Pf3cCl7UE+R/czTNVyR
 XSZ52Ny09Xgfh1IqY4lj+UyXCQocN6g+v25R3pT+P8KC7eV3TpJcLp1X2YSO+dkHtGFx
 /rsz+KTz7kIPm6WL/Mgb9omhlzhRriZuRyfW24EhnpXJF+3jt+i+nTnbj5eghwsKaT3c
 LEkI8Tv75ZJA2ncLGCJ4Lz8/ZYZxlDdgZo+ZaO6RMaacPNFwefrWDOSdVDv2CkmFJ7IX
 Nr9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789026450; x=1789631250;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9QzctfesIz2/8zhFNiFvmwFJMcrNV/icdBW7FZZCuP4=;
 b=Nl5Ggfa/w9XL7niIY8MoVJvJdCDZ5AUQzd7/yGmZSBSWQV7dxqEAyCBBEJVSzQ1ECQ
 QbbY1luGJLgGcIt7yajU58YXnYw4Kh4m4OEd/XTSnpkvcxHqpOA1pj+bTXKHSyJ6MX5j
 ufwyUvYtBJUlRVXUbxB/Ke7HDtfxMtTPbVtCTb12lyXrEVlBKZiUcgWKBv0Lw7ntDCJ1
 pI9B6ruzlWD8Hq3ybLXcm5YYOT2YR8D6P9QoybB/xWkIi6Nqzczp3W0V/kMeTWwPn+MH
 uWdVqZBqJ3DgOnqdBnDu4SQyTslJFntr+apDNMb3DOR56r7SAzshuYCb51fbDTyrjKel
 8CAg==
X-Gm-Message-State: AFuF++mBnfOAkKzKOX2L5qkeRSsmLH4Nf7KribFB/wGFsQMkYdEaW1LU
 P9G5m1xNXrNqwYf+i6355z26ebmTGRvD+ityUse3LGQDKSY5JeYURdEFjuQHbc+IeSMX5AdL4mP
 L/xIWFLwKolhJw3ej01ZqkdH6xHN5ZSvY83xnhChiyzwasX6O43+G8o94nQ==
X-Gm-Gg: AYBFou3mD9iXpPnAKT4qDdlHkV8oKVLGgL1NjyWWgrxV79NkYnCaeNQyHTf8nzc1aiJ
 ytdbeOf066i6ynCwGglTaX3W5mfQG7IrHW0JnEWtdiEXWULDboj2+koKesftnBfn1zdsQ/Hq/lR
 n/jZXMlm7g/VIOE+WyFbc7FlRttbSoSOWx7iRgrqNaxDCEU5zYTt5Sd+H/5yI/wA4g2kMeJYapj
 HcJSwtgWH440WQlXRV6ugDf/dyxowq3p7ZLwPtKXXPHRMsS4TZesE86N4LcIrkiAZk1upEEOf0i
 8E7le2ugYabbxTGFaLMDD6Ci56eD7CgyjG5JxKhcKKXSsRNu/u0bZ4fcxTcFxOhOLFddq+JNVnz
 MVOa0Te8J6rxypLI11Y85Asur6NTO+rLyP4dj/Q==
X-Received: by 2002:a05:620a:4806:b0:939:6de7:8767 with SMTP id
 af79cd13be357-93980574f84mr4351845585a.46.1789026449980; 
 Thu, 10 Sep 2026 00:47:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4806:b0:939:6de7:8767 with SMTP id
 af79cd13be357-93980574f84mr4351842085a.46.1789026449472; 
 Thu, 10 Sep 2026 00:47:29 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9a20c31b0sm1096551a12.6.2026.09.10.00.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 00:47:28 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:47:27 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Icenowy Zheng <uwu@icenowy.me>,
 Matheus Ferst <matheus.ferst@eldorado.org.br>,
 Sunil V L <sunilvl@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v11 2/5] target/riscv: add riscv-server-ref CPU
Message-ID: <7jkwao2hlaqtkdi44zkvgfe6rij7rpz6dd7qqwm6gw7xmta6vp@biexkhgtrofw>
References: <20260909210756.1767711-1-daniel.barboza@oss.qualcomm.com>
 <20260909210756.1767711-3-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909210756.1767711-3-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa26093 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=PXcuKL70AAAA:8
 a=FRSEYCzRAAAA:8 a=DdpuajOAZS452ExD0-8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=xVlTc564ipvMDusKsbsT:22 a=1qLaeP4TCVy2vqIEy19U:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: TivMfv0Kd9hn8STdNwX_PPD5Fk1qO6sw
X-Proofpoint-ORIG-GUID: TivMfv0Kd9hn8STdNwX_PPD5Fk1qO6sw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4NSBTYWx0ZWRfX10UA/tbjw9yx
 57AEDhMHy1e7omKNeSmGT92XG5uHiXbH3Ss9heVCMCS3mXzHOY+r/WgM/dVqjeMbyQJ03bZqGVO
 4IUgxtLV/O9FfAa7vpLConJGUED+3zY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4NSBTYWx0ZWRfXz+GsrwKByiGb
 VfyfAma5d8E+buyDawiR6m18ttO0YUlOiyZGxuFSoionN4lAW3dmEfLrxs9o7MCH1sL6xZxCWRV
 kkOYC3nimeYXiRnyOvZy/cOCebZ1wA2E/wq8QXMccI/K8LY/oamodmhCIEiTuRtEA69N/ZKG8bs
 FDwiZhQU/5edSRwZ0SRZ5HXsvTCSNxRQTsH9QiKzTrt9ktPnOunGSbvQCF9O+SFqvh6X4vPpphx
 IakAGt0x6NXyX3T2BUiUY+kUc81OjrzDHX2Klk6HFwOjFCxF1UAM5D9RME1OwtaxTsvyCQCX7Ub
 5iAX5BVtXqte9gWwaaC8CfkhvDghDDr7C88IoFf1PpOjde1ocPpWhM3KSJ/lvH+PflyTjWoJ/ec
 g0JFI6APvJtuMsciRxQyqmovLgJYPPWcAqBZpy9aolN0z9bSE7YD3GEXvchE7eER2SpzHspicXt
 o5u5fjyhv5gVas5HqHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Wed, Sep 09, 2026 at 06:07:52PM -0300, Daniel Henrique Barboza wrote:
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
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
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
> index 773aeba8da..0b0b8e0a99 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2424,11 +2424,36 @@ static RISCVCPUProfile RVA23S64 = {
>      }
>  };
>  
> +/*
> + * This riscv-server-ref entry isn't a profile per se but its
> + * CPU definition can be modelled as a profile that extends
> + * RVA23, with additional things on top of it, and allowing
> + * future CPUs to derive from it via
> + * ".profile = &RVServerRef1_0;".
> + */
> +static RISCVCPUProfile RVServerRef1_0 = {
> +    .s_parent = &RVA23S64,
> +    .name = "riscv-server-ref-1.0",
> +    .satp_mode = VM_1_10_SV48,
> +    .ext_offsets = {
> +        CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_sdext),
> +        CPU_CFG_OFFSET(ext_sdtrig),
> +        CPU_CFG_OFFSET(ext_ssaia),
> +        CPU_CFG_OFFSET(ext_ssccfg),
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
> @@ -3766,6 +3791,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

