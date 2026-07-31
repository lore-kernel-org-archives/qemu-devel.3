Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8DFC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpjfL-0007Rh-MB; Fri, 31 Jul 2026 05:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfH-0007R3-1m
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpjfF-0002dJ-C6
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 05:36:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so541021f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785490584; x=1786095384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UwSfonjEOpdx3NsZ6QlNEhIH3TDtFP3V1EzW8Nka/3o=;
 b=b0GsRfVy7X+r0SvFH6hcmvUljLOrhSg3p7tNq1trWnd3uOtLkuQ0exv6d9du+KiLnL
 QvTbNl07bQ3QUwvStTys8vT1w2sOoriZGnAknf4dp/mbTJJFxkLoblUwpeSamtPWfKzo
 I8+DwW19e8HmiZhetg14VK6GVI+feOttf+Lq9UN/zoS+rkCq2kdaxGDds85BEpUMEg9P
 6NLYH6Cz7wF1iAbSHuq0O+t+QF3PCmWGzZHlR1VPUVVD30SMahMFXydCag2lsnR6Hz3K
 wOxVwWZDdpps31RwwLZaYaH01ap4yg8t2SlPvlUJN8ESRKMUSLEAN1UyfBr/YZmlp6oi
 jxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785490584; x=1786095384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UwSfonjEOpdx3NsZ6QlNEhIH3TDtFP3V1EzW8Nka/3o=;
 b=gzTo8YPPXAZ/la7LDCzg4PB9OYeP97rcJLcxriPkUKx72JzJ4Qm+KyGNec+sqv9w4I
 vFnSgmp7GKxJqHykMfp0XEAIpPCwv3xA5lDw6yw9S9gGij+9FGwENB9J2fkiczgbzQfd
 bmzdZ/F4D8K60k217kq+IHNgf2kufG2+wAkMvC1WeKioTv2f1PXd/9vcBSR86oBRm0FD
 v7PwleGVFUYIvCjJ94YcTt1p8V6tw7CR8C7WwoKGiuf1gAA4yPr6M2Wu2JV1PstzapMV
 H1RGHgtTZmIoBmm+othNUVjvd+esXit3kwP2E+DnzYKKz8M52C0dMvCZwlhi1Del64L5
 QLTA==
X-Gm-Message-State: AOJu0YxsyJhMzVogy95ZpyB8sfB62ccUBSRJE2GJFksbmxAPkQzQW7+2
 1nMFM7PvKh4SDVGIJsD1JDTowTcwbcdvn3evaxk5uB1Z/44z7kbrFrimtqw+AuTzboo2oDSsvh3
 uryU5
X-Gm-Gg: AR+sD12AcbtdheZx0Z2421MJ9Hu3nre449KQORG3kTH1VH21fKqsDGDGmPmgh3Jr/AC
 Y3UJKvN8xFM1mT/i8ciy3NkH0rz2qLTPfiT+vCvUUf3CwoNU+td5aNXMjcbujl91T41wX9OEfFO
 d+THSvqWeoM/9HaUWoqHs66QDZdMDkFy/zaqonxD0OGcuXHc+C/qryx9ohMglc51pkhiyk4r7wY
 erBOgWTDCFNM6zF6HXcytdyXQLXWQqvom4b5F0ncaXdJfXA6zNK+MQua5ayjg74j1uwu+6ssDV3
 XQNRbHvPkYAj9POKh5scmmIud0JJLAK0JZHmsgaKZ+Wuf5JFj8L4M4z61TK2PgtS3amP070/lWC
 FG/9vrW8uOLmfDuPaD3e9FXDZ7Ogyrs3oqluAQm+TbQTLxokPoRmwLMn2FUk/qIYhYapw+2Gd/i
 tpjajSl3T8QpNTqBAddi29E5lNVlDqDqoga8O3RwsSfOy1SwAGJC05gSSsLKL6mc/XMGQGShBGd
 o4eHU/cBJRW1KfRRFMdeWK0DC4J8T4/W+lKzD3e3SRjbXXMVX7toN6wELHBDtx+Y28RzA==
X-Received: by 2002:a05:6000:2c02:b0:47f:9dab:f676 with SMTP id
 ffacd0b85a97d-47fd2b5525dmr3476219f8f.31.1785490583788; 
 Fri, 31 Jul 2026 02:36:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm2861208f8f.12.2026.07.31.02.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:36:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 2/2] hw/net/rtl8139: Send whole of vlan-tagged packet when
 doing loopback
Date: Fri, 31 Jul 2026 10:36:18 +0100
Message-ID: <20260731093618.2961031-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731093618.2961031-1-peter.maydell@linaro.org>
References: <20260731093618.2961031-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

In rtl8139_transfer_frame(), if we are transmitting a frame over
loopback then we do this by calling qemu_receive_packet().  If we
have an iovec rather than a simple buffer (which happens only when
we're sending a packet where we are inserting a vlan tag), we have to
convert this into a simple buffer first using iov_to_buf().  However,
when we do this we forget to also update the 'size' local variable to
the size of the new simple buffer, so we will truncate the packet by
4 bytes (the size of the vlan tag).

Correct the logic so we don't truncate vlan-tagged packets when
sending them over loopback.

Cc: qemu-stable@nongnu.org
Reported-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rtl8139.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 2b61c171f2..16479284ee 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -1765,6 +1765,7 @@ static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
             buf2 = g_malloc(buf2_size);
             iov_to_buf(iov, 3, 0, buf2, buf2_size);
             buf = buf2;
+            size = buf2_size;
         }
 
         DPRINTF("+++ transmit loopback mode\n");
-- 
2.43.0


