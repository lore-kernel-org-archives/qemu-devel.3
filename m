Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F004C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP28w-0005St-Al; Tue, 10 Jun 2025 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP1ce-0003XA-Nu
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uP1cc-00025U-Ug
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 12:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749572085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xkCM5X49QfFNU96toz1oguUI3Huvz4CHRXCa/Vtdjm0=;
 b=QSHYbVCchXj03xLskDXQtidT/XOLAu+FbVJXXcSPQCnrWphPrM8N8qVdu3E4QbbwmYSWXb
 ue5nS3fKCYUAXMVTq9+4aoneKtwa2qkQu/B3P4KdpFHbXotNIbTypVJtYNqiUbygL0vnol
 7mncuUXeT3Y3ceWGwFzADBZh2EHs7o4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-DqbqQnncN8yCq5g80KmCMA-1; Tue, 10 Jun 2025 12:14:44 -0400
X-MC-Unique: DqbqQnncN8yCq5g80KmCMA-1
X-Mimecast-MFC-AGG-ID: DqbqQnncN8yCq5g80KmCMA_1749572083
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so2512304f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 09:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749572083; x=1750176883;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkCM5X49QfFNU96toz1oguUI3Huvz4CHRXCa/Vtdjm0=;
 b=wA9ItzMA3rzHMWhpYjBBGncwt4gU7lBvrIVJND2ZskM3PoUyIThMrVEwiIdihLkXLW
 ujjOOO2wxG86hS1w0Tq3msfAU3iCSZgSs+2qts3xN0qeQwz9PG1DxhlfZNXBlpbL1V5l
 Q4tJwiRjA5SuldJGH5KSyOk9ugJ6gtvWYwxxgBM7OWSGCMnsmY5n0NOu7PJBJJszt38D
 EOWvTnW6/6UXff/+f29PwcSLpIXYi5d4Wx/N4q3RmBtSFh5/V9QRyFK1wE8y12pJDBb0
 QYd2gntsclOUTe08IGU+3UwoVT23RWvDdv0kSt6YCRABE5JavnnsGBzsw44FeziI2NWp
 j0tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4YI8kHiSrxN4TkKJaUWiBcLZK+GnhN9l+dSuumRL9pY4cAi373sO5GDpysTtVjE+ae+tFizOVhsbX@nongnu.org
X-Gm-Message-State: AOJu0Yy+HfJN1KNtqeD6oRsMheZ4F3cyplfJ7A/Nzq9vA7DlFklq4T4t
 z/ZokkGA3ZIapAhaiU3vdH56qQv+b23LIb0I2F+dPZBbS0CP8WGjWRJxGv9Kmoqton4GaW2n3IK
 k3vtwy+FpZs6wj6bhZ4IaE2hx1HZKDeOle0FwMsp7ltlJpvXapMu2gfoa
X-Gm-Gg: ASbGncvRuprM+d3z6M2Z4ttsFZCrBd+FDdRAaTeFN1e8Hcl9zfyeViAbHYvvlVHFs6B
 saFIHN3g1TcEpYHQbDMqyxgWgVCvpvg5dgtM2coe2bAmapT7anld55xjUuToT+N0o2wLUUMYDp2
 s1TEDNi9VKeQH5QT2vGDbcuqxsMy545F92GzBzVR3RXfr1CDiZ+a30Qo6PsXDUkaEN5zApRaaFs
 i9Xs5+OeCukuMRu9VmrvdW9GQkLMI6ZVY+7Dkrfrpgov2+vxdHCVd7i74x2U+NJYmDYhKOXHNcd
 9zkg2Ft3HS5UV0ZC
X-Received: by 2002:adf:f58c:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a539d73f90mr9798611f8f.47.1749572083072; 
 Tue, 10 Jun 2025 09:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGso1vb61dE/j3z8KqF7YodcmlZvAlOQ4RKOCcnYswwN92Gdg6Ww0SjL8pyHelqO0rywvboiQ==
X-Received: by 2002:adf:f58c:0:b0:3a5:39d7:3f17 with SMTP id
 ffacd0b85a97d-3a539d73f90mr9798572f8f.47.1749572082557; 
 Tue, 10 Jun 2025 09:14:42 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323ab1a2sm12510052f8f.28.2025.06.10.09.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:14:41 -0700 (PDT)
Date: Tue, 10 Jun 2025 12:14:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 yuanminghao <yuanmh12@chinatelecom.cn>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/1] vhost: do not reset used_memslots when destroying
 vhost dev
Message-ID: <20250610121422-mutt-send-email-mst@kernel.org>
References: <1741024937-37164-1-git-send-email-yuanmh12@chinatelecom.cn>
 <20250513141341.5f3ffa57@imammedo.users.ipa.redhat.com>
 <36d6672a-6d06-4af2-bdc6-4349df570662@redhat.com>
 <20250514111224.7fb1263f@imammedo.users.ipa.redhat.com>
 <acc02028-89ac-49ad-9c5c-d6973738b113@redhat.com>
 <20250530071844-mutt-send-email-mst@kernel.org>
 <b89fc010-cf76-4951-8d06-80dd7c2ebc8c@redhat.com>
 <20250530073603-mutt-send-email-mst@kernel.org>
 <89639b23-6061-4c18-96c9-1f2d3bcd773c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89639b23-6061-4c18-96c9-1f2d3bcd773c@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 03, 2025 at 11:15:18AM +0200, David Hildenbrand wrote:
> On 30.05.25 13:36, Michael S. Tsirkin wrote:
> > On Fri, May 30, 2025 at 01:28:58PM +0200, David Hildenbrand wrote:
> > > On 30.05.25 13:18, Michael S. Tsirkin wrote:
> > > > On Wed, May 14, 2025 at 11:26:05AM +0200, David Hildenbrand wrote:
> > > > > On 14.05.25 11:12, Igor Mammedov wrote:
> > > > > > On Tue, 13 May 2025 15:12:11 +0200
> > > > > > David Hildenbrand <david@redhat.com> wrote:
> > > > > > 
> > > > > > > On 13.05.25 14:13, Igor Mammedov wrote:
> > > > > > > > On Mon,  3 Mar 2025 13:02:17 -0500
> > > > > > > > yuanminghao <yuanmh12@chinatelecom.cn> wrote:
> > > > > > > > > > > Global used_memslots or used_shared_memslots is updated to 0 unexpectly
> > > > > > > > > > 
> > > > > > > > > > it shouldn't be 0 in practice, as it comes from number of RAM regions VM has.
> > > > > > > > > > It's likely a bug somewhere else.
> > > > > > > > 
> > > > > > > > I haven't touched this code for a long time, but I'd say if we consider multiple
> > > > > > > > devices, we shouldn't do following:
> > > > > > > > 
> > > > > > > > static void vhost_commit(MemoryListener *listener)
> > > > > > > >         ...
> > > > > > > >         if (dev->vhost_ops->vhost_backend_no_private_memslots &&
> > > > > > > >             dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
> > > > > > > >             used_shared_memslots = dev->mem->nregions;
> > > > > > > >         } else {
> > > > > > > >             used_memslots = dev->mem->nregions;
> > > > > > > >         }
> > > > > > > > 
> > > > > > > > where value dev->mem->nregions gets is well hidden/obscured
> > > > > > > > and hard to trace where tail ends => fragile.
> > > > > > > > 
> > > > > > > > CCing David (accidental victim) who rewrote this part the last time,
> > > > > > > > perhaps he can suggest a better way to fix the issue.
> > > > > > > 
> > > > > > > I think the original idea is that all devices (of on type: private vs.
> > > > > > > non-private memslots) have the same number of memslots.
> > > > > > > 
> > > > > > > This avoids having to loop over all devices to figure out the number of
> > > > > > > memslots.
> > > > > > > 
> > > > > > > ... but in vhost_get_free_memslots() we already loop over all devices.
> > > > > > > 
> > > > > > > The check in vhost_dev_init() needs to be taken care of.
> > > > > > > 
> > > > > > > So maybe we can get rid of both variables completely?
> > > > > > 
> > > > > > looks reasonable to me,  (instead of current state which is
> > > > > > juggling with  dev->mem->nregions that can become 0 on unplug
> > > > > > as it was reported).
> > > > > > 
> > > > > > David,
> > > > > > do you have time to fix it?
> > > > > 
> > > > > I can try, but I was wondering/hoping whether Yuanminghao could take a look
> > > > > at that? I can provide guidance if necessary.
> > > > 
> > > > 
> > > > Guys?
> > > 
> > > Is the original author not interested in fixing the problem?
> > 
> > Given the silence I'd guess no.
> 
> SMH, why then even send patches in the first place ...

Drive by contributions are not uncommon.

> Will try finding time to look into this ...
> 
> -- 
> Cheers,
> 
> David / dhildenb


