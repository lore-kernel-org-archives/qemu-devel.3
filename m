Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B35EC1425
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhGj-0007N7-Rt; Wed, 04 Mar 2026 03:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhGi-0007Mo-9k
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhGg-00066I-RF
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7Z1esJ/J5oEpVBGty65yuY625YiGVfcmErYzn9k5oE=;
 b=YrUD8BHRFhkSwl9CIFkbrLWaPTUjVeZlEk7+d8IMwiQke7rK29nwEmmL2PfeB7ZkliuYr/
 gAeK2sEqVS2G+jwTyU/mL1QC+8tdVLdlEpM2U2zW+kVoQXdtdp5ihQea9cvUzhhY3EJH72
 dEM6Ex0ndJ2d2ZsKPmz/YNtv0cV92dw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-_MeFvBdSNgqMx8oNLcodSg-1; Wed, 04 Mar 2026 03:07:40 -0500
X-MC-Unique: _MeFvBdSNgqMx8oNLcodSg-1
X-Mimecast-MFC-AGG-ID: _MeFvBdSNgqMx8oNLcodSg_1772611659
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ae49080364so27611095ad.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611659; cv=none;
 d=google.com; s=arc-20240605;
 b=cJnwvquIT0kileaSydqXPFxUAqjgODy72MORyjSGFkd5UCalORUDas/NjoY1zJwtZc
 5Fn1t/zkuU5tlPxoIG667K6IMNxg88jo4E7Qmpm2i1W9HNwgx4Dw94ythT4AHJD4kg9d
 Efkv2Ms0twIxFZlgEUPfm72LqMtBnIHGmxNaRUR1yGQNVO3g7l9oXJLkqB8W8kP0q2C5
 mgiKPSngd289e671AnRFh3fVbUMr5Jo7Er6yzF6djHnQbJvFxZ4j0vK+PV1BaAAK7Ind
 Fe2KPw8/j1DsubgKBfUdVpp592YB78zl01BG81+PwwrtIsEXVRdeyPv2ZJL0nVDN2KV6
 upSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F7Z1esJ/J5oEpVBGty65yuY625YiGVfcmErYzn9k5oE=;
 fh=lqgO2lOGbWCk7XWjZay7GKu0eUWYY0MLXCk5dOVr3UE=;
 b=iPBdxVR0ll2rPpYYWiXW1ba/t7RNIk307Pg9HLRHJUnW/dO2UJyZpCKkOigW51e2yW
 6URiVlu3XVv9pKYu1ORn5JQjcOOUiZsNEhCOH8g1I6unadSWJc5BZ6RY7Au4idGuM15v
 QZWzFQ8sJwapzIiKFf1p3k1oMs1vHbHuRICBYMA/9XCx14gzWyDIb3WfxlJ3qjy56D3d
 67UTA4Z71t5HepYgPie/Uo8IxOGvvdKJ1qD5Yw6+odnxnb9lPdP9hIXl4Lbje4ZGIZgL
 RSh7rrgxZS/encqkOMLNIzzXJonOQteX1Z8MC7pRFrXlrYrIDI1pma3Xl0MQpLwjfCbA
 lyqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611659; x=1773216459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7Z1esJ/J5oEpVBGty65yuY625YiGVfcmErYzn9k5oE=;
 b=CEn4UyPeEb8Sdsj5S5u6d8XpO53huOW0Lqj/Xc5IjNM1Dx8POByLUwOVxh5UDzD2tK
 XMBnY09d/QYzvRllNL+bw9OShe3WQfcU8bDSffALiZ3hrfdxAuBR0m3aq0Sq7dAiDayT
 QHQ7eKHknVtztgHK8qfF6Jq8bRoz81Xa+5WND2st3YHvxH0upD/nmPd69vlBkl9rhBZc
 BSPBHxYHd9mvXGddvOxOP5sjpJ2kycqM7/ehFfWinKlJnMr7iWcHnyvIeGGRXNCXUolh
 Od4JiU0VuaUKndoxjy073a0Jj7pCoeUuWIpl3K5wbPACMYU3Q7PfDSBss7+wTragwP40
 tVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611659; x=1773216459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7Z1esJ/J5oEpVBGty65yuY625YiGVfcmErYzn9k5oE=;
 b=PRZGn+OMSRmw9oZU2HLZqMFTvflKnJVBoDfjQl/uOzZCvx0yfnGQifbE9LdYy2ww9Y
 WWsg5+k8JnMb6OzZDc9wy3FYmjs0RcY9n3qmsFD53Yt3sYBZtdjTthSPKSTEyKUg/BWs
 tHvGjBSOvqfT+9hTMbsJ/69bWs3JdAdr6BNwy2MzL3S4BWJ5qITgxYlcXNLQjzYqunsH
 X+TxeLUL0uxI/Qn7bkGDmYOPpa/F7h8fiVsnFWFaF3kIyO/k+9Xna6YkhSZHq4lpC6PD
 W3dWBC2SP0W+DjFCKG0EYrQ7ecbaY6+KqpNSDadQcMm2OUmGMgopxf4JrvmEvX5H0elh
 2vhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFgKJRMJF1Ornqffm+ZIzD/ZnmmkhQ66Z3D9Y98TZ9TYw79X5bBtNx2A+OVrnfMM9NDoZRQPbAfuXl@nongnu.org
X-Gm-Message-State: AOJu0YxOFwdN5zpeIok4DVAqe4OeZZkTZSfVZh30g4CqIcPdx9yKIBMC
 w4HlBDvw8kjpYuY/v1DhgfudpeBONEFNGuOHs9pKpKQGJOhvA3oVk1jIj/XAL4OVseOkOoI97fE
 fYHg2Uc8kAh0y7G+memObtJDfobYcWwiiBBGRjC3vvut25m4+xt9Zc1doVeChydQbnCfesEz86i
 c4Bg9V0pT2aEyM/zf8w/xuVaNueWEz5Tw=
X-Gm-Gg: ATEYQzy32xN9YHOeRa/N8LdVzJmi/m98JH/5nVNf95vivOzwwmjF3BWxp0NM8NPbG6c
 jEaL6P62KIX98NPP/rg6GNycaDPW3rn236yzfxpXQSPkK5y5y3jmfYSt+Q+RlSAUGc2/v8b4CYo
 kVW1IEuZv2Q1USWkLXHGjBlmXsOfoJsAkJS7PxhfcMly7PqYRKRUAsoxv3L70jvrXzjuVuOKlvY
 DDeQq2Dln5kqQHV3R/5twn3msGWEnsO14WXTlinWBrOPc11BKa/cusiQMKwnNnk+ScvypAlT4jt
 eeLX6g10amLq44v2O0x9wJS8
X-Received: by 2002:a17:902:f545:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2ae6ab64894mr12325315ad.47.1772611659559; 
 Wed, 04 Mar 2026 00:07:39 -0800 (PST)
X-Received: by 2002:a17:902:f545:b0:2a0:a0cc:9994 with SMTP id
 d9443c01a7336-2ae6ab64894mr12325175ad.47.1772611659189; Wed, 04 Mar 2026
 00:07:39 -0800 (PST)
MIME-Version: 1.0
References: <20260304-coreaudio-v8-0-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-coreaudio-v8-1-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-coreaudio-v8-1-bf1d40731e73@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:07:28 +0100
X-Gm-Features: AaiRm53dZA4U8FR0Ew-tnk2aFUsL3qOMBQhKgSn7YR9OCfpwMaTVsq_xQGLdTc8
Message-ID: <CAMxuvayTOj64eVp6kYGR9A+bLMrEYwVf1ATPKNzooc5Av6O=Lg@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] coreaudio: Remove unnecessary explicit casts
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Mar 4, 2026 at 7:17=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> coreaudio had unnecessary explicit casts and they had extra whitespaces
> around them so remove them.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  audio/coreaudio.m | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index a28fa77d73ff..cbda4f143698 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -310,7 +310,7 @@ static OSStatus audioDeviceIOProc(
>      UInt32 frameCount, pending_frames;
>      void *out =3D outOutputData->mBuffers[0].mData;
>      HWVoiceOut *hw =3D hwptr;
> -    coreaudioVoiceOut *core =3D (coreaudioVoiceOut *) hwptr;
> +    coreaudioVoiceOut *core =3D hwptr;
>      size_t len;
>
>      if (coreaudio_buf_lock (core, "audioDeviceIOProc")) {
> @@ -394,11 +394,11 @@ static OSStatus init_out_device(coreaudioVoiceOut *=
core)
>      }
>
>      if (frameRange.mMinimum > core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D (UInt32) frameRange=
.mMinimum;
> +        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMinimum=
;
>          warn_report("coreaudio: Upsizing buffer frames to %f",
>                      frameRange.mMinimum);
>      } else if (frameRange.mMaximum < core->frameSizeSetting) {
> -        core->audioDevicePropertyBufferFrameSize =3D (UInt32) frameRange=
.mMaximum;
> +        core->audioDevicePropertyBufferFrameSize =3D frameRange.mMaximum=
;
>          warn_report("coreaudio: Downsizing buffer frames to %f",
>                      frameRange.mMaximum);
>      } else {
>
> --
> 2.53.0
>


