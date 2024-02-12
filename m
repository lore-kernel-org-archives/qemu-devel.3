Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30207C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 14:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWvN-0006y3-9e; Mon, 12 Feb 2024 09:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZWvL-0006vS-Vf
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:04:44 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZWvI-0000mV-UO
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 09:04:43 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e09143c7bdso1446729b3a.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 06:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707746679; x=1708351479;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tsf5j453l/NKvZWRTZEYgI9PIfyN3n0ULKEqSdjEljA=;
 b=0px3tQ+ixNrgHBqJnEZO3omgZXRwWIfjKSBC3THjxH+faOmpfF3x6MbJn1W7+MXJQz
 sBTKfyZOcCpF3Z/4qw5aYEHU0FnT/Yqw+frtzxoyRy7NRKcVq+P1GgwO1JTseHsaXB+h
 SNesT+C6pFNacol8qcLC1xbK2rVRrxxQ8Ap65a8lnA6ejEm+ibE+5r9kb9PGFyBb9sa8
 28GUc+K+AtDyKSvm9eCPLJ8GJfEzZFvgp6dLmCPl5kbtHtwKEZA7UQL/U/JDsf5949FB
 RqQo/R/nhb2ccMy+2GlzZZoNaBKoSFIcf7wgWQ67aOp5wktACOky4aUjQPvfl3y2rhki
 BxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707746679; x=1708351479;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tsf5j453l/NKvZWRTZEYgI9PIfyN3n0ULKEqSdjEljA=;
 b=fq0AkTjgJekF/Lhocq5SaU9IsPZSPKdI8Yz9N1uRa5P0eh7Uj5eNDZswjRNTWHapce
 ukaBC1gUxjS1O6LKASyQLjRsjEnxHol1GnQKi0iiJP9TlN1FbjTLVwQ/0FLl+WyLjxuM
 a31IsqNAV2FMblbwboRRTbpqlxSSc4AUJWG97Rva0z+qw8dABl4Kc6EP+NcjdFPat+Vo
 cEcJhd++7w+fSmizud+VdIvQM5b98mCm1Y+EtXzPGQN3MKbuIJijIA/TFLOwEUNJ95gV
 7o8a+0a4OZujViMOndV7W491HwKt6yZFJaIFN34sTIkGMZHfUN07A/ht3fmeB6P/Ym+v
 ssOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5GjWa62xKNNPmdsF6Q4E2Y8CVqcW4hl8jTFGdRYXG51PQNQb9QgrJLBpjdjaK4TNgJ2jHjyikbD9/eKkP73RnKq9D9RY=
X-Gm-Message-State: AOJu0YxF1vRGJjhzrcrzkD4/tmdMUqF32yRXPvxOCq/h9BI5MmF3vftT
 l7BJpx8G3qd6VVtPzAsx4hBHbVGZzNtqrBIDv5SEjIdA6hRKyvYHhUkBCdCcjzs1C8Qk6VL3WeH
 v
X-Google-Smtp-Source: AGHT+IGhzA/N4P7gg6CkvgXjO94oXGEWdhwSpZa9x2Y3yGlI5ft4XSXySmPr/FzTUmGHwzVsxG4x5w==
X-Received: by 2002:aa7:888e:0:b0:6e0:91c4:be1c with SMTP id
 z14-20020aa7888e000000b006e091c4be1cmr7874092pfe.9.1707746678915; 
 Mon, 12 Feb 2024 06:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWxae7XoR+RqzIaHdI3Vo0+MCc7jwxDosKGIzjvWwn0huFklaAvcHdNSDTVdmlchPS/Tss3EvU1ye2r8EAqtMNHaqpa5r2nVLAutvkedHu2qnnf99je
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 ko19-20020a056a00461300b006ddc75edd55sm5484536pfb.152.2024.02.12.06.04.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 06:04:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 12 Feb 2024 23:04:35 +0900
Subject: [PATCH v2] tap-win32: Remove unnecessary stubs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-tap-v2-1-94e2ee18b925@daynix.com>
X-B4-Tracking: v=1; b=H4sIAHIlymUC/x2MzQ6DIBCEX8XsuRB2q/Xn1PdoPFCgZWMqBozRG
 N+96G2+ycy3Q3KRXYKu2CG6hROHMQPdCjBej18n2GYGUlQqQhKznkSFqqmxLU3j3pCXU3QfXi/
 Lq8/sOc0hbpd0wbM9/3dU6qEqRKplVVIrUOiBPQ9BBpvT0+pt5FWa8IP+OI4/ResC1ZwAAAA=
To: Jason Wang <jasowang@redhat.com>, Stefan Weil <sw@weilnetz.de>, 
 qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some of them are only necessary for POSIX systems. The others are
assigned to function pointers in NetClientInfo that can actually be
NULL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Rebased.
- Link to v1: https://lore.kernel.org/r/20231006051127.5429-1-akihiko.odaki@daynix.com
---
 net/tap-win32.c | 54 ------------------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 7b8b4be02cff..7edbd7163370 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -707,70 +707,16 @@ static void tap_win32_send(void *opaque)
     }
 }
 
-static bool tap_has_ufo(NetClientState *nc)
-{
-    return false;
-}
-
-static bool tap_has_vnet_hdr(NetClientState *nc)
-{
-    return false;
-}
-
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
-void tap_fd_set_vnet_hdr_len(int fd, int len)
-{
-}
-
-int tap_fd_set_vnet_le(int fd, int is_le)
-{
-    return -EINVAL;
-}
-
-int tap_fd_set_vnet_be(int fd, int is_be)
-{
-    return -EINVAL;
-}
-
-static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
-{
-}
-
-static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo, int uso4, int uso6)
-{
-}
-
 struct vhost_net *tap_get_vhost_net(NetClientState *nc)
 {
     return NULL;
 }
 
-static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
-{
-    return false;
-}
-
-static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
-{
-    abort();
-}
-
 static NetClientInfo net_tap_win32_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
     .cleanup = tap_cleanup,
-    .has_ufo = tap_has_ufo,
-    .has_vnet_hdr = tap_has_vnet_hdr,
-    .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .using_vnet_hdr = tap_using_vnet_hdr,
-    .set_offload = tap_set_offload,
-    .set_vnet_hdr_len = tap_set_vnet_hdr_len,
 };
 
 static int tap_win32_init(NetClientState *peer, const char *model,

---
base-commit: 5d1fc614413b10dd94858b07a1b2e26b1aa0296c
change-id: 20240212-tap-51087194c8eb

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


