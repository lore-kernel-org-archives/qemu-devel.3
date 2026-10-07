Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86356CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENKX-0002cO-R1; Wed, 07 Oct 2026 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsz-0001cv-DS
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJst-0005KH-93
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so11123695e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349684; x=1791954484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4bLU8H9HIV8nETT9y53fkVZYcaJvtDXCM34S++tplI=;
 b=iUhtijR8bs4D9szfRqnl9A3+SJMfWBJPr5b9Vq9I6zOmZuFDRpHYbMVQGDyvjm+Yfv
 iSRR96AJLMnLUTmyAm2jaYXBYbsyqRjgTlp45LHGwy3ssIDFxJYPytxvHNeysbfv0R53
 KwmyH3nPXqAjnHk4AJzx4sTgZpNWotIH3lWf5C1xE0U0bMLvdjZhtbQ6Vd6orhC4SnYW
 PJMw+fhFUH2L6FAh08XZ8yBwKfkbLwmZ0oSmh/8oijMZHNeteOY6ndO0NJZTvqYfzIcE
 Ndp9YkY2J/k5WNTxVmQewQ6iOn0PH1amwheAtHDLO+7HAvswqj/g4kTJuOmP5qRywG4s
 OE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349684; x=1791954484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d4bLU8H9HIV8nETT9y53fkVZYcaJvtDXCM34S++tplI=;
 b=1PTxhiqMyDGxO1JuFzW4nq8RIrXiErGpQdrDmN4kxDSd19CbokJ7ZawIgovtPGwDvb
 4Dpfj5og84xGmgMV/dEJKi4gYnXNAgRDT5obqwFw1cC0DPzWP6O5qgQ+TWT4xnFmEp/G
 w8AahelIIeC+EMStCAEzWLF2hC9hhIA6M2bcglX9LvkYiH92+/a1kQNA7GzxM5ZhV10J
 EycFhH7N2f8MmkeRBnq6DABkU+e9SXKjCKXW+HBxpUkJKQ7yPaWaJT1rR0udh2wHpiWv
 m2MQK4XPs5saJYzSVh2a2Dgy+tz/CgCchwbd83qFKhPioEbUlWFYrsj972ZZWyeBqgE9
 05jQ==
X-Gm-Message-State: AFuF++lhuz81F7SKz/gjMs/mVbyaCffk9eZWKE3Mqqjq7X6F9ruAqxdx
 5w6l50bie2jKwmArVAsHDkPjftroH9oFKZzDeE1vmzcaOAFDS1dlsBxe/gdGiyvTrms=
X-Gm-Gg: AYBFou3p5z0CphFjaC3x84PE9sB+BfM4DOQ1zH8tGKPs3RqE2kZ9YRT+hLWbkf1rQks
 zi6RrRi4G2AQ4K9/e6Ap4qDOU7GlHyIhk9Y5UOLH+NkCQoomwvXCR/N5SryGCsWYATmtsOSLYa+
 wSXZjgbeB6uDy402cX7hzkLhy+V0D0O9JlCb86S1vIZw7so40RWRB3D7qgO+i2vdfcUf1Z863Ct
 k392dbnofy+Kfk/F+GAy3j2O4/nIjiMXhxB8WAhvGxK0xXzcOoAnQiVOMBDCYFRn2uHzO6bZvNV
 lR7PzjL83ahmk6EhJ9yCN1dhhq3SLsR4CdZIcnCRBINw6pVg45rtIw1ndkgIKf8K+uBg3F8wHvc
 Xm2hvIWbpu3dJmxKQomTyimNv+rLy9rEoMss2GVLnCn4mNSbGHB8P2Sy5cm4K0GQaI115RkDimL
 YytdYljMGdIh3GnWwcdiv6iszbeYSIA7bX/Ch7UxJ3eif0AZo4DD2teP+9enIi3QjyzX1ri5rNK
 Ee1vOxIl5gF9CIHr8LYHfKl
X-Received: by 2002:a05:600c:810a:b0:49f:f0bd:1e40 with SMTP id
 5b1f17b1804b1-4a1804557b3mr10459915e9.23.1791349684286; 
 Tue, 06 Oct 2026 22:08:04 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.190.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f795f29sm33359315e9.11.2026.10.06.22.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 22:08:02 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Nariman Sayed <narimansayed28@gmail.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Subject: [PATCH v2 2/3] net: add generic get_mtu NetClientInfo callback
Date: Wed,  7 Oct 2026 08:07:17 +0300
Message-Id: <20261007050718.926-3-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007050718.926-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a get_mtu callback to NetClientInfo, along with a qemu_get_mtu()
wrapper following the existing qemu_has_ufo()-style pattern, so that
device models can query a netdev backend's host MTU generically
without needing to know or check its backend type.

Wire this up for the tap backend via tap_get_mtu(), which is now
static and only referenced through net_tap_info.get_mtu, matching
the existing pattern used by tap_has_ufo() and similar callbacks.

This allows other backends (e.g. vhost-user, vhost-vdpa) to
implement get_mtu in the future without requiring changes to any
code that calls qemu_get_mtu().

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
---
 include/net/net.h | 3 +++
 net/net.c         | 9 +++++++++
 net/tap.c         | 8 ++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 9edfacf827..ed06814644 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -72,6 +72,7 @@ typedef bool (HasVnetHdr)(NetClientState *);
 typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, const NetOffloads *);
 typedef int (GetVnetHdrLen)(NetClientState *);
+typedef int (GetMtu)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
 typedef int (SetVnetLE)(NetClientState *, bool);
@@ -110,6 +111,7 @@ typedef struct NetClientInfo {
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
     GetVHostNet *get_vhost_net;
+    GetMtu *get_mtu;
 } NetClientInfo;
 
 struct NetClientState {
@@ -204,6 +206,7 @@ bool qemu_has_uso(NetClientState *nc);
 bool qemu_has_tunnel(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
+int qemu_get_mtu(NetClientState *nc);
 void qemu_set_offload(NetClientState *nc, const NetOffloads *ol);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
diff --git a/net/net.c b/net/net.c
index 0a30579ca4..9fb70e412a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -514,6 +514,15 @@ bool qemu_has_ufo(NetClientState *nc)
     return nc->info->has_ufo(nc);
 }
 
+int qemu_get_mtu(NetClientState *nc)
+{
+    if (!nc || !nc->info->get_mtu) {
+        return -1;
+    }
+
+    return nc->info->get_mtu(nc);
+}
+
 bool qemu_has_uso(NetClientState *nc)
 {
     if (!nc || !nc->info->has_uso) {
diff --git a/net/tap.c b/net/tap.c
index 57ffb09885..89cec2accd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -379,6 +379,13 @@ int tap_get_fd(NetClientState *nc)
     return s->fd;
 }
 
+static int tap_get_mtu(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return tap_fd_get_mtu(s->fd);
+}
+
 /*
  * tap_get_vhost_net() can return NULL if a tap net-device backend is
  * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
@@ -411,6 +418,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .get_mtu = tap_get_mtu,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
-- 
2.34.1


