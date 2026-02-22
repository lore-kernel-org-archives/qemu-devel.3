Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A2AC636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYB-0003gA-Cz; Sun, 22 Feb 2026 18:07:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIY9-0003OL-4H
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:41 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIY7-00060v-I6
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so29519915e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801657; x=1772406457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SF9Qi5I1V/HMuPsNxz+60IaEmiSzuOlFJb6yrhzRy94=;
 b=iCHOUwYCVwUlBOp0NcN3Z7IFxO7M/OjY9kU6H7PXUQutpZpyuTv27Vc+4YeunoUYpH
 oEXhJLBIkduQL+ob4GlW9CWwYXYPpj7apjVQEDwT/wIFDKi6f7/IhmW+6dkoS+O0PEeR
 tDNdS4VvOyLG/6L6SPEDTmslyyWgswsR1T1Q44sKdm9soKHLr0/UJWM5hdcv6ve6ORKt
 gwC3IJVQeUPQDrgCRxy8+cp8gmHl4lHYFr56sGbgTtrUYR2zrcyjuV0ZR5yb1/5ghT70
 oWUEd2BIQi5G3sxcFXKBres+mln5j4clH3II+ObgYSRDXYbeUvrHsZ0K5vWfzEOHP3L1
 X82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801657; x=1772406457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SF9Qi5I1V/HMuPsNxz+60IaEmiSzuOlFJb6yrhzRy94=;
 b=OUBMl9H4qiUb17h9/ADdZ0vWVlSHGaSRB94IAWJCFys7S8vfcBCKsWMv6dOBN+omCq
 VlGFzpAr77G69SH24Q9bYKz6kc7E8jlLO3pHX4zOUv3d7PtUbG4i7kZ654poN15fo0CJ
 n3q06GAt7JWQYXhQlWLLoEfAQbgEvCZUgOrdH7aJnkYDEDnq0i4ajPQ6BHlm4CGH+12A
 bghQX+qwhfmhm9SJnSR5QTi7dRaLE8YkL1XF3evWNiqBaF0Q9Ro27wP+4Whc1HLjQ0Rn
 K7udv69A63dJPE1JC6QVo2ngaY2OHmMHa5Ko0NRQJcbcmSdgC8EOalBUfscZ9wNW7iBh
 p2YQ==
X-Gm-Message-State: AOJu0YycpgIB2mH6No1pP2uRbF4bHClJPaXC8JkHfbl+D2kU/oiOvKiI
 pp+Zp17tC4k6+b+bhRycV+0Isv/tazkGFM6/1X31zYcLCkp0S6RbzGjjsOB8G63MbduVgSy1qM5
 Vy/j8IVA=
X-Gm-Gg: AZuq6aLz5ClKVKZFxLyyXnBVncE80VEkJtnex4OyuahN3XNQDUWxK6nGq8xgw70zjnf
 zq5/dYY26ihHXcQy3g0fpAY8MHj97/8O1/nhBB0N9P9ngltUCmRuITxJItXnzrpc6BO3JPSytxC
 Zno/OFdg7tvqusadoMRyNpejtcI6Xy3aLFdItVBHHSv+TW8I7jW9hk2h5KSGjLMOwd7uXBIFd2V
 CcPIcN8PWVD1GnuFBPpf6Oq/avBuOREILqBcM6gr86DLCQtYwKSrVokvLK/4Fmb6oZOpu3deb0/
 ATrej4q3nBL9kcRiLGMnar/M0uZKp/QIOWYqINowhqzlChgqPHpQAP1i2nsfTUhnMTpiebFojc0
 BZvEItz5XgVj6kYmazxwOlb5MInVoSUoycdBauKuoar9ER2NXcBHbuRBvpeac3HXOcnZtrx23CM
 K/u+Wao6LnLwlNF0yEiN7eBt9N1uLC5XH/2T5lt/lsbxR0fNltP4X6cRU6oG0smx2kwAJB70PY9
 YYh5rex5Ng=
X-Received: by 2002:a05:600d:8445:20b0:47e:e0b3:2437 with SMTP id
 5b1f17b1804b1-4839fe96a24mr152986295e9.5.1771801657555; 
 Sun, 22 Feb 2026 15:07:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b3d88sm244184425e9.3.2026.02.22.15.07.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/20] hw/core/cpu: expand cpu_reset function docs
Date: Mon, 23 Feb 2026 00:05:55 +0100
Message-ID: <20260222230602.5756-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
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

From: Alex Bennée <alex.bennee@linaro.org>

Add a hint to the developer that this should only be called from a
reset chain.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260219171810.602667-15-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index ef20cb356a6..89934b8efe2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -815,6 +815,9 @@ void cpu_list_remove(CPUState *cpu);
 /**
  * cpu_reset:
  * @cpu: The CPU whose state is to be reset.
+ *
+ * You should refrain from calling this during CPU realization and
+ * make sure this is called from the reset logic instead.
  */
 void cpu_reset(CPUState *cpu);
 
-- 
2.52.0


