Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B7CFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWel-0003vd-Cy; Fri, 06 Mar 2026 09:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWej-0003s7-C2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:57 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeh-0002KO-No
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:57 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so2778934f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809194; x=1773413994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hDDY3r22JGwcDao4tzCI6uIgo6JsYupYAptKIjoTmEI=;
 b=c5S+Clhw8rRYs/hsr5ibBIIkEVaKK/prMTYBIOeYLvA5Kb7na9bKvg6zfjWtEvZjJn
 kZjejH+Nrxhl8GVh8qWfuLEn/8qxtx4dGeLnnG1Q/Lc26wma70XMC8//9h87YqBdwtdN
 tZUuP42gRv7wsjosqGAJ9ekMPFWo1ZwqktltO9O9BqNNU6/CB1tpyrIGmJIL4mvj3R4X
 9+dZUz/vav5j/wlv1Tb8t2kwCIVkgSgABoopAbCIACgzeoYkWgMTUdOwxWtK5ZEQJvCq
 lhz5Z9c5tnvO1KJLkfvM899M7+O1dRvOYHLobaKApc+b4HauEKfmgABnnVnoJMY19n49
 EVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809194; x=1773413994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hDDY3r22JGwcDao4tzCI6uIgo6JsYupYAptKIjoTmEI=;
 b=hEMrxM9pMwX7SDqMBaHIPDGa9lXF3/+toMutVt073hLm3HPYNJk/VcU5PXKbKZ3Z8l
 SFUvPN7huEKeZ+gLic6JcLAM1vylVvfURkmE7IJwRBeZyzhr0Y+R4ygrAnSa/sUDnSZz
 9rdnmQpkSlVpAD1Is2QkYMnKkaOBSa6rOpEVRCs9fB8JeKoj/zx6qUrreN5nBI6dOUmK
 Fn81Zhd04hsxq2X7EEH4Q2TtYCuuBWro5ITPatE3Ec0zCH6AXaxPECrDdC+XVPe5S6Mo
 JHyMmhyFsxmm74/vgGkcS7l+NznafV+ZlfZybPVaSvcEMvLmUehc/sko2H1S4EdZYiX4
 1tpg==
X-Gm-Message-State: AOJu0YxPSNRbia9fdSh7Slx6aRqrFbiUVsSuwFwB3n8MnoCcUSef1kEw
 TlLR0vC+bxZNT3n6pBoCHCwU/4/kf9GlM+2ihnBWYzt0/35L2YbXVFUiTFXsCeI4eUsTssH7UId
 FDyZu
X-Gm-Gg: ATEYQzzj2oEyelApZyJi2kWPgOODwqaUgvvRx050V9CdYB0KeOpWXNzaBlx9NpPpoLU
 llq30azFX8EgmNON2hvQtxNqjIDNr4cPNNJg9dDKpPpl3+1eIbj12HuZZLDOEa9NzK+LMsXmngT
 FQT/u6Jzf+eLWTOuFT19dU9pkyXEOiSTdGXL36vdGylSGNpRXFN9McJKPCiWFRwR0IBjPDVkadT
 2TbjVkK7GTWsNjoKKYngNHWCHlXoSlGkiW3XZ4JDF+GPznfuGtGhqJM5SSn3ELcDmSOLLuBB059
 3idZwShhV27pVquaWW3Nc3duTNtu6vdpe+rjVqwK9YfEElbb8Zox2n+2q1RxHHMYLC4hP47Zt2L
 /rTpfi+jqNqd4AgFO6iUmRMc5X5hVdXJrcgiDV6IhpmJw7nGXRpupuU7vmJ+b76RWlsBiNm6Yez
 fXrSM8ePHp2IukyLrwn61o//bCxToQ0aOjnM4IJOxsdhGggpAHojTv1FvS5/kT+jNbthr5NUZ05
 jw6imOxTKOYXhENQYk9awpzoLbK1hLJ5YuHgKjilQ==
X-Received: by 2002:a05:600c:46c3:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-48526959433mr41222625e9.21.1772809194172; 
 Fri, 06 Mar 2026 06:59:54 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/49] vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
Date: Fri,  6 Mar 2026 14:59:04 +0000
Message-ID: <20260306145939.2162189-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Already existing VMSTATE_VARRAY_INT32 requires an array to be
pre-allocated, however there are cases when the size is not known in
advance and there is no real need to enforce it.

Introduce VMSTATE_VARRAY_INT32_ALLOC as we currently have for UINT32
and UINT16.

The first user of this variant will be the target/arm/machine.c cpreg
indexes/values arrays.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 20260304101625.1962633-2-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 89f9f49d20..62c2abd0c4 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -447,6 +447,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_pointer(_state, _field, _type),     \
 }
 
+#define VMSTATE_VARRAY_INT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
+    .name       = (stringify(_field)),                               \
+    .version_id = (_version),                                        \
+    .num_offset = vmstate_offset_value(_state, _field_num, int32_t), \
+    .info       = &(_info),                                          \
+    .size       = sizeof(_type),                                     \
+    .flags      = VMS_VARRAY_INT32 | VMS_POINTER | VMS_ALLOC,        \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),     \
+}
+
 #define VMSTATE_VARRAY_UINT32_ALLOC(_field, _state, _field_num, _version, _info, _type) {\
     .name       = (stringify(_field)),                               \
     .version_id = (_version),                                        \
-- 
2.43.0


