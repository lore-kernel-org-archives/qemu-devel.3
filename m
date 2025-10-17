Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B97CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kXt-00006f-OY; Fri, 17 Oct 2025 09:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXr-00005y-Tz
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXb-0007yV-QE
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:30:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46fc5e54cceso14681715e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707836; x=1761312636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O2UPMw/YN3rHSOyP+4AX/2wuGvfW6yAoggPFM7dTXo=;
 b=P13NeCyvvoyzuGk2UYhpVhqz67+wuGbGJxDeyuc+/m4w1mQEovy792/SYX/d8PY0Tq
 1z1AB0CmLqmpETOlIzLWDyPhoUsKHI8r5610RrXYfb9xqbPHSlTTH/c3YUKljyQ9B2Xw
 Jzi0mqDNOazGcMvq83T4YlfSu17EGe7e3dcUPco5x/wL+IksSrBN83salOE6d+cVRW9J
 ZQSyQrLFOLWMHHUvRJUSRSCPxa+YERsimSf+uCyngwphAe20nPgiW1s+SZ5e9fC7zXZG
 9qRNZkkE07fM+AIpilz6IySLFrJa3Qql8oXFFYFA8xYfzYcaqeIZWM/nCmf31h3PLvr8
 uwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707836; x=1761312636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O2UPMw/YN3rHSOyP+4AX/2wuGvfW6yAoggPFM7dTXo=;
 b=Drmo/QWYt2RYEnmon14JyJK/AgYnD4SwKi4Br3T7Xy7DDeKdn8uPWvLSLKZW83sZ45
 K9EWFBLCo2P+QPAMwfAPKDp1xOPUMnM39KIoPkV0HpdZqcv/8rv0xtAFXNX9l0eGo1+l
 Bxy2/YQEW90cNVzZVOyT6reDfhpAhMqNvT0b9OnijpO2mIpZPsTdpDYQNhD/jX1eatj9
 KX1RIuI+HjQBFfwkzuhn9az0ozsZyEy3uRRkNM6DKpLKdVo7Vz2Wag+Or56sxMFM792U
 tA/nI6dzc04fq4iscd5n6UemT9nGt4+4M+ZMSIrZtPQS5k6exQoWh1K+l5bvN+j7lnHS
 F6fQ==
X-Gm-Message-State: AOJu0Yy6XyuyNEmNwQ3ocOjDm1lHLxuLN3kexeF3WPkINOciu5zxc0E+
 pXaf7cqaGUwflm7YK+hyUeU2kMzNWwB/pAGNhMfUodDFu5c7/7UXd8E1EEiT/RLYVZCCuwbzOBB
 MKVGpL5w=
X-Gm-Gg: ASbGncutqCqrrZwnMMfdhX7pfgB1o2ZuISQCFWoFApYvz93sZk2mwAFE0ofejuYpshB
 pj9VSXETSpORc8bZkZlu7bwOvIEB7KWeIdt3QQTpWXxPYSfd6zbAgNT5GkKZ0URAfdnYghuErvj
 DQzJfzTU1v6KLnq0DfElXz8WwTIYrLxHZ3HN3PPqRrvI8rq/WcO0G+GuyQJQxumOn9jIeHLHpBz
 RkprlsRaYejhqv3hQmffS0jTxCkg9+e4JTBwKnog+4VvWXmnUVM62QUpxoSYi4wbnwe9L+LHWBV
 6qvE87stKDRwTPirzE+yHmJltuEB2QkqbGOHhOF6Rkov/4NnBepqpyXU+Ea3xnKvQgEwEotRWX6
 fCXZ3MHucATnPx/HW3zXxxo2Ip3hu9X/XR9MWmmrudiqV3bQF9oS7++aJRUn4yjex34tOF/Godu
 fGErAoSXP4hAbtsA7q8/UjLwkDC1b0hKtufvH9yl7saR3+pgOvQwsCKJ+4tciF
X-Google-Smtp-Source: AGHT+IFIi9zF9k2DTInlvNKnPaqDmAniERN3xGMs/Te5YfN/gfEV23TayKVAp7n2qEdq11t/OuI6hw==
X-Received: by 2002:a05:600c:6291:b0:470:fcdf:418 with SMTP id
 5b1f17b1804b1-47117911694mr29067855e9.27.1760707835679; 
 Fri, 17 Oct 2025 06:30:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42704141cdfsm7661994f8f.4.2025.10.17.06.30.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-6.0
 machine
Date: Fri, 17 Oct 2025 15:29:55 +0200
Message-ID: <20251017133002.61410-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 103b0c4d73f..46dcabe6ad1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1094,21 +1094,6 @@ static void ccw_machine_6_1_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(6, 1);
 
-static void ccw_machine_6_0_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V6_0 };
-
-    ccw_machine_6_1_instance_options(machine);
-    s390_set_qemu_cpu_model(0x2964, 13, 2, qemu_cpu_feat);
-}
-
-static void ccw_machine_6_0_class_options(MachineClass *mc)
-{
-    ccw_machine_6_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
-}
-DEFINE_CCW_MACHINE(6, 0);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


