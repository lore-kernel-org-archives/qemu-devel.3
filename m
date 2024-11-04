Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF9CD1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80sV-00065v-8v; Mon, 04 Nov 2024 12:28:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sS-0005tU-Rh
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80sO-0000O7-7A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKH82Qv7Oy514F5AxGk5rkT73airVJkv+YqHS8mBhzc=;
 b=OzaDCKdUGYRc9G51U+qcq93ITvfRDEbXFHbIp83qXYXdWlQ3s84C56g3VNTFLUxk7EscLA
 JIAt5nUL88ZZbEVg/0CSzTBE9YSIuCSrQALZQ+tJPLJlhBhDJ5QmXZz7ecs7dRP1vOI1pD
 zwFxBWwtGHm6TUPOO8tyFcPACTPbMmo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-vb3FHSVmM5q89lGvqFXEaA-1; Mon, 04 Nov 2024 12:28:22 -0500
X-MC-Unique: vb3FHSVmM5q89lGvqFXEaA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315eaa3189so38366125e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741300; x=1731346100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKH82Qv7Oy514F5AxGk5rkT73airVJkv+YqHS8mBhzc=;
 b=ISvmqN3hQ5+NUHVh5zMyJbNK+LCDqwvgXcuSQRybGS1yAnloRs3y1fzFxLhHDWGQtO
 20LXHOGPVBGeu3IT//XSGuVicLL8Zau072WzpFjdq2hqWIShJmW7eUjy4EtojSwxbl40
 78XJg86MnUTN7rRAGUg6qVlc32Z83et0BthHFQrqaF5TuVdaV/G/3eSlEQWxKZMCBOVC
 cYY+qL/On667XFm5sRBpGbbwAfLjkrHITvZbUC1ftrvfRiKM8s61k8AVuuqn7/vo4xyR
 QEauDrLSpJrR2SOW/CJ0WUdzKGnl0NgN/+cU1voJQe1Iq9NTbYp5R15ep/8aenJy8aFc
 i9YQ==
X-Gm-Message-State: AOJu0YxF6bTkAR/hNG7oS2HHvyl7W3/TqT8y5rM1vuDRobObJafvWf6a
 sS5Fb5gSONB3RRDS3eJmm0dbbuy4IHTibGKaA6Ukr1Vg7h7onve1A8lzjAy8Foflk5Z4ZIcHRyo
 i00iIrKu4YQ3RPW+MopF6x6D1L6KbJQpGhasWmO85+/yjTxjh/lq5TTxmpBuk0BWUZxW6MMxo8/
 UUj6wDafRIGR9T/4MWZJBX8W0zFTtX1DshoALvRI0=
X-Received: by 2002:a05:600c:4f8a:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-43283242bbamr141805085e9.1.1730741299982; 
 Mon, 04 Nov 2024 09:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5aHIxoHJ7zck4IgvTDUbw7/dLCy8G5i0lBS4Fj7R6SagkTPs/9YNojWhckxu034F6CNQECw==
X-Received: by 2002:a05:600c:4f8a:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-43283242bbamr141804785e9.1.1730741299563; 
 Mon, 04 Nov 2024 09:28:19 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983ddsm162048755e9.44.2024.11.04.09.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 26/40] rust: fix cfgs of proc-macro2 for 1.63.0
Date: Mon,  4 Nov 2024 18:27:05 +0100
Message-ID: <20241104172721.180255-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

Replay the configuration that would be computed by build.rs when compiling
on a 1.63.0 compiler.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/packagefiles/proc-macro2-1-rs/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
index 818ec59336b..8e601b50ccc 100644
--- a/subprojects/packagefiles/proc-macro2-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -15,7 +15,9 @@ _proc_macro2_rs = static_library(
   rust_abi: 'rust',
   rust_args: [
     '--cfg', 'feature="proc-macro"',
-    '--cfg', 'span_locations',
+    '--cfg', 'no_literal_byte_character',
+    '--cfg', 'no_literal_c_string',
+    '--cfg', 'no_source_text',
     '--cfg', 'wrap_proc_macro',
   ],
   dependencies: [
-- 
2.47.0


