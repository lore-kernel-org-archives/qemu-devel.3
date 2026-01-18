Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DE1C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 19:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhYb7-0000re-W8; Sun, 18 Jan 2026 14:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaH-0007O8-IG
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:16 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhYaG-0006uV-2M
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 14:37:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so33797435e9.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768765030; x=1769369830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCyMmfY1je4KK++qvAKc5w59+JOFx7vAsdkNeOooSpo=;
 b=d1IwMewhk3TeNassvrQUI6AI7s1VK1kC9Dt64AMYvgVNEZc7qWm86GFLuyusFDISIb
 1sqt9gUQNcAziNi6/T8If/bTombDxqWmRYSpif/PU6UGq9dFefUMzxRX2vL61CHGDrmI
 iVU8sboeZw+IoN6oQ+wpHZ0m9CZV+DAgOPxZCCAhBOWw6Ffk5/glov2uY/yaHKQrYr1i
 Puha1fGjCLbyH+8tVDN/B9RdeFu+P6T3D+lWKwfmSTP4VbjMD8NnCFlgtFPppep0zw15
 o3QN/pI24LNCam2avh6z4+eRf4rVk2JLCbefawYkDSAPmQVHLhxek80UhatyvvfdYGlZ
 i/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768765030; x=1769369830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uCyMmfY1je4KK++qvAKc5w59+JOFx7vAsdkNeOooSpo=;
 b=CxQpT+W2hng2mUxmmSv5lKBlCF2YC5ntde28zFmWgB9zsoOBkkmg+Fn2m60v1+WhvS
 AOQp69IzUDrr1esFkxjWe5WGIh4STAClAuzFjg+sbk6UsCbvX4jGnGb+BDHDzL0WczP2
 P5sk+IfzGqiqPtCBBfZ+paGm9Q2Hzn3IXuLU5AsodLwUzf2GBJ9nhazdbI9ALtiZZ2cF
 ZIB2oAFSnCUlJJDM/7unmboT67C14z4DKmpFv2nA3+yi9crsGQldyqtXrw6kezwWOvxy
 Iugz16DK0c//5y4lCfEYsIkheXR05GPj6sGmQblK8Z51JtJr+SWg68iUXEMOkLAh0j3Z
 8BHQ==
X-Gm-Message-State: AOJu0YxCmPTlMMs1ulLSwi/Lhv74gvzEHZ2hH7MSv1zsT3ufCcQRqZGZ
 jyTXT5RNDQU9SVVLIHjsoCvk74mdTY/bytla+RAcrAeTDfu1xxiaqRZfmMnfQf10yNPq10fmcXU
 qlF9f44k=
X-Gm-Gg: AY/fxX6dHUsbZdZEDC3K5a5xIOjop5CUC36f/eW1WrJcGesYfQxx9lYVbWN7KQol27M
 aaa5vREOoxNTUT4V8VCUP2bDGfMMtuRvhGsJuRShuMUoKnZLMiBRMxWZcg2+M/HNe9MjuEVuUse
 rprAZ6m6DwGxPTUEf6KVWoBzHwaFwZuElUFbMO6sbCLbWhaHniYeGXyqc/9GeDZfYUOaLOU/pz4
 cfVLerlejz+FXNSsglUJ+bg5SkuM3MVLZG8Ps4JgbfdZiDFW7cATCLMDGDuzMLOU35ESm87FBu7
 F9hgWpqsi4bt0omJ5eFkLevddKq0P1lMkk9Z0e+k9nqN50Nz84g9p+m5jYtUQsaqpXb5lTWkqJZ
 4tST/RpVCt/Olgf2NmKl9FXY23gKvYAaXaJri693UfKz3tsGewDOm/f9GI9UnfVGCDUmmWmmPK9
 AHsnyv641bByjxq+nh1HlXGI0XdS73JBRsJhfr5Wm+khDukPdlpOcCxTexkM3N
X-Received: by 2002:a05:600c:1f12:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-4801e2f9110mr98770925e9.3.1768765030251; 
 Sun, 18 Jan 2026 11:37:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4802dc90068sm76480585e9.7.2026.01.18.11.37.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 11:37:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 17/18] system: Allow restricting the legacy MO_TE*
 'native-endian' definitions
Date: Sun, 18 Jan 2026 20:35:07 +0100
Message-ID: <20260118193509.42923-18-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118193509.42923-1-philmd@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Guard the native endian definitions we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index 799b5b42218..4aaa6a0ab02 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -36,11 +36,13 @@ typedef enum MemOp {
     MO_BE    = MO_BSWAP,
 #endif
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
     MO_TE    = MO_BE,
 #else
     MO_TE    = MO_LE,
 #endif
+#endif
 #endif
 
     /*
@@ -150,6 +152,7 @@ typedef enum MemOp {
     MO_BESQ  = MO_BE | MO_SQ,
 
 #ifdef COMPILING_PER_TARGET
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
     MO_TEUW  = MO_TE | MO_UW,
     MO_TEUL  = MO_TE | MO_UL,
     MO_TEUQ  = MO_TE | MO_UQ,
@@ -157,6 +160,7 @@ typedef enum MemOp {
     MO_TESW  = MO_TE | MO_SW,
     MO_TESL  = MO_TE | MO_SL,
     MO_TESQ  = MO_TE | MO_SQ,
+#endif
 #endif
 
     MO_SSIZE = MO_SIZE | MO_SIGN,
-- 
2.52.0


