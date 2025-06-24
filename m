Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CD9C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qS-0002ya-KG; Tue, 24 Jun 2025 13:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qJ-0002wk-GF
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:00 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qH-0002lq-78
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:53:58 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b34a71d9208so816823a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787634; x=1751392434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHe8xQirzInPTSI2/m7eUgGXSthWU8jdNTJ3AwcZinw=;
 b=nof21IAjc2QUKMO8XlRdRKS7MkH/fgNmLsnOKa/ntuN2F9/4mB8FBDFWMUse9FZWJW
 6b8EPNVRtjEdYwff77EdIdCoTqTdaVg18NC5tTBCxLZ8UtDEUYzZKhJoLfyiaqy+R79/
 x8hZ6JSg7h3brknAC/UDC6HBWGRlHe/IszlmyOuYHv8nx3cLqvh/0GKEN8NO1rq7pGSM
 5TjJs7XcsBYQ0zkzbcLqspj21xFbe+BhxY9X9lHEt0BncShbcouvdH717+IyPdv5lxF5
 Gf12JpJeRElmW7ZgXMAsIwBDI2rjKrty0G0OnNfAi7rrec5YBa2LB+04NYqYyZ0DdbpF
 9LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787634; x=1751392434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHe8xQirzInPTSI2/m7eUgGXSthWU8jdNTJ3AwcZinw=;
 b=OALrgtjoUJjLgBTkmfZnJsfA6jsXj/JSoKShbOvM3lCcajBm0UV0yJx4FzCLlJ6Gqj
 CVjzs4G3+m4vgrFgDVCcbFq2JR8TJLnFf6oPujVfzi+N0fOP8HinAZ3B5I7mW0YtgdQb
 5XPMwVRuL8IQx0hQ/ej9IysYLpxKov51YtXBRoGUT+Vp7CFVTAeG47/5dRzM/ERWk/4V
 29/isBdBFsK5oVZH9MqgUcqc/bEa5FQvhETKEIV5ZOaLdV5iVhv+6leeuKn6LVeS7Mvq
 XD96YXLjTrJE4VaZNYNC/q2AQcy6MeVQb82Tou8pbrUaCV0u/+FHRxR6ZpR6h+q1MIg1
 Hrnw==
X-Gm-Message-State: AOJu0Yz5EmgFmqJlJl1Aw9w37ilymGrPu3ePg65hKStKBV2bbgsBpaMR
 qFoDZbW/+2FYjsWXQNhbBgWqOSvD88zcfNN8iLpQZ8+bn0Yp0RXLWekU9gE7pBdHQcE=
X-Gm-Gg: ASbGncsAyV24TgAyLnjphTgocGwEsFdRRkBFJt8G3wtKEuulQDhLJg0+b1cn5pM67Yj
 uybddvZXcne0uPmLqJo8hqVUT6QhfLInytMhrSb2cSvJAGhp1+kq48yBN8+aWff8Z+bY85nOVJX
 i69Ygt200W2JPSHWBV93QqMk5mKj0rPQzrEpb2Q/bAK6fBKMZn29ZrSdsG+S541BsFN0e6tEYv7
 V2sY+moRAC9Wwwhgrm/sN6p5mSCBsERnvL0amIv3FEmvuWXkG1y16RQHV/UPZuH6wDalrwKaeHq
 2aMPbl/mCCClztEr56oRhkLDTccMAkcauH8ObryM7MTyAbdBFuMq3NCko/nruQ==
X-Google-Smtp-Source: AGHT+IHDs1T12MFHm40WqppsL21JDdl8ZgeXZP7OBVR1xdJtgqIz7SMZZKz9m/4ogeJUH9nMpgpJ2Q==
X-Received: by 2002:a05:6a21:2d04:b0:21f:775d:107e with SMTP id
 adf61e73a8af0-22026dd980dmr25556123637.17.1750787633666; 
 Tue, 24 Jun 2025 10:53:53 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm9318153a12.40.2025.06.24.10.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:53:53 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rowan Hart <rowanbhart@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH v14 1/8] gdbstub: Expose gdb_write_register function to
 consumers of gdbstub
Date: Tue, 24 Jun 2025 10:53:44 -0700
Message-ID: <20250624175351.440780-2-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624175351.440780-1-rowanbhart@gmail.com>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x52c.google.com
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

This patch exposes the gdb_write_register function from
gdbstub/gdbstub.c via the exec/gdbstub.h header file to support use in
plugins to write register contents.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 gdbstub/gdbstub.c      |  2 +-
 include/exec/gdbstub.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index def0b7e877..dd5fb5667c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -535,7 +535,7 @@ int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     return 0;
 }
 
-static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     GDBRegisterState *r;
 
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 0675b0b646..a16c0051ce 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -124,6 +124,20 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname);
  */
 int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 
+/**
+ * gdb_write_register() - Write a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the register contents will be set to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * The size of @buf must be at least the size of the register being
+ * written.
+ *
+ * Return: The number of written bytes, or 0 if an error occurred (for
+ * example, an unknown register was provided).
+ */
+int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg);
+
 /**
  * typedef GDBRegDesc - a register description from gdbstub
  */
-- 
2.49.0


