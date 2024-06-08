Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2940AC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXr-0000s5-IG; Sat, 08 Jun 2024 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXo-0000qq-Vv
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXn-00008C-Jo
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXnnhH0cnkHU+ehb7yw4mbwES46u16ZrihCJI8uZWQo=;
 b=Ghn1s/Jsg999PnWdX48ZEuMDgP1UTFdKo1zTSn4ZjKSq2apTB48PZfRsCQKffw7btqhSIZ
 adtPk2hCnwWSTAL2eImPQEOkNfuSMAOQZftnD5F/C8gyjhidMWyCNfq9v56H2Cmza8kKtS
 Ouo7w/2gBOODLRdz+kLx7w3U0CJ7kdA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-sGRSXZ_0OiKYs-JjVjAgPw-1; Sat, 08 Jun 2024 04:35:11 -0400
X-MC-Unique: sGRSXZ_0OiKYs-JjVjAgPw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f0f008f9aso2314966b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835709; x=1718440509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXnnhH0cnkHU+ehb7yw4mbwES46u16ZrihCJI8uZWQo=;
 b=Rj952HRDR3hMH72gNG0CP4AWdUOXonrSNZhzAHqU/PQ20BDL/Om2xgcMvoFywCPINm
 oQtFuXK8H4I4KSz6MV32oq8RMM3skQN+5XvcHiL3+/KO/27tdJ7gfjWYsXFA5xP0D9wU
 Yj7bdLhwTn1IXdxq1selx9XM9WP5XuQ5vHPVajTEBGyCGdV79B2XptmdjoMtgGg5JN4B
 yRmedFA3iuz+qsJ7tF4txNVgLfzx9pL2pvv9/yq2U52MGGGQoOhk6oG0r0mTsCnaApPV
 Nixk1slBFV1cY3zfu3UXBIAKHMcLW0zIzzHGy8OoEuJzSc5o/Yv9p9Rp0hTXuLz74l1a
 sKxA==
X-Gm-Message-State: AOJu0YzDVRVHrNObeulr8sAllcgR7TnUKWwCeqLqyfx2E6tQeaZ0Tjor
 oWJQhmjSkGHHovrSObq+gyVh1hXGtiAM+n+GGiSzcFlBylP5Y4VLHwS7WLuAd+4l6UPRAdvndhI
 5QYphfu70cQcXluoX3g6ebZ46OfILQS5cRpVAcpaghNyTG0jwGS3QrhK0zmNmjn8wPmkZGd/Egt
 95SLJLVL2hQN6bTkeAx8qih+jyJamrhPjrIbEg
X-Received: by 2002:a50:9507:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57c50861786mr3219457a12.2.1717835709311; 
 Sat, 08 Jun 2024 01:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtoNaKMcr1RoBg3M2VgzdCmEjwFfgtqHVvppM1EKEKCLiMn4NJGypxRjTx3Wa/Vjz+D9Uhkw==
X-Received: by 2002:a50:9507:0:b0:579:73b7:b4cc with SMTP id
 4fb4d7f45d1cf-57c50861786mr3219443a12.2.1717835708958; 
 Sat, 08 Jun 2024 01:35:08 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f0bc2a31asm32224566b.63.2024.06.08.01.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 19/42] osdep: Make qemu_madvise() return ENOSYS on unsupported
 OSes
Date: Sat,  8 Jun 2024 10:33:52 +0200
Message-ID: <20240608083415.2769160-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michal Privoznik <mprivozn@redhat.com>

Not every OS is capable of madvise() or posix_madvise() even. In
that case, errno should be set to ENOSYS as it reflects the cause
better.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <b381c23bd8f413f1453a2c1a66e0979beaf27433.1717584048.git.mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/osdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e42f4e8121d..5d23bbfbec4 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -64,7 +64,7 @@ int qemu_madvise(void *addr, size_t len, int advice)
     }
     return 0;
 #else
-    errno = EINVAL;
+    errno = ENOSYS;
     return -1;
 #endif
 }
-- 
2.45.1


