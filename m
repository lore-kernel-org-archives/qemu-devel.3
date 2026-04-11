Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EADF3ED54
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 14:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBZKB-0007BK-BC; Sat, 11 Apr 2026 10:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3-K3ZaQkKChE0v358vz8rx55x2v.t537v3B-uvCv2454x4B.58x@flex--jemoreira.bounces.google.com>)
 id 1wBNpU-0006mR-OD
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 22:12:12 -0400
Received: from mail-dl1-x124a.google.com ([2607:f8b0:4864:20::124a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3-K3ZaQkKChE0v358vz8rx55x2v.t537v3B-uvCv2454x4B.58x@flex--jemoreira.bounces.google.com>)
 id 1wBNpT-0003vv-1w
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 22:12:12 -0400
Received: by mail-dl1-x124a.google.com with SMTP id
 a92af1059eb24-12711ec96fbso5928591c88.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775873529; x=1776478329; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RUi25tL6VRbh424glOaREy1evXPETqqAzqCwfi2sKiE=;
 b=QAgES7L/8uOsA6P4cxfZUEj6OuEEomqPni2FjrNbqX5WCbJNx+tYSnmm4LeD4GVfHK
 iskkmik6mvpIFSZ0KJGYexVP6+ykksZBh29wGrAGdPOmUZGsXJDCvsAamaaJmDyrdojR
 GGzgiUcyxgUQDL/iYmT6KIf8tbl4pVvTUyML7D0txGQREYH1yH64hfEbiWtrhW73J/dW
 6Mk8hBTiHv69hgcTIwshA/ru6Ovd8yyoL3AG6Xql7Cd+duagFSJ5isvouKYAcgZZkQdD
 3Uh1gJ6EXuVMqak2dkOfBG3/jw8ASm9fX34knkWT3IAX80PsxlqDSHw7ishAzxDn3xh2
 QzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775873529; x=1776478329;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RUi25tL6VRbh424glOaREy1evXPETqqAzqCwfi2sKiE=;
 b=gCXQzuNmgiEfiQJvUbKvs1QR5e+iuxzZLKDC8g8x3JIpOae/9pstkmcQd4mOmsiQ62
 3LUdtE5CFQ9gqs9KzDdV1xrXEtMz5SMPhB7lv1QU1TdCg6YMHY40lbRnwpqRNBZARvea
 9gglnstN+Ls4JCHSEjF6n5D8oR7vreJaj1RmaJd0R9L3T8SQ3NdKIlm399KrtsBcxUeI
 7kxSVA67AiiXx9jVwcR4U+8oefXseeI0jAodHrNx2Tk2zkH/nOOmQ3Cnta6bgJKn7OOq
 VrZ0z26B0G9XuxNFkByRZmXc00ZQ+M4bCJLJtBcosqEh7euVMYQ5sOJbdjCux83LZJE2
 ppGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGXX6bLezs8tnQkCAoD/1Te9Audp+qZM+1iAUucfSLfQyiXUxVN8zdYxaKda3vvmZnqnnXKnJHHQJf@nongnu.org
X-Gm-Message-State: AOJu0Ywrn6+3Kr2FTWvtrjvmnys2lYXH+NLTR2iPm2Q/UUybXIjqQGIz
 Ci+Pol4hVRm73AgOsvYqKlIqcgsovhYq/+Kisx8Xlh2wu47tQrVzQ+H2bHmruQ7u/HWYt4DFZG4
 5oyekBMl/lhbA+EmXYA==
X-Received: from dlea18-n2.prod.google.com
 ([2002:a05:701b:4212:20b0:128:ed1b:481d])
 (user=jemoreira job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6299:b0:127:1492:e370 with SMTP id
 a92af1059eb24-12c34e92fc6mr3404027c88.5.1775873528758; 
 Fri, 10 Apr 2026 19:12:08 -0700 (PDT)
Date: Fri, 10 Apr 2026 19:12:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411021205.3592118-1-jemoreira@google.com>
Subject: [PATCH] vhost-user.rst: Explicitly allow front-end to write to kick
 FDs
From: "Jorge E. Moreira" <jemoreira@google.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Hanna Czenczek <xanclic@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 "Jorge E. Moreira" <jemoreira@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::124a;
 envelope-from=3-K3ZaQkKChE0v358vz8rx55x2v.t537v3B-uvCv2454x4B.58x@flex--jemoreira.bounces.google.com;
 helo=mail-dl1-x124a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Apr 2026 10:28:37 -0400
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

Migration of back-end state happens while the device is suspended (i.e
all vrings are stopped). To resume normal operation on the destination,
the vrings need to be started again with a kick (either a write on the
FD or the VHOST_USER_VRING_KICK in-band message if negotiated). While
these notifications are typically sent by the driver, it has no reason
to send them in the destination if it already sent them in the source as
the driver is unaware that a migration took place. Therefore it should
be the responsibility of the vhost-user front-end to ensure these vrings
are started. This is particularly necessary for queues where data only
flows from device to driver, such as those used by the vsock and input
devices.

This behavior is already used by some qemu vhost-user front-ends (e.g
vhost-user-blk) and by front-ends implemented on other VMMs(e.g CrosVm).
Adding it to the vhost-user documentation makes it explicit that this
strategy is permitted and suggest it to vhost-user front-end authors.
Explicitly documenting it is necessary because vring kicks appear
designed to originate in the driver, so having some originate in the
front-end can be counterintuitive and cause developers to waste time
looking for other alternatives or face pushback during code review.

Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
---
 docs/interop/vhost-user.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 137c9f3669..ad5aba3430 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -656,7 +656,10 @@ destination, following the usual protocol for establishing a connection
 to a vhost-user back-end: This includes, for example, setting up memory
 mappings and kick and call FDs as necessary, negotiating protocol
 features, or setting the initial vring base indices (to the same value
-as on the source side, so that operation can resume).
+as on the source side, so that operation can resume). The vhost-user front-end
+may also write to the kick FDs of vrings containing unused buffers or send
+``VHOST_USER_VRING_KICK`` if negotiated to start those vrings in the destination
+since the driver likely already kicked them in the source and won't do it again.
 
 Both on the source and on the destination side, after the respective
 front-end has seen all data transferred (when the transfer FD has been
-- 
2.53.0.1213.gd9a14994de-goog


