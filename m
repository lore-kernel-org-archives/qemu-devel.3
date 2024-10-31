Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5840D767F6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLf-0007PB-1R; Thu, 31 Oct 2024 13:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLd-0007Mo-IF
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLc-0007Ec-3v
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faIyTxbRB6QuJWpBey5wc66gbOje3wGKa0Lss9bWK1k=;
 b=HPnp34HoPIdkAfd9eeUQ2FnBVVJDGWPiQ5n/RJzaQHbvWc96dsdkz4kNmZxtMiuEWXO5Pj
 P/4cJfYjdSd8fTlNf2338UfTt7YP21pQd05pxjgZYlXJIjOeazMQnYr5NIfi9wbgYUuDQH
 1r9H6Tbrf/cbqIhTGmB7sLl7IY4ABpg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-0KYGdkkHNqqURH7mskUASA-1; Thu, 31 Oct 2024 13:52:37 -0400
X-MC-Unique: 0KYGdkkHNqqURH7mskUASA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d45de8bbfso805517f8f.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397156; x=1731001956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faIyTxbRB6QuJWpBey5wc66gbOje3wGKa0Lss9bWK1k=;
 b=ki90BSyR7v6cIE0oXoK6CYJ7QDBHrxZY6nfbtcd8SBI4zxVstnZRccVZ7USoxRly9i
 lL9Mvb59HVDzPG/GJFGmRbSkGq9BsHl63iAtdP0yVpInMEbN+oDZ0fjhn82mFPB1B56u
 T6N3c7dcgrGyjxINjbPM6k5lkEil22/AhCCbf8iobFwF2+9mqoFUnwsFwa8vyYPs0j1X
 93Qid/eNpRnFkx5UGGS4Yfz9QKyNIvJLKvxm5ruIny3RRVbKe0TstoI3xGnNgfwNjcSq
 kzh5NeFZI55cPF1Hs9h+UdR9ZeSlKbGnfwM2/U59e+H4cRXrmxKSD9vpE9Koj5/UW1ZE
 9T/A==
X-Gm-Message-State: AOJu0YyHpgd4lt7hlkg7bZuk/IHaVnPN0Kh1/Hl5zscdcDX0tHRHeBx4
 PqeHw66mulk0cZecYj7Cl6WK1gCYbwwt2l5eTBCz2YidABDTpQDwJGOjANE07Gv1evjzQR8fEYI
 dKhnlRQMkIQ+FdA+y5ngzjGZONhGMbk8vJ5THI8jm9AvKf829I5idBStOx5uCdkxk3qh1tpDpsk
 It1x0h6DIW3sUBccPPukxjPX1DBk2bB+R+M7PoAWc=
X-Received: by 2002:a5d:6da6:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-381c7a6c662mr863630f8f.32.1730397154356; 
 Thu, 31 Oct 2024 10:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyqZ0rl4laehGL6nE4IVNATmjJWqOkdAfwn76DnrWq7l+ulmMb1As3xFiC+0o+DFDd0q3GKA==
X-Received: by 2002:a5d:6da6:0:b0:374:c1c5:43ca with SMTP id
 ffacd0b85a97d-381c7a6c662mr863608f8f.32.1730397153949; 
 Thu, 31 Oct 2024 10:52:33 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7e1bsm2801295f8f.1.2024.10.31.10.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 09/49] accel: remove dead statement and useless assertion
Date: Thu, 31 Oct 2024 18:51:33 +0100
Message-ID: <20241031175214.214455-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

ops is assigned again just below, and the result of the assignment must
be non-NULL.

Originally, the check for NULL was meant to be a check for the existence
of the ops class:

    ops = ACCEL_OPS_CLASS(object_class_by_name(ops_name));
    ...
    g_assert(ops != NULL);

(where the ops assignment begot the one that I am removing); but this is
meaningless now that oc is checked to be non-NULL before ops is assigned
(commit 5141e9a23fc, "accel: abort if we fail to load the accelerator
plugin", 2022-11-06).

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel-system.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index f6c947dd821..61d689935e1 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -73,19 +73,17 @@ void accel_system_init_ops_interfaces(AccelClass *ac)
     g_assert(ac_name != NULL);
 
     ops_name = g_strdup_printf("%s" ACCEL_OPS_SUFFIX, ac_name);
-    ops = ACCEL_OPS_CLASS(module_object_class_by_name(ops_name));
     oc = module_object_class_by_name(ops_name);
     if (!oc) {
         error_report("fatal: could not load module for type '%s'", ops_name);
         exit(1);
     }
     g_free(ops_name);
-    ops = ACCEL_OPS_CLASS(oc);
     /*
      * all accelerators need to define ops, providing at least a mandatory
      * non-NULL create_vcpu_thread operation.
      */
-    g_assert(ops != NULL);
+    ops = ACCEL_OPS_CLASS(oc);
     if (ops->ops_init) {
         ops->ops_init(ops);
     }
-- 
2.47.0


