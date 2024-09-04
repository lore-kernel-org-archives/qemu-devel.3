Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C434CD4F3E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyaw-0003qB-Hj; Wed, 04 Sep 2024 18:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyau-0003mX-Ht
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyar-00019C-Nx
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725489316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m/DbK9XdojHuefj3uLrJXs3OU/fV0mAfxAnovKnnqP8=;
 b=aD4ksJ5iI9PBeIb56ZjtS9FZeyNwSkIGkBmwgTuuXDjeVgFFWijQWMXKKF1F/+b1z5DYNm
 IoXdoD/IPJSSxY9dbN6cN7RjXsidit0QtfZA5+J6ael5hgvEpQ9B+5a99G6JMVmA3K3XX+
 bmzqdee33SlTWQkRXk5AF59u26BxbeU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-43XQz7FxNmmM9Kpr3jyj8w-1; Wed, 04 Sep 2024 18:35:13 -0400
X-MC-Unique: 43XQz7FxNmmM9Kpr3jyj8w-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-456916c1889so1742851cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725489313; x=1726094113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/DbK9XdojHuefj3uLrJXs3OU/fV0mAfxAnovKnnqP8=;
 b=IZ1L+8ln/UwAAw3025vjleEzE6ge9NZiG+DnZYZVv41rBXabaz+THK3zdWAAv1gscl
 nvKHEKRfV3Nj1xg8JSo8/9ci1Lc7AdL0BexgPT82zi4zc+qj/wkW8s1cP/hwXDRwqcbV
 rHSDtnOLJhxrI5NtnKatzh62jpHmwC+eTQimo04uzQPUZcTBaui/2DGKawx6Ic0HR3MH
 n65g1/7IlJ8SDjQBhh14bHMWl7hHTZZigJLZooPqf6iKAbOKvC1tk1cRs6gXDl/oPSI2
 eJDy49Sze5Q/VFS3candRIG3VRcelY4gDsWH5lTXTScAGNWxlfGGHTm4o/VkJnoUqe/v
 BIlg==
X-Gm-Message-State: AOJu0Yyx82t7ZzvnH2UfYqyKRNJnz5FSgga2udPuKuVkk4qBn65KPNaQ
 lGQNKDs5m/n9BPzu4wT7SGQRbTIOPnompMY+EkFvkzzOvnhe0MQ7Aeqnzc68fo8k6O+lYZ4/i52
 GPP/e392zXr2zglYWWBlA7r4avUrgzURhPRaLpaKZL6kEvAj13vcky0aA2+8jVOybJkkZVfS7fT
 p7MOYU2ABr0Jv/KDS2pTWp1IcHgrC35Vt60bF0
X-Received: by 2002:a05:622a:420f:b0:456:3d80:ff43 with SMTP id
 d75a77b69052e-45756a4ba08mr134240721cf.35.1725489312729; 
 Wed, 04 Sep 2024 15:35:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrJwjAGjs9kbvkb6agVDFdUJfT/jCE64YqvG9qWZm1qD1Zonfz2s4enNo5uTYp3bA2pA+K+g==
X-Received: by 2002:a05:622a:420f:b0:456:3d80:ff43 with SMTP id
 d75a77b69052e-45756a4ba08mr134240331cf.35.1725489312230; 
 Wed, 04 Sep 2024 15:35:12 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b35df7sm2428881cf.33.2024.09.04.15.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:35:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/4] KVM: Dynamic sized memslots array
Date: Wed,  4 Sep 2024 18:35:06 -0400
Message-ID: <20240904223510.3519358-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

v2:
- Reordered patches, make the fix patch cc:stable
- s/NUM/NR/ for the newly introduced macros [DavidH]
- Added kvm_slots_double() wrapper [DavidH]

v1: https://lore.kernel.org/r/20240904191635.3045606-1-peterx@redhat.com

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
 accel/kvm/kvm-all.c      | 111 +++++++++++++++++++++++++++++++--------
 accel/kvm/trace-events   |   1 +
 3 files changed, 93 insertions(+), 26 deletions(-)

-- 
2.45.0


