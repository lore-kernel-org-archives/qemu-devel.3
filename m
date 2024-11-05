Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEBD1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbM-0004X9-BY; Tue, 05 Nov 2024 06:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8HbJ-0004VK-GL
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t8HbC-00076z-CG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730805588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gGZzqk9PebDSovSkijiespfOsuVvaBw8WYB4xrFjFNI=;
 b=EdYGjTewUX56gWJ9/QqslVKgWYP/KonjR51waF/+uxHO0bEYlis+A+JmnJd3gqZzWqX7/3
 nXBjEYGdRJoZ1eq6B4OPvJYiIOg0eF+8kzIknS/ILqUiKsSx3puM7SH2Q2/Jils4CpbvJu
 +oF6EAgF7B+FnKb1JZFFoCs8pz1WK/U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-Dih-djIhNkCOMQ5wI9ETmA-1; Tue, 05 Nov 2024 06:19:46 -0500
X-MC-Unique: Dih-djIhNkCOMQ5wI9ETmA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso2867440f8f.0
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805584; x=1731410384;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGZzqk9PebDSovSkijiespfOsuVvaBw8WYB4xrFjFNI=;
 b=Dkn9BZU5jzR6ndWY4S/QLbqjkuPheu5blTU2UMJkDz5KTQrrm2ovtGbnY8NjPI8REc
 3OfXW9W7fPNBmQcf8dHwl0O4LgaRsrtBkkTBP/OnJ2VB1u4ZdOSYUzyFTI/KFSdunc/M
 c29IjjDFJ14DKeaftSZjYgMp4KbLoJ7E0BVKWq9YSqeTHiBmjs+Zafrh93uGw5NQjs/P
 mRowsvEMprCBv7RzrbucwfMtdBuiGpMkt1/+BoJ6V2Ft07Ztbkfo/Oa9jjQHRL5q9O6w
 0wgwiLxaRRXrw02OgQLhg2VVeOo3CBnSH2ebTZCFfkhnbfPffRno+faYkcA6GdgF9Fbo
 iyyQ==
X-Gm-Message-State: AOJu0YwwtlERZ9EslYOpuafUD1+AI9mDniZy71NfdVqO4uKRGFRmYbN7
 DstOmnoYdi/dd8jcIGquupKHEbnNSKrB6Va7dcj7ouLz1pvMKJPWKUQ4pIAYa3B5hoeRzmXnJRC
 xUePTn1EjsUx5SbYRrWrX5p7gcvlZZImn6EqQYM6YCWlH5bIga7pFwUaisutBdM46glGOOrjQhG
 gBMM9KC1/7zRw0992ShZlm+sWFjqwtM2m8M0U=
X-Received: by 2002:a5d:6d0e:0:b0:379:5c8:33fa with SMTP id
 ffacd0b85a97d-381c7866580mr13622626f8f.0.1730805581191; 
 Tue, 05 Nov 2024 03:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgp4I6nxfY6FvtXDHYpjjSXUdcoxlFzAVPbyv2yNttU5oSa5wehT7tWI8O/O5aP/qTe3TSk6CNFlK3pvhFHXE=
X-Received: by 2002:a5d:6d0e:0:b0:379:5c8:33fa with SMTP id
 ffacd0b85a97d-381c7866580mr13622553f8f.0.1730805579858; Tue, 05 Nov 2024
 03:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20241029150908.1136894-1-ppandit@redhat.com>
 <20241029150908.1136894-3-ppandit@redhat.com>
 <ZyTnBwpOwXcHGGPJ@x1n>
 <CAE8KmOyzWRqpGDOyAK7V2X8+SWVt_kR1897tiFm7vdBNRRE2QA@mail.gmail.com>
 <ZykB3voFw_-ByWfh@x1n>
In-Reply-To: <ZykB3voFw_-ByWfh@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 5 Nov 2024 16:49:23 +0530
Message-ID: <CAE8KmOzuGxdU7zp+vsf1yY_FP8bf-KTv7UJ+8h6bfmkE=0H-bA@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
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

On Mon, 4 Nov 2024 at 22:48, Peter Xu <peterx@redhat.com> wrote:
> Firstly, we'll need a way to tell mgmt that the new qemu binary supports
> enablement of both multifd + postcopy feature.  That can be done with a
>
>   "features": [ "postcopy-with-multifd-precopy" ]
>
> Flag attached to the QMP "migrate" command.

* IIUC, currently virsh(1)/libvirtd(8) sends the migration command to
the destination to inform it of the migration features to use, whether
to use multifd or postcopy or none etc. Based on that the destination
QEMU prepares to accept incoming VM. Not sure how/what above flag
shall benefit.

> Then, I think we don't need a magic for preempt channel, because new qemu
> binaries (after 7.2) have no issue on out-of-order connections between main
> / preempt channel.  Preempt channel is always connected later than main.
>
> It means in the test logic of "which channel is which", it should be:
>
>   - If it's a multifd channel (check multifd header match), it's a multifd
>     channel, otherwise,
>
>     - if main channel is not present yet, it must be the main channel (and
>       we can double check the main channel magic), otherwise,
>
>     - it's the preempt channel
>
> With that, I think we can drop the new magic sent here.

* Sending magic value on the postcopy channel only makes it consistent
with other channels. There's no harm in sending it. Explicitly
defining/sending the magic value is better than leaving it for the
code/reader to figure it out. Is there a compelling reason to drop it?
IMO, we should either define/send the magic value for all channels or
none. Both ways are consistent. Defining it for few and not for others
does not seem right.

Thank you.
---
  - Prasad


