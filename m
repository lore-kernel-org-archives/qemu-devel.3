Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6196E606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gurulabs.com header.i=@gurulabs.com header.a=rsa-sha256 header.s=google2026 header.b=aNhy31ln
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCC0-0007d1-Fn; Wed, 28 Oct 2026 18:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dkelson@gurulabs.com>)
 id 1xMCBt-0007c3-8g
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:32:19 -0400
Received: from mail-pg1-x564.google.com ([2607:f8b0:4864:20::564])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dkelson@gurulabs.com>)
 id 1xMCBp-000692-87
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 18:32:16 -0400
Received: by mail-pg1-x564.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so811991a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gurulabs.com; s=google2026; t=1793226729; x=1793831529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ynHjkneeChBH6HIXZuSRO2PDWZ8RvqSsFhJmzH6cnC0=;
 b=aNhy31lnejsAEGRDAy6gu8wiNs/UHHPruI8hsM4V4f97vzjDcLEWy4U4GitNG21Zoc
 Gt89z3yN+51SIwzTtgD4LYTqvJtD50GAhnyHhyeFVKhq1NHgRuJClvcC8VLD4o5S59+H
 34aNeRC78KqQU1TWe2Tw79lxF02S4JwglGEsa94zZzOb5AadSMyoIgwZCez2upa8xz1W
 66nLvcQCW8ZKGK4HMN399n4MkUq51jH7oAJ1N7HIldn14q70lUWooSjBTO679B0q1Wde
 4vNpJPoElt4qsMair43dqVP2HllJPGbyc4D69tgu7aF83VW5dtbNdD8lme0JnwPzaekZ
 l3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793226729; x=1793831529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ynHjkneeChBH6HIXZuSRO2PDWZ8RvqSsFhJmzH6cnC0=;
 b=JpSjFx26n0t64ZXvw7vSwwbEX86PIpEgyb7d2V376whYQH1hLlmhrpD9mlQbxYpiO7
 nCDJbLjreY0tYJMD5zRA6DSgwnp2kQrc8H2y8dXimHTXkQLnejNFa0DuuK005K6M+t+T
 gfdWM892UVVpKEyVIo5eo8HsuF+xrh0HvKK8n43lKkuH55mhEinLTSMi+BeOdhy2rOL/
 eFP0flFSoVsMSgliAQZD7hfZG1hJgOYDP53TvApqY8Ic6LoTHXMdCyDm+fnwiCYg5mj7
 kwIXariBS6K39rqn13Ckq9axKvLe2mNUD/gtwYeUFtQno0KB4NKK93RB9w+6V8PxeOgm
 i40Q==
X-Gm-Message-State: AFq9FYKF4Udoyz86nWoRGbunkXA5qo0lEvJr1YyXqBG++uFbTAswpf8t
 G/AKikZveRh4POrC/DTKvDiwNZmQFq2Ciz6C/JYRHxYQ+fVNQkMwibmQU+AmpIcYyKO/cnJI9F/
 JeNqtEvgyl5ozTaOXQawpzZAC2Naf3ioEJM78TTToKI3xAGtjgvDe
X-Gm-Gg: AYBFou3CpORZT+2NcW+MaAgXcfOclazzp1CBn++a5rbEGGKcViwRD9/2sSYbpIlolbX
 rsCtLAJJ7IdFiKjmCWHGdn9AtSlYkP9D1m8Guw09tMulsXZoWPLeo1bOZ2SEImG6TEIWhgfA3l4
 vRWvvDExue0XWqzglrCGz/ESxaU5d5VEND1NSqNkq5U9ts9LSLesMGZeN52CjvqVfwwZ+pY94j7
 Y4JEI6XnwZ98G3kgtMvqXnmpScegnH2PZZ+1Z0eAj04JKJAf62WdN40TSPIUR/ZzTJ348nTE0mR
 n0nTCzso7cBj5ZrqkUK3i+DJ5EXMnIJ6G8x/jU8qrx8XXhilCLU/4tsPbzBdW6E=
X-Received: by 2002:a17:90b:3eca:b0:3ac:adce:60ad with SMTP id
 98e67ed59e1d1-3ae580a9d5cmr2494145a91.22.1793226729381; 
 Wed, 28 Oct 2026 15:32:09 -0700 (PDT)
Received: from nas ([2607:fa18:1002:0:9209:d0ff:fe6f:7199])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3ae6e84adc9sm612536a91.5.2026.10.28.15.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 15:32:09 -0700 (PDT)
X-Relaying-Domain: gurulabs.com
Received: from localhost.localdomain (unknown [166.70.166.97])
 by nas (Postfix) with ESMTP id A5D6F55A9;
 Wed, 28 Oct 2026 22:32:08 +0000 (UTC)
From: Dax Kelson <dkelson@gurulabs.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dax Kelson <dkelson@gurulabs.com>
Subject: [PATCH] ui/vnc: recover a job dropped by vnc_abort_display_jobs()
Date: Wed, 28 Oct 2026 16:32:04 -0600
Message-ID: <20261028223204.86741-1-dkelson@gurulabs.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::564;
 envelope-from=dkelson@gurulabs.com; helo=mail-pg1-x564.google.com
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

Fix a race in the VNC server that corrupts a client's display output
(the client keeps stale pixels because their update is never sent), or
stops updating a client entirely, when the display surface is switched
while an update for that client is queued but not yet encoded.

virtio-gpu guests with a double-buffering compositor (GNOME/mutter on
Wayland) switch surfaces on every frame, so they hit it in normal use:
fast scrolling in a terminal leaves scattered 16-pixel slivers of old
text that stay until the client reconnects. A reproducer (a
page-flipping virtio-gpu guest plus a VNC/QMP harness) loses updates in
35 of 150 four-client cycles on master, and in none with this patch.

How it happens: vnc_update_client() clears a client's dirty bits for
every rectangle it puts into a job, resets vs->has_dirty, and moves
vs->update into vs->job_update, before the worker thread encodes
anything. When the display surface is switched, vnc_dpy_switch() calls
vnc_abort_display_jobs(), and a job the worker has not started yet is
discarded (vnc_worker_thread_loop() sees vs->abort and skips it).

The abort path only handles that case when no newer request is pending,
and even then it restores vs->update but not the cleared dirty state:

1. Lost pixels. On the page-flip path vnc_dpy_switch() then re-dirties
   only the GUEST dirty map. vnc_refresh_server_surface() compares the
   new guest surface against the server surface, which already holds the
   dropped rectangles' pixels, so every chunk that did not change again
   is never marked dirty for the client, and with has_dirty at zero an
   incremental update is not even attempted. The client keeps the stale
   pixels until those chunks change again or it sends a non-incremental
   request.

2. A stuck client. If the client sent another request while the job was
   queued (vs->update != NONE), the dropped job's vs->job_update is never
   cleared, and vnc_should_update() refuses every later update for that
   client until it reconnects.

Retire a dropped job whenever job_update is still set after the join
(a completed job's output was consumed by vnc_jobs_join(), which clears
it), keep a pending forced update, and re-dirty the whole client area
plus has_dirty. This costs one full update, and only when a job was
actually discarded.

Signed-off-by: Dax Kelson <dkelson@gurulabs.com>
---

Notes:
    Tested on master 73294d0 (x86_64, KVM): virtio-gpu-pci, a minimal guest
    that shows a screen of text and then page-flips (DRM SETCRTC, 60 Hz)
    between two black buffers, and VNC clients that use Raw and keep one
    incremental request outstanding. Once the guest is static, each client's
    framebuffer is compared with QMP screendump.
    
    - 4 clients, 150 cycles: unpatched lost the switch to black in 35
      cycles (78 client failures, all on clients 1-3; client 0's job always
      starts first). One non-incremental request healed each. Patched: 0.
    - 2 clients that also send a non-incremental request every 10 ms, 60
      cycles: unpatched, one client got no further update at all, forced
      or not, for the rest of the run. Patched: 0.
    - 1 client, 450 cycles: not hit either way on this idle host. We see
      the symptom with a single client on loaded KubeVirt nodes
      (GNOME/Wayland guests).
    
    The reproducer (guest init + VNC/QMP harness) is small; happy to post it.

 ui/vnc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 656768f9..c9187e7f 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -748,11 +748,24 @@ static void vnc_abort_display_jobs(VncDisplay *vd)
     }
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         vnc_lock_output(vs);
-        if (vs->update == VNC_STATE_UPDATE_NONE &&
-            vs->job_update != VNC_STATE_UPDATE_NONE) {
-            /* job aborted before completion */
-            vs->update = vs->job_update;
+        if (vs->job_update != VNC_STATE_UPDATE_NONE) {
+            /*
+             * Job aborted before completion (a completed job's output was
+             * consumed by vnc_jobs_join(), which cleared job_update).
+             * Retire it even if the client sent a newer request meanwhile,
+             * or vnc_should_update() refuses every later update.
+             * vnc_update_client() already cleared the dirty bits of the
+             * rectangles it carried and the server surface already holds
+             * their pixels, so nothing would mark them dirty again:
+             * re-dirty the whole client area and its pending-dirty count.
+             */
+            if (vs->update != VNC_STATE_UPDATE_FORCE) {
+                vs->update = vs->job_update;
+            }
             vs->job_update = VNC_STATE_UPDATE_NONE;
+            vnc_set_area_dirty(vs->dirty, vd, 0, 0,
+                               vnc_width(vd), vnc_height(vd));
+            vs->has_dirty++;
         }
         vs->abort = false;
         vnc_unlock_output(vs);
-- 
2.54.0 (Apple Git-157)


