Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D9CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLKq-0005km-Ty; Sat, 13 Sep 2025 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKo-0005jP-RD
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLKl-0004q7-AT
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQOby/BAJBGzsbQkEY5z4jLqdBepsOlgz7xz91bkfdo=;
 b=PqXE6T7fer95aqm7IAPnTHfnouDcdcxtxBvSjrY7jSxGYg3BmG23mlMQEPg8Lo51h1SEu9
 pCE6z+drMM/8EMEodqEoGAG9Gw+2x+4Us5nE8jWo4qDNvGf4+ibjlyRTQV5rJm36zk74gs
 dZgdJnXkZhh7tw1ehklH2maPLnP9fE8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-EaeuDGOqPqWPq9_xyBWkmQ-1; Sat, 13 Sep 2025 04:10:07 -0400
X-MC-Unique: EaeuDGOqPqWPq9_xyBWkmQ-1
X-Mimecast-MFC-AGG-ID: EaeuDGOqPqWPq9_xyBWkmQ_1757751006
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dd9a66c3fso8824685e9.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751005; x=1758355805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQOby/BAJBGzsbQkEY5z4jLqdBepsOlgz7xz91bkfdo=;
 b=E+NdFClM0LwTDdM2krBYrG9hJJdUPfB64FsCMHDYWmI7cgLTUhPGCtWHbis17GtHZa
 ByiyOb9GDowDe2HME0PRx+AmZcIEV6OU9W+g66Q382VFytP3PJkwAtDKAIw9foXSA8mO
 ILtGPuvsM+K23NVhCOombJOqL7Ym50i/sRTDr5o0DMP9Xw/shGDrqVXVp+kutIj8z6FM
 ed2X6tsVjxU9dgAsBXtA0FBsFU8ij5yHlLAyT5GtzI3PeW3Zte5plFNyzm2Pz79YkVyO
 jh3ZW9aVuDNqgIx8NkXil6Pg2rBO0WPAmMeEAYkS6rkpDWsqzMHeSrg4pzzfko9qiJnG
 fezw==
X-Gm-Message-State: AOJu0Yz2x82S4Y9mmWshZgQUjbmNIEgflajP3cQNlph1dwGRDTn0lIVa
 aeS78F++w/iY+mV26ZP73kHIKqK4JQyRzGZ4t67QjSBEgqN62nG0FVi9PKK38sapbpT/Cnnk7xn
 FOXAVSGYoDJOjxfBwBkYh3gOZeatoS1jwfi0o++ZgOoeuItyuc7UXTvWItjhCjypKGW6vwDYF3f
 zZQgj9tjR6iYL1/KmEzDz5nvxRTmIQ5EAQ+LBquLez
X-Gm-Gg: ASbGnctx/U+ksx4g1lhyQkvbNXNAxw7IREryNTYvmywzHU/qO+YLHRHzPTCwuByV3Zl
 k6fdqzKgJCoGbdUUu0xFoEB9Pwk5I8VWF4qHfMtP6D7rjaIqOCHAK9/s7V8w+TEXyt4JS8IcITh
 dt/+RYHhH3NDf1Jj0djC/aJL2Mf2BgLVVhG3jrObfxgLjNmi7qWeaZm3WTBhtq2o9Nyv14+WzhS
 fd25UGaIlkffQLlG403dBhkiQ/hPjZUofwpbw0TIxFJtw/KzqC+kB1jQdnI1P5+eCwXHsvC/5CL
 HqkkWLnRP1y5+m3Z2yN7Jtp+fNbdcFbkCMLy0u0kHI1D8T73eaoDLiMuG9Do2C1hRy8Mg1O2F5b
 dApwpYKkayNRvJ1AThXcIjyY9Qe7q02AOmDMaSqZ9sSg=
X-Received: by 2002:a05:600c:228f:b0:45b:6743:2242 with SMTP id
 5b1f17b1804b1-45f211f86c5mr39507175e9.22.1757751005181; 
 Sat, 13 Sep 2025 01:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdYN7zjBXL5Gx1hvNf2g4mjE8UdIR4weUBckc7I6Qj+khvXPzgyyhpeKhefb7KJ7xmHO6lfg==
X-Received: by 2002:a05:600c:228f:b0:45b:6743:2242 with SMTP id
 5b1f17b1804b1-45f211f86c5mr39506945e9.22.1757751004733; 
 Sat, 13 Sep 2025 01:10:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e82f647b83sm2516714f8f.20.2025.09.13.01.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/61] cpus: document that qemu_cpu_kick() can be used for
 BQL-less operation
Date: Sat, 13 Sep 2025 10:08:49 +0200
Message-ID: <20250913080943.11710-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 23bd02277f4..8b57bcd92c9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -829,7 +829,8 @@ bool qemu_cpu_is_self(CPUState *cpu);
  * qemu_cpu_kick:
  * @cpu: The vCPU to kick.
  *
- * Kicks @cpu's thread.
+ * Kicks @cpu's thread to exit the accelerator.  For accelerators that
+ * can do that, the target vCPU thread will try not to take the BQL.
  */
 void qemu_cpu_kick(CPUState *cpu);
 
-- 
2.51.0


