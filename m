Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B71FC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 15:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riyOH-00050p-Pc; Sat, 09 Mar 2024 10:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1riyOG-00050h-RS
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1riyOE-0005vP-U0
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 10:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709997212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvEnEn61qIGzBx5HDcABGdI1hanTCJMH/wO4hbvbsTk=;
 b=iaQw1FcGeLbPWXCutzQ+GE6GxkLpNxFauINLILmNLctISYflJefRAYz2ZVJ6UdeURhkDIQ
 m8SU5m6DXZ1Oj2GmXBl3tZgmN5G2i8PzxkIZP/qDu6f3c+jfAAa5zsoFtk/UnmSUs7Lvjb
 Km435dlaiEPlUZSOQUC4wDKCMLAD4fU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-PGIFR_f9NfWx1HSMtYY_cQ-1; Sat, 09 Mar 2024 10:13:30 -0500
X-MC-Unique: PGIFR_f9NfWx1HSMtYY_cQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-36643c99612so58395ab.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 07:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709997210; x=1710602010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FvEnEn61qIGzBx5HDcABGdI1hanTCJMH/wO4hbvbsTk=;
 b=rsWAKQZoIrAx9t+clfLUozn0IGcZOevF8P+MhKoRZNPnrPJzy+KHHkzcObmHAKOcpn
 a4eLDafB9OAFCgWeLeqvdjRQaKfNRElYLlPjXMj/8ngJR38KzQqxN4hEwjFx5iYPuqH0
 qCu9dBgP1KwmD0+9QxwG+rxwBp5YEEq85rEV/rNj0uOY+duwYHDJAdTbJtK4d1ZSmsr1
 j2FwwjleH0RdYqTqPfiyBgYWs8oewas3iUbcD6KO8TRGDS7AXd4HKAo4iePgWPJJyHqy
 1BL/0254yiBmWpNtPnWmIXmEzcPCnjkxoU6W3+pNKIYOkUkCShWVnjt+ogthWpViaqU4
 3vLw==
X-Gm-Message-State: AOJu0YzB3uv+uhjDM3dnvhnhcPF/a54DKqOMzKttaIXw6tB3uU9IMy72
 AHTVTheQLi59P+A0Y+N1hLOowj43Y77sfdBkw4/QxLXvpth7KoZkllAALhC2zqmrQj5nVXUP1Ma
 Os6ymI1z92qdZbI0jV/Ak62gMYuBHZIbKXPvb80iNc/oNhdzARfK3
X-Received: by 2002:a05:6e02:1cab:b0:365:21a0:781f with SMTP id
 x11-20020a056e021cab00b0036521a0781fmr2457888ill.16.1709997210027; 
 Sat, 09 Mar 2024 07:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFp1hr4hZ0t1wb+EJVnd+1U43AiKxx/jvryN7SP0adYWpNOW8Qsu99kGMg5QBofUef/8vnwFw==
X-Received: by 2002:a05:6e02:1cab:b0:365:21a0:781f with SMTP id
 x11-20020a056e021cab00b0036521a0781fmr2457871ill.16.1709997209778; 
 Sat, 09 Mar 2024 07:13:29 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 g9-20020a05663816c900b00476ca242b77sm459093jat.53.2024.03.09.07.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 07:13:29 -0800 (PST)
Date: Sat, 9 Mar 2024 08:13:27 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/2] Revert "hw/i386/pc: Confine system flash handling
 to pc_sysfw"
Message-ID: <20240309081327.7eb35acf.alex.williamson@redhat.com>
In-Reply-To: <20240226215909.30884-1-shentey@gmail.com>
References: <20240226215909.30884-1-shentey@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 26 Feb 2024 22:59:07 +0100
Bernhard Beschow <shentey@gmail.com> wrote:

> As reported by Volker [1], commit 6f6ad2b24582 "hw/i386/pc: Confine system
> flash handling to pc_sysfw" causes a regression when specifying the property
> `-M pflash0` in the PCI PC machines:
>   qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found
> Revert the commit for now until a solution is found.
> 
> Best regards,
> Bernhard
> 
> [1] https://lore.kernel.org/qemu-devel/9e82a04b-f2c1-4e34-b4b6-46a0581b572f@t-online.de/
> 
> Bernhard Beschow (2):
>   Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove
>     it"
>   Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"
> 
>  include/hw/i386/pc.h |  2 ++
>  hw/i386/pc.c         |  1 +
>  hw/i386/pc_piix.c    |  1 +
>  hw/i386/pc_sysfw.c   | 17 +++++++++++++----
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 

Please apply this, the original commits break my existing VMs.

Tested-by: Alex Williamson <alex.williamson@redhat.com>


