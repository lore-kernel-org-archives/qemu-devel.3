Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CBFC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 20:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlEZc-000110-Jr; Fri, 15 Mar 2024 16:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlEZa-00010b-6f
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 16:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rlEZX-0007pr-3Z
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 16:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710536072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQveVMzDKvZA2FTLi3sT40JpzC6HQA3q1yjeT0Boh6w=;
 b=KHm46EIJzOLCPDlnF5UL75+9wa84Xo5Rvui8NmNeZt7B9yJokJmV7CObeDF20Xze+d61mk
 bCEMbOgdBz2MNjicLJ8xN2qfH/C9mjE0k4877Wfg1d2lhm11IYxgkhwIQy/PekOy4oUq2A
 dCsasXvC4baMYVVqMfKuQLWgHEALMVw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-W1EgZ0P-OlebaLQOuZbvAg-1; Fri, 15 Mar 2024 16:54:31 -0400
X-MC-Unique: W1EgZ0P-OlebaLQOuZbvAg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6818b8cb840so7561816d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 13:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710536070; x=1711140870;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQveVMzDKvZA2FTLi3sT40JpzC6HQA3q1yjeT0Boh6w=;
 b=v1hVb8couS+UkFA+hRd/kQaw08NOYZL/ntRQr3LJpeEgxIcl5oh9N4aIaOaHKx1QJC
 egnCI3yT+sv+6tLAKAZNr1pfU8AJLIrd2F0hoGoodCwqCrBYa7Tin8QflbnUA8aDqMBw
 qgqOix66wfqq3f/Dis5dj1xW/tk5I5p0zcEx8rEUNv6jE5k6SM8t87YQmtueAiXNr6aX
 DGzFHUxnNUXgATGhp1FCUvGDp0rL9LmuelwJ/DfRZfPfF6j6vnK2PYOrnNT6AKqEhFC8
 xHD1tbpdxyCjjsq2ywqITxVLNewE6vF0dK2u4aSAbWRqYYpVInB0UtfLuCwZHWK9Oz79
 55gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4tSgEyYE7G9KW0sZQISrJEHEwTEK9hF0NgAGV3tmXoHoX50RlvTbhMjiNFiKzBezHytPWqFTt4u4MoRSney2wyXwsIzg=
X-Gm-Message-State: AOJu0Yx6KLvz32YF4gZ2DipRxm4AOH8XvAdvdL5AKrPKD9fNK0dezoXN
 wlZl6JKv9lgeDknVAuRFwkwYn/Ak1v/HZvOm6DgCvf/4nkebbJjmUiT7oHAzE8LqDWcS1qeGEP3
 AdnpjkNV/+jwEUs7Hhi+tpmt0W217JguFB7Xs7ypqsHcyMUrfjiPe
X-Received: by 2002:a05:6214:4386:b0:690:b47e:60e3 with SMTP id
 oh6-20020a056214438600b00690b47e60e3mr6255945qvb.5.1710536070530; 
 Fri, 15 Mar 2024 13:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtGZP/bLZDXfcI7rp5QM0XnBQGrPjyQVpmgsVmn11AgFIcN3+X2XGvQkVzrDYMtbVWDoFBJQ==
X-Received: by 2002:a05:6214:4386:b0:690:b47e:60e3 with SMTP id
 oh6-20020a056214438600b00690b47e60e3mr6255936qvb.5.1710536070109; 
 Fri, 15 Mar 2024 13:54:30 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 e8-20020a0562140d8800b00690cb8eb777sm2397225qve.59.2024.03.15.13.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 13:54:29 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:54:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH v3 3/3] migration: Add fd to FileMigrationArgs
Message-ID: <ZfS1g8YvZ7if9j5M@x1n>
References: <20240315032040.7974-1-farosas@suse.de>
 <20240315032040.7974-4-farosas@suse.de>
 <ZfQNDv--4BnN5zYx@redhat.com> <ZfRxwml7m0DQVO2b@x1n>
 <87y1aj74t6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1aj74t6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

On Fri, Mar 15, 2024 at 03:01:09PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > [I queued patch 1-2 into -stable, leaving this patch for further
> >  discussions]
> >
> > On Fri, Mar 15, 2024 at 08:55:42AM +0000, Daniel P. Berrangé wrote:
> >> The 'file:' protocol eventually calls into qemu_open, and this
> >> transparently allows for FD passing using /dev/fdset/NNN syntax
> >> to pass in FDs. 
> >
> > If it always use /dev/fdsets for files, does it mean that the newly added
> > SOCKET_ADDRESS_TYPE_FD support on mapped-ram will never be used (so we can
> > drop them)?
> 
> We already have SOCKET_ADDRESS_TYPE_FD + file since 8.2 when the
> MigrationAddress was added. So this:
> 
> 'channels': [ { 'channel-type': 'main',
>                 'addr': { 'transport': 'socket',
>                 'type': 'fd',
>                 'str': 'fdname' } } ]
> 
> works without multifd and without mapped-ram if the fd is a file or
> socket.
> 
> So yes, you're correct, but given we already have this^ it would be
> perhaps more confusing for users to allow it, but not allow the very
> same JSON when multifd=true, mapped-ram=true.

I don't think the fd: protocol (no matter the old "fd:", or the new JSON
format) is trivial to use. If libvirt didn't use it I won't be surprised to
see nobody using it.  I want us to avoid working on things that nobody is
using, or has a better replacement.

So even if Libvirt supports both, I'm wondering whether /dev/fdset/ works
for all the cases that libvirt needs.  I am aware that the old getfd has
the monitor limitation so that if the QMP disconnected and reconnect, the
fd can be gone.  However I'm not sure whether that's the only reason to
have add-fd, and also not sure whether it means add-fd is always preferred,
so that maybe we can consider obsolete getfd?

> 
> That's the only reason I didn't propose reverting commit decdc76772
> ("migration/multifd: Add mapped-ram support to fd: URI").
> 
> For mapped-ram in libvirt, we'll definitely not use
> SOCKET_ADDRESS_TYPE_FD (as in the JSON), because I don't think libvirt
> supports the new API.
> 
> As for SOCKET_ADDRESS_TYPE_FD as in "fd:", we could use it when
> direct-io is disabled. With direct-io, the fdset will be required.
> 
> >
> > What about the old getfd?  Is it obsolete because it relies on monitor
> > object?  Or maybe it's still in use?
> >
> > It would be greatly helpful if there can be a summary of how libvirt uses
> > fd for migration purpose.
> >
> > Thanks,
> 

-- 
Peter Xu


