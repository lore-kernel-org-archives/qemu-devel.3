Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3847CD70DEE
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkL6-00060a-Ib; Thu, 28 Nov 2024 14:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <abf0f092c1dd33b9ffa986c6924addc0a9c1d0b8@kylie.crudebyte.com>)
 id 1tGkL4-000609-F0; Thu, 28 Nov 2024 14:38:10 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <abf0f092c1dd33b9ffa986c6924addc0a9c1d0b8@kylie.crudebyte.com>)
 id 1tGkL3-0001i5-4a; Thu, 28 Nov 2024 14:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Qk5/KF/1vF+ZSw5b8p5vFLsVZz9aE1CGi3a3hyOPSlM=; b=d5Nym
 Df9Qb+BBRe7hgedaCSn2W1Hn8fSdtkCjYYjUak9RMvmsqfoXUo2mWMj6V2cc7ctIn4/HJkcszVd/k
 HLUP6YduSTFeQGJnxxv1NWcKfYujqfUgNMVH67lYgP/YmMSMshEekwT6srq3SwTnVCB0dWygDfYPl
 qiRY9nBEqdo+oENR7wfTr29a1FdaGSXhIAxXfqvJqawu4U97qh55Wb2L9ZX6aVg0U7jit/J+T2aNR
 yRaSUVt3H6dO8T7fWt0eZpC/rohXn7HUIgfj6ZL3ZCpPVPJivxtQXwhpTPAIVyKr3I79zBzvmFU4U
 s3RwI16eiGNBKBP/Ji7adHpJItULe+lvIRT1ckCTaIVCI2AjDpJTnJrGOulR3LQy3e2bxYkQikWe2
 AlZ4YVV5ZVgSDGYwAktGKysxRqaj+HOlyaZjzIVH92fLXCzatOvRx0AbC59l57wq5YcUmAomhP04g
 ZYID4xxwd7tGxzCVIhz2LmnSPXEVZ2kXBVjo7Qq1EAE4FYgDogr94ReLbhso+sIZNtwrOoK8h51D8
 oxH8nVIr8TD6LjXK9WWY4PY1s41QBeH0nvIUiQ6Prwd8QZj9ryYORF/mvDsFYvQvCDUc0RiUKWxjw
 ZKsjgE86G5GGoOG1WnuNDhsHHiCsjLSS9T+g+HGW98gR9El3LhHZgaWjHk09VE=;
Message-Id: <abf0f092c1dd33b9ffa986c6924addc0a9c1d0b8.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 3/7] tests/9p: fix Rreaddir response name
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=abf0f092c1dd33b9ffa986c6924addc0a9c1d0b8@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

All 9p response types are prefixed with an "R", therefore fix
"READDIR" -> "RREADDIR" in function rmessage_name().

Fixes: 4829469fd9ff ("tests/virtio-9p: added readdir test")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <daad7af58b403aaa2487c566032beca36664b30e.1732465720.git.qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index b8adc8d4b9..c61632fcd3 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -238,7 +238,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RLINK ? "RLINK" :
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
-        id == P9_RREADDIR ? "READDIR" :
+        id == P9_RREADDIR ? "RREADDIR" :
         "<unknown>";
 }
 
-- 
2.30.2


