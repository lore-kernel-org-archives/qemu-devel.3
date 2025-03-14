Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211ADC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt537-0001ez-Ig; Fri, 14 Mar 2025 09:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geofft@ldpreload.com>)
 id 1tt4SU-0002mU-Qc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:48:15 -0400
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geofft@ldpreload.com>)
 id 1tt4SL-00032o-UX
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 08:48:14 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 84EA11140211;
 Fri, 14 Mar 2025 08:47:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
 by phl-compute-08.internal (MEProxy); Fri, 14 Mar 2025 08:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ldpreload.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=2016-12.pbsmtp; t=1741956477; x=1742042877;
 bh=crAiE0KQ/JwLIewHW5QCO2eBX9Tzzjq4SnobfF+5VCo=; b=GaDnoEUPB4j6
 VlbeiD1689bjVX4bQYCge2oh1YvRUQ9RQa2kW0u4W8Fadi450svWM+Zo8HCOet5K
 p8gt3mt0fwF1ZQyRtmKSYLYNyszS6l451bHVKVFO+DTLfCKR9YuHd70fyAgwITI/
 FZQfJEGwOgTrfeoIYRtgAutCR/hCduU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1741956477; x=1742042877; bh=crAiE0KQ/JwLIewHW5QCO2eBX9Tzzjq4Sno
 bfF+5VCo=; b=WAybR/Zj2jrIF1AsKNq3cOioiTe95qr6hQhQigHplIhfikyDotR
 /BpybO/+hxULOJIfnbJ1npEt5SC3ikZYD3NDvGEjo0By2WxUYGtcvaZFyBxM2VmS
 Zz3qR+KqfQ4QVVbaq4C+cS7J3GmXC8OUVGCZt2vWjg2c9Q/lG2HO+gtz0H26dTLC
 tIgN5JdgkRxMs69DoCmrhqkgdaKsUpBGc8PQdBN/CHwKVXnkmqrl/sWNSEqyD6Wb
 btuq2aBsGrK5wgEF41f0kYcot3PU9chxz/lShyPVbR1uipqi6es1BsZibCmzBSka
 UCLeAb+fCWvICwal3Ycydqo1tGvAP9SFhuA==
X-ME-Sender: <xms:fCXUZ0N9FM71h5Qydb6D9zTm2-xbX4XRH21G2yJ_3qs0auWRtxVTlg>
 <xme:fCXUZ6-j_QL1XVTGhOqnVZ5YuwRgv_CdfbGpJe4vvSaryStluiQyImkw3CYloKnoG
 UokTOdxt5ZPltfYSw>
X-ME-Received: <xmr:fCXUZ7RDwsWq2FwNr-XvRf0BFfUpCOMmZYg4bQGJe3JwScDjiM6zsV_AJeBgYtVqmMRifg5Lly4WQMxHmvqyG6tbRS8grGO5SrqrXp2V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtkeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttden
 ucfhrhhomhepifgvohhffhhrvgihucfvhhhomhgrshcuoehgvghofhhftheslhguphhrvg
 hlohgrugdrtghomheqnecuggftrfgrthhtvghrnhepvdefhfegheettefgjeelhefghfel
 ieduudfgkeehtdeitdekteehuddthfefieelnecuffhomhgrihhnpehgihhtlhgrsgdrtg
 homhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
 pehmrghilhhfrhhomhepghgvohhffhhtsehlughprhgvlhhorggurdgtohhmpdhnsggprh
 gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheplhgruhhrvghnthesvhhivhhivg
 hrrdgvuhdprhgtphhtthhopehgvghofhhftheslhguphhrvghlohgrugdrtghomh
X-ME-Proxy: <xmx:fCXUZ8v3XYMSrJk6yebXBqRJnTQAli_yqVyyhBWd5tMpy51m9NfO1w>
 <xmx:fCXUZ8enChHcb2GS5VKag14VNLqk8UrsET27UhjWVXbwGAfxgTkiQg>
 <xmx:fCXUZw3WoJIeRe7vvq2kBO4gGnSH2YklVWoodVc-gTpDFB4GJNk8YA>
 <xmx:fCXUZw9jZPsWEqZ8hl3zOX0-uPTAcG-APoeGHMYCwX_T7tQEV6wZXA>
 <xmx:fSXUZy1Fu8aYeMYbPCyIKdqqAzSHBoOkUjfEXDTICYQbdQiXz2Ti3KES>
Feedback-ID: ia7a14449:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 08:47:56 -0400 (EDT)
From: Geoffrey Thomas <geofft@ldpreload.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Geoffrey Thomas <geofft@ldpreload.com>
Subject: [PATCH 1/1] linux-user: Hold the fd-trans lock across fork
Date: Fri, 14 Mar 2025 08:47:42 -0400
Message-Id: <20250314124742.4965-1-geofft@ldpreload.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=103.168.172.152;
 envelope-from=geofft@ldpreload.com; helo=fhigh-a1-smtp.messagingengine.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 14 Mar 2025 09:25:49 -0400
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

If another thread is holding target_fd_trans_lock during a fork, then the lock
becomes permanently locked in the child and the emulator deadlocks at the next
interaction with the fd-trans table. As with other locks, acquire the lock in
fork_start() and release it in fork_end().

Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Fixes: c093364f4d91 "fd-trans: Fix race condition on reallocation of the translation table."
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2846
Buglink: https://github.com/astral-sh/uv/issues/6105
---
 linux-user/fd-trans.h | 10 ++++++++++
 linux-user/main.c     |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
index 910faaf237..e14f96059c 100644
--- a/linux-user/fd-trans.h
+++ b/linux-user/fd-trans.h
@@ -36,6 +36,16 @@ static inline void fd_trans_init(void)
     qemu_mutex_init(&target_fd_trans_lock);
 }
 
+static inline void fd_trans_prefork(void)
+{
+    qemu_mutex_lock(&target_fd_trans_lock);
+}
+
+static inline void fd_trans_postfork(void)
+{
+    qemu_mutex_unlock(&target_fd_trans_lock);
+}
+
 static inline TargetFdDataFunc fd_trans_target_to_host_data(int fd)
 {
     if (fd < 0) {
diff --git a/linux-user/main.c b/linux-user/main.c
index e2ec5970be..2cd867491b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -149,12 +149,14 @@ void fork_start(void)
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
     gdbserver_fork_start();
+    fd_trans_prefork();
 }
 
 void fork_end(pid_t pid)
 {
     bool child = pid == 0;
 
+    fd_trans_postfork();
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
-- 
2.39.5 (Apple Git-154)


