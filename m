Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75625C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbf54-00058C-Fn; Sat, 25 Jan 2025 07:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tbf52-00057k-9m
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 07:16:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tbf4z-0003PI-GV
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 07:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737807360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1CzXpG9tJ879PK52y/ATtdD7ABBIJpIP5NSa4UrGxk=;
 b=PB8AushzJq7tqDkOgLS1qYjO/B9GIXzum18w/78LdGTS078bIfecguZZ6ReJn8HQ7OrUY8
 Wu6FCayLkT5nTNKjzYVtcuQfZFINdTXSFVM6dYeAUyNWhnO8GsRgQBuDcPoEMjtYFVJjDP
 fmE6tUysndDg9IWGCcNXKAZpSWcgHUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681--B0qYAUeN2K5-esUNFQ0dA-1; Sat, 25 Jan 2025 07:15:57 -0500
X-MC-Unique: -B0qYAUeN2K5-esUNFQ0dA-1
X-Mimecast-MFC-AGG-ID: -B0qYAUeN2K5-esUNFQ0dA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso14613995e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 04:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737807356; x=1738412156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1CzXpG9tJ879PK52y/ATtdD7ABBIJpIP5NSa4UrGxk=;
 b=xDP+vdnWEyb5SRg0/RKR71Kbs9lknoL0J8JrgqCh+oTR7doII61ShC7wsIhm12pGg7
 U4UedKgINALqmsfxa/ZZDBRQZyhTJqKBnE435awfHG5ytisXgcQbfatmUAqFJ/+8zN8F
 DXbq5InsZT/qO/GB7mgWsRkQEKNEnXNr7XQuv4qAK4XZKNlpHnXBfTJgH1NCjkrVTW1n
 SPrzWRX2R1TtJxTX4fDZL1MLgJlthYj4VRJCOO0a1bMX6zGkm/qG+qsmrx9gIkKtr3kf
 4WMBNHWqUPt6yb4snSfXM5ELiqpJKzZJMZjDWKnyPi5SMXhsBKz0yPOLLqkmK3XvCeS2
 VLsg==
X-Gm-Message-State: AOJu0YxXpAKP40CK3Nobr7P7enn7cdHtnvHXHRsNWDwP2hPezNLI+aiB
 G0UnFzr99ti2gu+Axff0QxuA6mzL4XIJug/QGYpboxzEsxeQMiKMyjWiDAqjjyqKPwAD+NiK83z
 0WGJUHKTlICqTzq/Fx/19H+kMQTmbR4lZ8Uzq2xtWeRitODk5LdmrbxL8s6Y82rfjxaEhzuLk8g
 +W/JTkQbTtZPvOXPxdfcGq/1HDBIY=
X-Gm-Gg: ASbGncugxZaoh3G8mCWgNN/BFLROHIHXaItpRAZGDUtlkjezssvzJw0XAu/4CMp1BEL
 olhCC2nUCKGTejIhJdiOEKZGT1ATDcMx5pYhwCaAK9cY17Mop5vnreeHHZoPZ/78=
X-Received: by 2002:a05:600c:310a:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4389144ee14mr338196595e9.31.1737807356456; 
 Sat, 25 Jan 2025 04:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk+nxJwbpBO1g0W+Qn857b4b2tnhLs2MpFNln2W9PNq+Yuw0tmPISxbTpTRzeSJ3Ia40YPTqnorQqo/9OiEzo=
X-Received: by 2002:a05:600c:310a:b0:434:e9ee:c1e with SMTP id
 5b1f17b1804b1-4389144ee14mr338196385e9.31.1737807356197; Sat, 25 Jan 2025
 04:15:56 -0800 (PST)
MIME-Version: 1.0
References: <20250121131032.1611245-1-ppandit@redhat.com>
 <20250121131032.1611245-5-ppandit@redhat.com>
 <Z4_Bh3ytv9REBero@x1n>
 <CAE8KmOw-4_DSoQEVUtJQnAuGdazmLqhL-dpUi3J1y8BN7zjLLw@mail.gmail.com>
 <Z5EYbBXkjTu98rHk@x1n>
 <CAE8KmOwvp=LJ+79t9VVsZqf4APqSYxqCQVmYSg_5QaVD4vzLWg@mail.gmail.com>
 <CAE8KmOywe888S-oCoO=4=oFsXuN=AfuuqvT27LGor-UTC78YoQ@mail.gmail.com>
 <Z5Oz-Kz4rysFQ-n1@x1n>
In-Reply-To: <Z5Oz-Kz4rysFQ-n1@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Sat, 25 Jan 2025 17:45:39 +0530
X-Gm-Features: AWEUYZnxkNQ2nY398nvdvTHuslapV0Lvp2MAF85Y7x_TTbu6uSaC4uBb8b2lcMI
Message-ID: <CAE8KmOw_k3Jxf_AyZ6W8nfOcgsF4mkbUL0-tigX8-iEdN_oApA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tests/qtest/migration: add postcopy test with
 multifd
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 24 Jan 2025 at 22:39, Peter Xu <peterx@redhat.com> wrote:
> > >         # /x86_64/migration/multifd/tcp/tls/psk/match
> > >         # /x86_64/migration/multifd/tcp/plain/zstd
> > >         # /x86_64/migration/multifd/tcp/plain/cancel
> Since multifd doesn't work with postcopy phase, compression so far cannot
> happen in postcopy phase but only in precopy phase.

* Right.

> So the tests I suggested was trying to make sure multifd major features (in
> this case, tls, compression, and cancellation) work like before even if we
> set postcopy-ram=on in the feature list, because after your changes merged,
> people may start always set postcopy-ram=on for all cases.

* Ie. we set 'postcopy-ram=true' for above precopy tests?

Thank you.
---
  - Prasad


