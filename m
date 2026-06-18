Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7721FCD98DE
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5Eq-0001rm-OL; Thu, 18 Jun 2026 01:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Eo-0001rQ-Vp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:27 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wa5Em-0006vg-AE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:24:26 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65I5NgWF053532
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 18 Jun 2026 14:23:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=j4WzgIsErxCqAmmKGya2k5MwOeVD3eT9Jmi9R6j0YOw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781760223; v=1;
 b=wSVFJjIAaXOXAuRI301Pn750s3X7xagFu6T1yIk1nfYRK3rI9zVQJwpexcWZIODQ
 4Gc3hUJE8YeIiHJq3amurcF9PO1AqX+POyFfDgGQ5xsDSmNKGaE7fShtEAwZ405x
 exw3xVoWFBREMRrcS4wLcoLziKPmp1QEIgN1EYKca7F2A0uTSeH19Vbadmi3BwS1
 MppYmhndavKhguH9ouZ7Lv2ow4D3kGBhUxLxV4m3/Qe0w38YWEAYI+ZQIqvuDG3P
 PU2u78lFy0O6BjX9oQlQx5oueyTZoPEBmT7x2oc1IotWvQt0Cn7Qds1mLT2uely6
 hwlVL01QIgHhiB7nU8a9yQ==
Message-ID: <2c41e21f-bc59-41b5-a449-082dbdd1a2ca@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 18 Jun 2026 14:23:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] meson: add --enable-deprecations configure flag
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-2-berrange@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260616155554.264412-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/17 0:55, Daniel P. Berrangé wrote:
> A challenge with QEMU is that internal APIs get obsoleted but chasing
> down use of old APIs is not as simple as it should be. Introduce a
> --enable-deprecations configure flag which expands the macro
> "QEMU_DEPRECATIONS" into "G_GNUC_DEPRECATED". This will trigger a
> compiler warning for any use of the deprecated APIs.
> 
> It would generally be a good idea to disable -Werror when turning on
> deprecations otherwise the build will quickly abort.
> 
> 
> XXX: possibly add  -Wno-error=deprecated-declarations, so we have
> show deprecations by default despite -Werror being on by default.
> This would trigger very many warnings but might be worth it if we
> want to strongly nudge maintainers to convert existing code. Our
> historical approach of "hope" has never worked to eliminate old
> code patterns.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qemu/osdep.h          | 19 +++++++++++++++++++
>   meson.build                   |  1 +
>   meson_options.txt             |  2 ++
>   scripts/meson-buildoptions.sh |  3 +++
>   4 files changed, 25 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 2f0e61ad6b..99b8f9cbb7 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -447,6 +447,25 @@ void QEMU_ERROR("code path is reachable")
>           ((void)0))
>   #endif
>   
> +/*
> + * Tag an internal APIs which should no longer be used
> + * to emit a warning during build if --enable-deprecations
> + * is used with configure. Use of -Werror will trigger
> + * immediate build failure if this is used.
> + */
> +#ifdef CONFIG_DEPRECATIONS
> +# define QEMU_DEPRECATED G_GNUC_DEPRECATED
> +# define QEMU_DEPRECATIONS_OFF \
> +    _Pragma("GCC diagnostic push") \
> +    _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
> +# define QEMU_DEPRECATIONS_ON \
> +    _Pragma("GCC diagnostic pop")
> +#else
> +# define QEMU_DEPRECATED
> +# define QEMU_DEPRECATIONS_OFF
> +# define QEMU_DEPRECATIONS_ON
> +#endif
> +
>   /*
>    * Minimum function that returns zero only if both values are zero.
>    * Intended for use with unsigned values only.
> diff --git a/meson.build b/meson.build
> index 19e123423b..9e863aa897 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2567,6 +2567,7 @@ config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage')
>   config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
>   config_host_data.set('CONFIG_DEBUG_REMAP', get_option('debug_remap'))
>   config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
> +config_host_data.set('CONFIG_DEPRECATIONS', get_option('deprecations'))
>   config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
>   config_host_data.set('CONFIG_FSFREEZE', qga_fsfreeze)
>   config_host_data.set('CONFIG_FSTRIM', qga_fstrim)
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..8f5924422d 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -367,6 +367,8 @@ option('qom_cast_debug', type: 'boolean', value: true,
>          description: 'cast debugging support')
>   option('slirp_smbd', type : 'feature', value : 'auto',
>          description: 'use smbd (at path --smbd=*) in slirp networking')
> +option('deprecations', type: 'boolean', value: true,
> +       description: 'enable internal API deprecation warnings')

A build with the default settings will fail because both werror and 
deprecations are enabled by default.

>   
>   option('qemu_ga_manufacturer', type: 'string', value: 'QEMU',
>          description: '"manufacturer" name for qemu-ga registry entries')
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index c003985047..fb57f0610d 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -13,6 +13,7 @@ meson_options_help() {
>     printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
>     printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
>     printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
> +  printf "%s\n" '  --disable-deprecations   enable internal API deprecation warnings'

The help text is inverted: it says --disable-deprecations will enable 
warnings.

Those said, I think the approach to modify checkpatch discussed in 
another thread is better.

Regards,
Akihiko Odaki

>     printf "%s\n" '  --disable-hexagon-idef-parser'
>     printf "%s\n" '                           use idef-parser to automatically generate TCG'
>     printf "%s\n" '                           code for the Hexagon frontend'
> @@ -306,6 +307,8 @@ _meson_option_parse() {
>       --disable-debug-stack-usage) printf "%s" -Ddebug_stack_usage=false ;;
>       --enable-debug-tcg) printf "%s" -Ddebug_tcg=true ;;
>       --disable-debug-tcg) printf "%s" -Ddebug_tcg=false ;;
> +    --enable-deprecations) printf "%s" -Ddeprecations=true ;;
> +    --disable-deprecations) printf "%s" -Ddeprecations=false ;;
>       --enable-dmg) printf "%s" -Ddmg=enabled ;;
>       --disable-dmg) printf "%s" -Ddmg=disabled ;;
>       --docdir=*) quote_sh "-Ddocdir=$2" ;;


