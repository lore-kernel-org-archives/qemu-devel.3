Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEDEC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 10:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtFM-0007Yk-PN; Wed, 20 Mar 2024 06:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFF-0007PW-73
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmtFD-0004Hp-GQ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 06:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710930746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJjqOAFTCPJQwJBApDGw8XyG9n4ZFOpcZP/DpSbnm10=;
 b=A4/nZtkvA+fH2D6nmhUhR8/ZeUUv6sz+msg5FLt8fm54plJCKDxgJ6SXVlVV/JzPc16bjc
 4XGELRezn81FlbDLjfubzI3ASAc6/BU0JMv9P69ckcqmfruYNzvIv8EfISleKlD+vGWiL9
 hZnWHAIxNm5yLF+InV9ySJu8Antn8IA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-SvetAhwMPDycPIb_vnnqcA-1; Wed, 20 Mar 2024 06:32:24 -0400
X-MC-Unique: SvetAhwMPDycPIb_vnnqcA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a46b82df33cso215929666b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 03:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710930742; x=1711535542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJjqOAFTCPJQwJBApDGw8XyG9n4ZFOpcZP/DpSbnm10=;
 b=vJ4DHRDBopJG9DgApuCYzJkEZqb3QKAp79YmqGtU0QcNdyc2ZpT5WZx1CWnKwqp5Ol
 yBcwCGzLlQZ6q3BrOZiF3Y9dQZgQr2XookUtTAM0mMF/qwmlz0p0kk7R8iJ2c0pXUcOz
 Q9b0d0CFqLlpI7wN/o+CfCv+3wKCEt8kXKZ58CqSkUuVUIHXpM9zyXNJpqifzjISd5XS
 bdFOWQCC81ru7wy6jtIVvLPQJVtuqgMTN0sLdbfKx+RZtq5wjMg53sXQTDTX8mi3+f7T
 aQePvEbIvLiCUYPYrS0lfXn8AEbXBKVTbIzxLKpNgM2KkUEju6oLRSbN9/ENUO9FUPW/
 wCAg==
X-Gm-Message-State: AOJu0Yy5awba4mFpjH/4Giv9iiHI3FQPb4R93iGZUfIMXjiChHgT7Wb1
 fgf9F+/MXQJBgVQaiYhl5R+mwDCW36Qfpv3m/nLJMHQmQvY7S2YxFBuyfUENirNPxKIMe9C9F4l
 KWBzFSw0iuc62BMsb88qk8FdZJtnAse2sjjL0DpTxl5mhmYyI5KlksyI+YXoHkPd8L2Hq98PxGU
 JfQL/LHyAD8iDy1bOk5f/q092l7G9HGrmLhvfu
X-Received: by 2002:a17:907:971c:b0:a46:9a9e:f3b0 with SMTP id
 jg28-20020a170907971c00b00a469a9ef3b0mr11742603ejc.67.1710930742645; 
 Wed, 20 Mar 2024 03:32:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaEb0C9fzby7FgomWCCS7qA66uyuh7JtG9q0oEd/uBa++hL9BfNW+/Ka90JNRZGkBNIZfCMQ==
X-Received: by 2002:a17:907:971c:b0:a46:9a9e:f3b0 with SMTP id
 jg28-20020a170907971c00b00a469a9ef3b0mr11742593ejc.67.1710930742275; 
 Wed, 20 Mar 2024 03:32:22 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 ww2-20020a170907084200b00a46cc48ab07sm2843130ejb.221.2024.03.20.03.32.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 03:32:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] vl: do not assert if sev-guest is used together with TCG
Date: Wed, 20 Mar 2024 11:32:10 +0100
Message-ID: <20240320103213.1048405-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320103213.1048405-1-pbonzini@redhat.com>
References: <20240320103213.1048405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/vl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 0c970cf0203..c6442229824 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2676,11 +2676,10 @@ static bool qemu_machine_creation_done(Error **errp)
 
     qdev_machine_creation_done();
 
-    if (machine->cgs) {
-        /*
-         * Verify that Confidential Guest Support has actually been initialized
-         */
-        assert(machine->cgs->ready);
+    if (machine->cgs && !machine->cgs->ready) {
+        error_setg(errp, "accelerator does not support confidential guest %s",
+                   object_get_typename(OBJECT(machine->cgs)));
+        exit(1);
     }
 
     if (foreach_device_config(DEV_GDB, gdbserver_start) < 0) {
-- 
2.44.0


