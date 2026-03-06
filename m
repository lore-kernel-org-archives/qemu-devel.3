Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C4FCB605
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWej-0003rx-AS; Fri, 06 Mar 2026 09:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWei-0003o4-5T
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeg-0002Jv-AD
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso77578705e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809193; x=1773413993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gJ7VFJWuSeydb2nt0OqrAAoYzkq0sPNDXVosGYHOAwY=;
 b=mc744WCU7SIWY9hJKvHwuVWYddEqILxPAjsvHl3zL84TlLZAwCEn8SVfw1IbtZRq0z
 m2T45e5F4rhMF8RdrjAcCEdA4LXXQlrwinx1/eCK32PkN+4yFOBKnFrYY+cEbpZfw1wh
 25eIcP0lznXSk9hMF9luBSfi0z4FOiZUv4y4JFVvMSAMqDlXL1sjHs9pc3YoOYEF9mWG
 Od6H8V7RZGCBqPM4Fx/c54ydfCbV0HHVa37h+ee5xjWqDflybedy3cxzPwwa6IzJnl69
 oAZ2uWtDYY5XIbvol0KdzEPGj/4Szn+4hSw8GeqGVvFVQnZBYJz6WrAKMXtk853AgYi+
 x8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809193; x=1773413993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gJ7VFJWuSeydb2nt0OqrAAoYzkq0sPNDXVosGYHOAwY=;
 b=bjQFB2D49HXWt3MPXubZgVEv+dPRVPxSAH2n16dwmDqf7WoiInPJcL+mW+jYlTgqiU
 efYlb3o5xWYbTjGfUbVzAaObgpepf29GISW1qeyMDnl6FmpbSE2fEO0YpnQEjlnRhEKL
 Hmz9tquz4b1qZK26EtQ4pFdG3tSxcfumIrVfpWho6jhowRn5VmpP0oUpw/vkLkuKO+OM
 PPrrfdWASaYZ1iE4RcltN6J3G9e+G2siTwl4FQ5BqUNWyvgMnWzQN2xrNybexSPLmxZP
 /+L15HlmAE6T6THh1FKL/k3I8zgUmi2fGsJ8x2aP+UE+KQWvs6iRmO96pc6itVxMuiOe
 7pBQ==
X-Gm-Message-State: AOJu0YyZYxpIZDPcv0286K/ZOAo8jNHpNkg1Dx/b/NP13K41EJQVKOiy
 Qn8gjCR2aFWseUN3wYX3Lve45phfbDl7X8ky9CzMXy92/oRGmmzkBuoKMAoeVz1UBUceTMvhaZu
 8HmqV
X-Gm-Gg: ATEYQzwga8B1iKTjSGl1qvhL/eUCrAY9N1qy+sQ0VlN8czTIQHMioScqv41HKq0gaS/
 B+vI0BqIXm6KJPLzhGJ/L5TpejPd6/cN3JW6CwUu4tU8RBk/Vbn7vX1+6lKnZAMUU4ciH1T+iA6
 LCqUDaXf65LMIIxrlERBYWyIBic8CTWOuvB3flDicELXKhQVDlfYQuixxz87kuria6Xcl0tzraa
 cVggLrUE8B2ZONMipKdLR5Ez+Hb+8bMymXc6BBPOvgpQ/jU+SfPLRkXes9MVB08Y9zAIOS/sO6M
 F+R780yOOMJrvnW5BfkQPA1GT4mFrd/0QAePpLB4NctV9wlRHAIDMehFWLrnNCxJ5AQAxviQbCF
 6WxQ+ZKpcqh4VPG1Jz6fyd/XEFsU9w04t8xu4Q5BkqCksfPsOP7Ao7eU+AUVUymDIn+Gt/bscw6
 3zSkE+LK+NdbyiUThJJdX64/mP0d66P0/pFRNXn+f+CloaoZQvxaNuO0BMo4nb3xW9E/49dQ9SH
 IuNoElch3yjoL9XHw2ndCI6rnFgrqo=
X-Received: by 2002:a05:600c:4e89:b0:480:1e9e:f9b with SMTP id
 5b1f17b1804b1-48526951acemr36430665e9.16.1772809192516; 
 Fri, 06 Mar 2026 06:59:52 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/49] hw/net/smc91c111: Don't allow negative-length packets
Date: Fri,  6 Mar 2026 14:59:02 +0000
Message-ID: <20260306145939.2162189-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The smc91c111 data frame format in memory (figure 8-1 in the
datasheet) includes a "byte count" field which is intended to be the
total size of the data frame, including not just the packet data but
also the leading and trailing information like the status word and
the byte count field itself.  It is therefore possible for the guest
to set this to a value so small that the leading and trailing fields
won't fit and the packet has effectively a negative area.

We weren't checking for this, with the result that when we subtract 6
from the length to get the length of the packet proper we end up with
a negative length, which is then inconsistently handled in the
qemu_send_packet() code such that we can try to transmit a very large
amount of data and read off the end of the device's data array.

Treat excessively small length values the same way we do excessively
large values.  As with the oversized case, the datasheet does not
describe what happens for this software error case, and there is no
relevant tx error condition for this, so we just log and drop the
packet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3304
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260226175549.1319476-1-peter.maydell@linaro.org
---
 hw/net/smc91c111.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 3420d8e28e..3b526524fb 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -30,6 +30,12 @@
  * LAN91C111 datasheet).
  */
 #define MAX_PACKET_SIZE 2048
+/*
+ * Size of the non-data fields in a data frame: status word,
+ * byte count, control byte, and last data byte; this defines
+ * the smallest value the byte count in the frame can validly be.
+ */
+#define MIN_PACKET_SIZE 6
 
 #define TYPE_SMC91C111 "smc91c111"
 OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
@@ -289,7 +295,7 @@ static void smc91c111_do_tx(smc91c111_state *s)
         *(p++) = 0x40;
         len = *(p++);
         len |= ((int)*(p++)) << 8;
-        if (len > MAX_PACKET_SIZE) {
+        if (len < MIN_PACKET_SIZE || len > MAX_PACKET_SIZE) {
             /*
              * Datasheet doesn't say what to do here, and there is no
              * relevant tx error condition listed. Log, and drop the packet.
@@ -300,7 +306,13 @@ static void smc91c111_do_tx(smc91c111_state *s)
             smc91c111_complete_tx_packet(s, packetnum);
             continue;
         }
-        len -= 6;
+        /*
+         * Convert from size of the data frame to number of bytes of
+         * actual packet data. Whether the "last data byte" field is
+         * included in the packet depends on the ODD bit in the control
+         * byte at the end of the frame.
+         */
+        len -= MIN_PACKET_SIZE;
         control = p[len + 1];
         if (control & 0x20)
             len++;
-- 
2.43.0


