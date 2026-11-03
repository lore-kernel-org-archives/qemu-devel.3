Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C91606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cr+aDYVg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbw-0001yx-IK; Tue, 03 Nov 2026 09:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbi-0001uA-Kr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:28 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbe-0005AG-OY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so32275965e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716518; x=1794321318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hDVAb+F8hSA0YezNkHEKdOgDDSffcRZHSUc8G4KrWjQ=;
 b=Cr+aDYVgRLvmWki1kgeRVI6nZmTkGNQAbSr7GFwEzCiGHMeVrjwrSMq3CseVukY7yY
 fClYIwp5Ud71+sDYleemA7iaCfdK06Y84eD9CYO75Hv91gsUDSrgurt6gHeGwrQ3+HRd
 reRlyTG3vIT28PCXDhEMdqpa+ChMg4qcUwW/O/xhY+v01MrGZJsQzDEKYqBww9WPYdGj
 qCWR9fe5Zg/8NwXs1LQAesnj4CdJiVG1640raAQfFHegPyeu8qsTqChu/xDUK7upZ0I8
 l6Sr5kaasNRDlBwkXPQsxF+dMFtOl+CxNl/KARlOUOeni1VzUGKDqPryu6aq0/vz5nBf
 JQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716518; x=1794321318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hDVAb+F8hSA0YezNkHEKdOgDDSffcRZHSUc8G4KrWjQ=;
 b=q+LEpmYCBoIQB7Zsqi6KmlrxURIx7Ou9pM1pRy3o09EkjMOxi8c2kacwI5A7x4+3qh
 Xghc3Ll+tTGZAbRuQJtV5XSrTRu9QekL6gtuAUzP/X4PVdYcYq/c9uwuZOZ5+VJvcN6T
 dwkxOkEgD5SVQqnCPP7V71CVTNZLCI0N9SAdp0VvqKA+QUCb4zqEyQVaMyQJ/fI+xunC
 XSD5l3kTBgsh3WBWCP4kOJVtR/yyxHf9/xTUKmpcULSLT+TVzXj5HwBI4s6Fb4SZ0HDO
 Wjf13GOqRA2XKYVByn1/HCRW6BD4TUAgCOcY3b86gWXNjvXb/LQ4HnTx9nkkhE4ubDJ6
 4pIw==
X-Gm-Message-State: APuU4Z+uIIqwRosKVI24pCigwIvSneD3yqiSsn6NQkzMZcliys8lQAIG
 4oAUXByYZ2RgqLtbvWGzA9WnuzZQIHBvfJfj4kWogmRH1idj+Qp2bCa/MgNAI8qWeK+EdHjrRKY
 EpZFGo2M=
X-Gm-Gg: AYBFou3aUtskTXW6sKT4Fu8XR8oV3cUQA+rrggiHdBtfTcu9WRSRZ7+e+Lgxbcx8RqP
 0RQCh1Cb5S96SUFGBNZNX+RAMCDcs5R4s13er0EqPRT1UoB540AEPrbVPg3tr3lrb9KzJYmvRoV
 b3Kmz+RKHORUvSTZYtUGVdGunVnhiVJtOmM+aJeSA32Z855pLlphIyhLsGJpL6gk/JPXiCcA1PE
 WuarZmkSsMq4Sd4WLMv/+Fm3viXYJNu+1gETZMeHrzdOAphngjCfyQD3POihMPyp4R74xAZfxej
 GWBiPCqf30w6Wg6Pabm2pMl1m5uifHJoKJYNa+NVwP2Rhj7pwoEG39xU5H/LVDfPPyC43JB2q8N
 Dizflh2IpeUNav7XlHp4bxrYBZDfZaLaCXT79p8WJbdPTx2cSpcMZY2D6kAdK/To4QCU/sCJFKG
 2KyVt5XKslruZuLncX1p+ZMMBvtiamdChOM/9GYNH2XyllMjmvlvi7N08VbfeY0VTCHSTpFVVFB
 kcM864hRhxUbq696kpFgxl7mUXJkOia9jN0R30wyKlJiFQ5uX3nLVVnLAugBpwRKnCY+9Sx7c7n
 1KBWqQEDdJrivcurWioqPphzlJoIs/iv8dbAbu2tdNxf+vP1ssfvp6AvvvjwEa9WSC55qosN3yh
 Tx3c0LRRQKlXXP4Kd9La1VEbclgujGHH/wg==
X-Received: by 2002:a05:600c:8b04:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4ac150b2044mr299201455e9.2.1793716518497; 
 Tue, 03 Nov 2026 06:35:18 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/5] block/vmdk: Fix various bugs in handling malicious image
 files
Date: Tue,  3 Nov 2026 14:35:11 +0000
Message-ID: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This set of patches fixes four reported bugs in vmdk's handling of
potentially malicious image files:

 #3843: if cluster_sectors is 0x200000 we can overflow an 'int' and try
        to g_malloc() 0xffffffff80000000
 #4017: if cluster_sectors is 0 we will divide by zero and SIGFPE
 #4029: we can overflow a 32*64 multiply; we catch it a bit later on
        so there are no ill-effects, but for robustness it's better to
        check before the multiply
 #4571: we can read off the end of a block of memory when trying to
        parse descriptors; worst case is that we read some junk from
        the heap into BlockDriverState::auto_backing_file and
        ::backing_file. I don't think this is an exploitable info
        leak into the guest.
 #4571: if the input file specifies no extents, we hit an assert
        in vmdk_co_get_info() rather than rejecting the file
        (mentioned in passing in the same issue as previous bug)

I think these all classify as "hardening bugs" rather than security
issues, since they're just "self-denial-of-service" at worst.

Tested using qemu-iotests on the vmdk format.

thanks
-- PMM

Peter Maydell (5):
  block/vmdk: Avoid assertion if image file has no extents
  block/vmdk: Avoid reading off the end of descriptor memory
  block/vmdk: Use larger types for byte counts in vmdk_read_extent()
  block/vmdk: Reject a zero cluster_sectors parameter
  block/vmdk: Avoid overflowing multiplication in vmdk_open_vmdk4()

 block/vmdk.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.43.0


