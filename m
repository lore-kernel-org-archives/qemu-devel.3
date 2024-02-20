Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3289AC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsZ-0000QM-Bv; Tue, 20 Feb 2024 03:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsW-0000L6-Qs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:28 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsQ-0008D5-0Y
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:28 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3e891b5e4eso202764866b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419200; x=1709024000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wInO8bPcUIy1thV+iCEEHgOMyRBvhF+gY8bxTe/IrWw=;
 b=tGsV/9nYK6KGO4LofCwDwwVgJSsrhx7luTmm/pG9ULXII7EbDPTuNOPGPiL2wP2Nev
 aIzMhdO1gprBauDsC2myCXvtyO/+dTnYtDrktwVIQ4f69u3b6PPoP0MKqC6b8OGcOZip
 8ks7qTcDetjZOZOO5xjxPfd54z1bHI/n6jClh0jIA3ZrJLzgaXJbKqfcmNzJFQKbcmKK
 /OcP0qgspzUApuJEQoeaev74voMv0RciL0o1KefSPAVgfNsdjgu0neWn+gcdwvxonxTP
 EkZ0iGS/sgZlBQQvs/ZFyN9/dKVuvDjRVkmOilfkK5jtQPpLCNmoTGhHd/lr/sMzs++Z
 PnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419200; x=1709024000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wInO8bPcUIy1thV+iCEEHgOMyRBvhF+gY8bxTe/IrWw=;
 b=M+qEbXHXrgbrqYr5C6eqM9KHpLEfzwacbXxZnh+kR1dOP6F/m6Fmb/7IjYIZSJH4Vm
 vJ9zEAXo3L9m9Ma4Uo/guwX8zBQJ7RyzXZ9G7gj1+zw2qRVECmlErmHaNeFg/CMzjj38
 qTEXvMezeUGoyzXN1M05wItDRqLQxuuQ1eas1kZilqm7Cx0iB/IUF2oRk+coi6lQ+GvB
 X43F3LINvrx7EQe8WFCD4VF6ezqKCxnSj6RUV/bWdrd5hY1SP/+kqw+Qv5OIQ8hlV8Oe
 1PUeTWDHx042Mnv+t+Ut0LLZbW7jbaEnS/5ZCX0oiPjzU/KTr6LFUm/ovS2TPhd5AKRM
 YM8w==
X-Gm-Message-State: AOJu0YwLCYsFz4EANPl2/X7fMqlgozV24iX9wCvS8wz3Pe6rHSWQCQZM
 qSrMU6Jfvev8MEYpgeSXdPfL0n9JHzj1ZNkV6bBMjusrRJcPU/udebBzSIpy5vTnAOtKQD8wwN1
 fu1E=
X-Google-Smtp-Source: AGHT+IHXxMtbuZiVe7Aa8Mle5ntWAs+56CJ3SEwLgEMUnoQh9LyMVjwHfUu5NBXP6rkZvHu1DQv+QA==
X-Received: by 2002:a17:906:ff53:b0:a3e:c1ec:7bff with SMTP id
 zo19-20020a170906ff5300b00a3ec1ec7bffmr2476895ejb.68.1708419200743; 
 Tue, 20 Feb 2024 00:53:20 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:20 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v1 11/21] hw/cxl/cxl_device.h: correct typos
Date: Tue, 20 Feb 2024 10:52:18 +0200
Message-Id: <76ecf49e448d00c6b1b09446c832e007dd1f811a.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/cxl/cxl_device.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d8e184c4ba..279b276bda 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -268,7 +268,7 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
 /*
  * Helper macro to initialize capability headers for CXL devices.
  *
- * In CXL r3.1 Section 8.2.8.2: CXL Device Capablity Header Register, this is
+ * In CXL r3.1 Section 8.2.8.2: CXL Device Capability Header Register, this is
  * listed as a 128b register, but in CXL r3.1 Section 8.2.8: CXL Device Register
  * Interface, it says:
  * > No registers defined in Section 8.2.8 are larger than 64-bits wide so that
@@ -276,7 +276,7 @@ void cxl_event_set_status(CXLDeviceState *cxl_dstate, CXLEventLogType log_type,
  * > followed, the behavior is undefined.
  *
  * > To illustrate how the fields fit together, the layouts ... are shown as
- * > wider than a 64 bit register. Implemenations are expected to use any size
+ * > wider than a 64 bit register. Implementations are expected to use any size
  * > accesses for this information up to 64 bits without lost of functionality
  *
  * Here we've chosen to make it 4 dwords.
-- 
γαῖα πυρί μιχθήτω


