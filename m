Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9551C88E54
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8j-0001ju-Va; Fri, 11 Sep 2026 05:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8a-0001cg-Iz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8X-00081E-T6
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=fahyY/lvZ8FptJTsZw7hnl8pslfmZmY+iDk6FQPFRHXaXJ22EJYshEnU5+7aR6409turam
 M3R168HyuRDWWDdSK6XXYvhpO28uO+yZBtZZ1JQ+ye0v4geLwII3crRnBLUI7Hvy3CkCtx
 iG2QGutk4ak1dwDWEFxnAReY1s5W38g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649--RBpQmrMO--kpXcMl9R-sA-1; Fri, 11 Sep 2026 05:01:29 -0400
X-MC-Unique: -RBpQmrMO--kpXcMl9R-sA-1
X-Mimecast-MFC-AGG-ID: -RBpQmrMO--kpXcMl9R-sA_1789117288
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so5946025e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117288; x=1789722088; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=BUZ3yhLBFMwK6LqnZVdCzVMvnbe5bs2kwatZyPCZOT2Itz4XdzlXjAazZ5NihXdJGZ
 ZHU+vzIdwaRgUJoyrSdJBqS3OPxS3EOLBPtyzcDcUdUo5jKeyxOYNkb8piUN4NN/VlJU
 oY7qGblHrn/dYsBKJr/5glpiaSz+VWw+XPfQ5+J02p8MQqXAncQhOmcljsfl5K7htPEx
 8gNdG3dGUbBnt2rF9mgqbu/RU4cxXR9MTSwj8IH78RpWifkyOlFquivB8dfKcQ31L0Mw
 vqv/iEbliVjcsSpOGg9gUajBd87vvUoRSrDPXWu4xjIWWwkrZdZ1zQuuWX/SZBwWsVTl
 4OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117288; x=1789722088;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=duT8sfy/1vmAKnbU6GKLoZk3/IV53fEkN7T7OylyeSg=;
 b=nv6YZqCylKd/dX8wSSa+zvK2H2x+zZFTprm691Lhtgvu/jl8VbUY/BylptSk27Dfas
 EY23xFlp9aIYVelVLGQnJYBr/LqHzbhL5MBI4b/XTHjlb379W8t0wjYrRJzsT1/z9Mn/
 quuyGSckUNp2aFSbC318lD1Cf/1m+PotTnu8v+R1wD1gk8fDYFb09nEwbd63Ao3+8z5K
 DQ+kSnwJ/Ik3nS+gO9K4gj06LOCNRakml8/3TQA1WHgEsJ5kKN27zKNHceJ54kg8kIgX
 xLNEDBfzk0oz2qR4CLLsjDw+Pw5JWuHYseC5/uCGiJ+Nf/E9fdWoprKJuU5abM8DHEsl
 dJdg==
X-Gm-Message-State: AFuF++kcjF2KQW21i8ojdXr0GjcsW+G2nXcvm2PqCIemm5Y8YbPcC/W/
 SarRUizVuV/OQswO2CCVfJRz/1HBNymbh56vdChddTpbbT5CGg1RqTXki5VZCJeIVod+rO/YzwH
 6OumPBpo/0EvtOj/AIlOVivWRVr6Z0tnGpo2LNCXmss0UlMnXFPxHGm1Aw/zOFCL3xRvTWERPKV
 xRWI6JVRR7JuG6iXn7fm4ToqDx2LAG3m9mSw==
X-Gm-Gg: AYBFou1m3pGs4zPQMvPx0CHlEx7Xp64wnNYmX0Md0r3IfIS8ptLZsAcKqAb4z9wthKT
 C3CzZ9rAnAaX+65W8bt3VnYvzNX7T1lX4QzA3zauaU0sKMoT5JqlZDmAsdDDQAhIw9ib1McLvHL
 SqH4n0T8FnvvQhbrumowRt2PaqIhEmEG90e05cw9fpmpOwbr3kdACdXJeOeer1zq7RjT94nmRKz
 5Jsu4vZiRqdmolfl9d8SO7E6B4bUJkckgZTiJSJGb84BBmjiih1lsVlAtHX96mq95IY3Ekq7/3f
 CHZLLTQnAAZzVNRh4E5z4j8rMJSPMBicIW5oZx/CT2NKp3oUlh0p4blgWwDy6yqJglu8USbP2em
 m17+wSMDD4RjfMvDTdkQTbzk=
X-Received: by 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id
 5b1f17b1804b1-49e61983771mr26335675e9.4.1789117288135; 
 Fri, 11 Sep 2026 02:01:28 -0700 (PDT)
X-Received: by 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id
 5b1f17b1804b1-49e61983771mr26334855e9.4.1789117287535; 
 Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6576122bsm36196675e9.2.2026.09.11.02.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:27 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL v2 04/75] hw/cxl: Fix guest-triggerable QEMU exit on reserved
 interleave ways
Message-ID: <713e7e85a2b43e9d4e58d91643aef230d2c30b07.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Junjie Cao <junjie.cao@intel.com>

A buggy or malicious guest can program a committed HDM decoder with a
reserved Interleave Ways encoding (e.g. 0x5-0x7, 0xb-0xf).  Two call
sites pass &error_fatal to cxl_interleave_ways_dec(), which calls
exit(1) on the reserved encoding before the subsequent decoded_iw == 0
guards can run:

  - cxl-host.c update_non_interleaved(): called at commit time from
    hdm_decoder_commit() via cfmws_update_non_interleaved(), so a guest
    writing COMMIT with a reserved IW terminates QEMU immediately.  This
    is the primary trigger on the current tree.

  - cxl_type3.c cxl_type3_dpa(): called on memory access while iterating
    past committed decoders to accumulate dpa_base.  Once the commit-time
    exit is removed, the decoder stays committed with the reserved
    encoding, so a later guest access outside that decoder's range would
    otherwise hit this second &error_fatal; both are fixed here.

Pass NULL instead of &error_fatal at both sites so that the reserved
encoding returns zero and the existing guards handle it gracefully.

This can be reproduced by writing the HDM Decoder 0 Control register
with a reserved IW encoding and the COMMIT bit set (e.g. IW=0x5,
COMMIT=1).

Cc: qemu-stable@nongnu.org
Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
Fixes: 48461825af1b ("hw/mem/cxl_type3: Fix potential divide by zero reported by coverity")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260618104316.557306-1-junjie.cao@intel.com>
---
 hw/cxl/cxl-host.c  | 2 +-
 hw/mem/cxl_type3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index eba13c9e7c..369a985f9b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -442,7 +442,7 @@ static int update_non_interleaved(Object *obj, void *opaque)
             }
         }
 
-        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, NULL);
         if (interleave_ways_dec == 0) {
             return 0;
         }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 28f41fa623..6f44770db6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1200,7 +1200,7 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
         }
         if (((uint64_t)host_addr < decoder_base) ||
             (hpa_offset >= decoder_size)) {
-            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
+            int decoded_iw = cxl_interleave_ways_dec(iw, NULL);
 
             if (decoded_iw == 0) {
                 return false;
-- 
MST


