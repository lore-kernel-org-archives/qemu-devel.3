Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C80C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 21:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sboAN-0007Mi-CM; Wed, 07 Aug 2024 17:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sboAL-0007FM-5S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:25:53 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sboAJ-0006Gs-Mz
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 17:25:52 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cf98ba0559so269951a91.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 14:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723065950; x=1723670750;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+NtiK39PRKu5TV3cugoLOjFunL6Il1sVYisbMr+D3PI=;
 b=ZxpIuJ4TELs7c+jj1QXsflnUd9Gwl7ficCqDZFKOrbOXBsoP5chOTeJJrb4v4E/ojK
 rDVPcDkFY+nNW26UaWPHj+AIsDX+HHkK+DYG++hQwDZpVc9M5dJOvi8xuqmXQhiUtsik
 uf+ytUiHpZRy+LoqcPSIi4mu+3vTsKioeM3xSS5tQUc/006GXNy9COpSGiXiXGFGDrhG
 rOLZ/jMD8/5dSZJETW+XrF1hGbfq40vk2mBIOhgdg5cxiJUGBHdYTA5cW340L+tyPeR7
 FcSNCM3JzLpYO1zVLaDIQ6fqhZp6qBds+LYiQ8NBwu9uLVG8yULZV2HlNykR6uRMoNIW
 WGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723065950; x=1723670750;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+NtiK39PRKu5TV3cugoLOjFunL6Il1sVYisbMr+D3PI=;
 b=fCOTmIVeZQcHOp+xlMYSshdiNxmEiIVlIBqcgk5woGa0+ZZr8FW2pflfHEzwAIC6Xn
 lbbeXfLnwcaqKWxiNrFDsbQO88xWVPTZe4FF85+Ver5QBmgkEXMlIr5xfyc5DXQo3aTh
 hEGiBDFor8rLywMtZsUwOlR2yuCevCUwcw69VMY+1Ni3PUFXLsKcO+SirT8bDiEQz2aG
 TxCCuYwpoaBs3vwor7B6j/dkLSYgJlEKRT6BGvDRnaGdWkOH8smuhhPTmA5Isi4sbLr4
 tv5JOSpVEQw5syx4BFjMnduf8ysLoQDee+DLqQo8KsdjjPbnnxQJaQn05JX2EeJlQgs2
 yAZg==
X-Gm-Message-State: AOJu0YyHonR0lfYAb5IVtCSqnjZDVGkQs/gD4SGLRK10VyFJdrEcheJT
 SVh67/K4e/2QxU+QR5TW+VBHGVkPGQID4JXhSPEyTOeVRVgCGnYlc//lAerW9Ic=
X-Google-Smtp-Source: AGHT+IG4VBMMMkHVCIsDHgj3vFh1zNGK25ly+a0ECrLxZRa4JWijhVstTHJme7lxWcPyQyVPZQFJkQ==
X-Received: by 2002:a17:90a:e00a:b0:2d1:bf4b:4a6d with SMTP id
 98e67ed59e1d1-2d1bf4b4b7dmr309289a91.1.1723065950007; 
 Wed, 07 Aug 2024 14:25:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b36dd55csm2068242a91.29.2024.08.07.14.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 14:25:49 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:25:47 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 12/20] target/riscv: implement zicfiss instructions
Message-ID: <ZrPmW3VvOiRObRfk@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-13-debug@rivosinc.com>
 <199f7ee2-411c-48ec-bf69-34fceab8f48a@linaro.org>
 <26d1f8a7-9131-40f2-8d3a-e1daabad149b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26d1f8a7-9131-40f2-8d3a-e1daabad149b@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 12:56:46PM +1000, Richard Henderson wrote:
>On 8/7/24 12:39, Richard Henderson wrote:
>>>+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>>>+{
>>>+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
>>>+    int ss_mmu_idx = 0;
>>
>>This can't be right, since 0 is M_MODE.
>
>I'm wrong about m-mode here, but "0" is certainly not right.

I followed `riscv_env_mmu_index` here. If CONFIG_USER_ONLY, it returns 0.
For qemu-user, I didn't bother to protect shadow stack from normal stores.
And simply used index 0.

>
>I strongly suspect you want "ctx->mem_idx | MMU_IDX_SS_ACCESS",
>once you add that bit in a few patches.
>
>
>r~

