Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=o+sMlwcS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVbc1-0004FJ-Vf; Mon, 23 Nov 2026 16:30:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xVbbz-0004BN-Bu
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:30:07 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xVbbw-0000nu-6g
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 16:30:06 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so3127549f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1795469400; x=1796074200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hF/Fq+JYQGL6VliaArv/VPDXtF8Cq9Jqq+27FFiCTM8=;
 b=o+sMlwcSD+CvFUMuDlbn8pojPOi5U4yEUA2+PhNbWG57MlN69SI9a9xmPLaAHbrcSn
 naxJ38azTJvpBHsZvAOzoiD2m2ZCfLNF1n9xeOEYZJELSV30yAjFaBcrYkBkdfqc00d9
 GrfV7JE2B8142/N8F6iQclCIVyACCkwS/CSJ1Il76gm7//QQvGjQdYQdLKFbVBW2iHfH
 IMncpe4PI3JAI+nRAPcs0QmjUxg0ts3Et1m0FO/cbDzsl4tEmLO8dHIE2rJ5TkAEKZOk
 ULb67AWbyS90ejuXRk7JxBLFR6aCEmG5zzXUTVmZNDAvnKX7HJyivwhXL48HcJOs5lFG
 AWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795469400; x=1796074200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hF/Fq+JYQGL6VliaArv/VPDXtF8Cq9Jqq+27FFiCTM8=;
 b=ZHiF1VcHEEkuwLYM07YgYT1vaib2zEGz3LuB8OU8OW9k8MBerWa9QIBISae3r4Ig9/
 4fEzB3whadVH4AiDKJ9yr+EgdZ1xaLQQHp6VLkPQhiBev1LpHSe4U95tbyCPVnQ6RtbQ
 NZct+e2id5pT9x9eoCmlqU35z4PQbVJ651bdQjUBuK577OsVGNeenjdbsF7Fs5XrwY9S
 m+2nJl4NdTc6W0rqGEUt2TSGEcotX/jzBzzwMTtBI7KzXxMaS7hV3uYaYk0u0fMF8BfB
 mGPna9ASbC0YlmODk67m+hbV/GdEhXFMQf9hXiOMwRZgNqFz955ILBVh8zdtv+gmCmrd
 mrdw==
X-Gm-Message-State: APuU4Z/qPkrnlsdk1TO1pUWJLL5E3EwvDNpnfYMmdq+uUmP3T5dSR8ej
 w3oXHQ9a2PFRY9dP5hnGQWcSFUPukxJT3S6gGtaIbttyKHmSIZuHYvPBWejyAyrp/uyM4DQVaR1
 2tnO0
X-Gm-Gg: AZFdTZdvfblBImyg+MOXJTlZ30EuPqjoxQh6Ff0lwo77YEQ4Kych7/+6VOy1e/xx2pb
 M89/N2A2BmyvPBxruOjTwvlmN+ektUtCIBYmqRf+WWPxsN9ZyKpR/8H3wCwHMd3/1NUIyQTKS6X
 PQB9IXcbmI/FCu685H24wjafd48oYmyk0/9JMh3QzS7gMXM8YK1HSiAgZNLymG6MSNnmF+NGri7
 cI0WU8HubQXSjOSF3Ugp86WxRBwR83dV9HsWB9HLOx05USJqq/Qz9m/LnLm1F/lLekLTwaQKink
 z1NzqCLN381CNUIVUSjbW2IqnHVYFwreSTsTauBbKpnXavBb7dgvO88Ucx47C9bUdg6Use9lywY
 sByd+KhlHq4xmqytuuUtbJhR+elixOaWM8KHtLqzQR4wy0uRc4Ux4rHHTXId/OBhsa5WsnKT8ht
 ZmV7jxIQyRJ3PJGLKzHixVY0yqSdUGoqKF8mqrk9CyBx1BLlqv/sR+9NxNYZEVRztHo6WW2fBVE
 eurqEah7nHevNsy8q8FuigiaWg4AMRHSSj/72/psLUGLAI0B3LZjLbwVfxFnu91GIGNowAk1geA
 ijFgA/RuNeUGxTQcBWNlT1oPOzQ=
X-Received: by 2002:a05:6000:4284:b0:48e:3b53:e100 with SMTP id
 ffacd0b85a97d-4abb9edfd7cmr24148003f8f.56.1795469400469; 
 Mon, 23 Nov 2026 13:30:00 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:62d2:2eda:8655:4219])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b2050f1sm23996103f8f.38.2026.11.23.13.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 13:29:59 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-stable@nongnu.org
Subject: [PATCH] monitor: fix abort when a rate-limited event races with its
 timer
Date: Mon, 23 Nov 2026 22:29:57 +0100
Message-ID: <20261123212957.242482-1-den@openvz.org>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=den@openvz.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rate-limited events can be raised from iothreads, outside the BQL.
QUORUM_REPORT_BAD always could be. Since 2155d2dd7f73 BLOCK_IO_ERROR is
rate limited too, and any disk on an iothread raises it.

The rate-limit timer runs in the main loop. timerlist_run_timers()
takes it off the active list before it calls the handler, and only then
does the handler take monitor_lock. An iothread raising the same event
for the same device in between finds the rate-limit entry with a timer
that is no longer pending, and QEMU aborts with:

  Assertion `!evstate || timer_pending(evstate->timer)' failed.

This hits virtio-blk on an iothread with an error policy other than
stop when the storage goes away and every guest request fails.

The state is fine, the assert is wrong. Once the timer has fired, the
handler is committed to run: it takes the lock as soon as the iothread
drops it, sends the stored event and re-arms the timer, exactly as for
an event stored while the timer was pending. The event goes out at the
same moment it would have had the iothread come in after the handler.
The entry is only created, re-armed and freed under monitor_lock, so it
cannot go away under the iothread. Drop the assert.

Fixes: a24712af5425 ("monitor: Turn monitor_qapi_event_state[] into a hash table")
Fixes: 2155d2dd7f73 ("block-backend: per-device throttling of BLOCK_IO_ERROR reports")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: qemu-stable@nongnu.org
---
 monitor/monitor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890..22c00b6195 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -360,13 +360,14 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
         MonitorQAPIEventState key = { .event = event, .data = data };
 
         evstate = g_hash_table_lookup(monitor_qapi_event_state, &key);
-        assert(!evstate || timer_pending(evstate->timer));
 
         if (evstate) {
             /*
              * Timer is pending for (at least) evconf->rate ns after
-             * last send.  Store event for sending when timer fires,
-             * replacing a prior stored event if any.
+             * last send, or it has expired and its handler has not
+             * taken monitor_lock yet. Either way the handler will
+             * send what is stored here. Store event for sending
+             * then, replacing a prior stored event if any.
              */
             qobject_unref(evstate->qdict);
             evstate->qdict = qobject_ref(qdict);

base-commit: 8f66cb79044c370e3813c56ceb7a75a5ca2d0a0e
-- 
2.55.0


