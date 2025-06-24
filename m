Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8FEC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 17:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7qX-00031g-T7; Tue, 24 Jun 2025 13:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qP-0002yV-Nu
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:08 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uU7qM-0002mn-5M
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 13:54:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74ad4533ac5so9667b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750787640; x=1751392440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsQHVm/OyW/NFr6cysTM72YPPcsE1O1Z1YjRSYHSSgo=;
 b=DexHvuKU3rWCESdUv8zWilZjNOxs6xvejK5zQcsMfZ8Dh5bNSNa3fCds8Vqixjgcqo
 qyH8ftOWj3J1LEFcAFBtG5IRgjM6Yqob920dUecwjqhpByelu7t9DazEoK8S1z9cGwsj
 PcpOPvUhXcUZTEG7lw9LnUjRamxQt+iGwS7vOLhUkAgGNKjqAtKePRvIysnFKWtLDeHf
 Qn1foje3WboIbtVfQ1SAtV6ZjaboNw9xWORtiLhGiYmAHa4BymihVtmJhgMSvJrtXv+/
 RouEz4jXevwxm61IEzHive482chQOrU6U/ecDathrM8ETztfONMhZBt+1EmsoPct7Uvs
 uvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750787640; x=1751392440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsQHVm/OyW/NFr6cysTM72YPPcsE1O1Z1YjRSYHSSgo=;
 b=U++UB8diMBMbIfqNuPeSQNrfD0amQWsdO/b9DecYUMp//It0E9pgYMcPBC3UKv5eF5
 Mg2bo06KnImpVrTNDO2BhRGksRRIJj9BoVM9FL9JIDLbfwZudBKFrw2e7NW0ZAAmmPms
 VdBmp7Ypxulu+Phk+aQur+DAD/mX/JjiiKv1kkT5ZFXHezdOkmrfJcNIb2M7ohw3xZcc
 NRtNfX5KjFnDMA4FS9c8qbc251pNfNbvu6JSoltYPnoyB8ON+upTOEKNhkeH5DlbwImK
 gpSqPHH1oQjOP1iMeH3AHrwhVCqvTdB3Br+GAQAzoHn0AvUW+gCvvrOSR8isAF9Q6OMj
 RqTg==
X-Gm-Message-State: AOJu0YwfE1SC+l/kVoDRrTdTxQq/3bw4G9Oh1krygGbKa6WsIvpIjWuB
 OIqnSEeDUHJd7zQQUtzHudoULcNd1iq3cDdLv+v89nNvyRocYmJjVCYOwCxZx2e1XYU=
X-Gm-Gg: ASbGnctfNZqe2GZmnCCEwKfY2OHs/l9z5YCEM0X3w58B02dn6IjiJigBDyqYuIGB4FN
 dwtCYquMejlVNIx7JL14dprMpuDH5gq/xNg+Qx6KktqdUq2UEFmxt8+5IUhoKTEd9es+ECyKwC8
 CzPDjxzIaU/ShattVchAEoXY2e4YkvLtQoBc1N665EvIG+WKi2KaeCXO6K9nmVdFYkUYk3X61WX
 gb+tnZsP7XSQPTkG52zU7YWeaq1blzhhXR/usejKi2LbH239cv0V6ti42D/mUihT7DuTMkUn7g9
 aG+fZxzYYmblvREALCTkjbyRnumiVaOvmXarA10YQFqnTmJSAv9j++oZ7Ps46FlDO6OcJO5A
X-Google-Smtp-Source: AGHT+IHghreWfc60aerczfg+OUSq06KbHz+yVlpzwBY0PemmjUKg9XMQCVWyVqwjJZ1QYZBtSdkc4w==
X-Received: by 2002:a05:6a20:94c7:b0:220:480a:8dac with SMTP id
 adf61e73a8af0-2206a12e7e7mr7034675637.13.1750787639747; 
 Tue, 24 Jun 2025 10:53:59 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12427b7sm9318153a12.40.2025.06.24.10.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 10:53:59 -0700 (PDT)
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
 Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v14 8/8] plugins: Update plugin version and add notes
Date: Tue, 24 Jun 2025 10:53:51 -0700
Message-ID: <20250624175351.440780-9-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624175351.440780-1-rowanbhart@gmail.com>
References: <20250624175351.440780-1-rowanbhart@gmail.com>
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

This patch updates the plugin version to gate new APIs and adds notes
describing what has been added.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 5eecdccc67..c450106af1 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ * - added qemu_plugin_translate_vaddr
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
-- 
2.49.0


