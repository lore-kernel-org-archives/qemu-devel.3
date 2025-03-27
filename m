Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0A4C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmg4-0004MV-Dm; Thu, 27 Mar 2025 08:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmg2-0004M7-NI
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:49:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1txmg0-0000XC-RN
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 08:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743079779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G2U7YXHUQcYg3ice4/xd3Jvsc2gSolE142a3yJhhyMU=;
 b=g/UiFb7c4BvL8jv6MJEqbnWDAniSk1e75uHy29Cs7OrG7i+zdQcc3j4txr/fEJe7DAm04x
 K+I1mQghhPF//bAHojiOtub+gGrnDOSh/3LScBFs0B7Lvd+yyKvhvTeexdSBFpd3xgkQnw
 jm1CwUwNELYbwe9rkQYDC3n9/hFCbqo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Uy-9xiEEPI-JU9zFyh4WaQ-1; Thu, 27 Mar 2025 08:49:37 -0400
X-MC-Unique: Uy-9xiEEPI-JU9zFyh4WaQ-1
X-Mimecast-MFC-AGG-ID: Uy-9xiEEPI-JU9zFyh4WaQ_1743079777
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7271d7436acso1288517a34.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 05:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743079777; x=1743684577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2U7YXHUQcYg3ice4/xd3Jvsc2gSolE142a3yJhhyMU=;
 b=iamoqiVyofuiEqDcq+e4hWVgx4EO8gyP+8tymOLyxnm3fY4vUmQodaDXc/0IfN4ClU
 ELimxV/eh6gsFfLfVcgm5n+xuiruh35Ung5Utpf3XF529F24imfIuwqfVlXu+YNiG//x
 Q5mdC9hcqkmJVgdftf4TBpoWaoZerdfaweEzZkIiyaBWWOcdNN3mX0vLeugkO1Vi4vn8
 Gfx+esNq1Lbx1hgkOgA/mse8HM54tlByl2Ktkp+NIsOMlCii7J7ljlNXGFCSIKB8Q6Dr
 0ka+s5GwnpOoCNkgLzSaSinJ+XPtgGVSowOn/k9k/7W79BkIyU+uzd2GFbLLGjBdRSW5
 VAIQ==
X-Gm-Message-State: AOJu0YyZu26K82D8o33+VI7js2HWy0iwy0u/XKbvZ2h6+SfC0EID2ioH
 dcu7dZv8JQsPkCb5gW0+3RnF7zm6wgh1r56qK0nioACHWwd8uh4MyAC0ht8IywXPgu/UppBeJWa
 9fcy2q/AgDgQ7aD5L5B5jD/Ylr/d3nHHFhMjyiIWRTDWoYHGZmQISON9gLjAex7grYAaoydhei/
 DGOIqH/wZ5WVbBSoP/lOvphENRFJM=
X-Gm-Gg: ASbGncv/bv9c1TzhVhmJ7L0C4oiQzdPa6ePUOzCItqn43I0XWqV5EB5pHuLkYzpF1Sx
 +FTMRiAJ2gcO8e2K9cPPHWuIIvW9rTxlu5uQMqYuedOUOUiEy0JInTofrtGjDfaebuTHxhLRQG1
 E=
X-Received: by 2002:a05:6830:631a:b0:72b:81cd:e123 with SMTP id
 46e09a7af769-72c4c98beadmr2399191a34.16.1743079776964; 
 Thu, 27 Mar 2025 05:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhv1gx8bvXqabljnXuJJjM4So6XM+lmS5Bbt+OZyfwOGVn8CrqJypINf3tdHIygV06aKbnrKZYTYjfpr3N4Pg=
X-Received: by 2002:a05:6830:631a:b0:72b:81cd:e123 with SMTP id
 46e09a7af769-72c4c98beadmr2399179a34.16.1743079776562; Thu, 27 Mar 2025
 05:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <97f99f82-6a82-471e-aa22-65604fa5f509@gmail.com>
In-Reply-To: <97f99f82-6a82-471e-aa22-65604fa5f509@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 27 Mar 2025 18:19:19 +0530
X-Gm-Features: AQ5f1JpJpln9-8uBtVciFLersOL2kvXy_UfBRC-AT7A7HjfU0b6OVpReBnWwF0k
Message-ID: <CAE8KmOxEUaxDUv=B+hwKB1igJF6Q1B4vXg1JW0ujEvyMZwKy6w@mail.gmail.com>
Subject: Re: [PATCH] hw/net/virtio-net: fix memory leak in timer_del()
To: Zheng Huang <hz1624917200@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 27 Mar 2025 at 16:15, Zheng Huang <hz1624917200@gmail.com> wrote:
> +++ b/hw/net/virtio-net.c
> @@ -422,7 +422,7 @@ static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
>              }
>          } else {
>              if (q->tx_timer) {
> -                timer_del(q->tx_timer);
> +                timer_free(q->tx_timer);

* free()'ing a timer object while setting status in '_set_status()'
function does not seem right, probably timer_del() is intended here.

> @@ -2844,7 +2844,7 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
>
>      if (q->tx_waiting) {
>          /* We already have queued packets, immediately flush */
> -        timer_del(q->tx_timer);
> +        timer_free(q->tx_timer);
>          virtio_net_tx_timer(q);
>      } else {
>          /* re-arm timer to flush it (and more) on next tick */
> @@ -3982,7 +3982,7 @@ static void virtio_net_reset(VirtIODevice *vdev)
>      n->nobcast = 0;
>      /* multiqueue is disabled by default */
>      n->curr_queue_pairs = 1;
> -    timer_del(n->announce_timer.tm);
> +    timer_free(n->announce_timer.tm);
>      n->announce_timer.round = 0;
>      n->status &= ~VIRTIO_NET_S_ANNOUNCE;

* This timer_free() usage does not seem right, likely timer_del() is
intended here. And a memory leak is happening due to another reason.

Thank you.
---
  - Prasad


