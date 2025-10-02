Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4444CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 17:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Mw1-0001Jk-5I; Thu, 02 Oct 2025 13:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4Mvm-0001CE-8V
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4MvY-0005tr-Ar
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 13:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759425424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCIypnBTJ7P0E1vJ2ddzLDxhkc/ok8N9/TfPhtZrrjQ=;
 b=JljbVaDGNJzR2WF623S5mb/Owy4zRNUcC33ygaPcesihvnwB+YcXEIVCjbsQFQYNhYglYS
 Yp991jU8V+GK26Gj0SH0E1s7VZRIYUgd60NtY3FT19UsDyJSWCfJzZGq5MPgY2XCl8mC/h
 s6GDDL5RWaYo8v4hgQZiZYAgXO7lu5Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-_dStS86TMqKTmoVtG_NsTg-1; Thu, 02 Oct 2025 13:17:03 -0400
X-MC-Unique: _dStS86TMqKTmoVtG_NsTg-1
X-Mimecast-MFC-AGG-ID: _dStS86TMqKTmoVtG_NsTg_1759425422
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b4544f46392so119496166b.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 10:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759425421; x=1760030221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCIypnBTJ7P0E1vJ2ddzLDxhkc/ok8N9/TfPhtZrrjQ=;
 b=LhqE0XuYzXb0v4cn2DV46zuHihgRpj+g30Uu+MZ6qZThmUFVxE27X5F18hnz8lBop2
 rML4rfY2+kKjcEZ51veGsGUsALn7EVBf4IH8pSxC/7ZktdmES2mNMWpkJl18t8Ykhjfk
 soCB3kARJaBRBVtSa0KpxzUkmSZXsOuudHFM+ywIH1B+ECGP7Rk3k2Y8XmWDHJRS4lB/
 kp4B9EQCe6AyfpQ6PXJMo/vnonOe5Ci21MYUn+gh6AzOztuOx5r+BjdMsVk628GG+XBf
 LKySpEYz58KERhnDnNd0/WlsA6CpAk1z6Hv6z7VqDgJaIWmOwz997jR+xPQuRqml6Wud
 43PA==
X-Gm-Message-State: AOJu0Yx5QymE2pqwUK+WwG6HvjkRIFjlqbR/1jj9KW+EozXphZrg5fIb
 64V/Iga/1bDu2EXhFE69i8dpJmFYderAikilnMW3ALBIp659SE9t/67uO+oHCBN6TWxCuM1eqIr
 jRhk1tS3uUFcDuZZ/1YYAYvflrh7LwED5a/4vCIZpZ5QCf852xD7o9tfN0p9bVR0XgKM+vGeUpe
 mzmRIGvVXjMrDEG1ddl0w8JGl2DrmoPzt8gNOesrEt
X-Gm-Gg: ASbGncs5KaqO344e++tIfgNzOp9RmGpAtJcqkcOoQC/K2p5ZlPDvfU3t9BFHVdCzEE4
 bfQgKJ9kGma2Hbu8RcIaLT/vYOugYmreEH6G6dO242TZPh0IZJ5vpEuXdfbzrDpHle2S1WWem3e
 4K70wfsTaPN0a7PZrApaZVV2FJ1i/VOLxIAstuSKPmiWJwvwCPAf1ghFcnpYamVCItQdAgPxmE9
 pACG2pyyPQWZs1//YZGHUkUOMpEgjft6qN5rR/rIaK9liTkGAP6UVexmpEqPCEVpnRj6gSXQNnU
 cxELBFL90R1IKYoVcw3UeEvXkUoOORgnQ9CAcsMJCsd5L5wujhljerJJlt9o/z5dzmRjZjf1hCk
 +2/mnrdjFbNefbaJY/OwcqYBJIelzqbIIUuNvWtTUmphNaRI0
X-Received: by 2002:a17:906:4fd1:b0:b3d:9c3c:9ab6 with SMTP id
 a640c23a62f3a-b49c20531bbmr23355366b.29.1759425421144; 
 Thu, 02 Oct 2025 10:17:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpY7XUM8SR5e1qXFw/6oaxaEAP7KUtjjNkgbwfTEcQxGl5AS9GINDNmuD5bEZTkD71WSV9FQ==
X-Received: by 2002:a17:906:4fd1:b0:b3d:9c3c:9ab6 with SMTP id
 a640c23a62f3a-b49c20531bbmr23352366b.29.1759425420721; 
 Thu, 02 Oct 2025 10:17:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.91.106])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486a173a5dsm232992166b.85.2025.10.02.10.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:16:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, magnus.kulke@linux.microsoft.com, wei.liu@kernel.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PATCH 27/27] MAINTAINERS: Add maintainers for mshv accelerator
Date: Thu,  2 Oct 2025 19:15:36 +0200
Message-ID: <20251002171536.1460049-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002171536.1460049-1-pbonzini@redhat.com>
References: <20251002171536.1460049-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.451,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Adding Magnus Kulke and Wei Liu to the maintainers file for the
respective folders/files.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-28-magnuskulke@linux.microsoft.com
[Rename "MSHV CPUs" to mention x86. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 406cef88f0c..645344c4faf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -551,6 +551,21 @@ F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 
+MSHV
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: accel/mshv/
+F: include/system/mshv.h
+F: include/hw/hyperv/hvgdk*.h
+F: include/hw/hyperv/hvhdk*.h
+
+X86 MSHV CPUs
+M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+R: Wei Liu <wei.liu@kernel.org>
+S: Supported
+F: target/i386/mshv/
+
 X86 Instruction Emulator
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>
-- 
2.51.0


