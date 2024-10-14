Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C072D16268
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 14:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lc5-0003Cv-Um; Mon, 14 Oct 2024 09:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Lc4-0003Cl-Gg
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:59:56 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0Lc3-0006b7-6L
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:59:56 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539983beb19so4617596e87.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728914393; x=1729519193; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgYkgCKZuVBDZxGWarNitHSI2Dlt5in9RQeg4ygxQk8=;
 b=eXkFlyWlqB3/5m8IAz0UDZX8lrVfSLfxuXvfM3hVxOLB/T8vh+0UsLwFlimnIY7Avf
 1jVZfHGOVupnIKYx6V6fNZEEqmZAd31rSdwiPL515LI9Zo3gjA2w8KizRSMUzIvebe1H
 iRdt8kR2r73GacW+I05sYPrJFyxa6Emj2oRY1mKZ7F55m+OXNfxcazNiCjGlaLK+Fesg
 2PB6gQE8YmrXz67P5/XBfbo1UIwa5BbTwEQBytAgP/eMMpphzdiaiu3bRQZ+0GD4vqKI
 6FCUWLrIhNdJtBZAZBh6VxoZIRQyVIyArltIbfZS4HIEQmEO4QH4F8srTLlD+CO5N//D
 uDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914393; x=1729519193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgYkgCKZuVBDZxGWarNitHSI2Dlt5in9RQeg4ygxQk8=;
 b=pjFCphgrcpfPmPDMzSmhfQK5w41rrULgJN016GmuwnKv0YUu82g5kGSUeoFt36kt/p
 BhPjg2oNGV24wECk3VN1II4dH8kLBCIG7T9DSPoeIfr/uYKJKQFyboyL2MQ6VddhExZK
 QPBSOtVz9qWQQjxhghSfpBOVgVV3yTcsbuTCBfUmDzwgVnVshS+RHxvWSD+62dL2s+fq
 oia4wKFaTi6Oa7i3atx4FXxHfoEZI0oBGNJl3/xRkS+W9E9pLz+YoaiKnuNdsEQraIam
 Vl9cgputWugdIEw0ASCE0ea2o28dDZFebKEIEtecdP12AiTi0teA81deDgcAc2pVx2qA
 h79g==
X-Gm-Message-State: AOJu0Yz8bcc02K7mSnsQkQrCIx4lhddKBxyLCpaCNk3ZwuRju4V0hZQa
 8P374a304yw2duXD6Xl7dLTkY5wZJA2FrM65GVvQCQnk3ezzjt2WzvXY9+Anet+2F4awQX5cC4X
 LgUeN/bZZP+Tp0n0doIl+BUuwv7ZKdA==
X-Google-Smtp-Source: AGHT+IEeO9A2EifxFPevbxe4Hed1lmmzQFJh+IerFN7gxwd7UIOLSuzuTFgSce6PV8xOeBP9eX777YM6R+5dERe3eKM=
X-Received: by 2002:a05:6512:3049:b0:539:fc86:ce0e with SMTP id
 2adb3069b0e04-539fc86d028mr690620e87.35.1728914392972; Mon, 14 Oct 2024
 06:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241014114135.389766-1-r.peniaev@gmail.com>
 <20241014114135.389766-8-r.peniaev@gmail.com>
 <CAJ+F1CL6SNBFwo3CgfZR-WhahrcwGky3zTHzHUyoztDbUEroNQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CL6SNBFwo3CgfZR-WhahrcwGky3zTHzHUyoztDbUEroNQ@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Mon, 14 Oct 2024 15:57:48 +0200
Message-ID: <CACZ9PQWKv5oHnFVbRRqkN2MR5_t6yyAVb+=q15CWaWcvi2sOzA@mail.gmail.com>
Subject: Re: [PATCH 7/8] chardev/mux: implement detach of frontends from mux
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12e.google.com
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

On Mon, Oct 14, 2024 at 3:22=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:

[cut]

>>
>> +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
>> +{
>> +    unsigned int bit;
>> +
>> +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
>> +    if (bit >=3D MAX_MUX) {
>
>
> if (bit !=3D tag) instead?

Right, thanks.

--
Roman

