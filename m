Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1311EC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 10:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJ93T-00085h-9k; Sun, 25 May 2025 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uJ93Q-00085W-VG
 for qemu-devel@nongnu.org; Sun, 25 May 2025 06:58:09 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uJ93O-0006Tf-AU
 for qemu-devel@nongnu.org; Sun, 25 May 2025 06:58:07 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-477296dce8dso12316951cf.3
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748170684; x=1748775484; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzH3Wj0EZ0CTe3mjiecPuPxYxVJ9+Xmn3p2HJMZIzQI=;
 b=DxUBziq0wwaWa7uGUDSNOcRI7r9tAiwQXyBFXrKIrNpj1pXPDssrIZc6eDl5bJltuR
 yFm1o0dXDihI3mvn6BeV57pBUp1Nkp2eNNTn/OoaqdB2jNommXawqU9xIKOm8mSkb61x
 QDJBg5PDQcOQjEerDWg8zQEF0kJz3fYCt21aUXt9rzCodO6mQZwBc7vbTsFO3whjLGmN
 DDPdoRTFJlf/uYGDS6GiJlxm3bjme8wYB9h373eN7B3KFEYOzwrU/casD0dsDzccGZ/u
 3wMFYUrz8H0aZ+S15YJxXL10DeHVpw9yGv2PXEJO+MP1l0iCa0D69/owXO/P3HawWsG5
 ehmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170684; x=1748775484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzH3Wj0EZ0CTe3mjiecPuPxYxVJ9+Xmn3p2HJMZIzQI=;
 b=kNvd+/RvEMpc4cCNM5Oi4RGnxZKDoXNYPNqNxJJ6/UOs04UwNY1lWxItQ7KNbNu5Qq
 UqxrQoGWmscOwQAEZNo1tKCpFSjWBMH/cgt7cEC2YXqWdAgrP5xs6f4ZE+OpvbJPAaRS
 5Zl/wEPn6/bGsedaO8CiovhzhcE1SOsiQo8X2iiUg2PsHxxp66S9bSB0IKTZu4+mHiXk
 cLghEE/YaU+cbNbeOedwCyiPF8AEnNbDl0jbTCVVbji9flvvDUcnyxYaChkJM1YNy2UN
 Q9HqU52YatufXpomTGBuqK5kRq56gdXrcd409HgxmogKvGwyG5E5etL7mBwYSy+rnfdE
 nx+g==
X-Gm-Message-State: AOJu0YyVSNs1SpcuHqQmlHXJyjhnoFLWb0ycP+W0bSXJfhpLvkz2DIgD
 ZXkE73Go3cjEa0qLvWEqkmFEH8+p3eDSei6F1I28qo1aQ5vbhfiXB2zpxuXUvt9pjBDStIi8c4l
 RFiuq+rSEAXnhRfOrr1/0TKcxrBsLSh4/B+jZZwFa/w==
X-Gm-Gg: ASbGncvwy/UT/KVTpulCR23pAhdqbkNlOcEwqHtpE7/NylJ1CGKE9QOdMZfm0UZT9je
 V2NaAHrySkEciOsdgNeC74lI9tKxTzrfPzgU/bVfASuccPTCPz8j0e00mCsfAooWbpeTyFAqerY
 O4V7/st6Avk6yqmJwQg2O58URETz85G2mTLA==
X-Google-Smtp-Source: AGHT+IErgFcSkbDCzWU3Q7+EFNibsoDd+4iiGvhpom1FzKcMhkMBzI85UL+p/SjuFRaoDocpojSahEhgGzm1+k9E8EI=
X-Received: by 2002:a05:622a:5c1b:b0:494:ab13:6824 with SMTP id
 d75a77b69052e-49f46940d94mr85201261cf.15.1748170684360; Sun, 25 May 2025
 03:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250317-rate-v1-1-da9df062747c@daynix.com>
In-Reply-To: <20250317-rate-v1-1-da9df062747c@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 25 May 2025 12:57:52 +0200
X-Gm-Features: AX0GCFubH3ZtTA5Z5U5Y7tExjED1mPyQTwQCVR9LXKzq31Jw8SCgmfLQpqd0E0w
Message-ID: <CAJ+F1CJjPS66Sb_nUU15Xg=PuA79TUnPC8Yz+NJhgiUf7k_MnQ@mail.gmail.com>
Subject: Re: [PATCH] audio: Reset rate control when adding bytes
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 17, 2025 at 9:07=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> Commit 90320051ea99 ("spiceaudio: add a pcm_ops buffer_get_free
> function") caused to emit messages saying "Resetting rate control"
> frequently when the guest generates no frames.
>
> audio_rate_peek_bytes() resets the rate control when frames < 0 ||
> frames > 65536 where frames is the rate-limited number of frames.
> Resetting when frames < 0 is sensible as the number simply doesn't make
> sense.
>
> There is a problem when frames > 65536. It implies the guest stopped
> generating frames for a while so it makes sense to reset the rate
> control when the guest resumed generating frames. However, the
> commit mentioned earlier broke this assumption by letting spiceaudio
> call audio_rate_peek_bytes() whether the guest is generating frames or
> not.
>
> Reset the rate control in audio_rate_add_bytes(), which is called only
> when actually adding frames, according to the previous call to
> audio_rate_peek_bytes() to avoid frequent rate control resets even when
> the guest generates no frame.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/audio_int.h |  1 +
>  audio/audio.c     | 14 ++++++++------
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 2d079d00a259..f78ca05f92fb 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -255,6 +255,7 @@ const char *audio_application_name(void);
>  typedef struct RateCtl {
>      int64_t start_ticks;
>      int64_t bytes_sent;
> +    int64_t peeked_frames;
>  } RateCtl;
>
>  void audio_rate_start(RateCtl *rate);
> diff --git a/audio/audio.c b/audio/audio.c
> index 41ee11aaad6d..049d9d07aa58 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -2274,17 +2274,19 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struc=
t audio_pcm_info *info)
>      ticks =3D now - rate->start_ticks;
>      bytes =3D muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SE=
COND);
>      frames =3D (bytes - rate->bytes_sent) / info->bytes_per_frame;
> -    if (frames < 0 || frames > 65536) {
> -        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n", f=
rames);
> -        audio_rate_start(rate);
> -        frames =3D 0;
> -    }
> +    rate->peeked_frames =3D frames;
>
> -    return frames * info->bytes_per_frame;
> +    return frames < 0 ? 0 : frames * info->bytes_per_frame;
>  }
>
>  void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
>  {
> +    if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
> +        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
> +                rate->peeked_frames);
> +        audio_rate_start(rate);
> +    }
> +
>      rate->bytes_sent +=3D bytes_used;
>  }
>
>
> ---
> base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
> change-id: 20250317-rate-308c5c79f50f
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>
>


--=20
Marc-Andr=C3=A9 Lureau

