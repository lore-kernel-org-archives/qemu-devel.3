Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551C0C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reRzY-00054M-5O; Sun, 25 Feb 2024 22:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRzW-00053x-53
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRzU-0000Wl-J6
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708919359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9EOUYcphJ/QFT2T0d71f6sYYpmbax/7RmsDV13YL1o=;
 b=dS2AJeJfO6sVr1fWMWZT7BfHz8+t3hcCIqrPMERsuvgRp88wexpYM9NW8tYjxKsuG+ziUP
 ZbByCnoi3aizJQluPP7DqjPSFKmG6Pv49FkSm8fOrMcEGShyG+9u8/N+VKnV445x74ImlD
 FmNBaJEKM8vdN9lHepocRk4DAV9e6qc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-8NkDF0UvMSGnEN96VZFY2Q-1; Sun, 25 Feb 2024 22:49:18 -0500
X-MC-Unique: 8NkDF0UvMSGnEN96VZFY2Q-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5c683944ab0so731157a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 19:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708919357; x=1709524157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9EOUYcphJ/QFT2T0d71f6sYYpmbax/7RmsDV13YL1o=;
 b=Jl8GbOTTLG0PUr2L+qMnTTGwRHd/Uimvhlx4KK4WOICGwVKwLu6g/gDfvRgHXGuNpX
 B5/RnJ5k39u9VplCOJcPm4/sMLYVr1i4zm55OZaBbePATLr1E1jeCtNKnRJsT4EQTQll
 fBFBIdcuHBiolhz9/GO7ysCxzJ8l7g33zJ3SwELzxyySp6vV1xTLNZwZ4/z5bCOVS/UK
 LfIgjtkTZA/etUfwqWd5oK0nSZ5BHvQE6xq0XnRscOuGmHkcymfRQvoB6MQU2/eulbLx
 EYZKixhdzsDP/rtdDs5Sj0CtJzVvq6xvzUU6NPDsPFqT0pLgQy4T/lnm36jAQcB1Zwqv
 rxAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBMC0IInu5leIkA18RFCWCeZiXpA9LcrOO9RA05zDrybbEWg1NZXNQcHVdXTnVptNoF7CwnGKDy4EWQIxWZAzsP69Nd6g=
X-Gm-Message-State: AOJu0YyWx7ZeKQEpi2K/M+Ye8yzK19wdcvOZnVzTZ4lpkpr3awbdkNbZ
 gIaDzU6cSaj3+o/LzuM4G/2sHHGpxx97IOOAQvcLr0DWm5wt+4AW7rB40vP9V7esUClfTiAmaTt
 Xx4oUJNGlL1bTgO07yAhUiMjOsgGBAy/WSgQ+Bqnkd0D/Sg0OKfbf
X-Received: by 2002:aa7:8011:0:b0:6e4:68fa:f1ff with SMTP id
 j17-20020aa78011000000b006e468faf1ffmr7564444pfi.0.1708919356998; 
 Sun, 25 Feb 2024 19:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3sopuJKxbIY2qaaS5DTN1OnUBg7A6pllRRtx65C+xcb04T9cH+zH7Tf86YoKQ1FA9mbf78g==
X-Received: by 2002:aa7:8011:0:b0:6e4:68fa:f1ff with SMTP id
 j17-20020aa78011000000b006e468faf1ffmr7564434pfi.0.1708919356634; 
 Sun, 25 Feb 2024 19:49:16 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i16-20020a635410000000b005df41b00ee9sm2945734pgb.68.2024.02.25.19.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 19:49:16 -0800 (PST)
Date: Mon, 26 Feb 2024 11:49:09 +0800
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration: Free argv
Message-ID: <ZdwKNYI-uhkXJ4B5@x1n>
References: <20240225-argv-v1-1-a11e772884d9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240225-argv-v1-1-a11e772884d9@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Feb 25, 2024 at 02:54:01PM +0900, Akihiko Odaki wrote:
> exec_start_outgoing_migration() and exec_start_incoming_migration()
> leak argv because it uses g_steal_pointer() is used to pass argv
> qio_channel_command_new_spawn() while it does not free argv either.
> 
> Removing g_steal_pointer() is not sufficient though because argv is
> typed g_auto(GStrv), which means the array of strings *and strings* will
> be freed. The strings are only borrowed from the caller of
> exec_start_outgoing_migration() and exec_start_incoming_migration() so
> freeing them result in double-free.
> 
> Instead, type argv as g_autofree char **. This ensures only the array
> of strings will be freed and the strings won't be freed. Also, remove
> unnecessary casts according to the new type.
> 
> Fixes: cbab4face57b ("migration: convert exec backend to accept MigrateAddress.")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Peter Xu <peterx@redhat.com>

This should conflict with Steve's other series:

https://lore.kernel.org/r/1708638470-114846-1-git-send-email-steven.sistare@oracle.com

Considering this can be stable material, should be easier if we have the
other series rebased on top of this, even if that was sent first..

Steve, do you still plan to repost your series?  Maybe you can review it &
pick this up into your series?  Then whoever pick up your series will pick
up both (Markus will?)?

Thanks,

-- 
Peter Xu


