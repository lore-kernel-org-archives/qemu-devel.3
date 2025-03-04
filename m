Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E129C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNxz-00053d-VZ; Tue, 04 Mar 2025 03:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tpNxa-0004zr-M4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:49:08 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tpNxX-0004X7-Af
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 03:49:05 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-548430564d9so5703639e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741078138; x=1741682938; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OfRFYMo//K94xaEfKhA3McqQupcqgzohEIkPVRQuvI=;
 b=IJBXyM89Kjjqof83z97Fiu3UkUWIWd1QPkukHT3R/eXShpuccuLZjA3l2MnGoi1bBk
 seTdfQqYYGO0Cc+PO24hflCJrRpYnBhLs05qtaHcmYtg4o2YMKVFSa4KLnOlLN79NwHN
 j5N4l4FQPhqW+64E/qIY3nNYX0XsC0XFUdgVIJBNzYYOr5gicokbKesL4VDEM/7G3deq
 fZSr6lCS3blN0auSMWEKNPdKujAflEX2NND1OqQ1u9818WjTfqvYla4VIpR0ukMzd5jY
 i1UMDb9D/LqrTd+WfXM3LykTf3+A++CpJAAexfezsy7WVo10pshar0Mfg1KhBrnIlOaF
 7W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741078138; x=1741682938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7OfRFYMo//K94xaEfKhA3McqQupcqgzohEIkPVRQuvI=;
 b=wPTeguiYEkQ6ONvA2rGoagM+72PiNk2lp8kMarRPlvjaLWUxDbxyttyFGDgWsRsz6e
 Qofa4rM0M/qrx1lyZX3GF4a2qgE4wMgfejTXPTQecdIJmkf5AHNAQXYy6+WthtMFceFz
 Tjvr82zivHdH8X84s1VY9FQZv18UMdw+XdemDDxvIiY6SCorozflRVK3XIz3nMY5m1a8
 HsuMgJ2IxAx6BxuVecG7YXaqCGZFGOB0C8L903THjULwm7NWbaz/kthYwyeSg6IWOEdi
 u3ey7TXZTc4MawV/tv6gyBqyyIPwOJlx72bKKC6dy7nF7hRGO2hyB8HG0YOTMXEKdBbj
 IDuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI4Dk1BBZwyxtqwcXLgcnpOVNwCT99nmxU2WlYis1XLcfmcj5n2qNHRW6T1gFMtrVsINiMv07/NRuv@nongnu.org
X-Gm-Message-State: AOJu0YyIjXzoGaplOcT9JAtNHwySqT+oTArIQFFj3DfwJagQVqowQEgb
 KyFrkVwQcKK2966j6VeeVUlEtC/kwdYmSe2tMxczrbw6m3Jbb/hYO0izeu9DcCVjj6TJAPtS4Ih
 O2N/bFuuxhPcYFO0mnZCRE8VG5h0=
X-Gm-Gg: ASbGncvLtWwVfCb4iUjxr1q+473AOs8t+wHqWstCMgwvWcbommPG8fKX6sbbOtU8/Wx
 1KAkXEWha1G7464cSIFI1Pwj369t0QiZBPl3LQUEM43ZB5MH9/CHkTQ1UDtTOqPUVTA5Ohs+35S
 aGYB90d9Opu0zzbuFTVDlZTPELig==
X-Google-Smtp-Source: AGHT+IFHqQ2dKJRRao6t3biwtd+Rrdo7SFWzMmh2jeoSWs3IX+/GO8eOiiF7V6ekwyAIcw3E/ixGLt8h7Qqc8gXXj3o=
X-Received: by 2002:a05:6512:3d1b:b0:545:bf4:4bcb with SMTP id
 2adb3069b0e04-5494c38ac59mr6062667e87.49.1741078138040; Tue, 04 Mar 2025
 00:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20250226075913.353676-1-r.peniaev@gmail.com>
 <CAMxuvawEAXpTtUUHsdi-jX6pMRTD=LD5UTu0iN_7-nqf4F09Uw@mail.gmail.com>
In-Reply-To: <CAMxuvawEAXpTtUUHsdi-jX6pMRTD=LD5UTu0iN_7-nqf4F09Uw@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 4 Mar 2025 09:48:46 +0100
X-Gm-Features: AQ5f1JrcU2ZzywVydl2TKQZXv8JAwUvnCDzt_q0ft0Cj0W8bbfvrGPvPckFludo
Message-ID: <CACZ9PQWAeBoK-X62o+nS-TCu0gpoONv7NaWeMDwXgbbzrdEs-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ui/console-vc: various fixes and improvements
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x131.google.com
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

Hi Marc-Andr=C3=A9,

Do you want me to resend the series with the review
tag incorporated? Or are you fine to pull as-is if there
is nothing left to address from my side?

--
Roman



On Wed, Feb 26, 2025 at 11:06=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> On Wed, Feb 26, 2025 at 11:59=E2=80=AFAM Roman Penyaev <r.peniaev@gmail.c=
om> wrote:
> >
> > This patch series brings several fixes and improvements to the QEMU
> > virtual console (VC), making it more usable and aligning it better
> > with VT100 spec. The updates include support for inserting and
> > deleting characters, better cursor handling and correct position
> > reporting. Without these changes, the console is hardly usable.
> >
> > 1. Support for DCH (delete) and ICH (insert) commands
> >   * Properly handles character deletion and insertion as per VT100
> >     specs.
> >
> > 2. Add support for cursor save/restore (ESC 7 and ESC 8)
> >   * Implements legacy DEC sequences for compatibility.
> >   * Ensures cursor attributes are also saved and restored.
> >
> > 3. Fix cursor position reporting
> >   * Reports cursor position relative to the screen instead of the
> >     scroll buffer.
> >   * Fixes issues with tools that rely on accurate cursor placement.
> >
> > 4. Ensure DSR (Device Status Report) responses go to applications
> >   * Stops terminal from rendering responses to the screen but instead
> >     send reports back to applications.
> >
> > 5. Handle `ESC ( <ch>` character set sequences
> >   * Makes `top` output look clean by handling the character set
> >     commands.
> >
> > These changes improve the virtual console's compatibility with
> > terminal-based apps. Without them, the console is quite frustrating to
> > use.
> >
> > v1 .. v2:
> >
> > * The VT spec and ECMA-48 standard are somewhat vague about exactly
> >   what attributes should be set for the ICH (insert character),
> >   but various terminal implementations reset the character to the
> >   default state. Instead of inserting a "space" with the current
> >   attribute, call `vc_clear_xy()` for the inserted character.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Daniel P. Berrange <berrange@redhat.com>
> > Cc: qemu-devel@nongnu.org
>
> lgtm,
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> >
> > Roman Penyaev (5):
> >   ui/console-vc: introduce parsing of the 'ESC ( <ch>' sequence
> >   ui/console-vc: report to the application instead of screen rendering
> >   ui/console-vc: report cursor position in the screen not in the scroll
> >     buffer
> >   ui/console-vc: add support for cursor DECSC and DECRC commands
> >   ui/console-vc: implement DCH (delete) and ICH (insert) commands
> >
> >  ui/console-vc.c | 154 ++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 142 insertions(+), 12 deletions(-)
> >
> > --
> > 2.43.0
> >
>

