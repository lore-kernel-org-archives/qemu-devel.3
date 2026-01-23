Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4910ED74EE2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIno-0007Qy-TV; Fri, 23 Jan 2026 10:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInR-00077r-At
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:09 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjInP-00036A-3j
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:10:01 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so17096085e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180998; x=1769785798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zd1I64gLFEX+HyqWTrjp/BrmEmETb82V0nNznQxNN2w=;
 b=Vzw68KQGVFFqNZtscHGehMm2/OgjLjAnBx1VW03pRqQfCZ5HGD2J1gggx3QxPP34iU
 Bc4WMD1UTLyW0EkrEdKXLL5FENXY487K7kNlf0BDkGE/td2Iw6UlZhOM7Prpvi6or3lR
 yf6ITegc2qbkDPfz+0XNY37Bvib/k85msvo9RhH/VS1ds1iqURMzv+0ugsNzmL1j5Mjc
 dC+2Bo/ll1lRup+XwgNH8owocBun+GDX2j2dskmsAA30tourptxZDd7w3hSwe3LxRvJv
 oxQ8UOfMdZ7hUF4uXUimzQipItS38MZo9xb3l7iLBD6T6GPqwt0zCTBlDbFcQ9DaVvZm
 f6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180998; x=1769785798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zd1I64gLFEX+HyqWTrjp/BrmEmETb82V0nNznQxNN2w=;
 b=h1bqcqhEYUU9BwjiXQOg+b0She1Ahd7+avnZjn4GJtWG9C2Kvu3Nsoan5gVn0+leov
 h+ogdFsiyOtJqQIU2Y8owTLCEp5+XxP3jMFBwBCK9tju1xNyvP+BWRs3Y1Iup1MvUdUA
 YHJxz/SAihfzIkH9ZodR7entxgsA6yZoOBwIXTeCXH/7tafzIwLQmErPtVXH2yS/xYZ4
 FKy6VSjMPq1moRTR528r9SuCRYFqjnGDoBOmVXjysHSIAkYUJOLXt33yEFd2LK3nEiZo
 8BDvz/AASvr1Pvu50iA4UWby+CSzcv2VBwt2POF0/ahXixTsFkXo88iEyHZqRxKLZSNb
 ksOA==
X-Gm-Message-State: AOJu0Yz3VczlY0MmZ9a1lgKOgpsOmns2kLruXu+EPx+C8VCac17XNuYJ
 Mtm9nQcm8N27mJ9v+teU1K+DcMt1do3ySwfzyNTfBGxdvjUYLaOpA+DdyLMU5qCNgjRboMtYS9/
 jNl3Qxp0=
X-Gm-Gg: AZuq6aJHQQGH3NSObEGMbC7wtMw3MmMXU14Rkj/A6jbj/ecrPJ4B2Nd1gOSSSC/VYtE
 vZPkLJidqg1tZnMuxikgPEbYFvjfQJZU/lx+uNgIZ+fRh9d7H+cadECBBaXbBUQHrkLWQvt1JBb
 rTVlZXoCSBoRZvfgfU1wcqMBXvcg0sYuvaxVe245+1zUpSD8yF8ktBfG489M0oNGjfukkYtidFe
 lLbdsws3ZF5fkUEZhwBeai1pqaZZvKpNkTBjxJCdfdNZpDqBMw8o554bvBxh2QWJSLeTYU4cbZi
 w4AST9hwPF2urrVBOVAdjE6+JaE5BomNnMAEK2vHoKWwHRaiTapiQyis2zR7Nl2rRpD5V8HL70D
 g2gexlPigJWtSvZXvG7L5vjberfHhRhl96bkoW1iczxv1gNthW/GEhANjqjkqv9Wu6QH8S9K8Hk
 NrxVijXpEAaOKQ7Yf8PhsWS06daYYMYQkysSJSCPGsWPA2y4Q88OCIkndvVvQ9RXs=
X-Received: by 2002:a05:600c:524d:b0:480:3a72:5c10 with SMTP id
 5b1f17b1804b1-4804c95c6e0mr61071695e9.16.1769180997455; 
 Fri, 23 Jan 2026 07:09:57 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm8255641f8f.25.2026.01.23.07.09.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 07:09:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/22] hw/intc: declare GIC regions as little endian
Date: Fri, 23 Jan 2026 15:09:34 +0000
Message-ID: <20260123150941.1877768-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123150941.1877768-1-peter.maydell@linaro.org>
References: <20260123150941.1877768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The GIC should always be a little-endian device as big-endian
behaviour is a function of the current CPU configuration not the
system as a whole. This should have no functional effect as the GIC
cannot be instantiated on a BE system but will help the single binary
efforts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260121105932.135676-3-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 4d0cb125a6..4d4b79e6f3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2062,38 +2062,38 @@ static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
         .write_with_attrs = gic_dist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     },
     {
         .read_with_attrs = gic_thiscpu_read,
         .write_with_attrs = gic_thiscpu_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     }
 };
 
 static const MemoryRegionOps gic_cpu_ops = {
     .read_with_attrs = gic_do_cpu_read,
     .write_with_attrs = gic_do_cpu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const MemoryRegionOps gic_virt_ops[2] = {
     {
         .read_with_attrs = gic_thiscpu_hyp_read,
         .write_with_attrs = gic_thiscpu_hyp_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     },
     {
         .read_with_attrs = gic_thisvcpu_read,
         .write_with_attrs = gic_thisvcpu_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     }
 };
 
 static const MemoryRegionOps gic_viface_ops = {
     .read_with_attrs = gic_do_hyp_read,
     .write_with_attrs = gic_do_hyp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void arm_gic_realize(DeviceState *dev, Error **errp)
-- 
2.47.3


