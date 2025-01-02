Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DB0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMsx-0007YF-Iw; Thu, 02 Jan 2025 10:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsu-0007Wg-87
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:16 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMss-0006Xn-Km
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso75437525e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830792; x=1736435592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iv6ecKkSpnKeosCOJXavZ4qKTQvySBvi2gGLMbLWDu4=;
 b=IGatA4SK4UFD1m3ScgBNDMXscrUvzQCOuDG5wQ6WssnKiTSnKO8zSiS+aWCCfyqqwX
 HrPDspB5XixWt7zEhAc/VQrgmWQweYZPgMFkXcpBTOmSk+5cG/hXJTqNEy+YW8f4fuOf
 5xkhZBlbmqT6+uGN6NtSitlVYZLQriHBT8BvpJoVQmcwTa2yBCt4nqIcfnreaeMC4uQ3
 38L5rC6VxJLDe5EOdEsO1TPdU0GZ82Qj1h1mBD2UhGDfE+6qN/TBD4WnKsftcI8r7Q9S
 3GiTvN9+QJTPWfHEeQTIvUdix95v3swyWJ+V+O519LX9kIO/1+vdKHhSURzOuPRSQmO4
 /0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830792; x=1736435592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iv6ecKkSpnKeosCOJXavZ4qKTQvySBvi2gGLMbLWDu4=;
 b=a3QOlLvpfWSdH+wIZ9BLP4isjmuJ9Qb8Cy4Kj/GPN6UqbmI8gwX+7/WIPvqGs/pbTh
 YHow9x0VP08i4ktAbyxRUtw7ciqKZ6wqbBM3ZH3uoX+WmMkhFZKaI6la9qmSPcbtvt5O
 Uwfe1po9nwx6rDjV7v2DHUN5sXaz9bIb7xzX3tKWbg/2TsWDiquS8Fd/6BGalE7t2jiV
 eut3uhMwUHvUkFJ9LDpeOLn8npQlTKiFvuuWRUU1VOH5WOE4tDsUoKoc5H4267kks/Cp
 0uWNlm41qlWB8vvqUIdNWbZYgwT3d81zbV0t+1cxzC3+57awUugWjDMZgN75QWyV8Acy
 x0wA==
X-Gm-Message-State: AOJu0YyfW+jWoWiZghs1dnpX+l6fSia6eYjUGSiBRWWhEUadJ6lnhSTn
 fRF9ynUNbQY58OgVcMEgx4AehABdCrDpSAKEs8zaTucEIxWXZI6XIQXXb++jWpLU1kpELjQknx8
 Gtgrrew==
X-Gm-Gg: ASbGnctinmpKqJn8eJHlPb9N60TMNQYsy7ufAbQzvhcX4JIjttvjenckMo0DMZ+skHW
 /a3/GM27zU7GydH/KrZnYhLD4mMUmI7C9cTY6njbWtkgtZyC06ZYc6ca52jDUm8fVL6zo2gwh3n
 tx+uteTm88evrx6nDLiXzAMphL7tmZh2WipB45rqSCnPrz5UZLd4GSipoQu0EKDTRQwUfLGj1JS
 8NvMizXxJUOlHP4xMPEc05qwE28j26DIaY5SHXjQOUHNnLHZqVOC8vBU3xnmXtb91E1W4gvvC2n
 AnHNcr9B/R394Hvylyh9WCF1ySDf40c=
X-Google-Smtp-Source: AGHT+IHiChyrAT2ubQQx11banri10lRuItyy4PvV+ptJyezLzBOFcoSB709RAognxpV+sdotF6dPdw==
X-Received: by 2002:a05:600c:1f85:b0:434:f2f4:4c07 with SMTP id
 5b1f17b1804b1-436686464d9mr427504785e9.15.1735830792360; 
 Thu, 02 Jan 2025 07:13:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e219sm38820123f8f.84.2025.01.02.07.13.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 05/10] qdev: Add machine_get_container()
Date: Thu,  2 Jan 2025 16:12:39 +0100
Message-ID: <20250102151244.59357-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Peter Xu <peterx@redhat.com>

Add a helper to fetch machine containers.  Add some sanity check around.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-10-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 hw/core/qdev.c         | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index bf8a0ee6486..bb4b085c9ce 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1027,6 +1027,16 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * machine_get_container:
+ * @name: The name of container to lookup
+ *
+ * Get a container of the machine (QOM path "/machine/NAME").
+ *
+ * Returns: the machine container object.
+ */
+Object *machine_get_container(const char *name);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index bc5b60212a7..9973e029ffa 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -829,6 +829,17 @@ Object *qdev_get_machine(void)
     return dev;
 }
 
+Object *machine_get_container(const char *name)
+{
+    Object *container, *machine;
+
+    machine = qdev_get_machine();
+    container = object_resolve_path_component(machine, name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 char *qdev_get_human_name(DeviceState *dev)
 {
     g_assert(dev != NULL);
-- 
2.47.1


