Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2A4606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e8uMe8QA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlFu-0006nY-Af; Tue, 27 Oct 2026 13:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFp-0006mZ-Iz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLlFn-0000if-Fc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:46:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so1257075e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123190; x=1793727990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3K9rWJJeJ1opaIcb0feWqc4Wlnwrg7nSQ3xZ6D43aPY=;
 b=e8uMe8QAhcacXHhaT4XAWB0ZKdYU0MMH7ZDsVnjOMbYUzrfTDWVmV3//uJieR4CgeD
 +M+8WHdOe7sXhi8nckvQCyaWtM0AdXJBFFkG0PD64L/fXJujDZXu9ZsP65xyOht1cPmK
 mxWSLQFBflnLPcMjTgMfKOMTdp5KhO6cp/GaAugSu/KYiUC0L0Ene+ce8CYHRv1sHDzz
 Ecv7YGrgWIeaOc5s+Tp0H6nrAB9YpiFocI2wYVYOClCk9GGcd2nY9aZpLsnjTWpnUl15
 NnamoYdpnfpDoqXztEIZOybWSQ+UomdK8ozRx6WZTiHC2rlPxyNCyVcwjL2bsoH0bAyB
 wK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123190; x=1793727990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3K9rWJJeJ1opaIcb0feWqc4Wlnwrg7nSQ3xZ6D43aPY=;
 b=QstsfeyCXuL/Vx26lcMfxyt0PQiFFeWyLZCG1BMn+r7WZz/MHZSzsGMoCNGYlkapDq
 J7OXoZse2K9E7g+USVSrD7Z+KBrojKn99f3mlNy33WxLe/KigczGTEDMQTOrec4TO0QZ
 6pC89UcJediY6FiG020dlVEtZkjRgnWOnmteqfDi0tYsJlz7BESETffxbRE48bj9RHCY
 ZG6mNuq/nMp+MFnzuT1ENv3Wv5v/VfHal6Tp5dIfKDVmkSsTcS5/1XiLuOxMGsbRc1Hd
 M08Sw6/5Det+9U1vyDftct9+zimm/vfJbNunkrbOBRUXsS3MoQa5UOSrNaV2O/ouMVii
 OZfg==
X-Gm-Message-State: AFq9FYJDKB9kMSUTjnNjy+nmtjUMNOaVBol8G9ByNisQSrnBi8gc8k4W
 WYncqaWyZAKnc+S9DlugdOJRFDL4sw4SLDjC27bNy5rzOCgdncHfrirFx2yhDzraUb67YgfCzmL
 djEuRv6Y=
X-Gm-Gg: AYBFou2LbsNgrbg2U02fESVlrvmX+BpWjVDVhfZgvJ6HpqBm16+M6XOlhrEWB577GNQ
 HUPeyXrG3zVgh4GC7O4gwjQSHIAFgA9aczKbFTshfUUF1gnaerrANwQaFQWROO/fdxCSw+gL2S+
 xsFHr7eN9fjb+aPlAz+uhQcWEnCEuOEDQSGY1xFbutoxSD4p86C4Tt4U6shXRqwPC65HDwsxz4w
 4OmcDmkiYOAAQpy7pE/CotKaiNFWBfc++849MBRGlS28HsMqo7BxNk1g+iaMpKJowMUptsjF0X/
 g2U36LtFCTPXS4FsEQVX7GFBkU7HxKxIifJR6RHXXrh3bSh4TNMgsXdVmM5MgShSSjYWdRgNGeM
 bJG+SD7OYX74C6mDEWwYUv/AHH+7WzHsfw94AiQ/rGDCL6Sb19Ya+/AHoSLsTX32LP/p9FUI040
 8JyuyhyCWuo0MfIa/OQu7GeZrDgpBsNEtldtWiLXWcvbHDTre51Lb1cZ2aFbryaAMVGrqHl+SCy
 6WR4redV9zj9VXLCzOzUG1jJjJOxfwEtMEdhYzBCfwjwlJxUU0qcN6Qolrotw5LXTgwHZR4TNBf
 tLxpO/8+czr03tQP8SZl2OZqryz06KSplEJtUlOBaUYk1tTYw2EmBQFeqR7j
X-Received: by 2002:a05:600c:c84:b0:4a2:10f9:37db with SMTP id
 5b1f17b1804b1-4a7c0a4b2efmr82102805e9.7.1793123189891; 
 Tue, 27 Oct 2026 10:46:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92b8812c5sm5518875e9.10.2026.10.27.10.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:46:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/4] net: Set do_not_pad for net backends
Date: Tue, 27 Oct 2026 17:46:23 +0000
Message-ID: <20261027174625.4025878-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently our handling of short network packets (i.e.  those which
are smaller than the minimum ethernet frame size of 60 bytes) is a
little confused.  The intention is that we allow network device
models to transmit short packets, but we protect them from having to
deal with receiving short packets unless they explicitly opt into it.
This means we don't have to have a lot of code in each network device
to try to handle the short packet size -- historically that code was
untested, and often a source of "carefully crafted packet can cause
an out-of-bounds memory access" bugs.

Our implementation of the padding is currently done when each network
backend feeds a packet into the system via one of the
qemu_send_packet family of functions.  This mostly works, except that
we missed some of the more obscure backends (e.g.  the socket
backend), and it means code duplication in each backend.  We'd like
to switch to making qemu_send_packet do the padding itself.  To do
that, we first need to make sure that all the NetClientState
implementations which do not want padding set the do_not_pad flag.
We do this by setting the flag for NetClientState instances created
by qemu_new_net_client() and qemu_new_net_control_client().  Emulated
network devices use qemu_new_nic(), which does not set the flag.

Note that this also causes the net/hub client to request no padding.
This is the right behaviour: we want the hub to accept short packets
and forward them on to all destinations.  Each destination then gets
to choose whether it sees a padded packet or the short one.  The
hub.c code is length-agnostic and doesn't look inside the packets it
is passing on, so it has no issues with short packets.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/net/net.h |  3 ++-
 net/net.c         | 10 ++++++----
 net/tap.c         |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index fdf6a2ddd44..3c5b99c806e 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -169,7 +169,8 @@ void qemu_net_client_setup(NetClientState *nc,
                            const char *model,
                            const char *name,
                            NetClientDestructor *destructor,
-                           bool is_datapath);
+                           bool is_datapath,
+                           bool do_not_pad);
 NetClientState *qemu_new_net_client(NetClientInfo *info,
                                     NetClientState *peer,
                                     const char *model,
diff --git a/net/net.c b/net/net.c
index d7fa637ce51..1042a9d3a8e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -267,7 +267,8 @@ void qemu_net_client_setup(NetClientState *nc,
                            const char *model,
                            const char *name,
                            NetClientDestructor *destructor,
-                           bool is_datapath)
+                           bool is_datapath,
+                           bool do_not_pad)
 {
     nc->info = info;
     nc->model = g_strdup(model);
@@ -287,6 +288,7 @@ void qemu_net_client_setup(NetClientState *nc,
     nc->incoming_queue = qemu_new_net_queue(qemu_deliver_packet_iov, nc);
     nc->destructor = destructor;
     nc->is_datapath = is_datapath;
+    nc->do_not_pad = do_not_pad;
     QTAILQ_INIT(&nc->filters);
 }
 
@@ -301,7 +303,7 @@ NetClientState *qemu_new_net_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, true);
+                          qemu_net_client_destructor, true, true);
 
     return nc;
 }
@@ -317,7 +319,7 @@ NetClientState *qemu_new_net_control_client(NetClientInfo *info,
 
     nc = g_malloc0(info->size);
     qemu_net_client_setup(nc, info, peer, model, name,
-                          qemu_net_client_destructor, false);
+                          qemu_net_client_destructor, false, true);
 
     return nc;
 }
@@ -344,7 +346,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
 
     for (i = 0; i < queues; i++) {
         qemu_net_client_setup(&nic->ncs[i], info, peers[i], model, name,
-                              NULL, true);
+                              NULL, true, false);
         nic->ncs[i].queue_index = i;
     }
 
diff --git a/net/tap.c b/net/tap.c
index d71e3dd1175..ada69a21021 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -620,7 +620,7 @@ static TAPState *new_tap(NetClientState *peer,
     TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
 
     qemu_net_client_setup(&s->nc, &net_tap_info, peer, model, name,
-                          tap_net_client_destructor, true);
+                          tap_net_client_destructor, true, true);
 
     s->queue_index = queue_index;
 
-- 
2.43.0


