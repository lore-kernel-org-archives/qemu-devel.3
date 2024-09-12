Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40289EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodhb-0006dH-2B; Thu, 12 Sep 2024 02:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhZ-0006Si-Nf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:13 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodhX-0003TO-Rb
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:53:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so5433045e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123990; x=1726728790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OsmhMkPXAJPNIk8exjedFxVnBkDRePms2WrWvHvrW1E=;
 b=RFlLChLM1SqMcMCg/U2GxVSUdkZc8dXMChWZwGxjCBzv3R/VCUJ2ZzEjuNj7NJ8vsf
 QFtlXjgtBgYeGJSrkwi7XZnUqqCT/9wapL8bddhOqMry2ts/NQKnKVKNfFWXKQzdFiNl
 PwFTQmss2oaqYxLnKuFdvGMTLjKDe7T0Q3pOpIFmhJrdoXI6OWneIPCT2qJGXoZqwJ0v
 ciswLyGylaUwoZKS0wQleqMMwG6qgMtygX0/9Y5/fDA9CE6a0vEhZ03nVaXxZFAFqUHq
 IHnAHGxQSsZRKx3UXdHVFvP3lCTPDp8uxQJWx3AqOOxA1DsVls0a5wzeWGTiXtiLUewf
 ATgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123990; x=1726728790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsmhMkPXAJPNIk8exjedFxVnBkDRePms2WrWvHvrW1E=;
 b=RdN33qyeVNHdCV38BRwqVL0bEg0OcJlJHiUfNm/NrkWNtEPwtQoNm+zpmR5BKKPSnQ
 fm/JKJQcUje9OqSuitpxP7xokhDLR58wMvPKxlpX58DFj0QfA3mJR+1SEMdLwQSy3tO0
 IUp9TLZNA7WSV4Y9dg/sz+vae3KKGuNMIgMFMWVMx3kXvsActprG9bWvDx9oTjilSeP4
 Ag4eTwIJznBUIXx2JuKoIji3CVXHKL4brPaERlEn2BOBR1FZL5yH50YAIJFQo02rsKFF
 6CYoKITAtl7u3xcTcf7hkIJQRRdhzClzM6sKzA38LkyZu2lz66zf9U2slNbAeAQlNHWd
 R08g==
X-Gm-Message-State: AOJu0Yyfumc+MN4/6fH8P4dLq5KlmPoLZx2LAyhUDpzHnnq1FGSZ/lVj
 yWO/7QmHkoVnhn/VrD85iIUovO6WhGvcyFApoeT1G277cU9HPlfbmEBQcg7ZghV7C+L23Fv60tz
 e
X-Google-Smtp-Source: AGHT+IG+GgG5Dp90BeiTrS1D5gDaesTq5qLfw5APnrgUYXJeNGlJEM0c3EJz1IiAybN963MnPmDOfA==
X-Received: by 2002:a05:6000:cd2:b0:371:8f32:557e with SMTP id
 ffacd0b85a97d-378c2d4cab5mr908312f8f.39.1726123989897; 
 Wed, 11 Sep 2024 23:53:09 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956654f4sm13450031f8f.43.2024.09.11.23.53.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:53:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 52/61] hw/core: replace assert(0) with g_assert_not_reached()
Date: Thu, 12 Sep 2024 08:52:21 +0200
Message-ID: <20240912065227.67848-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Use of assert(false) can trip spurious control flow warnings from
some versions of GCC (i.e. using -fsanitize=thread with gcc-12):

  error: control reaches end of non-void function [-Werror=return-type]
        default:
            assert(0);
      | }
      | ^

Solve that by unifying the code base on g_assert_not_reached() instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-6-pierrick.bouvier@linaro.org>
[PMD: Add description suggested by Eric Blake]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index fb81c1ed51..1b5f44baea 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -380,7 +380,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
         }
         lb_data.data = node->bandwidth;
     } else {
-        assert(0);
+        g_assert_not_reached();
     }
 
     g_array_append_val(hmat_lb->list, lb_data);
-- 
2.45.2


