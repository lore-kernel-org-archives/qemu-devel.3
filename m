Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172BCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 19:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3g4w-00058u-Pw; Tue, 30 Sep 2025 15:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3g4m-00057q-JN
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3g4g-0003n5-WE
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759260703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3U+j7qF6Vsl4onp9RmrZTwcluRQ8ZU0GiGa9NOSYBGs=;
 b=dRHcVIVflF6s1BLp+63B/KuUHYSTYKXlISJ765t/Dbb6Q4Wx0K9JNlKhpNea16DozDMtDL
 3HI9gH+cnJolvGGiHq3AqoHQT4nBCkUuJbScDp+uvD9xjDnLWXOU2n9pBXyqad2XPc4DtR
 8n6wIafX6/VjhzjR0aJT7XPOriyyhEg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-jvXKF7XWPHWPvn6ApBj8lQ-1; Tue, 30 Sep 2025 15:31:41 -0400
X-MC-Unique: jvXKF7XWPHWPvn6ApBj8lQ-1
X-Mimecast-MFC-AGG-ID: jvXKF7XWPHWPvn6ApBj8lQ_1759260701
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4dfc05dec2fso112440391cf.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 12:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759260701; x=1759865501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U+j7qF6Vsl4onp9RmrZTwcluRQ8ZU0GiGa9NOSYBGs=;
 b=CW+E5TcC2VqEXatWxMMv7R/nq0cC9qEEpF6RLV8K7NLgAqRuF/P63G9RZKO06be+hC
 XINnJiutu7E5E9dBKnAh4cHI7DdKZiOSwpSN10b2aNZzdDMa1IXMsrtJZH4zhafpV2O6
 lwi3YY4x6uzv1ghTLMOn+XFUjA4HVq2JO+vwEdeQfV+YVyqp4X7+JvZ80nsfwvJacbkl
 hYe2zo/JAk91aoaenDRRUvjCXLpqthcuhHt7TinKZD/piHWJ2b0oDqBHM7A2g2wfsn5x
 z9egMxbfSM8pp9xUCKtoZiHsdcOvMN7Gqj4B3Wyjql/M39qTVXdelttuNASyVD17b0xc
 xwkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWluz9Udv0Xe1R2L9xYJAavfqMLWOIWhZD+/KBjV0H2ZiwGjPE9/CsIpnK+08ysezo3ZtQbPkWnPtQ4@nongnu.org
X-Gm-Message-State: AOJu0YzstQowzbRmwJQfKu796iE/qRxTt/zWbHgJ+RqQtEtJCi+35Yvm
 7Pn1brGJ0tOgMZJcIw1vX3yajvA64dz8xuWieehle4Df7RMvGGElObDT07huXH8F0C2hZwzXX2w
 XgfHDiNjmJ5gVrVqbupferGr7RXO1VFZUAX0pq/bZKQ1R1XH4iOn4Rdiv2IbZ9Snv
X-Gm-Gg: ASbGncstp5GdAXVoYP4+dov9ma38Y2HOzLkF4cV2KqdlMHykbalr8urG5uCZEonECfW
 hdge54vLyCN8+HHvGvnNEbGbiCz0WfRF8myC9r8St+Tup/pja8R7gTw7ghfMfQXZ8J+EB/iKZ7R
 +sBvORaIv8uGOpoIjG9VBGmngPB77//yg8+pbVZNUfD/9AH/DmkEO2KxYXwvDEQ/vaDJqgDziRi
 fF7sOQCfRmFwUc9d8PCFR0Cl1Mm9GDCAb56bO9Y7VrQcz+rEpEM3dXwDjzuADuzjM+tnAScINbe
 ey1PjTXgU3HOqJVGq2uZ8HjZRsQWUB97XyvzSQ==
X-Received: by 2002:a05:622a:2614:b0:4df:c240:d596 with SMTP id
 d75a77b69052e-4e41e444accmr11455101cf.73.1759260701016; 
 Tue, 30 Sep 2025 12:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDOazenpN6UR3jvGese3FEvinXPMGsaH6uWfem6BAk7zLF58/gnv9CaJvpIEUGC2bkhROBFQ==
X-Received: by 2002:a05:620a:4593:b0:862:be11:1efc with SMTP id
 af79cd13be357-873781ad9b6mr125784885a.85.1759260357886; 
 Tue, 30 Sep 2025 12:25:57 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c298ef869sm1110335585a.28.2025.09.30.12.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 12:25:57 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, philmd@linaro.org,
 thuth@redhat.com, eblake@redhat.com, michael.roth@amd.com,
 armbru@redhat.com, farosas@suse.de, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru
Subject: Re: [PATCH v6 14/19] migration: add MIG_EVENT_PRE_INCOMING
Message-ID: <aNwuw_RdHjsV3pXe@x1.local>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-15-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923100110.70862-15-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Sep 23, 2025 at 01:01:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> We are going to implement backend-transfer migration feature for
> virtio-net/tap. When it's enabled (by setting migration parameter), TAP
> device is passed through migration channel (which should be a unix
> socket to pass fds) to a new QEMU.
> 
> So we need to know during TAP initialization, should we open TAP
> device, or wait for incoming fds. But we can't check for migration
> parameter at TAP creation time, as use may set migration parameter
> later (especially when TAP is added by command line parameter).
> 
> To solve this, we have prepared TAP initialization code so that
> opening the device may be postponed to later point. And this later
> point is obviously the early beginning of qmp_migrate_incoming():
> here we already know all migration parameters and capabilities,
> but we are not in downtime, so we can continue initialization
> of TAP device.
> 
> This commit introduces MIG_EVENT_PRE_INCOMING, to be used by TAP
> code in following commit.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


