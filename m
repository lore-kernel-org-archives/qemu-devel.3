Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50EFEE0ADF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 12:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voh8S-00078q-0U; Sat, 07 Feb 2026 07:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8L-00077H-KM
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:56 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1voh8I-0002sD-S3
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 07:09:52 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c65822dead7so623327a12.3
 for <qemu-devel@nongnu.org>; Sat, 07 Feb 2026 04:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770466189; x=1771070989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4M2Nh1IUiw+FQ6WAOCON1M0zDU5UgL7i/MkIz5UbV4=;
 b=fAh9IUo6obh4peqbeE652PFvNnceDaL2872VPsRWyO9Vy2/8TJPWt/HqAF8n9F12uo
 e4e7ZosfXKLkADHceonW+e1I5YcGSlIuAWRBDZFzK+IaYTIjhaYzjAZsLugmsqpXCe4f
 r4M4DsW0YcsmieMD5Q4X6Xsco34hhkGMBImY4wUH5GKQDvoCzAoo4V6S1yIFPMA6ZR4H
 WIlVw16nYh5CSr/zTlprJmGNk7HDj0I6FGy7WD187v1d0oJjK78Jg5s5K20zT4c6QzPp
 48mYmfYVHsHdDIkdetrd6ifMD1AtTQj97dufW5AqwNJ9kLIm57K/TzPy06Kq9Si+IWmE
 LuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770466189; x=1771070989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e4M2Nh1IUiw+FQ6WAOCON1M0zDU5UgL7i/MkIz5UbV4=;
 b=OnGUKON16ULZTA3y0W+4Raygtnm7CUzM3svL7d0xfTjQYPddKwmX/f8GnNWYiQd81V
 4MF7KcMNFBvwqA0UCITUkbg6lKAR1s6+9HMkGqFWlJS/zmuzCvD6P5DmmQvPeW0SzMGL
 l4kwXmidHy0OfsRvbTdIGtAvaizQ3ltK3N4XOK+SGydI/SNmD1AxiApYSFIIDoYI4+Md
 lBw0P0wgr0PWzxXDFoqUW+WFW+NPy2j/SXIsekW1HLfiu7nVPdMk2w5ubfPuA/pxcw8r
 8DssLZON8GfdHDRrpVUiFYpWEF0zdNu99hYIlDbH90QItRIM8EHEqXPmovdR6io20WQT
 7xog==
X-Gm-Message-State: AOJu0YyNNZrp8F+VVkgSgUKW3MSSPu0ZwGY44TXJvew+7cJY/nBW9kfN
 FeIDi19zdM0We0HacB2RQaXaERF3xdCn98Uu2H0mNSWgSlmmCDbEQSGb
X-Gm-Gg: AZuq6aJHo9Pr0KcJA/qLvowXk5dcvoiVbIsfcLj85eFQJutVs/VdpZ+a0QF95TkPIoe
 qJMCGQ+mIuq4jCARdUPu0HqtoQvQDZCMK8obHrFBkDF37gWZxM9qIxLeclvaeLd8FujAksHF32L
 DDwUcdXXkwtRCWk1xU4D8v9NPilMCDTa8z6mcoaatMT8coyBlRJrGo2Z3clDABlUR0by74Bx7QY
 vfZMPHycONwkuFSAKRPvN8Njbq1Kk3CgfA7e19K1Xx5YOTi2R9/yjTL9ZL/KxVfiPDM38oolFbu
 dvRZxN5pn9YBV45XiADeNjyDr0BoEIxIT+OQsay4owFpNMPFNDfrRB1H/w/dvZ+KkVXqmty3CBV
 p9YlKWXrvahbwZ9u6zQhXcVZtZmBbyHATwUHivMAtlAlrW1Nj65ZpJNDAlZTBgJj0MEZlar21cL
 C1HvMZ2AGKvevdd7FN1cN3rp5osNM2OyxPYYG++Mf2FS9GUfQ=
X-Received: by 2002:a17:90a:d40e:b0:354:ad98:7d1c with SMTP id
 98e67ed59e1d1-354b3c80c20mr5315324a91.11.1770466189298; 
 Sat, 07 Feb 2026 04:09:49 -0800 (PST)
Received: from brian.. (n058152022104.netvigator.com. [58.152.22.104])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b30f899csm2178530a91.3.2026.02.07.04.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 04:09:49 -0800 (PST)
From: Brian Song <hibriansong@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hibriansong@gmail.com, hreitz@redhat.com,
 kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 stefanha@redhat.com, fam@euphon.net, bernd@bsbernd.com
Subject: [Patch v4 1/7] aio-posix: enable 128-byte SQEs
Date: Sat,  7 Feb 2026 20:08:55 +0800
Message-ID: <20260207120901.17222-2-hibriansong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260207120901.17222-1-hibriansong@gmail.com>
References: <20260207120901.17222-1-hibriansong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=hibriansong@gmail.com; helo=mail-pg1-x52b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch enables the IORING_SETUP_SQE128 flag during io_uring
initialization to support the FUSE protocol requirements.

The FUSE-over-io_uring implementation embeds a protocol-specific
structure directly into the Submission Queue Entry (SQE)
to pass metadata such as the queue ID and commit ID.

Enabling SQE128 expands the SQE size to 128 bytes, providing 80 bytes
of available command space. This ensures sufficient room for the FUSE
headers and future protocol extensions.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Brian Song <hibriansong@gmail.com>
---
 util/fdmon-io_uring.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index d2433d1d99..e6efc8d8f7 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -452,10 +452,15 @@ static const FDMonOps fdmon_io_uring_ops = {
 void fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 {
     int ret;
+    int flags;

     ctx->io_uring_fd_tag = NULL;

-    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring, 0);
+    /* Needed by FUSE-over-io_uring */
+    flags = IORING_SETUP_SQE128;
+
+    ret = io_uring_queue_init(FDMON_IO_URING_ENTRIES,
+                              &ctx->fdmon_io_uring, flags);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Failed to initialize io_uring");
         return;
--
2.43.0


