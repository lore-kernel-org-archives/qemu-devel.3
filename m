Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E07ECAC58E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbE4-0003ui-M9; Tue, 17 Sep 2024 12:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbE0-0003ic-3b
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqbDy-0008TW-1F
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 12:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726591124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eenrsbEr6uJN92Yt183uHoXgP8OKY4iqp8mQemFQxtU=;
 b=UXuNTBrSkgzeNlijWjsv22RgBeTKusJf303lZl+g+Y6goLYA4SYQ5svv3kk1XUBeccBYqA
 T3YaP8JzA9ddBE0IxMwIF259mz/V6yceJfkb+uhgyXJi+1cGv3/TGTSYQBHKArdRWI3uDV
 ltcou52dy+V31U+NHqC4qbCfxs2NiDo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-nw-bClk3N_-6tYLN9g9WrA-1; Tue, 17 Sep 2024 12:38:42 -0400
X-MC-Unique: nw-bClk3N_-6tYLN9g9WrA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-45834f5927aso94088751cf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 09:38:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726591122; x=1727195922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eenrsbEr6uJN92Yt183uHoXgP8OKY4iqp8mQemFQxtU=;
 b=IUSPvGTprfyVCozmDVhZ6LMUsDbJOqrpjtimj4W8hZ0Am6swJtJoZ39NztA/cHq+uX
 8zhcvqZOsjEr3ULxV6N6O2l45e29kKlzuuOeqz5tiVQRUzWMEZDEElwa7eK3YMACIdc+
 ruSx0k5KcooePFZa9lF2gW0nUWqSqIJsVjxTKNNNPtks6pev6e6zu/4No5Jn+SLqEoo4
 XQQ/Zf3uJ1CNKOilLQyVqMz+ut9DYrLe0Ms/QdRPOcG+eVN+AL5vuCoHLW2ojSss9A3y
 di2giLjHP3NARBe8AJPJDV+ZuVcz5GLpFckr/SScba4leO/DxLwXDK/Iutdalj+1CeLT
 Kn1w==
X-Gm-Message-State: AOJu0YwjZXU7Jmp5AKx9oCu8HMOPmlgI8k3kxhS5o6eYs3K1hzPDlAV2
 kc35deMzb0MnP4YDQm8Ef6at2YYAkjESAn9ZeAqgD3EoKyM0bYmbDTTW5OReSYV+p4933iOdp12
 Lx27MEZoHJWd2E/85lQwimffgq96ZZuRTS1nVtpZ/XoQ/nUNhfv98WRpVd4hhYCTIHnAi93Yhmg
 ilcExMXahZqlDOlJ/tzsIghk7FeUxkpL8lNZu1
X-Received: by 2002:a05:622a:2985:b0:458:2945:c4a3 with SMTP id
 d75a77b69052e-4586044df56mr272042091cf.56.1726591121797; 
 Tue, 17 Sep 2024 09:38:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9ypQjNrqRXuZW+HM0HoKKw84fnSrIcDR1EUfnrD80q0bpkvuTSxriC4/mzvhxeSF2pdhVFg==
X-Received: by 2002:a05:622a:2985:b0:458:2945:c4a3 with SMTP id
 d75a77b69052e-4586044df56mr272041781cf.56.1726591121365; 
 Tue, 17 Sep 2024 09:38:41 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2497asm39942911cf.95.2024.09.17.09.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 09:38:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 2/4] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Date: Tue, 17 Sep 2024 12:38:33 -0400
Message-ID: <20240917163835.194664-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240917163835.194664-1-peterx@redhat.com>
References: <20240917163835.194664-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Make the default max nr_slots a macro, it's only used when KVM reports
nothing.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e0430f08ea..0b66c8b27f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -71,6 +71,8 @@
 
 /* Default num of memslots to be allocated when VM starts */
 #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
+/* Default max allowed memslots if kernel reported nothing */
+#define  KVM_MEMSLOTS_NR_MAX_DEFAULT                        32
 
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
@@ -2515,7 +2517,7 @@ static int kvm_init(MachineState *ms)
 
     /* If unspecified, use the default value */
     if (!s->nr_slots) {
-        s->nr_slots = 32;
+        s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
     s->nr_as = kvm_check_extension(s, KVM_CAP_MULTI_ADDRESS_SPACE);
-- 
2.45.0


