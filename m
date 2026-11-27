Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF91606A686
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=E6mPtncr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=JsouJ7rO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=HAUQ6pbBSUBoEs1lgve5pL3R7Njw6Z0m6VicrKtJxqQ=; b=E6mPtncrqZc9+dd82By8
	ApsT8hkfI01FvBU3IfTOwoLi3xS2xbOqns9x2LSaSZnmdTK6GKXwSzBEAnqRkzujXBMTwvP65dxpB
	nSyynp9VS9HchOuXcidrDLO9+zOMugJhxH6PublpStf2mChfbjRXFZjaNaNhoP06dqg/3C42r7u4L
	Rk2HsvCuzDaXJc6WTjt/ydXc5aJM+fFTm7G9zfvgGVMalLG0vGwSkiGDtnfiJWjcaKsuIDfnFUbkD
	0TwlXMHSD3EXy5v/FLjGBltzDqfmBANMuCqSWJEJYcTD1Tvf1htd1AvFSNRd9EO++BE2Q0N4xjrqO
	LwDvPhDBwNqFcQ==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWsdt-0006IA-Dd; Fri, 27 Nov 2026 04:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWsdp-0006H9-QX; Fri, 27 Nov 2026 04:53:19 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWsdo-0008Vs-GQ; Fri, 27 Nov 2026 04:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HAUQ6pbBSUBoEs1lgve5pL3R7Njw6Z0m6VicrKtJxqQ=; b=JsouJ7rOD3SCpPM
 4UEbpGqKjBHsUCKah47cmlI2i3x/2pFZGaYOBY7fig5i+f1y/rhJut/0Fh7cIF4Yh3NmsIpE+2d7Z
 C0O8ScaUG6roHPmQl++nheMtno+nSSanXsSx5jxHYv3IWEyrUS7X5eON4laR1J5yPxPCEGiLkNYMp
 xY=;
Date: Fri, 27 Nov 2026 10:59:39 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 02/24] accel/tcg: Update stale TranslationBlock::jmp_lock
 comment
Message-ID: <awlUfubmBjdtwEac@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-3-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-3-philmd@oss.qualcomm.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> jmp_lock was placed to fill a 4-byte hole, but commit 9da6079b2695
> ("tcg: Add TranslationBlock.jmp_insn_offset") added jmp_insn_offset[],
> so jmp_lock, jmp_reset_offset[] and jmp_insn_offset[] now take 12
> bytes, leaving a 4-byte hole after jmp_insn_offset.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  include/exec/translation-block.h | 6 +++++-

Reviewed-by: Anton Johansson <anjo@rev.ng>

