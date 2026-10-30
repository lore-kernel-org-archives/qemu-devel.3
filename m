Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A03606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZpGgcVCa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkg4-0001OV-3a; Fri, 30 Oct 2026 07:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfz-0001Mr-UA
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfy-0002lz-9f
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so584814f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359296; x=1793964096; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CtFQfS3ZPQMOHEPZqYufRtBAPULATHXGwg5wUHbxOvE=;
 b=ZpGgcVCaQv35s2rtRailCdSaz2g7IinJ7HZFfdg2QIwm6AHiPvXBV/kfl+Qeo6VA2h
 RZ05d7znfV0Kkx4S/nTCOPOiG7p2oRkwqVkinF1uU/e9Vc27jsWnglaPnym0es+nwMQF
 8HOzCMkn7eIYIcTWkHrYEadLxYRyvOySck+08X0dxEjAedoft7qU/NtrlB57XgWCWOhS
 JEKFMzynXg0PwOuZcougLsaLTwIuv4G/xplCjFeaGrCezYAysOGqh03X0Fu965uDz1IX
 4i3kGIhmxsdtcpdpCpvJG0Jy9u8uIiUHOptCkhnPGgOsEHZLhrJvxScPikCIsGBTKCx8
 5xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359296; x=1793964096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CtFQfS3ZPQMOHEPZqYufRtBAPULATHXGwg5wUHbxOvE=;
 b=NRuhAD3HdCkLx6/CIZ2gponVMFnahia7Oy2fAy021uZWmM9DWR4ZFSfRHxmlJQUPS3
 6Mtjbdhxwwv6UPpcNY7gz0ojsil1eq1A+Pgr4vdjrLHhbBLqHdQdeiYFjOMv4vBxpfR7
 nKRBUbeJKgLvKFFkFeLB2mLBv1kCxfU8n1gk5psGE2lyGcrvFg5Jqkg4tItstl5wzMsO
 R0DisUaI2ahqtR5XXZUShzlmzVxZhAtG/Y+9/MWwtPoWjtMFuwcU3iFZOI3cbqkiWf9g
 V4uaw39lvdboo6lRq3ke2E3240TPK0ZNoBgbZONGb+elO3pCjHwZO87awAFogrGXIOwa
 K6cg==
X-Gm-Message-State: AFq9FYKIwq8GfITMXCnJf2zLLavqzh/amUIeJP5W47bLF6Qqu61aKhOo
 WrkNvWHTAuVj9awG0afNVn91SFhlAwuPHRKXvF7er00AS+HxM9UYa4fD
X-Gm-Gg: AYBFou1n/7c47i70TFbjwr19jmaNMk6xga69RVbTYndCFw/T+W5JzUIDaU5guG5Mu9u
 Q3SqmyOnfwF3z3I8bpmgtsT1sfQLZbkcPd+fbq5T+7rV+Wo4uwqjCxgfd7sR0o6ByiDf3lBlxcA
 6MiKf1rkkSkiAjsTaNWN4vO6hkMXjd0fqK3851nBoOlycXPaIi8+6mnykXG4nK+BhlsX8nkchI7
 FSNcMCwRwTwc5g22dX/pMhw7KyhMzrdd4rFg0B08OIAtCZZaxR9EdWwkAj+6WQArJAkE99y3GNK
 nu6QlGH6cX/xg4JLwWYhUj8iu/fSQ1wUncRloOpX+8PJ6socshc9oxlFOsc1JyN19/QdyhE0p/K
 wAihXLgm3siOWhsmcQm2Qnk3Ob5FP+4k4JkDg9iob4NU6NLd6VJ9i6Xw0gv5PbJATcNpGoUInZj
 cdA1M/cZryqOwfj5G7STuU2gjMJ+dvj4HAp5cb0Rv51KKo3EWxOBbvdKicUYMydsPWCN4eKAndb
 Utj1XKSZ+28rdwNuWKVSxlJTEPrZREQlderiIg1omcIIcjf/yV3aHlnbMQvsTCcm4ilBo6rKoVX
 ZcHZFSYNamzH63ZxpmL9B9VyM77l5g2cM/T7bkZ79Sr0zNhcGq1sVVccMbjkfzLiBxj81GK8XA2
 cjqlB0rhBhTMcFUaVYgHDBJK29PP2CINPNNQOMZs7+klWcMgiynmM4uTzItZrkw==
X-Received: by 2002:a05:6000:200e:b0:48c:466e:9d08 with SMTP id
 ffacd0b85a97d-48e6e50ab18mr4700925f8f.43.1793359296428; 
 Fri, 30 Oct 2026 04:21:36 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:35 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:58 +0100
Subject: [PATCH v2 5/9] util/oslib-posix: implement qemu_set_blocking()
 with fcntl()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-5-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qemu_set_blocking() relies on g_unix_set_fd_nonblocking(), which always
issues fcntl(F_SETFL) even if O_NONBLOCK already has the requested
value.  macOS rejects F_SETFL on POSIX shared memory descriptors.  The
socket channel treats this like a read error and disconnects.  Those
descriptors are passed in blocking mode anyway, so there is nothing to
change on them.  Query the flags with F_GETFL first and only issue
F_SETFL when O_NONBLOCK is actually set.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 util/oslib-posix.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index dc001da66d..3d5bb16ca6 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -252,17 +252,29 @@ void qemu_anon_ram_free(void *ptr, size_t size)
 
 bool qemu_set_blocking(int fd, bool block, Error **errp)
 {
-    g_autoptr(GError) err = NULL;
+    int flags, new_flags;
 
-    if (!g_unix_set_fd_nonblocking(fd, !block, &err)) {
-        error_setg_errno(errp, errno,
-                         "Can't set file descriptor %d %s: %s", fd,
-                         block ? "blocking" : "non-blocking",
-                         err->message);
-        return false;
+    flags = fcntl(fd, F_GETFL);
+    if (flags < 0) {
+        goto fail;
+    }
+
+    if (block) {
+        new_flags = flags & ~O_NONBLOCK;
+    } else {
+        new_flags = flags | O_NONBLOCK;
+    }
+
+    if (new_flags != flags && fcntl(fd, F_SETFL, new_flags) < 0) {
+        goto fail;
     }
 
     return true;
+
+fail:
+    error_setg_errno(errp, errno, "Can't set file descriptor %d %s", fd,
+                     block ? "blocking" : "non-blocking");
+    return false;
 }
 
 int socket_set_fast_reuse(int fd)

-- 
2.55.0


