Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BD2C5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 02:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHao-0004ty-Lh; Mon, 02 Jun 2025 22:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uMHam-0004tj-RY
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 22:41:32 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uMHak-0004v7-Rq
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 22:41:32 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3122368d7c4so3798474a91.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748918489; x=1749523289; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Eu+FesRqL52vewcRRuStIzS3DzZENKUPDkHv/RWastY=;
 b=nNxmMZ4zv0WxvB9kOnC+qZRezSwr5wbao2xa6VBWg1PTVpaio36EriRB2v/Dlyt2YG
 iT2bS+ob8K7fZTibHEoVOlesyxSJdpkjTHwHkofEkyrBQA9S+c5Mqt/7GwDFnb601/B0
 /l/OEq0E7ZInTnlNZeI8bhpZfQEdPXMCgUWx3TCoznzwLQzsm0BITMEZ8bDj1rviKvsS
 kh+fsY6JOBBnzPQBWdG8c4NVYThWllI0Dj4HFC03XNNTu70fzsTxxfOs6WuI1LhYeinB
 QwEqr+U8zYzsa2kjAXDugDSFwZvMxvZ+Nm9GT22O4RSK9LHWf8GfXWNAuJLlEehWTtuY
 j4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748918489; x=1749523289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eu+FesRqL52vewcRRuStIzS3DzZENKUPDkHv/RWastY=;
 b=HsUy33iTjMyy6nhmAuEVcZcoJ6A7u0dSBwO3pCQNoU8U/AZZihrmfck25cTmovKP+F
 6QXgyrbrts0sQFalIJj/s4WeUyQ0BYxCRG5gXtShoFEYwfuR9YLfGYZf18LfK8skkEET
 D+ST8VBG/X2NGa2MSxd2dv1i2cDaHNBtt6LNXKA29Ngh2KATtLdp0dyzM3c25r0BKaph
 EtVGwCJGolgz8jbn2nOVfXDFoUX0QmmPdt1KtWsW3PWTFwjBhuvPRYDpjFFszAAYVzAK
 97Cjcw/BVPu0fEi/nQ4ZR03C0HGJiK8tuYtzbbCaxTgsT20DfZLQYE+yNHKUXSU/cryx
 HCgQ==
X-Gm-Message-State: AOJu0YyXQjGrsdftnhAlaTzhXRhh1AfHUn753tNpjVcs6Ew57wDbayw9
 coSSFAIQjWvdDFXBlom1GNwo+9gjW5CG1aYuVsTiT9TLqXo6zjz7/nM4lOkQvKi6ED95TvYJX+i
 KRYLVvMzCnKtouBXRmhLJoPM4zh7l5PcW3RI5
X-Gm-Gg: ASbGnctGpyHg295VeM0bVthK/iJCQMUcYqzfBaw2X4M3J+qvYPj42B40CvVcuAPLCE2
 iR9s2njScSI1wR4GeARvaexl2ymdXRU/iBME7T6cYt+alWhlC8dMZzP9yUmAD99EH8mkRINjdB+
 rLx8Y0f+YkwI9eGerggp0OY1Qj+z9GBrGESVGuHdgPorGrvRMbgxFTjRaJfh8BO8Q=
X-Google-Smtp-Source: AGHT+IEKVJgDufR/12Bbg7qkkG1iKRt8/rdvByM/JSHvcx8y2iysMFKeR1huoi/fHFtgkS9jRXzWCkSDvyAgQKfwpI0=
X-Received: by 2002:a17:90b:3d04:b0:2fa:157e:c78e with SMTP id
 98e67ed59e1d1-3124150d6a1mr25064180a91.7.1748918488689; Mon, 02 Jun 2025
 19:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 3 Jun 2025 11:41:16 +0900
X-Gm-Features: AX0GCFu6yFtr2hRkkKqTFMU2CoLopPx-0-gROj5x_v4T7RmeDUdjqLh69G8FbjE
Message-ID: <CAEDrbUZQ4-RQoe5BtTnHxz+v0c7_mJMb0dZV8GWmGiG+L_B+Ow@mail.gmail.com>
Subject: Re: [PATCH 0/5] Enable QEMU TCI to run 64bit guests on browsers
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000004271a40636a1d1b6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x102f.google.com
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

--0000000000004271a40636a1d1b6
Content-Type: text/plain; charset="UTF-8"

Hi all,

Kinldy ping on this patch series. I would appreciate any feedback or
comments.

Patchew URL:
https://patchew.org/QEMU/cover.1747922170.git.ktokunaga.mail@gmail.com/

Kohei

--0000000000004271a40636a1d1b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi all,<br><br>Kinldy ping on this patch =
series. I would appreciate any feedback or<br>comments.<br><br>Patchew URL:=
 <a href=3D"https://patchew.org/QEMU/cover.1747922170.git.ktokunaga.mail@gm=
ail.com/">https://patchew.org/QEMU/cover.1747922170.git.ktokunaga.mail@gmai=
l.com/</a><br><br>Kohei<br><br></div></div>

--0000000000004271a40636a1d1b6--

