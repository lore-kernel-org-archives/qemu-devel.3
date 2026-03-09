Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBC3F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcyP-0003Ja-F3; Mon, 09 Mar 2026 11:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxq-0002CG-21
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcxo-0000jm-GZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:56:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so5669492f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071771; x=1773676571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fw6wBvS/jWBCT8CzgmaAoObQ5XjTTwGmshMvHdDMLrQ=;
 b=NjlYGLXXcIkHzKRxUBeXB67HDc2ggmNtUxgWSDcxYU6SzSzBN788YRdXbHcbVjKD3i
 V9Ibr14ucTBuUxklPz8pjl1PL6AN/q7vE3WG9OGezmQjR12AHq85ikySlFb+HnMOIBFf
 s39m15OUVDPxNnIxzjIeMakDwjAC72xR0SSO/OQnT0CRKgFM8E4fX0KewE5t+bTNm9VI
 5lPRhCdB6mml3Nud7WEqaZRW1oZPnadZZH7utPfcnTp5Of4I59c5CpJr20bdq802vjtM
 F8W1Wsg1hox+JvplTPa3MsfUwcmHsQajAkK/oYUUU0PA7+lHqOnePS0PQyb0df4OhuMt
 XUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071771; x=1773676571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fw6wBvS/jWBCT8CzgmaAoObQ5XjTTwGmshMvHdDMLrQ=;
 b=BLeJgNX72bF0znwTcrZGbbwsWC6OWcvbMQ79laOblDePfM7Yxauuul4J2LNeNg05M9
 aUl3xttU2KN8Z8MbJMDrXYUsUFWXWh7ru2eAy8s+7gklkr9kIa3Ii2f0qPipEfMp+CBU
 ii6uKiJ99SrRviqgmlqFvi6pwxoIC1wcuoQS9i1MtDGGe0DPA0IMDCAOlq88UxJQEMLi
 gCRZWjYv7L/EY9jQaFmI3t6n7fsbMYcQghBMAV+XwFrCdUSAr988b4vInwF/obgpTuQc
 RTfuCJ1SBF1YqxkIJ4Kj7WmZ6GiM/zgt333y54plwr0x1V1v/fEkuVkrhWaq9Ycx6a80
 bLDQ==
X-Gm-Message-State: AOJu0YywX8yvvW9H4djA7K4qEh7hh3zxN8mGQE0sfMIg9CYg5D4A59Py
 LDH+rNXnfBsVu3Z+/FiYsk14GYQ6uELLnUEaSDTTicgAK6lFoKwYCz3cNJh09H81PgbnCRWVYvG
 qd+C9JMw=
X-Gm-Gg: ATEYQzwJqLTC1G5owCpwQp595qFNo2Z9MUp9tA1br7EaMFzYuyXT0XNp4Z29Rsva8vg
 u+Sd5ZXbsjr92iYGLayfy+Y7ePVwzs06rYKXmJ3KJs28UROERIpCFsFO7/j7MLoajdNH+1lSlai
 k/GKTCiwcgLUfwNENRLyPPJLPSUbxWIreozURrIe7ukTkxK5mJ8+3ciQvXS37LaaariqvvorrR6
 KJUEY9EXoPp2iJnsz5ONssqsI/gOo6dXy0FtBfG23WwctAaB8mU+xAARB0GmY3lFP7tIUaB8azo
 LbcauCLTNaDg4FVrbd1qn4FgVnOVulAPxMLJwlgQeniJ5rR+x+u1UwYOKTBRkVCEEgp408O7Yyt
 qh7b2snUOiPDk+gKU13Z83oDV0M9Uu5mSDma+/IMyXX5Y8Xxwp2W14/ZryZcuKgKzH9tgwpGljp
 Lv6eWfHs14olnyQQcZA/5+V3K2sGrgBR7ksAwvZEd2OQkbnqwH7Raa2ejidfhzTAsmSyt+hB16
X-Received: by 2002:a05:6000:430a:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-439eff38bcdmr213588f8f.12.1773071770619; 
 Mon, 09 Mar 2026 08:56:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae49177sm26636875f8f.35.2026.03.09.08.56.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/49] hw/qdev: Document qdev_get_dev_path()
Date: Mon,  9 Mar 2026 16:52:04 +0100
Message-ID: <20260309155219.62400-35-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We don't document qdev_get_dev_path() at all; in particular
we do not mention that it returns a string that the caller
must free.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260307155046.3940197-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/qdev.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 4b2730e9d8e..29083bc9078 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -324,6 +324,10 @@ struct BusClass {
 
     /* FIXME first arg should be BusState */
     void (*print_dev)(Monitor *mon, DeviceState *dev, int indent);
+    /*
+     * Return a newly allocated string containing the path of the
+     * device on this bus.
+     */
     char *(*get_dev_path)(DeviceState *dev);
 
     /*
@@ -1060,6 +1064,25 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);
 
 extern bool qdev_hot_removed;
 
+/**
+ * qdev_get_dev_path(): Return the path of a device on its bus
+ * @dev: device to get the path of
+ *
+ * Returns: A newly allocated string containing the dev path of
+ * @dev. The caller must free this with g_free().
+ * The format of the string depends on the bus; for instance a
+ * PCI device's path will be in the format::
+ *
+ *   Domain:00:Slot.Function:Slot.Function....:Slot.Function
+ *
+ * and a SCSI device's path will be::
+ *
+ *   channel:ID:LUN
+ *
+ * (possibly prefixed by the path of the SCSI controller).
+ *
+ * If @dev is NULL or not on a bus, returns NULL.
+ */
 char *qdev_get_dev_path(DeviceState *dev);
 const char *qdev_get_printable_name(DeviceState *dev);
 
-- 
2.53.0


