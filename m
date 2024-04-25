Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 18:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s04CJ-0005Zf-6n; Thu, 25 Apr 2024 14:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s04CH-0005Z2-Cr
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:51:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s04BO-0000ZW-9T
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:51:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C573F21F7D;
 Thu, 25 Apr 2024 18:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714071054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxlOqw04fFyuhI5FziqB8n3lQ5kQGq5MopTCkZEfdiI=;
 b=Off+hcrzxAIzDKDrYjSwogQa6fZEg6A41n7lY93HE8N4KqqYxWGQ1O+A7sMfbCMhcyNr1C
 VwN6awiHoD57qkeQeu3Je2FXa8PVo8Zp6p8rGT6pwCSfexEkD+5J8j9lt3cpfId2HV9BDS
 MBB1wi+nIQBqz66xkd0SD65LKdCSgJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714071054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxlOqw04fFyuhI5FziqB8n3lQ5kQGq5MopTCkZEfdiI=;
 b=AceWdqdpwal0ko980cSOYLu4ZxWm+6wGuBy6F6WFcseqV5zczf7eU8VybECC3hSwnwtl3+
 /caXFOFhHGf24GBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AzVFsBb3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FE6nJ0+B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714071053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxlOqw04fFyuhI5FziqB8n3lQ5kQGq5MopTCkZEfdiI=;
 b=AzVFsBb3luhyXLMMQBfVuTUIV9aSqbibMG5/IycqYsZAvyqt5ksXj83fqyAppQvDB8Wt4r
 R1lm2PtNdBYH/EZAh677nNfhnCjwwbjCnd8iWAuW23xiihvkZEU4teqnUCqIYRqsg+fVUe
 B8ut0JdDJzz2YQGNWgM4astiTC+bgS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714071053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxlOqw04fFyuhI5FziqB8n3lQ5kQGq5MopTCkZEfdiI=;
 b=FE6nJ0+BbxT/Ey1/wQemME22IC3IAQMEVjJI32wiSl2kfi0oCv+i2HBryJpjzvpFkFQ2Y+
 Y5T84TVD3RS3HNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52B7113991;
 Thu, 25 Apr 2024 18:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LSv2Bg2mKmY3SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 25 Apr 2024 18:50:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@linux.dev>, marcandre.lureau@redhat.com,
 peterx@redhat.com, armbru@redhat.com, lvivier@redhat.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@linux.dev>
Subject: Re: [PATCH v4 01/14] meson: Introduce new instruction set enqcmd to
 the build system.
In-Reply-To: <20240425022117.4035031-2-hao.xiang@linux.dev>
References: <20240425022117.4035031-1-hao.xiang@linux.dev>
 <20240425022117.4035031-2-hao.xiang@linux.dev>
Date: Thu, 25 Apr 2024 15:50:50 -0300
Message-ID: <875xw5i8dx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C573F21F7D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,linux.dev:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hao Xiang <hao.xiang@linux.dev> writes:

> Enable instruction set enqcmd in build.
>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> ---
>  meson.build                   | 14 ++++++++++++++
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  3 files changed, 19 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index 95cee7046e..9e008ddc34 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2824,6 +2824,20 @@ config_host_data.set('CONFIG_AVX512BW_OPT', get_option('avx512bw') \
>      int main(int argc, char *argv[]) { return bar(argv[0]); }
>    '''), error_message: 'AVX512BW not available').allowed())
>  
> +config_host_data.set('CONFIG_DSA_OPT', get_option('enqcmd') \
> +  .require(have_cpuid_h, error_message: 'cpuid.h not available, cannot enable ENQCMD') \
> +  .require(cc.links('''
> +    #include <stdint.h>
> +    #include <cpuid.h>
> +    #include <immintrin.h>
> +    static int __attribute__((target("enqcmd"))) bar(void *a) {
> +      uint64_t dst[8] = { 0 };
> +      uint64_t src[8] = { 0 };
> +      return _enqcmd(dst, src);
> +    }
> +    int main(int argc, char *argv[]) { return bar(argv[argc - 1]); }
> +  '''), error_message: 'ENQCMD not available').allowed())
> +
>  # For both AArch64 and AArch32, detect if builtins are available.
>  config_host_data.set('CONFIG_ARM_AES_BUILTIN', cc.compiles('''
>      #include <arm_neon.h>
> diff --git a/meson_options.txt b/meson_options.txt
> index b5c0bad9e7..63c1bf815b 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -121,6 +121,8 @@ option('avx512f', type: 'feature', value: 'disabled',
>         description: 'AVX512F optimizations')
>  option('avx512bw', type: 'feature', value: 'auto',
>         description: 'AVX512BW optimizations')
> +option('enqcmd', type: 'feature', value: 'disabled',
> +       description: 'MENQCMD optimizations')

s/MENQCMD/ENQCMD/

>  option('keyring', type: 'feature', value: 'auto',
>         description: 'Linux keyring support')
>  option('libkeyutils', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 5ace33f167..2cdfc84455 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -93,6 +93,7 @@ meson_options_help() {
>    printf "%s\n" '  avx2            AVX2 optimizations'
>    printf "%s\n" '  avx512bw        AVX512BW optimizations'
>    printf "%s\n" '  avx512f         AVX512F optimizations'
> +  printf "%s\n" '  enqcmd          ENQCMD optimizations'
>    printf "%s\n" '  blkio           libblkio block device driver'
>    printf "%s\n" '  bochs           bochs image format support'
>    printf "%s\n" '  bpf             eBPF support'
> @@ -239,6 +240,8 @@ _meson_option_parse() {
>      --disable-avx512bw) printf "%s" -Davx512bw=disabled ;;
>      --enable-avx512f) printf "%s" -Davx512f=enabled ;;
>      --disable-avx512f) printf "%s" -Davx512f=disabled ;;
> +    --enable-enqcmd) printf "%s" -Denqcmd=enabled ;;
> +    --disable-enqcmd) printf "%s" -Denqcmd=disabled ;;
>      --enable-gcov) printf "%s" -Db_coverage=true ;;
>      --disable-gcov) printf "%s" -Db_coverage=false ;;
>      --enable-lto) printf "%s" -Db_lto=true ;;

