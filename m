Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F90C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGrE-0001xS-5N; Thu, 04 Jul 2024 03:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sPGrB-0001qc-8f; Thu, 04 Jul 2024 03:26:17 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <krashmisha@gmail.com>)
 id 1sPGqz-0008OB-47; Thu, 04 Jul 2024 03:26:16 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e9fe05354so453150e87.1; 
 Thu, 04 Jul 2024 00:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077961; x=1720682761; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VmFt2tmkjrED2F+p4Jgi2Im8lxalM94exu7ZMBJhdSg=;
 b=V1YJ+XWHQNX8KziHT/+XGOZqdk4h7v9T5DwFJ7fAJilbMtb17hoEdGn0cQknXCwaHo
 ibYbrdDnyxRTC9CQ0z6jvJy0AXhaZP3/UloWhqCaMNfW55fIPAdsqXYFrGgUq8G4vE5P
 Guj2v3I7XaKszWY1bO27LFb144FeTYxJbJLfliHTujh2T9V8mjfdbq8oe1Cov2YUYe7i
 L9R9LOxw7d3+ZSKzHryC6+nL7AZDghJrk0Ss/jAmdyeUMtM5TDvJXxA2FRaVJEybL3wc
 XZvxOd02Qb+ta3IPH4yhtvcJUZR3qtAWyBom3jXpACd0yoXSDF/QMWVfdYCAP3d468tL
 HZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077961; x=1720682761;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VmFt2tmkjrED2F+p4Jgi2Im8lxalM94exu7ZMBJhdSg=;
 b=uFIJ7Ab4lUbr9BCzxxyAjRC+AQPxgBk6X1+FA+woA6haZyzVrrozmTxU4XWBhhXsaD
 UjPlCVXbkUX7tdAt4bb7SdptE5ZN6ViMf/Lm6mjK68jT/Gn1MugwcPRISAGnuqNvYa20
 +q7BHshU05v5KeeGadxTCx/ACHz0Vbg6n/GwRh9Dt4MVuod0iup9Oek7cAaYLqUpN8cw
 mcRYEo2qzHerOk0SLlfZVH9UePhpvTXCFaKIZrDvIo9RK39RRI1uDL/GCMGpjMZyDS5d
 LG9n6VpeIHkmEoMUXb5X97pq+1u7dKE0UJyxVytHZsiXsw7OfzrFji4+9uldaWO4KiHK
 ud2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURQ0yaRZELZpeL787EZXaGCEcHzyWsXgvKDzk2Krq3o5/tx9KitB1OjABWhsRwBwOSExOjSVZD7Ngz4h6UmVFjhYPYlMjd+mq84HHA4DM7Ejwx/7FBNzU39oyz5g==
X-Gm-Message-State: AOJu0Yxxs/EmYcK56nzm2BUnvw6rXqmWb0L6zRkAfVTgleiZnQ0/IlQO
 daEdtTvktPguURgAcC27tZ1VF0CA/yKSwD5sDLLWUvDwi+BQKq+h
X-Google-Smtp-Source: AGHT+IHQF88DHG//lgj3bTced6RGQnJe0WxcIf4s9AcRD64DmIiXUDo4U2WO8Dm00k5NwKPs7Yfc8w==
X-Received: by 2002:a2e:8795:0:b0:2ee:8d19:85af with SMTP id
 38308e7fff4ca-2ee8edff25amr5197171fa.36.1720077960276; 
 Thu, 04 Jul 2024 00:26:00 -0700 (PDT)
Received: from [192.168.188.220] ([94.25.185.41])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ee8842b920sm2940231fa.39.2024.07.04.00.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:25:59 -0700 (PDT)
From: Mikhail Krasheninnikov <krashmisha@gmail.com>
X-Google-Original-From: Mikhail Krasheninnikov <mi@gmail.com>
Date: Thu, 4 Jul 2024 10:25:53 +0300 (MSK)
To: "Michael S. Tsirkin" <mst@redhat.com>
cc: Mikhail Krasheninnikov <krashmisha@gmail.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Matwey Kornilov <matwey.kornilov@gmail.com>, 
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio: Implement Virtio Backend for SD/MMC in QEMU
In-Reply-To: <20240703160451-mutt-send-email-mst@kernel.org>
Message-ID: <e0e1e2bd-a230-a460-79b2-dd9318e7c92e@gmail.com>
References: <20240703145956.16193-1-krashmisha@gmail.com>
 <87le2ipigb.fsf@draig.linaro.org>
 <7c281582-e5a3-265b-f6fc-80f7a1f01078@gmail.com>
 <20240703160451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=krashmisha@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MALFORMED_FREEMAIL=2.967, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On Wed, 3 Jul 2024, Michael S. Tsirkin wrote:

> On Wed, Jul 03, 2024 at 10:55:17PM +0300, Mikhail Krasheninnikov wrote:
> > 
> > Hello, Alex!
> > 
> > No, there's no patch to the VirtIO specification yet. This is 
> > proof-of-concept solution since I'm not sure that I did everything 
> > correct with the design (and as folks' reviews show, for a good reason). 
> > As soon as most obvious issues would be out of the way, I think I'll 
> > submit a patch.
> 
> 
> Mikhail, if you want people to review your patches but not merge
> them yet, pls use an RFC tag in the subject to avoid confusion.
> 
> Thanks,
> 
> -- 
> MST
> 
> 

Hello, Michael!

I was planning to submit three patches: to the kernel, emulator and Virtio 
specification around the same time - as soon as the obvious bugs are 
fixed, I'll submit a patch to the specification. I thought it wasn't 
necessary to use the RFC tag in that case, but if you think it is, 
I'll include it with the next version of the patch.

