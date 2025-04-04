Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3436DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 07:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0b76-0005CF-Vg; Fri, 04 Apr 2025 03:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u0b75-00059w-1G
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:05:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u0b73-00080A-6j
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 03:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=29wKsr6PKXjiqbb6t5bEUy/E6kXF5llH9Mk8UWhAUnI=; b=Y4cU98iWug/RFLfN29Lykg4asu
 Shmlir7bwhnH1yEmZBUmk/8lYEoEIolNNHrPBFyMWRp5v6ypam9zO/C5tFGGB9VJo7th32Wzzu2cW
 5Qc42XL6RMtBI9BkmHn+uU0Qjp1xQMLPyfXotDQvbVPtbzFUbfbkr1iwM82YQpV7gzRThwFxcscc1
 XvT+8Nkbcb5W7B8Refe27iMUgtrbc2SBBrfrNk16fb9FQAk1GgJi1TL8kis1e0rnvqCOkR+oQ11Fs
 TqiWssaqdtRfqCp9G3VTzjPY9YCf9VThoEWbfXIywAVXl0W+a7AAMcIPAF/lo9dJqDhYGLt0NRWeZ
 McST38/HVPz8CUtghlEB3JoqevXMvOVIZVK/I/ul6T2F3ldDTX2iTGEK1YfujhhTQSIelnJastPaP
 YuLyDYFnF88rBD0lqfSwvMJhahAlPyILgNCcp/8wXcgYM+XkxEb3Bvws+LuY1WpfzRRpzIWotwOZW
 nLGsdNaDeFIPe/6sJQAf8MPEpLIn7VGGgEqLHiOjUpY41FlSa19M27v6eUdUCfEyt1Y36RkIAcZVG
 eOwlsavobQOxqcOCHVjLIRacRD4qYPQK7C99HrVJSkavTbb7PNuBoHCy3fdFVQ5nFSb/0L8FmoBaK
 TDJNOhuiYUt5VzyJys6tw/j/7fyVjTCwBuzYqbVuM=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Volker Ruemelin <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
Date: Fri, 04 Apr 2025 09:05:08 +0200
Message-ID: <37909074.vkC8U9mzk0@silver>
In-Reply-To: <alpine.LMD.2.03.2503311503200.6402@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <2118992.kbFERA6akJ@silver>
 <alpine.LMD.2.03.2503311503200.6402@eik.bme.hu>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Monday, March 31, 2025 3:05:24 PM CEST BALATON Zoltan wrote:
> On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
> > On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
> >> Quoting Volker R=FCmelin: "try-poll=3Don tells the ALSA backend to try=
 to
> >> use an event loop instead of the audio timer. This works most of the
> >> time. But the poll event handler in the ALSA backend has a bug. For
> >> example, if the guest can't provide enough audio frames in time, the
> >> ALSA buffer is only partly full and the event handler will be called
> >> again and again on every iteration of the main loop. This increases
> >> the processor load and the guest has less processor time to provide
> >> new audio frames in time. I have two examples where a guest can't
> >> recover from this situation and the guest seems to hang."
> >>
> >> One reproducer I've found is booting MorphOS demo iso on
> >> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> >> startup sound but instead it freezes. Even when it does not hang it
> >> plays choppy sound. Volker suggested using command line to set
> >> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> >> necessary, because the alsa backend has a design issue with
> >> try-poll=3Don. If the guest can't provide enough audio frames, it's
> >> really unhelpful to ask for new audio frames on every main loop
> >> iteration until the guest can provide enough audio frames. Timer based
> >> playback doesn't have that problem."
> >>
> >> But users cannot easily find this option and having a non-working
> >> default is really unhelpful so to make life easier just set it to
> >> false by default which works until the issue with the alsa backend can
> >> be fixed.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >> This fixes my issue but if somebody has a better fix I'm open to that
> >> too.
> >>
> >>  audio/alsaaudio.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> >> index cacae1ea59..9b6c01c0ef 100644
> >> --- a/audio/alsaaudio.c
> >> +++ b/audio/alsaaudio.c
> >> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool ena=
ble)
> >>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *=
apdo)
> >>  {
> >>      if (!apdo->has_try_poll) {
> >> -        apdo->try_poll =3D true;
> >> +        apdo->try_poll =3D false;
> >>          apdo->has_try_poll =3D true;
> >>      }
> >>  }
> >>
> >
> > Correct me if I am wrong, but AFAICS if polling is not used then no sta=
te
> > changes would be handled, no? At least I don't see any snd_pcm_state() =
call
> > outside of alsa_poll_handler().
>=20
> I have no idea but this fixes the problem (and does the same that can be=
=20
> also done from command line but nobody can find that command line option)=
=20
> so unless somebody has a better idea could this be merged as a fix for=20
> now?

Well, I understand that if fixes the misbehaviour you encountered. But how
helpful would it be if it then breaks behaviour for other people instead?

I think it would be better to add a 2nd patch that would handle state chang=
es
in callback mode. That would satisfy both groups of people. AFAICS
snd_pcm_state() can be called both in polling mode and callback mode.

Just my 2 cents. Of course it's up to Gerd to decide.

/Christian



