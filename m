Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3DEC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTUJF-0006uL-EH; Fri, 26 Jan 2024 17:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJE-0006sr-9d
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:24 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUJA-0003Kh-7E
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:04:23 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55c2c90c67dso588865a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306656; x=1706911456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhPW+/fhD522LvSZgboHJx0z0AbZf2+RXOPHpa2tqdM=;
 b=ZecPfz1VZW8W1c/ZP+25+UeG5ppVZTN18R9j4VrE81fb2ujT//Yaf2BcaFkw/fmMT3
 syqAPOCDk6pOx6n6ScwSdjReuTr93/HIvlCXr9m3kPuM7FvqNUXnszRwr7Aa1DASj3BG
 KxoV6HFBkKuJKm2Mf5ATuCXvhffhOxqBQU3SKIIGfMtLn8gVLW/WFQxRuyNpI1QNI4SO
 SdyuPRSYESilq4Y+7S9Fo1VHw7Ny6eVsbfSk39kjvEVV7NywlivZTpK7rSH6tnUEHxQT
 x5+SBg/X2nMYSwUbqiJ+8iL8zEKnvtToONh68FqrgWm0CY38Aau3rrNn21QAcvUTCCa3
 /10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306656; x=1706911456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhPW+/fhD522LvSZgboHJx0z0AbZf2+RXOPHpa2tqdM=;
 b=LFsWK5ZbXRI3ENlSfH8x+bKLiwZmOlYlCJq1UZo6wiPChB5E3u8RLrA2nJBGyKQ59l
 E0gKOysQ/8W2ARxcgpHnokuZDpxsf0iCvJnzfYtqYgQcgol8f8X6z93CsFBmt1Se3KxC
 TbHfefKFN7JQQfKPqMigkIdM/Jtpu3MV+pM/JAkPMTYoh6PMHMlXr5PT4E1gZabvWWkM
 fYNlmawT4eanc3px9ZPzEKRKVVb2l7AMyotOidH7vTKvGOiEqrfJZOYCZpLYiAPW5U0b
 z8+XvGztScjeaJ1xilFQaARBFIjOContGahqo/5UPB+A7ustwapxjNVNju/GM9MPTZGe
 1B8w==
X-Gm-Message-State: AOJu0YylZ43wVRrXtCOa1TTYHd+8ycedQ+yJCzGcT9wym1K4kGzUBIKc
 aYlVXeWBSGrPpHFQ3Pemc/ErDAra+VRJgFgX5UXdXRf1/Un7E2n5pguFYB+42Hcrnwq/H57iY+K
 7
X-Google-Smtp-Source: AGHT+IG4Wg8rywDTMVuRM7GkwEmCFZtMm4l+BGhG1j8wou81QLrVUKTsIfgDuyEQppKx/hJqB7/64Q==
X-Received: by 2002:a05:6402:34d4:b0:55d:357f:1837 with SMTP id
 w20-20020a05640234d400b0055d357f1837mr298106edc.1.1706306656478; 
 Fri, 26 Jan 2024 14:04:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 d26-20020a056402401a00b0055c6048544fsm1007886eda.66.2024.01.26.14.04.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:04:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 01/23] hw/acpi/cpu: Use CPUState typedef
Date: Fri, 26 Jan 2024 23:03:43 +0100
Message-ID: <20240126220407.95022-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

QEMU coding style recommend using structure typedefs:
https://www.qemu.org/docs/master/devel/style.html#typedefs

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index bc901660fb..209e1773f8 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -19,7 +19,7 @@
 #include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
-    struct CPUState *cpu;
+    CPUState *cpu;
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
-- 
2.41.0


