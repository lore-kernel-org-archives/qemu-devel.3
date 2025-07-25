Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB0AC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOyB-0003oA-IP; Fri, 25 Jul 2025 16:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu3-0007eR-Q9
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:28 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOu2-0001EZ-5e
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:27 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-74ce477af25so1830054b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474825; x=1754079625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c48HtYt5SZHZ65RgJpJ7TFDt711IMXEInKjXtQ8WpUs=;
 b=PTWDY5ns3o/GmRs3Rre/lfm54opJx7XV8xb9fxiComHL1DjpMGU9RQRm0NIWXQjZw7
 QV9bUTkhwKl3MXRG7Q3tVUHepMufS3a7nKLfaJEWg0u4n73+7LVDKCsUt4CglJ8AhC4S
 r84YQfE7ICCdN2TKGXS2S06PeGWu1xc1u9ZzF7FQahDRPg62plKlV1deFL1zygrAvQlZ
 1oFk9qZNa4AIMqFZaYtiKpV7zZOFtAZdJzpopEcDH3Rn2McN9eZfcGhGFlx2B5fh6+/E
 qHfud2j7pcWCoRRDMFBSObgyJxaDqzWoS56eevEgo2pgHHqOj+DLEgFDDj3SqLKmakNL
 8IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474825; x=1754079625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c48HtYt5SZHZ65RgJpJ7TFDt711IMXEInKjXtQ8WpUs=;
 b=IMHRZdEx+k3COmXkt8EUmiIDQVTtF3osYotJ8t4vGFmsV+hS01mIgFsAquv3LzIsIB
 nFSfBc9fFLJ9uT3tZ60Wvys3hecCcXxtQYHhtpN9IwoJgekun2gYEjZG2h2zDeu9f7Io
 r3fJipQao6T57nDUIy4DtJlwx9DP4Wvz0J9ZW0wAO4aQr+qA50P1GOhsccmh9sE6CxIP
 fQMzy/z6VZP/uXu81nUZANyTX+lFw21WYWeUk5Iq1qCbZ4vQyUYXAYqkCGd3Jc74PW69
 ge4q8M5kzN5tUzzQhDegl0OvFDLQIfQGNki9Mjm2IDdV6iJb67wIuR8YOY8KOtvrSfG0
 f1ew==
X-Gm-Message-State: AOJu0YxF7lo/ajPAj9hw6jcPoa65Qulrmd1sGRE+KVxNMptRBGQe2Cte
 vrW4GEI/yVDBagUxkoEGdutgcQEhGjq0aJBkqN0xJmykYOdUg3IYwMQfgTH7kuuR5nFfHqQ2M3s
 iCcFt
X-Gm-Gg: ASbGncs3MIEu6Gvshxv60MhDbukUhCzTLa7L2prl3Gul3OUdAzsS5t45RKTflq8pujV
 u9SwRwh4ReCkE6vrplCIHPf7XZjofox3jCC5tHJ9Y6U20n3lcLFyl3FVnqWHCsBCh2EcHvcjqwu
 ekvFXjfdjG1e3ZjOjyprKQF2g2nPzuMf3glhtY6d7VpLmsTwtGsQaLm9NA6Gfl3x6JeAtDuf7xF
 XJfSZfrh4PWO5RLh3fcmKnYcAXW22gxfr3bpkqI0Tb9YqBDRzQLZyi7xMvvGizwouFdepsh47lz
 tPPeAYIS4tQI6HDFtHpqL8nWFkmPqybYr4RTsEW2pM7JYspD0wQDS2b8uEPUPrJA4TYLn64yHYb
 jnlxJcpzvog0qXrJjQJi2v8tKj/UNtAFj
X-Google-Smtp-Source: AGHT+IG6LgCHPmqslxZONZpgYLY2+4Ri9+zUaDAJt4X/R89/24ZLv/iZbQrWCj6Eg8Mx8L4vfUJscg==
X-Received: by 2002:a05:6a20:7486:b0:23d:4777:49ca with SMTP id
 adf61e73a8af0-23d70191082mr4906128637.34.1753474824662; 
 Fri, 25 Jul 2025 13:20:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640882071dsm360925b3a.16.2025.07.25.13.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:20:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/3] system/main.c: compile only once
Date: Fri, 25 Jul 2025 13:20:16 -0700
Message-ID: <20250725202016.21325-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
References: <20250725202016.21325-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build        | 5 ++---
 system/meson.build | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 71c253ba135..7718983951e 100644
--- a/meson.build
+++ b/meson.build
@@ -4437,14 +4437,14 @@ foreach target : target_dirs
     execs = [{
       'name': 'qemu-system-' + target_name,
       'win_subsystem': 'console',
-      'sources': files('system/main.c'),
+      'sources': [],
       'dependencies': [sdl]
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
         'name': 'qemu-system-' + target_name + 'w',
         'win_subsystem': 'windows',
-        'sources': files('system/main.c'),
+        'sources': [],
         'dependencies': [sdl]
       }]
     endif
@@ -4519,7 +4519,6 @@ foreach lib: single_binary_libs
   single_binary_objects += lib.extract_all_objects(recursive: true)
 endforeach
 executable('qemu-system',
-            sources: files('system/main.c'),
             objects: single_binary_objects,
             dependencies: single_binary_deps,
             link_depends: [block_syms, qemu_syms],
diff --git a/system/meson.build b/system/meson.build
index 6d21ff9faa7..f358c2c446d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -18,6 +18,7 @@ system_ss.add(files(
   'globals.c',
   'ioport.c',
   'ram-block-attributes.c',
+  'main.c',
   'memory_mapping.c',
   'memory.c',
   'physmem.c',
-- 
2.47.2


