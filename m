Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9460606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=samsara.com header.i=@samsara.com header.a=rsa-sha256 header.s=google header.b=Znj30zMP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT2lA-0005u8-Ix; Mon, 16 Nov 2026 14:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xT2l9-0005tz-2H
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:52:59 -0500
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xT2l6-0001pU-AR
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 14:52:58 -0500
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3282db206d3so10754627eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 11:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=samsara.com; s=google; t=1794858773; x=1795463573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C/9E2J4Yex5wXvuNGm2rLRIf+6hY4TVMoCWe9lYn/Rw=;
 b=Znj30zMPKeAA7K/ZVz2ZFXYzEJvD39IZKT3lOeL0e+u/chUU9728LNnOWK/j4B+0x5
 tofGNm1gF+61rcYFMJdxZ8lCC1msW9QHQq2/ZgaHNXWsYeEJRi5OIHkbBNejzr9HxTUL
 rOOYTrlBDfyZAoDSR22yBb78j/BJkHyQbMcrrPFH4TToT233uSizqcJIkzTC+EFg2DvS
 lWO91mcNZOEp2wK+ut2sjGs/AxAe5tmO0tKg8joi9xdmCvG2ZQS6iVemVvmHlnaCfYnO
 /S+2vD3pDQ9HjSJYEaKRvCZWXfl6t1FbBjLfQkOta8Tmjhdu9XFfOJgxRjFqfh9MAMKh
 Frfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794858773; x=1795463573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/9E2J4Yex5wXvuNGm2rLRIf+6hY4TVMoCWe9lYn/Rw=;
 b=HNYxk3se/bJsGO/au010pgsahZdBwfKOtH7X37xxemngnpC8InOcNOtHNiX4096osD
 Ym+t9ZswQPawXUIBZatXIi4UcB5pecspIPC8vVBaPpsdNG2qdGT6qdq5Lzp1zjmDiz6o
 2ryI8QN9kIPeZwFNf0bO+DNvmd45H0/IVvfjVRQHIMlPLzwv/Psu3jzrtZ7hUF/DWB0N
 fsaknRqxpAn/fqY9RLLTnjXu+D6N7vd1yMj5RJQATcNMgewD0chmYvTN2oUNCI0Jq1U6
 U7UfYrws+jnGVPnVFoisnOyYdpz0Xp+CFHY9QVGKA/Tk3khv/Q0lLuPHB4/0VWJNn3Fq
 ltuA==
X-Gm-Message-State: APuU4Z/tryjQCQ0GdQWfgONMfS4jI9k0qkiFJBUX4SYnd2qJNaR5Vn5I
 1FDc7OxQfx5YUPVkMBDI+nPqhqfaw7c514Ms7He79hdnRDjmXeGIJ8wldnGSeV0igNkN5EW3my6
 F0qyP1g==
X-Gm-Gg: AZFdTZeyKvy62ndFpSM08Ra7KcOgUjWz1/hZwR1/2rNoxkAxFfUSstBwg2a4KhdvBjl
 wERzwzZUxVr0PASDiFymbAkaA5MAkaUJn1HyXnyGK0DzjYJpkG1ohSveNaJHF7D9tKTMYk6+y8t
 T4jomxJ9QR+D97XPAmI6eNOFBtaH5nw4HIyopYqwhu4cPbL54SweU6Isvg4MIZGnXUwMYBo8l3D
 mrWc+wOhM8L6KTVZUdQutIGIU6SnE/lH63EJEjY7QC3l4XdqxkjWpjr6FF9/RSRg3QGZfAAraLP
 eeet+YseO389va0mHk7NqDQN1qmEoGRzbFOXM+6KE1+T9mvmtyOequswDPAjSUThdrfNLWntmFH
 TAv7lz4+vZUtohgOJP7juwJ9ov32h3VMtOVwZz3OTtl81urFJL8uLhWG826BZgDUN+b5YhtxnQM
 0/foTppI7ULrPi/F57pXzV7oYn5/oEmnS5RktjGiaeXNDSV1Fy89kTslxuZ8i2rwFMPyb8MctMh
 Z7zTqcL7Lu3qEsU4OCKy06JRRYpu905LNv/biTmMf4p+WWzWsBjZ25kJTtGq4rZs+yAmbnuFJxl
 23L9H7WjUu9Cx9+dZvP/hhfpDDhouUmUvFQANOV6wTP3YVk1PH/4oFsjDAbtBj2FFYtpJKyTqiR
 z21mpEvE=
X-Received: by 2002:a05:7300:d718:b0:36a:12c1:3adb with SMTP id
 5a478bee46e88-37966b52740mr17093257eec.20.1794858772764; 
 Mon, 16 Nov 2026 11:52:52 -0800 (PST)
Received: from Mac.attlocal.net ([136.226.78.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm44414767eec.27.2026.11.16.11.52.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 11:52:52 -0800 (PST)
From: Gavin Li <gavin.li@samsara.com>
To: qemu-devel@nongnu.org
Cc: Gavin Li <gavin.li@samsara.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2] net: add per-connection guestfwd unix support
Date: Mon, 16 Nov 2026 11:52:41 -0800
Message-ID: <20261116195241.41819-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=gavin.li@samsara.com; helo=mail-dy1-x1330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For -netdev user,guestfwd=..., add support for unix2: in addition to the
currently supported tcp: and cmd:. With unix2:, a new connection is
opened to the given unix socket per TCP connection to the target
address/port pair. The unix socket need not exist at qemu startup time.

This is an improvement over the current unix: support, which mixes all
guest connections onto a single host unix connection, and (by default)
requires the unix socket to be present at qemu startup time.

Also update the minimum libslirp version to 4.2.0 (released in 2020) as it
adds support for the slirp_add_unix() function.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
Changes in v2:
- rename unix-per-connection to unix2
- update commit message for references

 meson.build     | 2 +-
 net/slirp.c     | 6 ++++++
 qemu-options.hx | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7bcb581c1..6567ede5d9 100644
--- a/meson.build
+++ b/meson.build
@@ -1289,7 +1289,7 @@ endif
 slirp = not_found
 if not get_option('slirp').auto() or have_system
   slirp = dependency('slirp', required: get_option('slirp'),
-                     method: 'pkg-config')
+                     method: 'pkg-config', version: '>=4.2.0')
   # slirp < 4.7 is incompatible with CFI support in QEMU.  This is because
   # it passes function pointers within libslirp as callbacks for timers.
   # When using a system-wide shared libslirp, the type information for the
diff --git a/net/slirp.c b/net/slirp.c
index 451c0fd1ba..2886c0b22f 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
                        "forwarding rule '%s'", config_str);
             return -1;
         }
+    } else if (g_str_has_prefix(p, "unix2:")) {
+        if (slirp_add_unix(s->slirp, &p[6], &server, port) < 0) {
+            error_setg(errp, "Conflicting/invalid host:port in guest "
+                       "forwarding rule '%s'", config_str);
+            return -1;
+        }
     } else {
         Error *err = NULL;
         /*
diff --git a/qemu-options.hx b/qemu-options.hx
index 5fe9d73eaa..488a4e9828 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3553,6 +3553,15 @@ SRST
             # and connect the TCP stream to its stdin/stdout
             |qemu_system| -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
 
+    ``guestfwd=[tcp]:server:port-unix2:path``
+        With ``unix2:``, a new connection is opened to the given unix socket
+        per TCP connection made by the guest. The unix socket need not exist
+        at startup time.
+
+        .. parsed-literal::
+
+            |qemu_system| -nic user,guestfwd=tcp:10.0.2.100:1234-unix2:/tmp/socket
+
 ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
     Configure a host TAP network backend with ID id.
 

base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
-- 
2.55.0


