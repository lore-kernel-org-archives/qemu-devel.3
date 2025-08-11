Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E934CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVzx-0005Kl-2A; Mon, 11 Aug 2025 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzd-00054t-BW
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVzP-0001t1-C6
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:07:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso29538855e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754932028; x=1755536828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL9BjJEaO0GjattCvBT1sYPxfZkwHVSu+LlGdRsmcAg=;
 b=V8abu0MXhk47x0rElHb6U4LfPfhuu82xDMcWKcWrUTEo7W55rT36w8OeF6LN8rOsom
 VK3eBtojb9ufCF54hbGcORVUIviY6XUdasF3AIoTYRyFlL2bBhUa+LcQKuzJDfskQ31+
 F+HrjYd4VX3gGnfWmsUYIHULHuowjJmbjsGbiZMTmYZDs8/8veCVG3DnO2AmCRvdC9Oe
 mEeK0je60+SWjBmam6QDVX9XPxm+IgPtHp9AsNBRh7Qfoh+FmkqfzmCh38IwpzQ4usuU
 Haj2YTBWpxS5iKVMzAxHhXheMbLE8AtrO1I+VTsEZegCqLAQFleLClrMQfWTYISnxH6F
 8Zug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754932028; x=1755536828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SL9BjJEaO0GjattCvBT1sYPxfZkwHVSu+LlGdRsmcAg=;
 b=E5I47hiJysFfe8CUUtpNxWDt0ZJBY96H+YFwnev9tAGg8NBVn9MTiPXVH/oG1x3A6/
 duVN5zUQQs1E6ZbZNDauyC02HSfys4CHOYGEAKkIc1ZuoUtzz4LBLLtkfEwpOkz2/b1T
 HMbSOBTme5u5R/X/CWlnVQBLy78hPCVAP8otSGynoGIM9ZdjdPd3PSq54LUUCn5nMGQl
 DFMhz0/UZZfBc6bTLCyJltUfGe1s4EpnUJnlf51vrGPovrILGMnMxwOPfn7Ob0iIc5rx
 o8MBxcigPy5TF4SNjkXQnDv2X97CWr1qy5RO1Ebe6HtgUGkkCqLKPOw0kQ48QZNzDUD2
 4o4A==
X-Gm-Message-State: AOJu0YyHYVZRu1gNRLvbmpPx8o6dZhaHfpJFFu4U5OQuERJJAyOlmvGO
 GynJ/mZ9luW9CWz6shoWMdYLuFz0SDd01PekS0yRml/WpZwZWme59J3ciQ+yTOUwKn8ZQCme5fi
 OVolM
X-Gm-Gg: ASbGnctDhJ/QfDAH7dN7ZDHRXx0Y7ZpomkxND606+PmeXLcNwmsd8BSdRzx7Hjj5FDr
 K4vQ12V33ocm0OynAIyvSGbTxU3pYRraXrBwi/hHUvSZiLmj0VxVYwuDj1uyyBopFq2X+X1dQX1
 uv2uV7fw3YiVMM0JxWQDS1MyiwFtc9DQuYWIE5eiHmdk1JKRpVhyiiUy6kCM2qpAi4gJ3X0SdAZ
 WNcF93OLmuDRA0yuk/gS2wH3zIzt/vZMYACLHpBOknCtJ27GHjETrDR3iquXMIFVNXWOctdFNBB
 htETtDINEIM45HHTFAC7u6oMt2SD9rZc69tZE4skD7mRckTHKIefYDKl4qNSDR9gDmBUIJuucBy
 5wqEL6/Knrv8tp6KrYwrMKMLPH+K8LXbVnmP4vTLPuPk8eqSvv7S3T6Dp8qpw75R4MfEGcIYN
X-Google-Smtp-Source: AGHT+IHfoaigvwFcg4KswaUsW5gj91pCHoOh4NHtbdx2nxS2EGq2EkpPF+O3AaqXm2LpMC3Avw3iGQ==
X-Received: by 2002:a05:600c:1c12:b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-45a10baf6f9mr5082985e9.9.1754932027824; 
 Mon, 11 Aug 2025 10:07:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dcb86d6asm311891055e9.5.2025.08.11.10.07.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:07:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 10/11] target/arm/hvf: Consider EL2 acceleration for
 Silicon M3+ chipsets
Date: Mon, 11 Aug 2025 19:06:10 +0200
Message-ID: <20250811170611.37482-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Just a proof-of-concept...
---
 target/arm/hvf/hvf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 778dc3cedf7..d74f576b103 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1000,6 +1000,9 @@ uint32_t hvf_arm_get_max_ipa_bit_size(void)
 
 bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate)
 {
+    hv_return_t ret;
+    bool supported;
+
     if (!hvf_enabled()) {
         return false;
     }
@@ -1011,6 +1014,9 @@ bool arm_hw_accel_cpu_feature_supported(enum arm_features feat, bool can_emulate
     case ARM_FEATURE_GENERIC_TIMER:
         return true;
     case ARM_FEATURE_EL2:
+        ret = hv_vm_config_get_el2_supported(&supported);
+        assert_hvf_ok(ret);
+        return supported;
     case ARM_FEATURE_EL3:
         return false;
     default:
-- 
2.49.0


