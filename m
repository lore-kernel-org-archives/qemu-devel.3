Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A14606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=KfgLYx63
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQ9i-0003Bj-0G; Fri, 06 Nov 2026 15:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9g-0003B8-1r
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xPQ9e-0004mp-4k
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:03:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so48545e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793995396; x=1794600196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hFUTERdPrSqmP8xKhWv9s8cMoPJQwZU0Cgpn/MagI5U=;
 b=KfgLYx63PWKuDaLZ8BGEYDLnMmQs2dZCmfTI8WkfEqPmP1RMW0NnBTHOmTfa36De+u
 jsjkQKeI31UQG9OgJ2+70M4UZB5gwya+81mPLnr6/eoBG8BuP+Yxc4Ocbl+geoa4fKdU
 gLqrJGbhkIFT3rrTAYOK6tJNl931RshwtbusJQrOHfocy5LH3CfcfdOjCx9fWxmfh0H8
 xmPosAfT4i8Exj4euKKd0pbd/mJJEe6C2fZWL1oXRkpMIHcAB/2xizGDI+dA0fC0lGts
 lZGZAR+psJ45xqldr6skoTX8iTYCbJ5Z/pXkHU54Tkj/9V8H4uvDL7ZnnRkgaXUQQ7qC
 WQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793995396; x=1794600196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hFUTERdPrSqmP8xKhWv9s8cMoPJQwZU0Cgpn/MagI5U=;
 b=Gt3al1Y7wkkC38707dQ72RLFF8UNQxalY43FigunY9X+8n+asIF975scZ1K4yII2js
 3x74eGAaq4/H/jBbIxhjGSuNdN305zdwCj2kpN/rqHSRjiULteDOpvaRInt03lKso3X5
 2cDrRV4GCYQs6K77SB5qmIn7NnBtf6DVk9iHPHkWdkQpueLL75GgjZHicKis5eDHNccJ
 /h0Y2jcMAlf2GES/ST/qd0kuCHPoDD294HWEtzFqeZ4oaXb92vKD+DW80IA8li6zzCou
 8+arqdR9kOem4KKp/AlnlyxMrAn+HpuOZndO3Fz9Q1A8GkuDecHCvaQ8OVzaik5tQ8B1
 od0w==
X-Gm-Message-State: APuU4Z9vsgGRqiGP6jqKOPXlR7jRL7u3yUWxkYoZV+HJDRgoaUptC4xU
 gD18KFYcGB3IZHNdUO75jEZGPnXAbtGJxfPtl+XRQAB+oK0Z559UjEEa+XnRFCBwHlBqWJ36J1x
 0UfWu
X-Gm-Gg: AYBFou3LY1ne3KJoFjRRwOSdPBKx8ajw0d0UsQFesV1SMKu1zdslHo7f3lN3+tIqyOX
 bGrV/N5ytZNw/YEgekawMgVNLi6dIou01Wc7kj65oF14l/VySnczRpYD4hCege0hgH+Ou1lHhGg
 3WdDgFY/flB2NEubBBWBYIr1k4eRJxVj/X0hr3rj7bFBwibvT5iXIDkXPYCxfkMoJruXhyCt7s3
 oohV/fsTvptCO7IOe5gniyPUY3V3n3qOapXost3PD304QCES1s6lzHNlzn8wl0UTlnDNrAsw3fE
 5kOVG8d2BR8J1g3dIsq3iLBE2CwssezBIn5Fji0PALmMSRwauKlSkM3rbJYwf3/Zx9G9wrWCC+Y
 nvFqXXJjPMFq4/EOZGVp6LMOCLdY0cY0bCTQBr/UNpUxyoVNyFwMQBt2Zz1qVvPq2MNFC4+hyoL
 3QXkNqwpUcONdVEV/cTrlzfSVE4di5eNQ1wTDmrCZDTkDWa915AOw5AlmReiifMmHIOSDPaqsx+
 VtKgF0M1OSvDw8gDyXzrd27aLFaQ4iuD0eJrTSvW0KGWcNGUe2AiVz9evLdSfv/HFXDe19kCNMC
 OYB/bY0kwmFg12OM4qvEYi27Fg==
X-Received: by 2002:a05:600c:8115:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4b8190f468amr881655e9.7.1793995396420; 
 Fri, 06 Nov 2026 12:03:16 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:1983:68c3:80e8:4ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7e3271867sm4660995e9.6.2026.11.06.12.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 12:03:15 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Jason Wang <jasowangio@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/2] net/tap: fix busy loop in tap_send() after the tap device
 is deleted
Date: Fri,  6 Nov 2026 21:03:09 +0100
Message-ID: <20261106200309.122830-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106200309.122830-1-den@openvz.org>
References: <20261106200309.122830-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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

From: Denis V. Lunev <den@openvz.org>

When the tap device is deleted on the host while QEMU still holds its
fd, poll() reports EPOLLERR on the fd every time and read() fails with
EBADFD. tap_send() just breaks out of its loop with the handler still
registered, the main loop wakes up again at once and QEMU spins at full
CPU until the VM is destroyed. Every tap netdev is affected, single
queue or multiqueue. With vhost-net the spin starts once vhost stops,
e.g. on guest reboot, since vhost removes the handler while it runs.

Stop read polling on EBADFD and report it. Other read errors are left
alone: tun fails a read with EINVAL for a single packet it cannot
convert, e.g. an unsupported GSO type, and the next read succeeds.
EBADFD only exists on Linux and Solaris, hence the #ifdef. Anything
that turns polling back on later, a vhost stop or the delivery of a
queued packet, hits EBADFD once and stops it again.

The test deletes a single queue tap through netlink under a running
guest and checks that the CPU time of QEMU stays low afterwards.
Deleting the device needs CAP_NET_ADMIN, so the test is skipped
without it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 net/tap.c                     |  8 ++++
 tests/qtest/virtio-net-test.c | 70 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 9bce0d088f..8274aebda6 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -265,6 +265,14 @@ static void tap_send(void *opaque)
         size_t min_pktsz = sizeof(min_pkt);
 
         size = tap_read_packet(s->fd, s->buf, sizeof(s->buf));
+#ifdef EBADFD
+        if (size < 0 && errno == EBADFD) {
+            error_report("tap: device is gone, stop polling: %s",
+                         strerror(errno));
+            tap_read_poll(s, false);
+            break;
+        }
+#endif
         if (size <= 0) {
             break;
         }
diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.c
index 9224ee05d9..027fa6210b 100644
--- a/tests/qtest/virtio-net-test.c
+++ b/tests/qtest/virtio-net-test.c
@@ -20,6 +20,8 @@
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <linux/if_tun.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
 #endif
 
 #ifndef ETH_P_RARP
@@ -380,6 +382,72 @@ static void mq_tap_attach_fail(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert_cmpint(readb(addr + sizeof(cmd)), ==, VIRTIO_NET_ERR);
     guest_free(t_alloc, addr);
 }
+
+static unsigned long qemu_cpu_ticks(void)
+{
+    g_autofree char *path = g_strdup_printf("/proc/%d/stat",
+                                            qtest_pid(global_qtest));
+    g_autofree char *stat = NULL;
+    g_auto(GStrv) f = NULL;
+    char *p;
+
+    g_assert(g_file_get_contents(path, &stat, NULL, NULL));
+    p = strrchr(stat, ')');
+    g_assert(p);
+    /* utime and stime follow the 11 fields after the command name */
+    f = g_strsplit(p + 2, " ", 14);
+    g_assert_cmpint(g_strv_length(f), ==, 14);
+    return g_ascii_strtoull(f[11], NULL, 10) +
+           g_ascii_strtoull(f[12], NULL, 10);
+}
+
+static void tap_delete(int fd)
+{
+    struct ifreq ifr = { };
+    struct {
+        struct nlmsghdr nh;
+        struct ifinfomsg ifi;
+    } req = {
+        .nh.nlmsg_len = sizeof(req),
+        .nh.nlmsg_type = RTM_DELLINK,
+        .nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+        .ifi.ifi_family = AF_UNSPEC,
+    };
+    struct {
+        struct nlmsghdr nh;
+        struct nlmsgerr err;
+    } ack;
+    int sock;
+
+    g_assert_cmpint(ioctl(fd, TUNGETIFF, &ifr), ==, 0);
+    req.ifi.ifi_index = if_nametoindex(ifr.ifr_name);
+    g_assert_cmpint(req.ifi.ifi_index, >, 0);
+
+    sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+    g_assert_cmpint(sock, >=, 0);
+    g_assert_cmpint(send(sock, &req, sizeof(req), 0), ==, sizeof(req));
+    g_assert_cmpint(recv(sock, &ack, sizeof(ack), 0), ==, sizeof(ack));
+    g_assert_cmpint(ack.nh.nlmsg_type, ==, NLMSG_ERROR);
+    g_assert_cmpint(ack.err.error, ==, 0);
+    close(sock);
+}
+
+static void tap_deleted(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    int *fds = data;
+    unsigned long ticks;
+
+    if (fds[0] < 0) {
+        g_test_skip("cannot create a tap device");
+        return;
+    }
+
+    tap_delete(fds[0]);
+
+    ticks = qemu_cpu_ticks();
+    g_usleep(G_USEC_PER_SEC);
+    g_assert_cmpuint(qemu_cpu_ticks() - ticks, <, sysconf(_SC_CLK_TCK) / 2);
+}
 #endif /* CONFIG_LINUX */
 
 #endif /* _WIN32 */
@@ -431,6 +499,8 @@ static void register_virtio_net_test(void)
     opts.edge.extra_device_opts = "mq=on";
     qos_add_test("mq-tap-attach-fail", "virtio-net", mq_tap_attach_fail, &opts);
     opts.edge.extra_device_opts = NULL;
+    opts.arg = GINT_TO_POINTER(1);
+    qos_add_test("tap-deleted", "virtio-net", tap_deleted, &opts);
 #endif
 #endif
 
-- 
2.53.0


