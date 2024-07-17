Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3155FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4aV-00031q-Jj; Wed, 17 Jul 2024 09:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sU4aU-00031B-1h
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:20:54 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sU4aR-00081P-Oh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:20:53 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-447f7c7c5fcso39052151cf.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721222449; x=1721827249; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0JqeriNIHWExDMMdpLIdh51FNHUKTqdB0L8qsdmG1mc=;
 b=HsAmV9HPNUEKtSNhR1EdLXeBE6ondHg1EOYgZ2a8htAoG3bcwbym14riHgyEq/cwUH
 SVI6g1ELUF+kD+Q/Uf2zw7px8UIIETjth1qOOoE06SWNrEAE0q0bNMCWRrrcCqvkg95v
 uGJEFdbNSZu61z22J9fDidV1VhRM0fQ842yJIqBSjF7lwsciC+AM8HUiWEW9o3zlcCtK
 c6vl5PgoafrgE7+KLGxhJAa1aOaLFoqtlWkxogG6JpGoE7aL/3RE9JVCqW5UWNwPlsNK
 bbsqPaVaYu+8GbhKj6mjiKlI71svHygt5oafTPQbbvL0Kws5JAFtLMjWZYt0z/UbJ66f
 1lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721222449; x=1721827249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0JqeriNIHWExDMMdpLIdh51FNHUKTqdB0L8qsdmG1mc=;
 b=CNSWDh3cwsnXoDNW/uUDQc07PPXzOqPs6EZyDiophr1wWFSKNYRmkt9siS0sYDFD7d
 ylyZyES9ksjbjwMOkIQygJ+m3Fep4P81o3sbU6fokg/Xv0ym1uo/bo8ggpGakGQJPWts
 HEQ1zHvjVXxyGN74y3Nxi3CNHoSmzZOM/Qjxg3jjAETHo9HvFzfvLmVQX+QasmaAZpYz
 jaItBDIqeMBGAUq3WA1MG3Qd8h1KJHBrrC6huMcOWI3RCrDguOGo5eEjO12ZVgElFRgN
 c8yA9srcu3+CMrZvllRaCyc76Vhtf7eCa6Alak77VgTjXU9mhSyjCJu183dV7GCMCXfj
 43Lg==
X-Gm-Message-State: AOJu0YyMUXr3M/zSDaO89Xger/lmegOitGXN8ddy5+6gZgJVVZD8fPk7
 U2qPnETmwOh9s/YXxv0o/bzZcZQJCPXunzQDo6Xaf1ZipzqwRiXrK//Z3bRSQ/zK1/ZdIFs63/D
 wDTzwMkO8ShUH3UuWOcCMc3dhk10=
X-Google-Smtp-Source: AGHT+IHZAZg2NeHw4Ca8XJnXCnBZwgWrjbNXRAlsJMuE+8dtfyA+tyFPFjQx1e2T1nDnsBj6XfEKU9+374fTRMz5aZY=
X-Received: by 2002:a05:622a:19a8:b0:447:e38c:59f with SMTP id
 d75a77b69052e-44f866571c3mr17794351cf.47.1721222449242; Wed, 17 Jul 2024
 06:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240624101040.82726-1-phil@philjordan.eu>
 <CAJ+F1CJMzyWr3y7kEGcj2hE8fogLqH_PBcHkXYK=N28+t96OsQ@mail.gmail.com>
 <CAAibmn3s-+_21sUVf9w9HKVysTM9xgxYBq9Vg0+9iNMC1K7=QQ@mail.gmail.com>
In-Reply-To: <CAAibmn3s-+_21sUVf9w9HKVysTM9xgxYBq9Vg0+9iNMC1K7=QQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jul 2024 17:20:37 +0400
Message-ID: <CAJ+F1CJn_pJoT-bn1NCWcMsOhQhW0Gf3ks9pFJ-3FRdkv1tp6A@mail.gmail.com>
Subject: Re: [PATCH v2] Cursor: 8 -> 1 bit alpha downsampling improvement
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, akihiko.odaki@daynix.com, lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000aaaad7061d715477"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000aaaad7061d715477
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 17, 2024 at 5:11=E2=80=AFPM Phil Dennis-Jordan <phil@philjordan=
.eu>
wrote:

>
> Mouse cursors with 8 bit alpha were downsampled to 1-bit opacity maps by
>>> turning alpha values of 255 into 1 and everything else into 0. This
>>> means that mostly-opaque pixels ended up completely invisible.
>>>
>>> This patch changes the behaviour so that only pixels with less than 50%
>>> alpha (0-127) are treated as transparent when converted to 1-bit alpha.
>>>
>>> This greatly improves the subjective appearance of anti-aliased mouse
>>> cursors, such as those used by macOS, when using a front-end UI without
>>> support for alpha-blended cursors, such as some VNC clients.
>>>
>>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
>
> Thanks for the reviews folks! Is there anything I can do to move this
> forward? Should I submit a v3 with the review tags included? The patch
> continues to apply cleanly so it didn't seem necessary, but I admit I'm
> still not 100% clear on whom I should badger (?) to get favourably receiv=
ed
> patches actually pulled into staging/master.
>
> https://patchew.org/QEMU/20240624101040.82726-1-phil@philjordan.eu/
>
>
I'll include it in a UI-related PR.

thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000aaaad7061d715477
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 17, 2024 at 5:11=
=E2=80=AFPM Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu">ph=
il@philjordan.eu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_quote"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Mouse cursors wit=
h 8 bit alpha were downsampled to 1-bit opacity maps by<br>
turning alpha values of 255 into 1 and everything else into 0. This<br>
means that mostly-opaque pixels ended up completely invisible.<br>
<br>
This patch changes the behaviour so that only pixels with less than 50%<br>
alpha (0-127) are treated as transparent when converted to 1-bit alpha.<br>
<br>
This greatly improves the subjective appearance of anti-aliased mouse<br>
cursors, such as those used by macOS, when using a front-end UI without<br>
support for alpha-blended cursors, such as some VNC clients.<br>
<br>
Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu"=
 target=3D"_blank">phil@philjordan.eu</a>&gt;<br></blockquote><div><br></di=
v><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</d=
iv></div></div></blockquote><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.=
odaki@daynix.com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;</block=
quote><div><br></div><div>Thanks for the reviews folks! Is there anything I=
 can do to move this forward? Should I submit a v3 with the review tags inc=
luded? The patch continues to apply cleanly so it didn&#39;t seem necessary=
, but I admit I&#39;m still not 100% clear on whom I should badger (?) to g=
et favourably received patches actually pulled into staging/master.<br></di=
v><div><br></div><div><a href=3D"https://patchew.org/QEMU/20240624101040.82=
726-1-phil@philjordan.eu/" target=3D"_blank">https://patchew.org/QEMU/20240=
624101040.82726-1-phil@philjordan.eu/</a>=C2=A0</div><br></div></div></bloc=
kquote><div><br></div><div>I&#39;ll include it in a UI-related PR. <br></di=
v></div><br clear=3D"all"></div><div>thanks</div><div><br></div><div><span =
class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gm=
ail_signature">Marc-Andr=C3=A9 Lureau<br></div></div></div>

--000000000000aaaad7061d715477--

