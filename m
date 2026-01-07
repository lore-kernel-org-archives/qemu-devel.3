Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60349CFD62A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTHh-00010u-Dm; Wed, 07 Jan 2026 08:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHK-0000g2-Sr
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTHE-0008Os-Qy
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:08:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so16586345e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791318; x=1768396118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prcEORDpaGFxyGovg9LUonLPwKCY/l7aGLeExZ61Aa8=;
 b=b9sKjHVUWlRF0JWj2pbkpGqeGopIobUUYYOMN/3nm9+CXQE+gddiuTiE/U3TKlVQRu
 Wj76b5uKKOmdKV7D3QO66pZW/8/ZMC086tGvLQj6eKGISFNgESBY90YsbIlioi+4QRUl
 ZIKxflHmwPqSLB4aXH//mr13iAjYRYRcrsT10QX8L0R+/OZdXDCIAG29gfstfEk6xmtV
 y3U5B4/BrWzL3moo2I/nGytWWA1wqLrlEgu+6R2RkyJsZQ+gzbRUS2I0k0c8P+gCFcBd
 mUQCO7VfzblgfvTm3sy02iWlmey+PXyK/lYHenfTRwhnzjbZvpXqGMKHIofRf6/IW43P
 Kj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791318; x=1768396118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=prcEORDpaGFxyGovg9LUonLPwKCY/l7aGLeExZ61Aa8=;
 b=tjoZHcutgdkA/G7eEUuMzckspoAC544JyHRZ8/KWsL5XJB72dCfjpb+c3zSV9d2/eK
 btzYxx58lOoiNsQCrBVt8vkfWA4U/mHjtywixmb0j+rwcB2L1onqsZaESSXw0xOJ7chD
 5WTafRRQyU5rYnVrvA46E25uXsp8i4hIti25mtKJs1iGN9ezVJw4n4XHoHJBIZuqrCXM
 kJ4KFo7t4OUexh/UE7TgKAV8BNJ0cpkljeMTCnnoU+bInjYlMyAAUIpgwRSQ2c8nznw6
 8PSh0/0zpcIYb8PauWbd/aucQW55O1uQFizImlKgvc7eqxYJf4Yq7jY7Gr5WGM7PCWJ8
 is/g==
X-Gm-Message-State: AOJu0YxCIHe6FaKoCbTYeeop5Y8/LcJPmhJXkhs0V/rryJvY4V+1T1tg
 v9ubxARpeRfFu/QZS+Nh7YsRvIdSp762dC2fZ2faLgKVvdJMerYiER7tuw0rc4Z+7w/GtE25yGN
 URjP/y2I=
X-Gm-Gg: AY/fxX7AD77kTkxbA46MtjeVkrMn+V+WMt4O56/pO6bWlYcVn1pXX1mD+eDMIOvs2rI
 Qllp+pf4kzHkpV2kSP1OMcJHBGdBrB1/eAmc9msh+706mwGXN0d/v087ZzE/lISt2/6VWNFPeIk
 J30Fs1oEC1EP/gstZd58nwddOelFTE9l+Tiq3IetCF7g9fP0BZCoH9lzzwlC+sI2xWH8Psj8xiU
 T89nKvuI8ndPcJMk5T44g768XslreRdAOVBzPPfFbwI4vlPMznes/74jAasBh6eXKwtmEVHNhEW
 nRI41m27ghKG1JYrfNiqkIrRjNEPxv/+3qQI6d7GCrUMRoc6F3ae/K4pwrqqxhSGAFaYU48/+Fb
 RJCUErzYq3qASf40HtteaoKZrEeVwheN48s6S8guhDglMhvZr5+xNM6rnwIjh7ehyKCqQmY0bSL
 zT4RcCSX444kNQi4Rl0Ussvh7HNQwzjYnsT+rLGQvkk1ZeLmpV1Hiso0fQmBHe
X-Google-Smtp-Source: AGHT+IEOkpYAfHJ/rFg2YST4NcvSABwvxPmaE54Sq3GAKwdny9PRzzF4kMgNzjkLvgeCNuBDxFKYAw==
X-Received: by 2002:a05:600c:3114:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-47d84b2d27amr28680355e9.13.1767791317574; 
 Wed, 07 Jan 2026 05:08:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm99515255e9.1.2026.01.07.05.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:08:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
Subject: [PATCH 04/18] target/s390x: Replace target_ulong -> uint64_t in
 gdb_write_register()
Date: Wed,  7 Jan 2026 14:07:52 +0100
Message-ID: <20260107130807.69870-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
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

On s390x target_ulong expands to uint64_t. Besides,
ldq_be_p() returns a uint64_t type. Use that instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index d1f02ea5ce4..9ae715add4d 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -46,7 +46,7 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUS390XState *env = cpu_env(cs);
-    target_ulong tmpl = ldq_be_p(mem_buf);
+    uint64_t tmpl = ldq_be_p(mem_buf);
 
     switch (n) {
     case S390_PSWM_REGNUM:
-- 
2.52.0


