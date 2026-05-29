Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8E7CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgc-0001T7-On; Fri, 29 May 2026 07:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgb-0001S3-6R
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgZ-0008Aa-Be
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso8538267f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055249; x=1780660049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GoXX4YWT40J+kryrPvd7GD/qSjSySyctZsAYeVA/MuI=;
 b=Nf5JbGUIz44LDyf887zjrSoKQagpwRmMwU3JSUyo9uCV0C5i9kYt0wosGUYnhK1+Wb
 WmArVF1bZTW7x8jmEkty/VV1tCSI5IpZ9JCAX6Q1gPnxsS6gnn3B8PRmdRupnlU9nz1t
 rl7eF3LbuI6XgDEPWl/TUGTdh7Q1hmmI9i1ph18HVPevldX39Y1LxBoaLLMNMtpUbWso
 5BZvYeYvhBrTa3SJtmQO0KnYz4dj8OObcV0JUy3aJNzzGHYqqljftyP/b/dfAOx9iGAZ
 JJwtWJ8QLKYK9zABSDYbaYWyPNv4cS/4sRG1Fxu43HExMOpSSdUQ2Q1llZ+MN4aBC+Si
 oBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055249; x=1780660049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GoXX4YWT40J+kryrPvd7GD/qSjSySyctZsAYeVA/MuI=;
 b=eI5BGudFo9uca+4Q1hjCBEcRmPn9+v3IkeDElYoxJPn2pcYe3dDjfmDQshHl9tC5Hq
 BNT9INlvBjUFgQ8lsY6wv9ibVtrmUhRYiiQe+PhaEFCf0Q3K32C/NSiDw53loAbsxHkO
 G7WFselc53JXKCPFPZefbf2SI0526DSLIT8vndTmZJS0LWeWRVkA3QiPC53hSeIzugsZ
 JlQ+BH+DT5sdEA8mt1Gjuvb+CjV/kPwPunQxpjXVCRb+7ONYe43IQBORp5yiZtaxdwRv
 WbEi81anqAQImNpdQJ4Lrqrx2GeDBfY4O0AmgUZMqZsyth5GrYe1VZM6OWgR8XRPPt7m
 10MA==
X-Gm-Message-State: AOJu0YxSuvMNNOFC1nyRApRiVBes8H7L1qtrVyZgQNbtKF3m0SsJ+nRf
 I2FtHijJNMdJs+ds+mUZvZ98qB1e8ckSb+hqKUne/CaSBNZN273rjrScnhfaO6nECI8ubABRK1e
 5XHhB
X-Gm-Gg: Acq92OGQSxQ+HSIX0E186rKSaS+gY85e9odnLgw+IoRj+/0gn19UPTgUgMyOUjBbVFM
 d1vNraVE8e5hsd6YbqVfT2QYNCG4RpHSZORpYThDA4jAzS5Yvpg3/uWDa1LLYna7mMCn24TRsGB
 xTkk2l5CCwpLSLoV0Zi6a+hjqtgsLfWeB3IrgZeuGDTd6h/ymaDT53vTMB56SHJOQmfb6CSVWLq
 Xsmcb0rP87h2Lw+ih9ulW8ChzASBHwBzTSQt3zcxhvQ0G60TGdsRKjf8K5vnPUh5ZfO/UELzyhS
 DByXcqW4US1FztW4WaH+xvTQtQw0sgO/0dQmUuYseOjZaWJWIYzmlMkpPUj/4FKtIUB2O4q3uoh
 rTKR/Oxqxa3LN/FhtD4zEJFhmQPpBbhXU8TQoB7gxmADOv9+xvr9+chxCSlXjifawurNms1a5/9
 jJ1a3bgO+rPYd2hPY6qqpRe15zg54SPGtcK8+fvEwDUf+4ZCBt15UXn9XL6mIB4c8FqTMYgMQzg
 FnrswJvdr2fujF/4vL3JtIPV8b6FTUiFIlJlwWlfQ==
X-Received: by 2002:adf:fdc4:0:b0:449:31ca:5e53 with SMTP id
 ffacd0b85a97d-45ef144307emr3108697f8f.8.1780055249371; 
 Fri, 29 May 2026 04:47:29 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Fri, 29 May 2026 12:47:05 +0100
Message-ID: <20260529114723.42040-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

All register bits are clear on write by writing 1s to those bits, however
the register bits will only be cleared if the condition that sets the
interrupt flag is no longer true. Since we can assume that programming
is always done, the `PCFG_DONE` flag is always set to 1, so it will not
never be cleared.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20260518073401.11279-4-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index afe6ffd326..7370ab941f 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
 
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+
     xlnx_zynq_devcfg_update_ixr(s);
 }
 
-- 
2.43.0


