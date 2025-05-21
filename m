Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FBEC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 09:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfzS-0002mO-32; Wed, 21 May 2025 05:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzI-0002jh-LQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uHfzD-0001cC-F4
 for qemu-devel@nongnu.org; Wed, 21 May 2025 05:43:48 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso3284584b3a.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747820621; x=1748425421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIakYp1lP7xSBXnDVrm8gIcQG/rmDlJvM13jkAvGUko=;
 b=m+s+z6sOQmlF7paWbACdxh8n7RXobu8uWtkvyhPKDzafoC5ZE8NXfIR8e4Lol9xlBK
 xdU7w+miKc9a8EmR37c3pkkd4nCUXulIwI1LDFfI2zE4aokHCxuqCTN0t0z0ifY/+aRC
 prVKJYhn5nkISknb1B9CPD27C3a64zFaJownO9cNYfFCDsXFbBq2Cs6g5QBc/TI8HRjc
 955+snUax2jshLdfaflcBsonUkR7r+tHR9DTwpla60E0misOww/nQmTkKX9k+LOl+V99
 EELBuMkWlgI3jcAWqxtramIBF7h0+sbyn+eMJqjs4m4Ndi0AHHm1y6WQc+3jvefbSSKh
 QFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820621; x=1748425421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIakYp1lP7xSBXnDVrm8gIcQG/rmDlJvM13jkAvGUko=;
 b=RkQhlK/LPdmyWSgA8a69E+hYZKyw8JSGZOJ329RGfpnSZPsY71dCM+ITGnJbsk+b1T
 TwJlsTmgq5whTQZVjtGaATxylR1t8sevt0DFfsWuYWTD8i9Q30+Ala5hGYev0eCKQTPX
 EjNQKdvPqvS3wUN7S63DNgE61Z4DBTDzJKTrGI1+/izUpC91XFiVAhA5JmH2ckEMhd+C
 vYDli3KrBERRFLJP4og6mLPe0M9Zmsc/5t8iSLfsV+cx80i2jfBFyLqCKZbek6s/Jghk
 6uA9TFH08mp3DPdmyXFlrFWoV/vIJDWBUPStRr+InCvdu2dVZbYVEZAVyYQp4jnggpRl
 yg6g==
X-Gm-Message-State: AOJu0YxKGTdHCy8tvwTndBFLGaVkP1wlP6q+okCKh5bRM3PNlZCOcIpM
 XELR5OSQqWuAf1f/FHjc2Jkse6qe0FCFEhvBoIsYJK1LtTyUxebKP40zgfk3EGr6dtc=
X-Gm-Gg: ASbGncto9P+FxRnsoZb2PghSwnEOukg6fYizFJz7rpLgKNgGQpDTLk4m5XKf3hXHWGw
 Bl3pEFEKnSHDxLeqZC4pzbQfzdmiIeJPzyxPb2gLiwoo+N5JpBFrX15nL7jH32+VvbF3K13k+LF
 A3YuAbWTY1oxrsXOotxjWYbFmXdQ1BO2Ni1Uh6knHORJQEtSG1Rg+N2VvHwFd0dtz6opxO/200u
 XG36v/t7xpXTLKMuCDj/z/kchN2LBAWh7qil6P8pV8oE2wEUTUD3L5tij0wz1rMCadMhxKY/Drm
 ac9nr0OFK+ieRNOOzEiAwcsUq52NhdxIq/hjXn4hVZm4ku7abb8=
X-Google-Smtp-Source: AGHT+IGO5bKuc2rTh6ikR04ee/WVR8CKKVt8643OrAS4GJ897r5oO38RUQJsXxNrSRBGyhcmgj9jzQ==
X-Received: by 2002:a05:6a00:982:b0:736:a7ec:a366 with SMTP id
 d2e1a72fcca58-742a97a2bcamr25456071b3a.9.1747820621281; 
 Wed, 21 May 2025 02:43:41 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9829b87sm9255668b3a.114.2025.05.21.02.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:43:40 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v3 8/8] Update plugin version and add notes
Date: Wed, 21 May 2025 02:43:32 -0700
Message-ID: <20250521094333.4075796-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521094333.4075796-1-rowanbhart@gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42e.google.com
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

From: novafacing <rowanbhart@gmail.com>

Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index d4f229abd9..4cf2955560 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,21 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_get_current_vcpu_address_spaces
+ * - added qemu_plugin_n_address_spaces
+ * - added qemu_plugin_address_space_name
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


