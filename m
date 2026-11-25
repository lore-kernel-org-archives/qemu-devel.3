Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54348606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWEwl8uT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWCEv-0002L6-17; Wed, 25 Nov 2026 07:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <puranikyashaswinsharma@gmail.com>)
 id 1xW9gl-0006kc-PN
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:53:20 -0500
Received: from mail-dy1-x132d.google.com ([2607:f8b0:4864:20::132d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <puranikyashaswinsharma@gmail.com>)
 id 1xW9gk-0004gu-00
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:53:19 -0500
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-3282db206d3so5329791eec.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795600395; x=1796205195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FInCen5Dp394VnHLVq3Ql0hl3kgwbGHaxdTnVFlLFlA=;
 b=FWEwl8uTmEfdRO/74wMGQlPjBDLeUfnVCGp4gYCuIEaHxIAWp+6ZMjK7HC/UHswCJP
 0XjXz7oEATvNH0fIxdAXIgDRiqTuIOSWgnavYD7SJl0g/ktKaTuIKEowdiBaOlTTSfR6
 sAV+lLbh3gyjj+di8Qti9oJb8Haeh9qHpnxXP7tlyxES+G5ERR+f0lJ+K1t6aDQ/bPjh
 9hQPLo93/4tqtnEJ8rYa9lLk4b7omAYskAbu3Gkg0zM+FD3Q96bM0Biia3iAuPZLPzbX
 pMQCFbnTP2e34UjqCJ5+3/NHGs5dbrpQb7FzgsGX4lukoNpr9B8KbJRBz76Uyfs9dtvi
 XgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600395; x=1796205195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FInCen5Dp394VnHLVq3Ql0hl3kgwbGHaxdTnVFlLFlA=;
 b=AUpbUa18EWeXhq33/+VhHigf2LYg9rwc8i/kUUtydJb9xqEc8SiTm/m+HkPm52SbC0
 rB3Nbd7BOpRD9awA/g1jk4KJF0aZFNH0wmBhcYdAdBUuOmUUAiLuMtDJ6+Sa/T7KwyB6
 Dlq6kpiichnK4X6aHUXh93gv7470NvKebv3XvIpV1CjNEFl1KE5Az4Bh5g7IkfB0Gsfg
 jgpF3jh5KQL/A3XB/8QZUdXMSNRThIBk7HVejcap7cg0/A4lwl8PiPwCUqS1UttgM9E6
 0o1J+T6Ph7gB5Tc8UuYJ+CbDedDtvKq2eUDSd+SAg5kL0j6Gltf8XF8FQJ56Yu6PRrWh
 QL2Q==
X-Gm-Message-State: APuU4Z/FDyFMSRJAQKInKpOwNlzL5oDCx/l6hpjxyUCUxosXvSkEk13Z
 lU463+7XGdzlp4ntJLgyeIY+cTjVb+Nkwd3FdCbDpDY3sPurUapVmrNDob+lbk1pP3c=
X-Gm-Gg: AZFdTZdKxexID4CDFb6GS6mZpUfs1x+Qw0caAb/5EZdDgd9VGeU07nKfR/CRco/lLYU
 vqEEc4zDQEx5ZmCopA9jf8JBy/k2+zhTmgtkROUNX2gfipI+V8xngfnMDoBFvNco9lL846IEHwQ
 4B9SL+2V/a5fzrk/0LoMk5syO8MsfX02ST2n7J1NXzOqcEF+8djn1HxAMrX2Bd0Lq0SeGBaxvL3
 kmq/4y/hWjUnjz6u8st1ZJnoIgDnP/bS3d0Nb2qAJWW7P0Bg411z+fYIj8tn5lF4k7nsa3qedu0
 ZFPJsO2WGt7W9dKDc7rIrnt5WEhqLwBcPZ+dpEKz+/xNT0j25aiBGC8njF7XpDR+oHBzBty9XrZ
 WtWhLcqoIXzh8JhjaOt89+olFlBv2nf+5BHQr4dTwzAYNXuRFQHoO03qSSCiIlV/BQWNV8/Inr7
 Vm+ij3AHq5zS7Ln2kewZwqlyqtD9LfMgk0MuTcWu0I0V7fdc7tqpvi0sNiTFHBhcbb7CXH2gNGb
 3NXYqWxz6BG7w2dC9TZO4v6kOKpCevI322noadC1vz6A011y5v+BqbLmt33DuoIpiaKaXv+jC8F
 fEaIj0ASjxEZwOqvvy7c5znsUKPRyi8ikFOnNWdcdO1L29iv28EAPJ2B9GS/R/aMoUQyGI7Fykf
 w5PG2/OqCkh+LIvWAbJj9+snNcobvURx6vvYhCTYbUVD9DARUszweYLm61pV3FQPOVXvgcyLhOB
 IZpNaDLMRCQYUKXKLhIHdC8UhIJNfXPh09TOLVMTcP0EN2+Jdw0a8aUMBIosoOe16B0sG/wgpFr
 0ZvJPc=
X-Received: by 2002:a05:693c:80cd:b0:385:b8f4:756a with SMTP id
 5a478bee46e88-385b8f47b36mr18236049eec.12.1795600394546; 
 Wed, 25 Nov 2026 01:53:14 -0800 (PST)
Received: from localhost.localdomain
 ([2409:40f0:114f:dac0:c822:471d:8ab0:7163])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm40052060eec.1.2026.11.25.01.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:53:14 -0800 (PST)
From: Yashaswin Sharma Puranik <puranikyashaswinsharma@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Jiri Novak <jnovak@fel.cvut.cz>,
 Jan Charvat <jancharvat.charvat@gmail.com>,
 Michal Lenc <michallenc7@gmail.com>, Ondrej Ille <ondrej.ille@gmail.com>
Subject: [PATCH v2] hw/net/can/ctucan: send a Ready TXT buffer that has
 priority 0
Date: Wed, 25 Nov 2026 15:23:04 +0530
Message-ID: <20261125095304.21652-1-puranikyashaswinsharma@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125045205.37999-1-puranikyashaswinsharma@gmail.com>
References: <20261125045205.37999-1-puranikyashaswinsharma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132d;
 envelope-from=puranikyashaswinsharma@gmail.com; helo=mail-dy1-x132d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Nov 2026 07:36:32 -0500
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ctucan_send_ready_buffers() starts each round with tx_prio_max = 0 and
takes a Ready buffer only when its priority is higher. A Ready buffer
with priority 0 is never picked. It stays Ready and the frame is never
sent.

The CTU CAN FD datasheet (v2.7.0, section 2.9) has no such rule. The
Ready buffer with the highest priority is sent, and of two buffers with
equal priority the one with the lower index goes first. TX_PRIORITY
resets to 0 for every buffer but the first. Linux does not hit this
with four buffers, because it rotates the priorities 7 down to 4.

Select the first Ready buffer regardless of its priority. Replace it
only for a strictly higher priority, so that the lower index still goes
first when priorities are equal.

Fixes: aa406e8b7ecd ("hw/net/can: CTU CAN FD IP open hardware core emulation.")
Suggested-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Signed-off-by: Yashaswin Sharma Puranik <puranikyashaswinsharma@gmail.com>
---
v2: Use the unset buffer index to recognize the first candidate and
    leave the priority types unchanged (Pavel Pisa).

Tested with this change on v6.2.0, where this function is the same as
on master. Guest: QNX 8.0 on ctucan_pci, connected to a host vcan. A
small program writes the registers directly, with no driver loaded.

  one buffer Ready, priority 0:    before: stays Ready, no frame
                                   after:  TX OK, frame on the bus
  four buffers Ready, priority 0:  before: none sent
                                   after:  all sent, lowest index first
  priorities 0, 0 and 5:           before: only the priority 5 buffer
                                   after:  priority 5 first, then the
                                           other two, lowest index first
  one buffer Ready, priority 3:    sent before and after

The test suite of our QNX driver (43 tests) passes with the change.

 hw/net/can/ctucan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index f6ff4ad..380a3ee 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -259,7 +259,7 @@ static void ctucan_send_ready_buffers(CtuCanCoreState *s)
                 continue;
             }
             prio = (s->tx_priority.u32 >> (i * 4)) & 0x7;
-            if (tx_prio_max < prio) {
+            if (tx_prio_max < prio || buff2tx_idx == -1) {
                 tx_prio_max = prio;
                 buff2tx_idx = i;
             }
-- 
2.56.1


