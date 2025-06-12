Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCCFC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPize-0008Gy-WC; Thu, 12 Jun 2025 10:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPizZ-0008Gg-Jt
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:33:21 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uPizX-00089f-LC
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:33:21 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-607434e1821so1659827a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749738797; x=1750343597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AX3E31XECFc+G9A1RVdfizbbvy7OzcfeDBJl8Rt31Y=;
 b=AKiu+8jYEdJW9DOTbxEz1iSc5hx5SnF/JGfx/2N/dqUq5FWDMJq4u7kjA4zLzm/4Ts
 5SGTMJCK6YPxT8rukXUJ5jGfo9Io76gugI2wfQeKoeIGSmKdgiRm4fFd7ViXHIg4LDdj
 pxV/1aMF8/1fXMUDcMtmuQLbrJbWl/D8ugVvFcRntLksJU4+pPQE8hQm8ZjPGZMAHsv8
 n4DKbtgadVh8ZhVZUsJsVLls7g9nX5Qw/5osL+uSgyvZTugvj9iZRC2n1ImhKFxTCI/m
 sbdvPgFzgrUdD43MlhCEsfrGTqWWbbprBxa+nJ/Nki39Yhkicv9yA7RetG67TcyyeyH8
 oChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749738797; x=1750343597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5AX3E31XECFc+G9A1RVdfizbbvy7OzcfeDBJl8Rt31Y=;
 b=inT5+6milfHD/YqOzDGUI9EVlgAfgyYzQzKps81i8sQlbmBk7+CeZBptZGXzQBxq7F
 P4Q1pf2p3RuzRYhUWRjAHA2KGMFuXiYVTUK/5l7A16xOG10qH3dBMAMD7ZMrSIZ7liKC
 pbYfahXrhqh2wmmxMiCsyNP83VvnKQzOapyF/pQQTb6LpMD1uSEIJwe9RMe8e5I2RG0J
 c694Ymjuahtrm9iHAwAyJEsWlttFEHwP41hWcye1XNnrRxGYC7uR8/GPOfmHs+Hs45S8
 1e7QIhS0QRGqhgyGzWFxqfJPyaZ3spEUI5onOP5j6eLI9WJ2mI+FqqZ7ID+WPRR+7ATB
 N9Xw==
X-Gm-Message-State: AOJu0YzFwPTWaIv/xbh4opPwpNmAGs24HMctf0BHQR+dBDNx8+kuQE3y
 Qoe3WAoiXWWitO2dPveLAKCXHy/XC9oQGZ/+JpW3VAE8J6dk/E/4ffKF8iASSf16dz+R1N2tRxs
 vJfiY4XXMxijHJtHyR32eyuuXn20OZh8=
X-Gm-Gg: ASbGncu9Px1VUFMoiZIruztj6iyYJRfREToSrY/ojDk0Y9elpw69ZAqXl6pnxNWJGoL
 dM/E/Imlv/RVtEOMWfDvykzkHOefRaB23ITXZjRR8v5RPkRfthoO8eaYRGzxE5AUvDQpUvr2eKW
 3son6C/dHGl9ceK078Yq67jGFY3WXHa+qdBBvRnHdeBg==
X-Google-Smtp-Source: AGHT+IH3yI9V70FWTV6VxP59SvxxqFI4L/U7dzYJC4sTjRmYPTdangYV2yTCnRxrKm3X48GgIYNwPed/cOSB8AIuxqc=
X-Received: by 2002:a17:906:fe02:b0:ad2:28be:9a16 with SMTP id
 a640c23a62f3a-adea273ad40mr333360866b.51.1749738796644; Thu, 12 Jun 2025
 07:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
 <4ftyylwfpk2d6xioduftadbbwq3cydjmzeaqivksseem4a2h5d@xg7u6y6qaaak>
In-Reply-To: <4ftyylwfpk2d6xioduftadbbwq3cydjmzeaqivksseem4a2h5d@xg7u6y6qaaak>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Jun 2025 10:33:03 -0400
X-Gm-Features: AX0GCFuNCm3ax_Gy0RxZ1WxbeO9uYIUiK7JM_dNhwYjOxiwyN8EZtDN0BqpugaA
Message-ID: <CAJSP0QU-msg=bTwODkB5VPoiwMcDC_ozN=7MuG5tFDNiNDNOKg@mail.gmail.com>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
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

On Thu, Jun 12, 2025 at 10:16=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>
>   Hi,
>
> > I didn't fix it. GitLab's mirror operation is still failing. Your
> > suggestion of force pushing should fix it, but I want to understand
> > why a commit was lost first.
> >
> > The issue is that QEMU's mirror and upstream have diverged. The
> > following commit is only in QEMU's mirror repo:
> >
> > commit 44693a974cd90917f81a7d0310df4b592edd7e09
> > Author: Christopher Lentocha <christopherericlentocha@gmail.com>
> > Date:   Tue Jan 21 11:59:14 2025 -0500
> >
> >     Fix AHCI Disk Detection when using EDK2 CSM
> >
> > It is not possible to fast-forward to upstream's master due to this dif=
ference.
> >
> > Gerd: Do you know what happened to this commit upstream?
>
> Hmm, no idea.  Didn't notice it got lost until now.  Also can't remember
> having seen a non-ff update on the seabios master branch when pulling.
>
> Either me or Kevin must have deleted it by accident, or something went
> wrong with the coreboot git server (where seabios git repo is hosted).
>
> Guess we must do a forced update once to get them back in sync.

Do you still want me to go ahead with the SeaBIOS update you posted?

I'm asking because if QEMU drops the commit I mentioned above, then I
guess EDK2 CSM AHCI detection will break. That would be a regression.

Stefan

