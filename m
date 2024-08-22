Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FA2C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZK-0005Z9-RO; Thu, 22 Aug 2024 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZD-000578-Fk
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ3-0007K3-UV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso7303215e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343690; x=1724948490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaN7NC9uHrEwXd29tH1+I6/CGeGFysWI1W1y0Mcbdjo=;
 b=ycL3p/CxwDjA9aCs4o2zK6NceNnnCy9CzXj5b2NG5XH0J+MAwa+WbGXseG6OIkHobU
 Xvtkc7vugvzTXfKUSZZ8rcSkE3E3BKYVwICNrrX57pxYwksF3PpTwLKmEPITvTnot6oR
 hIz0qVyXhYmC8k6OIwo1Ynn3LAkO7U+opNeGp6fUF8uWcvjIGOv7TooPzuAIszMPk4uX
 MMBbAnQzUcPFb1GqsqKaCujKMvgKuNlg2Myy1LaDyfROqZ4FmjEB6xAxsVpQRuVXH2rn
 nQkgJjxx4iDZleYOToRZpxTL4GABP3FWuj7egMSsxortyXe7InhG3pj0HrM3yJhsEXRR
 M2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343690; x=1724948490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaN7NC9uHrEwXd29tH1+I6/CGeGFysWI1W1y0Mcbdjo=;
 b=udq4o3PuCMJ03ZAM077evkoeY5O7Sl3mo2pevVfPJuzCM4hnJ1fcYX2v18okJY7fjK
 +FmIrtsVfRUnOK/rJDUGjl3IuNSgX+YU8L73TbatPuAepaPISalpzffG/gIaQvQe1EAL
 +gww/xd+iB1hzhlbhjEgHG2emlVkV/MAcFEG35INriX9fOICVSet0ZJC+0rNnA/Fu0K5
 nrWYfaqEPfWZxRe31lHWDM1g4q/eOHt82Y34tVDX6dRO/IDlsOdo7fC4p2skSF/RpbE5
 BUmTNAq/OQG214+rp4er+Yhu8dYTrmJDBnaz73+icmzSUZ+XqfDRduGgX5bYc28lE5or
 Dg9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcLYKpjCMgu6q49y7GNGXLQFQe0FLJwBHow1TPrCHDX4rZmTGzzGbnwO0bnGowQJ5LEANSyB2W4Uz9@nongnu.org
X-Gm-Message-State: AOJu0YwGhgtu95vrE0jw1zkU6BCCPhHW6YoURFyH4UmZegAFm6eHuL3b
 KvwfFMGaAgr71s8nhHul0H3FmoAhrJ6nIlZui8dDrV2ZSODAxLZCoUfBviicyZ0=
X-Google-Smtp-Source: AGHT+IENxlBGHBvDRNLD0rjunbRN5atbKzjlhwrM+3UuZkymQF555M2bBpAw5KyhCroF/tu0/IpaSQ==
X-Received: by 2002:a05:6000:1087:b0:368:5a8c:580b with SMTP id
 ffacd0b85a97d-37308c1809emr1629814f8f.19.1724343689838; 
 Thu, 22 Aug 2024 09:21:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 1/6] hw/misc/xlnx-versal-cfu: destroy fifo in finalize
Date: Thu, 22 Aug 2024 17:21:22 +0100
Message-Id: <20240822162127.705879-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since the TYPE_XNLX_VERSAL_CFU_FDRO device creates a FIFO in its
instance_init method, we must destroy the FIFO in instance_finalize
to avoid a memory leak for the QOM introspection
"instantiate-examine-finalize" cycle:

Direct leak of 8192 byte(s) in 1 object(s) allocated from:
    #0 0x55ec89eae7ee in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d7ee) (BuildId: 6d508874816cc47d17c8dd775e8f809ae520e8cb)
    #1 0x7f697018f738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
    #2 0x55ec8d98d98d in fifo8_create util/fifo8.c:27:18
    #3 0x55ec8aa2a624 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
    #4 0x55ec8aa2a33c in cfu_fdro_init hw/misc/xlnx-versal-cfu.c:397:5
    #5 0x55ec8ce75da1 in object_init_with_type qom/object.c:420:9
    #6 0x55ec8ce5d07b in object_initialize_with_type qom/object.c:562:5
    #7 0x55ec8ce5e91d in object_new_with_type qom/object.c:782:5
    #8 0x55ec8ce5e9f1 in object_new qom/object.c:797:12
    #9 0x55ec8d65c81d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/xlnx-versal-cfu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 6bb82e51c15..2284b407eab 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -397,6 +397,13 @@ static void cfu_fdro_init(Object *obj)
     fifo32_create(&s->fdro_data, 8 * KiB / sizeof(uint32_t));
 }
 
+static void cfu_fdro_finalize(Object *obj)
+{
+    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
+
+    fifo32_destroy(&s->fdro_data);
+}
+
 static void cfu_fdro_reset_enter(Object *obj, ResetType type)
 {
     XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
@@ -539,6 +546,7 @@ static const TypeInfo cfu_fdro_info = {
     .instance_size = sizeof(XlnxVersalCFUFDRO),
     .class_init    = cfu_fdro_class_init,
     .instance_init = cfu_fdro_init,
+    .instance_finalize = cfu_fdro_finalize,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_XLNX_CFI_IF },
         { }
-- 
2.34.1


