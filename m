Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7953ACC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEdw-0003ov-9U; Thu, 15 Oct 2026 02:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <35G3QagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xHEdt-0003nx-W4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:42 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <35G3QagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com>)
 id 1xHEds-0004IX-2A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:08:41 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-892ccb01fbfso1407254b3a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792044517; x=1792649317; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uKb19g4DzVC5AyiW+jAUzHc0YHfMiCGmcIQ3sZq866k=;
 b=DdKu5CQe+gszE89bPSYLxTmDKyAnRi/LO0arDcnN7ClGKX7heJJ9QiGfWTjGqP2GxH
 sYTHTI6t9vNCaNX5u999GOQP7xDax/bWYU6r+3QD4TbhMk+b7i/8L6JlOpwrwp3I+Lhr
 uyqKiIvek1FfFYhsHijh4Lex2vB8ajz8PElXyDF9mkOn3u5iYpkGQ15DQKuwRQ5IjNkT
 pvStdjeHaU7IIBzmpT/6VUjk7SKHjj8jNeyYMbMRtphkvK/zyvuzH/G/SGCiES1/vAdh
 GqTg7I7b6ekN+liF2/u8ycp/5jGE4cZFv2i6jZ8MJbRCLUnM07JMDbMsBReDqwnPm7Y4
 YSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792044517; x=1792649317;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uKb19g4DzVC5AyiW+jAUzHc0YHfMiCGmcIQ3sZq866k=;
 b=ymFx8iHlFY5TvH6Z5VZ/f+FJqw0fpHdkj2AWKSXOs7mlTF5vtKtrxCg58gHbDK2Pfh
 LqkQBRWyoEO45GdDBOSIuJ9wSTEFtaHTl2id1jJpPlmdIm+P1Ywp1yt5DeoQp4I0JmZn
 FlW6DNXbvOXxEMK7EuUuo/uHKqVnENBsToYmDvkRqYjLABaA6eiL6OROqytEPwD0Mbss
 Y/iqap3XQoCwxcmwcyiz7iYsvFss3T9pkboEUi/AysvU0vcv9mN7ZHNb7r32B0t+yEHH
 Ek3vW31eNzmycqy+RtWTwC0B7X+ySzph6kjRvXavgNpYo5NW/xPPiIn7cc0hTZEigFIb
 E1Mg==
X-Gm-Message-State: AFq9FYK8ZuTRWcWLXCxTitv716+zIyfVTywKGGKyOU6x6rtZPvo/qK80
 vD1VS4RNzZWEeYYZwQp+5y7+yOIBnKN9gZeT0ejOtUG+4nWfJcUpDYi69OTWWTdSPWgthf1KlYA
 6NMee5P718HosR1Zgxu+LaQ==
X-Received: from pfeu12-n2.prod.google.com
 ([2002:a05:6a00:c0cc:20b0:88b:3c2:d0a6])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:951a:b0:87c:9094:b72d with SMTP id
 d2e1a72fcca58-897c3ff4d75mr14866835b3a.6.1792044516810; 
 Wed, 14 Oct 2026 23:08:36 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:08:23 +0800
In-Reply-To: <20261015060827.341298-1-stanleyjhu@google.com>
Mime-Version: 1.0
References: <20261015060827.341298-1-stanleyjhu@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015060827.341298-5-stanleyjhu@google.com>
Subject: [PATCH 4/8] docs/system/ufs: Update task management request support
 status
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=35G3QagoKCl8PQ7KIBVGERDLLDIB.9LJNBJR-ABSBIKLKDKR.LOD@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x447.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The task management request (TMR) handling implemented for UFS supports
QUERY TASK and ABORT TASK, while other task management functions return
TASK MANAGEMENT FUNCTION NOT SUPPORTED. Update the documentation in
ufs.rst to reflect the current implementation by removing the outdated
note under nutmrs and updating the Limitations section accordingly.

Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
---
 docs/system/devices/ufs.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index d3482e9299..7e1fa671ab 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -51,7 +51,6 @@ Host Controller Properties
 
 ``nutmrs`` (default 8, maximum 8)
   Number of UTP task management request slots advertised to the guest.
-  Task management requests are not processed yet (see Limitations).
 
 ``mcq`` (default off)
   Advertise Multi-Circular Queue (MCQ) support. When off, the guest
@@ -81,8 +80,10 @@ Limitations
   link startup, DME attribute access and hibernation are handled; DME
   reads return fixed values, and DME writes, power mode changes and
   hibernation do not change any link state.
-* UTP task management requests are not processed, so a guest that
-  tries to abort a command or reset a logical unit gets no completion.
+* Only the ``QUERY TASK`` and ``ABORT TASK`` UTP task management
+  requests are supported; other task management functions such as
+  ``LOGICAL UNIT RESET`` return ``TASK MANAGEMENT FUNCTION NOT
+  SUPPORTED``.
 * The Boot and RPMB well-known logical units only answer basic SCSI
   commands such as INQUIRY; boot and RPMB data access are not emulated.
 * The device cannot be migrated.
-- 
2.56.0.385.gd3acb90ef8-goog


