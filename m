Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1624B1091904
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IlN-00005f-OR; Thu, 19 Mar 2026 15:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlL-000056-Fl
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:31 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IlJ-0008PV-RL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 15:10:31 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b45bb7548so868654f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773947427; x=1774552227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/baUhUHLskzt0UuYRNXOTK4Cu8bhklvA3O4wTh+q0Qk=;
 b=xO41od1+3rz5gf2hXW/Lav6Doz3P/k7FWMfkt6twsXpTA5/pMGoVsPidvBRI5kNfCh
 bQADOhJzZFCxdEYARzUwgeokOzULhzU57PxDNizhJj50AXAAwUjqDY2BrH2KMylZ2Jt/
 QAt+3CUvveSgyfkR40gnOtU517qw2nh9GAVofDRITaqPjOEzzq8Sn8MMFLhDnW7TgN1A
 v+iwGjJ8bWZhVnkJuQ1xpW/BpF4f9UkAq4BuBQ+tfDlAPRCAstzH2gW1qjogktILU787
 KI6gVsDWFuIkJ6TfMvexYVvR6EpWuYCnW7p4/FPK4nDyHQWusvAfoBj7ZBHEO57WMWMO
 hOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773947427; x=1774552227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/baUhUHLskzt0UuYRNXOTK4Cu8bhklvA3O4wTh+q0Qk=;
 b=RRt7IO3jWXKuf1nxnU4/OETfyhsP2tWCzhBa9N6hXyyLcZNfafcisAlYGyYaETW8Ke
 Nht7PZsiSjrW1KyMtY9BrzjnJLQU3J3OSRngsMoBQjprm5El2oNED3Jp1T5lLsqi86Pm
 bmlTMnaxKDgIH5PvZtP+BThw44Og8Iru82Ta+dHqaPrIK4dsMRs7gwqvU6dch4US4mM+
 S5+YG0DbryghRcvAznMMkJmwi6mukHSbdC0ox+bS9wlldGJ1yKZBJ7rHB1/GCLVogftf
 kji2sy5ydunYiuW5xyN31+TxsZ/9C/gMpkFhoEPxA0Hh9PQanKiLwUssuvvGJQ76OJDE
 yEFQ==
X-Gm-Message-State: AOJu0Yz8risNzJahi+/+pgZcrWeIj4ZNPgF+W8Hu2LlMzre/OoxLsw4t
 Mq7v6vNVHfQiLCrtoBZcOIt7keBV1h6i3zBrOSHCL9e6qdf75VL+wze4HAPqydPmtoqmgXAB0zt
 I32jCjDs=
X-Gm-Gg: ATEYQzxAxP6inoad/moUhejcOYE24FIegbndZoLFrhzxNsH+rFIxBAWZ7VjzyW7RJlb
 J72340cD2n3EdV4ytnFPF20RrusySAycS6IPXLqw3hpsDy+Ym85XwxUJPuRPxbVZ3Sr0RkTn40t
 YmBO2+oNRcc+u0ODD52eqo1Gq1nTqk4nKJqqWJXB2tY9oFlnwGO/TrMHLgNCfP+EwEkBx/AGoxw
 lAQv/CzRqkeFlxpjWBgpJRV85WgHSza6vVlRQO+anPy2q/qaLj7h33HT29F17tfmPY+N3kHbYCy
 144NK3COy7BlONH+QJvYM0i1BWE70jpmCyDiOCkr2U/s5Q9qjhCN/ku2y4WWebXo+yPh4lsKSiG
 c2G+LrIArg3Yh/1ZXOKP0qIR+Gbv54WqmE1c93JdCdhvpbmuki3BI3Pf9ERSk2NkGEww3qHmOme
 USyJD7Q/vT15YHg6FQlysF2oy+BJZk0lpuRnpaJWi46kYAgva8JaJqHncPlrUc1ujTzia/sfdl
X-Received: by 2002:a05:6000:18a6:b0:439:bdba:56be with SMTP id
 ffacd0b85a97d-43b6424067dmr926369f8f.10.1773947427260; 
 Thu, 19 Mar 2026 12:10:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b647120a1sm641454f8f.30.2026.03.19.12.10.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 12:10:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 1/8] system/memory: Constify various AddressSpace
 arguments (flatview)
Date: Thu, 19 Mar 2026 20:10:10 +0100
Message-ID: <20260319191017.12636-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319191017.12636-1-philmd@linaro.org>
References: <20260319191017.12636-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mark the AddressSpace structure const when it is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h  | 2 +-
 system/memory-internal.h | 5 +++--
 system/memory.c          | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index d7b18b632d5..1417132f6d9 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1201,7 +1201,7 @@ struct FlatView {
     MemoryRegion *root;
 };
 
-static inline FlatView *address_space_to_flatview(AddressSpace *as)
+static inline FlatView *address_space_to_flatview(const AddressSpace *as)
 {
     return qatomic_rcu_read(&as->current_map);
 }
diff --git a/system/memory-internal.h b/system/memory-internal.h
index 5f0524756eb..0066ffdffb6 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -20,12 +20,13 @@ static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
     return fv->dispatch;
 }
 
-static inline AddressSpaceDispatch *address_space_to_dispatch(AddressSpace *as)
+static inline
+AddressSpaceDispatch *address_space_to_dispatch(const AddressSpace *as)
 {
     return flatview_to_dispatch(address_space_to_flatview(as));
 }
 
-FlatView *address_space_get_flatview(AddressSpace *as);
+FlatView *address_space_get_flatview(const AddressSpace *as);
 void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
diff --git a/system/memory.c b/system/memory.c
index 17a7bcd9af7..bd12184a879 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -819,7 +819,7 @@ static void address_space_add_del_ioeventfds(AddressSpace *as,
     }
 }
 
-FlatView *address_space_get_flatview(AddressSpace *as)
+FlatView *address_space_get_flatview(const AddressSpace *as)
 {
     FlatView *view;
 
-- 
2.53.0


