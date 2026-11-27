Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A0606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=utBGglBk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=cCWTAr/Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=/jWbCUSFaITpYbtoQ7Fp34oCAAJQ+ponPQbBiEO4Gi4=; b=utBGglBkJUR28pSwFHD+
	MdUwUE9PZhjbmGQ4yCTjW6vvg1bXb4CB9W7LLIn2t7T+PLQW4CMUgCOa5VB1dfrfyCxFb4xgdCAhP
	agt6lyELaG1c3yh/qARFeisGbG3AMpBnHvqtJDZNcG4NlKzCrr+JY2ymGzWjJXrFhlLULDFgbxv6y
	QCOszGtA9fv45XDlQ1C+2oL6vdxEASHuxNfzbPQ/0cA1nwfP8hM27cKLK2RVnJhTr8ECA1FcBJZUw
	qgIuWgPaXUT2PSmRAVG4uxNfjgYX07sGMbkjN+Rcyz2kSrojMcivbge6NRRzg+RgK/8ZrTzxtp1j1
	IfklDvkw7t71oA==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtpl-0001ZR-Ab; Fri, 27 Nov 2026 06:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtpj-0001Z6-Bm; Fri, 27 Nov 2026 06:09:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtph-0008UK-ST; Fri, 27 Nov 2026 06:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/jWbCUSFaITpYbtoQ7Fp34oCAAJQ+ponPQbBiEO4Gi4=; b=cCWTAr/ZTIn5zIb
 7G6JCjeYvDA0wXfpyJcHbyBImDRBzC7jCuqZqdcXbHMcfUblZKaaNfG+ig/Emp7BqpWY+HbZJnt+2
 XuyvzzyYDB1EHkGHK6Ocamb1ZMgMcaSjFotomWY+y0ME74PloLSII3GfkqUPRAbe2Drlp6hNcuofR
 R8=;
Date: Fri, 27 Nov 2026 12:16:01 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>, 
 Xianglai Li <lixianglai@loongson.cn>
Subject: Re: [PATCH 10/24] target/loongarch: Use 64-bit TB flags
Message-ID: <awlmKtpoPIEltn0g@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-11-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-11-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/loongarch/tcg/tcg_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 0549506035f3..743b682f1fb0 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -236,7 +236,7 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>  {
>      CPULoongArchState *env = cpu_env(cs);
>      CPUSysState *sys = env_sys(env);
> -    uint32_t flags;
> +    uint64_t flags;
>  
>      flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
>      flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

