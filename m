Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C26ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfmj-0005lX-WA; Mon, 09 Sep 2024 10:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmd-0005R2-UO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfmb-00072G-OY
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muYuhVo8+jXYQG+i6YJIJ3ax/FpbTBxwSGmzcCzGN5c=;
 b=T0CVXYs9uORhZ8TcIrjEHZg6p8tBAYS0TEbiCDhAwQkADEMoI3220PiwrzFeilBeq+R5Ju
 V0lxc29j+Ohz6H+0bj/gybgFzSh4sotkz3oDj75SRQKp+ssSVSJ2jtbu36j9Tjofo0gXNs
 7KdT4uG2aAobcQhL69xLMOY+yWzof2c=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-VYQGZvV4OzSgKlkDLSf7jw-1; Mon, 09 Sep 2024 10:54:20 -0400
X-MC-Unique: VYQGZvV4OzSgKlkDLSf7jw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5df9375c3b1so3551924eaf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893660; x=1726498460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=muYuhVo8+jXYQG+i6YJIJ3ax/FpbTBxwSGmzcCzGN5c=;
 b=nWrTQP4wKOYwbQveeSqfArOjhQoG1w5T65niM4IH1KGoJrmfl1FelX8Q8826GZJ/Wk
 EyBA3lEeLVkSXpLsINDNmKwzgvaKiNDmCH+Rx1mvwTxo1XasN+MxjsU5X1A9+YXHXZGc
 uG+US70M2NKWEqyIEaRWnaIYOuhRSwszDEDFMI1bjFMjZud9iCuyIdJ+4qg6YSMKbsI4
 USWl/v4cA5TyjYJlMTgDvDOyPy06I3knJaTwh8J4KWS1x4MXNb/hAMYkKvR/2f/EEWOD
 GzOk+uL2huCqDzUsYdCTiEaPUfMgpBc/sE8DGsxl6OSIqgZt1p9hDmmoKMNPP5M0tMLe
 tJpQ==
X-Gm-Message-State: AOJu0YxTqZocXC5gvLHLkMmUOHDyVFXjrKvOutW9wFAvRTVh/3f2lHym
 +NGbtzd/frEoduLDDa2G5H8CxrndrbWiyPHoDq56E6LkKeGtBvRTHsumMUW0N7gzMXVLeTQ3Evz
 qhMseGj0kXK49gRjXBpHhYCU1flBqbH5ilfmCV2yBnhEZNkc2HtbGGEzCdONmx6ARMbCsC3I4tu
 kzo8wCpFhrAgrIKf/D6e2tBMehWgQWwp6lXh1H
X-Received: by 2002:a05:6358:5699:b0:1aa:c9ba:4330 with SMTP id
 e5c5f4694b2df-1b838594932mr900867755d.4.1725893659857; 
 Mon, 09 Sep 2024 07:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES5WhyBmF3sil484vp7OgwsJAW2XD+suHtu9rSq+4peKLE8F1Ftmss6TZ3kRCSJ07u5mIsBA==
X-Received: by 2002:a05:6358:5699:b0:1aa:c9ba:4330 with SMTP id
 e5c5f4694b2df-1b838594932mr900863755d.4.1725893659338; 
 Mon, 09 Sep 2024 07:54:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a9a79455b1sm225387585a.19.2024.09.09.07.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:54:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 peterx@redhat.com, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 2/4] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Date: Mon,  9 Sep 2024 10:54:11 -0400
Message-ID: <20240909145413.3748429-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909145413.3748429-1-peterx@redhat.com>
References: <20240909145413.3748429-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index c51a3f18db..2a2ee4e7d7 100644
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
 
     /*
-- 
2.45.0


