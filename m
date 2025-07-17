Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B681CC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIOn-000262-O7; Thu, 17 Jul 2025 02:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1ucI74-0001Jl-Tb
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1ucI73-0008DP-5f
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJnNR3wyN34m4jqe94oZh8+6TcZR69dM60UnOBANE14=;
 b=b6IeK9TuomsGRbK3+JsKvwpG4Wsf/mF2RX+sc5Ia3PPEA//upw5vGQwOOGcwW+0i3OGcas
 JKxw7O2A/UJ2ca1hD1h7+KwfGiGVq3xwCGIXQ6K8jjMJzvFbYbkzg2j1uLhZW2Hpb6uRXB
 4X0xNOvI7vjwK22CltU33gjuhnRzOgg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-O_ijPjrdP4mtranawJuXHA-1; Thu, 17 Jul 2025 02:28:56 -0400
X-MC-Unique: O_ijPjrdP4mtranawJuXHA-1
X-Mimecast-MFC-AGG-ID: O_ijPjrdP4mtranawJuXHA_1752733735
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4538a2f4212so2450815e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733735; x=1753338535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJnNR3wyN34m4jqe94oZh8+6TcZR69dM60UnOBANE14=;
 b=PD6c2aHYqiito8c++tai0tKS+JaPhmYSb6lBGb6eQCHjcHYQrcagkuNBCzktORmd50
 D7PY7n+Kxz2NThLNuBKdIUvr7g59Du6n9Z8YPUgueujgbR1c8zHMIZvTVIKOy+kE4smh
 MPAF51L0lSdBMOF/8NVcVt5XlSlpQ557bHboVSEVggEfxsdS13urd/OW4oW74S2Dz3nT
 +mLNrWxX6hYW6VG1uYD13aD6OfTdSBuozXTVoA0pDwjDlAJRVuS0XlJFA+AtQn/yPq7U
 /7TOabPcUUfnB1cOv9tVXgZEW+CjQ+eSwHl/goysYExM26LIOsKJOggxsekj/2f05qii
 3M1g==
X-Gm-Message-State: AOJu0Yx9iX2pGx6Rx0bBmnk7UE5NR6wejQD0HqP4JV6GnGWlIuHm77sq
 g237u7hmYiZZO8703q0E089i3vYMFmkyYAGRfqVIXZPdwgvBQgyJJ7qBYxpzIAtavktztqtxeZi
 SEgAfMVJZRVF/JKLDnVJNw9gs0F0rVSJz1py+fmCwMWyKnxOWY6W88F/uNQJ4SVCiTqMux5SH9d
 N1kxhEuZZMb6SAtHFAxF+N1sB1CRP3sow=
X-Gm-Gg: ASbGncuOoRf4busXdrG4HU2m/aBRpUI1DFWMPIvd7GUl+m1M2fTSpUEID4lFkYLMbxW
 zk3u14nmmey93MZtZjjkd6PYlR2DPudxGE66WHhtoDwZO3b/YXI4/JPy7/xhyHwRZAOi768BYCk
 Cb/Ld9BFoQBQPWdYo10W6CYw==
X-Received: by 2002:a05:600c:310a:b0:456:1608:c807 with SMTP id
 5b1f17b1804b1-45635d86bcfmr6314375e9.26.1752733734952; 
 Wed, 16 Jul 2025 23:28:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3yrgCZTMCRyP0NrK5ECKX4ROjLZmnR1r9WQsJ8iSVnVS2r/0B782deICvohJ+rZi42yOX0DSU5lTU22S6KfU=
X-Received: by 2002:a05:600c:310a:b0:456:1608:c807 with SMTP id
 5b1f17b1804b1-45635d86bcfmr6314225e9.26.1752733734547; Wed, 16 Jul 2025
 23:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
 <CAE8KmOzrFF79P4qUOxH4UtzuymGUWTcSLQan-ee=+EaVwv2dBQ@mail.gmail.com>
 <8734awmf5m.fsf@suse.de>
In-Reply-To: <8734awmf5m.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 17 Jul 2025 11:58:37 +0530
X-Gm-Features: Ac12FXxHkafwEwNGdbc0m5BPVgCKxFEijFrcaUagRKRS7bqg57UX2ym0deRio-g
Message-ID: <CAE8KmOxPLS9Zd+_uGRSBJwxDb6NcqOnLK7bTLeJ0mKKUs+gMxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 16 Jul 2025 at 19:06, Fabiano Rosas <farosas@suse.de> wrote:
> The condition should be >=.

* I'm thinking of doing away with the loop and the string array. The
array has 3 values of which only one gets used due to conversion to
seconds.

> But then that's "0 sec" for 1000000 us.

#define US  (MS * 1000) => 1000000

When us = 1000000,  us / US should return "1 sec", no?

Thank you.
---
  - Prasad


