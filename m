Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34111C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 12:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwhf6-00026N-3G; Tue, 16 Apr 2024 08:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwhez-00022z-2u
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:11:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwheu-0006SK-SI
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 08:11:35 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e477db7fbso6906334a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 05:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713269490; x=1713874290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gNEkEPD0tVOI/lu4ivBFdOidmevWvYuW4osF27hlrjE=;
 b=l/ajP8B7BaYZAFamcHYpO35qcaWEsvcS2t4xsYkbEPQDUfBUx/pZm7JUiq/Mzz6WHz
 yNQeGaUDe8n0JPUbLbF47w7/SHtjv5BPMThdjrlaM8k+9ei9IgBZ/cLlA7HnN43IYtps
 jGIVsfB2M7SMaj6Ujn3lYJy/QAITHzy4wcahqZ3JUuuz2u0GSAK3utWv5JPosuUi4j1V
 WIg5iLkXJbYk1AhewVEmTSXMzUcmbQRDCjNvOGLzaNAR6QUhkFXlNB9nOMXXRlmZu4uv
 geqEWWdc7wtcW9tEPE2V9ckdhebdoTemw2lJDeatT4AxM07eJjvlt2Ma1rSClaQqgIMa
 GoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713269490; x=1713874290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gNEkEPD0tVOI/lu4ivBFdOidmevWvYuW4osF27hlrjE=;
 b=PA4XNwQQlEMVryFuk20WaC2Hf9/MZS5fUvNhLqjRPNXI7u7l3YWSvqkTtgFsK6UNsy
 d7CflHbOLvKzTF7jYWuUSkDbSAaF0HbQsc0orTgNvknPXTXTNoNyMZiGC1ROeAfLHMiA
 sSVKQ9A64nbXhh78GTTMXpZnFJChYB4paM0NLa0QJ0++Cj6GOpng7G07GvGwCViLd0NB
 7vAC29DL1i0yz8dw6p7Xu1CY1hINqfcM687tRwOvRq+8HSwYPhnvApBgZk5Bv6fNHA3J
 +ureRFy8SAGcBXPoUKU56BdtFFvrvoxmTFRd79hJC8gfYBWSDUUodIdreJRyFc+oBZvO
 2IRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfwfq0L1Fb4i5LE4U4KXcR+XgXNItnMq6CLCX8bBWSN0CRh7eAGg/wyVO9CPWeBAoW14cz45UMVm8VFOzEnxsbpNPJPPo=
X-Gm-Message-State: AOJu0YwNld/bgPCOmwB8sK3xpxFpj9TP2A2s4qUiQjlBja95q19QgqEP
 TCTkfrvuYVy0Q7WceinTHfabOgSQAmfKcS/1IzMxShlh5C6Zj/UUwetpfY/ypjJbRhiT/Tu5T1b
 B/UoqSi+51YnVPmac5iFS6xig7xHmXmbwk50qTA==
X-Google-Smtp-Source: AGHT+IEv0ZBHJDAIUhlU97OkOWDGkupEzs6AxtoL/cyGpv25ld+aQ1rJz5wOb1MrgyR9Qa3XFcYhWMCBGkCKildDtBc=
X-Received: by 2002:a50:a453:0:b0:570:333:e1f3 with SMTP id
 v19-20020a50a453000000b005700333e1f3mr7532775edb.9.1713269490483; Tue, 16 Apr
 2024 05:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240412144202.13786-1-kwolf@redhat.com>
 <95399e0a-9ec6-4751-a4a3-83e44dedf8a4@redhat.com>
In-Reply-To: <95399e0a-9ec6-4751-a4a3-83e44dedf8a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 13:11:19 +0100
Message-ID: <CAFEAcA-k4p3dW8rmY-hXwFt-MtRgpjMVN2NOtap5AwvbC9cckA@mail.gmail.com>
Subject: Re: [PATCH for-9.0?] usb-storage: Fix BlockConf defaults
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 16 Apr 2024 at 10:26, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 12.04.24 16:42, Kevin Wolf wrote:
> > Commit 30896374 started to pass the full BlockConf from usb-storage to
> > scsi-disk, while previously only a few select properties would be
> > forwarded. This enables the user to set more properties, e.g. the block
> > size, that are actually taking effect.
> >
> > However, now the calls to blkconf_apply_backend_options() and
> > blkconf_blocksizes() in usb_msd_storage_realize() that modify some of
> > these properties take effect, too, instead of being silently ignored.
> > This means at least that the block sizes get an unconditional default of
> > 512 bytes before the configuration is passed to scsi-disk.
> >
> > Before commit 30896374, the property wouldn't be set for scsi-disk and
> > therefore the device dependent defaults would apply - 512 for scsi-hd,
> > but 2048 for scsi-cd. The latter default has now become 512, too, which
> > makes at least Windows 11 installation fail when installing from
> > usb-storage.
> >
> > Fix this by simply not calling these functions any more in usb-storage
> > and passing BlockConf on unmodified (except for the BlockBackend). The
> > same functions are called by the SCSI code anyway and it sets the right
> > defaults for the actual media type.
> >
> > Fixes: 308963746169 ('scsi: Don't ignore most usb-storage properties')
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2260
> > Reported-by: Jonas Svensson
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> > Considering this a candidate for 9.0 given that we're already having an
> > rc4, it's a regression from 8.2 and breaks installing Windows from USB
> >
> >   hw/usb/dev-storage-classic.c | 9 ---------
> >   1 file changed, 9 deletions(-)
>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

Thanks; I've now applied this to git directly (following
discussion with Kevin on IRC.)

-- PMM

