Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E3EEDF15A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrFWb-0005W7-1a; Sat, 14 Feb 2026 08:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWW-0005U7-PD
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWU-0007v5-9J
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:24 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4376c0bffc1so1305886f8f.0
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771075040; x=1771679840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMv+L0cpevCd1h8t6bpXrKu22mF1AowIc+cuUvHrjXM=;
 b=cBhAP0ib91NMtUO1ZG3VQdb4buD3TpwkXdjxQwSHzNF5PmO6/0iAaUcCDa469eoPhp
 +x5Zp82LcPqBD+Ju+ab+tCV/nOJtaEo0pEs9XiBh0XZkOoFw09ylvV3XLEyRFIFCuw5Y
 140wJn/0Pb0+8AKQSqOoHT24/zXw171+1fUYlqA/sclX9EFpiNo4KFdDEy6JFR1MXjWn
 H9GMouagdY0lZeCCeGBK2dar7Vl+0256rsAufaDzbaBDU5aZHluy/am7bzupCLYb0SsL
 6nFNchtSDTIPugvmUz2+37D/jZA68mlcEf3Vv70cgL1dQpC4r9tnRUaimSOmIxYI/1Gg
 EVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771075040; x=1771679840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yMv+L0cpevCd1h8t6bpXrKu22mF1AowIc+cuUvHrjXM=;
 b=ZIK64/OPhQvinI8G4JgqB/qVdxEYTqh+F3QNkEUfwBycZRGGg4zEZoq/1DJPaK/KvB
 weuvmu+h1vdY9LTqNEQAXIYMrmvonYdKbdAB1+faDi52qIQQ1XL3NBd7HkRdn113vayX
 gGagZv0e1A+QlRiRXgylRXrbUYwc9w+44Z2WQ2uxYEcAwNIkRQtJ5qs+PuZXiiB4lz+I
 AF/fRJEtxd3BdbVb2l/wsaHeYyfkilIE23Yk9ha2/1DANtztqI2De98aGTRuoMpc8c/O
 xCD1QgPHb5Op/cMQyJ6ADhXk31Siwf+chff8oU6XFT355cmuOHQJy691mgC44nk9Gr1X
 HTzQ==
X-Gm-Message-State: AOJu0YxbqGkfEh1IgTMZ52CNR0893AGWhRzrFrHKsWJ8CXoQ/ePsRNbO
 3Ap9i4djSpNnek9yWRJFTTt27s94UVtLO3DXVUCcZia5apq4cjeFdu/524UJcw==
X-Gm-Gg: AZuq6aLW0SGB8YB9AjbqmPTWrTZUUTyh6Atgvkj80fPxRtlUucYbFoTd6FiChWRDHli
 bHTG4DCIvT3JictkGiIY5g/BUQ1Vmnhxdks9Azxu9A2EL+uJi9FQ2tm8NSsl4qoa54AiXnXU4ES
 CVz6w0FMm/czHQcQxeGJuHRXAE16tY5bf9V0WoInvv/YeWXKAcvJs6JD7Hd/S7DUYlEJYV6ZYZo
 nnYsC/ejxLaaOx6HXy5AUWs2Dj7I4trctKjtirRwCWGJN4EpAEj/gHFbkylA6Yq+9O1c0MxPh1V
 f0WcvZjyiii1LGvXAR57AuqlhHNgsCItBGkukA4MXI/FVFqgFLAM4ZB7wo+3ARNV+qQTj98h/+o
 KTyxwAVjIRIa3/jKL83Jk8uQpjqy6R7v9qM/s82Hkqs8YXdMxK82oe77Dr1qC9ngzt9npy5tFxi
 5TaUM5owj22CRqUHOUc6OY5d67j81ZOOj4InqVIJ50VPX4KIl3iLaesxQGQvb8GfsPVsPWUU6DS
 5u09cmFaziylSaB
X-Received: by 2002:a5d:5d06:0:b0:437:6f0c:2ed with SMTP id
 ffacd0b85a97d-4379790f0a9mr9220903f8f.34.1771075039750; 
 Sat, 14 Feb 2026 05:17:19 -0800 (PST)
Received: from archlinux (dynamic-092-224-176-164.92.224.pool.telefonica.de.
 [92.224.176.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm13340471f8f.27.2026.02.14.05.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 05:17:19 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/3] target/i386/hvf/x86_mmu: Fix compiler warning
Date: Sat, 14 Feb 2026 14:16:58 +0100
Message-ID: <20260214131659.31378-3-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214131659.31378-1-shentey@gmail.com>
References: <20260214131659.31378-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When reusing the code in WHPX, GCC emits the following warning when compiling
for i386-softmmu under MSYS2:

  In file included from ../src/target/i386/emulate/x86_mmu.c:20:
  ../src/target/i386/emulate/x86_mmu.c: In function 'vmx_write_mem':
  ../src/target/i386/emulate/x86_mmu.c:251:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'target_ulong' {aka 'unsigned int'} [-Werror=format=]
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~            ~~~
        |                                                                       |
        |                                                                       target_ulong {aka unsigned int}
  ../src/target/i386/emulate/panic.h:34:12: note: in definition of macro 'VM_PANIC_EX'
     34 |     printf(__VA_ARGS__); \
        |            ^~~~~~~~~~~
  ../src/target/i386/emulate/x86_mmu.c:251:48: note: format string is defined here
    251 |             VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
        |                                             ~~~^
        |                                                |
        |                                                long long unsigned int
        |                                             %x

Fix the warning by reusing the target-specific macro TARGET_FMT_lx which exists
for this exact purpose.

Fixes: c97d6d2cdf97 ("i386: hvf: add code base from Google's QEMU repository")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 target/i386/hvf/x86_mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index afc5c17d5d..fe44d2edf4 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -244,7 +244,8 @@ void vmx_write_mem(CPUState *cpu, target_ulong gva, void *data, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         } else {
             address_space_write(&address_space_memory, gpa,
                                 MEMTXATTRS_UNSPECIFIED, data, copy);
@@ -265,7 +266,8 @@ void vmx_read_mem(CPUState *cpu, void *data, target_ulong gva, int bytes)
         int copy = MIN(bytes, 0x1000 - (gva & 0xfff));
 
         if (!mmu_gva_to_gpa(cpu, gva, &gpa)) {
-            VM_PANIC_EX("%s: mmu_gva_to_gpa %llx failed\n", __func__, gva);
+            VM_PANIC_EX("%s: mmu_gva_to_gpa " TARGET_FMT_lx " failed\n",
+                        __func__, gva);
         }
         address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
                            data, copy);
-- 
2.53.0


