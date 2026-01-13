Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAFBC9EC9D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 10:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfbRZ-0006lF-RX; Tue, 13 Jan 2026 05:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfbRO-0006iv-9a
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:15:58 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vfbRM-0000Vz-Q7
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=TgRMDU5IIGQuBxCVxWJAQ/VBR7GcJ9hqNmiA4rEDJXc=; b=kQLGvAkLatuNNUh
 yyzMrH2QPOoiq/kDum7A/oaS/V7n9sw8QeP0ISf00mEx1uDg3sWMCGU4lK0En1+z/NDkHhpZJARML
 0iDBx/jYtvxcTlRV2Sic7eqAEV3IJgiqVe0tQY0FdtsrJrlQNUaz1EqyItZuzhQt2B/PMNDuCTIGy
 5c=;
Date: Tue, 13 Jan 2026 11:19:24 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 5/7] target/xtensa: Build 'xtensa-isa.c' in common source
 set
Message-ID: <ao2kxrolsei5vmbkelg7pcf6dxew66i2izp62ubyikqwnv6mxv@kvdwikpwzoej>
References: <20260107202556.55787-1-philmd@linaro.org>
 <20260107202556.55787-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107202556.55787-6-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 07/01/26, Philippe Mathieu-Daudé wrote:
> 'xtensa-isa.c' is now free of target-specific symbols,
> build it as common files (thus forbidding further
> uses of such target-specific symbols).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/xtensa/meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/xtensa/meson.build b/target/xtensa/meson.build
> index 69c6946420a..3fdb20db655 100644
> --- a/target/xtensa/meson.build
> +++ b/target/xtensa/meson.build
> @@ -12,6 +12,10 @@ xtensa_ss.add(files(
>    'op_helper.c',
>    'translate.c',
>    'win_helper.c',
> +))
> +
> +xtensa_common_ss = ss.source_set()
> +xtensa_common_ss.add(files(
>    'xtensa-isa.c',
>  ))
>  
> @@ -24,4 +28,5 @@ xtensa_system_ss.add(files(
>  ))
>  
>  target_arch += {'xtensa': xtensa_ss}
> +target_common_arch += {'xtensa': xtensa_common_ss}
>  target_common_system_arch += {'xtensa': xtensa_system_ss}
> -- 
> 2.52.0
> 

Mentioned this in the 7th patch, but xtensa-isa.h is strange to me,
why not move hw/xtensa/xtensa-isa.h to target/ and drop the current
one-line target/xtensa/xtensa-isa.h file? Also include with "target/".

Otherwise,

Reviewed-by: Anton Johansson <anjo@rev.ng>

