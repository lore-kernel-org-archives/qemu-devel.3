Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2ADC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6tk-0008T9-VN; Thu, 23 Jan 2025 18:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tR-0008Br-7K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tM-0004PK-4J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:48 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1183755f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675942; x=1738280742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOf7cXhzVFnELwvvE/9oD0dVEdIwULgdsVx2rdQEX18=;
 b=y9cJ233jkEU2cGiX4rydtYd7iaCv5DVQkPevCFChp1S0C0KVzJuAEk6EL8NVS2Ybwr
 fw4tlRA4hoYwW3Vp+3mnwdol8qnGX3koIrOYLL8AIlr7DSGtQDxvE5J77CtOCtAhjiKr
 9cMJZkFi9C99mO3W5fxZvrbfBt6BOYAAmBzmnk8KVtoNBwSgUq5miVijVjzyKjsgb9DI
 IWbdJInt3o4UT5Al3lYATYeI4lJOiyMYp7BbVo7OLIREWsGv+rrDLuzygqUCzzU3/2DH
 9Q29QONNT59iaioLwVHIXkC+bPAmMKI9MMvkYP2azlRpFiQXYtBB3bLEjLBKI6TtC7cr
 cvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675942; x=1738280742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOf7cXhzVFnELwvvE/9oD0dVEdIwULgdsVx2rdQEX18=;
 b=T4YVFOBMxPbJozBP/a8pFRnbvAq/6i5LW5sn58LUT0ws/ezHpSYPoasgtnuMEluZ7a
 qem+Dej940gTGjvfsY7hIuxDTTbg4zr0/e5Bi/1MJ4cQD7eRP6EY054crVoff4RJFHey
 y+fRQ9WmYXJKdBD6wvk7/BB1TTbonDlbAu8pAbkxNV2bqr1judGZpSF35Zk4mDy0hSbY
 TAxaPrFVW3bpDksjtApsOHzEoCLmYhYd5sH1GcNQiIQT0K7FCsbH/Qq1TYAYVJb0FtmJ
 qfSEQmfDB5EzPjzRUl5jx2lboU8b19IpjWkOSyK4DFVkf3/prYFXd4jqmPK+Zec2qrwO
 oYjg==
X-Gm-Message-State: AOJu0Ywd/kCg5vlVPD5jJK0AIGPWN0CNEG/msck03juw3OKbLodYlug3
 3SJn+AlKIKeusZgLNwy/v8iYkUQW1K2FgXfvvf4dqU0/2Thaug1sr9FbKoqoVT4fqUZ448gzTYb
 gV+k=
X-Gm-Gg: ASbGncvdzjohmKSuZ899WmqHXUTr5QdpLg8WoN1of0ceoQm5FVrjH+3aSj2CKwCVacz
 rIJsvwgkXojyA3mh3xN6eLHeh3ZNjOPKkCGAA/xY5OIoCokZ6ZvhMeQOvx0z2vfPBdo+PTCBkZQ
 bIn2sbCxU2oYHQDCmkFG89MXSpCEfRCtcxGakjG6wx1jKIUsl7BQWPbNcl8JNWC6a0uGaaAJ+IK
 OWYhYrjbpyaPpS59e215ESIk/ApwV7TPoWZJJLtjB/SJhE4aU9+FBwz6isRGjxT0H2ougkN26KG
 thLxwrzQ2N1A7eZrQC8jqjMlmoVCTIUZWwo2JqRul8JVGtylypSEDJU=
X-Google-Smtp-Source: AGHT+IFFvdlRkBEFpuvRapz+0/bX2s0BjBYZ6M4itb1IiIpdMWapxxpC9ppUNuB95mK5m+Q7pE4GZw==
X-Received: by 2002:a5d:47c9:0:b0:385:fb56:5596 with SMTP id
 ffacd0b85a97d-38bf5663956mr20431872f8f.19.1737675942270; 
 Thu, 23 Jan 2025 15:45:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bad87sm971133f8f.74.2025.01.23.15.45.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 15/20] cpus: Fix style in cpu-target.c
Date: Fri, 24 Jan 2025 00:44:09 +0100
Message-ID: <20250123234415.59850-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Fix style on code we are going to modify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 6d8b7825746..a2999e7c3c0 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -47,12 +47,15 @@ static int cpu_common_post_load(void *opaque, int version_id)
 {
     CPUState *cpu = opaque;
 
-    /* 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-       version_id is increased. */
+    /*
+     * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+     * version_id is increased.
+     */
     cpu->interrupt_request &= ~0x01;
     tlb_flush(cpu);
 
-    /* loadvm has just updated the content of RAM, bypassing the
+    /*
+     * loadvm has just updated the content of RAM, bypassing the
      * usual mechanisms that ensure we flush TBs for writes to
      * memory we've translated code from. So we must flush all TBs,
      * which will now be stale.
-- 
2.47.1


