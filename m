Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0815C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqew-0001LN-E4; Fri, 19 Apr 2024 12:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqec-00018G-8n
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00015o-Rf
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f15so18576065e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542389; x=1714147189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eY2FcYl+CzfFOjoUH17x+b03bQquHC1I7mh3fnkgfD0=;
 b=zUryZJcycH7tEz1ZQg+5x6rofWajWFuskrjEn7eqjoOYVHBJ28IUVFLH/cLqccAIXq
 7RnoOXb4e0IqGwBH8XwpceCoEjC/VrEahUkclsDF4E40D+dS3E8FMuShJnbSoxXYhPcw
 V2VJs3jKNz0QIl2g8SNxHK77hm0WOLG90cLeO3VyqV8RfM7ilNa+jYnjsoYR8Oeh5Ly8
 oHvQoLa1W+ej3pEujhAKf+YtziwdBIuJ66rlgBaI6CBXhxry+wTgjeWSX7mtQ8a3scGE
 L0o1MmG99BLnzpV3uYgXNn6xIDkUzZkTrb3e6WmVsWCNEYEttz+R4z6dAJzto7vaXKWn
 KyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542389; x=1714147189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eY2FcYl+CzfFOjoUH17x+b03bQquHC1I7mh3fnkgfD0=;
 b=AecByVZmLsHfQBB55V8SFevLYWGvrVhxZZFL2mUJQayWPVqE+0GE4LbszwnlIbZYmk
 4lskIhAdLDatflIz6YmOFErPKZNwIipl7AD+08PJ9F08M7Gixa9cZq1gj3+fsQTUBI/p
 imSvAe6Ie1qMmFuhDdQbQFjAqITsxzSO52M1bhXGbJzv5Vp5V4MrLf8WMuvEkv+Zkh3v
 Y8EhVf8Rw/lHcWupTooR97cqUtABPp8pvqhczNhicgBgbvCpeGBQAMaHSTbIjN74rwME
 BHwO5Xdm7QCGvmu/4a16gzauixsRIU4yQdgixOM3G/FANE+2X0EckTnWAI61V7Tv1jih
 y5mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAtH+cgFkx3AFCODl/flXmxXqOtryGUbhs7MkFCMiti+E2reNxuGHu/oWGDc6T98XjX0sMzTSQNPbwVg5PJ+BWsi1JQQk=
X-Gm-Message-State: AOJu0Yz6qudzcgQ5w2VZlJgyuomhTJfVyYeBIBuSJcyS/7A1CMrYbZ5T
 X+ZtEqzjwXISIzeJZozhYQtwoufiGv7qNuIpbycNEI0sRzlRtGDx0fupX19piT8=
X-Google-Smtp-Source: AGHT+IFdTCv/4qF5ef/m8iftnCwZTQyCvMGVBFc9yKiwQrHvinWiSlXgx1RyQkxThnBi6pkIAw+PYg==
X-Received: by 2002:adf:fa0e:0:b0:343:3a51:ad65 with SMTP id
 m14-20020adffa0e000000b003433a51ad65mr1537382wrr.38.1713542388970; 
 Fri, 19 Apr 2024 08:59:48 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 03/22] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Date: Fri, 19 Apr 2024 16:56:51 +0100
Message-ID: <20240419155709.318866-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

Returning an error to kvm_init() is fatal anyway, no need to continue
the initialization.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v1->v2: new
---
 target/arm/kvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3371ffa401..a5673241e5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -566,7 +566,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
         error_report("Using more than 256 vcpus requires a host kernel "
                      "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
-        ret = -EINVAL;
+        return -EINVAL;
     }
 
     if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
@@ -595,6 +595,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
             if (ret < 0) {
                 error_report("Enabling of Eager Page Split failed: %s",
                              strerror(-ret));
+                return ret;
             }
         }
     }
-- 
2.44.0


