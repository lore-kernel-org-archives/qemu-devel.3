Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1452BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjje6-0002RQ-Us; Mon, 11 Mar 2024 13:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdr-0002Qr-ON
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:40:55 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjdq-0007Em-2V
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:40:51 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e617b39877so3315635b3a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178848; x=1710783648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLLsOmMfH6Hic0UmOy3GbMHG10bAawMzfOEyo9niiZA=;
 b=cN8XEqtXy53TKbiqAz9A4LdMOxqZ4fWU+Kble8POdw8i4HXZv8ISZG2ahxZxJPoMIy
 lJa3P4j1CNthpLl9UNqF1YjQ46jhr0Riz4yD0MMRFhiLsB81Ocxb3mq6TfO45wG13gH5
 y898Oc3yB0F4g4yCxRDFmAvKRscF6WstS/Ih+tQAR3/O0LWMHWhVf0C7rUwg+0DHM/lV
 6PpHVy1jrBKVWoYgvllS0+bAO3ScXE+q6LA9boICELxxOOaOmVuz6ryodQrgcABZf1EO
 hj8JQWG6tOGdT04avO32/1/lgBR98ga0pSqjs0gdmmkH7fVvOJeoQyLeMPQNI/2c171S
 z0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178848; x=1710783648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLLsOmMfH6Hic0UmOy3GbMHG10bAawMzfOEyo9niiZA=;
 b=ul9ryb8rqUgxBabSimYM5UOiRyoWZ4qp6Qbm5i/X6QcK+U8w6QcxZKwsVzhDcju1kt
 gmeqrPC1Vu9Lqg0KRv7hppDl+ck3ZZgZ9T5Ec1DvgyYJc697+FuPTwwklb+ggkkeMX0a
 USbGuwiJPix2w5VBnnGt0xM+99qixw2uCFK3v4l0zdgTlJrESvB9cnqk1IhGt8ygiTTQ
 CbMzQ3hXCfu7Iy64nA2hs35T9NbO6vCFh7hA3RdK5PjRm5cTneWVEwXda5ggns9vs6g1
 cdu5RozNc+05G5U+IUx9MS6FxS7GNRMvPPVr72nmiD1/MtZY0NMeZmiRojIkN+ZgNIqM
 gG1g==
X-Gm-Message-State: AOJu0YwtPmIKkryQOkH2yiICGRtC7JplcNBB7aGZr4GWpbtsqahxVCoY
 RPfdFjWzPRxe8U/fq+cT6J4Iz21g+FQSAiWPSbhEp5eTC8VYTyKlYIprIk9h8+s=
X-Google-Smtp-Source: AGHT+IHDM362me8XuQ5UtEkx6swaUt2CjXepH7skR6Fvw1xUz7/hB84F3jlJID+WEBOiEailxWB7Tw==
X-Received: by 2002:a05:6a20:729c:b0:1a3:1595:d3dc with SMTP id
 o28-20020a056a20729c00b001a31595d3dcmr3265715pzk.46.1710178848307; 
 Mon, 11 Mar 2024 10:40:48 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:40:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 02/24] scripts/replay-dump.py: rejig decoders in event
 number order
Date: Tue, 12 Mar 2024 03:40:04 +1000
Message-ID: <20240311174026.2177152-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Sort decoder functions to be ascending in order of event number,
same as the decoder tables.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 scripts/replay-dump.py | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 419ee3257b..b82659cfb6 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -139,6 +139,19 @@ def swallow_bytes(eid, name, dumpfile, nr):
     """Swallow nr bytes of data without looking at it"""
     dumpfile.seek(nr, os.SEEK_CUR)
 
+total_insns = 0
+
+def decode_instruction(eid, name, dumpfile):
+    global total_insns
+    ins_diff = read_dword(dumpfile)
+    total_insns += ins_diff
+    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
+    return True
+
+def decode_interrupt(eid, name, dumpfile):
+    print_event(eid, name)
+    return True
+
 def decode_exception(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -198,15 +211,6 @@ def decode_async_net(eid, name, dumpfile):
     print_event(eid, name, "net:%x flags:%x bytes:%d" % (net_id, flags, size))
     return True
 
-total_insns = 0
-
-def decode_instruction(eid, name, dumpfile):
-    global total_insns
-    ins_diff = read_dword(dumpfile)
-    total_insns += ins_diff
-    print_event(eid, name, "+ %d -> %d" % (ins_diff, total_insns))
-    return True
-
 def decode_shutdown(eid, name, dumpfile):
     print_event(eid, name)
     return True
@@ -222,6 +226,21 @@ def decode_audio_out(eid, name, dumpfile):
     print_event(eid, name, "%d" % (audio_data))
     return True
 
+def decode_random(eid, name, dumpfile):
+    ret = read_dword(dumpfile)
+    size = read_dword(dumpfile)
+    swallow_bytes(eid, name, dumpfile, size)
+    if (ret):
+        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
+    else:
+        print_event(eid, name, "%d bytes" % (size))
+    return True
+
+def decode_clock(eid, name, dumpfile):
+    clock_data = read_qword(dumpfile)
+    print_event(eid, name, "0x%x" % (clock_data))
+    return True
+
 def __decode_checkpoint(eid, name, dumpfile, old):
     """Decode a checkpoint.
 
@@ -252,25 +271,6 @@ def decode_checkpoint_init(eid, name, dumpfile):
     print_event(eid, name)
     return True
 
-def decode_interrupt(eid, name, dumpfile):
-    print_event(eid, name)
-    return True
-
-def decode_clock(eid, name, dumpfile):
-    clock_data = read_qword(dumpfile)
-    print_event(eid, name, "0x%x" % (clock_data))
-    return True
-
-def decode_random(eid, name, dumpfile):
-    ret = read_dword(dumpfile)
-    size = read_dword(dumpfile)
-    swallow_bytes(eid, name, dumpfile, size)
-    if (ret):
-        print_event(eid, name, "%d bytes (getrandom failed)" % (size))
-    else:
-        print_event(eid, name, "%d bytes" % (size))
-    return True
-
 def decode_end(eid, name, dumpfile):
     print_event(eid, name)
     return False
-- 
2.42.0


