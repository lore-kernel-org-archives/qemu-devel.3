Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB6CC44514
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 08:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdpR-0003Ug-9n; Fri, 17 Jul 2026 04:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpO-0003M7-8h
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:50 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.kuma1313@gmail.com>)
 id 1wkdpM-0000n2-NU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 04:21:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso7700157f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784276507; x=1784881307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m09Cn5mBSByo+odkGAcJwQBWYgjFxFbtWApOsvVdC00=;
 b=cECKjQjor10eCoidMVqJOvvGKoy/Hl8Y8PD+JL3M13c1ojjrvsw7cRiOE4kDKli32Q
 EivWR2c10DLzJmUl+Q8Nasfxva/dTiQ8ysRP/CyY06Nq6VFaSOqB8vNAy/DkjhIScuh5
 PDM2hWGCEyGlYuKhYVltKVQC1+XO6OcJWl3sxk3pAKPrGIdur7bMM1QKkBDAzyXF5njo
 ya/WKYLAaXZCryPq5Np7tpSxgqWfxx5Gorx0rNbeSR5yFow4eW8y/RP81N/+kq68a+zd
 Tv6NgHxjHNEk9m3vbqTwsNu2TiBmVdynfM66zvmHi/TPtKjWUKFZ0GIJ3ZYOeEyTvDP9
 LdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784276507; x=1784881307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m09Cn5mBSByo+odkGAcJwQBWYgjFxFbtWApOsvVdC00=;
 b=nCmO2H5hVdFd0LUlHPLg04YgPY8noj/F64wxW+tO1s7efbtFvUK6Vek2otb5k/71fX
 tWeIuIjCzrPZY0qQ6fU1Z2VvPA17LR5LLx1qh1FFyxIUm55B40OfMOhDUWnvuDNhMGrw
 ee7UfSA5QBjA6m5wt/YAHZpShCV347eHEjch/yKYWCAxyC51qis0xHneq6aTIne3sf7N
 Fl07Y3HdaG+uv2GVUC2RXXAcrjJaLKcYcOlmYZxxtyYpzywZciFTrBQ8QpcvcXmOLA4h
 15XhYq/349z6IS6O8VhJNVP4mjiN7vbhtOlTWMIrfvwv+bGAlzAO8f6Q5PJZ6Tb5YP8I
 UYUg==
X-Gm-Message-State: AOJu0Ywp3o4yMIisQGrtw9fYfjbj3TKlg8QkCLTmHEp8MKhehjAdwrMY
 Rbxqfuovb9d7EqQL8PdHYN/WV+vzE9BsNuyKRUo8ZSeoGitq4jBq7v7RDrfufowm3Ig=
X-Gm-Gg: AfdE7cmIG8KGdi3R6C7jph5v7EU5LDSPjp10PK517mFftkG+nK3dCLYb1V2ZfKUo89B
 AEWoQQ25VeysiUprZIKnF0FTN2+EjXYsvYUfFfV7uPeRjOPaSdAqXPeJV/+ouENfcQLITUY+t7r
 Je2R8A+6+yJaV6SIV9mS7VkJwYtz6jWPQy3Bih9R/j6ZMACqn6PoGPjpgviOrw+ubRiLbzdIIGa
 S4vk2wmicZrCMjq0ie5u7d/YZwjxi+853hcN/Ny5fNyZ9LEtFrPaOJ7hPg5w/BNb7k7pJgq4YDu
 1ozRAJLwPmveJOTMRCU+v+IBpAoNTH/r24bULAyF0iYax0Hw3NMeCbqgHr1BaJkp2Jod+03JjEb
 6fPtt4knii36KEzvw16N+/9udMt29MK5s6dvDM0XM+jPITeijWCk9uR54wVEXxuuSMQdL9eyOk2
 cPDhbgQAqppHrWTar8Ngf/tBSKyLVAMiqGHyyzjuGMYogqME0i82s5xIGFvHET2zekXgOZPDUzQ
 m9Wb8rFrpCVu3ED7r2BC3X1Wi7ZmH0eb/n8IXAZ2CK4EajYQU4=
X-Received: by 2002:a05:6000:2885:b0:46f:5d62:d914 with SMTP id
 ffacd0b85a97d-47f6230651bmr2418875f8f.12.1784276506915; 
 Fri, 17 Jul 2026 01:21:46 -0700 (PDT)
Received: from ip-172-31-13-20.eu-central-1.compute.internal
 (ec2-18-198-207-175.eu-central-1.compute.amazonaws.com. [18.198.207.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edd7d3sm1622587f8f.25.2026.07.17.01.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 01:21:46 -0700 (PDT)
From: Rohitashv Kumar <rohit.kuma1313@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Rohitashv Kumar <roohiit@amazon.de>
Subject: [PATCH 2/2] hw/i386: make the latest non-default PC machine the
 fallback default
Date: Fri, 17 Jul 2026 08:20:22 +0000
Message-ID: <20260717082122.2439916-3-rohit.kuma1313@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260717082122.2439916-1-rohit.kuma1313@gmail.com>
References: <20260717082122.2439916-1-rohit.kuma1313@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=rohit.kuma1313@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rohitashv Kumar <roohiit@amazon.de>

Mark the latest machine of an x86 family that is not itself the default
(i.e. q35, while i440fx is the default) as the fallback default machine.

When QEMU is built without the i440fx/pc machine (e.g. via a custom
--with-devices-x86_64 configuration), x86_64/i386 previously had no
default machine and required an explicit -machine argument. With this
change q35 becomes the default in that configuration, while normal
builds that include i440fx are unaffected.

Signed-off-by: Rohitashv Kumar <roohiit@amazon.de>
---
 include/hw/i386/pc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d4b6d3ed..3e54d781 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -306,6 +306,8 @@ extern const size_t pc_compat_4_1_len;
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
         MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         mc->is_default = isdefault; \
+        /* latest non-default family machine (e.g. q35) is the fallback default */ \
+        mc->is_default_fallback = (malias != NULL) && !isdefault; \
         mc->alias = malias; \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
-- 
2.47.3


