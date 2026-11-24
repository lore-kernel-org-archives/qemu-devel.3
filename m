Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95914606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GKmIYnK8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqaH-00059Q-He; Tue, 24 Nov 2026 08:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaB-00057D-Qq
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:17 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVqaA-0007OM-7A
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 08:29:15 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so4286508f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 05:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795526953; x=1796131753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3H0fLgaXfYkSeAvWy/RU0AqvZSS+ka4mLFlMPqlDno4=;
 b=GKmIYnK8dJcjKGXKdG7Wg51i8+MfVkufSLeI+/ESYHpOExStauqfUf8irOaQbxxNH0
 nkdx5ZCpCe+ZDtNLl9hrxfadnA55GF10RP2xqKsSwcLjdRLoTSQ//CcFf1FBdJjGQuwh
 MJS9NDt9WKlX5upK+d1pxFw5AKpe/F+XEhHKwSpNHfDeh92MibHG3Qd+iI/fyO2URyZ9
 tAJjIO6yn807K/Xo6ulB5R537HuS6TQNbrQzXClhk8a0fu07GhTeVkw+DLGzeDiAqBVB
 f3VbbeDnotI2azojeBiusLBTsNpIDN/suCVL8lQIrTsOuq3dmAlJP2EKz7dsA2lTzpUS
 nAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795526953; x=1796131753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3H0fLgaXfYkSeAvWy/RU0AqvZSS+ka4mLFlMPqlDno4=;
 b=ky26CYncynXS4lPU1i/9NnMj9jgvDy2bbwDWpzAIE6D0OuaPTPtS6iAFWCid4LHf08
 /H8mLRXDwfa2LjidlF38zWfImTlyq7K+wDMpwRZWEwq9vF5u1aJ8A9DaLvQ+s36otWN3
 wdeDYJAv0rCBqXoSzj9BwP2f6JO3XI8KSOzt8vpfLz9Tr2/GGjnV1Kq7trrkSBu54KCm
 nvfHQ8XNp3td8WVPtZKDGHnenqeskMVS5rQaLgtAoCHM++neL6eE+Xyhki3H/L5UUKSm
 rwivVnrO3ANaoNJGQ5Cxzy2nms6IspHG84yH4uQQvCxLclMgDfSxa1k+piBurwlvZ2Vx
 rt/A==
X-Gm-Message-State: APuU4Z/UGCSzZ8BPiiOT84zzsTD+46DW/FpdBgYPvI6fquXnAkMLO05z
 kI+hlwom/ULtEgbtee/8sDILwaMQoe9LHbaV0lVEDZI2O2MPYpUy1mg9RgijElrr/oT+LsMlq//
 qZumB
X-Gm-Gg: AZFdTZdEhAJD1QJqBdxKYE05u5YSWPQ0+4gtXtesHtBmYjOhUzmJh/vXp1mKS0YPRXe
 o1nVzKh/5/oauYcsBQThelwi/ACatKM+9bN4UJjpon+zqCTMfXJuRXNupNQB/KYHCVSFyPRna13
 /dZqrb/9YQl/uFTAA3VoZaK4JOrGGLVbO6NpDvC71WPXgKJ9K9hSRWsEwa3voXjAfRD2Tmnprkm
 SvNyLWwRPIWbjInrS4pMxm/R6t2P3dSDDVq2ilQyNINWDCV4QVVkE9HCpGXJacA35vzSK5cuKJo
 jwQmQTl7WhbrAVy0RjNQkeThYIUnQCQNK4N2BF4fh1SOQw6Bnayj8mr9ST4QCvm7S2JoWIX+cnV
 RfwE01bGyMgBF14P2FiuL9qlgVubU82cHe+FoIJpGmrHeW1cP9QROl/FnhvH2At1PuEHakvk4pB
 /u7x6LfFB6F0mQIBzfDBaV4urDWjXEVw6vGig0MnfVNjTlSfS0EMo8UwqugkhhqKORKW8IKCJgP
 AQ1P+Uc9xWtTq7eLP+mdjZgaMdjYAwrGDdQTHPELeIOe/bVnIBOjDR9QBJOKOi7GwbNOY+cfDYZ
 IkqzQqFcuPoe5eNMmmo/BjYLE8Po/YvZcmBQE1AuHPAUS4k2vihLY33kHaQ/Bh7gctES6vKWuo6
 fIcdJa6acdCgmeGMqRwLZKjQlNqZIByL34g==
X-Received: by 2002:a05:6000:299c:20b0:4a7:9630:7b4c with SMTP id
 ffacd0b85a97d-4abb9459073mr20803323f8f.47.1795526952722; 
 Tue, 24 Nov 2026 05:29:12 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b2c9sm29098031f8f.31.2026.11.24.05.29.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:29:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/intc/arm_gicv3_cpuif: Don't count a virtual EOI in
 EOImode 1
Date: Tue, 24 Nov 2026 13:29:01 +0000
Message-ID: <20261124132904.138731-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124132904.138731-1-peter.maydell@linaro.org>
References: <20261124132904.138731-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Fuad Tabba <fuad.tabba@linux.dev>

icv_eoir_write() increments ICH_HCR_EL2.EOIcount for a virtual EOI with
no matching list register, in either EOImode. The VirtualWriteEOIR0()
and VirtualWriteEOIR1() pseudocode in the GICv3 architecture
specification only does so in EOImode 0 (ICH_VMCR_EL2.VEOIM clear),
since in EOImode 1 the DIR write increments EOIcount instead.

In EOImode 1 an interrupt with no list register is therefore counted
twice, and KVM running under TCG deactivates an interrupt that its guest
has yet to deactivate.

Increment EOIcount on EOIR only when EOImode is 0.

Fixes: b3b48f529fe8 ("hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR")
Cc: qemu-stable@nongnu.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Message-id: 20261119091922.1380805-1-fuad.tabba@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 67a0bba4b03..02e1e7c254e 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1617,9 +1617,10 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (idx < 0) {
         /*
          * No valid list register corresponding to EOI ID; if this is a vLPI
-         * not in the list regs then do nothing; otherwise increment EOI count
+         * not in the list regs then do nothing; otherwise increment EOI count,
+         * unless drop and deactivate are split, when the DIR write does so.
          */
-        if (irq < GICV3_LPI_INTID_START) {
+        if (irq < GICV3_LPI_INTID_START && !icv_eoi_split(env, cs)) {
             icv_increment_eoicount(cs);
         }
     } else {
-- 
2.43.0


