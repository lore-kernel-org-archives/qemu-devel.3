Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B743CD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc0gN-0004ak-69; Tue, 23 Jun 2026 08:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wc0gI-0004Zm-1Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:56:46 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yisooan.dev@gmail.com>)
 id 1wc0gG-0008WN-47
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 08:56:45 -0400
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2c6d3851e09so28458595ad.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 05:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782219402; x=1782824202;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6swxASzh/shRJLEp7Pk/oVO3/j140Xn0WoM0mhZf7Uc=;
 b=TSzCCQyjuJhTvVeMC38EPgwEBkxVVQKU4HyupM7ZB2mgqdc+aOafklfWBMtoo7WjVo
 yl9dvi2LKviGiiyu6vXVpDNPpuntq55SSrPjBDFTAUH8osLe5G+ZdVDBHK71GWUDd/xN
 588SXLC0PeyDn7r0QMOeD09OE/EAQuUeePY8l2dtO1pGZpho0zAdgOiSmBb71gBmDYRc
 ITDKdjtweOC7I7yQ1rTicCOItsDF0LPKupOm33T3157WP2onWzH3uAJGLtSoYp9AdF3i
 Fu+o+wAo1IlqWuaHHH6Nu1PBjK4oWn7qTsvWpnDlppNleKkFF8lj83CtZNxhSvZoJmV/
 hZUw==
X-Gm-Message-State: AOJu0Yw9O+9q2Ip4KRxigg2dYJHRkLemojce4AzHs7pqBAKuBDXk/lbK
 J5THK+TGIcKa8LWXnFa0KnOD8uMbcccSVGnPKCyOwDCZuaA1ezUJ5wwu
X-Gm-Gg: AfdE7cl+9z97zdxRfruzp115quI4AtSDyeVynRwcQ5tdrY3OBxf7CJc1usIV+kXfXr8
 2e7hLAt06VgA8hMz9++nkuwLNR51+FsweGxnprijszAVA7buS/HRT0peJbp6SFkr62L0waI3aKg
 Lt3/yVrcN12MN0FFWQYXY2tLOCkorOF8ITPUa7MPloP1P3o3jSyHNDyO4tbfZ+gVvkkKs628xAx
 4e92UY7YvcB8UjDulPnzET+8k5fAMrpzNfX7He87eTenhirS+bpX6jrBsNQzPP/mNknVQIK7eAq
 u1g1gOvWuPITEmYAf3mGhFFKgXI0eSNFRP74dvBhDYgJv1xZHTDBGH/tb+DKInuEfCpca7y0ABk
 hDkehCziQIPpeixmvYZ9UHLITzgNXgrC7YVit/BqThlwnCV1hFpv8PLNQGLbylSox08jNzqmV0o
 VUcRvuHsofIz3LVq0EZT5U0rLLOPvXVGQhf4PWDUF10GQNkRpuVejX9qV8ELBSQidN0VuzAnYmo
 F959NMg5bzc+YuW+1+Oirl2DxfX6Zk=
X-Received: by 2002:a17:903:46c7:b0:2c6:b87c:e5a3 with SMTP id
 d9443c01a7336-2c718ed74e6mr194294015ad.15.1782219402494; 
 Tue, 23 Jun 2026 05:56:42 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([1.213.237.162]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436af310sm110579705ad.2.2026.06.23.05.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 05:56:41 -0700 (PDT)
From: Leesoo Ahn <lsahn@ooseel.net>
Date: Tue, 23 Jun 2026 21:56:35 +0900
Subject: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDQAyF4VeRrBvQKAP2VUoXc4kaKVOZOKUgv
 rujLj84599AOQkrPKsNEv9E5RsLmkcFfrJxZJRQDFSTqQ21OGbWFRcbxWOOZRI+jF1PTSBrTT8
 4KNcl8SD/K/t639bsZvbr2YJ9PwAFGjwMeAAAAA==
X-Change-ID: 20260623-guest-panic-unhandle-4921d2aa69fb
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Leesoo Ahn <lsahn@ooseel.net>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=209.85.214.171;
 envelope-from=yisooan.dev@gmail.com; helo=mail-pl1-f171.google.com
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It's worth cleaning up all resources that the guest taking and to quit
if an exception in el1 could not be resolved.

Otherwise, the guest will get in the infinite black-hole by
unmodified pc.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8b902c6882..4358cf90e8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         cpu_synchronize_state(cpu);
         trace_hvf_exit(syndrome, ec, env->pc);
         error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
+        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
     }
 
     /* flush any changed cpu state back to HVF */

---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260623-guest-panic-unhandle-4921d2aa69fb

Best regards,
--  
Leesoo Ahn <lsahn@ooseel.net>


