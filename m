Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3077606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bhMSMvIc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKavo-0007Za-CV; Sat, 24 Oct 2026 08:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <theultimatecarthaginian@gmail.com>)
 id 1xKW1C-0002Ai-Lf
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:18:18 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <theultimatecarthaginian@gmail.com>)
 id 1xKW1B-0000ma-3t
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 03:18:18 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8b0d91601bdso21357027b3.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 00:18:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792826295; cv=none;
 d=google.com; s=arc-20260327;
 b=M197T1FEu9Ag0c7iWiP/MP+6p5utO+2+0ult0ihNrcShgypb1cAj9NDLJ0A+YBZ4l9
 2cx390F/APezqaj6LkXO2V1pMAsEBClupphoud0Z4AXGrrcQh4nfsfPbsuPPsW2DuHLb
 MEaT/iuw5LOw9FqP2COoy131MlQBGHZwPn7mMz9pZJ7HCarUregOS2oWK25UoHGi+Bq4
 7ubU+vHNKUwta8xx+ZE5FC3E5MrSprOBeDfQ6oq/aU9BdMuQMx/PBKWN6jeWbiysxtAM
 bvyQ1iJYDcoFFWnVTGQW+gX0GDlKLRCXxLUf/Pau6aZohSOcxDuPGYrNC2dBMUs/xrwE
 zeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:mime-version
 :from:dkim-signature;
 bh=Kc3ULKBKUSlkEOdodQJAEg6MHly1Rqk8zRAeq1IgTlM=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=bhjq+6DK9HZ4UKWGt+4uBZWjQBc38Rk2HDZL2j32jvezbbRfydrfTucKqHGw6ZIZoG
 1S9R0IEJX8Qcsv9FlGORuKydK4E78nfuuePksXldDYn2Y8JhzOXPPHZSLjMMfY68gSus
 eQWlFc3/jNNXE8kr6QG/VinucNvox6VufY/8hYVT+LmI2VRYES+jjYxg4rFDRusRAfbO
 ATdpqkz+GRpFWINf9BrtvwlvDqnMvIqL42H7nUazWl5823h592GeT2FLkKIOLlmHR6ZP
 o4bxxRKWvSIc3xyQJUH9PY8zNNvG8FNa+l0Wb2bTvaczCwLbV4SUApgnedUG0P3Acvs4
 lBAg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792826295; x=1793431095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :mime-version:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kc3ULKBKUSlkEOdodQJAEg6MHly1Rqk8zRAeq1IgTlM=;
 b=bhMSMvIcI4jHh8bdBPmPII3DhoKxvMJ4WH2dZJ7XHdoD9TGgS5zElrgGpqHy+46p2D
 QT2+4vVVgGNWQdy2jpXkx7WSfJCvPJusfJ86Y8u62ljqzaqdVWs8BBz4caFXfGsNLVxL
 P4wLP+dBmFfr4hI/+dXiuoAHIhTzSQy+CLPpTG2ahIc/cK5MfcRUzh1c8fPk2j0/mMJI
 KF0OcXpsUMI92RyEhtz+Z7lcanZE/LlgIY75R5PqKqaBkV88YYn9NPW+PGioF4u5vPZv
 2lUP7LS/Yos6i1eHmZj4JBIkWhyp6fmtAc8AOCyG/vzLA7fDbseTF6+mMitSkEbL0f/N
 xypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792826295; x=1793431095;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :mime-version:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Kc3ULKBKUSlkEOdodQJAEg6MHly1Rqk8zRAeq1IgTlM=;
 b=J+ccQdkKPHLwg4DL3jYXLiP7wxswKCVLOGeqNr3zzHNb75SDQR1wBiFgqSSvBkqw8S
 gS6yOX3XuwR4zB7+Hzb9UwwhHWOM+KrxGCFGLYvpI118iBahbdyhf3xQNv9G39RWMTZ6
 /66jRZ0rTY/hV34jj+zfVgzsnK8XPWKAs2rRf244m2uihm/QS4oiD0xAuUcRfG2//aCQ
 zndwgPWj7sFq0/ZqBGE45VuWhozGRuDvTdWql/m4lEegUyCKrdXgjY7nxal9aYq+ezRQ
 soq/cMTVrdbrV/QIDn/8/boxFlANrOFSOkxR2FKJXCGsLJxT8L/m+9tdqphqtBegYf/E
 bhhQ==
X-Gm-Message-State: AFq9FYIDvfN4yUcZQhZ0WWb2ig9KEneJSqXNGNiqYS3Uav0ElfQ1MwHH
 19BgUVkDh+fvS9W97tJIo1eyFMonZCw9mdDyb+LCLIbSKgfcFMDd2Xg7d0y2OJWuwGI5Cqx6PIO
 KQKWDrhQy3cUZOKWorG/CrLNq6Mzgska5OQ==
X-Gm-Gg: AYBFou2hCccEqSMYE6QussS4tYhP//5JtjyOBujBir0gLQguAOs8f5cfWwXcSJDAsVR
 HXgxHlnXSFL3R98VqwWQVgF9m/bckguOLkoE9UwElPmsCsB+4MZGWwLLOeKoXsZP/otq9PjgIpH
 /f0xvIJ/pIuPe01U1mTLoIDid4k2SpuwUcRZYQYh5s1b0uXNkkUSSVp41f1manOKP44voTBSmi5
 NDEKD/uLe54hwUUToPwv2kauyrDJ/piJuFlVna3TNmDSqFToM3oHiKK8i2CcoByOWwu6WzLdzxQ
 Qem9tzi4JtPs7TMDVxFQTKLSDtJbkf/EcJM1BGt8HLzM4Qyoq5Kwv0QQUhBGzUyzbwU1RgEhO6g
 E79CSuJhcTlliB+P/7NjQ2+PMHtalDoQEepAu
X-Received: by 2002:a05:690c:ed6:b0:8b0:9e7c:7b11 with SMTP id
 00721157ae682-8b166cf0d2bmr10937867b3.32.1792826295632; Sat, 24 Oct 2026
 00:18:15 -0700 (PDT)
Received: from 511566560828 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:18:15 -0700
Received: from 511566560828 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:18:15 -0700
From: Abdullah <theultimatecarthaginian@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 00:18:15 -0700
X-Gm-Features: AclHuK-s8WA1xI3YBdtAyGNuOJNtbhtmpQHYRYKfG76TX0c9r0sBdWCCZvduLj4
Message-ID: <CAD2YpajTN8eyoLhu5p3ARseZtuqF0uA=dPcnDkYUFdFGbt9b8A@mail.gmail.com>
Subject: =?UTF-8?Q?Ink=2Dboy_=E2=80=94_open=2Dsource_emulation_project_introducti?=
 =?UTF-8?Q?on?=
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=theultimatecarthaginian@gmail.com;
 helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 24 Oct 2026 08:32:14 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello QEMU development community,

I=E2=80=99m the developer of Ink-boy, an open-source project exploring Game
Boy, Game Boy Color, and NES emulation on an E Ink e-reader. I wanted
to introduce the project and ask whether there may be relevant public
discussion or technical resources around lightweight emulation and
constrained hardware.

Project: https://github.com/hellominecraft913-dev/Ink-boy
Reddit: https://www.reddit.com/u/Every_Purpose_1152/s/Yh9djnC8h7
I=E2=80=99m active on Reddit and engage with every post in my community.

Thank you,
Abdullah

