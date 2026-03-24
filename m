Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C632FEC0FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57XO-0000sk-RG; Tue, 24 Mar 2026 15:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w57XM-0000sL-8I
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:35:36 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w57XK-0006nr-DS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:35:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso1973855e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774380933; x=1774985733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GDxBD2slxa/qr05PqNswk0PG2IQH7R7Cd9XrepJdiD8=;
 b=qylblbRjEOxEdh2ru7zklYHND23xru2y/YSNwflap1bKlTKAQPvjNAcKOPKastkkVI
 uG09/g+blA6g93EcE9Nr5npEoFy4AXkCu3Ez2cHih76a/qGQcC2D/3LAZ62v7Klrveyg
 3Rg/LKrYdVClPBIvxlKhKsNtFTZ9rPpB7qRueFffD+hlkQotuEMk5/npfSKjaYCPMdL6
 vc7G44A88yYJtO/f7uuzvu4MNC0VvDuRvef6wnn3VH0BlFcyMlDL0EiDxa/MocwbJ2LN
 rR4kxySPcC7f47EEDwj4KhYCsUB+T1wHgCdTiaPsG32+Uf1qbdKGgY0lDh0Aul4uSIP2
 jrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380933; x=1774985733;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDxBD2slxa/qr05PqNswk0PG2IQH7R7Cd9XrepJdiD8=;
 b=Y/8C+12LBghc7irmimRFLlkqlM/zjpmxxvHyrVFC/p7oDOz3uQl58g9TpP4jpyUem3
 qWynJPZv7J/MNOA8UynJOaxtM4bHfBcmBx12ITgmM86RqJxISs+2atL3Mv+1d04x7gwp
 zKsYIhEkZJLFLHpW/sx2Fcat+iMJZVawdNXMqw5ZXeDj5RIcq+ez3DcTn7/X0QyXPtMW
 K95xg9gfyx4z9lS997M5Ijx7qjlKgUtWvk8urjGmB9DASPba58MpyJM5ZC3J5BjRmH8H
 Ua+EBGcCOvyxApWa9eMDO9YThKZGzf9n83vBCnIEa8LA59dDOlLVIWoTZdtX8MLN4aQT
 feGA==
X-Gm-Message-State: AOJu0YzkzwTaoA7KPhnrbcjhnnU5efEvUObaE3mBg0ROnjbQ8Vz+5ZWm
 D0b9Q6dsUMmgbmas3UB0ayzHkn6o8BRs1NI3AnCDhHdQfl40ovWOw+S87UsCF1TxRqAew4zDuxm
 ouGHRHe0=
X-Gm-Gg: ATEYQzwck+R0mGTUEjYlqf+oc/e9U/RIDjiMxk7zSntfzF44VmzsMXL6+zEIjUoDD5w
 n8g8Df1U3gYEW4ipyp2bwUmxzUf2RO0xTbs1gSez9nKKlA0etXb5r4INeAhZ117TMFLz/wEhj2I
 CfC4Z0B+rHry9x/gM22S+75q3ce8FVKj7X+mQihbYq5OlpIayxgJqlYI0Wge2xQV1Ean0C5V1Zm
 iKWSskHHbdzD/YDNeLO69jJ8cqrcFCXjDNvL5oX9Hr8buAXiCWaKd8c76yANWPvpo7GcuDzhWOm
 rZ9xI6u6DhqnT32YvloTnjJX/n1z8tfV4xhfB8E97z7vhhgJzIjEeezVVY9B7eeS3veg1gnMk2c
 irA+1ZkoGjaPLVXLpshVaPuonOI8waN7W2yK9kmV4dbBDJMIG68Dt1BbLB3LXAnRD9L2bVUzGPT
 QZiMR+BNHnQbHaKP6Ab2IuOezkDyq5HZZa3zWT7gFzrceJOpfG6CDUPaFnZOeaioKjeOOFVz5LC
 xaYEUEqe39Wq5+uUVFHJEUW0y7K+fk=
X-Received: by 2002:a05:600c:5288:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-48716075f66mr13447065e9.9.1774380932230; 
 Tue, 24 Mar 2026 12:35:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871664ad92sm4318255e9.4.2026.03.24.12.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:35:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH] hw/net/rocker: Avoid double-free of l2_flood.group_ids
Date: Tue, 24 Mar 2026 19:35:30 +0000
Message-ID: <20260324193530.375628-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

In of_dpa_cmd_add_l2_flood(), we allocate memory for the
group->l2_flood.group_ids array, freeing any previous array.
However, in the error-exit path we free the group_ids memory but do
not clear the pointer to NULL.  This means that if the guest causes
us to take the error-exit path and then later call the function
again, we will try again to free the memory we already freed.

Fix this by clearing the group_ids pointer in the error exit
path, so we maintain the invariant of "either it points at
allocated memory, or it is NULL" (both being valid to g_free()).

Cc: qemu-stable@nongnu.org
Fixes: dc488f88806 ("rocker: add new rocker switch device")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3253
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 814f19afc5..3190a0e75c 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -2059,6 +2059,7 @@ static int of_dpa_cmd_add_l2_flood(OfDpa *of_dpa, OfDpaGroup *group,
 err_out:
     group->l2_flood.group_count = 0;
     g_free(group->l2_flood.group_ids);
+    group->l2_flood.group_ids = NULL;
     g_free(tlvs);
 
     return err;
-- 
2.43.0


