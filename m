Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA876C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIJs-0004Vy-8f; Tue, 06 Feb 2024 05:04:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXIJq-0004Vp-Al
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:04:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXIJj-0007SP-30
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707213877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OlaMvjmghAtQSrU9aPbfJRXKX0TneT+fiS5qtyXtIms=;
 b=IYNeCktXS8aZ8pXhusxI/Smxs6bmxCWvrCFKpGjmVNvrV1aU1FtaFkOaK/2/k+F15DtkAl
 KoZjEz76ZskcW2O8r4u1zQhY6N8CalkXOuUD0eSq/OvPkfkS6Wm/o/jY7MUFMhHmkdxGd1
 xZSBq8h/qrLd/hQ2dm5KBdwhuVh0VE4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-qlw6zYHhMbuUUtrzkwIDzA-1; Tue, 06 Feb 2024 05:04:35 -0500
X-MC-Unique: qlw6zYHhMbuUUtrzkwIDzA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc1aeb6a58so992926a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 02:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707213874; x=1707818674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlaMvjmghAtQSrU9aPbfJRXKX0TneT+fiS5qtyXtIms=;
 b=D5ynTkC/FxOJ+AYZSEhK+7de9szKrlPpSBMUfJjuycx5caYjbg9kwin7+dK/aE6jPx
 gGy1vHdZoZOdJUUufDYe6BQS/7Us2pD6jYi+C87p8p0LuA6EOOonR5N+T3P4q1oKRQw5
 xiPrAzscZao1WKCuQxYSicLimQpWw40ntISvbRLomRDZHS4HAiapZSr0sCVhOIs9j2Q3
 NhW9C82srS/ePzzlRDvXhTQnPInyfh9qv8Jqg9ibKG0JN56tsEW5KjWPhp02RB4AbM44
 3wgxUnGcW9nTfVjJO2+ZJpYlnrE14hpQFdoMPAZqZgmJLzcZ+C7Luaog/dvpBSSXx/0o
 6SBw==
X-Gm-Message-State: AOJu0Yy3TE1FGC1dSO7qAzUaBWC9UVYx6mBKQNAf8rGsAar+8bY2hIkC
 cfpC50Hawuju/PKbYKUxxlQ8wyVrhSzege+Gyp66UocWmR9OUMtjqOnCBUaP5AErg2dun+uJ0NW
 NJbuFHoXQrnHR7xYqJW/UCsiOUppEHH60tnin3vIeUEtrDRN3Usus
X-Received: by 2002:a17:90b:1d0c:b0:296:9c2a:e7da with SMTP id
 on12-20020a17090b1d0c00b002969c2ae7damr2059117pjb.2.1707213874577; 
 Tue, 06 Feb 2024 02:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAuYLpm1o1VmSq3IIVg3JiDJb5qshIWbLNCEhTBPGp0SRoRpRhsLJwbQmZWbzIF4/Gm/359g==
X-Received: by 2002:a17:90b:1d0c:b0:296:9c2a:e7da with SMTP id
 on12-20020a17090b1d0c00b002969c2ae7damr2059104pjb.2.1707213874207; 
 Tue, 06 Feb 2024 02:04:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUevyctVfT6oqiT1d9LISD/eG1ks7O+f2bGOBjtH5IRcHuada6YkREM+gSuGHq0Xis4PAE6GeWgA1Hb8NbDFas=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 sx16-20020a17090b2cd000b0028c89122f8asm1136947pjb.6.2024.02.06.02.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 02:04:33 -0800 (PST)
Date: Tue, 6 Feb 2024 18:04:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 00/17] migration: Add new migration channel connect and
 TLS upgrade APIs
Message-ID: <ZcIEKpNDXGe3J4ra@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125162528.7552-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 06:25:11PM +0200, Avihai Horon wrote:
> Hello,
> 
> Today there are several types of migration channels that can be used
> during migration: main migration channel, multifd channels and postcopy
> preempt channel. Each channel type has its own code to connect and to
> TLS upgrade itself when needed. There is no unified API for these tasks
> and it makes the code a bit unclear and cumbersome.
> 
> This series aims to solve this by introducing two new APIs for the above
> tasks that will replace the existing code.
> 
> The first one is an API to TLS upgrade migration channels. A new
> function, migration_tls_channel_connect(), is introduced and is used by
> main migration, multifd and postcopy preempt channels.
> 
> The second one is an API to connect migration channels. A new function,
> migration_channel_connect(), is introduced and is used by all migration
> channels other than main migration channel, i.e., multifd and postcopy
> preempt channels. The reason it's not used by main migration channel is
> because the main channel is a bit special and has different flows, and I
> didn't see a smooth way to include it.
> 
> Patch breakdown:
> 1-5: Some fixes and cleanups.
> 6-12: Add new migration channel TLS upgrade API.
> 13-17: Add new migration channel connect API.

Hi, Avihai,

I am queuing patch 1 as it does look like a real bug to fix asap.  I'll
copy stable for that one.  For such patches, feel free to post separately
next time if you think I should merge earlier than the rest.

For the thread race issue: I believe it should be fully covered by
Fabiano's series, at least that's the plan.  Let me know if there's still
something missing.

For the rest: I didn't closely check, but obviously many of the changes
will not apply after applying Fabiano's fix on the thread races.  If you
have anything that still think worth merging, please rebase to that (or
wait for my pull; it should happen this week).

Thanks,

-- 
Peter Xu


