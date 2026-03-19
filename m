Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE7A109190B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IUF-00043A-Qs; Thu, 19 Mar 2026 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IUF-00041z-12
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:51 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3IUD-00015h-MC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:52:50 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4853aec185aso8255875e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773946368; x=1774551168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHvV98N1vBG7Msqj+ig/zOVtTID7C0EI/MEHDz7oGBk=;
 b=N0C/rhgoR/KzYHX/xpNZTM/r7LTFlOtkpWC4z5xW35jExNDqu6EsCOp+Ju/F/+oPeB
 gA0v9t7xuKqog2C+f6U7xBrU+H1LAgQdUibMPqbYJpmXP04qyLmIcowgye7kzDhf59Qm
 jm4jQLM6zeH6SzvkeOngE8TD1A6Pmle3LhVRP4Ikw9/0lcqAYwWqBVvWw3ot+9knGDQT
 I7P+OrXHijEbubPa4ThTRlVqevAcbup3eQU8eR7Jcae0q3ymN0Nvt2pKnf1utu0bvr0v
 bjSBm2CqsVsLB8wSg8l5Rv9PByOEcFiGHFfyXYwCl/fogVMueLviEz71DfuTYNC2cjsZ
 857g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773946368; x=1774551168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EHvV98N1vBG7Msqj+ig/zOVtTID7C0EI/MEHDz7oGBk=;
 b=V91eQ9hul5HdMdoLAwIQCLxr6PWoVF6BQ4ZgzprRwCE9ROA0/gIxQTOnioBmTPpZC2
 xfnDcbPpd5wBTqpzREtcYXOGfEvtWdDxKO0CqizuGHuRFqYMlx8uhziQOvJFu7fg0F8U
 HLVlCcNtV6YM4fW17PffJ+LektypcmnAjA44DQ3JvlVUEMQBCAQnOHIp1kG4gRoEjbIl
 1oeLKgeLp3vOr4d9xzFgVwRmT2Ug/PsL1cNp3FrWmTi6hkuHpdoKaPqng9AXD0OC0UqS
 t4YJubC72GusPhtKOYdNYbh7Ze/SivqQ/ESKVn7Lv8eqGcAO5d408mKcvXlcJuD69CPL
 ThOA==
X-Gm-Message-State: AOJu0YwvQk5sIm8nTkHxmh2f+5FVVf9Et7k2mf5pXVNbq71TKz0Vy6TJ
 YoeBzbIZ4EiCDS/sScMZhMEDn1O955BGE7yzGPq4XCpnvIyFCKrVNNh9lp8Th4fXIyIavcjOzHZ
 +qq0IuwU=
X-Gm-Gg: ATEYQzx+40dPA0qE/uGfXx6hcU63IkJj9U9/GmrZrzt76L4drzFH17qz1iqLhRU62Gz
 oSQ6yWpdd6GYvKeKKI9Olf3z92VaOdZkdGt5djKhe2xJaSxi1IQ8EGs9Jvcnsl0njmvydhWHM6r
 LX6Fb1wo8cnqveaPjYgfmBW14vG04mstgaSxadOpzuBrJDvoFEa3kvhlTZXxgljRJKJgg245Zgq
 VHWuTSjBEOA2mYZFOSCQGI7Jc2aYpdbjXHD6zDpEX6v3+L7QCTEd43h9uWezE5UV45lEujg4m3B
 TIi6LvZKWRv7GCk65rDkmpsjC0VL/9FEvn1FD5mWiLpYkLg26YCpS3MArmRszw7ca0eyF+PjYs6
 p7A6hwHs7eyfZfmVY6nO4B/57a1ragboNHBduKY0sdXg/MOXcm7yLS9Jli3h4qPSkKCed45YMGG
 VD7TBqbwctPjUzauc7HtQskBBYlovaB6HCHuRj/tP20dZnxNZC/cbrb/N4Bqy3H8pLZPRjyzsP
X-Received: by 2002:a05:600c:a4a:b0:486:fe83:8621 with SMTP id
 5b1f17b1804b1-486fee1ab20mr2575835e9.23.1773946367782; 
 Thu, 19 Mar 2026 11:52:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff173756sm242435e9.0.2026.03.19.11.52.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Mar 2026 11:52:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] configs/targets: Restrict the legacy ldst_phys() API on
 s390x target
Date: Thu, 19 Mar 2026 19:52:03 +0100
Message-ID: <20260319185203.11799-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319185203.11799-1-philmd@linaro.org>
References: <20260319185203.11799-1-philmd@linaro.org>
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

The s390x target doesn't use the legacy ldst_phys() API anymore.
Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to hide
the legacy API to the qemu-system-loongarch64 binary, avoiding
further API uses to creep in.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/s390x-softmmu.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index e273075f1a9..478988e6d4a 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
+TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
-- 
2.53.0


