Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AAD8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyav-0003o9-WE; Wed, 04 Sep 2024 18:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyau-0003mY-IZ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyas-00019O-Hn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725489318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n96AsVK5wxnnnoMRLrLFJzon8QcyNjwp4J+Dv4Znv6c=;
 b=XL7K1PkEXPoYxDurqlfzB+QPn4fhhyp7PXHVDvUJx5qDR1dU4RFSmmb9kj/tAyx1L1n7LF
 8ZYZjeJo+wC6BE1SzlmSeyPgrNqLppz1dbhLNeV7t5DvKivXsN62I/7ykhKGuMbRX1oKop
 lqkUaj4Gg/nsfrjFel6Fgm0P1q6J/eU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-RvUdrT8ZNQSFrlTe42xOYw-1; Wed, 04 Sep 2024 18:35:17 -0400
X-MC-Unique: RvUdrT8ZNQSFrlTe42xOYw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-457d35e797bso1436091cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725489316; x=1726094116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n96AsVK5wxnnnoMRLrLFJzon8QcyNjwp4J+Dv4Znv6c=;
 b=sVhTTu0hDD0Sz4v7aDUzG/UnS7PNJsVgW6uZ22POX7GIfipf3MU00BIKcGxqF6yQLg
 hjP6tOgjMd2wmitB1nhvinvLuZMaLgz/2DwpcFsRYpJLimLSRU8AKttQfFHUvOre8QqE
 JPwn+uDOJnasDBxWye1Q9ikw5iKsqOt7BmWHj4EFk+lRtiynoCFQ16ma0pflvl31xDMC
 ycX4mLoR2d6keW9Fgpty3MW4DschOi47TUzloXDf7dK6ZveeJA/3NkZvUXX1GlQsqFyj
 H5C+y7Ry80tbven1Q1a9HqhkhyQkaak9lo6Z6HzzD9VzrGSZg/t8nj0O/3iz393a3rmB
 JA1Q==
X-Gm-Message-State: AOJu0YxXdgb98JT7BcyFxo0M8ah5fYM2OvXJ5iJM9uNNcH7lLPFrQm0D
 VIrrj3/AnMe60FK7jAflxPY8mzuwQh6Jc0PUfQix+feiB00odDFVGN473GN6P+fmuCDxV4nT/hV
 97Q9KVcFolz2x1LDTGqAMCkz52Xhg34G4s/5M25hAJTYkZAYzc/uCySpWKqmBPUgU+Q4Vb4ByU+
 rnQ6eLudg/0oYfzDRdiFLhcrHXV1QNMIriHOx+
X-Received: by 2002:a05:622a:2505:b0:455:1f:c876 with SMTP id
 d75a77b69052e-457e2d28ef2mr77535721cf.13.1725489316006; 
 Wed, 04 Sep 2024 15:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEej6DTJw87HRtWA9LFEYoflZXflYbD22qJixPEd6eqCMhYMl/22a2S+6MTDmdU5xt5S3LKpg==
X-Received: by 2002:a05:622a:2505:b0:455:1f:c876 with SMTP id
 d75a77b69052e-457e2d28ef2mr77535471cf.13.1725489315655; 
 Wed, 04 Sep 2024 15:35:15 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801b35df7sm2428881cf.33.2024.09.04.15.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:35:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/4] KVM: Define KVM_MEMSLOTS_NUM_MAX_DEFAULT
Date: Wed,  4 Sep 2024 18:35:08 -0400
Message-ID: <20240904223510.3519358-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240904223510.3519358-1-peterx@redhat.com>
References: <20240904223510.3519358-1-peterx@redhat.com>
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

Make the default max nr_slots a macro, it's only used when KVM reports
nothing.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9368494a8..bc1b039190 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -71,6 +71,8 @@
 
 /* Default num of memslots to be allocated when VM starts */
 #define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
+/* Default max allowed memslots if kernel reported nothing */
+#define  KVM_MEMSLOTS_NR_MAX_DEFAULT                        32
 
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
@@ -2509,7 +2511,7 @@ static int kvm_init(MachineState *ms)
 
     /* If unspecified, use the default value */
     if (!s->nr_slots) {
-        s->nr_slots = 32;
+        s->nr_slots_max = KVM_MEMSLOTS_NR_MAX_DEFAULT;
     }
 
     /*
-- 
2.45.0


