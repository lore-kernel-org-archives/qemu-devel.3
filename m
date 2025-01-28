Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BAFC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmU9-00085u-VE; Tue, 28 Jan 2025 09:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTx-0007xt-Bd
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTv-0002Lk-1v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso42395915e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074140; x=1738678940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCOhYMyVhf/9MTlWJYC1Pyb8EOr+qnDpIx/K4OIle8U=;
 b=HIXX8jpfYmx3orluh9tJuCSgZoXZhUMxVWmCNBwLqs+lQ2cOELDtbNhEi8FIn7KMTG
 D9GZrP3o5Rilow385pzHojPZYWXLFSKONzg9KyyLCpoD9iQj8oPEWZIK6c/Mq0GJ9C9N
 OfBXsSUVdQUSOh8+a844BI9ZyO9bz7JHyy/GxfQYn15nEjaOPfgOINdvVNMnSwWq8Qgk
 FrerrPoV+7O9Wvr7VnaFC37p4AZzSMme2QfEe0PkLnpa4EfdrlNKBi3wfLMwwrudZr1a
 72xjRdu1LEKn5qOx7UCwVbs5iGuYEHahyvqBz+oUIVf27wiMgISfZ/viswW+0f7Eo2Zh
 D1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074140; x=1738678940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCOhYMyVhf/9MTlWJYC1Pyb8EOr+qnDpIx/K4OIle8U=;
 b=Y69Nu9Tnx/7snDTbOEyFzhP4RlHM+RrQqvuO/fcAKJov8X3kcvykYll/WdL8LrwXFz
 KkWbYWULLLUy3UPvylJUliedgLa0S69TyFMLXEwMFJXfNUIfVrNCIdb+RF0/fPXPDurC
 vBWK4/epo6DophsrXfvr3w4rHmaBU6qE0+iCSC1kGx/VXbxCC5agJ1dOuW9G7Qr7YqjB
 lVEQbXoT/KZXKCiOHpVkHKSZzAmoZ0cSQu30EqM3arGhHuwuERJo1AcH4w+cEM0i3YiY
 smZR3xcR4wKXGQ0ULIzgecJjWLT6DMo21FfLvcRRVdVCckLvLz7acEaTubgqc3Jj7jL4
 K/Wg==
X-Gm-Message-State: AOJu0YyOUSpTrPb/fkuv3BfAAHqVIjriASwsgH9IffBBrC+WydGtFkDd
 eEGBDO4zU2W1YTwSNxe0zyiewFU7zDMMP92dd4K+K0F/cTbEY4tAzT6Om6ZhUeqfYLjhltMWR88
 +EYg=
X-Gm-Gg: ASbGncuovb0nUC05K6IyTE2cdeCvJo5U1ys9YZp/uI4Gwm399GRlYhWRb5l0LCn7/ri
 9+yGeGSTMN3uG+7uosHxx7CVUCEgS6eNTIrJ0netkMg+0LBwE5ypnXQaF5JNnWee3CwgX3hlfLH
 Wm+aOd40Ppd1bJM9uYRcblXwTIIaY+khv8ora5TNkyADOHyTigxBH4jVxyrYdJtgRzHOUXLHFIw
 5AXGv1aC7M4oIik4PfGyunBIOoZVj6OnS+FDwuWgl0Fwm4pDUlqpuJvYls9ZCb4F8HDuwLBW0Ub
 d8Tji/uUVlnZhKYaEhUsE/EJxomilk9qD/YZErQ/gR96dyCvkIzlPr+IsZCV8OvrAA==
X-Google-Smtp-Source: AGHT+IE44lMFstrRJbbKMMn+hBpz79bGQD7lLRHTYaowiK6y0WzRah7ztkDdk12TT/+zj/uGA78k7A==
X-Received: by 2002:a05:600c:6c92:b0:437:c453:ff19 with SMTP id
 5b1f17b1804b1-438d59b566dmr30503145e9.14.1738074139917; 
 Tue, 28 Jan 2025 06:22:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57325csm172106435e9.34.2025.01.28.06.22.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:22:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 5/9] cpus: Add DeviceClass::[un]wire() stubs
Date: Tue, 28 Jan 2025 15:21:48 +0100
Message-ID: <20250128142152.9889-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/cpu-common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index cb79566cc51..9ee44a00277 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -219,6 +219,14 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
+static void cpu_common_wire(DeviceState *dev)
+{
+}
+
+static void cpu_common_unwire(DeviceState *dev)
+{
+}
+
 static void cpu_common_unrealizefn(DeviceState *dev)
 {
     CPUState *cpu = CPU(dev);
@@ -311,6 +319,8 @@ static void cpu_common_class_init(ObjectClass *klass, void *data)
     k->gdb_write_register = cpu_common_gdb_write_register;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
+    dc->wire = cpu_common_wire;
+    dc->unwire = cpu_common_unwire;
     dc->unrealize = cpu_common_unrealizefn;
     rc->phases.hold = cpu_common_reset_hold;
     cpu_class_init_props(dc);
-- 
2.47.1


