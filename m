Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BE1C61DB2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 21:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP6Wb-0005ZE-HD; Tue, 10 Jun 2025 17:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WZ-0005X1-W9
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uP6WY-0000h6-Aq
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 17:28:51 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so4683598b3a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749590929; x=1750195729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmunumSSbRJ+sU3cFReMs3+OMRURp5YZyylAlQXMnU4=;
 b=o82yPzcrblVxU8dJzGYt+3BSWBiyfC7sU1gXxTMpddwkvNGu7MnFJXkJPDaIiDbfpt
 ZKOIf0MNBrfwo4tceiCxQJnaL4DGL95RgVMmx/QeU29k+Mg3kKr7lGiD47b1vfgGkdzU
 5r5yWsaFdhsrHsrlVTZe/n+dHtCEwwcIskQ8JIgOmDjTx4Qf771oAqp1Mo6GJh0iub+g
 oR52Ijms4uvWshF5jKaw5gS1uNhSaDqrSkqFqL9Lnik0b0/N3laFJupW0kWDqISNzGcX
 khH7MRcPUNRXEyEGMthtyED6OtPtjNEzrlwMR0/L3OVRIhupNni7aibbVJi9Dmp9x015
 Pu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749590929; x=1750195729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmunumSSbRJ+sU3cFReMs3+OMRURp5YZyylAlQXMnU4=;
 b=tzb4ID+cPFLA38vsqPXgIWtNYJIluiW24Obb/VPTJjrbTRVGH5oOhZ1WtyaDyagh8s
 9HIm+/Iuv3pwPMcT2mhhES9yEexbYHwyOMvNLZlehs6+/ZylMTAIrPiUyV8iS+lgmls6
 fjcVrFKpUQP7TYDMxFG90hEq6LpnX3veQcbNxN6DH51vx4KZh39WSqQaqTsrUK7BYvTd
 XtTsJCejwiwOgI7yiWFpjRogNdubFJ87c2Q6bdnDIHQ3skI+blkJInh+uToMHG8VPrYI
 aI3n9dC8ESDmsdPJsJiyfGzefWCRRlmLmNT2eob85b1C2QbPSrYTaeikXQXBFwiUxm5d
 VIzA==
X-Gm-Message-State: AOJu0YxvGGQbxmOUnE8zDVp3LsHI8EQ/2Y2TFoGP5uu8afMJ3voPVo6o
 BGxBx3roX9Ry1MfCCC/8JkGJlg2pZrC2lOvQvhnP8hJZaarPDO6GZ0wwtnE+tD6Y7u5PuzDbfwy
 1AHUF
X-Gm-Gg: ASbGncvsc1zW4EzfzIQoKZBLb66LqV17dA4rEbRhEa9jF5le3qSJWZxMq0tWKA+Wynf
 DoFNnvhPFFDDvoxuEMubOWATF/4/xvWxWAQFdmL7I1EAowtkQsJlaP4g9bDQcx48HXaofz3KxIe
 Vry3vOIVzIdq2fsNcBuTj1c1e24kn2D75MtqFRvdiM87aqsXlO7df73iI3SrWThxIKBSuDPXtn0
 Rcr/e9sGDwGdgwF4IXF4AAo8fhd/+A6BMi/CO01D3fFcsHTC6UIKXIzkYJNSaVym4Er0NXzH71T
 COR12gRodmCQyeIAkH3ArCU23gkVImnmU+SLZwNZwOylCBpvT8g3LZWJVYzFMw==
X-Google-Smtp-Source: AGHT+IG0MCbBo3/eYeGtX2/yHnPmAmOL4svxBBVWfPQUCvsq39e4hx0BWSwmeQ0OG6jpZgEODbCyKA==
X-Received: by 2002:a05:6a00:1490:b0:73e:2d7a:8fc0 with SMTP id
 d2e1a72fcca58-7486cb219b7mr1312263b3a.1.1749590928721; 
 Tue, 10 Jun 2025 14:28:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0c0613sm7864225b3a.122.2025.06.10.14.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 14:28:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, berrange@redhat.com, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] system/rtc: introduce -rtc time-dilation option
Date: Tue, 10 Jun 2025 14:28:29 -0700
Message-ID: <20250610212829.2818792-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
References: <20250610212829.2818792-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

This option sets a factor on time spent for QEMU clocks since the
beginning of execution. It can be used to slow or accelerate time for a
guest, without impacting QEMU speed.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/rtc.c    | 11 +++++++++++
 system/vl.c     |  3 +++
 qemu-options.hx |  7 ++++++-
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/system/rtc.c b/system/rtc.c
index 56951288c40..36c53f0fbd7 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -188,4 +188,15 @@ void configure_rtc(QemuOpts *opts)
             exit(1);
         }
     }
+    value = qemu_opt_get(opts, "time-dilation");
+    if (value) {
+        if (qemu_strtod_finite(value, NULL, &clock_time_dilation)) {
+            error_report("invalid time-dilation factor '%s'", value);
+            exit(1);
+        }
+        if (clock_time_dilation <= 0.0f) {
+            error_report("time-dilation factor must be strictly positive");
+            exit(1);
+        }
+    }
 }
diff --git a/system/vl.c b/system/vl.c
index 3b7057e6c66..e3e3f2f0209 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -243,6 +243,9 @@ static QemuOptsList qemu_rtc_opts = {
         },{
             .name = "driftfix",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "time-dilation",
+            .type = QEMU_OPT_STRING,
         },
         { /* end of list */ }
     },
diff --git a/qemu-options.hx b/qemu-options.hx
index 4faad5604c0..b8aaf8b3349 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4887,7 +4887,7 @@ SRST
 ERST
 
 DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
-    "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew]\n" \
+    "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew][,time-dilation=value]\n" \
     "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
     QEMU_ARCH_ALL)
 
@@ -4916,6 +4916,11 @@ SRST
     problems, specifically with Windows' ACPI HAL. This option will try
     to figure out how many timer interrupts were not processed by the
     Windows guest and will re-inject them.
+
+    It's possible to slow or accelerate time using ``time-dilation``,
+    which is a factor (real number) applied to QEMU clock. A value of 0.1 will
+    slow time by a factor of 10, and a value of 10 will accelerate it with the
+    same factor.
 ERST
 
 DEF("icount", HAS_ARG, QEMU_OPTION_icount, \
-- 
2.47.2


