Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A275DC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFGu-0003cG-Nt; Fri, 11 Jul 2025 11:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaF4s-0000jh-Np
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:50:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaF4q-0005sx-5M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 10:50:18 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so19546425e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 07:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752245414; x=1752850214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1KZCFRmN7FgHfkfFmu6Isb/O1Hh0dI5FA6SQ72r7jdA=;
 b=yEN0wtPqlHFJfF/l11sS5zVTMbTZNa4ndDMTxBgDs2Qh7sxA2TLhwJk6SEzISlKVb3
 lbz2rPOmBkuBTuuZrkGrQoZsnTcQn6wv+23FdJRtmKJoejTK469AtKqkJL6mm3SCkybh
 qxyrkU4Jk0MAc1fR6y7lvbfuRZpF/bnCTXz3OuR5yKI1tWFPbfrGowfpDzOwSjYEd+w/
 R7yKZepvvK5/ghNBrAaHKqw1cBSPsF7NeAUbJwf3k1mkXPCdWAclTuSaYG9MHmNPG5a0
 rvDjKD5RJQqa8KIFtAl4jpRiYyJ9JjlTNinUwbwMOIg0Featwiqp04Im0C41+4QkMFqg
 PRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752245414; x=1752850214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KZCFRmN7FgHfkfFmu6Isb/O1Hh0dI5FA6SQ72r7jdA=;
 b=HXbsPa5GrCVGhoFJveXlUrswtAQXqyjwKaAHGp4KNag7SEc4rlrl+saCB2tLoYlYjR
 Y4u1soVkxDsM2Wn18ingG19d/iGl3POiD0b2MCKUK0eCJLPi+gYzg22sGAmYWo9V1EmB
 /t3RhxeK/9Olsuq/kJulfC61uXa+UW0yX9rDgBdvAHtM1D7onTKMIKk/nKMZOMv88cER
 KQqShpUJLV6ar8cgbj3OWmUHGVy+prtwQpy+ZCMcwtZqHAQgrf+3aD2AQpfnhZc4PR/i
 md4ht4jPCU8V1sTT+evhPlMXA0sGszJWE1HipMou6vQa6zWWyEjAHGgCdqeRtI6Sw/Id
 s1tw==
X-Gm-Message-State: AOJu0YyLNXvI3OJWfVILTlm8XjhkbAT1XolWvXobFStFZdIwUmfA9DaV
 KuaAwQcJsTvyQ04n3DFEuEoibvx6GIG1VkEIyZlEHXvVqBXXbpU62fTV2Ei84wPALEdagZOKA2L
 ksR2P
X-Gm-Gg: ASbGncsQjKglmcJGPosC3mH5W29SivBqrc4e/epEdMUEdbkmii5A6dWhzXyhUtjbiR5
 XkJXP+jNYUELTmvkRYvOuQ+kw8rZ2ireBEtELb3BcBCsoU1gLuz9qi7dI1Ct4duBRXLH2O52XEV
 hDZU8DLk9unDcIK+JQByhq+vo2juHPghd6JPE3677TGg6ZzU7s8lJjb4itKapTAf3ay/f8pjqA8
 Ys86uOtfrewQeIP2XRSXXJ5IoTrH+kAkMGDyRa/quUYfdcPM4hR0y5dhVoWno5aGi722+iRnwAb
 wLJpDQfLY0DPUUsgaISUwb5pMQp6kWCbI3PPeiGCBUTJJDegRtb/xNKipaVAQ8oGpqL2JYV3Rxv
 V5vofpGSJaX8jBIumyqYGW75MT5UJ
X-Google-Smtp-Source: AGHT+IGOAaPuy4xXYrgYrMxv6BAY5yeatoXmrGhZq7Jfh5m+No/bruvD67d4C05+Qjifs12YaQKC/A==
X-Received: by 2002:a05:600c:8207:b0:43b:c857:e9d7 with SMTP id
 5b1f17b1804b1-454e2addac7mr35789625e9.5.1752245414123; 
 Fri, 11 Jul 2025 07:50:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5061a91sm88841405e9.17.2025.07.11.07.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:50:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/misc/ivshmem-pci: Improve error handling
Date: Fri, 11 Jul 2025 15:50:12 +0100
Message-ID: <20250711145012.1521936-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Coverity points out that the ivshmem-pci code has some error handling
cases where it incorrectly tries to use an invalid filedescriptor.
These generally happen because ivshmem_recv_msg() calls
qemu_chr_fe_get_msgfd(), which might return -1, but the code in
process_msg() generally assumes that the file descriptor was provided
when it was supposed to be. In particular:
 * the error case in process_msg() only needs to close the fd
   if one was provided
 * process_msg_shmem() should fail if no fd was provided

Coverity: CID 1508726
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: tested only with "make check"
---
 hw/misc/ivshmem-pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 5a10bca633d..d47ae739d61 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -479,6 +479,11 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
     struct stat buf;
     size_t size;
 
+    if (fd < 0) {
+        error_setg(errp, "server didn't provide fd with shared memory message");
+        return;
+    }
+
     if (s->ivshmem_bar2) {
         error_setg(errp, "server sent unexpected shared memory message");
         close(fd);
@@ -553,7 +558,9 @@ static void process_msg(IVShmemState *s, int64_t msg, int fd, Error **errp)
 
     if (msg < -1 || msg > IVSHMEM_MAX_PEERS) {
         error_setg(errp, "server sent invalid message %" PRId64, msg);
-        close(fd);
+        if (fd >= 0) {
+            close(fd);
+        }
         return;
     }
 
-- 
2.43.0


