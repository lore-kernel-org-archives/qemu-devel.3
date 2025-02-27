Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457EBC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tniFr-0006wL-UK; Thu, 27 Feb 2025 13:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SanAZwcKCuIZIRXYVIKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--venture.bounces.google.com>)
 id 1tniFq-0006vC-1t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:05:02 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SanAZwcKCuIZIRXYVIKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--venture.bounces.google.com>)
 id 1tniFo-0005hj-CH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:05:01 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2fc45101191so2819536a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740679497; x=1741284297; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CCxEAVG37wYa2sqPvOrwdkyFZWGt/rOF9d+EQkX9LwY=;
 b=SWva8mQx1KwFQHaAFt1fJlMwZ/n9aP6mt2X401hw8GUsi0gpJhLBq4a+SCFEXqf+L6
 DWkiL0TsHEX8sd+ORdDWzaU1n3WZPmD1uJIQduyoMpScmhfB/6hM4HQReBu/zSuvSwp8
 2ycTggov47kVlytV1sBU8GMBI3dgy0yWosQwtNKgO87F7KU9j/wSYCBzJq9d5MIfa2/I
 3XZ99ELrSlRXDj3Im4IxY8GphQnCwTbekq01+O8Z3/2+RbHxUWVE2nb8VFQajKZlCp2C
 etOODs6Q4RV0c+tYw/nEFnCOBx38NpMDkqbx4FOQzBs8TouEgCsR2Z6Za4HseE/6mW+u
 oquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740679497; x=1741284297;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CCxEAVG37wYa2sqPvOrwdkyFZWGt/rOF9d+EQkX9LwY=;
 b=nkiHCECaJ6lPiasNvNIDX3raDCwGkvFatcDDjcFk17bMLSg8ckBtHXKSboxPglXMrx
 GGRhfGy4PqUC2To/If+MvhLuN/nk7a4uhxGwlfQ1jX//6ISL6jtEAoAN7kxmzFxoRtYD
 uQeVHeO0nRci+cxg11F6woCx4HEUQdsvYgfA1p7uB/D92LnnkVUoTzsfJXAkPzRHN2Qi
 SGUrjVFtAQZsStnxhG3sbu1hrPlBlJaYL6Iavredl7LapTt6WRfvF85SuvDb4POTBfn8
 8Z7S8HbemldCDI2v15S+nFLio75IPFUkfuSjL4IWd65g5roht8s7FauxS7RnZPK9jROa
 wvLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfTcugjVJZVme4XZs+wWTpxBGIXax4npmau1Hwm7SdTT39qMrqvWWr6Qo3Y2dVM/l2JbHFrq7r/kv0@nongnu.org
X-Gm-Message-State: AOJu0YyMvB2Sp5DuD4lUFin5QvQEncGqGw1hgjEhypCPb4h432SDsqvc
 /irgE3d/5WD/9iaatEDeE089SQHIfM4T+DpUsmuzMXfDVBorA/xEDX4U4lAEOuDfuvaI4b0a9I3
 tyI/1qg==
X-Google-Smtp-Source: AGHT+IFl/Rrd0+KL1+DRokILRHPQXJgb18gk7y9j4V4vHAjFrDXOtH+NknUY6QADWYw1BOg8umTeVgC1k+LX
X-Received: from pjbph15.prod.google.com ([2002:a17:90b:3bcf:b0:2ef:d136:17fc])
 (user=venture job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:35ce:b0:2fe:85f0:e115
 with SMTP id 98e67ed59e1d1-2febabc8086mr293939a91.26.1740679497538; Thu, 27
 Feb 2025 10:04:57 -0800 (PST)
Date: Thu, 27 Feb 2025 18:04:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227180454.2006757-1-venture@google.com>
Subject: [PATCH] scripts: dump stdin on meson-buildoptions error
From: Patrick Venture <venture@google.com>
To: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, philmd@linaro.org, 
 qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>, 
 Patrick Venture <venture@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3SanAZwcKCuIZIRXYVIKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--venture.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Nabih Estefan <nabihestefan@google.com>

Dump sys.stdin when it errors on meson-buildoptions.py, letting us debug
the build errors instead of just saying "Couldn't parse"

Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
---
 scripts/meson-buildoptions.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 4814a8ff61..a3e22471b2 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -241,8 +241,14 @@ def print_parse(options):
     print("  esac")
     print("}")
 
-
-options = load_options(json.load(sys.stdin))
+json_data = sys.stdin.read()
+try:
+    options = load_options(json.loads(json_data))
+except:
+    print("Failure in scripts/meson-buildoptions.py parsing stdin as json",
+          file=sys.stderr)
+    print(json_data, file=sys.stderr)
+    sys.exit(1)
 print("# This file is generated by meson-buildoptions.py, do not edit!")
 print_help(options)
 print_parse(options)
-- 
2.48.1.658.g4767266eb4-goog


