Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEFFC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJMj-0000Lf-KK; Tue, 18 Feb 2025 03:54:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkJMi-0000LR-Ch
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tkJMg-0004Wd-T8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739868841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mWe+13siB08Fu71sbWO0GGxOuP87BIkCTwW/mqVOJ4=;
 b=d5xtefy4tuUv06NcVHOGC7+aHpDNeU40Fcg0z22NfaBdiaR+fsg84dy/G0nWzxX23Vp9I8
 cECY4NmqFS215gFK/yybUH9yJjS33oDl2W32mh3xlG2MP26QrBdEQ37g59POw3BkwEZ9xp
 rL+QKK8f5f7bqCyMwa7Zx/MMAFMJYlE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-MDz3AzPIO2SbWim-_iZAjw-1; Tue, 18 Feb 2025 03:53:59 -0500
X-MC-Unique: MDz3AzPIO2SbWim-_iZAjw-1
X-Mimecast-MFC-AGG-ID: MDz3AzPIO2SbWim-_iZAjw_1739868839
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4398ed35b10so5175185e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739868838; x=1740473638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mWe+13siB08Fu71sbWO0GGxOuP87BIkCTwW/mqVOJ4=;
 b=NoA1oLME8VXBhvJ/CITNmAaKdAIuZqD+w2mavrExzsz1R8W+ihiI86KWOwjrBh4afM
 XCwmpvk5jFiPgq+oQ158W9KiYpvpFhP2g3L59tRDdWq3QxxiJXhlX3IRUdkTJHmlAQDY
 S9ZN/quxt9iV1aRNGUPpyTDgdnmAVvyzGwuiWAlfezqyHyiVX7FbYa7uWtwlisVRESOZ
 CB1V0W67G0yZI86sq48Ldo6ukO3tEUVHy9qqCIgRi8Dac39rapIXflfRKi9b9gnFQNYX
 rMvQ6obO6Uco3Ed+kur0JQ9QyNYpij+A7JoRQe12Ja/aot8GMsczrfbhqQtMVSgXQ62U
 KyCQ==
X-Gm-Message-State: AOJu0YxqVn1pNXHokc223XCQ48UXJPPKf4z1sXC0HGbuUZuPbdg2mdvs
 3bTvGQM64WYEMHxUdLfeKZeOSR6/HoAjNcffFjf8GxenHB1HTEW9UmnRJ4+pXJaYKZHt21yWStf
 eI7zY/erj8xuQU5PTdSJ5i3SG3UtiUC5roUxds1FIaSDh0EEchQSv90iVR9UzLDWNpJB5QwBy+h
 cPYEBXr23UnzBXPQKeWoFZPNv16MA=
X-Gm-Gg: ASbGnctmmkODqv2eLAjNSxprwv1pTJD9X9CVO4dMWahfx2NxjK2ykMpi5aSuV8FqbXM
 tbUC7uFOMsayL8B5gHrwwYkAluh9CDgK9YF0CjYIydXE3HzjH++7dgVzWAFk8ceyI
X-Received: by 2002:a05:600c:19c9:b0:439:6a24:1067 with SMTP id
 5b1f17b1804b1-4396e6fae48mr128969425e9.16.1739868838615; 
 Tue, 18 Feb 2025 00:53:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHieH6QSmbkF4BX4xvpb+VrRIgRZ6vnOCZ7+QY5SrXB8Fo3Ela7psUk9A0oOMNM76R700eFHwU0kINChTYVNj4=
X-Received: by 2002:a05:600c:19c9:b0:439:6a24:1067 with SMTP id
 5b1f17b1804b1-4396e6fae48mr128969145e9.16.1739868838343; Tue, 18 Feb 2025
 00:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-4-ppandit@redhat.com>
 <874j0svbwj.fsf@suse.de>
In-Reply-To: <874j0svbwj.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 18 Feb 2025 14:23:41 +0530
X-Gm-Features: AWEUYZnHwsAEDYg043zGfbd8HESuGQ9HMVZLJIPcQlg1tN9XBZ13vKzZmQcKRFQ
Message-ID: <CAE8KmOz1ErBBErsik6u3mhkxi0ny7TWcxqFOuBhqEfuR5yXjNw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tests/qtest/migration: consolidate set capabilities
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, 17 Feb 2025 at 20:47, Fabiano Rosas <farosas@suse.de> wrote:
> I just noticed this is way more suited to be at MigrateStart instead,
> because then we can make the set_capabilities as part of migrate_start()
> and move the events setting in there as well.
>
> I also think we could just pick a default for multifd channels and avoid
> setting it in most places. 4 is probably a good number.

* Okay, sounds reasonable. I was thinking of setting multifd channels
to 8 as default, but didn't want to deviate from current code so kept
all values of 4/8/16.

Thank you.
---
  - Prasad


