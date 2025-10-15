Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD5DCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91Up-0000Uy-JH; Wed, 15 Oct 2025 09:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v91Ub-0000Ji-D0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:24:37 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1v91UU-0003Qr-3F
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=eSIsQT3zGPtkzbH2Vj3vQLJ1uU76XbGJhgS3rx2A1Ks=; b=OQy+55qgsXVq/5fq
 gKOXMeEMlMfnH2Hhpvg4dogBpXKRhabyFe4GZkC4xphf/eu8P/2K+fTT1DqrxFLSYpEORUXyCDa2P
 AGMV3YQ68WpOi9/cGD73b4vzvLva2/VKNB0Lo5Ax+ekiMPffGXxzB497HyLgjYs26InNXSXSaQSw9
 m6mlKyYfUQ+Ij4DUYtehBMP/dfUrrfwdZiGrcpIp4xnr9iwAlFULATVZuESR4afUgaBM+NlbfOYM0
 A11whiXXGOmgxYjWQhcynz/sUvM1ojUVEpYhOC2raTVHOy8JzJ3FJ4VBsy4RKZtPlYL6gPYsnBSI1
 ZaGj+VKJmI0AnyBazw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1v91UK-00GbU9-0Q;
 Wed, 15 Oct 2025 13:24:20 +0000
Date: Wed, 15 Oct 2025 13:24:20 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 "reviewer:Incompatible changes" <devel@lists.libvirt.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] RFC: audio: deprecate HMP audio commands
Message-ID: <aO-ghGojbKm8wrFS@gallifrey>
References: <20251015092851.2850617-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251015092851.2850617-1-marcandre.lureau@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:23:10 up 170 days, 21:36,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* marcandre.lureau@redhat.com (marcandre.lureau@redhat.com) wrote:
> From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> The command is niche and better served by the host audio system.
> There is no QMP equivalent, fortunately. You can capture the audio
> stream via remote desktop protocols too (dbus, vnc, spice).
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

=46rom the HMP side I'm happy with the deprecation, you're right
it's pretty obscure and it's easy enough to do from the host.

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

Dave

> ---
>  docs/about/deprecated.rst | 20 ++++++++++++++++++++
>  meson.build               |  4 ++++
>  audio/audio-hmp-cmds.c    |  7 +++++++
>  audio/meson.build         |  5 +++--
>  hmp-commands-info.hx      |  2 ++
>  hmp-commands.hx           |  2 ++
>  6 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 98361f5832..a357f207cf 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -169,6 +169,26 @@ Use ``job-finalize`` instead.
> =20
>  This argument has always been ignored.
> =20
> +Human Machine Protocol (HMP) commands
> +-------------------------------------
> +
> +``wavcapture`` (since 10.2)
> +''''''''''''''''''''''''''''
> +
> +The ``wavcapture`` command is deprecated and will be removed in a future=
 release.
> +
> +Use ``-audiodev wav`` or your host audio system to capture audio.
> +
> +``stopcapture`` (since 10.2)
> +''''''''''''''''''''''''''''
> +
> +The ``stopcapture`` command is deprecated and will be removed in a futur=
e release.
> +
> +``info`` argument ``capture`` (since 10.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``info capture`` command is deprecated and will be removed in a futu=
re release.
> +
>  Host Architectures
>  ------------------
> =20
> diff --git a/meson.build b/meson.build
> index afaefa0172..a4d8e33132 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2354,6 +2354,10 @@ endif
>  config_host_data =3D configuration_data()
> =20
>  config_host_data.set('CONFIG_HAVE_RUST', have_rust)
> +
> +# HMP code deprecated since v10.2, to be removed
> +config_host_data.set('CONFIG_AUDIO_HMP', true)
> +
>  audio_drivers_selected =3D []
>  if have_system
>    audio_drivers_available =3D {
> diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
> index 8774c09f18..9129a02331 100644
> --- a/audio/audio-hmp-cmds.c
> +++ b/audio/audio-hmp-cmds.c
> @@ -28,6 +28,7 @@
>  #include "monitor/monitor.h"
>  #include "qapi/error.h"
>  #include "qobject/qdict.h"
> +#include "qemu/error-report.h"
> =20
>  static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
> =20
> @@ -36,6 +37,8 @@ void hmp_info_capture(Monitor *mon, const QDict *qdict)
>      int i;
>      CaptureState *s;
> =20
> +    warn_report_once("'info capture' is deprecated since v10.2, to be re=
moved");
> +
>      for (s =3D capture_head.lh_first, i =3D 0; s; s =3D s->entries.le_ne=
xt, ++i) {
>          monitor_printf(mon, "[%d]: ", i);
>          s->ops.info (s->opaque);
> @@ -48,6 +51,8 @@ void hmp_stopcapture(Monitor *mon, const QDict *qdict)
>      int n =3D qdict_get_int(qdict, "n");
>      CaptureState *s;
> =20
> +    warn_report_once("'stopcapture' is deprecated since v10.2, to be rem=
oved");
> +
>      for (s =3D capture_head.lh_first, i =3D 0; s; s =3D s->entries.le_ne=
xt, ++i) {
>          if (i =3D=3D n) {
>              s->ops.destroy (s->opaque);
> @@ -69,6 +74,8 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict)
>      Error *local_err =3D NULL;
>      AudioState *as =3D audio_state_by_name(audiodev, &local_err);
> =20
> +    warn_report_once("'wavcapture' is deprecated since v10.2, to be remo=
ved");
> +
>      if (!as) {
>          error_report_err(local_err);
>          return;
> diff --git a/audio/meson.build b/audio/meson.build
> index 59f0a431d5..f0c97e5223 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -1,12 +1,13 @@
>  system_ss.add([spice_headers, files('audio.c')])
>  system_ss.add(files(
> -  'audio-hmp-cmds.c',
>    'mixeng.c',
>    'noaudio.c',
>    'wavaudio.c',
> -  'wavcapture.c',
>  ))
> =20
> +# deprecated since v10.2, to be removed
> +system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
> +
>  system_ss.add(when: coreaudio, if_true: files('coreaudio.m'))
>  system_ss.add(when: dsound, if_true: files('dsoundaudio.c', 'audio_win_i=
nt.c'))
> =20
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 25b4aed51f..59f3446224 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -363,6 +363,7 @@ SRST
>      Show host USB devices.
>  ERST
> =20
> +#ifdef CONFIG_AUDIO_HMP
>      {
>          .name       =3D "capture",
>          .args_type  =3D "",
> @@ -375,6 +376,7 @@ SRST
>    ``info capture``
>      Show capture information.
>  ERST
> +#endif
> =20
>      {
>          .name       =3D "snapshots",
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 15f6082596..6d59bc8f18 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -764,6 +764,7 @@ SRST
> =20
>  ERST
> =20
> +#ifdef CONFIG_AUDIO_HMP
>      {
>          .name       =3D "wavcapture",
>          .args_type  =3D "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?",
> @@ -798,6 +799,7 @@ SRST
>      info capture
> =20
>  ERST
> +#endif
> =20
>      {
>          .name       =3D "memsave",
> --=20
> 2.51.0
>=20
--=20
 -----Open up your eyes, open up your mind, open up your code -------  =20
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \=20
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

