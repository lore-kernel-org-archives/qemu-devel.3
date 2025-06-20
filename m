Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18FBC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfJK-0000Ns-QW; Fri, 20 Jun 2025 13:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJI-0000NF-CH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfJG-00048z-MX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:13:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so15071035e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439629; x=1751044429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWjItNWUmR5RGSyqchV2FSRpv7OZ5HV3ahAIHsZwTNE=;
 b=H6uiiVu0cCngSlFx6bMJ6S9jlj4ReY8uXKrokkHn9edk7zrEZ9zLBzAHNtv3gMhkWZ
 6rjw74DHTsnrG4AEm3soiUWgrd+qvUnGyqJcO2AbNY0E6+fLGe7bp4txzXEzeyBoEEbQ
 PtdiTO9PsVyrnWAqKLkBunCe8KzQ+qUwimXBBTaBCewQNTIGfIJMchynNkdpCN9lNVPl
 e7PHWBjl9OfmDloWYt4OQ0O/UwTLlg/mVzUdsJBAbAUlGcq59SfbEa0waKpzX+CG0jUb
 TkTv6GZqdhzbzuIs5YKVex8qLKYiwDP8l6XEQid3uldrwKdi/LwSJoCcdk4BxivU5jfe
 N5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439629; x=1751044429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWjItNWUmR5RGSyqchV2FSRpv7OZ5HV3ahAIHsZwTNE=;
 b=ofUOHTfvegksVfU9xbaq98ytcy53Jm5HG8zJ/QDFKqdRp2geqz+OaeCQpVHDlEJ04i
 u9ejZzqNrjaOC3L9p515ujl04weZpch5yVey0j9xMJLhXtzoNdU+8o1R6zCvcHYGcItg
 YvMI9xGNM3EP63MIZR6K+CbmxMtqAzuYt9gVFzY18s57xffKrip7QXaaE3RfEPNBUI3J
 RSUk1a8TO2OXX9UurT8VAyLkoc4ar2U7AIDwEc7jbeF2kq+gRbbzz/1KIAWdcMu89Vm0
 p2bbtauYVV0aHp586pO+WZoTkjRk//cUAyiB4+9qLwXtrHCmLrKStHBpFQkL9K/3iFV3
 ZPWg==
X-Gm-Message-State: AOJu0YzdNtpBr4WdnA34wBnMnKqk9I24wyKWi2XCgHQdhnY4iRfCkwF2
 xzB4W+X7JfSo76cI5dYQ8m4eKuXmZW2e2dPLS5xeTVp5XEZaTNDx4DHgKmC1yyHBAXO5Bbee5iw
 3MuOpv5Q=
X-Gm-Gg: ASbGncvwEPupcCET1bNr/su0LCQZEroNYLNUMnnOWyrzIuotc+2EAgfRvDv0+RH/Pxx
 8Ntv5pRC+szFKOCCQe5el67BZO4F5Z3S+LISvyo8ZGqB0/I0raDx7TgC0t2DORKyFNWJxdAbzCh
 nxr2PE6g3O5zo7kOe6aC58ir/petOzR6OAjhSev8plMWPbES6rv2kFqHLy+vwdR3BfrmkQIfWlM
 WxYMf5P2Nzw17UCE/KDgYDdLIZXcoJPCDjF73NX+V4GquUowGJJksEinxhFP18utTN/AcjpKWfC
 6nnhbcOgvzZrRSJ+exOz+JSJ5sm7MZNA5LP+qgvQb110YPj7g9cWm/IAOIFBtX5dPDK09T5jHM+
 +y/Vaac7oR/wEuEJoc+M/ce5FHFayy4oYr9sz
X-Google-Smtp-Source: AGHT+IEIaDC2UuVPruwF8/5erDvozr/H080GNw8uV3/Dtl+VXrelhfbqcK/qAj9S0ilpK/c+p/lLsw==
X-Received: by 2002:a05:600c:871b:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-453659d0a9bmr40538055e9.15.1750439628807; 
 Fri, 20 Jun 2025 10:13:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1190d13sm2565934f8f.90.2025.06.20.10.13.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 01/48] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Fri, 20 Jun 2025 19:12:54 +0200
Message-ID: <20250620171342.92678-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/runstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a5172..b6e8d6beab7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,16 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+/**
+ * qemu_add_vm_change_state_handler:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-- 
2.49.0


