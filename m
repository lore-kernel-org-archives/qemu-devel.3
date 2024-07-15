Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A76C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGqp-0005jK-Rp; Mon, 15 Jul 2024 04:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTGqo-0005cI-Mg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sTGqm-0006SX-Oi
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 04:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721031260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZSxyeJ5tQPfX84/b8fqAfrKmB7GjmQ7sLmYdJrCaHO8=;
 b=NCvFaL7LU0FyL6G0COrYO2ieHlXOaDwQK5bTaBO+hy1Qjza3EV8tVM7T15EqizDAR3lBTY
 LDkzGifajcorzpVj7sZvJGxZ9P8OoSN2U0hqFb2mtls1aGCblZa9pmpisgGEQreLS1RzwU
 Y/F5M45VPmu/zO87esfP4T3G1cGLuIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-TsToQ3BcNEiGOSoutBdzcQ-1; Mon, 15 Jul 2024 04:14:18 -0400
X-MC-Unique: TsToQ3BcNEiGOSoutBdzcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42725ec6e0aso29375935e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 01:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721031257; x=1721636057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZSxyeJ5tQPfX84/b8fqAfrKmB7GjmQ7sLmYdJrCaHO8=;
 b=RQhWNUcVBOGksOhloVbEKoF0ZrsBV1bIwD9WZVVYfFAeHmxVVqKGzblp5KIAdupsLQ
 Kp1NwgWYuGicgU5t7gbtlLiNo1KapcNjViFiuhcXVd6dJqvqfgtmgS9mGe1q3kenvVZt
 poCEBfRvTQxLiPNcePIoQpuNAjMA3tKCezyHp8GySiD2oOOr1tiQ2M+V16za/qZaxwHt
 maBW8iKvgL6n//O/N0oAwlnlla0hqfsHMjHJq/8/xSDlOiWqpyA4EmzuT7g54NuCPoly
 mnw1YVIWdhi4oQFviOm9/K3w5AzAk2wvuX/ESwgovOoqSdijsRf4zu3K8jUBIV1VktRV
 Qw1A==
X-Gm-Message-State: AOJu0Yzq1ZS1z8a/GSoh/BnXaJhre+QbTfihstAWERupVZOicqZami9P
 OOVyBzTvT0tVJiazX0UDcddnm24SE0/XnloUrKCugIS34cCglIBQuKog4XggHLEJiB6C+t0Eu7P
 4Uh09OXiv+Gmf4u4GEvujnzPrw9XKcbFpPozLZbkgiIoZ+tu+PsGqiCsoNz5G6eDhiyVrT1sL15
 qPcEeHqX2JOS8hUFfvA4vp8kjiey0=
X-Received: by 2002:a05:600c:5349:b0:426:6861:a1ab with SMTP id
 5b1f17b1804b1-426708f19a9mr118524105e9.39.1721031257591; 
 Mon, 15 Jul 2024 01:14:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5hX99ngr/85yJHaMTTBC7EKqi9S58qAiYSimDJQbmLX2+AT1EEPW9cfYKUDsEPIbgB8h2zDXTlfW5e3+vMhQ=
X-Received: by 2002:a05:600c:5349:b0:426:6861:a1ab with SMTP id
 5b1f17b1804b1-426708f19a9mr118523955e9.39.1721031257270; Mon, 15 Jul 2024
 01:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240711131424.181615-1-ppandit@redhat.com>
 <20240711131424.181615-2-ppandit@redhat.com> <Zo_9OlX0pV0paFj7@x1n>
In-Reply-To: <Zo_9OlX0pV0paFj7@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 15 Jul 2024 13:44:00 +0530
Message-ID: <CAE8KmOzrAdxGMVb7=hYMOgAOuhhzUT+N0X=ONNN456S6f2i87A@mail.gmail.com>
Subject: Re: [PATCH 1/2] vhost-user: add a write-read lock
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 mcoqueli@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, 11 Jul 2024 at 21:12, Peter Xu <peterx@redhat.com> wrote:
> I apologize if I suggested WITH_QEMU_LOCK_GUARD when we talked.. I don't
> remember which one I suggested, but in this case IIUC it'll be much easier
> to review if you use the other sister function QEMU_LOCK_GUARD()
> instead.. That should make the diff much, much less.

* Yes, QEMU_LOCK_GUARD simplifies the diff, but it may extend the time
for which lock is held, delaying other threads, is that okay?

Thank you.
---
  - Prasad


