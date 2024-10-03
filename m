Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B2CF34D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 23:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVUC-0000h3-A7; Thu, 03 Oct 2024 19:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTx-00089M-FG
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVTv-00041m-72
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:43:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so15019635e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727999017; x=1728603817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dm59hqKIZ3uzww+6ZScIPbWn9/eLWxkBAfjg6zYFCG8=;
 b=S+J5E5yRZoIaqLAUjiDxVj5kMIPOp7qQ/qzaQGFXgAsuyp0W/8OH3NZFi+7aKdYepq
 FCH0x/7UcwKRDLKIxSw22HUaKhZ1kafyHb02RKOmvr0yoJI/y1jUxT3OWIwBBZ5we+kV
 lMxRfyqgQo/+Cv7vM3iAvLBftKvFH07m1lKOwG5ffcqfRheaMD4chwA8GDUw3KDS1mnH
 xwkP0dMYy5pB88We/o1IKNJ9UGrXaSV5xbtkEpbzQ+YoK+h6ZzCFID0hw2/tm/orwacy
 eiWZT4LS61Fmtx8znCnzdsk9gMQ4s+HvxzfkoIa16Y4n1KVkgbILs//zgVNtXLyQmX2W
 ITdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727999017; x=1728603817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dm59hqKIZ3uzww+6ZScIPbWn9/eLWxkBAfjg6zYFCG8=;
 b=l/FzdmRU7kfDATcdTODZrF8MXqBW3FY0TUM5txQoNv3Q6sfMFwmxHI20smBMk5GocV
 S9Eyiot0Er84O/gHlQyba6blcs5JQb0N514YOEkI5Pmt9k3QztV0ig2g6u62X8PkmXM/
 QQH3diFqy5A7t9Vq1RxKbP2mQ/kwzxjpGoksN4jdYaBWd1wBvW8KjE+hQDDDEY2WZEeg
 o32jcUPiKEER4D1eVjpq97nM15mbneqvE+wS7y/aMO7LOttFhBNxK2KSgwd89mMjuGDL
 FGD4Ou4vc0oqgH4JIxvJTRdfoPWRmFONwjRMsvEKgASmhcQFHC/KzUAv3rQqmlZY14KM
 tnZg==
X-Gm-Message-State: AOJu0Yzx04WFC9JVsoM4w5LTIjlAuQvIYEVyi36SfxRL41J4yXj/uMBn
 DOrIfCqp/gkYYOEjcr7De+hPImz1LblVtbIQxmvVmFDq8P4zZC5eo9mE5yo2Lm9hAYjfQRKO+1Y
 2LsY=
X-Google-Smtp-Source: AGHT+IGRlBDtBD7p424YekYCFlRx2XjPNGNN2PizopRrVsHXKXAAqqeyX8wh1w1grWnp2w51IIo8fg==
X-Received: by 2002:a05:600c:3541:b0:42c:e0da:f155 with SMTP id
 5b1f17b1804b1-42f85aa6f3bmr4490165e9.11.1727999017259; 
 Thu, 03 Oct 2024 16:43:37 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7464sm2170287f8f.12.2024.10.03.16.43.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:43:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 10/16] target/s390x: Use explicit big-endian LD/ST API
Date: Fri,  4 Oct 2024 01:42:05 +0200
Message-ID: <20241003234211.53644-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The S390 architecture uses big endianness. Directly use
the big-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/gdbstub.c | 4 ++--
 target/s390x/ioinst.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index a9f4eb92adf..f346208f79d 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -88,7 +88,7 @@ static int cpu_write_ac_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
-        env->aregs[n] = ldl_p(mem_buf);
+        env->aregs[n] = ldl_be_p(mem_buf);
         cpu_synchronize_post_init(env_cpu(env));
         return 4;
     default:
@@ -123,7 +123,7 @@ static int cpu_write_fp_reg(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (n) {
     case S390_FPC_REGNUM:
-        env->fpc = ldl_p(mem_buf);
+        env->fpc = ldl_be_p(mem_buf);
         return 4;
     case S390_F0_REGNUM ... S390_F15_REGNUM:
         *get_freg(env, n - S390_F0_REGNUM) = ldtul_p(mem_buf);
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index bbe45a497a8..a944f16c254 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -603,7 +603,7 @@ static int chsc_sei_nt2_have_event(void)
 #define CHSC_SEI_NT2    (1ULL << 61)
 static void ioinst_handle_chsc_sei(ChscReq *req, ChscResp *res)
 {
-    uint64_t selection_mask = ldq_p(&req->param1);
+    uint64_t selection_mask = ldq_be_p(&req->param1);
     uint8_t *res_flags = (uint8_t *)res->data;
     int have_event = 0;
     int have_more = 0;
-- 
2.45.2


