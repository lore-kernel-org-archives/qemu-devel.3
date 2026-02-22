Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46F5E68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIYj-0006dr-48; Sun, 22 Feb 2026 18:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYg-0006MQ-MF
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIYf-00065P-0N
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:08:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so34625075e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801691; x=1772406491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5dSZ2BRPb9a3u6TkdiLcs4w8cdPWRis2CRSgfa2M8O0=;
 b=C6VEib7H8LRi/Wfvj1Xb9YivCLDv4Jgd+H3h7leC3WT1Y08PmupjX8VQNLuGhYxST8
 9ot9tiXnjhvVPudDE19LUx1XQ3kuYdmFJ3eL8zL7XXhv8MYPbgNLumUspOFLOzRRE/EW
 9mTODDyrNscuPGGr62dZDag47R/sECoDtGymKKu2eZkZv5sQ2qhEJK+N1/LBdN4GZdEb
 +w3Q9eMNLbLAXbJxDf5/WmS4hEOus3I/P4SJk8VM9nLY/iyHz/M1gIgG7YMRC8uTXFY6
 cHaFrpro38HO86l08ZbXV8W+FJdkE/1CnUY3DIadWk7zEy26I1JxRedgYnfrqi3V9SmS
 +Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801691; x=1772406491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5dSZ2BRPb9a3u6TkdiLcs4w8cdPWRis2CRSgfa2M8O0=;
 b=YxgQo1h8NGHj+/xhWOPGX2gbh2PeDZRIy3ovyTtCx6G7R9P4pH815dQ2eLQN6XYxdk
 IG01Kicbx761zxyqSBw673+U6XqHBwOtJa0OvJDeKC0ImzOmc/jNaPxw4uAfJ0J4CffP
 20v6BaevakSrJ3rztRRc6C7M06Tj/N/Gb72/C9H/d9RsItN6W1Lm3NOszpiPrzqv8kkf
 XSa1GcNKKeUqkore3rfGjdLIMYrShjdD6CDzAxHUvb5ks/ib5qjo8QMrE4Bj7k/5YPGW
 mGwTLnoQcalAbufq8IradV30f3TGzWSw5ajsOMDD6ClGDC3eKRiRx8+F1IeuKj9cmkjN
 ijZg==
X-Gm-Message-State: AOJu0YwDSCByUoWeAZmgXJsVKtZXhrp5DYMNCfZp3e3oFgwgpnTM4+Bj
 B4fYi2/fykWB5V9mVu32NCbGNK4rizAMewJi9hH4Q/mCNpugV8I6LAFZcmuVwSdr3kP9xnMp/D7
 Mm9nHqb4=
X-Gm-Gg: AZuq6aJM644zr0F1sA3WkZP9EdL0q3DhVrLmfPndw5tQ6qM61Ns5XONDIwjE14FHTpU
 k3SV6zUs/xtkaeo2q24LN96azLipTNiq+Sw4c3CX6VZYFdbLGmq5VqU1AxMo6n75Y6kpFcP7ccw
 R8+okakmccwEyY4rs0zRw3fI0QZI8Iw0DXwlRPMgdYXWJe79xYWQ9k2pRPKgTsiyhXDsf04fvy7
 9hW+on6aBO4RcquWRC4dkCwSPLGV51tP5srT/rIQ8izHQOqiwQ4+uaDKO9mDWyozcIZPEoI+u6T
 MX7xZauswS0FFT5fEToRIvlW7p75mQpeOa73wCBYtC69XcxvYcBonmDZDXqxKu0at+OGHC2+frA
 0DmgVh6CSd6M7dQCcShmfecmY0H8ZHWORW3Om7mnMljPvI4e9hWMIVJt7hoSQS0FJkDpHih4raX
 4z6srCDNoWA5PMGG0aeHzU05BiMxYYOKgjkG609a+pLgwEVn93YsnFaaPiUgSWLrz6BlovjMWep
 FcShzVkzbY=
X-Received: by 2002:a05:600c:4fc2:b0:481:a662:b3f3 with SMTP id
 5b1f17b1804b1-483a949f791mr107831785e9.7.1771801691187; 
 Sun, 22 Feb 2026 15:08:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9fb2sm15623773f8f.1.2026.02.22.15.08.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:08:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/20] net: mark struct udp_header as QEMU_PACKED
Date: Mon, 23 Feb 2026 00:06:00 +0100
Message-ID: <20260222230602.5756-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

The eth_header is not actually guaranteed to be aligned.  We attempt
to deal with this in some places such as net_checksum_calculate() by
using lduw_be_p() and so on to access the fields, but this is not
sufficient to be correct, because even accessing a byte member within
a misaligned struct is undefined behaviour.  The clang sanitizer will
emit an error like this if you run the sifive_u_mmc functional test
with sanitizers enabled:

../../net/checksum.c:168:24: runtime error: member access within misaligned address 0x5b7a7f829033 for type 'udp_header' (aka 'struct udp_header'), which requires 2 byte alignment
0x5b7a7f829033: note: pointer points here
 ff  ff ff ff 00 44 00 43 01  34 58 54 01 01 06 00 85  95 80 60 00 00 00 00 00  00 00 00 00 00 00 00
              ^
    #0 0x5b7a71a5887e in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:168:24
    #1 0x5b7a7156819a in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
    #2 0x5b7a71566201 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13

Fix this by marking the udp_header struct as QEMU_PACKED,
so that the compiler knows it might be unaligned and will
generate the right code for accessing fields.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-ID: <20260212140917.1443253-5-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/net/eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 63f598d7cdd..df90ff08374 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -85,7 +85,7 @@ typedef struct udp_header {
     uint16_t uh_dport; /* destination port */
     uint16_t uh_ulen;  /* udp length */
     uint16_t uh_sum;   /* udp checksum */
-} udp_header;
+} QEMU_PACKED udp_header;
 
 typedef struct ip_pseudo_header {
     uint32_t ip_src;
-- 
2.52.0


