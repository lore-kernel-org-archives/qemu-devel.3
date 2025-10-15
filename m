Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1FCCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 08:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wmm-0007ul-8k; Wed, 15 Oct 2025 04:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8wmj-0007pr-A6
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8wmW-0000Gx-8G
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760516563;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWqpco4/DqPpHVIeYvc+HVLRNxEi1+W/EnZ9h/CV+xs=;
 b=eMi6pKWsaBIq9QkdNB7761naSaUgP4naIq/Lbcc2JYZX4WmQ6qmm0Zr6gwgOJlHiZ8RfP3
 Bd9FtonletT2cLOzKQ9CEXkmnAlRcSIBE8yqhTyXDf9df9DBIapM7un4vWABYimVoG7xrr
 okGSGa7I6l60r6swBT/jEgkTLrXXmcc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-SVWP-E67ME6GZSkcEQbLCw-1; Wed,
 15 Oct 2025 04:22:37 -0400
X-MC-Unique: SVWP-E67ME6GZSkcEQbLCw-1
X-Mimecast-MFC-AGG-ID: SVWP-E67ME6GZSkcEQbLCw_1760516556
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F7861956080; Wed, 15 Oct 2025 08:22:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 793BD30001A1; Wed, 15 Oct 2025 08:22:33 +0000 (UTC)
Date: Wed, 15 Oct 2025 09:22:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] RFC: audio: deprecate HMP audio commands
Message-ID: <aO9ZxvtMYd3CKzsO@redhat.com>
References: <20251015073559.2799165-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251015073559.2799165-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 15, 2025 at 11:35:59AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The command is niche and better served by the host audio system.
> There is no QMP equivalent, fortunately. You can capture the audio
> stream via remote desktop protocols too (dbus, vnc, spice).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/about/deprecated.rst     | 20 ++++++++++++++++++++
>  meson.build                   |  9 +++++++++
>  audio/meson.build             |  7 +++++--
>  hmp-commands-info.hx          |  2 ++
>  hmp-commands.hx               |  4 +++-
>  meson_options.txt             |  3 +++
>  scripts/meson-buildoptions.sh |  3 +++
>  7 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 98361f5832..a357f207cf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -169,6 +169,26 @@ Use ``job-finalize`` instead.
>  
>  This argument has always been ignored.
>  
> +Human Machine Protocol (HMP) commands
> +-------------------------------------
> +
> +``wavcapture`` (since 10.2)
> +''''''''''''''''''''''''''''
> +
> +The ``wavcapture`` command is deprecated and will be removed in a future release.
> +
> +Use ``-audiodev wav`` or your host audio system to capture audio.
> +
> +``stopcapture`` (since 10.2)
> +''''''''''''''''''''''''''''
> +
> +The ``stopcapture`` command is deprecated and will be removed in a future release.
> +
> +``info`` argument ``capture`` (since 10.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``info capture`` command is deprecated and will be removed in a future release.
> +
>  Host Architectures
>  ------------------
>  
> diff --git a/meson.build b/meson.build
> index afaefa0172..0a2401e11e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2354,6 +2354,7 @@ endif
>  config_host_data = configuration_data()
>  
>  config_host_data.set('CONFIG_HAVE_RUST', have_rust)
> +config_host_data.set('CONFIG_AUDIO_HMP', get_option('audio_hmp'))
>  audio_drivers_selected = []
>  if have_system
>    audio_drivers_available = {
> @@ -5105,3 +5106,11 @@ if not actually_reloc and (host_os == 'windows' or get_option('relocatable'))
>    message('QEMU will have to be installed under ' + get_option('prefix') + '.')
>    message('Use --disable-relocatable to remove this warning.')
>  endif
> +
> +if get_option('audio_hmp')
> +  message()
> +  warning('DEPRECATED HMP audio commands')
> +  message()
> +  message('If you want to keep supporting this command, please')
> +  message('contact the developers at qemu-devel@nongnu.org.')
> +endif
> diff --git a/audio/meson.build b/audio/meson.build
> index 59f0a431d5..ca2ef2a8f3 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -1,12 +1,15 @@
>  system_ss.add([spice_headers, files('audio.c')])
>  system_ss.add(files(
> -  'audio-hmp-cmds.c',
> +  'audio.c',
>    'mixeng.c',
>    'noaudio.c',
>    'wavaudio.c',
> -  'wavcapture.c',
>  ))
>  
> +if get_option('audio_hmp')
> +  system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
> +endif
> +
>  system_ss.add(when: coreaudio, if_true: files('coreaudio.m'))
>  system_ss.add(when: dsound, if_true: files('dsoundaudio.c', 'audio_win_int.c'))
>  
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 25b4aed51f..59f3446224 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -363,6 +363,7 @@ SRST
>      Show host USB devices.
>  ERST
>  
> +#ifdef CONFIG_AUDIO_HMP
>      {
>          .name       = "capture",
>          .args_type  = "",
> @@ -375,6 +376,7 @@ SRST
>    ``info capture``
>      Show capture information.
>  ERST
> +#endif
>  
>      {
>          .name       = "snapshots",
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 15f6082596..414e2d2d1e 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -764,6 +764,7 @@ SRST
>  
>  ERST
>  
> +#ifdef CONFIG_AUDIO_HMP
>      {
>          .name       = "wavcapture",
>          .args_type  = "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?",
> @@ -798,6 +799,7 @@ SRST
>      info capture
>  
>  ERST
> +#endif
>  
>      {
>          .name       = "memsave",
> @@ -1090,7 +1092,7 @@ ERST
>  
>  SRST
>  ``dump-guest-memory [-p]`` *filename* *begin* *length*
> -  \ 
> +  \
>  ``dump-guest-memory [-z|-l|-s|-w]`` *filename*
>    Dump guest memory to *protocol*. The file can be processed with crash or
>    gdb. Without ``-z|-l|-s|-w``, the dump format is ELF.
> diff --git a/meson_options.txt b/meson_options.txt
> index 2836156257..d0fa75f1cf 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -39,6 +39,9 @@ option('coroutine_backend', type: 'combo',
>  option('gdb', type: 'string', value: '',
>         description: 'Path to GDB')
>  
> +option('audio_hmp', type: 'boolean', value: true,
> +       description: 'enable HMP commands for audio', deprecated: true)
> +
>  # Everything else can be set via --enable/--disable-* option
>  # on the configure script command line.  After adding an option
>  # here make sure to run "make update-buildoptions".
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 3d0d132344..44ef7900f0 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -11,6 +11,7 @@ meson_options_help() {
>    printf "%s\n" '                           set block driver read-write whitelist (by default'
>    printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
>    printf "%s\n" '  --datadir=VALUE          Data file directory [share]'
> +  printf "%s\n" '  --disable-audio-hmp      enable HMP commands for audio'
>    printf "%s\n" '  --disable-coroutine-pool coroutine freelist (better performance)'
>    printf "%s\n" '  --disable-debug-info     Enable debug symbols and other information'
>    printf "%s\n" '  --disable-hexagon-idef-parser'
> @@ -244,6 +245,8 @@ _meson_option_parse() {
>      --enable-attr) printf "%s" -Dattr=enabled ;;
>      --disable-attr) printf "%s" -Dattr=disabled ;;
>      --audio-drv-list=*) quote_sh "-Daudio_drv_list=$2" ;;
> +    --enable-audio-hmp) printf "%s" -Daudio_hmp=true ;;
> +    --disable-audio-hmp) printf "%s" -Daudio_hmp=false ;;
>      --enable-auth-pam) printf "%s" -Dauth_pam=enabled ;;
>      --disable-auth-pam) printf "%s" -Dauth_pam=disabled ;;
>      --enable-gcov) printf "%s" -Db_coverage=true ;;

Adding build time options to disable functionality is not the way we handle
deprecation in QEMU.

This should update deprecated.rst and then change the impl of the HMP
commands so that they print a warning (once only) when invoked.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


