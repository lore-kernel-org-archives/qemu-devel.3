Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD03606A326
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2026 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=samsara.com header.i=@samsara.com header.a=rsa-sha256 header.s=google header.b=MAm304HE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPZab-0006CQ-MK; Sat, 07 Nov 2026 01:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xPYGG-0006HB-79
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 23:42:40 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gavin.li@samsara.com>)
 id 1xPYGE-0000vv-Fg
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 23:42:39 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-93efc0452b5so94505085a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 20:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=samsara.com; s=google; t=1794026555; x=1794631355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PwyoXqOAsoSQ5x1H3zCuaLDeyrc/+TuQRKSSjrjgrdI=;
 b=MAm304HERYpP3MgcpTNG4vNe9yFGdKUfwEuOf5VcsRzrVnIYva36+NJsD3232d+BwX
 uLqZfRQp4iFL2X2fZm/SjhbWQljN2f11qyEzv2uGyPmxM24S0LudxCsfZtOkbUn1ly44
 WHMDwG7h3FpPMKGhbTDhDGNS0ZMnfsbCACpwdIPT9C9cVT3D33f5U8CUXGsx0s4Tg0CS
 pWWHHZegGDtVH9hzoWx9T9tRejFUjCV6RLNJwYYiAmxnSznEfY51jniButgEEf3V48HG
 MxfBVQVmJos99LXKqazA6TqaaHsZoSPy3n8p4hF1tPjw/0YRRCZGteUp7hGXmW56uWhf
 PiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794026555; x=1794631355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PwyoXqOAsoSQ5x1H3zCuaLDeyrc/+TuQRKSSjrjgrdI=;
 b=XCuEeo4NtgaDfndN9kOI/B52qfX9ydt1hoA/akLPkT35emQRVb9OtYMSldn84+TPN1
 OqE8MYEUfSZJzoFKylD8G5hrEqkzsegxrLwlSKG0aElIJSLZmTG6hhR9gZZn+YuNpQA5
 KzPy8N9dQOqYEJ56IoRPESr2yYJ1s8M/zKvmFglbPgaX0+LMohk7OF2ylq7qr/IvainL
 0+28iagb8l8T0xxejLqu+iQvnMdk0lAikhlp1pGnwn2CtiKlooCyoUhQtMiOykn3Zzmp
 CNRlTxtYBpFRGmQuUQvzvkIDbN9RbaxfllMRBcdpqEcAk+vmpx0QUx+muaVCOSYq0aJ+
 Ekig==
X-Gm-Message-State: APuU4Z9Or5nYgmcj1lR3UgiQ/zXYnbRpZkamcadWFHdfX97WUVdB14YN
 GJgXiRbNlVWSs13czCMD98wWKUG79qV80JhootK7AxCvCUm2lVW6irFLjBAQHIdyiZMK7W/b3ob
 ljCHNJA==
X-Gm-Gg: AYBFou3via8wg9rfIauSWVKPq1ccBEPcoBZb+f8TmJCBSlJ4OmPrVuIO71NBm9T1vjp
 TQXNQzPKH154tGCjkwHFZVMmN6+YGERatS1P39ha43RAz2tKJcZ+ebolCkqnDuANnhne+i+bYxa
 7QeDpmchXRjTkcIBdw42Iw4e3D0BtUSwVBSckVnjB6OoJfnx/QhnvfPti+yA2QBy9x0G7+R90oz
 8QjLEDpOPSgNLwh5vIWKYD6x1MK3j4MTac6lsQ8sJCN/DaxozJ2PcUDAo/YwcmAHS9RzXpTNnT8
 hrIXK/IQ3sv+WGmI4g6F3wmlb9LiSZNCeTKbQIbbwOtAc0zLceTo1h5Hz8VFgvW1UBXWxBNqxKK
 YKwWrVqvPNiwDDGke6yN3c97x7IboOWicjovyi2x+L4GCaqZ2l8i9/hSpIYncONDf8SzAsYx7hZ
 1bj23yNHo8xi9NK1v0EzMjw44hfdG/rqHSqaQbolatj43pWcF4CDH3Ni+hhnJjhaziq+Mvhr8YV
 lHwPtVJMM+Fd0R+ojg/Q7NTndhoQ6CJXtj4Mz+kh9djUOIpdYnRN8cqDcZyKDoYdwvEd0XdYq+Y
 sYYdE4f1tKo2QHb+zW/EFobARCNadpBTyIHX8bEBytFhjjYYzdMPAgNxuIvhYwOnmQ7pGcI1C2d
 jEm+um8WgR2QO7sszkAx6qL3xW3A1GA==
X-Received: by 2002:a05:620a:4414:b0:93f:232f:658c with SMTP id
 af79cd13be357-945f35dc48cmr699191985a.71.1794026554523; 
 Fri, 06 Nov 2026 20:42:34 -0800 (PST)
Received: from localhost.localdomain ([165.225.38.148])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94604847c24sm85017485a.36.2026.11.06.20.42.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Nov 2026 20:42:34 -0800 (PST)
From: Gavin Li <gavin.li@samsara.com>
To: qemu-devel@nongnu.org
Cc: Gavin Li <gavin.li@samsara.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v1] net: add per-connection guestfwd unix support
Date: Fri,  6 Nov 2026 23:42:25 -0500
Message-ID: <20261107044225.2786-1-gavin.li@samsara.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=gavin.li@samsara.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 07 Nov 2026 01:07:44 -0500
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

For -netdev user,guestfwd=..., add support for unix-per-connection: in
addition to the currently supported tcp: and cmd:. With
unix-per-connection:, a new connection is opened to the given unix
socket.  This is an improvement over the current unix: support, which
does not support 1:1 guest:host connections.

Also update the minimum libslirp version to 4.2.0 (released in 2020) as
it adds support for the slirp_add_unix() function.

Signed-off-by: Gavin Li <gavin.li@samsara.com>
---
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
index 451c0fd1ba..b0b03b2bf5 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -1159,6 +1159,12 @@ static int slirp_guestfwd(SlirpState *s, const char *config_str, Error **errp)
                        "forwarding rule '%s'", config_str);
             return -1;
         }
+    } else if (g_str_has_prefix(p, "unix-per-connection:")) {
+        if (slirp_add_unix(s->slirp, &p[20], &server, port) < 0) {
+            error_setg(errp, "Conflicting/invalid host:port in guest "
+                       "forwarding rule '%s'", config_str);
+            return -1;
+        }
     } else {
         Error *err = NULL;
         /*
diff --git a/qemu-options.hx b/qemu-options.hx
index 5fe9d73eaa..062cd39aa3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3553,6 +3553,15 @@ SRST
             # and connect the TCP stream to its stdin/stdout
             |qemu_system| -nic  'user,id=n1,guestfwd=tcp:10.0.2.100:1234-cmd:netcat 10.10.1.1 4321'
 
+    ``guestfwd=[tcp]:server:port-unix-per-connection:path``
+        With ``unix-per-connection:``, a new connection is opened to the
+        given unix socket per TCP connection made by the guest. The unix socket
+        need not exist at startup time.
+
+        .. parsed-literal::
+
+            |qemu_system| -nic user,guestfwd=tcp:10.0.2.100:1234-unix-per-connection:/tmp/socket
+
 ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
     Configure a host TAP network backend with ID id.
 

base-commit: 71f25c75417d31c214ba2cd26b273c114fc99987
-- 
2.55.0


