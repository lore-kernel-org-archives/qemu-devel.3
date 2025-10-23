Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36ADCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBw4c-0005gY-6h; Thu, 23 Oct 2025 10:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4a-0005fb-2L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:13:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBw4W-0007MH-3v
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:13:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so8893975e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761228821; x=1761833621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Jp6xdYt7Qm+0J/pdgQITMBLjBSEIftoO6mxQrB4mn0=;
 b=PF2YNPXE5IopRNiFkc6/P9emOjXL6OKSX7iB0gGpKth3a1trGs8kOPPyxEXDwL+xOp
 71LjStc5ajpdCxBPfK6vj9l3oxA89MnWuXdsrfeqCQ9q063jt9YQBjq7qvYV3qVd7LFn
 Xowdg4OWESu3QQja5w/QCzHpcx/A5SIT+PNTiqVH8bvGk4WLvQW+38NdVf6NxJ3VD0OM
 hu/8z9IUZMbK3XJP4kMt+mQvoF30IrYGTId3M21Ibz2BjY6jN9LfMOesY988Jr+MTeub
 LfTIdbw6UqFLLQoc6M21+X439LmIMODOJ2uHl4TbEfBfUzbqlu1StvYTDR65VqGg1G2T
 O9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761228821; x=1761833621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Jp6xdYt7Qm+0J/pdgQITMBLjBSEIftoO6mxQrB4mn0=;
 b=h18rgmYMRMDBGd+skHvHkK1SDgy68iTLQTc9ngjyl9SoAsz9bg8r2b5dIO6VhJws0A
 r+ezCw55UuJug0UuxHO8VDpHJjoeC3WtPssc1/BNQdl3yI79J6vT+RukLOG1SbPVSmLJ
 aqeCnkUMgnP3jYvBt8096v3SqmGm6jij08kBXpTpquyKgqq5WbwNdr+L+vjxls7NeOvX
 XtnsCFOBs3mjUwO6AtgcObPqnWcOFA9GaB9zVPhXXF3v158nT8AHzyWvQfrxOOZCJLiF
 9Jm7MnO2+sThUMcIu0IdMPUMl+AD+Fx/s7FanpeAzgdRJW8VGwyFxKIYUuIB++SjzGx9
 EcgA==
X-Gm-Message-State: AOJu0Yz1Fm8jFzzoORAyWSgDZ3BIs5TxpeKV86IB6og10lnQJT7EOP52
 3Syrf6PGwpJmZt7FdDZLomXG8vXixNQAnIiZmnPVcc+W3xTTTqUcIp2Ssm2/VealSYZyxZFO6dd
 uwvnG1XY=
X-Gm-Gg: ASbGncvoPyNO9Iy2Wd394erWSQ6C0zlL33iI/4nCVDTOyQfr3XQ3NN5fBL94Ftg8HCr
 b/217caDA3XdWa3DjWsMc4864C3TEdL38p3fvpfNFbPInbHHS0EEvASWKthib/lSU080emFXhoW
 I7yh8lhjs9iST+Vp04e9q+GRGsqh/l/hb0QtfTs0lbn/cE/Ok1L79yEJo//eV1XSgdfh35KiDUk
 EbES3FxNHts1AmNn0BZ0EyhC8iSxUVcLGDLBD9ITTJPbvpoZgDBe03jfMHw0O+oZmAKswkDLWrw
 jncy9q1lNuvPI/4HiLrkiVmusK1rJHtm9TiyixAmfCHgB3kmbahqew12R7AxO4G3JRA9mrwJ8Xs
 B15ksTs+0Lq+/IujgrHvmbX6egj86S/X7C62jmYaD1yzFlZ5SEtteZwaOoPzpl47phPN/S8nN6p
 1QBluhXY69n3wllBGjQ6oTKQzZpah4F7QXJxXu42+fVX50zaaCGhL2HYNqYfej
X-Google-Smtp-Source: AGHT+IEnnTwsXVBYIuBp3v9AGSUlhgGakvZU4O00YAw+251OY8sxd7ngtnxckQj0WYUB6nVCavx1QA==
X-Received: by 2002:a05:600c:5009:b0:46e:50ce:a353 with SMTP id
 5b1f17b1804b1-471178788f0mr173644175e9.14.1761228821121; 
 Thu, 23 Oct 2025 07:13:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm117463675e9.17.2025.10.23.07.13.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 07:13:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Collingbourne <pcc@google.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 10/58] target/arm/hvf: Mention hvf_arch_set_traps() must
 run on vCPU thread
Date: Thu, 23 Oct 2025 16:13:29 +0200
Message-ID: <20251023141339.10143-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since hvf_arch_set_traps() calls hv_vcpu_set_trap_debug_exceptions()
and hv_vcpu_set_trap_debug_reg_accesses(), which must run on a vCPU,
it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bfccf5e9a2a..ee04943b0f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2192,6 +2192,7 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
+/* Must be called by the owning thread */
 static void hvf_arch_set_traps(CPUState *cpu)
 {
     bool should_enable_traps = false;
-- 
2.51.0


