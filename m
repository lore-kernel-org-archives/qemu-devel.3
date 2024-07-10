Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54621C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRfAW-0001kO-Gh; Wed, 10 Jul 2024 17:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sRfAS-0001jn-PY
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:48:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1sRfAD-0006cP-3k
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:48:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f70ec6ff8bso63175ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720648066; x=1721252866; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NR4rjK7A5xqVWp1g1Wi/6Wp1b61pjIpOtbU6yTUYobY=;
 b=RyJ9wYiCYs7mr+6K4XMq1+MzhZi8Wn5LP1ZcC8CkyLkgX5aR61uOqNvmOVNrRkSr6c
 t94wLdnYTrcdG1sLh9X53SQwaYcW0y7hZxJckNyPAGAKART8rDwDst36Uq8icX1/Hs1l
 /OtSy5/x5n4RcmFt2lWW6yl14aRgCWT37xOlqB4YuWjpImohXYp7p0ODRXgu9CQ2VdVc
 OAmT4NxdKng4/vwBrC8NkgVOdkxFpo2TqKiyvefQReoq9USacoGmawhnLGxx/TJA2TUK
 Igygpd/CirAc61CRwB15iEF1eRoznHVLPvuPWFlUEjP65BiyWSQNmYLwH1Pqunl4cTkI
 Zwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720648066; x=1721252866;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NR4rjK7A5xqVWp1g1Wi/6Wp1b61pjIpOtbU6yTUYobY=;
 b=uT55suVVCoXu0iVpqBUZh2yDgnvxNT01IH25D4AltiaIQ0TjYO/eALBFz7B/eomL3L
 dTapibUV3eAaPa92C7jiSHkttXMdQbgwJvUOVidKxMzOJHdCtf0QJDlf5CJJoFjfRe8g
 /ojIeY59RqsvzRmQedoRabw1GTgmpoDx6ql9RUFepzwsuu0vgkldLiJJVKZhGCENLmS5
 lIqQSzk29F867868sNh0MRJqUulZ8cSNpWfvkg2o9KsovRioiBvZAkL9sYlf6PiR4cHU
 WWchUQ9Z1HXe+Eo+qxBdyK7nVbdIsttAPc5o5DnPHuEvsRnOjIemDRUWmWGK+FY7fupd
 jm/A==
X-Gm-Message-State: AOJu0YzLcDE9S0TQmLVkRk7UaGVt17TzBFU0JPtbRM5FaLbGoRdZZqUx
 64+Fk0ioTaHtg03GbBUkQCJnq4TgDB/wGMf5zokYJk142dc6F7fdLZ4OFj/YsnNGirCOHPu7xU0
 rwqlgvnsY48ojoN8g2Wm+tw8Xt1u8l750IUBIqOfp028/i6/DQg==
X-Google-Smtp-Source: AGHT+IHQ/TH+w5LbVQA+Hi/J4RhDLHA5QxH6WUfwOZEHRA2qxBx4OT1tJSqXgFuC6KaVcRJDP17lFskxg2+wfekDtpo=
X-Received: by 2002:a17:902:fb44:b0:1fa:191c:fe4e with SMTP id
 d9443c01a7336-1fbdec6e2e5mr291975ad.21.1720648066183; Wed, 10 Jul 2024
 14:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240708181709.27410-1-rkir@google.com>
 <CAFEAcA_r9ee+5VLSEVPN-g8AzFOb7j7ft+_GYCYLFVe=ieBMiA@mail.gmail.com>
In-Reply-To: <CAFEAcA_r9ee+5VLSEVPN-g8AzFOb7j7ft+_GYCYLFVe=ieBMiA@mail.gmail.com>
From: Roman Kiryanov <rkir@google.com>
Date: Wed, 10 Jul 2024 14:47:35 -0700
Message-ID: <CAOGAQeryFuYVmn=75i4zyF5kmXsyH0LbccjoAN9RrXsu+07LYQ@mail.gmail.com>
Subject: Re: [PATCH] iov: don't use void* in pointer arithmetic in headers
To: Peter Maydell <peter.maydell@linaro.org>, jansene@google.com
Cc: qemu-devel@nongnu.org, mett@google.com, jpcottin@google.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=rkir@google.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Peter, thank you for looking into this.

On Tue, Jul 9, 2024 at 2:39=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
> We had the question on a previous "make this C++
> compatible" patch of "how much of this stuff is there?".

Unfortunately, we don't know yet (we are still upgrading to QEMU8).

If this is a burden for QEMU, we can keep the changes on our end
and send them once we have a bigger picture (e.g. when upgrading
to QEMU9).

Regards,
Roman.

