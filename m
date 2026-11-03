Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E014606A32D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Rvk/dK6Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOFbo-0001wU-5u; Tue, 03 Nov 2026 09:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbi-0001u8-Ki
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOFbe-0005Ab-OK
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 09:35:25 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so38330125e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 06:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793716520; x=1794321320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f6lYnEZkfeXPmDIW2q8UWkm4NDsYNQ04FJzjn+wn/Uw=;
 b=Rvk/dK6ZesWek8ErDBIFEy6fpG/XAow3fxqbsNwfRV0fzZb+ks+GHbtfbHcCP3Ype+
 HnwsqobyH0dxXktv+rW+TKeuX96NmxMyA7tax+3maji2Uz2YPx6SpUnapay83FYar/fn
 dtC4xMNe4++YkzHAJhsPZ3sqANshu+GMq33ehtRJuPuTtGmitDaV9+KK2A0J4bP3NTl8
 cNYzt/k+ydsYdVFzWCR2AhPyYJN4Ejg/uHHlflUxLgfaBdByGjlMmmh67FGeK8c681av
 xzdXHFVUlgEwZCDadWQ8u4vl+mxchrl8P65Pu8WJs0ETz6v9T/EBXwhmh8a71uLlG26p
 NV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793716520; x=1794321320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f6lYnEZkfeXPmDIW2q8UWkm4NDsYNQ04FJzjn+wn/Uw=;
 b=GwbS8OYWv90nT1GGPulnADMCS5RWteqq4Gz3twH2FOQq/HBzzkA9YR/KxygdwFH+VL
 6ZTrKHlKUFuKEBviFxUojSzUrtNsyXSxWN/yqsUIeE2szu8MBqDtSFVlSVDrLkb/c8xg
 sglSXbjVBtEK0FabRD6hZ9eub0ugZTHgnFUjzVJwr4CdcM+izJoZhRdS5/19rOMbiqdp
 O1pPH5rZXrUrJ1ACY0SF5OKjaTYyPJ2muttB00XVZ8zYvJtA1pK1xcjMpADbHQHz9C+e
 BzbVvM+6V5A4IfP6TZyZxkErvliaZwsad9Uw8xZfyFoS8LPi8Rq4Son/KdL/n7GnGKfq
 ChIg==
X-Gm-Message-State: APuU4Z8ywg7ehsNponKSGwYQtdOUVz6I0kB7oz5Ghd+7M5HTm2xxfW3G
 6t7WRWHyY2X+XNZHLJeMJelZf3aAlmkzzCJoJsvsi+V29HlelueUbIWxUjV1uocUdByuR7HfHxJ
 PUp+gyRY=
X-Gm-Gg: AYBFou3qosv7Kayn33VzrQo3movjzBYB6FQryV1od6tNxSeIk3YYT8SmHEOdQ7voyne
 0BsFE/PI2u3MNrBd9D/1ipr2RfHklcpuYvGevQ/G/lG+8Zp/Vs6MF6u+tEMnHNMpDEkXYSyXCVk
 6TTTSGsXQ38l85iEnLhCJJrqO6wUYc9Yz35xN8jNoZ/yavzR/+ZrCNQGLdKDH/pZYfEQjXQAtUC
 B3EPaBhFrtoZaKSY/JHMWlsbJ1IoVlFUhDqRHQK3R3nthLEu+GotCD5Ult3DzHQDHh0HwiWWaww
 hYOII/WB6ZTP1hoZkxrcBoFXxgsbk3r/D8e1Dh3IJJBWFjOK7x9/Q2pMDTDoSfrHc4kJrwiP7dw
 bTmfhThR8PpXsLhL/t4mV8u79t7qZwm8grREVlUACXsHo0V9T0x9JMfGG8/ymITOrl33Wf0tuif
 qgKa87b0OFoGCKqjCTUZDFcuCvfMCUfE9VBgHFq7tVGyvg+PnsGvA0gyiiwe5Bd4py9zHvoO21w
 CIFHk+0P5e2akOIWf9xATn8vSEiTwPkt7lC0cA/24FU9lxQLEe+BvEasC+bMHqmdayqF16yLOLa
 l0unHa0Cl+l21QzfrE33V9WJzm2qXkRkOBC34GazOXFruvdi1mFJLW83/0o8fla9YpQxBh6fkLe
 5rLlMbDGaVmYfx/tFFNznh+mYWz/WIFcx7g==
X-Received: by 2002:a05:600c:1d1c:b0:49f:fe39:5bc8 with SMTP id
 5b1f17b1804b1-4ac1709a1f5mr314355065e9.12.1793716519840; 
 Tue, 03 Nov 2026 06:35:19 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa953d35sm61100965e9.9.2026.11.03.06.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 06:35:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/5] block/vmdk: Avoid assertion if image file has no extents
Date: Tue,  3 Nov 2026 14:35:12 +0000
Message-ID: <20261103143516.2182626-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103143516.2182626-1-peter.maydell@linaro.org>
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

On a malformed image file which has no extents in it, we will open the file
but then fall over on an assertion in vmdk_co_get_info():

    $ cat bad.vmdk
    # Disk DescriptorFile
    version=1
    CID=fffffffe
    parentCID=ffffffff
    createType="vmfs"

    $ qemu-img info -f vmdk /tmp/zz9
    qemu-img: ../../block/vmdk.c:3104: int vmdk_co_get_info(BlockDriverState *, BlockDriverInfo *): Assertion `s->num_extents' failed.
    Aborted (core dumped)

(This was noted in passing in the report of #4571.)

Cc: qemu-stable@nongnu.org
Fixes: 7fa60fa3778f1c7336 ("VMDK: open/read/write for monolithicFlat image")
Reported-by: router0mail <https://gitlab.com/router0mail>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/vmdk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index b6e78a2b5d9..86059e1fa08 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1301,6 +1301,12 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
         extent->type = g_strdup(type);
     }
 
+    if (s->num_extents == 0) {
+        error_setg(errp, "Invalid file: no extent lines present");
+        ret = -EINVAL;
+        goto out;
+    }
+
     ret = 0;
     goto out;
 
-- 
2.43.0


