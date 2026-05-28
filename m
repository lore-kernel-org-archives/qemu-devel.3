Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20044CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShGc-0005qY-P5; Thu, 28 May 2026 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGa-0005kT-N6
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShGY-0004Zx-P7
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:23:44 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so37952365e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999821; x=1780604621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p7DL96LSJtlIoyK7GQFgBb7BnRiqaj6Fnaw6PBa+730=;
 b=XDtLkW1kyOcypyNxazmMUXYu6crQcFFSSSZ8KlOuuslkQysdLhzYah6jCL7WGO7i3T
 76FR2SB0gL6nc/ZZkROWs+732ydUKLPhQJF3aiCkN0AQXc1TYincipbTa33tevLtyAE5
 w2gvpzc+X9h67APBWZXp1I6CfZ+FuSbp6SnD0Vi+gsVWMa3HfR5Y02mG2K7OznBBDuYL
 ZzRRCNY2iyc36mxbtAAYDki4+QWBZ6BizkSKWdQvKICENRfvIaPauMp0gaqpy0WxWK9I
 7dp92qXWpTblG6XPL+88saMdyjA2+0IaXmQmTu3UzeTOkUs1xPKaWPQ+LytJgIksNVqK
 7/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999821; x=1780604621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p7DL96LSJtlIoyK7GQFgBb7BnRiqaj6Fnaw6PBa+730=;
 b=MDbrDA/jfxkLqljqA278XNHA6p+BQunTRLUJUDDKlOz0rJVTT2RVRLJf8g9rYco/Vg
 wJi3xwYeJq+ZU8vA0n6CczBvSThlhvyw7n/f4y0y71SI6IglwHYRn8gsCOi6+M+kGbvp
 Vs6d8XRNwp6/SzxNJsEaXFRmkKIaWfgmcMQszODuLkdmAFDdtuziXkUNl6xop/wpIqtC
 A+6WlJ0rUE3gKtmj/XQ7G465uDUjZiz6T9PFS2iRJWAp23HYOOK37KUzHIQfXf4s88e4
 YtPJONkvsbajRIdCjYRZe7DDJa3Swwe3fj2b004qbqod8JLDeCeasE5oFImYAuHuOuZ9
 Udsw==
X-Gm-Message-State: AOJu0YzoufWgQA82qgwNmEayQhQNmALu5k6lsNjnfoRNfapP2eZvirTh
 Z5UPQCGekZPGCvkUm7+MZ1RaTL2v4XdZfQyZ8vPH6LIcOI+wPSWHN9i3rTMY8pGkSQHN9C9qMdL
 koNPMsY+BZw==
X-Gm-Gg: Acq92OGvWD0jSuFJTrS9cJkrH0bY5aqbbMEhKp9OfW+rKx2LM5zIAmhBa4R5LYoMHHf
 noPCTfEvct3aLXJ0YI4LyeXBVAxnm5rmDPhFvxmruDkAef0PesvVyqYmitGn9nRWyU4yH8FWbUj
 /R1I6dV5J91PHdRUYFKYY3oXF07ZPY/XIfa/XjbgxXqTNAjYYeiGiIuQVy3+GXfPFD4F3oiJ+me
 cH8R1aJ55ZuzGL5JXugthrsKC8rRvgF0DXCsRqNT1WzgUdCSxkc9eNYZSDbMX21Kw/9kl8a+FpS
 LJ3BXHCI+9yLoEHm7/+1da3iQweftM8kgSiJmFf6Kt6fpyeZrimMjvLhYIA41ZwEpNgE+GjBf+S
 2jIX16l3cv8TQ0tSKpfsEBJWOCl5/KYmh1z2wM2EupZgwwk1arvBgBAUhz4YnJ1/kzaUKIIXLxL
 mS+zRrjeCCHz7Eqda5gAw8xatIpgM4otpxqkjQk8MCJ73FrgJ4Lbdx93GPiXxkqh0QZw==
X-Received: by 2002:a05:600c:a55:b0:490:6869:46c3 with SMTP id
 5b1f17b1804b1-4909c0cfa37mr392865e9.30.1779999821050; 
 Thu, 28 May 2026 13:23:41 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909bb8fd33sm1683575e9.9.2026.05.28.13.23.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:23:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/22] system/vl: Free allocate memory for pid file name in
 case realpath() failed
Date: Thu, 28 May 2026 22:22:36 +0200
Message-ID: <20260528202253.49122-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Thomas Huth <thuth@redhat.com>

In case realpath() fails, the code returns early in the function
qemu_maybe_daemonize(), without freeing the allocated memory. Add
a g_free() here to fix it.
And while we're at it, also free the memory in the qemu_unlink_pidfile()
function - it's not that important since QEMU is going to terminate anyway,
but some malloc sanitizers might still complain if we don't free it.

Fixes: dee2a4d4d2f ("vl: defuse PID file path resolve error")
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260518114514.684401-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index da36b2c6e18..dbdd4f22572 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1634,6 +1634,8 @@ static void qemu_unlink_pidfile(Notifier *n, void *data)
 
     upn = DO_UPCAST(struct UnlinkPidfileNotifier, notifier, n);
     unlink(upn->pid_file_realpath);
+    g_free(upn->pid_file_realpath);
+    upn->pid_file_realpath = NULL;
 }
 
 static const QEMUOption *lookup_opt(int argc, char **argv,
@@ -2672,6 +2674,7 @@ static void qemu_maybe_daemonize(const char *pid_file)
                 warn_report("not removing PID file on exit: cannot resolve PID "
                             "file path: %s: %s", pid_file, strerror(errno));
             }
+            g_free(pid_file_realpath);
             return;
         }
 
-- 
2.53.0


