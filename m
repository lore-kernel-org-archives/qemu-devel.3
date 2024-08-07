Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35EDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbqX3-0005ba-3W; Wed, 07 Aug 2024 19:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbqX1-0005ac-NO
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:57:27 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1sbqX0-0002I0-21
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:57:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so2455675e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723075043; x=1723679843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjmFqe72YdvfqIFt4uaBezk9cBCdMQ8uK+a6z9kJlDY=;
 b=pNenDunydkG9DxW0C7CtO/L1JOW3INVNUbUhyB4GTsSzUUGoGx2cL0nnmRNdQK+c2D
 0SkOhQU07re/cxtT/MUNCyyngMG+GPQstC0DdjbDEGHHrhRNq0ILICtA1j8vzNIIAvFu
 ochEVnvo38mmXrdhR9dxn/K+Uf0ZEDu9XMu5D32BZnZmQlofhGXCMM0tv5b12fYkgM/y
 /raVAHdMnpvTrKRfpXzmtRqO+WU2FKzOzzeGjSfQcF72+mo4rX2GtvnxSSL60L8mwwWg
 VPMXaxdMVLDoSDueSmzUL2N6QbaUEDmBCVUqNxKcMMzRu1iHyIR1ip79yh/wVtYrzqvV
 aLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723075043; x=1723679843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjmFqe72YdvfqIFt4uaBezk9cBCdMQ8uK+a6z9kJlDY=;
 b=GBC8EzTTTW5tUaiIymZtI5gaRfl1J/mZHgF8IzDP0vYqb+JUHMfrBRtfkTKwdX5gky
 rw6mDFEKir8+ywtF1bbQWDftMa3vXrCmm+OC74CaWrM9cKPyKReTEjn/JMuLSBwsvCMT
 pIK8NkRHJmH0BuJxGxtLsFKQV/lo2TyxOzm2Y9CKztkRLEh4aXPj/Y+1Jl7NpkDQAYjy
 P4HZd27SuB98w7cnjyEP8DAVnpJwSncmzAIQSOzdHU2cAcl9UQmiy65frpkgnPrLQ4Lo
 Sz1fhPZhcFP5SCiT1IevOd5NOvFIu8C672l2F2zOLoavjRvDwvz/wwYMkP33uVkTOaZq
 yFZw==
X-Gm-Message-State: AOJu0YyOnogwQOjqZPRQ4Xr2yrKbvyqaHVysP9fpNskyAVHoln4VqmkJ
 nvNrOclp+Ydf3Uva/tQv89nSlufgJ2tLOSy9Qpr0uUQHXuv+wFTejrS5a1AEqY8Zr5X3uqlX24Z
 9SCPZ9988mMIDNf18Q2jwhRKli8c4MgiAAmLh
X-Google-Smtp-Source: AGHT+IFv2cxTvpXCT+49NkRd97zHBHted2CkY5x40KNi6RQ0dDUdJEnI2MaMNyE+sAvAT7rdeUDrltASTg+VIbso40I=
X-Received: by 2002:a5d:4649:0:b0:368:557a:c64d with SMTP id
 ffacd0b85a97d-36d273c5c0emr96170f8f.9.1723075042625; Wed, 07 Aug 2024
 16:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-23-tavip@google.com>
 <a37a5291-5917-45e6-8697-08defb97ac29@linaro.org>
In-Reply-To: <a37a5291-5917-45e6-8697-08defb97ac29@linaro.org>
From: Octavian Purdila <tavip@google.com>
Date: Wed, 7 Aug 2024 16:57:11 -0700
Message-ID: <CAGWr4cRcQhQw-5QFga3-KDbBby_3mW-p2wKSd4iy7xHzw3-boQ@mail.gmail.com>
Subject: Re: [RFC PATCH 22/23] hw/arm: add basic support for the RT500 SoC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanst@google.com, 
 pbonzini@redhat.com, alex.bennee@linaro.org, thuth@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, alistair@alistair23.me, 
 berrange@redhat.com, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=tavip@google.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 6, 2024 at 7:51=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Hi Octavian,
>
> Few comments inlined.
>

Hi Philippe,

Thank you for the review!

I have queued fixes for all of the patches in the set where
applicable, I'll wait for more feedback on the rest of the patches
before sending v2.

