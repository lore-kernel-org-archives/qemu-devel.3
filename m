Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36309C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcojH-0007D8-Ck; Tue, 28 Jan 2025 11:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcoj5-0007Al-0j
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tcoiz-0007rB-2S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738082761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=efxaRvhY8NC6l3roRVWkiqHAumPFkoMcgmnKk+do224=;
 b=fJD8G5tOkCL+v2BdIZb3ID3w0xtAELhbbFugCo/w5uHyfP2iea9ajJYriM8Bo6Ifh3kZjE
 nQiGZJ2q5siJhZCLML/0Tg6d19y6CjZDkypIjq1XUZvm4W2emc6/rTRiOTQHzn9PJ5OGEH
 qKPV/xyAfvj4mE68mW5uHHBREg2tEPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-cfeDpZX0Pue_K4xAXJedIA-1; Tue, 28 Jan 2025 11:45:59 -0500
X-MC-Unique: cfeDpZX0Pue_K4xAXJedIA-1
X-Mimecast-MFC-AGG-ID: cfeDpZX0Pue_K4xAXJedIA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3860bc1d4f1so3573786f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 08:45:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738082758; x=1738687558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efxaRvhY8NC6l3roRVWkiqHAumPFkoMcgmnKk+do224=;
 b=YCL2iyvmdxoIvd4FBKYOFhlOUoY2Jz9cwy7FObm/gH7j/rGippyQOuJJL3riZ2CdbN
 +8oTpkrZVSCm2L7XOs9zQJxpAn9fUdSCJiMiQppIVthkglx8koFe8mzDsjkXv1Qp4Vdu
 C/cz+iRJszWcXaE+8IrjTXLW2+Rt/lR9jeEdqIhdtL5QPeWfZTX8lE5ZJ9dc+ixi6zdF
 L6OnyeiWEXKpNojL0s3ErLP+0SS8Qzj/WBf9gtart4h16ug6az1f7TRjeXhGygKtq+td
 WLFPUgeHZ1NATYdrxfpIzIe5COK9T0qIpM8NT0qu3kpvgqn9/IJd6tyyP3ez9jHyONyT
 yC6w==
X-Gm-Message-State: AOJu0YyGZyqubwRWvMqHsulozAb/AUrvkp3Bt9N4ZjD2e+aIFQVrcztN
 teGBVL76dInfxJTveqJ4Xc/svd3CZ7wpdkqYLnhaJCX/KyTzU9nij48fd6kizO7O648dQ8w+FxC
 qzKZek4wWanv6cYuoLYjBtKiIOlRobAZhGHae6HHeEgdDukL+pOQ0IW/BOksAEf500WS/3lnlYJ
 rSRAc9qD5/oG4ZigKvcklU23bcHmE=
X-Gm-Gg: ASbGnctFqfOxB6R2GPD9P2r4Rxhkkk6m4wsM9xHSeZlOnDrK61FWomFVycVhTnEXWmY
 +CL7ysWBZ0xMShVjx1Cqn54kIoAlxukPRBuUYBHlQ1twWxCx2Plo1K8JvGgEahfg=
X-Received: by 2002:a05:600c:3d05:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-438af40851bmr244782905e9.1.1738082757888; 
 Tue, 28 Jan 2025 08:45:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjoj0oGOmwmArvq2cY4fhuL27bzj+7Q5IZUoCvH4dT+V9uVkdh7KcMiLsoEel52dULuFZAXRpibXWQmXOl8PQ=
X-Received: by 2002:a05:600c:3d05:b0:436:469f:2210 with SMTP id
 5b1f17b1804b1-438af40851bmr244782655e9.1.1738082757512; Tue, 28 Jan 2025
 08:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20250127120823.144949-1-ppandit@redhat.com>
 <20250127120823.144949-5-ppandit@redhat.com>
 <874j1kufin.fsf@suse.de>
 <CAE8KmOyj0DvODhRVoyaqGaTSe+YDV8ymieFwCgnFZM0rWRuK-w@mail.gmail.com>
 <CAE8KmOzCwr_vMYEGXR9RgAHb_hFp+wRznOhp+xxtDMGxaa7eGQ@mail.gmail.com>
 <871pwnujxw.fsf@suse.de>
In-Reply-To: <871pwnujxw.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 28 Jan 2025 22:15:41 +0530
X-Gm-Features: AWEUYZm1beJE34BJmWoT_-VOF5UBm5ndWLM9tVK5b-db9AuDSX6EJcDjHCoNMV0
Message-ID: <CAE8KmOwopa-V4srKDMm-XmaFH+yPie-1CwuJZzGXnBS+oLuwbg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, 28 Jan 2025 at 19:20, Fabiano Rosas <farosas@suse.de> wrote:
> You could include qapi-types-migration.h and use the actual enum, that
> avoids the burden of having to keep the tests in sync with the code.
>
> (I don't think keeping the caps in sync with the current-version tests
> would break the compat tests, but please consider that as well)
>
> And a generic helper that calls migrate_set_capability() for any
> capabilites set. That solves the capabilities issue for all tests. We
> can then move some default parameters setting into that function and
> that should already reduce the number of hooks needed.

* Okay, will check.

> You can include it in this series or send a separate one, whatever is
> easier for you. But we need to base this one on top of it eventually, I
> would just send everything at once.

* Okay, will send it as part of this series then.

Thank you.
---
  - Prasad


