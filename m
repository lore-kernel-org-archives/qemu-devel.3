Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDC5C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0T5-0000zz-T3; Fri, 02 Feb 2024 15:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3NlW9ZQcKCgsvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1rW0T4-0000xr-6Q
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:58 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3NlW9ZQcKCgsvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com>)
 id 1rW0T2-00008R-OS
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:48:57 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc6ba5fdf1aso3398681276.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1706906935; x=1707511735; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GvmTyKAa6pFctd7IemM9i6KPSxPf0pawWWlJgwP74x8=;
 b=BpVrJBiIIyUSuzqVe/DrDgJmvlTjNy7soK+v13eK3OW9wd+MyEl6hevaYun9E8Qjcy
 rwVIplvhHnQ/R0feUEbN7G2Nf74Bp3VyCKgXtHpUGKnO85ixQVaeDEL4bXlVOtyt50cW
 +ZdiuEDhwGVUO5Yhe0hPET9uk9FtMVYn0rLOVPlOWWvjeZCrbfrwjxopLDRba3q5ChTU
 Q1vHymkHaRFR0p3TJkLx92dgdU+AITA1pQWfyqUM7t8Qr6P5xehuVBuckXA37SYEB9Wz
 d7biBvrwP26kfmJ7++RD0B/KRGqFPQnoOggWEBlnyfD1hpDw9fQ7uiTXMw2e1MAknz2T
 FJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706906935; x=1707511735;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GvmTyKAa6pFctd7IemM9i6KPSxPf0pawWWlJgwP74x8=;
 b=OVdZeop4MnmsdF7/+xW2dZYLLg83qdT5OiFRjRIbCg4uI6MMQRSo9bldZ0GwFoveXG
 S6CFgR0mk1l93rOXv2k/+euZ6mmXajFe044TP5VZJ2CUAYogC6XE7g1uBu9GrEmeqa0o
 VWeOAz4txDVqH4lwq1wpCQTq4LPYpurUK8aWrpALVOrd2SG/x3Kng40hOoNughYLwmt5
 8d4BCWLaD77Nj7pfcw1aoUbvIeLZwq2UKOCNJET7etFKrV0Vld5ZmWdUK6NtEjRZCYxw
 48IEtKFBZPC3GcswT58B+SqCG3NJfk55E3mPRPeviNCDBKiW44FoDEQi7AW84pbRZW9C
 IIhA==
X-Gm-Message-State: AOJu0YylE5ksMxoQB8HDtq7s872eoGgELcVJiDT56D9M0DtHnXfu2kih
 3y2ucor+oJFZkB+5GPTVoIE9LjYiX6HquIRHA++Jh6Dwu0YN1GrUyIhzBwX48xtRbgcmyqrnZo7
 JdX6C557iot6fHcuWoMtsWFXt/LZ4T9OCYE+/tb2syZzDlt3H4JAJsFY7v4MRALYh0qiCWLn5Mi
 nb9wfA3SgnlowIn8mLNHl5L+Iash6JF0GIqa8L
X-Google-Smtp-Source: AGHT+IFdm6eMdq8T6axYOVqlMZJZ7N5G+cb+zvEK9k0OlFmukvrYp89yQ8ScYfGxQwq9a5ge8f3IuJmjk9x7
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a05:6902:260c:b0:dc2:3426:c9ee with SMTP
 id dw12-20020a056902260c00b00dc23426c9eemr181997ybb.11.1706906934909; Fri, 02
 Feb 2024 12:48:54 -0800 (PST)
Date: Fri,  2 Feb 2024 20:48:47 +0000
In-Reply-To: <20240202204847.2062798-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202204847.2062798-4-komlodi@google.com>
Subject: [PATCH v3 3/3] hw/i2c: smbus_slave: Reset state on reset
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, minyard@acm.org, 
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3NlW9ZQcKCgsvzxwzotrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--komlodi.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

If a reset comes while the SMBus device is not in its idle state, it's
possible for it to get confused on valid transactions post-reset.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/smbus_slave.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 9f9afc25a4..4615e8b097 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -201,10 +201,19 @@ static int smbus_i2c_send(I2CSlave *s, uint8_t data)
     return 0;
 }
 
+static void smbus_device_hold_reset(Object *obj)
+{
+    SMBusDevice *dev = SMBUS_DEVICE(obj);
+    dev->mode = SMBUS_IDLE;
+    dev->data_len = 0;
+}
+
 static void smbus_device_class_init(ObjectClass *klass, void *data)
 {
     I2CSlaveClass *sc = I2C_SLAVE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = smbus_device_hold_reset;
     sc->event = smbus_i2c_event;
     sc->recv = smbus_i2c_recv;
     sc->send = smbus_i2c_send;
-- 
2.43.0.594.gd9cf4e227d-goog


