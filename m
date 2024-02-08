Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC387C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 18:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY8uM-0005xe-DZ; Thu, 08 Feb 2024 13:13:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uB-0005VB-JM
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:49 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rY8uA-0006rK-3V
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 13:13:47 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5602500d1a6so233246a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707416024; x=1708020824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2BaaqYtSB0f7aHxoF7miID3EmqxQDE1kM5wTAvRNjM=;
 b=GeQjWD0hwrVNlRHZmxEPTP6tyQcIhdu7ThSmsg3JuAQyfhnZ/iBw0jXKD5WFZfuLhN
 vea0W1fmtIOccNqdYvLjUIloC320gDzXEMHwHYMVlZLhOTBBbuJAmEiOYjEEqFE0StM6
 AhKztkdodNRCBgmHt/SSPbbm3XPYAiPOisXftLvJ1VPBRrClj5WVXik5w1uwObDrcjFX
 mWF6AviTpDKxZcEhBGhmRuLiX9igkG/9Hqy90nbcQ5cU8e4FEca4GwbrqrcWrUTTw8WL
 QL1AUT/vI7ZYBq7SXIayileKeOx2hTo5TN9OTv9GT7hmCxlO2+vycmPjtH+JWBh99xBL
 gMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707416024; x=1708020824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2BaaqYtSB0f7aHxoF7miID3EmqxQDE1kM5wTAvRNjM=;
 b=dGh2iMObraasJTsHgSJ/joTvQiodALVnNZCdpuuIUUQ1ZzYO8JGImbZ1k69ssFJlD0
 TTKH9/ckLJV5GMxMYx9HlYWGPGnxcDs8kRUdk79csv/FDtjaxeydAO+jFtP/I460iiZO
 qBYiZZ89qVv+l/gl+asJX2tzjtvy/wg9ERzARcBRDtgzA58ac1BHxjnu8gyAfH5zbmwF
 Djxp9GfRzVWFZ133NRQhuHEqbBULNWWmYg4Riah6L+o4fR2Ymsb9ooiEwKrbng7hYqm0
 8QPRYrNqoiz7DAGluSrk8CuSrrImuUuGGO3NK64yV6L3l3NGI88w4Vj1mIJ+kqW/Dcaa
 b9BA==
X-Gm-Message-State: AOJu0YwDthDnunGz6cTDN5SHFPD0Oa1rTO6vPTNp+b3ZCxWMaQqbDnIH
 n7MTPwJDaxyrFmGWNN8m+7XKHztQXz86eALTygKyH7IzwtXNSvUE6SRtKlyM/Fr91xR1IY4OlgW
 7Sqg=
X-Google-Smtp-Source: AGHT+IGxwoi74fFBhOMg2OjuBbKBODTBB9ePImyMtyF+HtSx56zbCN5dGJwNT9kE+q4vc2QyV/e2PQ==
X-Received: by 2002:aa7:cfd1:0:b0:561:1602:949d with SMTP id
 r17-20020aa7cfd1000000b005611602949dmr30642edy.24.1707416024131; 
 Thu, 08 Feb 2024 10:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWicqgbrRVVwmt+MjebO7v6rOOJM9EID8Ep0AD2RCmrZjRuPz/y71P7YBizYQkNbJCycYmDF50cJxHGydKsrrdguYSifoUEX87Hm6345qbhm4JJFsFTd//9NccnRs9w7q5aPE6NjpDk/3kXPcVY7oOiFZ8JFtF/peJGt/xfc4KL79ws8OuNzkKYkiCrb6+dvnefJeEOu1yXCiPRn0YW2xB9I6Ln7ng6rqVI9EkR8RYm9ViEkseqdEPTQmzJX/mytTS9Av2VqT9JbDIREFmbdrUDMF9yeq7QERypi46BCw5cIHMTPO2UGE/NqjCBHlLY52unYWlY8HXzXSw5mJNcXMH9IA7GLjSAdcB1e4aGms7zXd1FCx28TZHQgrbPmmma7zf8oONO/rNaEuIIBz5xN52d8WBkLp0JDts/Mw==
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 cs16-20020a0564020c5000b005611d0f7339sm409781edb.41.2024.02.08.10.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Feb 2024 10:13:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v3 09/11] hw/sparc/leon3: Realize GRLIB IRQ controller before
 accessing it
Date: Thu,  8 Feb 2024 19:12:42 +0100
Message-ID: <20240208181245.96617-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240208181245.96617-1-philmd@linaro.org>
References: <20240208181245.96617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sparc/leon3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..0df5fc949d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -263,10 +263,10 @@ static void leon3_generic_hw_init(MachineState *machine)
     irqmpdev = qdev_new(TYPE_GRLIB_IRQMP);
     qdev_init_gpio_in_named_with_opaque(DEVICE(cpu), leon3_set_pil_in,
                                         env, "pil", 1);
-    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
-                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
+    qdev_connect_gpio_out_named(irqmpdev, "grlib-irq", 0,
+                                qdev_get_gpio_in_named(DEVICE(cpu), "pil", 0));
     env->irq_manager = irqmpdev;
     env->qemu_irq_ack = leon3_irq_manager;
     grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
-- 
2.41.0


