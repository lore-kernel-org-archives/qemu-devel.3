Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEA8FCA174
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfSh-0007dE-UO; Mon, 09 Mar 2026 14:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSf-0007VA-QU
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:36:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSb-0003Yr-PI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:36:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso8004676f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081368; x=1773686168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bIEbHx6YI4gBPOp+3pEqRYyaYkjjh/Mj9wYvLwhU6C8=;
 b=E8KcInWrN37aaKl539sbIx73yXJDNWhdM3ps4x+n50rDAi0Jfq3QtFv87BZzBVbXvY
 ROS8J4sXQlQWF1amMFTbdEO8ncNyYGo5aBfel658fiMNdWkkZLO25Bw2pk4jGauZvyaJ
 IaTgzSidsAVqKGSi+OHL6NveAhWaYxlHWLbdpKB93TL5kqvGvx+P5faWAuX3WZGURWlt
 3p1NjBaxrG71+VjsGRbwVRcvvz19t5XxoCLJgEZ07DLOsSPWYMtlGNYD/yJVqqTv9J1z
 kKVV3yXsmSIAdFQ7hti0cQYJYZAI/iillglfy5p5B1JyRwcFPwn4TRPRAJs3QQpJCgGc
 7GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081368; x=1773686168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bIEbHx6YI4gBPOp+3pEqRYyaYkjjh/Mj9wYvLwhU6C8=;
 b=phPMIPafdthiSzMkPhFOFAF/ATgCq7vryYAHeuCIF3uV/w4RAlAW9frvo2tLqqbpid
 9ilxXMYL03FRSIBKNabk9VAHfvr0t8X/8X9vNB+k1WfhHNwGjO8hcnS+H1jEc5AcDW43
 tHDAVur18qtjXbQXVYq2H4rja/i33CdNlGfpCLZ2lBG9D7CENPgBq0wzqgX+JcNNiuyM
 48taUvxbpP2mMsjay50tYXdNXaLGZ3iHNaGRbg8FofFBcP8YJTVPBvKghQSgTPbNvMf6
 94NZ1QyZAXh6457B7bgdJUxXXzYUmwJLEBliThPDiB4hyN6xtrLvZJpcFMZKgibFJK5Y
 yS2Q==
X-Gm-Message-State: AOJu0YxRqRAYZT6a/hKJ1GloAUoW1EFbGcSYoOH76gmSrlz+LCIdzsqA
 fKUphRiUKJQjSqmo/XPGUBpNLIIO4kqNv7AasV0SJF3sAA/A6nBlXKkMhSD4/6RKwqGBJ+zBvUi
 bb7wtRU8=
X-Gm-Gg: ATEYQzxgTJyb/8ka2cduECic3bvzsJrSqInhxKKn7bNYgJwpcGDWe95vHJAHQE3EAPo
 QVv2sTKae9kamuchfG5MV0sskmk2l009gavg0bJYwjSEWXoBbuwa8q+LcudSxveoNwxqo1TK2VF
 vJfX1SGMVj6j3nwd1wc5ClO6+lYm4F+n5dEAeHTYAP8eCc8pE8hgzIZwg1x0yGiBAX+OVJh7Cmx
 8sMNrgjFMIq0vJVro7IWqdRwA7ovS3m8YONxTSLkJlgb+Bx+VDMW7gX+q8I5BhUAHP6I530tR6o
 BOXou5uYQyCAmyF74c2PO8dzMhkcwp0Wf5xdVCIbkWhRLx28rDHrswizToOmiL2UCpBK5np2m+X
 sY0ds4+pxMQzLFfgmUsvTSv4ufvtE/J80NUWqQD3DAR6nZLGFpRx0IFvuxF5XOCURZeAVoBitbk
 yyz6lvEJp+KLqvpdmAOjhd9dAPyCHhwzH9O3Msl1LbZ/eDkPdqeoPpo43FVJKTA7DmR1RyC942
X-Received: by 2002:a05:6000:604:b0:439:b715:6f4b with SMTP id
 ffacd0b85a97d-439da8a78d1mr22493963f8f.57.1773081367549; 
 Mon, 09 Mar 2026 11:36:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8dbb3sm25412105f8f.4.2026.03.09.11.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 11:36:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 4/4] system/memory: Have memory_region_type() correctly
 describe containers
Date: Mon,  9 Mar 2026 19:35:35 +0100
Message-ID: <20260309183536.88976-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309183536.88976-1-philmd@linaro.org>
References: <20260309183536.88976-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

MemoryRegion containers are not I/O regions,
describe them as 'container'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index b130d956d4e..2f2f96ab046 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3303,6 +3303,8 @@ static const char *memory_region_type(const MemoryRegion *mr)
         return "rom";
     } else if (memory_region_is_ram(mr)) {
         return "ram";
+    } else if (!mr->container) {
+        return "container";
     } else {
         return "i/o";
     }
-- 
2.53.0


