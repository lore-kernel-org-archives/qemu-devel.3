Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB8DD5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9ka9-0003at-Am; Sat, 09 Nov 2024 07:28:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9ka6-0003UD-Jk
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:28:47 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t9ka4-0006iM-KV
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 07:28:46 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e3fce4a60so2482019b3a.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 04:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731155322; x=1731760122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/Xd3MjqDy6TrIBg3CF4tuMJtDc1Wc3hbHGKVOlCUTY=;
 b=BBEoPnbIkP8ao7EMCKCiCKP3qEfk2RSvWCcq8M4ce0No0zuAHi9Vw5fCK+ThvRo9dD
 eMEqD82QI85S5iLPl6pTLK3htJ+ukKRERln09uR2z9hbr+lFU9gv+CHL8rxWYav/A4Vg
 UhZdo02OFW3lVRMUtCsJ7m3EBFR4P7Jj/AkHjsO22o+7sbKDiVCMM7bw+8zgXF9q9ZEd
 ZX10ItVvWxMH5WYAZXwsXmAAaMyCoVHshEatlx+bQ73vSZ4g3qN/u2RKAXjOEXZUzYnO
 FxMQqbCH8gmb0ogqah+z9Dr7FmuDAwxRIAnCDXO29Bh8NqhRKuSV6OaLQuoT3zdZcc7w
 n2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731155322; x=1731760122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/Xd3MjqDy6TrIBg3CF4tuMJtDc1Wc3hbHGKVOlCUTY=;
 b=QevY5KimmHyguYGK+vXXPqlbWIYHidmvn52OpAnGpBFfosNekxAmQekpGJiVQDlNjP
 qk7Qrmthqml5EetZMnYwjhSFJtySQaH5YHFWpBPvBpasILYHVpVZBiw7c1788EsAl7BG
 sBOAM2oyACBT/aIIUI1aZI42Z2bSHxhFd96VonaaD+H3mLlB/UW5LRbb7OVtT6Sap6nC
 coGR6d6Xs0tFOp9vi8D3k6Ww7jSMnksSNRDSQBc+njnsvFVQ+1c06RrkTlql8VzMh9Dc
 1zEXLGjU1GDM35E5Fo8g4nTlM9eWVAyKd4b8jI8awdigTLP1GJZOUwxd1OUZdzJ0A+i0
 USCQ==
X-Gm-Message-State: AOJu0Yz0/Aq8iLA/t2//D3nrLgtq+2QB8OB0KzUbTqYLQmeezdcxDj+j
 es8iynu62/ZvWf2zMQQkx1bY75PK/zbArJ6g8QZ7lfCErjTmIb7dZVd7rg==
X-Google-Smtp-Source: AGHT+IHpQMmBYq048oy+BYv8SqSPeDRKTrdeBDFnRfUuDi8Sn7gzA+YxoHllfb0myqRVeGg5uN1qkg==
X-Received: by 2002:a05:6a20:a11a:b0:1dc:e8d:950b with SMTP id
 adf61e73a8af0-1dc22b9559amr8684169637.41.1731155322399; 
 Sat, 09 Nov 2024 04:28:42 -0800 (PST)
Received: from localhost.localdomain ([103.103.35.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240785fbe9sm5506332b3a.37.2024.11.09.04.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 04:28:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: qemu-devel@nongnu.org
Cc: graf@amazon.com,
	pbonzini@redhat.com
Subject: [PATCH] docs/nitro-enclave: Fix terminal commands formatting
Date: Sat,  9 Nov 2024 18:28:44 +0600
Message-Id: <20241109122844.24057-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=dorjoychy111@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 docs/system/i386/nitro-enclave.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
index 73e3edefe5..48eda5bd9e 100644
--- a/docs/system/i386/nitro-enclave.rst
+++ b/docs/system/i386/nitro-enclave.rst
@@ -48,13 +48,13 @@ Running a nitro-enclave VM
 First, run `vhost-device-vsock`__ (or a similar tool that supports vhost-user-vsock).
 The forward-cid option below with value 1 forwards all connections from the enclave
 VM to the host machine and the forward-listen (port numbers separated by '+') is used
-for forwarding connections from the host machine to the enclave VM.
-
-__ https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
+for forwarding connections from the host machine to the enclave VM::
 
   $ vhost-device-vsock \
      --vm guest-cid=4,forward-cid=1,forward-listen=9001+9002,socket=/tmp/vhost4.socket
 
+__ https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#using-the-vsock-backend
+
 Now run the necessary applications on the host machine so that the nitro-enclave VM
 applications' vsock communication works. For example, the nitro-enclave VM's init
 process connects to CID 3 and sends a single byte hello heartbeat (0xB7) to let the
@@ -65,7 +65,7 @@ the applications on the host machine that would typically be running in the pare
 VM for successful communication with the enclave VM.
 
 Then run the nitro-enclave VM using the following command where ``hello.eif`` is
-an EIF file you would use to spawn a real AWS nitro enclave virtual machine:
+an EIF file you would use to spawn a real AWS nitro enclave virtual machine::
 
   $ qemu-system-x86_64 -M nitro-enclave,vsock=c,id=hello-world \
      -kernel hello-world.eif -nographic -m 4G --enable-kvm -cpu host \
-- 
2.39.5


