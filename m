Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354271061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7HjD-0007hX-B5; Mon, 30 Mar 2026 14:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7HjB-0007h3-Lc
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:45 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Hj9-00039C-7J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:52:44 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-439d8df7620so3447354f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774896761; x=1775501561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BF7n0AeribVf5J8IKbflMfLGP0Uet1AjDdCOhZOnHQw=;
 b=bzo5q2yDcGVSZrrZJ21hpzmKIE6m3Kmml/RcDUehKEBzodFZneUQjm3ulFe8XxTtdA
 7FQMxKRkz9oU7HMYrEMOIoiNMHA7Lr0R5j6l7+D6hUtodxFVIe8PmQKW2MXjtiyI4s/K
 +JDXHl34hVuHsbBaWp8sFg6LcBJAEP6/+bP2Jmdb5z1IcutJX4PeU8HSBMSoGzleBneD
 0Y3fl9N9EkczZSpCJ2Bcn32oZ9j7B/A5kQwweCYJF2I1s+byGA2nvgKWWyBtvhprh6tf
 ZcGZf3YYicWx3iL5qhFHutEft8m4zmYYwy4CsEEx8I6OQ86BH4zhtVgCRZXK7A/hHKmv
 wDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774896761; x=1775501561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BF7n0AeribVf5J8IKbflMfLGP0Uet1AjDdCOhZOnHQw=;
 b=ofMwTaIV28HRYPHD1MlQduUdOHveCK1sjO8cd/feMOYvRbASOnqdx0reC2UhmpMOUb
 H8abVUjJOwX0GkcitkmDGCF/wGC4uIYvkTs217A3Srb2oO8+2Eyf0SnbscbkfsYyKRdd
 9l0ViswrYdi+x4cUnCcetDsMQ1ItKo9BTfQFMJfxCqOW262tyq3ZbPX8/ykHMspa1X4k
 EeKTdKP/hqiAg0/AWLiKCJI7MMZbNMUqd5ptebd81iHfWWTHYow/HFz2fRdGvEbGoc7u
 sKC8aM369jn37u9d5XlEcjYWnn6pDtS3R4lGSj3fcHHM9oVpwBfvtgvixy2+4WzKynPS
 6eYw==
X-Gm-Message-State: AOJu0Yx6pMYl+gMImNFVyFatdQRi3dneyW4yX261x3LbESEedFR+TrgZ
 B7NtBnBxFXU/r9KjdPZiDCo7wRFEPcSyW3vq/H65AkdK6pOltSxaVawPYzzDY8OHLT1VCuByFNX
 oECAr9Ec=
X-Gm-Gg: ATEYQzw3SeKqU3mIADQEARvEqlVXkz2oVGDVISTRd41wifwUV8EeKdAZ5+2TU9CQJfo
 8TI4VApNqiCLfCxPbpnLgDRnE0LORVLbhbid8qHl6FKDm7fSVvaqJ+DcMNnrhH7+FDQNyXahz1T
 cALbOKSf5zYNiOpL66vXl5bvR+TPRpxOUY+MC+pxEHnX7kvtdXjjzVhX5UyaPnGBOej9ZpVeRI/
 JTQSaCR8WWidC9E9d9r7G7hLhrimnKRgOFf7BbFvNAlouvVqzK6TR2iKV5hNclrF5DG2G7KlHX8
 RdVWuIoZcpJzhdGKWUdiuNV4UOWI7vxAB0immSONDRCeqKJ1LamHMJZBM/uRrD2aThanQviu3xH
 LWWOFRp055407SEKUhg5U1sTnJ1GO+PYVFKv07G4HJvOI9YOLxFPa5q0VN0alE2boWKBcXLpu7S
 MfW0Ko0K7fCFxy2SqjfwKsQm8+cj+btz1mHJdA7P/VDr2694usgscY1xp0d2iesa6ZRuDlg9vzp
 JWIb1gN4VJTqK2RLANYSEcV1YAWWp4=
X-Received: by 2002:a5d:5d12:0:b0:43d:6e0:9458 with SMTP id
 ffacd0b85a97d-43d06e09528mr3281574f8f.39.1774896760726; 
 Mon, 30 Mar 2026 11:52:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21f1749sm21229400f8f.14.2026.03.30.11.52.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 11:52:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/5] hw/net/rocker: Avoid double-free of l2_flood.group_ids
Date: Mon, 30 Mar 2026 19:52:33 +0100
Message-ID: <20260330185236.1905636-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260324193530.375628-1-peter.maydell@linaro.org
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


