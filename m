Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568BFD3B996
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yg-0001E0-Nh; Tue, 09 Dec 2025 15:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yf-0001DT-8S
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:29 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yd-0001K4-Pq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:28 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so57595435e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310786; x=1765915586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bib5KwWT8F3I0Wt/g5NCURFK5YXFN/pQovwLilFRpf8=;
 b=PwU77H4SZlWpzSSk1FftlhcASJnntjXzufSFOpf6IqaXOc+JFqbqRujQropt/71Z5l
 wQrDjN9hUlZA7DC8EhVahhYu2s5x1kGfAaDRxlV6nFTBcFWsVMtV0ehe5rpC3iE0Q02W
 QJO5zQqkIKeYjxFKIBdZo7Clxpzt5qL1wDkpkHvwcQ6O0RQ9rcHhWxv25kaBJ8QM2QaA
 oyxwpj5skHwarKNVTBbJyNM2F2sdcStZEWCt8vJcZ6DHSeCShjVwaL9TCZY9XWc7y3nx
 jTKGIqr2Yfzqjf3o09NxfQA7bHuLx/V/HTo75UviaUF13A78o5zd3ryNHRqTFWzufjAL
 /cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310786; x=1765915586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bib5KwWT8F3I0Wt/g5NCURFK5YXFN/pQovwLilFRpf8=;
 b=TWm/SdAfixFJ6ZnFoSsD4sBAbIaoQxvRWGvRDjmR9TPDB6hH7ELhpOxzKZVL6o41dd
 MH/ZpDvRSqhmwEI4wW4BJ1EDZq5YmB4DlcDqJaQz/OvcgF9pW03iDq2DsGGWlK02sWBR
 Yd5Rgi8FkAojczL04zgTL2SHl4l7sPANULGhxu/iL5xgLP6GfJ0okHi0pkWWYmPIoNy+
 fYOQCZ8C8bqkvt6VUF0Ost8CRDOiulu49fL7vnD/ywLvQLHrEffJXwW94pKoA6E2OGds
 94+c4bAZHWpPjfazjH5aaQQ2mKFBDB3rvfkMGB8qrdq+SSIxPqJz0FsqWSNd0v0rmgHB
 t2ZA==
X-Gm-Message-State: AOJu0Yy4EtrJz+xOK5f0GqAQnbCRDZTO4Re3IA8p/3epene/Z60N2eyk
 e8CKFn97H+gUfKp9gB9FPMx8PXM2JeZZ/3gha86DeKyCOaIyO5GKhJ184fupLq1tTk8iFJRQQSd
 3TWoM2TU=
X-Gm-Gg: ASbGnct0rsWH+KduNfdhtXusy+CBnsNgXYJnt4OsY6+8fjlFTD2cInRXBE8gLcCdfu/
 gg67iJwbLImu6V29dqwK+nO/ykwyFowIColxGc0w5poJSzEjfBKy7+TTTsLDhsvkbAUiD2u4n/6
 mbC+xtmC5ReruGDLNnUeMwh+OltNw7vBT6j0ZnI0lXvcztdsYmbEJbFkDBAe+ZPOoYgAIJfeehE
 WNfqOYdtxU0cwYnFrr/sedY/gwEMpic9EVGugi7fs2MI2aEwXjc4ueLiwCFR5Phei8YkTq8cO3r
 SRvQAxSalDctaW7LnmR+mPRoiozkb3q2fXh4nyZvPh3sVWn3XCwdM454Jn1M3Fwb7ey3V3ejlGV
 UdK/WINGzlXo+RmPkwYSanWARBBeKF8YbVHFCmCfi/oEH49AuTqUwv/Ls/M7wWewEHc8uXdH95a
 xQyBatutFr78C+H+tRypiv/xgqBTVm0fMdlnq9BIPKaKb44+ao1vvkCVA+gtBc
X-Google-Smtp-Source: AGHT+IG+VXCUrJICQgvkIL6QM3rdWG++EG27y9R1vLXzu4Gvwg+g+JraiNgnrkPfqpJXR84luMb7Hg==
X-Received: by 2002:a05:600c:1c93:b0:471:d2f:7987 with SMTP id
 5b1f17b1804b1-47a837b9a4cmr757985e9.26.1765310786005; 
 Tue, 09 Dec 2025 12:06:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee5bsm33334148f8f.16.2025.12.09.12.06.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] scripts/nsis.py: Tell makensis that WoA is 64 bit
Date: Tue,  9 Dec 2025 21:05:34 +0100
Message-ID: <20251209200537.84097-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Stefan Weil <sw@weilnetz.de>

This fixes some settings like the default installation path
for the QEMU installation on Windows on ARM (WoA).

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209130212.764443-1-sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 scripts/nsis.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index 8f469634eb7..33069f4a86e 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -114,7 +114,7 @@ def main():
             "-DSRCDIR=" + args.srcdir,
             "-DBINDIR=" + destdir + prefix,
         ]
-        if args.cpu == "x86_64":
+        if args.cpu == "aarch64" or args.cpu == "x86_64":
             makensis += ["-DW64"]
         makensis += ["-DDLLDIR=" + dlldir]
 
-- 
2.51.0


