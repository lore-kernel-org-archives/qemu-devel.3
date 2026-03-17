Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2C5FF6E9A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 22:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2dMS-0007Qp-Tx; Tue, 17 Mar 2026 18:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dMS-0007Pt-3Z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:58:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2dMQ-0001oI-IF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 18:58:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82735a41920so2382429b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 15:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773788281; x=1774393081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5LwK4ZMpbwdwMoTORwTLtilm1v7SeNlN63Ch/P1NRjs=;
 b=F3kl4EmrPW/Ub1RS8Mx/LEqQqnhI0fdj0LYDAWyHm6kSfoyt4fcVAOMJTrGk6Bh62X
 4BflqVsUGNxvgsBd9687bgjTBzaDAlepNz53vyDGOm+ZO/LZ6f8x3NthkGjrScp9PR/b
 9tYN8jQ8RMgoqJIl9Fbp+FlYQQb8I9Qa+hU8wyRq03rk5FoQP18QcYguUlswK4SllA7j
 ktnhJ2GVbCRwfo3HmO2wR6knuPeFhEllcqlVFcl9tTBuepL8k/H0xduqZTXi3tixc4OA
 z6b+7/+WGfk1EZQbuzKvAqbucsbs5UoccO1bRZccUTBumzlmMdBMBG4xsu8RhvKzekih
 8EAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773788281; x=1774393081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5LwK4ZMpbwdwMoTORwTLtilm1v7SeNlN63Ch/P1NRjs=;
 b=TqS0uxgm+TLGdi3tETooeJ+tuAtbjYCGIpO7kfsmrCx+XbgXgCOad3jfKzdtq7U+qY
 WPzbAXraAcMHBOY/k8RKE05NLhtVPnD8xaVukq8cwxk0OS5dnhjmko2IJUWP7SmaoILU
 njo+CphkAo1n6MgyU5fNR5U73uguiypCRKmFb3PcllqL6FigUpBjnowZV4YtZaGX9C3Y
 ERIMIgQGXnFaxXkQQjR1ETrAOBlSByz1XbNsQVR1K/opG5W/fmCjnpJsMQwqO9IOS5Lo
 HHSJqlcpUXt8rUWltjv49lpw2Z5PBirVN3S7Q0B/3R5hsOMiZ06nuCz/h4YxN02F4EjN
 NkMQ==
X-Gm-Message-State: AOJu0YzFikQs9qKLrP78UzsuDGBOn8cRC/nD/UlDfEXLeVrQWWvjaqHE
 e9va/kSpNzSfxDTCE15qQZab62qs4XV8n+xygpAkTz6XMdMgFdiD60jATXuVB5MUS3WjbI7aBlS
 2Gek+Tv4=
X-Gm-Gg: ATEYQzyvxRhoBS4ECesyVQb2jl91v+G7N+eCLC3dxop5BL3tHtjgF/MUzS0VE13MWfT
 /oQyIL4HENzDDrrakhSNoS0k0BbqhaED66jaVC8XJCYLC+zkIObi//er/w6zDEiCosQUq8ztQ2i
 ruky7uYJR4YDqjqHIm5iQlxFQNL68AdfohlH0TJyYxRvf1rHCVOG2Vp/W/wBRBaquhdwcTqfgv5
 HP0iBtHHgfK+VCYxOH49dQXSj5QSJXbsUeIPTm01qrOOG1biduwPlRk4znxtyi4sZpln5s4fv5e
 IG3TkLcumwFI/8tTyyaOjGN8xgCzcl+QMWTN2tSgAnWYx8QvlmBZKahYU187xdD7SHR1VGvPoru
 3+8uIZ7DmBLMBlG/EfEwCZOjsMEq5tKE9CBzGRP+UNIwDkuTmEuMkf0XBEmxVD0570nMUL4Zsen
 UO0V8VdFhEOimueX/vK+VgOghh7wIsqiHPSJo3zziNJUiP1UunN6evUJuZkS2L5iYWdC+w8AMnm
 LL0
X-Received: by 2002:a05:6a00:4c0a:b0:827:3b1b:43e6 with SMTP id
 d2e1a72fcca58-82a6ae0d880mr793412b3a.21.1773788281012; 
 Tue, 17 Mar 2026 15:58:01 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bbe7cc9sm484825b3a.48.2026.03.17.15.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 15:58:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 philmd@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is not
 available
Date: Tue, 17 Mar 2026 15:57:50 -0700
Message-ID: <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

In case current kernel does not support /dev/iommu, qemu will probably
fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
since QEMU opens it before /dev/iommu.

Instead, report an error directly when initializing iommufd object, to
inform user that kernel does not support it, with a hint about missing
CONFIG_IOMMUFD.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 backends/iommufd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index acfab907c03..c4eb3de1307 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -32,6 +32,11 @@ static void iommufd_backend_init(Object *obj)
 {
     IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
 
+    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
+        error_setg(&error_fatal, "/dev/iommu does not exist"
+                                 " (is your kernel config missing CONFIG_IOMMUFD?)");
+    }
+
     be->fd = -1;
     be->users = 0;
     be->owned = true;
-- 
2.47.3


