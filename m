Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B3CCEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQz3-0003sg-8F; Tue, 18 Nov 2025 14:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyh-0003RG-71
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:03:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQyf-00069W-Fk
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477770019e4so62382535e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492575; x=1764097375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I5qCoWr7FI/cVd08v4vpwzDG2Q6hw19wH2p+V9v+2xU=;
 b=OiCJhpAX1Ko6lM00GWG104eArKIqtcbfXM0WAvc7A0iGgd07955fstY2+JajyhOADn
 RnEVpy1w4dVQYi06p2CXaGhgnfRqxmBQwDnMnvOzeW7X5ZREZvjd6op7Zk7YUOT5UycZ
 iwgmwJ2oTWVBXEBYkTJWqoWfZXLizaaWzEc8d9qvdV0WzO3ayk8ZJxM9bCM3XI8/El8K
 5AhTBdVp/SaQ636W70mKluY3SMSJzll1B+FuMy1ASPW2JPQZJiCKTEkkv3AfQ0NCfKMA
 CBv9rpvVe7901QmTdA0Boy1DYQ2XNed20fN/UmPRSoS2pQaZb2iPM1WQxtybxCLryOVI
 dp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492575; x=1764097375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I5qCoWr7FI/cVd08v4vpwzDG2Q6hw19wH2p+V9v+2xU=;
 b=h84KF5yjUaNbw5vxLzVbfJe2+DUeSSnLQwl/4aIPDBRrar45QRYBxWEjLIRJ9y/D/8
 vG2k56gChGcwtDuE5844hzN336VXrTUH71VFuCG8qnRiDuRavmp0dyJ90WhB1B5PI7i5
 tvnXqcsrW/QgC6EKf6sAJfau4wLEXcz4uPWssv/uWYkyB+bp3JGz3iVCUwgdiC+zL3sX
 Rt3CLNE/lWKdeJlhEqMYcB+OX7E88Y3Pe/uK5Us5nCgTCTVYLVLFpvH+fGoFSFNSjCgk
 5NfAQe44c+QaE4lekOXNKP1AS5piI6QhWjDfKAfHj0DeEOfxrhYUpw/P3GS1NEAWosCr
 EWPA==
X-Gm-Message-State: AOJu0Yw1MhErJgMyo6HqudRrAHG5QAe9j+2yyAXBPKWVEXl2MbWhmKAK
 PsbjPKFsBZ9M6liePGpn9DgmIoHcNKI3bc8+GRm6/e2Fgn02HBomuXGUCDYIcAny6MbnnG+JQ3R
 UNL8lF/pI2Q==
X-Gm-Gg: ASbGnctonD5HeCprK5I/T3yNL1f9x9fMwU4BsrEOoj+BsBK4g787W/2okOknDhIZcqd
 EUQi1bCijPnsXegD2AcbkZTEH/oEC8LlsWcP2/z/S1jY778guPgvPOJaxFDHydlx+WVEI0bIx8S
 UutmlyF+HFBn2NfJekPREWiAb74rAWHOPCuxAoEs3VIBt5ULWYzDhF7C/0YbeNqmx+BkkX9G2uL
 E0zzplnl+1al1lVoYe9ZtwfIRV13hqg12j3vqoUIEQfyzSm524cxV0CCtUb/li+jBl3KAJmuhzh
 Lq8P5lVcazc6Ox2yFNAJ4aCetCYM2Zcr7M+oSMVl1F72HLbjMD118rIJCrVhX2nD7i4zKBQynIv
 zVRSv/3YwmuV6d7cx/UQfhzjvDI4fJnQdpP+2lCVikOQ4JGFP1eidscCxu4zxmOwcKbiSLTCbOa
 GxVwDHi3TMxsjItyR9bFMJQZEXEABkk2L8Yyj4Mj3sG8uULosmcp/Pw1RRVS/blA6XpZz1KwLI2
 8TaxcmuCw==
X-Google-Smtp-Source: AGHT+IGybPjcgI1apLrf657Vds3uivmjeqYq6FjRfyheTFAM24+Z/Z1YVl44IWD9CH9c896dTjY+SA==
X-Received: by 2002:a05:600c:12d2:b0:477:9cdb:e32e with SMTP id
 5b1f17b1804b1-4779cdbe632mr70607795e9.9.1763492574919; 
 Tue, 18 Nov 2025 11:02:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b102bc9csm5254775e9.8.2025.11.18.11.02.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] ebpf: Fix stubs to set an error when they return failure
Date: Tue, 18 Nov 2025 20:00:51 +0100
Message-ID: <20251118190053.39015-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Stubs in ebpf_rss-stub.c return false for failure without setting an
Error.  This is wrong.  Callers may assume that the functions set an
error when they fail, and crash when they try to examine or report the
error.  Callers may also check the error instead of the return value,
and misinterpret the failure as success.

ebpf_rss_load() and ebpf_rss_load() are reachable via
virtio_net_load_ebpf().  Fix them to set an error.

ebpf_rss_set_all() is unreachable: it can only be called when the
context has an eBPF program loaded, which is impossible with eBPF
support compiled out.  Call abort() there to make that clear, and to
get rid of the latent bug.

Fixes: 00b69f1d867d (ebpf: add formal error reporting to all APIs)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251118154718.3969982-2-armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ebpf/ebpf_rss-stub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
index d0e7f99fb91..11729f3d8fb 100644
--- a/ebpf/ebpf_rss-stub.c
+++ b/ebpf/ebpf_rss-stub.c
@@ -25,6 +25,7 @@ bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
 
 bool ebpf_rss_load(struct EBPFRSSContext *ctx, Error **errp)
 {
+    error_setg(errp, "eBPF support is not compiled in");
     return false;
 }
 
@@ -32,6 +33,7 @@ bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
                        int config_fd, int toeplitz_fd, int table_fd,
                        Error **errp)
 {
+    error_setg(errp, "eBPF support is not compiled in");
     return false;
 }
 
@@ -39,7 +41,7 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
                       uint16_t *indirections_table, uint8_t *toeplitz_key,
                       Error **errp)
 {
-    return false;
+    abort();
 }
 
 void ebpf_rss_unload(struct EBPFRSSContext *ctx)
-- 
2.51.0


