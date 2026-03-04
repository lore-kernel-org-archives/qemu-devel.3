Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1E0EB7ECD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjqf-0003KH-Et; Wed, 04 Mar 2026 05:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxjqc-0003Jl-Mt
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:52:58 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vxjqa-0002BF-9x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=mvV0qFWDMzYnlr6mMNTEw1XBw+udOguA2hzHdQQtbQM=; b=FTl8tKXAn1RPCvaLsSpoCkGj4y
 SBQBlp76Z1jlcoUVEyblfQdS/BfiN42wKdyt8UgZm5cGrM6Fj/2c9rcnX8rNNHp2Wba6+kFptOqQY
 YDzs7QeEFnvWUcXzgeRroj1f4txaiZUliRFe+5GKnyOQM4fiHarfuzZoLq617Ei+9JaYL/P6G/vcu
 0jX52GfnLhgoMbaxjHbUgaVM8E05igHCK216nFMBZu+mIJXbaOaQKqTpzEp9vdoVTKmREFHiR4K8i
 j8/Qam8A8qoXbpMVJ5aBsv/2B7BFPY9rwOazequLm4aS8IOKr2PJNamfZJCN/AwCQu+nTPa2xNVxB
 QNdFAH0wi4xyz5VCgvMhe5nW/o45aCCkiUohZmZ4xE5P74KlQaz3XZB0DzOS7qPvt/LVxCXKLySqV
 HugXV1Q51gGG+8Z+sDG/8N1mPOI8A1LLJqe9F2Fq0pYlzAKJFxaDZmpnuZSfd+y0L5n+HkRi7QDAG
 GvqjGEg5ndZ0zR5vs8k4hPbY0NBoH6QSrDWul/dh1iVZVxea6zh5TLA1NogcZnvsbgh3WT6K8p6BP
 hy/O1hjrwRojMUfzlB1w31XrX+1l8xP80MzBG1XxsB7Q2UpoVxtf/QQaxHxrLU1sy/LXP4DUMVCCM
 4yQH14VSmKoTa+/HCB4Z/3DJEK3ijdR+cy2i4PU7s=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: devel@daynix.com,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v8 3/6] coreaudio: Improve naming
Date: Wed, 04 Mar 2026 11:52:51 +0100
Message-ID: <6136780.MhkbZ0Pkbq@weasel>
In-Reply-To: <7c389f35-2da9-4e40-a695-731a1484cb04@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <3933555.kQq0lBPeGt@weasel>
 <7c389f35-2da9-4e40-a695-731a1484cb04@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wednesday, 4 March 2026 11:42:41 CET Akihiko Odaki wrote:
> On 2026/03/04 18:25, Christian Schoenebeck wrote:
> > On Wednesday, 4 March 2026 07:16:56 CET Akihiko Odaki wrote:
> >> coreaudio had names that are not conforming to QEMU codding style.
> >=20
> > coding
> >=20
> >> coreaudioVoiceOut also had some members that are prefixed with redunda=
nt
> >> words like "output" or "audio".
> >> Global names included "out" to tell they are specific to output device=
s,
> >> but this rule was not completely enforced.
> >> The frame size had three different names "frameSize", "bufferFrameSize=
",
> >> and "frameCount".
> >>=20
> >> Replace identifiers to fix these problems.
> >>=20
> >> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
[...]
> >> @@ -349,16 +351,16 @@ static OSStatus audioDeviceIOProc(
> >>=20
> >>           out +=3D write_len;
> >>      =20
> >>       }
> >>=20
> >> -    coreaudio_buf_unlock(core, "audioDeviceIOProc");
> >> +    coreaudio_voice_out_buf_unlock(core, "out_device_ioproc");
> >=20
> > Behaviour change. Not pure refactoring. Should be split into a separate
> > patch.
> Two things are renamed here.
> - coreaudio_buf_unlock() is renamed to coreaudio_voice_out_buf_unlock().
> - "audioDeviceIOProc" is the name of this function. This function is
>    renamed to "out_device_ioproc".

Ah, these strings just end up being used in a log message. My bad, fine the=
n!

/Christian



