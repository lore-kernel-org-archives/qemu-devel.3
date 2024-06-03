Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B00C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2Av-0004U3-RN; Mon, 03 Jun 2024 03:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE2Aq-0004PY-2Q; Mon, 03 Jun 2024 03:32:08 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sE2An-0005so-Sb; Mon, 03 Jun 2024 03:32:07 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3747e9f7cceso12912875ab.1; 
 Mon, 03 Jun 2024 00:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717399923; x=1718004723; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwu3hZxgCn+9BORvOjcZflDkvad2eHE42JBDLOVVJgw=;
 b=h7wH0FNhBj5Rjw9ou3DIimL+u072215YtQZun56cALbqHeQgIyRVKyfZuOjgAA4pfP
 12a3E0xHX1YQrPJcJED43Vqc3Mozs7pAmNcEqHK+at1cLSKn88JS9nb981NDG1f+4vmT
 CPmNNhmBwMNDrKmCHuTx8tJWT3P2X8LnyM5+brak4GsYhU/9Tzo7/6FXIFYaFgFWCKvV
 SD3AoQPwbmUSKxbvm5/ash/OfdJs1jUFqVwvOnObG4vIEhQyzhIrJV93Kr24tXhof2eA
 lHLLieK6bzPUuSKD6A/rzmVi+bJ8cFpp5HjCk4bD0UQAZ4kXtjXYvZv5zJ0GcSoYnWru
 HerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717399923; x=1718004723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwu3hZxgCn+9BORvOjcZflDkvad2eHE42JBDLOVVJgw=;
 b=nhl2M48sbqLswzbv3XReDNdn7W9yWgDN4iXIyoDmPMJo1tYyrGRTfQCZ7btDiOe1vu
 R7Kic9FiuN+A+U2KobRnocC/d7P3QC4HeC0MlRrNFRcyeVgzQK9CgkQ2dW1uc9Jsh75t
 rXp0S1qCB+6RNyw/AdGUN3pKkcF5nN1kmNd6qaL5uvgQh+u2ZnszBwPDgvmrMlA5HCVy
 rbqWL9/zInwHowCiX4FvKmRLWWG2S9dzCUHNXTh7+gsMTZ4VxdUbAJL1/y0u2/3yiPs2
 8DaMCKaJFIyIwzWJThmzm6PVfadehNco65ggnSecaozNzcW4OtsGdtqOrvo8fj+ebdOe
 AtHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTAZS/VyT1RHZtubNmRqzWQuSlUigbOe8PsrC6dPHa+Ft5pHZgzmVvgzclb8th50eXKtwas8oVOzR00R4xblNpYg2sHoeNqQ==
X-Gm-Message-State: AOJu0YwnnXUFuux4mINKG/EJQtTw02Vs4HqyDrPPRBs/9EjfK/xbnokd
 rgjEua8AwYeryglzG5GhrnOBhaANIH4ERVIzd2+mqH7M2JlBywpZlabASNhodz2OZ6vcPn4ksdq
 +UXaWaKulERXPwPAwdWhh+By3Jaw=
X-Google-Smtp-Source: AGHT+IF87Hwu4m//+u+7oXnM+r47QsDuswAuI9Soi2ZDQov2ahmsAHZUeeYF92VRsCkSPC2cBxnIH/QUfmifloerhm4=
X-Received: by 2002:a05:6e02:1c23:b0:374:9af0:5f38 with SMTP id
 e9e14a558f8ab-3749af063camr31803515ab.32.1717399923125; Mon, 03 Jun 2024
 00:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240602103810.21356-1-vilhelmgyda@gmail.com>
 <7b93d09f-2926-4f44-9c67-591317eeef52@tls.msk.ru>
In-Reply-To: <7b93d09f-2926-4f44-9c67-591317eeef52@tls.msk.ru>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Mon, 3 Jun 2024 13:01:51 +0530
Message-ID: <CADe4k3+55-EQjkp6320+kUZ99yatoqsh6wEhfZEo7EhTCLAE2Q@mail.gmail.com>
Subject: Re: [PATCH] i386: removes microvm from default build since microvm
 doesn't support Xen accel.
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net, 
 manos.pitsidianakis@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-il1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We can remove Xen from default build too. Though, I think, regardless
of Xen being in our out of default build, the "depends on" change in
`hw/i386/Kconfig` is essential in itself to cover the case when a user
builds with Xen only. In case of a Xen only build by user, without the
proposed Kconfig changes, microvm can be ran with Xen accel. Something
that doesn't work currently.

On Sun, Jun 2, 2024 at 5:43=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 02.06.2024 13:38, Will Gyda wrote:
> > i386: removes microvm from default build since microvm doesn't support =
Xen accel.
>
> Hm.  Maybe we should remove xen from default build instead?
>
> Thanks,
>
> /mjt

