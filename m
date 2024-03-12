Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41524C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2K1-00047d-HW; Tue, 12 Mar 2024 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rk2Jw-00045u-FE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:37:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rk2Jr-00030f-D4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710250645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uawsLa3vQQieomSOJZ7BETMyvWFfTvmQgx0jzL8BDYY=;
 b=HOXOweMDKHuQoS66e/VIrarOH53CB4/utUlD33ru0tcZnAWTWd1OkJ7M2IkM9pu2kV8GWK
 a4pij6RQa4ApmYHgXu6UZSH99mxSuJ2qhgPHuFLyiqUMQ+y8xxSDdHgKCrBTP2lZCqgrSV
 /DO32xkQW09db35u2XcXuuZYiy/3FiQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-Af7TEIy8MrWftSohBQGCHA-1; Tue, 12 Mar 2024 09:37:22 -0400
X-MC-Unique: Af7TEIy8MrWftSohBQGCHA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513b15ac588so2071775e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250641; x=1710855441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uawsLa3vQQieomSOJZ7BETMyvWFfTvmQgx0jzL8BDYY=;
 b=ROim1gAkJZws7sUFt71pPcw+GROE5MGvo/j6k+3i0YRiJ0610yryAGFlqWsuWlJ6AO
 0xYvfqjcBYUQStNWBl1UUdPbSSIIcjziq1Y1uyhNIYlksd8iCaL1AQTFcKs32p483NU1
 eOoFIr0vsLLuTbMuewt85/gC5jDCWVh37ASI7qLS76nsobjaRr49tMJYX+iKJq0nMTai
 BB0fMMLmOjkd50UuQYkl6GrqmzUPYZYtRZYFMfkoyhOMCTrYuD//5CgJzsIY6r9TqR4d
 u91aw14b/2wMvWdbH9V94nmEBF4ZCS0Kw027EMiIZoIQ6HW7n0HeerbfT45wkjzrjdQL
 57+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuBTPtQQf9nqA5SVi9QwrdlNX27ORdNAgNsxElfIdnyxIcr9xBT7MldaCX51vbufsQnOXUD7Qzq1ZpbcdJy678dwdkQOE=
X-Gm-Message-State: AOJu0YxOZQLjLG6WWJLG3sW0Rno0h8WoArCo2sVO2slP9jiaa7Fn7cIX
 aB+G5+9CvfBvsRrIM3IrtriNIDpz+orEO51/Pln8zCfbc8YMdJk9ohQfCWGSHrpk7j9u8x3Hrs2
 JvLsJf0uC+dgRAwyTj2Tu5z5wceVas1qVpD/6IY6dG31vru22o0D+kzmrdt9DNYEilLyuA6Ybdd
 cVMEKsUvJvw50TITXamPZFdegtNio=
X-Received: by 2002:a05:6512:742:b0:512:dfa1:6a1c with SMTP id
 c2-20020a056512074200b00512dfa16a1cmr5701205lfs.10.1710250641007; 
 Tue, 12 Mar 2024 06:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXxVC3+25/RG2r8N/r6D8dpnPtp89QK0YSwzGcLINobPi1B2j1WnltbKqP7bgiCoB6aFg4FpK4Xm5eNIDVovM=
X-Received: by 2002:a05:6512:742:b0:512:dfa1:6a1c with SMTP id
 c2-20020a056512074200b00512dfa16a1cmr5701197lfs.10.1710250640588; Tue, 12 Mar
 2024 06:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240311054333.1264776-1-ppandit@redhat.com>
 <20240311130908.GA327967@fedora>
 <Ze8l1fzr0oxIFxO1@redhat.com> <20240311193641.GA384474@fedora>
 <ZfAkPhiAnyaEV9jQ@redhat.com>
In-Reply-To: <ZfAkPhiAnyaEV9jQ@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 12 Mar 2024 19:07:04 +0530
Message-ID: <CAE8KmOwpnVyFQKguQAAg3Y0oQCb8-G1vg_qL9Q_YaQqJC1i2MQ@mail.gmail.com>
Subject: Re: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello,

On Tue, 12 Mar 2024 at 15:15, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 11.03.2024 um 20:36 hat Stefan Hajnoczi geschrieben:
> > > > That can be avoided with a variable that keeps track of whether -EINVAL was seen before and skips Linux AIO in that
> > > > case.
> > > >
> > > > Fallback should be very rare, so I don't think it needs to be optimized:
> You're right. I missed that io_submit() returns failure only if the
> first request in the queue is invalid, and returns a "short submission"
> for errors in later entries.

===
+bool laio_has_fdsync(int fd)
+{
+    AioContext *ctx = qemu_get_current_aio_context();
+    struct qemu_laiocb cb = {
+        .co         = qemu_coroutine_self(),
+        .ctx        = aio_get_linux_aio(ctx),
+    };
+    struct iocb *iocbs[] = {&cb.iocb, NULL};
+
+    /* check if host kernel supports IO_CMD_FDSYNC */
+    io_prep_fdsync(&cb.iocb, fd);
+    int ret = io_submit(cb.ctx->ctx, 1, iocbs);
+
+    return ret != -EINVAL;
+}
===

To confirm:
* Do we need a revised patch V3? I'm testing one with the above
function to check if IO_CMD_FDSYNC is supported. If it returns true we
call laio_co_submit(..., QEMU_AIO_FLUSH, ), else fallback to
thread-pool.

Thank you.
---
  - Prasad


