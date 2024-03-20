Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C7BC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn2Jr-00020f-VQ; Wed, 20 Mar 2024 16:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2Jn-0001zD-SD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:13:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rn2Jl-0006Gd-4r
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 16:13:47 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e6c0098328so268845b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710965624; x=1711570424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XRv7DiKvRrwz0cItyDcpLdPVrg1l5NvKslY6SkA3Ts8=;
 b=JUOp7whqBe3d3ZFTscd7ZMRNCoNAYBFi60bbVIUkpXQuzgWsO2UkESG2DlCpqLIrQW
 g9ATzi6d+ppvXY1RzGy4ZmJSrCC79SGm21pYJzfEkQquUutcylHDfne0t2+EGt00+ZG0
 5JN5oCtea/jJs0c89u8nRe+2/LWpJEmso0lAsJORJhmL38BJgHlkJinzo1lcfYucEnKB
 x1fxzBtIBtxHEdQ/YfahOGsdSMGNATm7LZX3Ni9tBi9cYtMssxb9igU9CowpYz52g8l7
 Lo/L1iP4/yrhRuuGTodcWnYkGcU7j9v3e8HvgNDpSUr5c8YDcMtnNM0qd+kOiMfNGhp5
 BGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710965624; x=1711570424;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XRv7DiKvRrwz0cItyDcpLdPVrg1l5NvKslY6SkA3Ts8=;
 b=BBbBEl8EWFCcu4s/VSUqLE4/X6z1+txBrw0Vs9/YabZmKoLLVA3DcGsI6WlIzhCp+b
 Vhwb3SyxA7XCWXM4UgWlNmMd/rB3wSCuoyQwDT7ogeY3I68VGCt874dpDMkFz0RvrS9U
 q5wwcHI/1KjLz8pdac3h3afxLy+kP74rOIkvOJfd6wNZnzgFu5zkUTz2MyKvECrKKU8a
 vSWbznCXRPvt536nIpFp1qM9zkvAayAcdr0tL5Z0QynqXlDFp01dpurg3X6B2x58Ou99
 SnzzV47J8dMcaJ903TB7kZft5v0WZTiS74NDIYX2Lpen5huVhH26FsNSuupKFs/l4/t/
 XstA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHg3jM70ESoZj9D8MZF+RhhV44Wxyj11XzuLBgF9LWjIpJ/fU66w2vjr4efbSpLY+BA41yZaGN6BU5ec18KTGYQAQ5ATA=
X-Gm-Message-State: AOJu0YyKECLITbcDA2V5FGnPwjMbWDRRJs+p8+VioejYY/y79u8CHRXv
 kZ4GVXNneGTrIY921Gx+e2UAUnHJ1OIqKSJW8d7+apiTFeadBhqb8nyS7VBKeF4=
X-Google-Smtp-Source: AGHT+IFVU75DHHzep1/AK6VXYJhk5fCMfZD2hV3vS3I1wpnaoN4Uh2NVqLs0QVh+S5H+/ZfhK0oOiQ==
X-Received: by 2002:a05:6a20:8f01:b0:1a3:6f69:d9f3 with SMTP id
 b1-20020a056a208f0100b001a36f69d9f3mr3264108pzk.61.1710965623790; 
 Wed, 20 Mar 2024 13:13:43 -0700 (PDT)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a62e908000000b006e731b44241sm5360312pfh.42.2024.03.20.13.13.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 13:13:43 -0700 (PDT)
Message-ID: <d75b8950-fdd9-4717-aff7-c3a5f847428a@ventanamicro.com>
Date: Wed, 20 Mar 2024 17:13:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Check single width operator for vector
 fp widen instructions
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240320072709.1043227-1-max.chou@sifive.com>
 <20240320072709.1043227-3-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240320072709.1043227-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/20/24 04:25, Max Chou wrote:
> The require_scale_rvf function only checks the double width operator for
> the vector floating point widen instructions, so most of the widen
> checking functions need to add require_rvf for single width operator.
> 
> The vfwcvt.f.x.v and vfwcvt.f.xu.v instructions convert single width
> integer to double width float, so the opfxv_widen_check function doesn’t
> need require_rvf for the single width operator(integer).
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index ef568e263d..6cb9bc9fde 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -2331,6 +2331,7 @@ GEN_OPFVF_TRANS(vfrsub_vf,  opfvf_check)
>   static bool opfvv_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8) &&
>              vext_check_isa_ill(s) &&
> @@ -2370,6 +2371,7 @@ GEN_OPFVV_WIDEN_TRANS(vfwsub_vv, opfvv_widen_check)
>   static bool opfvf_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8) &&
>              vext_check_isa_ill(s) &&
> @@ -2402,6 +2404,7 @@ GEN_OPFVF_WIDEN_TRANS(vfwsub_vf)
>   static bool opfwv_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8) &&
>              vext_check_isa_ill(s) &&
> @@ -2441,6 +2444,7 @@ GEN_OPFWV_WIDEN_TRANS(vfwsub_wv)
>   static bool opfwf_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8) &&
>              vext_check_isa_ill(s) &&
> @@ -2941,6 +2945,7 @@ GEN_OPFVV_TRANS(vfredmin_vs, freduction_check)
>   static bool freduction_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return reduction_widen_check(s, a) &&
> +           require_rvf(s) &&
>              require_scale_rvf(s) &&
>              (s->sew != MO_8);
>   }

