Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643FDD26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFgC-0001CY-Ae; Fri, 09 Jan 2026 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFg0-00014S-3A
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:49:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFfy-0006rd-Jl
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:49:27 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so37086775e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977365; x=1768582165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6wRQ7EoY84wSQD0D7CNjpx8CjZayMzdWIMhqkkeAcM=;
 b=SHmvNLgCp5Q/JUd6cYyh38FGAC9Mug5TNkY+M1BnA6RMiwiYayrdQTLVYdo9BN4bSV
 p4scqF9Eyk7xL/nory9BU8g29xyWn4Yo4JJssdhWgt8GdkiZzYebTyWZ/nMGMkU3mODJ
 MxXJnuyQme/dMA9jOZ0PB+fMtY/bWCvt/m8shGmafgMTNvBPUr59ur4Fi60GNSZjFDcY
 Y14bXrgtLSXPczBeecthTnQ3STcCLFOmDwIb4/bYOaxNyubWYZ0tPojYojk5zw9Cacj9
 VSOvp4UkZvQ6lHvKOdnGkh3gDIGMeYKF7t1Viv0B1oE7UewDWYV5EZdXr5CP0kkuIoEL
 wJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977365; x=1768582165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k6wRQ7EoY84wSQD0D7CNjpx8CjZayMzdWIMhqkkeAcM=;
 b=SIEadn4mnBKgpWycePjjb4hVsXA2NjnE5/ygL7daWk72v+MGEPK8plyRum/E7GOUfO
 TL7JOFRlh+2zxCaCCSspSyTxNPw4bHXYB3ZYKOLj5Cfd2oweo4zHEj/rU8D9GdzxZdon
 Bjxy/4ify7Jd2a+30/WbOrtf38+/Gd+Y7S0gUiv6v3YoeC+D233vfyUwAh8iq+KxDy/w
 pNaKShCLl9dCVHX4fa3s7PM7j9+gxaUsdfY+KbBgr4dg16S/d+73c+rYbf5a0E/bzGXT
 VJCUzF9xp9PCJpqEuhnwe/xXSS0vEPOAIyF6mEuqpnbMxEfUZkdxzrwW8tHf+bYTVlHv
 OWjQ==
X-Gm-Message-State: AOJu0YxNDRslE4T2ZFuadwCAmNsm7XNTsysfTGC5LNoAVh+DzdqfMyyN
 r0ca4WPhfYQk1IglOCh1IMIPwB6GPs8zttBghFmx8MHYSSESEH700veJ+SuwhR4yovKmpnODPAX
 jWAlXXZ4=
X-Gm-Gg: AY/fxX4pT9B0ejeavuPNHSrdc/29LQhHsvHy2zNAm5VKFWNwYsdgFbYbTyF689NSR3F
 CE7eNKs6xXE8XyzAmGvauVll3ybP0FHJwme+ayhO59y8wlGCRS8U5FnXavXj6qKzkvrlxLReabC
 YVfHMUef2rjnfLE/YT4jCaM3n/X3EO8CQ308jFzrGVQp6l8NxM2EIHPEvz938uNYWf2xlxWNihg
 kq1qXe6IZyhTkS28NXlM4Xhq0AT1qFGuG2SYXU72Q/ABDzFXK/OV2Mz2MCqx8s5WRZA36X6g4nk
 EdnrIugLKDqqX9wgc/QMCENtfIfpRnOFvAd4krYWNjRf7rR/LOLntVJUSX1u0RaBawL64C+exXT
 zcj9NOLSXQFhYN5Jz4gbGgICwupBssMIXuh89jTHupWB5fhEvYG2KoKv46D12bGwEFGoup8zG0D
 42EgGMWyO17H4uFibKqEcLMPHL3GdW8qre25hU3VZ+fYs7zA4qTgYsk4NN+AX4+axi3LC3Z3A=
X-Google-Smtp-Source: AGHT+IGGeG+0Ns1YjYkSNhOGdy4AfKdhL/2cQoDEXNHaUmKuZh6GUH3uDDZIZDNZQtFdOSAO4xQruA==
X-Received: by 2002:a05:600c:500d:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-47d84b3baa1mr89241585e9.20.1767977364912; 
 Fri, 09 Jan 2026 08:49:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636e588sm72692845e9.0.2026.01.09.08.49.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:49:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 01/23] MAINTAINERS: Cover 'system/memory_ldst*.h.inc' files
Date: Fri,  9 Jan 2026 17:48:54 +0100
Message-ID: <20260109164916.58713-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109164916.58713-1-philmd@linaro.org>
References: <20260109164916.58713-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Missed in commit c611228c0ed ("include: move memory_ldst*
to include/system").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6602c9891db..2d8583cbb52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3260,6 +3260,7 @@ F: include/exec/memop.h
 F: include/qemu/ldst_unaligned.h
 F: include/system/ram_addr.h
 F: include/system/memory.h
+F: include/system/memory_ldst*
 F: include/system/physmem.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
-- 
2.52.0


