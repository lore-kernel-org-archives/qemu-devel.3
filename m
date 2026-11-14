Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D1606A327
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ST9KWuOd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSGWJ-0006pT-Bn; Sat, 14 Nov 2026 11:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xSGVq-0006L8-Af
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 11:22:00 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xSGVl-0005nJ-3G
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 11:21:58 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c50715c2757so274952566b.3
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794673310; x=1795278110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y7au+X092XB7IsLEe00STCm8ZOBiNjpaalo6Rd4yKKc=;
 b=ST9KWuOd93dOTPM10fycKGir1bhVLZDHe+7zkr9Gy7RmIZ0plZ5hhbxmjagD3i5e7g
 YkdDBpk5JHVXt9/5/AHaVowZDTmggDWclZzf06XiQLcX34KEBNjIi8RiSPyvJ53RjQlT
 qI5vca3YOfAjP9AtH6NdeDk0DU1z+WFgl4SOHfgbo/T8FJl1zXbCXDPNagEYHVXFBnNn
 hGF3kOXd6GHxgMWXN+Kycr2O+kAJwa+ZWTXBx+2yYizIWQk2+VRsAa9y22qqG0FjQ0yJ
 6jAOw2XZQHk3kxXSeYQcOOxvKLAETgC7f6YVFS+pHHkxPFvOtk4YdU9X/47VBtATQuFW
 0Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794673310; x=1795278110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y7au+X092XB7IsLEe00STCm8ZOBiNjpaalo6Rd4yKKc=;
 b=utHZJ/Yx05kDgGX93OYC83qfjypBg3rrdjnicLnT0/ruOGjnhmNEsi0FIrvGs8+rZI
 ecgVIdJYAypdrDAW8rJtFx23GDcMgagwu6mFLFq4fpbuYAnV3fYjifH9QEbPQAYrZMsb
 a6QJB+7qRQKZ/dVOGPR+LzrYwG6cYH/2zkriNw1CgtRySWkfQ7rhmRcpuBKh+lWN2OLw
 6YYawsz6qXjIdZdYPKfo7je2CLTfinTtlp2BEGYRPOa9Ifd+PyXBTFpT+PBm/bSBOHfY
 ULZ9rnwajisk3fkJmaKXYRq9TVUzXJj5Aa7u80R5z7AXPmVvGQnkeiqBwNTgqRbiSzC5
 NeZg==
X-Gm-Message-State: APuU4Z/3tJsY49w+Fb8Y43METVj2v6H+uUSGBFu6nXrc7A2baI4xhkzB
 w77ZTuWKAvhzAA4SUH1KjY9HZJYqlYGXDQJhbPM9b3b3PLXGd97TI9iUZEJsPw==
X-Gm-Gg: AYBFou2Y+zk/geInOs2Mq6sy2pLNZywj6W4n0lL7t4yFim/5c/xQ2NSqnLTHbPNeaav
 N4JHKTT8FI6yCrhi6VZG2BL3PCmpYJOEcgCOnMEYH8jTe7PKeYvXYMjZmmzYR/0TavRwtNBBlWz
 TMBJZADRaSFfCPA7RPvktPqxiDWa2qhCcLCjYkvhVpxXbRr3eM/PpfkaMOfMVeh0+klg3oaFCS8
 U/tEhF6U5A79vRtFzEKbhmNFv8RQ+jtBOalCwFa/xXO4vkGHFFdLWoid/WzH6ubMbQ+q7DAARia
 ZSn6GvOE6rxTo00kouD4JfoFlZrigh/LdmsYaM0yLiO7ICwVU5STF2lPvSc2GQSL91h9ID1aJOV
 dGeiD5EW1q09utTLed6RFdPO9vxx9BfGPVcfl11qfraoU1hILjE7y4xhIeDLbkE71BxGLE7igVX
 q5y3wQKDd9FsrHgz04CxdaiONtWLfPWNfIFhrK2hzFATwZkbLg3MI5wxUStgwQxHuWVCzNgXhrv
 6eVJT5gNdigCFIkIddUTUXnFszqimmxIh1fL+SXW7/h/qaVBJcjE+R5S9v1CKglKhr6hBVvuVMX
 FxEUaOIMak7SoyyveouwCU4/h4RTfW/gUfUh8mSrEFmYq5e1pPDF00Pog3QqGtsa9Mqxa2beM6E
 PCfjCEQiVKE/BQB2h
X-Received: by 2002:a17:907:3e9d:b0:c33:ca5e:8ddb with SMTP id
 a640c23a62f3a-c5096396e4fmr471688666b.28.1794673309508; 
 Sat, 14 Nov 2026 08:21:49 -0800 (PST)
Received: from vmbox.lan (088156177242.warszawa.vectranet.pl. [88.156.177.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b7e5cfsm229561866b.76.2026.11.14.08.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:21:48 -0800 (PST)
From: Dmitry Pimenov <sun4qemu@gmail.com>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@oss.qualcomm.com, atar4qemu@gmail.com,
 mark.cave-ayland@ilande.co.uk, Dmitry Pimenov <sun4qemu@gmail.com>
Subject: [PATCH] docs/system/target-sparc64: mention sun4v-qemu-kit
Date: Sat, 14 Nov 2026 17:20:04 +0100
Message-ID: <20261114162002.1995864-3-sun4qemu@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=sun4qemu@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch adds the reference to sun4v-qemu-kit; it builds the set
of firmware (hypervisor, OpenBoot and binary set of machine descriptions)
for the Niagara machine based on the OpenSPARC source code archive
with some changes and build tests. The kit can be used instead of
S10image/ firmware.

Signed-off-by: Dmitry Pimenov <sun4qemu@gmail.com>
---

Artyom, Mark, please look at this project.

 docs/system/target-sparc64.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.rst
index 97e334b930..24d5883cf5 100644
--- a/docs/system/target-sparc64.rst
+++ b/docs/system/target-sparc64.rst
@@ -20,6 +20,10 @@ and is able to boot the disk.s10hw2 Solaris image.
                        -nographic -m 256 \
                        -drive if=pflash,readonly=on,file=/S10image/disk.s10hw2
 
+Alternatively, sun4v-qemu-kit https://github.com/unix0cc/sun4v-qemu-kit contains
+a set of components (hypervisor, OpenBoot and machine descriptions) for building
+the Niagara firmware based on the OpenSPARC code.
+
 QEMU emulates the following peripherals:
 
 -  UltraSparc IIi APB PCI Bridge
-- 
2.43.0


