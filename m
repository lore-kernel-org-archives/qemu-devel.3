Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29960D262B7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 06:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viRud-0002SK-Me; Wed, 21 Jan 2026 01:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuJ-0000X9-VP
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:35 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1viRuI-00014i-Eq
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 01:41:35 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81e98a1f55eso3238025b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768977693; x=1769582493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7ToVCVVt9MHrVLkeewU0iI5OHV+43ugFcP+j037DZE=;
 b=N8mRmtqUOekmiQH15WdehGmvJCWNO0wXgR3DvZRZ08A/dHctUXlAZOqhSMIfuOQ+wX
 Dbcg6Vjs4+ijhTqFz3dXH5d0HPFJAQ4zNNkCqO0K7DjHCkDKGa0vnz6g+rQWcI7Jmjll
 40HLjP0ObPYZwApOislLxUTDBnHI+jzR1Fqq7U9/ykdS+cEtr8MtdzltM0dTWICxRGy6
 AE6+CqkkjXhXI5k49yTsemEgdSp+Sm8T2+bKBQsELeppapsmg9CUs8vMXiUzdOtfZ9oC
 Cqelv7+KIzWqLhQHUwZ73UT3a/XsTike1Ftje7CbdLTaiw6xNYnBQ3XDtzkIBrDsQK5q
 8luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768977693; x=1769582493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7ToVCVVt9MHrVLkeewU0iI5OHV+43ugFcP+j037DZE=;
 b=xRhReH+b01Y4egcX0HOVh8efkgZFNTELbWlH597qKRyhsXLPrDJId3eoztSVpbJQd4
 IX5uTvFUKKK1/yWvL2wVR5dEeVDwxVyg/jB57UMbQWSwy0uWX2N/E2u4X5H8r+6Q7BMx
 ROSb+6+BU1Jnz4lViN9mKMAAZBH/OMOGNJyPRX3rz9venA02dzni1wruQzmHzw4hVwCE
 zBXq6okWOQLwFp9z3SUta9CDyjgO54upQ15tM/whkBcn0plj6u0X+WZ/z73gf4Qf5QR8
 n8PMiaGB1d1VUSc4GJE/jf53fH67qZ7VkYtTOuS6yx4DlHXuXuJ+2nsOQEHxCHHEvFk2
 1kRA==
X-Gm-Message-State: AOJu0YyNsbDSho0P6ziZw/U2cppHV4AFH5bhkw38RXXyCuFcCO/2IIJE
 i3MHZm9ZGQ+oPJRFCbczVKRcr/FPEAgYUBZojZaGEeuIAuswUpvUbdV+oqtp+3pi
X-Gm-Gg: AZuq6aIXwZps41XaaMJOC7PKET8jU1+rEwxmKaBXl1c/DX2ccyaH1bByrD/JNNuNPG4
 8PYq+xeVwy2CnR/ORJfd5vPTnzyReYANJIRhrkn1KsRoGNFYxDm6a1x99eXyE2+/OibwvMH46Mq
 aviwK+1l14XWdDV93KDfrt7hT35dBxw8GfuW6jLzBJVIGJ+XpnYEIOEvd5TL0iHU/TQovpbSsnc
 RKz8Mlbc10GJYKDnkvB/pEsm7oUy+XgCZjhHCX0Eon92cbO9TaXeIR5n5iKTUzvZDuYC7CpQHVw
 Nl/LKcfKl0c9drUvLgKO7LUVBpDoB51d2sqLIiqetp7C01gctKXiIEhoPz72teLiwsL80/d2eHK
 fu2XVl3y7TaDmVwNP8la5jSa1JoAMOFmqp/E7PiGipQQiTANMMhPmMFCEnHOV29dk8XUfZ8SOg3
 SWoHqJO5O3vk/aLYA=
X-Received: by 2002:a05:6a00:a14:b0:81f:5a3a:c91a with SMTP id
 d2e1a72fcca58-81fa185efc6mr13390827b3a.46.1768977692556; 
 Tue, 20 Jan 2026 22:41:32 -0800 (PST)
Received: from localhost.localdomain ([180.87.170.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b3165sm13876714b3a.60.2026.01.20.22.41.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 22:41:32 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V2 4/4] qemu-options: Introduce new flag for iothread
Date: Wed, 21 Jan 2026 14:41:10 +0800
Message-ID: <20260121064110.28760-4-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121064110.28760-1-zhangckid@gmail.com>
References: <20260121064110.28760-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x42d.google.com
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

This demand comes from Cloud Native ecosystem.
User want to manage resources more flexible like containers (Kata container).
The real workload maybe changed(runc) in the VM without VM reboot,
It may need hotplug/unplug different multi disks with multi iothreads to meet
high level scheduler's needs(like K8s).

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qemu-options.hx | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ec92723f10..9afe9d4ebb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6352,7 +6352,7 @@ SRST
 
             CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
 
-    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
+    ``-object iothread,id=id,attached=attached,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
         Creates a dedicated event loop thread that devices can be
         assigned to. This is known as an IOThread. By default device
         emulation happens in vCPU threads or the main event loop thread.
@@ -6376,6 +6376,13 @@ SRST
         for many cases but can be adjusted based on knowledge of the
         workload and/or host device latency.
 
+        The ``attached`` parameter is a flag to show whether the iothread
+        is attached to an actual device(for example virtio-blk). In hotplug
+        scenario, user can add multiple "-object iothread" and multiple
+        devices (like virtio-blk). When user hotunplug the devices can keep
+        the iothreads as a thread pool, following the new hotplug devices can
+        attach to the released iothread.
+
         The ``poll-max-ns`` parameter is the maximum number of
         nanoseconds to busy wait for events. Polling can be disabled by
         setting this value to 0.
-- 
2.49.0


