Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C3AC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCNP-00037G-01; Wed, 26 Feb 2025 03:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCNN-00036q-4U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:02:41 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tnCNL-0008Ac-L1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:02:40 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54527a7270eso6523697e87.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740556957; x=1741161757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WVNZiuGTDbaCo5Vkd45s/XtKphR7hD0g5ktY5NtxbM=;
 b=CS1hxQaTNe5lmX3Ttyvy16UaFKOv32/Cq3DijX00fgazzGr4CSKZYWw5TcWuDebJDY
 y22UVDEmvu0VDRRmkN1UzuzXWeWH9h0u6hEkNy2dk5/vCrisGa7s9CnILLPvPoKe0l+t
 wwE4gqYvRJDGgJvltMykqy1UcEtpKc/YbXpxHxhJ4T73DRl0qdKASV0f/WvqfenYb6Gd
 DHXXAxYQts3LVN61wBJqnHaNw3cyA9u1t2DOKIYWQclzE9EFzAuVTseZDtDTADbZdJGK
 JKZpM7GpEvr3PUT93WPUG+Ewc6VVZvCfK+yOxFokUITDMsZ+/bFfmDHaByMUFwRwr7tG
 wyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556957; x=1741161757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WVNZiuGTDbaCo5Vkd45s/XtKphR7hD0g5ktY5NtxbM=;
 b=e01Ma6XyJLM3WB6umlAoUmZ85uqoR9+A3am2jalmsAtGMNtidD0HHS4K/HSc82RuwB
 8mBSmcNjeCDDQVgOfM8vf2yHGWsb7ZMYDcub6tNQCnncmhmZkEbf1vJ44Har3TzUJPdB
 Co9/r/3j/zZRCBSZWcBQlyYEjGoPBH4rhTPoJU5SnbxU/sOsylnPAjBGp+6cDsu1L6Wk
 A/mWOfLKEEY6h22kVCcCSzStzcfTJc5UiyXxbzesABGYuJFF1WXlVyevE4w89Op45TPx
 CHxsbqajL+O9hCERTz605/TV4CzAtj7WU0EWOf6cJ0ly4M7UnwHkn0sdWTOfALJCbPR6
 fN/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRo/64SnJuv6H2buJFlYKtcZJTHH32CMwW/0WnnFW/W1vTNW34gSdQ98vzNYRZXBNtYHIeSMx2vq/W@nongnu.org
X-Gm-Message-State: AOJu0YxrRqKGEKmsTtcE7Uey3pMB0oIcHpV2Pvnkp5rvm+XBg2WYLdlW
 nku2aT3nM4ddaWiJqZAf4cVO0s102O/MxHHlwQjaugsmu/71nZBD9cS0aULwCvJ5AjcoV1h5B8x
 j6lN/wFuXYtRcrX4zrm55hHob8WA=
X-Gm-Gg: ASbGncswjwt5L0EuPXm3n+exBSntGJzXTPZc3cvixAwxLVQGYqfRoRo9FvTglZcMCH4
 N+L9+RN0yCOZevJlK1KJsRcX+NT1JKRFiVaWfpCqcpmAmbGyo6UNoOYOnrHu9HEcGcp5JtL3Rm5
 VQabtdf1BNmCrLoEnuLv7HREoyzoXWbBs2Qiu4vhVPdw==
X-Google-Smtp-Source: AGHT+IEthVU83U8zWyWF7kQfBYS5uJKy+eeJNt3QaHck2XgW7DHeqBeSUgEb7tBqjny8SFbs8afJkiP1vf1vAo9YehA=
X-Received: by 2002:a05:6512:1309:b0:545:aa5:d455 with SMTP id
 2adb3069b0e04-5483913f943mr10781286e87.15.1740556957022; Wed, 26 Feb 2025
 00:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20250219090607.559887-1-r.peniaev@gmail.com>
 <87frka12zq.fsf@pond.sub.org>
In-Reply-To: <87frka12zq.fsf@pond.sub.org>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 26 Feb 2025 09:02:25 +0100
X-Gm-Features: AQ5f1JqKeP43pATPPSOGq02afrFuO-tUW3Kbk1nE1NWnY3zmLrPG4Lk3hSgy1DU
Message-ID: <CACZ9PQUAvarw7yZxUTYXQY2+n6F=A8aZbf498Mf0rP37_W8Z7g@mail.gmail.com>
Subject: Re: [PATCH 1/1] qapi/char.json: minor doc rewording for `hub` device
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x134.google.com
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

Hi Marc-Andre,

If you don't have objections to this one small doc change,
could you please pull the change?

Thanks.

--
Roman

On Wed, Feb 19, 2025 at 2:24=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Roman Penyaev <r.peniaev@gmail.com> writes:
>
> > Refine documentation for the hub device, specify the maximum.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  qapi/char.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/qapi/char.json b/qapi/char.json
> > index f02b66c06b3e..dde2f9538f81 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -337,7 +337,7 @@
> >  #
> >  # Configuration info for hub chardevs.
> >  #
> > -# @chardevs: List of chardev IDs, which should be added to this hub
> > +# @chardevs: IDs to be added to this hub (maximum 4 devices).
> >  #
> >  # Since: 10.0
> >  ##
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thank you, Roman!
>

