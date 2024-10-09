Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA12CEDD8F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 12:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syW48-0002l6-PM; Wed, 09 Oct 2024 08:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW3x-0002My-6N
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syW3u-000675-U3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 08:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728477905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGH2t+Aydc23FcuIBLI+pqNneU77CC+KunJmPkybxKc=;
 b=Gcnep5pAGQ4bav6iywNNUI5G48wfLUTcxvxf43/XZRoPNy3nuHiPImyY+wevt6yaQDWqiq
 X3q5OzLV96aNtR+shsmd4ajHYkKp/JVJ3vomHl+5FJ0dGB/5GpLWw3U3lzSZU8M2zIMqZ1
 /EIWU+MWlKw5XngulQWZQfMP+62QHM4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-U2iell8VN0yFdcbFNGRnfQ-1; Wed, 09 Oct 2024 08:45:04 -0400
X-MC-Unique: U2iell8VN0yFdcbFNGRnfQ-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83546bebd9eso9703139f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 05:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728477903; x=1729082703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGH2t+Aydc23FcuIBLI+pqNneU77CC+KunJmPkybxKc=;
 b=Vy51GXXvpV7PX4nuIpfQtv3rw6M1b+uWjaNvlvvMs271Eit8/AgPQZrPn2yZuKRl7l
 wXho6hSd2643vrlavPtS2epUauKkbGDKCNad1yZMi0zRR4R6+j82RuFyrpBOZsz1kLAU
 s/FOLen1Fo6SuUTm98p+ccK92kg7dSoblCKSIXZm5I7vp4IhhL3tYGfAMdDmHr1tAWSR
 zMG7N83wm0dDDTZw8aW7gSDbPliYGI5kroE/qrrndtmNwy69W9fbfemT1jaVfn8FkCiW
 Dy/L2YYGwQ/dMC4zz4jtO0kkP00yvttAD8fRlJxfeXjnm1bf2JtyfB3cIbQB0rRqJvXx
 uH0A==
X-Gm-Message-State: AOJu0Yy5MzGTH0xFg4Fno11VIzZFrDxjO4lUS+bLfy8MI4/7VeSufRk2
 EZrSjE+0R4JNkyXhsWwfJl/bpgBYTFhQQGkpcpYGHLOmf7Tb0hKbwZiZB3jlfJXnmPsTGlJSCTw
 y7ahEhnxkc61eFQSUBtOr2ZUk3D7+tYxWMtRws/WSALQ7FavjgLWE3s+Zqr1aPonQLJ2N4zNP8i
 Y6QBeXzVH6KB3TczY2QelpmbmJROt1/h6Szg==
X-Received: by 2002:a05:6602:2c8e:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-8353d4b3213mr274012139f.6.1728477903183; 
 Wed, 09 Oct 2024 05:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrU8PjdHvSpNXppZoVUZohAIQnw8xDqIhxyvtV6r1Fy2OyqbvTlR1lAEkrX3HwaO00Nf4UGw==
X-Received: by 2002:a05:6602:2c8e:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-8353d4b3213mr274006339f.6.1728477902695; 
 Wed, 09 Oct 2024 05:45:02 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83503aaca17sm217708839f.29.2024.10.09.05.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 05:45:01 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:44:59 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/4] KVM: Dynamic sized memslots array
Message-ID: <ZwZ6ywR0FjxJZBEL@x1n>
References: <20240917163835.194664-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917163835.194664-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ping - Paolo, could you help have a look?  Thanks!

On Tue, Sep 17, 2024 at 12:38:31PM -0400, Peter Xu wrote:
> v4:
> - Remove restriction on kvm reports smaller than the default alloc size
>   (KVM_MEMSLOTS_NR_ALLOC_DEFAULT) [Fabiano]
> 
> v1: https://lore.kernel.org/r/20240904191635.3045606-1-peterx@redhat.com
> v2: https://lore.kernel.org/r/20240904223510.3519358-1-peterx@redhat.com
> v3: https://lore.kernel.org/r/20240909145413.3748429-1-peterx@redhat.com
> 
> This series make KVM memslots to be allocated dynamically in QEMU.  It
> fixes a migration performance regression that I observed, reducing precopy
> dirty sync process from ~86ms to ~3ms each time.
> 
> Patch 1 is the fix to the problem, while the rest three patches are
> cleanups.
> 
> Thanks,
> 
> Peter Xu (4):
>   KVM: Dynamic sized kvm memslots array
>   KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
>   KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used
>   KVM: Rename KVMState->nr_slots to nr_slots_max
> 
>  include/sysemu/kvm_int.h |   7 +--
>  accel/kvm/kvm-all.c      | 105 ++++++++++++++++++++++++++++++---------
>  accel/kvm/trace-events   |   1 +
>  3 files changed, 87 insertions(+), 26 deletions(-)
> 
> -- 
> 2.45.0
> 

-- 
Peter Xu


