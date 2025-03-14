Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC11C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tr-0005ze-4j; Fri, 14 Mar 2025 13:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tI-0005ft-Q6
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tF-0008IR-2l
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225a28a511eso43039015ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973520; x=1742578320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=x4ccqJU2JUQQ4yet4DjM5vBu8Il7lqMZ4PMkueyUg/A4G8TO/fe7ORIXPA2F3x7clI
 jJvmHQXPhumSvRwXKjWOtjZ/+Hc/i1aIAu/Hv+X7XTWZUO6B+/8ck5A/Sp178Z4FRlU+
 nIAHYPdbt3JdT9hbdis4mAHBU3QRZ0s60mrd8vX0gLmrvwz7pcPumVOt7H2mV9Ow75Jt
 KERHQ2e2QTkgpfHXSS6P1AA1u60vFcBOJAkHkoFv0iCtM/vqgIMyVbmvVPhklOOVEF3h
 3GbTIcbPiM/4GhTWu5YmPugR72mixdwCIt1dqiBRYVd7z1Cwu/g5pv4Irctz25FGyKAp
 g+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973520; x=1742578320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOa15ppvF5kxsldjPkSIJYe5T0c824L9GaUvR3via0Q=;
 b=hrrmS8ESv/WkOVvztp0q4JGegl0TCkaWZIR4F8IbknF/7aN/p96v6WJIZ+BWPpFS8j
 eNk06uru3oVq19IIhUh+fqh1yXEUC5nQ6Uoz1G6mJJEwnDU3s+opGgJUrjZdHrFLU/T/
 yed5Isz5BxCYGoIqUm9sag90vJWM7oBsZ5uZSJf23JrAncMwTGBh/rHej9VIHwCCl3zX
 L1KUa96Ton+hKT20kX19K8T/XpAhJV9boiwYWZt9Ikk+GZ//xgZG1dhBAgaFPkq7BehB
 Y9PjRyPis8gZKCIXehs2MGRIppb6l/wjMu37bnp27pCkTSKzocjWS+HjjzoO26YkymZl
 dImA==
X-Gm-Message-State: AOJu0Yx+Y7iprq2pCOcyifc2WxL/VDt8gtCwzkD6FUBqQKX2r95oR2tO
 JQVBEWEyFtasoVxoruhPgARpzRd9DFMUeHs7ifvYOGic9tQmv7pOY/W7ekKy1f8ve5GuM4797PY
 UsZ4=
X-Gm-Gg: ASbGncvxsT1li3eLbfmlNo2Lto7VVaRkzgZxHHMip79bynZwBI4qlmj8N7ccGrOp1ub
 UuoRWIoJH2OpHkCYPnsmb6zZ4D71T/Lzniu1lEnAaDeg3plrWNE6oDdH7Ymo7VdkxUiswqzlRaP
 kcxX33T9YoUJH9WpC0NK9SGFcqv8NEker6DTwPkQmz6qs0xljhQrHVk7ztdLV2NL86ezcAHImlW
 YKOvl6iOqELF6RUBTM5voUHi07sShN9UZW18sLxAFGlwx7NzqnY/YUec8YHxEGoTXffQWhk5ixy
 ONmLgYBcZpNlp3IsEnZgQ3gzsgI+7aJRMoCWy5+GMHYoqndpKyQxdBg=
X-Google-Smtp-Source: AGHT+IFlQhNJcOD04DdXfXRzIQFpLw7YnyShzSPUUYA1tOEz0vWyEbVCk22Q9xZ8telIqsQxDa+sSQ==
X-Received: by 2002:a05:6a21:4a8c:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-1f5c1326a41mr6196288637.36.1741973520104; 
 Fri, 14 Mar 2025 10:32:00 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:31:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 13/17] system/physmem: compilation unit is now common to
 all targets
Date: Fri, 14 Mar 2025 10:31:35 -0700
Message-Id: <20250314173139.2122904-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index eec07a94513..bd82ef132e7 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'globals-target.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -16,6 +15,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.39.5


