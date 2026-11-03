Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1E606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xcTKPdTt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbx-000203-9Z; Tue, 03 Nov 2026 09:35:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbk-0001vz-LY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:31 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbi-0005CC-C7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:28 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so32202435e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716525; x=1794321325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XoYkG5HgUMmXMuKYnZiWXmhlnJZUkD60w92psedJghw=;
 b=xcTKPdTtEPb6k6HBoU1hRGykYZblHj6glrwzE8y24lPcd1UWFmWwfHOayXnb1JZyKJ
 +RZZQ1V9kE1ERMjSeBUg1jZ9cEtHlKu9J6hMJpVWhrlRgNwCTY3j3/MdexVjfeFHgxbs
 0yp9mg4CLD5H9bZ8W5eUKGQwFKp4tFEicdH8YjsgMksYX5GOhBIUf5rgko7takJH3Ha+
 Xi+AURef8v7Ba/JzPmH+Rzem95K9NQM4guORMlgdnS1pnW0A43jT5EH9SENieJn8RpYf
 Gj3MrDBGKIzW6Sz6K11OqeXBP/X2yCJDOv4smJ2Do59Y/8FlEJc8sFsetc/8RK6XFgcU
 5l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716525; x=1794321325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XoYkG5HgUMmXMuKYnZiWXmhlnJZUkD60w92psedJghw=;
 b=RoMD8BGObtv8hSYTkzqPuEVrwq297A3kv/g/3/nu1/CypuKYam8Xt10jh4l3Czfzis
 hd0IsCI+gcqcHoaDIsRc5cWB0ogorvmPmKXliy0ueEc8o+CAgDXp1MyeOUdCV5PO7a4t
 b1Mg7N66b0RHMExJtqrSPHmrK3iKxb5OHrhM+6Cp+0/GIS2mrjPoAfkBCw0fcecKNQCh
 wBRESA98aT1tZWUuFyiTchNtMEAy3dOayrgVck0aapz7+4UvfmpR7E9A1SAh7xLJRM1B
 veiLVfmq5AntlIXZKy/ETGdf8Ty66pboprgkfnmLDE9J0SNTepzL2cXz5F07HpVZg0dc
 80Mw==
X-Gm-Message-State: APuU4Z+tjaRZ4MsZKIQexGroTnkAdLAQ/7dBljTtrpDcF+ceDjupJ/ch
 pMJcE/0fwhZR4sFxJbZ/LD8B9e/PzphfBq3HKL2Rt7OBFBRXvpFLx3moAlbfOmySWG7qBqwkfeA
 Tj3lyWI0=
X-Gm-Gg: AYBFou38el5mm1WGsvoldezNW0U9Z1u/vsTgV4nuDTCRBXX6FQlCqOD/lW3pZs2VoPc
 a3sLloFZ4OkQI4FJs3SjL5Xdbwj6xwKEAmocEZtfypov6pz4TgEIQmh0xxMn7VHukGNw7xczWU+
 HZRYAAHYNObhgMmt0jAnldEtGg8g/fmYjyW3t49b0CZzxGLyvtTLNIzTLjvfGXri56tXPJ6YnQq
 xNv7mlywQinHaUpJQAHR0/OrgLGdcWfvTwSu9wD5uKEzxbCLAVSIQQpT8McsQx7CYpccSysPUSx
 WXZEVU6HMvB/nJYSuLjsv0SzNYBqFRt21abZZ+dx2DMniim7PcV2XZqiCxsWsxKPLErebYpkLS7
 zdkZeG6QSw000oFf6D10d64EZ0hD0/bM6zGcvG6oKIEdzf8sufkaoaRleShYBdngQcLaLUkiu6J
 YnQTtm89DjWpWbrWfmnFsysx9fbmlwDXzndoMjKUyAJEEuxV+E8GCHFe2/pDlWe92bYpQ7Ib2ul
 7tmfEcpIlBfRhK+fqzbzpFqB5lIm0YatHxBhrAAG+otSlaH02SmpEMSWdeTCnsGf2Sj54iN4H64
 UathG0FGafDQAFYGOI0tx3qqdZ+4eLuP/iXECIi1RQcfx51GNwkKgisvmENUSouYA+IB0v0pslx
 0KfYxAWQUwCpLBoblgkFNjfnsUMUQlXF/5w==
X-Received: by 2002:a05:600c:46d1:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4ac17b2c8a7mr301099705e9.25.1793716524619; 
 Tue, 03 Nov 2026 06:35:24 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 5/5] block/vmdk: Avoid overflowing multiplication in
 vmdk_open_vmdk4()
Date: Tue,  3 Nov 2026 14:35:16 +0000
Message-ID: <20261103143516.2182626-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In vmdk_open_vmdk4() we set the uint32_t l1_entry_sectors with:
    l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                        * le64_to_cpu(header.granularity);

We have checked that num_gtes_per_gt is at most 512, but the
header.granularity has not been checked at this point, and so the
multiply can overflow the 32-bit variable.  This overflow is harmless
beacuse we're about to call vmdk_add_extent(), which will fail if the
header.granularity (cluster_sectors) is more than 0x20_0000, but it's
a potential trap for the future if code that relies on the
l1_entry_sectors value gets added between where we set it and where
we make that check.

Check for overlarge granularity at the point of multiplication so
it's clear we can't overflow.

Cc: qemu-stable@nongnu.org
Reported-by: Tristan <https://gitlab.com/TristanInSec>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4029
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index d7e23ae8098..a9bd8a4245f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1052,7 +1052,10 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
         error_setg(errp, "L2 table size too big");
         return -EINVAL;
     }
-
+    if (le64_to_cpu(header.granularity) > 0x200000) {
+        error_setg(errp, "Invalid granularity, image may be corrupt");
+        return -EFBIG;
+    }
     l1_entry_sectors = le32_to_cpu(header.num_gtes_per_gt)
                         * le64_to_cpu(header.granularity);
     if (l1_entry_sectors == 0) {
-- 
2.43.0


