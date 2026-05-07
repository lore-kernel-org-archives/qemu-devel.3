Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D858CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPv-0006f0-5F; Wed, 06 May 2026 22:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPs-0006aT-Gb
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:44 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPq-0007gv-U0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:44 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-679f6ee3fb0so139035eaf.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120681; x=1778725481;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WC0vAoB2JrxhCnH6uJJk5wBT6sf05K3174sq655JkzM=;
 b=Y/5Gwk/rLWcJ8QYg+rbxVePXDOR8C28tqSRuh1KjMfUNd+iIexI3Bb3MG4kXeHrWLk
 I20PT9OaWVd4GF951GBFTDMXseQ/tn8V1oj4BsNSV8srnH6VQ5XPXG05B7qc1GNxkKPu
 sxyaWun7rRP5440E/EX5xF2EZ6+tTluG7KcEQC1z6jF1hFKcIjlpJSZhpXlK0uGcymY7
 jWZcgMvL90o4rjuPjcCri8KUScR+749x9gx9Lw8ifjPamE94tkjFUhmViysFDc3OP5S/
 GEi4oGGAPN5SB/0JAVP20nhVAbDmch+BjtF0UvGfSCZzfdmujWR86u3ta0FcOz/wPvCQ
 Ormg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120681; x=1778725481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WC0vAoB2JrxhCnH6uJJk5wBT6sf05K3174sq655JkzM=;
 b=SOKePVspwlLq0QuDN+EgOT/Wfr8Bv9v03pcflTDOQ4KoUXuXVnGxA/1drtgk5KGYqe
 PjXgqcvmlyC1Np4qGeMgdvt2YxTVWiVnKukUZFk2MrR34O5i6uv+bwAk2YFyFH5BXVc+
 LDtdOxJ9drNdtgxDkxKvcQevBCWgyXKx5SgcXwZK4VWvKU1qeVfEfu1SzNKLYGpaZZRC
 IYcFST0iNekbFUub96N9ZMYzDQuZUg+adlsXubk66aeWPtTJ88lGDHF3W+k88KlxZ0LH
 E7+nzpRFGK2lNzG+sbTdthRDVDllQqUcpxL7ksewCAtXZTgzWLeL9yIFRQe9rt/CIA7A
 Ct8Q==
X-Gm-Message-State: AOJu0YxQdrI143PTX3BB2Lu6RUBYkSa+U43v+zBbamk5ksW7lPzg2QIu
 oR7qdSvXNk9P5N9RwBLq8Hl0Z35Jb8mLvwFIsfHyg+aKYRgt98vKLe+UMC3WuLd7SnXazV3MiCQ
 BLVo82Bk=
X-Gm-Gg: AeBDievvfi/RVNDAbD7j1ddHDVClQIuJPFacbhmfatHUUdNm5fVzpFScRXr5tiS5QBP
 S93ZfwFI/KAFgMIP+t93CC8G9WU8vRo/tBGL1p5MXlfGyFG15qwfdz02hGvWCDYnCZ4zj37pgXw
 QfZ7b65IRnpyIHsfIPR2/tdE0XsdRAzroi+rbCJqL2IL7lO9JO2006YAsFn1gqfcyePKWxlWulZ
 azfpk/gpL03JMJ+n6tSgju5D7XozO0SEpzDznr8muQOFNEZlHXUQhJoKx+oPkzYcpzsLHluVTRM
 2OvFO1jKG3POznJ4aOaSWYq8radu0hegrvQgpsOdTQKAERsriGJCB00ro6BO6UG1EFYfcClVoJ2
 lsnp6hf5B5M+keaduWv9u1z7MDHZv8aEGLePsgqitEAvAJTwFhM4DACiK3DbVusPYfT63C4hHl3
 E6l+jWL2bFLd/+y6y8NKBG
X-Received: by 2002:a05:6820:190e:b0:67e:251a:bd3e with SMTP id
 006d021491bc7-69998cc5fcemr3328267eaf.18.1778120681567; 
 Wed, 06 May 2026 19:24:41 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:40 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 19/25] bsd-user: Add log_unsupported_ioctl function
Date: Wed,  6 May 2026 20:22:13 -0600
Message-ID: <20260507022219.44171-20-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Add helper function to log detailed information about unsupported
ioctl commands, including direction, group, and parameter length.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-ioctl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bsd-user/bsd-ioctl.c b/bsd-user/bsd-ioctl.c
index 94110d4ad5..2d84adce71 100644
--- a/bsd-user/bsd-ioctl.c
+++ b/bsd-user/bsd-ioctl.c
@@ -217,3 +217,27 @@ static IOCTLEntry ioctl_entries[] = {
 #include "os-ioctl-cmds.h"
     { 0, 0 },
 };
+
+static void log_unsupported_ioctl(unsigned long cmd)
+{
+    gemu_log("cmd=0x%08lx dir=", cmd);
+    switch (cmd & IOC_DIRMASK) {
+    case IOC_VOID:
+        gemu_log("VOID ");
+        break;
+    case IOC_OUT:
+        gemu_log("OUT ");
+        break;
+    case IOC_IN:
+        gemu_log("IN  ");
+        break;
+    case IOC_INOUT:
+        gemu_log("INOUT");
+        break;
+    default:
+        gemu_log("%01lx ???", (cmd & IOC_DIRMASK) >> 29);
+        break;
+    }
+    gemu_log(" '%c' %3d %lu\n", (char)IOCGROUP(cmd), (int)(cmd & 0xff),
+             IOCPARM_LEN(cmd));
+}
-- 
2.52.0


