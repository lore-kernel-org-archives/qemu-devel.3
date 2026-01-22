Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF8C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqT5-00078i-Oo; Thu, 22 Jan 2026 03:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSX-0005Uj-V1
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:40 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqSW-0005wj-Dp
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:54:33 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so447504f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072069; x=1769676869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hdu9ZH6B0aVGtR2M4GBwXddbc5aA1Ybd+nNhyXsl0gg=;
 b=JbNTT4saVYDf04TeMEbE0Uu6edSpnNSwPISUfFUzaVKOwC5YAJDzSOvLmIJadFkwF2
 aL5o7dJvQefLxyRNyOxGvWPanYJsUF3CReD42UbEWWnPF2OeaMvmxemHaqeXe36ISLZh
 PnoPpAWTuLH3KKeTJ8lvA8MUPOCNwrDLv2mejPMMKG0DrA0+8saFI/5R2XPGFJUsnYWi
 S+TIZ4SGRSfbQb4zz6J5H8EIXjDtvK49vhswt7Uk2oeMvqVzhMnmj4/Gd6cSMInDVALS
 +91QEN3u0foWhADv0ocDPUcTMNvb5q9RjgshmLt8AKbKeu6wzF3ObQW3zKB3QOITgyNR
 BGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072069; x=1769676869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hdu9ZH6B0aVGtR2M4GBwXddbc5aA1Ybd+nNhyXsl0gg=;
 b=gPLDo3Gdjld5PUXEGYjI4btN70B/OmzgPPt/DUQgsPDe8QdEL7zHn9P2Z18Mk8E2Rr
 VCAA2+M8OR3OAa6TmvUoEOF6qq2tx55rEjIfl4Ri9LZwV9ffWh2L3W3l8F8o7djpymXj
 SKJRTGuLrLCZLPQ7B8eeIga5KSsUw2Gq2ja9s3tG15bbRxHOpCf36s4mgaGFhDaBlVpL
 QqyD/pSkjNGvoQlhNVdvy/4a2vAMaUTMTAOW0lf31ULTpgt+nD6lOLm9M7odasqy/ZAh
 8ac67SiKpv2MRBec91Or6r3/XJ60V72slaSFBlUGx/iqVWlabvsxzvpJf2Wo62mi9E33
 iePA==
X-Gm-Message-State: AOJu0YzG4bwzy4ibbSNXOkN8DE9kTEXAhrwlyDXNOt+8kIR4EoXNyB4j
 k7v3Nf66fMU39pEfvZ1SygjTAlaA2+JTt/mgU8PQsCXQDN9ADvpgX6tXLbqHluXn2l42FBFGs0A
 FdlZo+gc=
X-Gm-Gg: AZuq6aLn+g4hxX1Fxb0PWXcd6ILe0pfXu/umjOSA6CEIKipTRLsdGUHZO0Xih69Qbf9
 NK7A15sX20030GicpU4doUb9DuqV1BflvoQ/B7RvsbpG9hJ3HxaqNA2TeQdqKE4ZuZe7axHG7Xm
 RXH081ao+bZ60Kbm9aCHgH/oB6hEvtS/TQFh0zvfWnnjnSXeYMP98njjdOXDTrgNVOBmEALSCbW
 R7prHFSY0nzPXwIwNDOJgKzVBlg080sebhRH5AmexncJZ0MnP/XrGkFd+zdG0XJSky94Wcizy8T
 XefS50rsHq3IOIAFBPRLtuqULB0ezm9/6UzcZ4C88eFYXxwJvW2tnJvVHR0HZTRz5HyRm8mKOFl
 Ghlr+QOKOoyrpumv5OAshWgweNXuO1rnGZu83hHgcKDD+srnS5pajbIkOKgQgQZHLm2zG8ySeKc
 wNDBycpdvulBj5AMtqOWhO4pgRi+ySnGt9KC5KjAuRW7UuR9wltYa2JmaHWdw/hzShl2U0F4I=
X-Received: by 2002:a05:6000:310e:b0:435:99d5:9d8f with SMTP id
 ffacd0b85a97d-43599d59f09mr9567505f8f.19.1769072069476; 
 Thu, 22 Jan 2026 00:54:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm15683155f8f.34.2026.01.22.00.54.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:54:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/31] system: Allow restricting the legacy cpu_ld/st()
 'native-endian' API
Date: Thu, 22 Jan 2026 09:52:37 +0100
Message-ID: <20260122085255.95035-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260109165058.59144-17-philmd@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..a5711bc15a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0


