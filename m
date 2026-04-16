Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34113F8A145
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrt-0006um-Ko; Thu, 16 Apr 2026 05:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqd-0005HI-SY
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqc-0007oW-E3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso93512455e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331037; x=1776935837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PCYokkt0aSvpHyLD8QwsAML5mgur37GtKavtfspbgps=;
 b=j6JDiCx98aw7pPi5ECyhNc0Ah8SxuD1NKgXwBOGqMOasOHi0KCtLV7fqpsQF7k+0WB
 WlmjCJx05y34a8xy2uVXehToxiS8JkVMzc1+wpnSt0x26dbo1EqLQFSKM6YrzmJY4TuL
 FP+Utmb2zaT4VNvqaHGO3MJF9SPhj8u5s/5drAKT5xazeKiDBweKwf0q6dp4hTW/yfMg
 l6V+iDm+5Zy65WzqPS0l+mEst43KB2XBFcSwY7VeTGe/0rajFewnY2WtAZvZLJBXtJ8k
 g5DAGMtNoX+rNzbeQUsWg28QUxmq0koN82YVN4Ebr2APDKpMX6JP+tntmcdMXAmMWvSl
 Y+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331037; x=1776935837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PCYokkt0aSvpHyLD8QwsAML5mgur37GtKavtfspbgps=;
 b=aKPz8DXt41Jpo1PQfnCymMC9QC3A862MGInvIBPaB4JH9hQ+Zu2k0LHhzkYkdVK5XM
 PcLPw9WsrNmT+BHGhHSxtrFsExgsHHeRZ1zIRUmb9BQvdRM5Nk6JZ8EJqm/oI1PWnKyY
 ifRgOzEKSwjyBWJ2gjZC7doMJxpPp1XrrWAn5Lkc4xax3JFFlUIbS6C3pzYrb2djwp5M
 7qup6WOnIQZqdeqRwSkowC9cYEy+2wXJk4qqNz4po+vlIGHMpX/9IeFfV+sVE/qdwhN7
 ETwY2D5I0Rd+87XmbIKfu6fOUHBrDx1S6/oyYF50LauL3hogjHvvzMuFcUzR95jIOjJV
 8F/g==
X-Gm-Message-State: AOJu0YwMG5OKZ/SKWKLnsKPnudaVr2bVrNyGDDa5UJHDPsGIFuJIvX1B
 kkb2jOveyGIrw3xMG09dtt0zxImLkQMA94+QS7proPd6OmxcGWEecmlctdNWBpjhnQLdm22Li12
 BPnsVeq0=
X-Gm-Gg: AeBDies7WBdhPoSCP9BEq3IvfQTGsr0H2j4u/zMow5LpoufEWbhRDCXJq8JC1jb1kS5
 e2t5wx/hYb7IBP995TbsBX/TuIypNtVL/Drx3GN7mSuQ1OwnVScGip6JriWqmUFOgEQKeUQo6VX
 z7oUjjxcBYkDjRt7kjkXY91mxnm1EHXIbXQo5RGgocDq6CaQi+VlwlCLPg9x+TYR8bNQCxDyQSm
 qOxPWy2kmFUHEGlqznpXzYoBvSKs7rKjvRkJZ7wmXHhQNthqhiXtnAkPDIMMTNs0AsaEkNCR3iV
 upOA69TRJICkKU1JkuWxhK9RjaRkJa9yryVVR0cmzjzDvM+ITCVPEwFMCf7dZkj7dbVmbdGobm8
 0VkeO/Zz09dOXL+AA8zhLQ6IzxUbRl/1NGWo+n5QXAU2eYjE1njbmA4P1ARo2TqQk97zqjRnJff
 i6Wgv23liZr8k9GUbRuO1hXJdUQq5CWp7lIQo27BCfyKRg0ldYvCRn6vZaBYhwOS/nrOONIS3Zh
 bKUhj5zgqYO60My9GFH1JCogi4EW0QrnFfQV8wqRg==
X-Received: by 2002:a05:600c:5303:b0:488:b196:d249 with SMTP id
 5b1f17b1804b1-488d67bf74fmr336320555e9.5.1776331036720; 
 Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/28] MAINTAINERS: Remove Ronnie Sahlberg
Date: Thu, 16 Apr 2026 10:16:46 +0100
Message-ID: <20260416091654.316158-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Ronnie Sahlberg has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 375e3e111c..7fac11b3f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4180,7 +4180,6 @@ S: Maintained
 F: block/blkio.c
 
 iSCSI
-M: Ronnie Sahlberg <ronniesahlberg@gmail.com>
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Lieven <pl@dlhnet.de>
 L: qemu-block@nongnu.org
-- 
2.43.0


