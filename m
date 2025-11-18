Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47BFCEE34B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQy3-0000z5-KB; Tue, 18 Nov 2025 14:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy0-0000r7-6T
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:17 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxj-00063e-Qw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:15 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so42379235e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492518; x=1764097318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gXiO5nPfAcYV2Wewa5o/aax8KoL/hNVg9xCYOqbljoU=;
 b=RcecxDpOPCNAAH7VMq0PyOOW5DnyJAU43FojxmrIgeszSn0KfVWQJlxZraoWlgTMfn
 POe/nkWtUC5VAELtCBWDGzNHQRXv8qCghpTmeGPlaS6hRPthbb8UujPswnUXcJQ5S9NG
 kOOJSnCaKUxEMhoUYDG7FC+rAFBiOhQMQdClq5OX7SEySx4Me92k9H+NU3zM/ImmQ0Cb
 XEefFIq1wAxVTL7dTT8TeHhrcKhE/5sY1ccif3dxDzbr2vOBRoDDaW2EvPPBB1jwmHMo
 /1zMObPIPhSz/AUXpJJmXLDq+XrfDMvbUNGtNZZMBiJBI36lYN+XNhUEbN99j9GQt44Z
 nZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492518; x=1764097318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gXiO5nPfAcYV2Wewa5o/aax8KoL/hNVg9xCYOqbljoU=;
 b=abw0qZjI6leJZaaSmqYqQ0Gah5bBwgmj8CGyt+JpFSfZ/tQDfKMZfQd+C1TcyCoOkn
 mDVKZztfijIyIWRMTEaYv5wKHMpoyPDDA14/ADP4HT/tsnhfcvMGEppGnMD2I3A/k+ML
 1iIf+V1C6Z8u6yaYPzsjuvIT0A0a44FpzKEV0lRJTKqjMuXNOHf/NT9e4PWXIfaRV3VO
 X60fsyUPLDd/XfmSC1LXpqJRV3dMcljTHwIZDbuZwB53QJH1W37cJHaPeVU8fxCOsN3a
 CgZCjwAY8/7fgShKXQl+NrewbmSBpc/fIcSRHN9XOLxdanRWoq06A2WMSx7o1SI2KopL
 kSeA==
X-Gm-Message-State: AOJu0YyyiysT2j1AGziWOQchYbIV1PC0N5BkNrwsLpxjkESFKFFn9AW0
 0mViirXPbeKBthqPIzV3K7mQhNROVgx8+xvHwpXlSSUy+Khk2P88EuG/ndD/hW7hv+87xKjZe2e
 cBT0ilKgZVQ==
X-Gm-Gg: ASbGncukdp0GRSKDoieNZBl8WosFBKXl12C5G5F0hQqOQzTATgYkN4NZ+bmamHTlghE
 W/rdPXqPrAUZqMhxXouAOLQBeXjSbC1aaUxmYMjgEb3zdP0BB7Fi6W31ly1MV4pfHs7H4XTbFV+
 szR8SCmGbH01GPIGn7BIZUHnU1S2IF4UHMlmXQa601g+D3hkqY56jXvLbfFyNkAeP2Zlz7h69wF
 AB342QzMWc/AOY+Qjl+pv4umsrk78XEY8Alrit/FsRK2Y4/sbjm8K+sKiQHWJC46bpspS0SrA2W
 s4vI2grCMo5yVmMWx4zCtCYg8WStrYi6GVOozaaPUA62BtRLQTOBICoPP31WDBSUNDcu3CbJJMh
 X47dayj/A0bj5gVeagVlCO82QXo62bQZmFHT574u1ojop0RGplcShRli/evgKzNJCSfEp9d6I7j
 S8EHS7tSXGs60PL1+xjPiGV7GWILzHufbiD4DqtdqrbicGITHjoT2qXI1/sW1uKkOYb7XUx2w78
 enwGFKXIw==
X-Google-Smtp-Source: AGHT+IFmW7hb3No794ZGBnkpEBuGFkQvoaUG214AuAgxt+Ks2pwKrZwSd1O0dUDExG7EAzEO8GmONw==
X-Received: by 2002:a05:600c:4585:b0:477:54cd:202e with SMTP id
 5b1f17b1804b1-4778fe59a0bmr167414665e9.2.1763492517763; 
 Tue, 18 Nov 2025 11:01:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b106a9b0sm4924475e9.11.2025.11.18.11.01.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] hw/sd/sdcard: Avoid confusing address calculation in
 rpmb_calc_hmac
Date: Tue, 18 Nov 2025 20:00:43 +0100
Message-ID: <20251118190053.39015-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jan Kiszka <jan.kiszka@siemens.com>

From the source frame, we initially need to copy out all fields after
data, thus starting from nonce on. Avoid expressing this indirectly by
pointing to the end of the data field - which also raised the attention
of Coverity (out-of-bound read /wrt data).

Resolves: CID 1642869
Reported-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <4f7e1952-ecbd-4484-b128-9d02de3a7935@siemens.com>
[PMD: Add comment before the memcpy() call]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index df5a36fad9d..40a75a43ffb 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1160,8 +1160,13 @@ static bool rpmb_calc_hmac(SDState *sd, const RPMBDataFrame *frame,
 
         assert(RPMB_HASH_LEN <= sizeof(sd->data));
 
-        memcpy((uint8_t *)buf + RPMB_DATA_LEN, &frame->data[RPMB_DATA_LEN],
+        /*
+         * We will hash everything from data field to the end of RPMBDataFrame.
+         */
+        memcpy((uint8_t *)buf + RPMB_DATA_LEN,
+               (uint8_t *)frame + offsetof(RPMBDataFrame, nonce),
                RPMB_HASH_LEN - RPMB_DATA_LEN);
+
         offset = lduw_be_p(&frame->address) * RPMB_DATA_LEN + sd_part_offset(sd);
         do {
             if (blk_pread(sd->blk, offset, RPMB_DATA_LEN, buf, 0) < 0) {
-- 
2.51.0


