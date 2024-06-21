Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A324C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 13:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKdzx-0002az-Pl; Fri, 21 Jun 2024 09:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdzt-0002aU-59
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:08:09 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKdzp-00037h-UZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 09:08:07 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so2010280a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718975283; x=1719580083; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8iEdyYyXY4c6mMXAyMkgK09iUTIHytWg1CbgaBKPntY=;
 b=OwbDcbyqHfSVYRgWjOqKhg5CuLMqXm55nNo03Ej+9T6NXN7qupe/i7LikK6OonZ9vC
 tx2/v18CvJQxVwpd4zrlcH7a96FGdcZCpvkSKqCcZsC+5MO5v1c9Ecje7f3CyDAlqzFd
 ghgkrfWjkChODpLeVFApwvc6P7kHEnF2NjxKxsAA3OI38H2Bimp70QfLwLBcQQGQG5zW
 5rMpKpGn2kAsUA/7okrY5YMZaLV3cGX+JfhqFvH78MVHgZldlcXg73cLZWR7hTnTjEGx
 N3nm9gv7no5NM0DIM8tH2rQBRcJojA8EbY8K/CslulTMf2Yh2XIfbA5iudNMm/NwQf/t
 oBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975283; x=1719580083;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8iEdyYyXY4c6mMXAyMkgK09iUTIHytWg1CbgaBKPntY=;
 b=OhL0tUCh0S4veY2Rh1wcC3mgIO23r9UfqirbyfsAMCdQjiKAWp2Q+sQ/EaRyIS0HJN
 Ivh4aIqgh9CS3QK8o6cMz6ybKJKLl/JS7I5PbeTZYBsDeJzUTICa6J2Tcd2QQHdCWlwg
 wqJXDoIxXSjtvckImMLdpEyRMmSr7BXHSjud5vLjz4LT1CZWeKvwAe17y9W6uNLE+Q0F
 xQ/StIW9sVmDvBGP8q2WqWGkNbVkiQp1UyqNxzSzUIgUOdBgr71vaiPqI7cwNjQN9EqU
 foGflLEBiZoLglcFkM0ufeYum/Mpu6dZvRUJubBDaepr9r29U0cQLVSZaVWfMmmrLqr+
 CW7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRdjfiPeguUtuCWYwD90Lsya8J9mDFXZHYhu9QLuVKZYDC9KtLvV7EAD7BVeI2vgfUNEM39ELvESsUOelQYtkNWiTjBYM=
X-Gm-Message-State: AOJu0Yx6fWU8RrHrPURduQv+2EvgueS83o6vbXL+kTbH6fKNPVUnQAql
 0j43Doo7he4QTLi8j8nNbPpaORYfn/nIS2Ud3qclsh9+LF8XdUCrGsTACkX/hP9ahY1ciNnczJv
 jLS5Fw0E/7eoTNzee6SQ89x29L98SOacf98JKTA==
X-Google-Smtp-Source: AGHT+IGuwTcpbE4mgPLRLjZsFMhp9qnZNEBJ6dikFtycb0ExBHFvVY9Q8+7HNRCmwHFhOGiDFvFxkEoiI1+qHuuLWEI=
X-Received: by 2002:aa7:c392:0:b0:57d:107e:dd79 with SMTP id
 4fb4d7f45d1cf-57d107edd96mr3951357a12.26.1718975283451; Fri, 21 Jun 2024
 06:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <adPv4goMCNmjeDRUK1LGCAHIZdOxvMoFAqlU1bCnvTCPsCTUFRQnOQnThBC3oIzU9IczdS6aw1vKLQ-w7Zk9CRo5FfvINiaInut_U4VwbeI=@peterdavehello.org>
 <CAFEAcA_D1+BUk01mXNwRehxYqyXQU+Zu98sWBujauk5L2tHh3w@mail.gmail.com>
 <Zh6qLCvyiSk6YkVy@intel.com> <Zh6oIH8Ihyn-9RwT@redhat.com>
 <pTgk5-fHZzZe_qQn7RdevQ7Dg9Yz_-I4jWPpYknkgbiStJvLCRlTj9EpfRY_K9GCqdSABB_s_xzuGBCxxRqDfzDIoO6AVcvP-onYk8yRiWI=@peterdavehello.org>
 <ZiCDzzFDRmQGPtDD@intel.com>
 <Fu0jQm-Z4E7D_J11oxIlfRJ9ZYK_QDKMYOs-9NNVX_jH9_aS5_9cyysois3SaVVtuTqR-H77MiwWLaa5RkPTEnCEdy0NvUmOuwqyirCbdhY=@peterdavehello.org>
 <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
In-Reply-To: <5qJ0Q0ZnUCu-VdtMQOwzj54wLBfeXb9ozncO8PjFiOlXbu4RHQeVCZyn7ZMWq89yqqE7GZX3Bsuk9YqWugHmx-Wu4Oh1GZ5wboTuZ-QUk8k=@peterdavehello.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jun 2024 14:07:52 +0100
Message-ID: <CAFEAcA8q5O1i-EDviKf-yN5DAsxsSofA3xa9ChMbn_tC91iNuw@mail.gmail.com>
Subject: Re: [PATCH] Add zh_TW Traditional Chinese translation
To: Peter Dave Hello <hsu@peterdavehello.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 21 Jun 2024 at 13:50, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> On Wednesday, April 24th, 2024 at AM 2:20, Peter Dave Hello <hsu@peterdavehello.org> wrote:
> > Thank you for all your help; I wonder if the copyright can just
> > belong to this project because the copyright to me personally in the
> > open source world just to deal with somebody violets the license.
> > Otherwise, I'm more copyleft. What do you think?
>
> I'm not sure if the previous mail has been dropped. I would really
> appreciate it if anyone could give me some advice. Thanks a lot!

We can't give legal advice, but the QEMU project doesn't do
copyright assignment. Copyright remains with the original author
(or with their employer).

thanks
-- PMM

