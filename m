Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45864C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeHI-0001gV-0I; Wed, 19 Feb 2025 02:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkeHB-0001ei-Aw
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:13:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkeH8-0004kL-RL
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1OQmW/545m6vLkAaXGANmHgJQOp+/h/1m9CYCxBnQM=;
 b=fY72PMbek1FM5iFvfi/HYlzOk9R7mQ2PNK4U1/qsnauo0spdmhp4Gc2P5xQ/WHe8sv5qOX
 74Itnr2R4vy1zEJFk1I2ANxvWEIgbhUrqBbjty16NUG/mIZ0qUJ+N9I9eQCF96c8GXGfMh
 Io/J3maQLh4lSXTvtqupX7PZCuyInRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-2yjxOaKhOBOLPH79-II0cQ-1; Wed, 19 Feb 2025 02:13:39 -0500
X-MC-Unique: 2yjxOaKhOBOLPH79-II0cQ-1
X-Mimecast-MFC-AGG-ID: 2yjxOaKhOBOLPH79-II0cQ_1739949218
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4398a60b61fso13308815e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 23:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739949218; x=1740554018;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1OQmW/545m6vLkAaXGANmHgJQOp+/h/1m9CYCxBnQM=;
 b=m1/H1X8yZd7JexXz6FZJdYfw9w7Ropu1jCVCHdkwFzwStqi9KXQxuWQGF/wyynYP5i
 X5joXCToGMOuyMzsxIz7fU/QSggMdsEY9aaYXQKDhY7djNLjMobf78VTIlxZMqdyJ9Xx
 aJG8nd//yggQxSjoJXqLcB/a+DULUdNytqpftv/tUDNl9vBDzkiPqk4kN/qJHI/g/V6g
 8jNn4UdBr/tM7tpWuiV8ClKw/rWdYXX/qdi/ZN5LAGBgQfBC9xsBXCX35mHQCzIb/1DK
 zYp4cjj/cEYsv0oz/EFavOLwgUuhHUgq/uwrxjfzpPzq1Ss+6zGwOv3S8YBzPNTN4nJk
 Jnxg==
X-Gm-Message-State: AOJu0YznWC/AcBIAsAZrLkymL7O4+BVz2rXcDjVjmvjMH1NJsgEAk3eg
 CdBOyo/mEiPObPyBaLNvoAAQJrdyjQTqKg1uzjghWo9jny/r0qtAwx2+cnQKUtG6i/fYUxdXutl
 1wF4Rur8EYh4lLT7rNRp49oB8Yc9Kp4zC4m9akbxxRjRy8bVPWjQ5RND0HQF45N1jtKMkuzBtwp
 iOeDPq1Su8WntjCSuLGPXuV84BghI=
X-Gm-Gg: ASbGncvPRU1XbY1BFvWSVJ310bOxKy5eQ+idTs6YOn5DjyKZRpj3U1MSPH5EUgT8N3Y
 jgH2OmJMbM7FLTrgF4AgF6eTVbBT/S1hl5jPedEyCQ/+ZUgqzVsdc3mRzrSh2BUru
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id
 5b1f17b1804b1-4399898f441mr28016305e9.26.1739949218123; 
 Tue, 18 Feb 2025 23:13:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6YkpF1Xl2ah5WW3gdvRtWXOhDfbCp+Zl4yxQEj9RgfGmcou3Uzt8N7y1eaPUfd9d2P1DeeGU/iP2u2bRHEWk=
X-Received: by 2002:a05:600c:314d:b0:439:9898:f18c with SMTP id
 5b1f17b1804b1-4399898f441mr28016235e9.26.1739949217883; Tue, 18 Feb 2025
 23:13:37 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com>
 <3abdrwrfqm2vxbdtprqjckkgwmdb4xf2rcjld6eiljyx5uwepv@plbn2lz6nrug>
In-Reply-To: <3abdrwrfqm2vxbdtprqjckkgwmdb4xf2rcjld6eiljyx5uwepv@plbn2lz6nrug>
From: Prasad Pandit <ppandit@redhat.com>
Date: Wed, 19 Feb 2025 12:43:21 +0530
X-Gm-Features: AWEUYZniANEUnjSIQPfcB20Cnqiad04WRCZv0uf3xjWYgZqWFnf-v0jm6nS4wFc
Message-ID: <CAE8KmOyEA-768kb+5s+4vTRVnng0pd0yTwZtDSexTe6bvq+egg@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 18 Feb 2025 at 16:47, Juraj Marcin <jmarcin@redhat.com> wrote:
> > +                error_report("%s: unknown channel magic: %u",
> > +                                __func__, channel_magic);
>
> Here, the number reported in the error will have incorrect endianness on
> a non-BE system. I think it would be better to convert channel_magic to
> the system endianness right after reading it. On top of that, then there
> is no need to convert constants with magic numbers when comparing.

* Okay.

Thank you.
---
  - Prasad


