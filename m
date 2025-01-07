Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E45EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 21:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVGuN-00066k-BZ; Tue, 07 Jan 2025 16:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVGuE-00063l-0j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVGuC-00035p-J0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736284466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMoCt/eAfwQB00MIvKfJbCKoNeOYalI//Qiq9q0tgeQ=;
 b=VKyRyMQDRvaZBgdnK4sA96f2N5AsJtpIekUfs/Gv/DW9n/t7q34J2xz/lFBFsB96qHzKAj
 e4CqTQwjf6aXYmyi1DF0Wy8Nrs6Fw+7x3bG69swnAbFPBr2E+ZRgepl257ThmYTv5sycAN
 7LVqJ9AVVq/ElW5l6r+GcKIfNC/vAbA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-kfzviAvBOo-kcvOTr0saDA-1; Tue, 07 Jan 2025 16:14:22 -0500
X-MC-Unique: kfzviAvBOo-kcvOTr0saDA-1
X-Mimecast-MFC-AGG-ID: kfzviAvBOo-kcvOTr0saDA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6ef813ed1so2492269285a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 13:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736284462; x=1736889262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMoCt/eAfwQB00MIvKfJbCKoNeOYalI//Qiq9q0tgeQ=;
 b=RdW8GY8nNMUMIEliH7DvHcmQmDetdT1+J9rtoAs7vEby7+8eY7wNMlzExQFyyhqh2f
 Yy9Avqi9p8eUBXu0NLATv5+IdQeuIakzRcOvYKZ238RoozmEjixqAw59kwpLtN7Xx7jj
 8lzrtg6YRzGiNBkyjxgPy0L7q8wuamlt1ahvJ5iVpfcNEvjkdiZBUr9c8hEZuTQVxo5n
 3yeNsG4J6qCh2ZHk2KB5vI+M3k3E4NpiK2w86xkBe2PI/yoiSVaaBImFY2SHMtZBiCqw
 cUgumRpQcd7fst5+v3dkvt8tue2ZPOC4ZRyP+ehMNSWjrD6n1QlURMO8pBrSamM4TctE
 EfDQ==
X-Gm-Message-State: AOJu0Yw9EGHcHJypTzsBBIpsswdXK5r4PEY1pbjVZYfqM+FqKYuJzZFl
 jUhk+KBVHoYAUwBzImaxV+Sw5blv6cVY0P8h1SIjBFQBj6SX1vQD4NnhQudqYUEPSRn3mET0jve
 gPFM1AQkKjdpU1eAFgTt452h9sHgltGW/B4nTkos+mq+Gz0pJi2Q6ff2IHbTA
X-Gm-Gg: ASbGnctrf+YL8vw2c7x63jJSjC5G1WtQNuLsyrKb/EVUT1NuFOYL0ZRdWcvqknAVtIa
 xZVXhpDyxR4ZgCt0G9uvbNoybTKzdlbeT20GZ1C67Xx2PlnUW0t6RTuYiChPsp/fGA3rvI18nej
 SVyl2/Vl94DiVuiMWKKmlSOjfp4ISuUZlJYsSK4GS1FGbDvIEJoqEV4qOP6Zqvy7pt6vmISFvBK
 wuV79I5BVn8moKRNAxX5SGphBmg1nTPTcNSjvXIBbIE1KxwqlujRjBhaEgA1cn6zTIlAt+hYI4V
 kn1jengnGjApGh5XZw==
X-Received: by 2002:a05:620a:4014:b0:7b6:ce6e:2294 with SMTP id
 af79cd13be357-7bcd97d7ac1mr32711485a.56.1736284462030; 
 Tue, 07 Jan 2025 13:14:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGsh7QW4qr2dQyq1i8NEQkEFaPsXjN6cE97kCV6cHhs4YsixBmYrca/qgY/bdH5stNNUIWYQ==
X-Received: by 2002:a05:620a:4014:b0:7b6:ce6e:2294 with SMTP id
 af79cd13be357-7bcd97d7ac1mr32709585a.56.1736284461796; 
 Tue, 07 Jan 2025 13:14:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30ab25sm1629025985a.54.2025.01.07.13.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 13:14:21 -0800 (PST)
Date: Tue, 7 Jan 2025 16:14:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/7] migration: Remove unused argument in
 vmsd_desc_field_end
Message-ID: <Z32ZK7kuhLozmo1l@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107195025.9951-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 07, 2025 at 04:50:20PM -0300, Fabiano Rosas wrote:
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


