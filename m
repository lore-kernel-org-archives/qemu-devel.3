Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C055C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfJJl-0007me-IE; Mon, 12 Jan 2026 09:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJh-0007g0-2A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:49 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vfJJd-0001Xa-Rm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 09:54:48 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b87281dbdbcso104322666b.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768229682; x=1768834482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wscBRTm7STUtvNgIyID3EdUtTJO2sL4HdK1iLXIRQS0=;
 b=bHV8lMkWX/RmKvbRUBv5KAvQQp9XTqy6wDaFa2hHlbbNLFzM4bjuzSnk+SWQGWStKi
 2rkiDpXA4GtnVteK9EwOujzNbsx15L4iQAemrIc7hqwL8llVUWGySQb/NwSSQ4Eor4B+
 jIRXKP0wAxgYCHrhpJOhkOL2GZ2Yw8ryeuBiQPdkWHvHb6gSfkQMmX04l3bPWPUgBvSG
 1ILkoxLjr9agvKyZ8j9M1g2yw/WBfXT23rAOYvS0rGQNQFszQM2epThXK7m2Hv8Z7Lb3
 4GiJ6Itb3/dfIw5yxGRpXbtwPEBaKf6cNMRUDzkf/BTpf4wqzER52uCJ6zFn5Zza61dB
 3GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229682; x=1768834482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wscBRTm7STUtvNgIyID3EdUtTJO2sL4HdK1iLXIRQS0=;
 b=kHVuS4GmGwYmMp0l1X7dv5kgGNA10ZyHOYLasDvNkWqanTy32MTI6kjnO6WQjRPGXG
 I38luICf8EAcz5z7QSrJbDKV7+vynJrPrnKQfAToBZdxSnFpSI77lLgO5hSGxk5QKMdI
 ISRB/eJZWtLk1M/whQZpMaYMDe0jkuWKX5FIdIQdrj/YZtNWQi/oONMRhFr2IEoW+HAG
 b0KvOuSFLUliGKMpWSACWsGn5jNsrPj62LOtul61QiNXbu9QvbvlvnaUG60uThYvRGZ7
 rVgm48b15YPC1G2INx4gJ1adZcLDbUkd+/cjyYhOLPMG1iQgIespz+mvqn2Uhw6/Jh3v
 76vQ==
X-Gm-Message-State: AOJu0YxGW4sBudW0ktjc+0p1IUIggNbH+ZvWcMzfceSVA9nYiGjaqWV0
 CQLpcIUFvY0rNPz9O7LwlSAgP3SL9Fjit9ACXH7rxRGanXkcIXpWHirI2WmMZxBm
X-Gm-Gg: AY/fxX4fcksS2ug46iZgvONuHY2jhh4sXvGIPNzz9I9Xzv4nwFOQFibz2wHr5K+mm3l
 Ks7Bj9n157dIkiOrDB+zIwGQE5ApWVbUcT41Ova79hwSN58TkVbyrof/2e1A8lmZql7z+quzYVO
 Hk7cXpigUMRF8bq0kv3DlT+WA8EZI3WEb2jvPH85XwQEbXNJT1OCfuVOfpz01dV4NpmcvxeNTYB
 NZaWrcTpKsHVyid5VO40hXBa/mmLoGpzRYFYopx2xwyYXlzWmyho4A2fP+4tNouDr5CFCirzMZT
 mfX0hqc3DDGF0TvIHVwPJOT9ekkJ2iZ9hlZt51erpNseslXsckaEWoT17l26QopuSv1bnLvciO0
 mvsC1kU2R/lXEODt8hm2df7Jl7Fl6GZqXJGYuyaEdzAIXq2rFXNxd5qBLrvPUsaaDk2FxeeGK8H
 hRij1K+yDr65okEYRAIYVUXcWGcb5V1Xz0ZGgAwIbojtm8TDNH+Hah6pe5JxziCb0/1a3mebRk
X-Google-Smtp-Source: AGHT+IEwu7WuTSHRhbEc9ACkxzfgXWJE7fekxK9tOyd5vaLjmsb2OmmWD9RV/pRI8f0kHh56EQdteQ==
X-Received: by 2002:a17:906:4fd1:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b8444cce26fmr1917157366b.22.1768229681474; 
 Mon, 12 Jan 2026 06:54:41 -0800 (PST)
Received: from archlinux (dynamic-077-188-226-222.77.188.pool.telefonica.de.
 [77.188.226.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8731f0718asm37387966b.67.2026.01.12.06.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:54:40 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 04/14] hw/arm/fsl-imx25: Apply missing reset quirk
Date: Mon, 12 Jan 2026 15:54:08 +0100
Message-ID: <20260112145418.220506-5-shentey@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
References: <20260112145418.220506-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Just like the Freescale MPC8569E SoC the i.MX25 features an eSDHC but
as little-endian variant. According to the datasheet TYPE_FSL_IMX25 requires
the same reset quirk as the e500 machines. The quirk was introduced in
d060b2789f71 ("hw/sd/sdhci: Set reset value of interrupt registers") for the
e500 machines, so reuse it now in TYPE_FSL_IMX25.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx25.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index dd670827ff..9e02063533 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -243,6 +243,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
+                                 SDHCI_VENDOR_FSL, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
-- 
2.52.0


