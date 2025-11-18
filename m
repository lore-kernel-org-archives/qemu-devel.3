Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD329CEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQzL-0004aq-58; Tue, 18 Nov 2025 14:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyv-0003ln-3B
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:03:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyt-0006An-9K
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:03:12 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso745855e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492589; x=1764097389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iA9seQt2cQMQ2VDPWWBkJdl2tQJiku0pCkEk7TgvXdI=;
 b=XD1bRm3miottRcyQTfT4aUQpV7bDwhKEuuG3JIQMfeTWAOM7/d9WCRw8e2V2WAdLxU
 qLhdTZM1PrNpIQfanbh7nWK945sh8WPOTVN0ROUbHl6G9jtReTP9PkvO7pBLXkwPk7MF
 nBv5fZDEReJ4WTpb2eTmKxnIalCsUO2noFo3+pSmhw8i4pAXbsyPEi23KNrYZ11tDYeG
 /dEw/2OYUkdIj0Aj34fm6JvGY2qBG2aqrD+zMR7BwGirkLvRRPGpmi1XLWdmM8iUP6B/
 JHyv/njdgCJWYGYfemCi15No8a6wzCfcEB3lefnEqzRM53NS9XSrvWtgJcR5KGnH+eNZ
 nVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492589; x=1764097389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iA9seQt2cQMQ2VDPWWBkJdl2tQJiku0pCkEk7TgvXdI=;
 b=K/EoZV7C2w2L5K7cDcDOsty4j/9yTV6oBS0RPcbvMTwAEAKWLZyM1wZc7mpKaCaVUA
 0IMNNLPYryHYO66hlaSbfNx76V2BR6xPZdOAuDJ0VueO9jtpT+PgFf4xbHx6TmJN9N2Y
 a3m+x3TTocjenWneXpxr+r4K2k3aI1UfRYfur9DULaR9Cx+PrVenzlorAyHR2ji+FfF1
 cJR+ocjKpNEVC/OUyi4ZJmTAcdHgiRoSuxRvXceG2THmJIVO5g7W512POh/oH2mFO+r7
 HFbzFrvWAmDUq+eOO29XbfDpbgcLn8hO6+gJS86JIvcVbktO22A5Ul3p4dfZDDLyhNso
 NbMQ==
X-Gm-Message-State: AOJu0Yy29oK1hUwFdjcXkhowYU+R8Jxelz5te2OqAGLJkzF+RF0J6fgh
 wxD0g2CsP4rkLbGSs8Y8CQUwoOvhRMkBRrxQUskGMka6srx8l0WeBQw0FrUeqBH2UOliOfJIABO
 corwv3IULsg==
X-Gm-Gg: ASbGnctkjvI8+z3oFNosN2f9FOZvl6Hyd9ysew9VqYteUF6NracJLgpy8mbgi4v5Tgg
 DJP0jk0armOk5AeWAlwbkwsAQXvUoz7hJLZNzO5wfd5TBZzqZKgoWBt9hOlBLA1fQGTIzhPTKVK
 iUf/XzSZyJJa2jCRXqjGy1lw3GQqDYkS2vP9mLsbIhuMU5xZ967XxlYo/nh7A/jOprpUtHD8noG
 9Gve+qssRkz3GpU2fm7VWOIJ0FY0EGoMWScTrIAN5sUqFqViJmeVUE21ArAmd/KgF8n4lglU4x5
 /3RBFzDqJjAz8RlZlpLJcH3kvm/Q90I2agegQMTRwG9jhRUILk/CHeyqcc0a7MaHN0ix2i9YICo
 t3LVjEeAmJNwyXybkbZX8SA22Z3dcqp3C5vDGAeSecs5E6N+BUiCPExIGCwPMFxfuN1iQx7t/Gu
 kkv+8mI1ExqftDjgP4PRoDRBLSDiXlzYJVXWcBStg/muhZ7elA0OdabSR7F3OT
X-Google-Smtp-Source: AGHT+IF4RIjl8tIpbJtHVzhHCMWkru0g+jiYz0ES9SwkfdWcGTdfoeleklz2s7oRrGAL/TWZ7YOjig==
X-Received: by 2002:a05:600c:c8a:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-477b0c9f337mr6400845e9.2.1763492588751; 
 Tue, 18 Nov 2025 11:03:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0ffc90fsm5931525e9.2.2025.11.18.11.03.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:03:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/18] ebpf: Make ebpf_rss_load() return value consistent with
 @errp
Date: Tue, 18 Nov 2025 20:00:53 +0100
Message-ID: <20251118190053.39015-19-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Markus Armbruster <armbru@redhat.com>

ebpf_rss_load() returns false for failure without setting an Error
when its @ctx argument already has an eBPF program loaded.  This is
wrong.  Fortunately, it is only called @ctx has a program.  Replace
the incorrect error check by an assertion.

The return value is now obviously reliable.  Change the caller to use
it, because it's more concise.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251118154718.3969982-4-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ebpf/ebpf_rss.c     | 4 +---
 hw/net/virtio-net.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index b64e9da3e36..926392b3c58 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -106,9 +106,7 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
     struct rss_bpf *rss_bpf_ctx;
 
-    if (ebpf_rss_is_loaded(ctx)) {
-        return false;
-    }
+    g_assert(!ebpf_rss_is_loaded(ctx));
 
     rss_bpf_ctx = rss_bpf__open();
     if (rss_bpf_ctx == NULL) {
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3b85560f6f4..f5d93eb4005 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1363,9 +1363,7 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
         return virtio_net_load_ebpf_fds(n, errp);
     }
 
-    ebpf_rss_load(&n->ebpf_rss, &err);
-    /* Beware, ebpf_rss_load() can return false with @err unset */
-    if (err) {
+    if (!ebpf_rss_load(&n->ebpf_rss, &err)) {
         warn_report_err(err);
     }
     return true;
-- 
2.51.0


