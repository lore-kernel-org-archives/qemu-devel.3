Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23215C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 14:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twMRI-0006Qy-Ev; Sun, 23 Mar 2025 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1twMRG-0006QU-5y
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 10:36:34 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1twMRE-0006ta-Gg
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 10:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=0H0FTU/s8FTPXZYyS4Z2UFsQYCf8MHFYMAZB6oB/cQ0=; b=iepHK5Jktr73tDTzqg5fCMDwje
 uJDbuJsXvtYIHfiAE2SheWPUTxcOtaCSajVFAUAgDRoke5HaSeeVK2D2zIlK7JJfdeLIBsqPxJGP5
 Bq/rHHfPNHrvVF2XsrCKwbfrqvj0iZXyfD2Ns+cQZF1yCQYwpydB9BHF7K7U0LnczADlM+nII9sT5
 sK+j0pedDqnSaiQw5uqUIZVDg+U9oxXtx2BMYw7o6/5+6Fw8uuw6qb18xoyhjIaIZjGkyADFAkz1s
 bv5i30iPO5TNxmG2d9R3KrZvAFWvNxbdwM+l34c6XpZqJmXBZslYvGSzHJnik/iyjwEzyVt0ARVgh
 uEGngUtTJatRE7p1SnqeLDnttCjcZY0zlGmTj5iLvcDihIz7G0d14NpLfTqslt/pJjJ7V9oyvsWlZ
 xCVp0e1LeKstKftP2ytPgw5Uh4HR5TBQrFggNUKGRdt0yubfutn4q73ErNsM6zLHcRXaI+xIi4mfE
 ScPc/G2ky+V/a9vdrrXUjCOLeldCzWtSo3r/VGIMr8KL+tEtHCT38k47WzRfmKdIuA8FAdufnPMIu
 IZqvgCr1kv0Yxl/DfQI9V4ZHfgKM795NPqPcNogqZXQe1BdmT8UsblfsetSbc8KfZ91ULgH4MG2vj
 +AjCTpTZAFFv3Q8wtm3VRHl9lc8kVDhRVwEZgYbWk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Volker Ruemelin <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
Date: Sun, 23 Mar 2025 15:36:27 +0100
Message-ID: <2118992.kbFERA6akJ@silver>
In-Reply-To: <20250316002046.D066A4E6004@zero.eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
> Quoting Volker R=FCmelin: "try-poll=3Don tells the ALSA backend to try to
> use an event loop instead of the audio timer. This works most of the
> time. But the poll event handler in the ALSA backend has a bug. For
> example, if the guest can't provide enough audio frames in time, the
> ALSA buffer is only partly full and the event handler will be called
> again and again on every iteration of the main loop. This increases
> the processor load and the guest has less processor time to provide
> new audio frames in time. I have two examples where a guest can't
> recover from this situation and the guest seems to hang."
>=20
> One reproducer I've found is booting MorphOS demo iso on
> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> startup sound but instead it freezes. Even when it does not hang it
> plays choppy sound. Volker suggested using command line to set
> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> necessary, because the alsa backend has a design issue with
> try-poll=3Don. If the guest can't provide enough audio frames, it's
> really unhelpful to ask for new audio frames on every main loop
> iteration until the guest can provide enough audio frames. Timer based
> playback doesn't have that problem."
>=20
> But users cannot easily find this option and having a non-working
> default is really unhelpful so to make life easier just set it to
> false by default which works until the issue with the alsa backend can
> be fixed.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This fixes my issue but if somebody has a better fix I'm open to that
> too.
>=20
>  audio/alsaaudio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index cacae1ea59..9b6c01c0ef 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apd=
o)
>  {
>      if (!apdo->has_try_poll) {
> -        apdo->try_poll =3D true;
> +        apdo->try_poll =3D false;
>          apdo->has_try_poll =3D true;
>      }
>  }
>=20

Correct me if I am wrong, but AFAICS if polling is not used then no state
changes would be handled, no? At least I don't see any snd_pcm_state() call
outside of alsa_poll_handler().

/Christian



