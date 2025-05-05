Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1434AC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC579-0006OM-L5; Mon, 05 May 2025 19:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC576-0006MC-LD
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:44 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC572-0003at-2G
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so6479999a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487238; x=1747092038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=gbTn+ZqF9MNXclnirmYMS4uadVtQf+R9QLFmZwFGjRNxwOwZ9+lbkqNlv6QxQsv56y
 srMVwTsNvGYwXgG5sT9gzX+cbqVTTzplptdV0vZpYQwLoEKJ2CTBTMQyHKgDAhenmgnf
 F1qXJwpt3qgIfwecn6ns8fhNMrK300kyYKth2ap3WNz/U83BQ7Ja5y31drdP+7TmEN05
 BXo+EkamG/umt+jHHUOobk/K/l0hqgsJoW+0mJ4iPXDzmM7J6zBnVfu4E+UxO6lOZpX3
 KTjNPpx+uQqWcZnHTWAwGknoHi7YkjH5TGTxLRJm5Sore74Ak5N5zbFRpYsgj4/FnKwA
 T1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487238; x=1747092038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/RowU+G9lDkd5OLEKmfnzuDeOXrVzkwWk098+SYGJQ=;
 b=OxJGIK0BUQ5nwXvIdd+icGHw6/m5gAQJAR+1EWrOfn0Oq810c1kLec5nzvTA+nYEea
 LAGdp+QqIU8PqT1YtgYOWcYHcBdFOxIWz1u/oiBGZ7ZkQDoSrMhhebkdj+RalDEU0RE3
 fgOHipCgwitJxaMOx73/4GZ8XUtrjZU4ABJLoADYukC6a8dAXU+8DbfhbYUPEPQJ8q93
 5GaK963/97uF6UwWdMNPOBjykWvE2rhr5oOKYFb1DPjvzzoobiZO6bsRXb4LOplEqEyi
 gdTd8g2K+8dP5bAiJq2gspxpOb+IYz5BxWUIYSe7qVMy76E9CKPedsOFiclUkcXqfeI3
 P69g==
X-Gm-Message-State: AOJu0YwzED9h4Hxx/mp/20VIx2kild4hf1q2fmABvvRbEkIN5+d5EFWh
 gm/HOzIdigglxf0W3IyV5102NeJuao7e7tl23PCYBKe01MhA2Ckyk9PfvnhTlJjUMu0xvPpeJGR
 bpRY=
X-Gm-Gg: ASbGncto59Ar0SFKJa9q5Vl7+ZRkQD6FYdWLl9bZ3r+woEwG7WY31OoQmsKPdBzFs/v
 wafNx7/7ma/Tmb+BcRNr2gab1Q1EHJIZSbRd0w1n/l0O7NfKW3t4IONldq+fPmnjNV2PxTCmp0Z
 6t5nScofQ4PXVTopUaxcPkAI3zZ5hnMxeQOFQeA0PTav+UTmz+jPTO8shH2DEYtuXpE2m95FIjV
 zu4/34nxj6oGhYTZp26IT9d49ksgFjp0isQ36kwkcbzOUhasNHl14+E7tm/yXhULYkOQloPM6B+
 kuIlKzkOS/i9bAE101/XpJiklipabbm5a0LuEjPk4td9rPbfNYk=
X-Google-Smtp-Source: AGHT+IH20d9iUdXCOHxwG6SI6Sy5JpqtCCPeA+IenO/oPeRx9XNel85Y0hwvj9DAfrOx6h8FyTp6MQ==
X-Received: by 2002:a17:90b:584b:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-30a800a14dcmr824679a91.32.1746487238401; 
 Mon, 05 May 2025 16:20:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 20/50] target/arm/debug_helper: compile file twice (user,
 system)
Date: Mon,  5 May 2025 16:19:45 -0700
Message-ID: <20250505232015.130990-21-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index de214fe5d56..48a6bf59353 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -1,7 +1,6 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_ss.add(files(
-  'debug_helper.c',
   'gdbstub.c',
   'helper.c',
   'vfp_fpscr.c',
@@ -29,11 +28,18 @@ arm_system_ss.add(files(
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
+  'cpu32-stubs.c',
+))
+arm_user_ss.add(files(
+  'debug_helper.c',
+))
 
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(files(
+  'debug_helper.c',
+))
 
 subdir('hvf')
 
-- 
2.47.2


