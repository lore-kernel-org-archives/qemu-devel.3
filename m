Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD37AC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgnWO-0004yi-6j; Mon, 06 Jul 2026 13:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnWI-0004xw-6H
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:17 -0400
Received: from mail-wm2-x01.google.com ([2a00:1450:4864:31::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgnWF-0008BF-EG
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 13:54:13 -0400
Received: by mail-wm2-x01.google.com with SMTP id
 5b1f17b1804b1-492367e8e15so2904115e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 10:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783360449; x=1783965249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4OIK9WKKZKKZfelXewT5MvGZeOSsUrYOpZM3HF+Zsx8=;
 b=UnvT6JejLLJ+JNZATQB/qd9mPbXofbSVcuplFy6XYp4574X6l22HdwomRmQpyDctvG
 RxdCT1VMDZXT58qiTpWYdElOEBG8scCGJ6JY+qxy1J9jmM+AWul2Q932DOYZYFznhv9A
 nx92Lv6jq9S3e3SKf/hst4rvdbIZ2MX5u9+kM/vMqV2d5bUBPi2t7uvenqM6qj8y685W
 59kf/pkIMe2MixNihuSuwxOYWfjVQMbroxi8O3sREiOTiMhdCxdkgJNizFw/grCtpVFZ
 sSt6RADDnfAMnuw1lZzhdjwOm+H+MoyHt4QXlDiuMYy2GpBgM0NL2JDpk6HNfC8H18GY
 O2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783360449; x=1783965249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4OIK9WKKZKKZfelXewT5MvGZeOSsUrYOpZM3HF+Zsx8=;
 b=fdks3swpn0+fvvUeqUol+hickYIUc1ArLAtY75ttCi10GPS/9WinPJQV6Ss4ANSuFU
 u1Ef2lj5s2LyK64YibI38/s1Z1sYdNIL2TRf50/vNqkA/+KFHprGwShRuv3E7JXFdkAG
 EBTdqdvdZFfWkt6OV50ETSJJdXlQPzrTb1hXujXXoMaH3MFknU5CQWgtLA2JcAFvDyro
 b9upyTGL8XivgPgnUXbJzI0tNKpLtCmyrFL0nas0DiALGo0pjp3rUp+F/tAtvHjzuP80
 Ee2goAc/YPFjUcwvzaXzhUjAm7THy03yfxXloopjL+cRGucwaWVvFl4vqVubecoDP4C6
 ky4A==
X-Gm-Message-State: AOJu0Ywt6XQChUgPtz2i8DMD+YbQ9EepAOf0IoGvTNAxC29Hpp3unNSL
 A4J1QbDGwGngB21r4+mPyd0Jhi4hLDlw4XxLrfJaIr9wSQZXWhk0OWV5+loR7YcDkwAZFrorYg4
 UtRZF6X6L4bq0
X-Gm-Gg: AfdE7cmc1LatZyX2WlsOBDN6SBrdGlcvIaAVpr14/iOepx8ZbqfltutBYds6wtc33wz
 DHOACEzkdZjjZ253gZPc+hv3WsLOb3bPgngUFpdbd0aXg4Vlq81ImClm7Yb9U8ghmU8aEpAp6aH
 12bCoXZ32sv7dqWftNsi617kzBli19a1QqMPdzZhWcXRvbj/6oWmQJuFxZUU49wXqT0Grg1cvr0
 ITqI/wvX4liE5tnym4cSi0Vlj1inFHvOKnRlKO8t0Fgt4KGNhBdXT9Wiq+rEEp8CyS58zUclX3x
 eNWCNIX9FP1Xxb9eh4xCeckynw7Y6fED1qzcKkxU5eJhOzOXVTUjLi5hDKWpW8Ayha7/IPWi1Js
 uE8yTY7H0mOvPC94LdWX7heVCJcggB4YRecZk3vOLAYX04V6iM7Et5vbKWMZ4wE0jz777qYyz+V
 p5J/BxDBMPnUbd84v7EN1l5vTbqUuywxTi044CTqv8r+hm+m9sW1xJsZc6WOqKZavlYhGj87g83
 enjjFSqhMZSrXVU4/EuNg==
X-Received: by 2002:a5d:6991:0:b0:477:80fa:f44d with SMTP id
 ffacd0b85a97d-47de66db347mr1040520f8f.40.1783360449457; 
 Mon, 06 Jul 2026 10:54:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm26392533f8f.22.2026.07.06.10.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 10:54:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Subject: [PATCH] hw/net/vmxnet3: Correct bounds check on tx queue index
Date: Mon,  6 Jul 2026 18:54:08 +0100
Message-ID: <20260706175408.905362-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::1;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x01.google.com
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

In vmxnet3_io_bar0_write(), we try to bounds-check the TX queue index
provided by the guest against the total number of queues.  However,
we have an off-by-one error: the valid indexes are from 0 to
txq_num-1, so we need a "<" comparison, not "<=".

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/vmxnet3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 97156dd33b..8569484b2f 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1079,7 +1079,7 @@ vmxnet3_io_bar0_write(void *opaque, hwaddr addr,
         int tx_queue_idx =
             VMW_MULTIREG_IDX_BY_ADDR(addr, VMXNET3_REG_TXPROD,
                                      VMXNET3_REG_ALIGN);
-        if (tx_queue_idx <= s->txq_num) {
+        if (tx_queue_idx < s->txq_num) {
             vmxnet3_process_tx_queue(s, tx_queue_idx);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Illegal TX queue %d/%d\n",
-- 
2.43.0


