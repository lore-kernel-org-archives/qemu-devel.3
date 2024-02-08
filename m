Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C378C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8tk-0004gS-CH; Thu, 08 Feb 2024 13:13:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8tg-0004P7-KJ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:16 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8te-0006mP-FV
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:16 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a3bbad234feso12490666b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707415993; x=1708020793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LcvVs02z5wCqQ7/8i6+yu1iXa6S9Xb47UoWtCZNINM=;
 b=kLChST3MpqAINYSWIKQ7SvZsfDAj4eCpLU11rm+axmFfvUj7LaHPCR4t/qmeAjWGrq
 mBOB9jsrAcSGK6OsZXaiqPewx0VjnuxewG/OI9vyn2MCwA3s8PeiKNdouphtuxd28kON
 1sD5+5YepU0/e2ovZbQcB5zRayxRxEBcGTgXsPCRls/3TOwYZSRDBV2/mNRIXSx8rhjz
 qh9HHkv/acwSNwjQm2nx4HOIWAGwb9MAFu5f7yIpIcba6EpTvPwLqXvzGI06KWFqLTc8
 x+g+Y7oIt9A+Im4769VpNx5dJ8hkJD5pixXB+bsTcNkENJiCmWkTSLCWZ+e6pt3bSj4X
 7XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707415993; x=1708020793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/LcvVs02z5wCqQ7/8i6+yu1iXa6S9Xb47UoWtCZNINM=;
 b=mlUTLnp4YWSBBeEkTpcGOs78dLfCh2JRrmqKRpVJ1nEu4tgllHmnldT4fSXmFhZW2G
 j+QQRK8KPbu20s/tXnV56mvSOssZBS/E2jBltCuwS4e8bKjjWXNSI+BUyC2+bqE3z+Xe
 MzVsBCL5BJ3PGj9KPo0YIezIG6spRYGaMgdJoumAUyylX5/654RZC3418KQ8mqJAroyx
 3S1s8cpDw5guvsZBv3EOBZlZG4rHmkXMWzRxiEtQL3tyZjnSXcp5EdK88v6x7rB0Ntrd
 zMa+FMqKyG6um2NhEt8IzK5ip87iFJfN1PyDppNmLhaEIyJP0y/SPqy/2gtxAV9Sr0iS
 oVWg==
X-Gm-Message-State: AOJu0YzwXkLOpU7ZBLOTvHsw0Ce5eVlgQQzLOC+RIAWMttlN+BOrBq+c
 kNZSxSTAnmbz61m39XG0iWL6z7SwGWiidEp3E71dU0Hgu6RITiAXocEXzZtoAK7TRRZ6PTFVnZl
 /Sco=
X-Google-Smtp-Source: AGHT+IF9oGbnvDl4+VyGCQIuejjirp+ANIadCNr6qvOWURsIzMZTFVNFqsnhNDl65/uRZRDtVNRy2Q==
X-Received: by 2002:a17:906:35db:b0:a37:5bf7:f64a with SMTP id
 p27-20020a17090635db00b00a375bf7f64amr86361ejb.41.1707415993010; 
 Thu, 08 Feb 2024 10:13:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUZfWjveanJQ5aK1sWpJZqar0gAVGSp61K9g/bixFm0BOrX7dgH5vTaB5OvNGW+/SnuYXSKAt6OUtxnBup2L2Rjq3Z0Akmmd526UHBN1ZC4i46OOstrEDooU4Cm+WmoI5FHAk8cMrg/qWOcctApmm28cbxVfMUPxqYFIiUvaa5v7Lzw1ZyeeoE0Zpbi5OV8bqeoJFuKmqlkC3f22Q9I3McCVYr04T0PwmSfcP9YQOyCGRV9VskMzRoT6is3d9fi5ktgcv7p4J1gpUEv2IuJzk3+/djLw1+/SglqTQ06alvFjIAG7zQ8aIReGY9o31bIvyrKYUHCcVtu4/Sr7o/XV6zFN5GhlPaHtStglkU/0ei44duEijInvEoeHqkJbwDHeSaC
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 cu12-20020a170906ba8c00b00a397c2ab4a5sm297011ejd.120.2024.02.08.10.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 04/11] hw/i386/pc_q35: Realize LPC PCI function before
 accessing it
Date: Thu,  8 Feb 2024 19:12:37 +0100
Message-ID: <20240208181245.96617-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7ca3f465e0..f67e5a55df 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -250,11 +250,11 @@ static void pc_q35_init(MachineState *machine)
                                 TYPE_ICH9_LPC_DEVICE);
     qdev_prop_set_bit(DEVICE(lpc), "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
+    pci_realize_and_unref(lpc, host_bus, &error_fatal);
     lpc_dev = DEVICE(lpc);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-- 
2.41.0


