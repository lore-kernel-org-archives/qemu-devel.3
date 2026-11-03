Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE608606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lNtpzduO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbr-0001xP-9q; Tue, 03 Nov 2026 09:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbk-0001vu-Iy
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:30 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbh-0005BY-09
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so41962185e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716523; x=1794321323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sJZZx9O1ukYlt5ZhKz2tX29/squSYwod0or2GxasAu8=;
 b=lNtpzduOt3UGZEH02tQiemLWKQJ6yrY4Msz7ol2Krh5HHIeI3Ah/ipsk6DG9J2aZjU
 3CygA4NTa2gY6G1iTBSVe8Vv/C7VDAea00rmuwOJ0Vwcyn4zlJ+Hc1KSCmc4tr9z21hG
 mxMptovNczbwtFbadGiUBlQXdAIyZrqWrNCv+9pvN/wzC2/b+d76coJJ+w5FLcqVRxGo
 dGHrPgiUJO4svr9OxxMcOdGEru0HRD3u03x9EZTptvjcmwzlcEPP95QJKRnf3PZ18zhW
 IowE+7KWzcr5ddoTkSTpPiVgF3ZzkvoptN73q3w+xw5pqs+JFkKRz6FPLfnqKw4k1SQ6
 6pEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716523; x=1794321323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sJZZx9O1ukYlt5ZhKz2tX29/squSYwod0or2GxasAu8=;
 b=LSf3qbDLr7Py2O8fOp+6ILWtCkHHbeIj3cz+YI+BsFUBjNqBpyR0oeydZbvi5QIltM
 2AtMBsa0b675DyYuBQu9agRGxTzdv/GNC4TtFyudM1671RfYrPXctpslY5ANJlUJIq3Z
 8cHuBa7OGdbUBeVKU6CKbeCgiEDO7+d1xpht+59xjjvUKVstUaE/S9tBK8FpQZ68n4IT
 sMGU0gX5/YNhTX0gUA68kHXhFpMvJvbwF1d07xCTqe1hzl5RilwAEeEdn1hlWRwz1dJC
 O3C1wtGjE0GOBSGAeYM3CV+ldBwmb9wvvyogNYlh+9xwpsBKZFh4pZkZ54sQFjLUXFM9
 1zjQ==
X-Gm-Message-State: APuU4Z9MFalNcOmDOZ7CggoYs/i7/LC4RlKBbwirmf1RA5TBBBbsv9e3
 AKKIcSAsMzmlytyRzRrx75iEcSLK7VCVm4oeqQBbmrNizrUsd+JS/Yx6P8GRhmu/dUjj6x9/Lj5
 tnslCcBY=
X-Gm-Gg: AYBFou2vEmbHPBEcKYO7Qoh+Yazg1S+mqLC+NksxFwh8C1s7FDOfa3Mv7bfvB9kWVQk
 nkc+tIBcBmmvzO7W+ziPQwLAe6qhTPnMCbmjKLg+dJQH+kyAR081/o2/D1vzIIbSuPPvWbWe8au
 eK5dassY6tD8rDWUMk3VPH4TGY/fFmta90sMNeOt1sHe+4eKPnHoiyVWGyXnpf13d1eE/jIkb7H
 wkTwvFiSJ5GtaZvKXZ3rVbE1aujjssEg+iksDTvG8r1wIGQhydPn40GmAhZCAKO/lvz68we3HpH
 V1xaIMqSKaKYHMXFWgsZN3BsRp3JA3hdY+GVzt7TNWdtOiRzsfNTl1qUvwf/HpAQbeCwRMfFU7s
 V234tyczVi5WMHz8Fzeje0UUlf8N4Uwj0Glc1IWLUoW+FY3g3Sdz52L1lwhddjpNDwrp3MFNcDp
 7ypyBskwFAnKiXbKejbYd4PzOnFt0dYV/P8dSACNXVBcJgPswDEFf43X0+4HBSig8gHu/2n0DAf
 1+YODD465iTnVDPdiEzBHD0Vzp/sK9O6riDhYt6MgksYl7cHw+E/yrPkDwxnd8Fsf8EXAY6Eujz
 TV0ZJ/6FHdCaBYfX4FGUyllljS7Tsj/cxVU5x7ElbA0G79WrCQjvxWLYZXsP/w4fzrOCTRQ/7Lv
 iZeRauBeBTgchMrxfazESQ9JIY/SJxaXOCK6h2VZgNGJ4m517KaF277Y=
X-Received: by 2002:a05:600c:524c:b0:4a1:fcfa:2a07 with SMTP id
 5b1f17b1804b1-4ac1960dd8dmr305416415e9.30.1793716523575; 
 Tue, 03 Nov 2026 06:35:23 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 4/5] block/vmdk: Reject a zero cluster_sectors parameter
Date: Tue,  3 Nov 2026 14:35:15 +0000
Message-ID: <20261103143516.2182626-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In vmdk_add_extent() we reject image files with an excessively large
cluster_sectors parameter, but have no lower bound.  In particular,
if the cluster_sectors is 0 then we will set l1_entry_sectors also to
0, and later crash with a SIGFPE for division by zero.

Reject a zero cluster_sectors value, unless this is a flat extent (in
which case cluster_sectors isn't relevant and the callsite always
passes us zero).

The worst case here is a self-denial-of-service with a QEMU crash,
so this is a hardening bug.

Cc: qemu-stable@nongnu.org
Fixes: b3976d3c8b89 ("VMDK: introduce VmdkExtent")
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4017
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index bd18d32085f..d7e23ae8098 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -552,6 +552,11 @@ static int vmdk_add_extent(BlockDriverState *bs,
     BDRVVmdkState *s = bs->opaque;
     int64_t nb_sectors;
 
+    if (!flat && cluster_sectors == 0) {
+        error_setg(errp, "Invalid zero granularity, image may be corrupt");
+        return -EINVAL;
+    }
+
     if (cluster_sectors > 0x200000) {
         /* 0x200000 * 512Bytes = 1GB for one cluster is unrealistic */
         error_setg(errp, "Invalid granularity, image may be corrupt");
-- 
2.43.0


