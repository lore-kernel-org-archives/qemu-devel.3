Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC401606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qW5F4hLD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWejj-0008On-7V; Thu, 26 Nov 2026 14:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWejB-000836-Fl
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:55 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xWej5-0005Da-IC
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 14:01:52 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c51bf011392so208019466b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 11:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795719704; x=1796324504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5OVoyjCkc+WrC7i9e3jXKc8VxoW6GGLBwrCBvvb0OZs=;
 b=qW5F4hLDDtETWZAmvdkMbwYHuONnFskAlhizW6qM0zpE5Ab30VqzNQp8BCrvuJOrgE
 BhHpm6Do5E9xz2PllGHer/DQhCb6S1i/bJY4RMvjWGQPqkWs3bPRmsrlQ20cDAFCavqk
 MZ0vFCJ8o0UV8thU3CDpimXB9dU4I19FnaGD4LqaY0x/SnbzlvyLCI3SjhmCid3PP/Dk
 hX6n20JECHRmcCHRTcz6dxzo4RqRdpr7bKR71tGKKGynTziWiuMLefDHF81vSLEjqAvA
 iFdv+PekS7r2bMkn2sXP80ydL4j9h09n50XiW32WGq1R1g4R7Uju/lz/td0B7a33OQ+W
 /aJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795719704; x=1796324504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5OVoyjCkc+WrC7i9e3jXKc8VxoW6GGLBwrCBvvb0OZs=;
 b=cpJTsPa+H7IcXb/DElwCPbNWAc3UgOPKHwxwb/wZMM7GnpOd+Fwcr4C8NCCFPUQBTU
 BDZjzK6Go90araiMR00LCv1HluI+tSRpA7xcWhBJVmCJo6XKSO9zRvfuq7m1BoQWzugm
 CmTRcmKwK/s0cml0PrTkyPCCr4mWWqwBVg1ad5k4V7A504grVmn37NvMsO3NQ1zBsU1s
 kRbEn3HqmTd3Qnsp2iVu+pNqzdIGG0wXBUym7fQQSA/4ZjWS0pa1+ZKag8UB9jub+bCq
 pG+sNW/YuJgMUoAhE6wfmtru2/imtGzvLF96HI2qz8geTxLqu4ejSjMRcyLqv3xjd5fp
 k/cg==
X-Gm-Message-State: APuU4Z+8dCtDEAz7zZ2RCb5u9lavxLnnJEEfLsUxMjX64+nCGO84Yz0S
 3XbjdqW7r1wUMsRtsaKxakI/M7JrZoE1B+asRUpIK5WSXJnCk79F2ctrlr4U6e5DTME=
X-Gm-Gg: AZFdTZftCso5eQeAFPQ6JDLjuUy/0weQS7Jtk2iwF0pOTBl21lhwswgG8g1Ze09sKrv
 Z8B3MXMQG9yt3EajvCbQHxQRKloJXVDc/6fjtDD7otsLgB3GfNl81hpohiaMu2+faXFXcRCwCsD
 Cw8WtpiFS+XIfj0Bj2hA98zYBE1noqvjJnyyaqVPR1eU/xuFJdCXS1IuFZPnxdPLUVbwaKyjblR
 wbDVnUrsT94Iz7//6rjmuL5xw2WIK2FH1fREHoyl2N+iUsFaJIXD1Sx3JUc/7vmh25ZdF6uzvWZ
 +/O+wHVdZBBGl2+kMGd5v864dqOEE+9iJXSgolqQnWfoBDRkpKpD0e5LT93hsaKtZQhi6g7oduU
 2v28aCMgf4XvCf5alkZo4O7t9Noulxq1s+xacunhLfZYBaSVT04bqSx+qmxmRAbw56H9WyTkZzg
 OAtFmyEz1UNkpMxDppgfVAHJADpGTpX6dw3wNWV0n3zQhXmNHmZ0JWGxuHow940FQU2mH8HFv6V
 gOfERMHwGO3OQ5hYwsvNNwNhe65lmP0mzWOPpDo1q78mJBboEbD2QsdijDn/WQq3h0zN9vEPP2A
 oCAU4uLqr5PZ416JvJ0RE7WwrK+zVPTiIiMv+E0B3NH8n5KfBW0vsx5HzQ==
X-Received: by 2002:a17:906:d7a5:b0:c51:249f:7250 with SMTP id
 a640c23a62f3a-c513ac66e13mr1318412566b.39.1795719704363; 
 Thu, 26 Nov 2026 11:01:44 -0800 (PST)
Received: from tulp.my.domain ([2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae6663esm786278766b.21.2026.11.26.11.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:01:44 -0800 (PST)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH v3 07/10] iotests: fix test 162
Date: Thu, 26 Nov 2026 20:00:50 +0100
Message-ID: <20261126190054.40844-8-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126190054.40844-1-bogorodskiy@gmail.com>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x62a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test 162 expects Linux error messages. These messages could
be different on other OSes, on FreeBSD for example.
Add a _normalize_errors() helper to cut these
OS specific strerror() messages.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 tests/qemu-iotests/162     | 15 ++++++++++++---
 tests/qemu-iotests/162.out |  6 +++---
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/162 b/tests/qemu-iotests/162
index 4f01611886..a8aa61a837 100755
--- a/tests/qemu-iotests/162
+++ b/tests/qemu-iotests/162
@@ -33,6 +33,13 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+_normalize_errors()
+{
+    # chop off strerror() strings as they are different across OSes
+    sed -e "s/\(address resolution failed for -1:10809\).*/\1/" \
+        -e "s/\(Failed to connect to 'localhost:0'\).*/\1/"
+}
+
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
@@ -45,7 +52,7 @@ echo '=== NBD ==='
 # NBD expects all of its arguments to be strings
 
 # So this should not crash
-$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}'
+$QEMU_IMG info 'json:{"driver": "nbd", "host": -1}' 2>&1 | _normalize_errors
 
 # And this should not treat @port as if it had not been specified
 # (We need to set up a server here, because the error message for "Connection
@@ -78,10 +85,12 @@ echo '=== SSH ==='
 # expected to be an integer
 
 # So "0" should be converted to an integer here (instead of crashing)
-$QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}'
+$QEMU_IMG info \
+    'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}' 2>&1 | \
+        _normalize_errors
 # The same, basically (all values for --image-opts are seen as strings in qemu)
 $QEMU_IMG info --image-opts \
-    driver=ssh,host=localhost,port=0,path=/foo
+    driver=ssh,host=localhost,port=0,path=/foo 2>&1 | _normalize_errors
 
 # This, however, should fail because of the wrong type
 $QEMU_IMG info 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}'
diff --git a/tests/qemu-iotests/162.out b/tests/qemu-iotests/162.out
index f8714cb0d2..12e31e6136 100644
--- a/tests/qemu-iotests/162.out
+++ b/tests/qemu-iotests/162.out
@@ -1,13 +1,13 @@
 QA output created by 162
 
 === NBD ===
-qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address resolution failed for -1:10809: Name or service not known
+qemu-img: Could not open 'json:{"driver": "nbd", "host": -1}': address resolution failed for -1:10809
 image: nbd://localhost:PORT
 image: nbd+unix://?socket=42
 
 === SSH ===
-qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}': Failed to connect to 'localhost:0': Connection refused
-qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo': Failed to connect to 'localhost:0': Connection refused
+qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": "0", "path": "/foo"}': Failed to connect to 'localhost:0'
+qemu-img: Could not open 'driver=ssh,host=localhost,port=0,path=/foo': Failed to connect to 'localhost:0'
 qemu-img: Could not open 'json:{"driver": "ssh", "host": "localhost", "port": 0.42, "path": "/foo"}': Parameter 'port' expects a number
 qemu-img: Could not open 'driver=ssh,host=localhost,port=0.42,path=/foo': Parameter 'port' expects a number
 
-- 
2.56.0


