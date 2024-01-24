Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E6DC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 16:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSgNO-0003rS-Ok; Wed, 24 Jan 2024 11:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgNM-0003rJ-VZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:45:20 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSgNL-00057v-1v
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 11:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DBVPoln/zNzLQyEcAZuaTIVE1DqPi2lqZSlHEEq2sgE=; b=TwBnnEkNb+5LG4AsOkMsBaL+qU
 8qFupPLmVc0nAHtm1CFrdANgXlVYZRRlijdqH+HYvRXEHkL61XM5HSIoXUPvsWxLA5KH8T/XX8B6d
 nRCC5fY8jy1u0AS1z4BTQQkN+lNL0r7tQly+uGrAA7m5TW8gQhK/PaWkwyDy0vQjF0gw=;
Date: Wed, 24 Jan 2024 17:45:11 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 1/9] accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in
 meson
Message-ID: <zedvkphnumxdgq5vjjho3xtnep4qrpooobcjntanpl2i4g36gz@k7soqgbdkrkl>
References: <20240124101639.30056-1-philmd@linaro.org>
 <20240124101639.30056-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124101639.30056-2-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SCC_BODY_URI_ONLY=2.899,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/01/24, Philippe Mathieu-Daudé wrote:
> tcg_ss[] source set contains target-specific units.
> Rename it as 'tcg_specific_ss[]' for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/meson.build | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
> index 46f7d53eeb..aef80de967 100644
> --- a/accel/tcg/meson.build
> +++ b/accel/tcg/meson.build
> @@ -1,8 +1,8 @@
> -tcg_ss = ss.source_set()
>  common_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'cpu-exec-common.c',
>  ))
> -tcg_ss.add(files(
> +tcg_specific_ss = ss.source_set()
> +tcg_specific_ss.add(files(
>    'tcg-all.c',
>    'cpu-exec.c',
>    'tb-maint.c',
> @@ -11,12 +11,12 @@ tcg_ss.add(files(
>    'translate-all.c',
>    'translator.c',
>  ))
> -tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
> -tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
> +tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
> +tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
>  if get_option('plugins')
> -  tcg_ss.add(files('plugin-gen.c'))
> +  tcg_specific_ss.add(files('plugin-gen.c'))
>  endif
> -specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
> +specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
>  
>  specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
>    'cputlb.c',
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

