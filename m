Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D8DCAC58F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbDz-0003gB-Di; Tue, 17 Sep 2024 12:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbDw-0003fG-OP
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbDt-0008Sq-Tr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726591120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WLKxu9ByKGz99RrPHg3YA79MbGVUrAWli6p1q+In960=;
 b=RVwgM8SuVXmrPtIRXAHcOtD/AKN3pmBP0e4TkBNDs+1146Wz04YgIY/ceI7hqOEET44Sou
 PlgItNlapNWQQOpEdKgMn5UClASAFmuF81S3XByFfeCaluwiNbMv/HXawBYeG5cwWukz2h
 NW7AJ6nM8CglDFrlREbtmintXElgqLQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-kyQRiU7PMvqgPOPayKN9qw-1; Tue, 17 Sep 2024 12:38:39 -0400
X-MC-Unique: kyQRiU7PMvqgPOPayKN9qw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-45856a29545so112548671cf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591118; x=1727195918;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLKxu9ByKGz99RrPHg3YA79MbGVUrAWli6p1q+In960=;
 b=wd1FHIKvg0TR/AgdJ8/kjwBa8UiF8ciuINdnoL3rIjgfbgUA+D8tLh9ugBt1rwQXAM
 f4I6AoloKxhM/BtbKMxAbNgBr8NqhcIz8PkeAltgw2FloKo0tt4jtyFmmFfp2QjUhXXB
 fhAbV066OLJUccFfyQBPCgrDzDTrAEbY7rLMiPRs/P2Q1kELmZuKQ8+tveoeGIhWf90P
 mDFrMtYM3G1Oy32TZ5vMm615c/sJpHBAIp6bffmh8hYv+LYGy4goJx+UL+FbXy0KnpIR
 JOxE5zqgTvhQu1kD+tRrHgaljlxTIXFZqrsz/3hFvqC8ehZcxRftG6FgM+Po2Pz+R8Kr
 mzLw==
X-Gm-Message-State: AOJu0YxzEnVod56nQIPkyOkM1UfvG6txot+anCJXk1ivRX9pHmvx+kNQ
 c6pw8Kdc6ckaMJv1Snfk6Dqd6asl86TBnVPC/GwzPjSqZ1rgBLaUIhaZGg90FewgeLNnunH5/u6
 Q7ZMAYoJXSbv5BkdUfGMSEo42YXVCvqwvAhGWebSiz2/4SbLVKd+1c6AyGwYaSZZOehemuCZV97
 y9VPRAt5JSdbKFa7bRWNZ5OuORI9cNMK2Pc0hU
X-Received: by 2002:ac8:7f41:0:b0:458:3a9e:4a0 with SMTP id
 d75a77b69052e-4599d29c917mr225280321cf.41.1726591118068; 
 Tue, 17 Sep 2024 09:38:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUVjod8Xz4Pmpz8wKUq5ghbktcW+VzYtMEvXHmF2JF/yCizwm71MGhRUyH+iVkHvaXHToHwA==
X-Received: by 2002:ac8:7f41:0:b0:458:3a9e:4a0 with SMTP id
 d75a77b69052e-4599d29c917mr225279811cf.41.1726591117407; 
 Tue, 17 Sep 2024 09:38:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2497asm39942911cf.95.2024.09.17.09.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:38:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 0/4] KVM: Dynamic sized memslots array
Date: Tue, 17 Sep 2024 12:38:31 -0400
Message-ID: <20240917163835.194664-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4:
- Remove restriction on kvm reports smaller than the default alloc size
  (KVM_MEMSLOTS_NR_ALLOC_DEFAULT) [Fabiano]

v1: https://lore.kernel.org/r/20240904191635.3045606-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20240904223510.3519358-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20240909145413.3748429-1-peterx@redhat.com

This series make KVM memslots to be allocated dynamically in QEMU.  It
fixes a migration performance regression that I observed, reducing precopy
dirty sync process from ~86ms to ~3ms each time.

Patch 1 is the fix to the problem, while the rest three patches are
cleanups.

Thanks,

Peter Xu (4):
  KVM: Dynamic sized kvm memslots array
  KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
  KVM: Rename KVMMemoryListener.nr_used_slots to nr_slots_used
  KVM: Rename KVMState->nr_slots to nr_slots_max

 include/sysemu/kvm_int.h |   7 +--
 accel/kvm/kvm-all.c      | 105 ++++++++++++++++++++++++++++++---------
 accel/kvm/trace-events   |   1 +
 3 files changed, 87 insertions(+), 26 deletions(-)

-- 
2.45.0


