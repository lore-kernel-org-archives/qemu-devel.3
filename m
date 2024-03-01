Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6DC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfrxk-0001i9-V2; Thu, 29 Feb 2024 20:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrxj-0001eB-Ai
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:45:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfrxh-0005ap-UX
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709257521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1FjfDFV+f389A/PryCuuJ7eK9FlIA18XLdQqfboaBY=;
 b=Y6bVclvLrLPoMcXEGGUvPpMpulN3TJr2uFzSV0JPAQ5/90eOLHPvbDKiQMhiqKtk+ZAmq8
 sa9mbLa2XAo2omipzcJYkYbNcwZUAYLSVbiqaRH4n6KUP2/nrTEJ0nwnYDv3PH/lu/iMe4
 rfhrP/adu5dU9XtDP5Gt9iYgkWE4YrA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-aMIdcjJOM3WAoU84HdytKA-1; Thu, 29 Feb 2024 20:45:19 -0500
X-MC-Unique: aMIdcjJOM3WAoU84HdytKA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5dc97ac2facso546975a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:45:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709257518; x=1709862318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1FjfDFV+f389A/PryCuuJ7eK9FlIA18XLdQqfboaBY=;
 b=e3nvWPsnxRwr3sf4dsZlOrCSz4JN8fJmKmGWEg9/7PRJvyUHhn3b1g7rF0fR/v1tIE
 EDk9vN8icrOffxsOpDQWg99Z1MuW18czKsBrgQoFZF4UpgFIx0BFZV2rvxd0itEJ4Blr
 DLucq8PPsSdGhGfqjZmkIBrcXoO/LnDeEyEufZjBH0tPS0wKy0IubyBfapJakWTP/F/J
 5bTWbE8npt5Nu3//u8vK8AoaKH8wG/hfKJVHuGe9DhvO53qUibm1PExAAIQlBeQbL3nk
 7irWIxvLwgOdaiNbkTGZV6pBE9Xt0pBQtuXhuaDsvDqt0C0PyrNCoQtuwhNwodzNMnSN
 SIAA==
X-Gm-Message-State: AOJu0YzalrnDiHS/09EXuPQvZLe1m11pewelsGdjS3PZk0DHHOxQS6uY
 FINTkKhB03PUVf1J6k0nKVw5g1TPMXx5DGgYmD2zgYL+cMtLPbkdPh0ax8JYUlZKmpoE0SXISU1
 jWJrTHIpg0AMXnxT/oVz6zCyg9XwLb4OA0yeLFUqrkpV1e+ZrH58b
X-Received: by 2002:a05:6a00:92a0:b0:6e5:35a7:5333 with SMTP id
 jw32-20020a056a0092a000b006e535a75333mr507842pfb.2.1709257518652; 
 Thu, 29 Feb 2024 17:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5SeHn0JY2hVuZYGagJnp+Q9ZlWXg5lZZB2hZnxqJGrbjUAQbvl9YcYV4YVlTtY+YhZb8mMQ==
X-Received: by 2002:a05:6a00:92a0:b0:6e5:35a7:5333 with SMTP id
 jw32-20020a056a0092a000b006e535a75333mr507831pfb.2.1709257518248; 
 Thu, 29 Feb 2024 17:45:18 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gx1-20020a056a001e0100b006e59a311e2dsm1692623pfb.92.2024.02.29.17.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:45:17 -0800 (PST)
Date: Fri, 1 Mar 2024 09:45:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
Message-ID: <ZeEzJ734MPmFfc7B@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
 <20240229153017.2221-20-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-20-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
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

On Thu, Feb 29, 2024 at 12:30:13PM -0300, Fabiano Rosas wrote:
> The mapped-ram migration can be performed live or non-live, but it is
> always asynchronous, i.e. the source machine and the destination
> machine are not migrating at the same time. We only need some pieces
> of the multifd sync operations.
> 
> multifd_send_sync_main()
> ------------------------
>   Issued by the ram migration code on the migration thread, causes the
>   multifd send channels to synchronize with the migration thread and
>   makes the sending side emit a packet with the MULTIFD_FLUSH flag.
> 
>   With mapped-ram we want to maintain the sync on the sending side
>   because that provides ordering between the rounds of dirty pages when
>   migrating live.
> 
> MULTIFD_FLUSH
> -------------
>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
>   packet causes the receiving channels to start synchronizing with the
>   main thread.
> 
>   We're not using packets with mapped-ram, so there's no MULTIFD_FLUSH
>   flag and therefore no channel sync on the receiving side.
> 
> multifd_recv_sync_main()
> ------------------------
>   Issued by the migration thread when the ram migration flag
>   RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
>   on the receiving side to start synchronizing with the recv
>   channels. Due to compatibility, this is also issued when
>   RAM_SAVE_FLAG_EOS is received.
> 
>   For mapped-ram we only need to synchronize the channels at the end of
>   migration to avoid doing cleanup before the channels have finished
>   their IO.
> 
> Make sure the multifd syncs are only issued at the appropriate times.
> 
> Note that due to pre-existing backward compatibility issues, we have
> the multifd_flush_after_each_section property that can cause a sync to
> happen at EOS. Since the EOS flag is needed on the stream, allow
> mapped-ram to just ignore it.
> 
> Also emit an error if any other unexpected flags are found on the
> stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


