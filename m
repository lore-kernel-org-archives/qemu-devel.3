Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EDDD132B4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vhs-0005PX-9U; Mon, 04 Nov 2024 06:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7vhl-0005M9-8N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t7vhj-0003VP-7z
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730721425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQ7bcLDh4uY2PqNhFo7KOKGicINHRr9H+/mjxoD4Lwg=;
 b=Ik7NAmxGOSmzI9nk8KWIi9QgzxnEOTWk32JURMVbJg8AGMhN9rjXQkl12MREIgvhRYEBlI
 IHBYwn68QQDPVKu3OD8xiy/gdyIk2TZuHh/Bi0cn20kXVh9Uxl9bgFIiN7PP6dei3fb9I/
 P9hlkjlD+wx0rN4iufucV3+v6GUPshA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-dEjcWnl2MPi7Xh_jT-3W7A-1; Mon, 04 Nov 2024 06:57:04 -0500
X-MC-Unique: dEjcWnl2MPi7Xh_jT-3W7A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so35733335e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730721423; x=1731326223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQ7bcLDh4uY2PqNhFo7KOKGicINHRr9H+/mjxoD4Lwg=;
 b=h3zcsWJDDBQV7qCgVYzeUDN/LCihbzXUXn96TSZyvS0ePBjiyX82ILFqSH8IVQVSth
 A9szUtasJ3jWMzCnYOW+A1bWi1auFolXwg56iDyX0XPtDWmvnBt/oc96kpwRhI8Lou4w
 Vt0YIEoKt7GBSb6gzyBvlpEMUn0Hf8czp7rze/FMFywbWviB1AXEa7eR5rX9UoKiwddp
 MkdI5ywZn2HTMEbUhDAdcR1Pl/DXGClfEv6ssSmcAHLdV7hkumbkthNOG/h0mTdqPszk
 +mMbuLD3m7yxFVQHvpot2YkZyhxUIakiKyCRhBuV9P4sRx2yHmHNDEAJWIz/reka4HR8
 PQsA==
X-Gm-Message-State: AOJu0YzPSJTXpKTWD64pbqMNOu09lBElNar01A4Gd1nSuRcPCLjEtRvB
 KGLaFhf8pdj65/e6HNKSgYk0ON5vMc/phy8TSNfZs/wD7epzoemcrKJDofvmzpjAGUvjCc0sOVG
 KlSFLM/6ru+kRNMs5dfjmUDKOWIX5Tc3YNd6SN4bN/ky/sK7KULKYr0w1TYAHkISbqVke6iYHDE
 xKxKgwANq/iyXkXSPHQjqAm01YAP0=
X-Received: by 2002:a05:600c:4689:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-432831cb9demr142200845e9.0.1730721422663; 
 Mon, 04 Nov 2024 03:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCw04du6G8vViHDBPcafKuOcX3Q48w2StczHC/FyVYqkOhsrXvKdXLtnqKpkXpnZYk0grLUSOV5Cr0/4P4MkY=
X-Received: by 2002:a05:600c:4689:b0:431:52a3:d9d5 with SMTP id
 5b1f17b1804b1-432831cb9demr142200695e9.0.1730721422361; Mon, 04 Nov 2024
 03:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-5-ppandit@redhat.com>
 <ZyToBbvfWkIZ_40W@x1n>
In-Reply-To: <ZyToBbvfWkIZ_40W@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Nov 2024 17:26:45 +0530
Message-ID: <CAE8KmOyi+_U2H1r=MyQmppNj6v3mMqpjMyMo=q9zm0=-49+B3g@mail.gmail.com>
Subject: Re: [PATCH 4/5] migration: refactor ram_save_target_page functions
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 1 Nov 2024 at 20:09, Peter Xu <peterx@redhat.com> wrote:
> > +    if (migrate_multifd()) {
> > +        RAMBlock *block = pss->block;
> > +        /*
> > +         * While using multifd live migration, we still need to handle zero
> > +         * page checking on the migration main thread.
> > +         */
> > +        if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
> > +            if (save_zero_page(rs, pss, offset)) {
> > +                return 1;
> > +            }
>          }
> There's one more save_zero_page() below.  Please consider properly merging them.

            if (save_zero_page(rs, pss, offset)) {
                return 1;
            }

* First is called in migrate_multifd() mode, the second (above) is
called in non-multifd mode. Will check how/if we can conflate them.

> >      migration_ops = g_malloc0(sizeof(MigrationOps));
> > +    migration_ops->ram_save_target_page = ram_save_target_page_common;
>
> If we want to merge the hooks, we should drop the hook in one shot, then
> call the new function directly.
>

* Ie. drop the 'migration_ops' object altogether? And call
ram_save_target_page() as it used to be before multifd mode?

Thank you.
---
  - Prasad


