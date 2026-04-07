Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D7AFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXe-0000Ij-9v; Tue, 07 Apr 2026 14:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-0002am-CG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yDT-0007IQ-38
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:39:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so2774690a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536745; x=1776141545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWzjUTCd9em7jjYKpUK6oDcQv+hHOaT5Rzf5ShfZusE=;
 b=KpyP6wZdTVs3dB9ozJoZF/kxnCpjTLa7BtQ2MXaDcxxViv28Za9D920Zn4XY6q0hRS
 IKBYRhHlWKjgOg8MoyfRGX2ujpIc7kDnSCGAdlekI/NeV6FlwtgySNX41MGVTcza6o7x
 5NyjU+43SoMcWax/8uqyGLG41lsnPiIfvRvDZZJU1Y3c8HqpwmWGY1cwrdDBl5VTfvos
 6V7raHKTfTb5IEAIRcbmRmzZP5kHB38pQoOwmpLHa22YCtAlrak2L6Xi57Ugv84khTIL
 NZJ3/d1Fnf0JAvXFYGp9INqKNLPwr8dmg9K2+Ckinvld+1HTrHJ1hX3NjAZaYVI9O3Z9
 GjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536745; x=1776141545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gWzjUTCd9em7jjYKpUK6oDcQv+hHOaT5Rzf5ShfZusE=;
 b=IiIugtzby5KzAMTFzpIFFsz8MP/+2IkDjlrF040z/wpTwUJkG37YYXQ/rbvlIMs/GF
 nwSYOYNrjRNDxfmRfeF1kYWMVeqiHurd4BYbsT05mRSZiCkQzcwOmqZHjvKsqpf2Qgv6
 /53YDq45pzyKleqqQ986trrknY5sQ2WEOvfcaZj6Qwn3H08MIiGDfwQoWJHRUGIbU/Ec
 lJvAFfB472maQw0wlHz8dgKjXhnR5eecnYQMy8fEhEYiXn0K1eGNVI9NVX4hdrMpZYY7
 xwNktLgwxVyTT0EwMJPZWKz/+KhYEabLmOV9BmI2HVeawAsN/nBJN2G81EiGcEWFJAS7
 DlcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIw4Rz+LM+KoM27TxrIFU4MUFBK+qiLiMypGFtjxJLxzKaXtU21IaxwhwgZz5fiCgCU97rHq36z1S/@nongnu.org
X-Gm-Message-State: AOJu0Yy2aiySqLzERnOZ5cyw11xmPa5sppaJwQ6jCGRvyoaoi5++kXuy
 hPd1wXOI7iCO6a6UlfwwVZcaq7mAyIEWQTuUJ3VAxnWCxs0Qt/hCkAFd
X-Gm-Gg: AeBDieu0mEOWkwhT3YVUnVBtbRXhe89/dk5m80OenR7u5nHzm4js4drHoTCZ0AmMyP8
 AP6v8soxT/EVL662ju3Y3TX4MSPLDvoCYoOvYiYqs1ZCzr5tAkL/XxskpxJS7wOM+5PtmYF9KUA
 MbOhmHcuGgJBRkf8ADvQhlfkMbiyBLT7VD2rW7EcJnE4I5dCew0DQhl7p9orz+VIAlu8eSO+5gn
 mzRy9xlDe05Nb/tNts1zsGHiwrqXZFENyBVdSxKQZrBJ5gtSI5jPiQdAyBMOSuBD6AjdSFxS0Q8
 AIiR6ke+EZp1sLRs9lfFAQh1FyQVEf2bfouqYLc7ZWKnMTDt2NY3OjMVsvKNVf2RxN9EN8DYSxl
 6LrpamJsqgoTXQM0I4zxMd34DwhfGElUsg/EQwDzlqyxSYO9bTYbsITer799SD/X9zOYTp8i+NR
 Ts8KVb75+00pfIUDX0UPIFeBrWnI29uTs8oLvAhiCJ
X-Received: by 2002:a17:90a:d40e:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-35de697176cmr13261499a91.16.1775536745580; 
 Mon, 06 Apr 2026 21:39:05 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:39:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 4/5] hw/timer: ibex_timer: Update IRQs after writing CTRL
Date: Tue,  7 Apr 2026 14:36:13 +1000
Message-ID: <20260407043614.372871-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407043614.372871-1-alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

When writing to rv_timer.CTRL after setting the compare values the timer
doesn't fire as we don't update the interrupts. Ensure we update the
interrupts after a write to the rv_timer.CTRL register.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/timer/ibex_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index 0f12531934..571633803d 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -193,6 +193,7 @@ static void ibex_timer_write(void *opaque, hwaddr addr,
         break;
     case R_CTRL:
         s->timer_ctrl = val;
+        ibex_timer_update_irqs(s);
         break;
     case R_CFG0:
         qemu_log_mask(LOG_UNIMP, "Changing prescale or step not supported");
-- 
2.53.0


