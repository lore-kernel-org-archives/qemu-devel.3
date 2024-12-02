Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4D0D78327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7fr-0003SA-6p; Mon, 02 Dec 2024 09:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7fi-0003L0-IA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:45:14 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7fg-0001Vv-Ri
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:45:10 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-51532deb8a4so1157209e0c.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733150708; x=1733755508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+uFdv1eKDUY7ikqYxJSBodTTKTXGH9PfRGs+PQzJXQ=;
 b=h8GygO3/9h8TB462BboYl7UJi8Ijnt8QgZRBBpJRm6WajTLb8MfcjKjatQ+pEqdg21
 Y+dawkuczd9/xkmdd5/UTi4qu7snKWx2/52npPpWwRQCofadQxvXQAQqpdx42BnKAvX3
 A10KxG1C9//YdV1E0063e6ji16F2WfHvX4OkjsQTvm+xffRcd9KYFCXb+SWX57w35XP5
 N35Rn3ED4S3w4QLylIJHF/My8z2lwnFi8hW9hHDZ3e5kZUsp2aWHDGWdDFudvdw4nDtU
 jojrLAInSezv1oL4FlfzaiCJniDbOwdYGnnTFl7To5llh7ZHp3DRwM2wSecNo2bgebQ1
 UxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733150708; x=1733755508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+uFdv1eKDUY7ikqYxJSBodTTKTXGH9PfRGs+PQzJXQ=;
 b=p7v2qqBcVGmwwWVIlIncz7vH10wADHB7kLN1lk2J5ALSI2ZyELHc56A1dII4AhIHaI
 vskHzRRafeZYvXegr9srk3wlpqlc/SeNtsDpyJblT6L2qRkuhzEzDFdpl+N9wwGI0eQ4
 oBDi3KRxL0+kINk16roMMLBIWWAIHtijK9aWFdEBs5SOScLQQZMHEaFqH2rZwCmK3raX
 bq2ncy1M7Cb6mLv1Nih01omrtISeoLG5RbCjVrJyVnsw1T5gkQkr0o/y6Q6jBIO+BRry
 p7KgIenmE1y3BVAFi/8nDIpT5JXHopUJES3WKHRuHheDSaqGwtLj6tljSnSD7NGrZoIZ
 3F2g==
X-Gm-Message-State: AOJu0Yzcq06X3d/e5cdD44x6GeuzWU5TOIe2O6lzN0GdPdio6aJ+DFZJ
 bo6JpNRXs4v7I83HMgzqEjcYdyT3RwcHsvqu4hVDaH7DcVOSVHZ2OMe9TBYEU4cYgg3mDj6grAp
 3UNsiZtfNzkcSC4NVY3H4PY46cpgi/g==
X-Gm-Gg: ASbGncuhJrkIb2yQYPxsclYsj6RDPHBzwH0vrK6sR1hXq47BhPAEcVI3+5NCbWiU8ao
 BZ0S5xpVSJDe+xNXFdkpkrWmW9NobK2/Ddg==
X-Google-Smtp-Source: AGHT+IFzSNrhu/TbnDXiiaLhGYMviHlvB6iHszPsAYl2FTiO6hjcnOFAdO0+uwKoCIvW4ZQB5AyDlrkzElBxxD0a+qY=
X-Received: by 2002:a05:6122:787:b0:515:5008:118c with SMTP id
 71dfb90a1353d-515569347b5mr27808310e0c.6.1733150707700; Mon, 02 Dec 2024
 06:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
 <44fbe3d8-509c-47ad-b764-5c8016980bfe@amazon.com>
 <CAFfO_h5LHsgng5itQTEO30SUT_jn02Pdi-0uYvyZCgRPJfcueA@mail.gmail.com>
 <2970cc68-a34c-4751-b4a3-d7fac416d7d3@amazon.com>
 <CAFfO_h47fHYfiU9vgU61UT+jSnv9YCO8jTy+hB77+AQc+NZ7+w@mail.gmail.com>
 <CAFfO_h4xpJY=sz2O8TcYqwdXALZ=g6MQk=w0-_EuPkgKPcG11A@mail.gmail.com>
In-Reply-To: <CAFfO_h4xpJY=sz2O8TcYqwdXALZ=g6MQk=w0-_EuPkgKPcG11A@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 2 Dec 2024 20:45:16 +0600
Message-ID: <CAFfO_h5v=ddJfqw78GVs6A891xCAxWcmW2j-kr4-6QaexW2nqg@mail.gmail.com>
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Mon, Nov 25, 2024 at 9:00=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> On Mon, Nov 18, 2024 at 7:12=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com> wrote:
> >
> > Ping.
> >
>
> Ping...
> This is a small one that can be reviewed and picked up for merging. Thank=
s!
>

Gentle ping.

Regards,
Dorjoy

