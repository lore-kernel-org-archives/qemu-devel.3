Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32E60A2617
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nb0b6sbr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUum-0004gN-OB; Fri, 20 Nov 2026 15:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrZ-0001It-Tm
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrR-0001v6-6i
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so14555855e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205127; x=1795809927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PIe6ou7eDh3j24I9zndpQ8TZCmYl8i9whubcYxJ0DUI=;
 b=nb0b6sbrq8o0m1AmofASorjIBCtOdmLGFbuEhSwm4gCzKatQPV+UUgKnaV7YZfDEou
 kfdq0D8tDp8ewGPGupJN21i6TyAMMEIAxbul+k/3IRm4d7yfhdlaRd0GtCwpa1sf4GEg
 fi9KHccdK/UAPsioEGGVvJydEHAFUr/hfnavtofB40gchs/NdpiUhgEuNKDE0kn7WK0T
 YpvS3oMYiqNKZrQNcomdYkWBTdck6DaVVVnpeBj35WlkKsMWhc86sDj4c8FUfL6YY+fP
 gvmi3vuBWMkWiMPvrxh08MmWajdni+E15H+ws+O278dtIHUERlygS0rktuxWctPGtnri
 1peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205127; x=1795809927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PIe6ou7eDh3j24I9zndpQ8TZCmYl8i9whubcYxJ0DUI=;
 b=X6SUWahNkSzYllSozrUft8clPkFsARKfuSjCUhihMJSeP6ihuHguK20iXrA84CvXJM
 j1f0/JY4qt+1mSZDqY0pHsgMPb1dBLfJb7mKlixWgZBuTEdN0HBHNn7TXaXGn9pC3YbX
 2/tSJgWiJpzC1mJE5u7sLW4Y3ziatpUHOabP4jC32oNuUXjVtGbZDkijiPjWm5jAvRZW
 qo+2zX4hRBA6rIvSmVUgN//81VQoRCsiZCzRC/smywSazhASWVFh9u64VMprYs4wYjVR
 fyleV0vv13KaoQhzg1TD4A/7dJXfmFJt2raL/hB2NtgV0FOTFZpnHp2ehCLKvnJbbOcm
 uddQ==
X-Gm-Message-State: APuU4Z8u52fsBr+5uT0V/NnJLH9sJvOM8mPkh2px63vN1O7NOB9wt2zG
 zAOm6t32mXMiCt4amkz5PGu+lmKpC4D2XRlWMMWtyAjXCymHngI5hQejJYJzMImPznE=
X-Gm-Gg: AYBFou0rdWOw8NXiK25uxOPUVTYQ7wQTKM/bOsqphY4HEjfgkTKdNImnOLvQyJOSCSN
 34FVuIdz3p/2yMEynA2wz1i1f1EjnseA5mnOUiY7wd2DOOrc64XX1yxziutxcyLiqgI3Qmv/BlL
 jq764sy8eBFdDO+3iIJ+SYTrSq4TlIFcviT3p0qN9OGG2St7xRAaDB8exPlmIr3HbjcuiYYP9wb
 ozW5LEfiYyWHMXQMVLtrXhrsyOkGyam2Wf+ZV4xVJvYNqtojXtmvLOao8SHDjVUco7HBOcWkDoT
 ABmNegoNT8njjQA78XBdRvptUErijBVy0Byamz8k9s7ApOw2c5dTDV17INOsCZ2EBwIpmCzi5EL
 CUN1Hwl+KO+/GT1R2waUbtx4wE7+89NMQXMmyEie/JXczESC3uUAk/KbgyM9V1anN3SI3Bqk4Te
 5NKSux5CRDc6bpeZ/JtlalyMEh4a4v+mEH8X7FxkHV1v4qywFs3Y8Q6msvVWjd//Pm0TCmpdrm1
 xJ82wlrqZvIKEzIajLRs7U/o45NphN3cGJkF7wgM6aFqsNI/h5F8Nzos/42Mm5aWW4VDvaBBYr7
 qKQCBUyM1G1OlGLVUQ/CAX3D0yTFfeMQQgxAeCTOxFsycFMV0g==
X-Received: by 2002:a05:600c:64c9:b0:4bb:679a:86ee with SMTP id
 5b1f17b1804b1-4bb88938dbemr100575625e9.29.1795205126032; 
 Fri, 20 Nov 2026 12:05:26 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm115195185e9.3.2026.11.20.12.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 50F715F7FE;
 Fri, 20 Nov 2026 20:05:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, "Collin L. Walling" <walling@linux.ibm.com>
Subject: [PATCH 19/22] MAINTAINERS: make Collin's entries consistent with
 .mailmap
Date: Fri, 20 Nov 2026 20:05:07 +0000
Message-ID: <20261120200511.822573-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120200511.822573-1-alex.bennee@linaro.org>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We should use the same form everywhere to keep the scripts happy.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Collin L. Walling <walling@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 031183706a5..c5d0b07aad3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3140,7 +3140,7 @@ F: include/hw/timer/mips_gictimer.h
 S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
-R: Collin Walling <walling@linux.ibm.com>
+R: Collin L. Walling <walling@linux.ibm.com>
 S: Odd Fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
@@ -3150,7 +3150,7 @@ L: qemu-s390x@nongnu.org
 S390 diag 288 watchdog
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
-R: Collin Walling <walling@linux.ibm.com>
+R: Collin L. Walling <walling@linux.ibm.com>
 S: Supported
 F: hw/watchdog/wdt_diag288.c
 F: include/hw/watchdog/wdt_diag288.h
-- 
2.47.3


