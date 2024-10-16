Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA429D1AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t14A7-0000YE-DT; Wed, 16 Oct 2024 09:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t14A3-0000Xm-Vy
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:34:00 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t14A1-00044k-Ug
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 09:33:59 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e28fa2807eeso6571188276.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 06:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729085637; x=1729690437; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiqQhnjEFkw8h0T1dLSc5P9DsGGAIGSF+8wkIRzGJrA=;
 b=cdGUjbWGCom+Za+ZYp0C6TMNMneRduZWxNzSYK2P//NONFKfBoOjYB5/hj6qzQPEOc
 y+JtI4k/ok/WFdo2+bYEVW/kTZlGA4M4bXIyO0YDaWWaxYgr+x+gjENDDs9QV5X3VDRP
 m/EKYHcwzkk6+7sbX8JQ9xVdnHT0uJCxMnzNigiVIf0fEx2SM7QQXZQS2p4LSgqG0ElB
 R68XYT+ucIrCusPR32qpq0r9IirWmuKdzrM6sUohy/EULWidcK7iCsankXPC5AY7dQnA
 Kz2NWWZ10yYFG1i8qAQHSwF420yo1qTOVqTJxuI7gEj2zUHPD/71Dg7Ja+3whcBX/S4h
 uPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729085637; x=1729690437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kiqQhnjEFkw8h0T1dLSc5P9DsGGAIGSF+8wkIRzGJrA=;
 b=aJpOFJGN9lmZ1dafI6lNhsty+4fZQfejgE3G0/KKvhYeEjGj8CnMABWpN59NrOr9cw
 47PUnt3CVrBUX5bUkz8/DA0Gol4XdvTEpu0wHheEUvYkk/NblRK0K8QhVWp2KZKXLi9+
 KGHSgCOWnO9k6FoRVp9d+qeHtXrMkKoA5eT3ePzq2iAmc+O78wJRYM2gp0ZDwTsAIIHk
 pTT48drAxDP/xOzzSc9lVZ7PRpmbHLaV44Z2gvWUGhTXTb0L0bw7wxhrfvKQdu1HHF/C
 Mu3qlDfFiFDlxl1M1dPWvjnXHEqkuMIWiBkRKgB0prIHSYf18lBtLH/eZvFrNLrSBR2E
 yztw==
X-Gm-Message-State: AOJu0Yyxl6j47J234N/iU38HMP4UqO1kLNh/v0WxEugEYSIgTSNlbzIF
 j5doZm5LEatBPPqXQCY8MWLRjT24jwl3MHfh5gKYFKwuS20qU9YU6jGj4q7Op+p/5FqkXm4RFUo
 pCRZWU5DYRwpXNPAmc93HDp9TY8A=
X-Google-Smtp-Source: AGHT+IFwod0SPd1yu3YG5DrsMNO4NF23HLm56JiHRdHB8RvKiTCSTSqZvAmzLlQA2zMHm+QaUy5vlupX3JwRbfgV4tw=
X-Received: by 2002:a05:6902:2310:b0:e28:e6b6:9ebe with SMTP id
 3f1490d57ef6-e2919fe5c25mr14857759276.35.1729085636724; Wed, 16 Oct 2024
 06:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102006.480218-1-berrange@redhat.com>
In-Reply-To: <20241016102006.480218-1-berrange@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 16 Oct 2024 19:33:56 +0600
Message-ID: <CAFfO_h4qVKBS88LZmbG9-W70HeWmsCw40wG0zHKo7xMB=F=Owg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] crypto: fix regression in hash result buffer
 handling
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=dorjoychy111@gmail.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Oct 16, 2024 at 4:20=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
>
>
> Daniel P. Berrang=C3=A9 (3):
>   crypto/hash: avoid overwriting user supplied result pointer
>   tests: correctly validate result buffer in hash/hmac tests
>   include/crypto: clarify @result/@result_len for hash/hmac APIs
>
>  crypto/hash-gcrypt.c          | 15 ++++++++++++---
>  crypto/hash-glib.c            | 11 +++++++++--
>  crypto/hash-gnutls.c          | 16 +++++++++++++---
>  crypto/hash-nettle.c          | 14 +++++++++++---
>  include/crypto/hash.h         | 30 +++++++++++++++++++++++-------
>  include/crypto/hmac.h         | 17 ++++++++++++-----
>  tests/unit/test-crypto-hash.c |  7 ++++---
>  tests/unit/test-crypto-hmac.c |  6 ++++--
>  8 files changed, 88 insertions(+), 28 deletions(-)
>

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>


@Daniel the api documentation for "qcrypto_hash_bytesv" also needs to
be updated.

Regards,
Dorjoy

