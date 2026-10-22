Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF35606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ECB//Jb4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJvHX-0000al-4k; Thu, 22 Oct 2026 12:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJvHN-0000Zw-0K
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:04:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJvHK-0003L0-Sk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:04:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so15828245e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792685069; x=1793289869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Nnu0hm4kGJFsI7Nj2ThtAJpHvK7Vb5XvPuwJZWLYBI=;
 b=ECB//Jb4iRz4qyaE5wDBiOY9Pmb2SHToqVHz3EFZX02reng4AZKU8J59lwGQXRMEpv
 RapS1x+sm2i7FC1PUUWU8yw25pz0Sypp8zKDCSX/cO77EQjpj76IX5tc6Gg4kRzCYTcs
 5uEBJa8ZGbs+Be0Z29Vz+qPwSIsjeSXbSQwxbWSAj61fo46eRLlLvsda213j0SofNu2r
 CI4uTq37t639j3AP5AppymaSpQFr5+It8EAgIRVMQFZnattxHHCrTpIRINafTV/sNNlZ
 BHokhlSnvjF0+jBh+9e/7ns+HRgWIEHFgqXWzu8MPc06QS+i7Hmt+iyIBOXyslCE3Det
 8ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792685069; x=1793289869;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Nnu0hm4kGJFsI7Nj2ThtAJpHvK7Vb5XvPuwJZWLYBI=;
 b=GV+yp9iuHQlVnS6l+86PE6CFCk/lEs+qS2TvCLvvwOarjKAGItxsGhSjBVa2jjP1UC
 IDAMMDDtUMBGq+5E1vl0oLEDZfBtwlnHwkouDEvvCDU4d83TYNLuVtdE7sgK6YO9VN8V
 kthS6DFzzrC5MpzCC7WEuRdVHN0+TvxSt8BYnPEm4HfwAvJZqIDvp0AZFch8yEui/krn
 JLrT3zUcRGcy5I1RCTRml9fzC023rrn6kMlInquNvhSFhQJy2/7DgToiLugM+m57tzAc
 dzMgsQ5sKwGWwaB6xIrcxyVqRjCfOyKni5xDsMu895SKx7qyFeVQK2zzo/blcMNvmkCa
 xGlA==
X-Gm-Message-State: AFq9FYKxq8TLmccfjhsgyUFUvkkbuczh01lb8aBcqoq3Phx65VDpSn4H
 NQ1QvpH6VGam/GllduId6tdBwdiIscIofhV+5GWxjThy0Z0yhfSiqMH6sWD8aeon8+Et6WyZogi
 9xX9BQ7E=
X-Gm-Gg: AYBFou0W45owZqOwBWF81IkRxNzo6k/352q2yG4KcEfYwKIjw2eMWXjfBikKqnBArqR
 gjnv+v+dBMzL5nWks+/uMA6Kz+GRe1Kp2oOqVWeZPPeHD5dFqOANopnKu8M5fV5O2KLd9lGjmO+
 9fAG7Ms4NH1Ft346GThWvc6aMekdr9K2qBlUhJMvWeW3ZPeu1aOB3l1u8lZH/ER726Mz1StF2Tv
 +romOGNVdCYs6zPXG3sHt+mdjAmM2qhz7jjPSUVtkPj2TxdiPjTtVSSlBJGVU8jyXbOdrokxLdD
 UwEoTOluBXPhCM/WkT8rh0ctw3pa5X0roq+ot4Jm+tW1FaqI7u+ZDzbDfpCNveoaJJb9NpZKI10
 WEsKYDqJFXiaLN4tvvKeM71DHqEuaP9Yz3fOXeoG4Le/j9647fesa22zle1xH1SknKRImU1vup2
 AtkQSluMIhO/1O3omzarIxmdHgR1IFo13iBIqObSFqkRNE8m0p8fXy/DXGJXeNgosMx0Ja9zopF
 tB91/oPFSAyg/C/w1rAblOCN6XkvvpwWLg10Qn7m2SPNg6+8QkF43PK9Pj+EaFhdKakdHdBw163
 lo0r7Wo+GzgLln8ANDsBK7W+/HP4h2gkmLKKt/+G0kDvV6JGNE+Qp2DxjMTq8BimisNLJVh2Cnf
 YjVxWFw==
X-Received: by 2002:a05:600c:4f91:b0:4a1:d675:b031 with SMTP id
 5b1f17b1804b1-4a1fdb1d82bmr122059135e9.6.1792685068873; 
 Thu, 22 Oct 2026 09:04:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a210304cfcsm5692665e9.10.2026.10.22.09.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:04:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] net/tap: Avoid "close(-1)" in net_init_tap() error path
Date: Thu, 22 Oct 2026 17:04:26 +0100
Message-ID: <20261022160426.451919-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Coverity point out (CID 1660042, 1660052) that some error-exit paths
in net_init_tap() reach the "close(fd)" at the 'fail' label when 'fd'
still has its initial value of -1.  This isn't a valid fd, so while
close(-1) will fail and we are ignoring its return value anyway, we
should avoid it.  (Compare net_free_fds() which has "don't close -1"
logic in it.)

Resolves: Coverity CID 1660042, 1660052
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index d71e3dd1175..ea0ad084819 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -1245,7 +1245,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
     return 0;
 
 fail:
-    close(fd);
+    if (fd != -1) {
+        close(fd);
+    }
     net_free_fds(fds, queues);
     net_free_fds(vhost_fds, queues);
     return -1;
-- 
2.43.0


