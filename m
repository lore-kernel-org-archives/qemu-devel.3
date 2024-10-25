Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA12D0C612
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Kn7-0006aa-PS; Fri, 25 Oct 2024 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4Kn6-0006a5-67
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t4Kn4-0005IT-AY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729864544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pbBEloMWou59hXT2HVcKWDx/Zpq6ytzJ0Nl56mu52bg=;
 b=TyBIaN4t4STlSxpp+JPSz+4lDFm9f9v3aOxaS8BEs9oZL1pbd5jPFJ7hdzl7ygRDW8ZXIg
 +DVgzATJNNrguaQ0F+23u5aC9W7PSWVh834xb6QFH3jVzF7tfOlfsL9oBZosIh8mIj39Fs
 e3APeUH3xdSfT2gXSCh4/YzYrJW+snM=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-cvY0IueWMCOLLTAzwpiMHA-1; Fri, 25 Oct 2024 09:55:43 -0400
X-MC-Unique: cvY0IueWMCOLLTAzwpiMHA-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e2605ce4276so3821691276.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 06:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729864543; x=1730469343;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbBEloMWou59hXT2HVcKWDx/Zpq6ytzJ0Nl56mu52bg=;
 b=PxiAs3Kc1/AqkCBGRPTFbqdJaqvCHSGsdFksm5KMyHjCO9zZE2y6OJ2n7Fp0MDolpR
 NfKBIl4pcEpZGZ0GapyVWwBbaleaMbFwrDooc5LbycfYrKTHM2VYVZp5OU4xJ4q1g0yI
 bq52qYnd6Yq5RnUi4VBbQymS9faG2ECvOKxVM34510NicVouGyyC3AgZIiUjIAUAK4Mz
 e/PQIochbB82BczcoPLiP04DmDktd2eJ76JT7P6409FeLBskorVm9O/byBHSz5L+0BAZ
 9V5Y9Sl8Z52tsiHOBVIeGdqnai6Ekzc1u/yTt85kBbyz2A9ZWQWi6Xu9mvYX4CV141Oq
 89Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8uhwF4GNJCGPYcP27dFzNdpN63dZpE+TqFJi98c7f8KYMD3SK3W0+3g8/5ZFs5gReLqASM3BYQPzo@nongnu.org
X-Gm-Message-State: AOJu0YzxwtzpAL8uKcUJ14TJvNzqljcCJMhGLdqnV5LMH05cetn/27S3
 A0fvDVdaQKj31yCIHmcUelx2hXYm+UhpaGh4vjbIRy1syQH+3X2Q2UDkIwIQReoM1Vvb0yf+mUt
 fk1n+rD5DxoLfi3PHi7QJu3i+YxC1hJ2QjifG7RxmwXOkxYIf/Dkm
X-Received: by 2002:a05:6902:2487:b0:e29:9ab:d39d with SMTP id
 3f1490d57ef6-e2e3a62387bmr9535476276.24.1729864542811; 
 Fri, 25 Oct 2024 06:55:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHT5b20FkCzD4NMMBNSySqoMldIuQJqRxbHcPUCZMlFoOLv7RYJtC7k//qOxcbTrA7CHa9vA==
X-Received: by 2002:a05:6902:2487:b0:e29:9ab:d39d with SMTP id
 3f1490d57ef6-e2e3a62387bmr9535450276.24.1729864542408; 
 Fri, 25 Oct 2024 06:55:42 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-461323a1c20sm6132071cf.84.2024.10.25.06.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 06:55:42 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:55:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZxujV_9eTYCvOU_0@x1n>
References: <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n>
 <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
 <ZwbpQiK7YWKpqHTk@x1n>
 <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
 <ZwhFyOQanyqWqr6I@x1n>
 <6d626aed-a78f-4dbc-b1c7-111bc42c72dd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6d626aed-a78f-4dbc-b1c7-111bc42c72dd@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

On Thu, Oct 24, 2024 at 05:12:05PM -0400, Steven Sistare wrote:
> On 10/10/2024 5:23 PM, Peter Xu wrote:
> > On Thu, Oct 10, 2024 at 04:06:13PM -0400, Steven Sistare wrote:
> > > vhost requires us to stop the vm early:
> > >    qmp_migrate
> > >      stop vm
> > >      migration_call_notifiers MIG_EVENT_PRECOPY_CPR_SETUP
> > >        vhost_cpr_notifier
> > >          vhost_reset_device - must be after stop vm
> > >                             - and before new qemu inits devices
> > >        cpr_state_save
> > >          unblocks new qemu which inits devices and calls vhost_set_owner
> > > 
> > > Thus config commands must be sent to the target during the guest pause interval :(
> > 
> > I can understand it needs VM stopped, but it can still happen after
> > cpr_save(), am I right (IOW, fd wont change in the notifier)?  I meant
> > below sequence:
> > 
> >    - src: cpr_save(), when running, NONE->SETUP_CPR, all fds synced
> > 
> >    - [whatever happens..]
> > 
> >    - src: finally decide to switchover, vm stop
> > 
> >    - vhost notifier invoked. PS: it doesn't require to be named SETUP_CPR
> >      notifiers here, but something else..
> 
> The problem is that the first step, cpr_save, causes the dest to finish cpr_load_state
> and proceed to initialize devices in qemu_create_late_backends -> net_init_clients.
> This calls ioctl VHOST_SET_OWNER which fails because the device is still owned by src qemu.
> 
> src qemu releases ownership via VHOST_RESET_OWNER in the vhost notifier.

I think the block drives have similar issue before on ownership when disk
is shared on both sides, and that ownership was only passed over to dest
until switchover, rather than dest qemu init.  In the CPR routines it'll be
also during switchover rather than cpr_save().

Maybe it's just harder for vhost, as I assume vhost was never designed to
work with using in shared mode.  Otherwise logically the net_init_clients()
could do the rest initialization, but provide a facility to SET_OWNER at a
later point. I'm not sure if it's possible.

For block it could be easier, IIRC it was mostly about the file lock and
who owns it (e.g. on a NFS share, to make sure no concurrent writters to
corrupt the file).

> 
> Thus the guest must be paused while config commands are sent to the target.
> We could avoid that with any of:
>   * do not issue config commands
>   * precreate phase
>   * cpr-exec mode
>   * only pause if vhost is present.  (eg no pause for vfio).

OK.  I hope precreate will work out if that can solve this too.

Thanks,

-- 
Peter Xu


