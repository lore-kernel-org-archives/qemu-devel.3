Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDEDC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyT-000593-SV; Tue, 27 Aug 2024 02:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MHbNZgUKCo8CtE18z77z4x.v759x5D-wxEx4676z6D.7Az@flex--tavip.bounces.google.com>)
 id 1sipyL-0004Qf-I3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:33 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MHbNZgUKCo8CtE18z77z4x.v759x5D-wxEx4676z6D.7Az@flex--tavip.bounces.google.com>)
 id 1sipyH-0006BM-JS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:33 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6ad660add0fso69829667b3.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741169; x=1725345969; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Zz923pwwDN/VS0a8ZCn3vZ6fDnLK7TCJWzC4KDdiIlE=;
 b=vrz96lq8ELPdyGJ6YioTb4MF/sk16SIxCnc5sge5o9BSw3QoNYb34j4a7jnO3evbfS
 E2bMpHmx2HARdWiesmHLOVGxjqRubShnuBwCdxk1m9TBSzudpZTXMfBsE02WVlvGZQSs
 Cfp6AEkq6UJ7J3v9H/+IYenbtPW4pA5CCNUmde8z36r02E82jqV+SDk0wNwrmgD8zAy/
 wv1Flb4IvlnjYtsRxUhc7yw5C2PgNWxh6BcuEAdVYpr+OKlZl0B2GkYRKNev6Eqwy/HJ
 Hftz3/zzgL4qHFN3L3R3xyL4TPZImzHrwO1mNQ9uNTeIQ+oWx7qgrRQkNVtcutf3vGfk
 GZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741169; x=1725345969;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zz923pwwDN/VS0a8ZCn3vZ6fDnLK7TCJWzC4KDdiIlE=;
 b=TXznO5Ncqk34G39ZyG4WWLKPUFDpjA8CYE8b7LeiQ303oqzGr30j+f7XJ6qbwL+efH
 GEV4dpCHuD9JGo4eTS8oLIrOHs5Uq7X/pikzg7C4Z9mD7QB5nnsWm+Uqe9rlYPHZt+MS
 229rKgdTMEJipxMKPvWkPBFIT5HGD21i1Xgd/QmBTLm3V9WUUtVGdDOt45mg9xeyg8Y/
 aTKCcdWj9UOHrnaKJ0DsJ/P3XFhl7c0IajilyuWT46Zq53bkhiy52Li8C3dbBH/hZzSv
 /p2HMlVZA6I+vvtNyOKboGmB0sselS6VjEvdSxLsWzcHBx5jj0UZ098nodTrFf1y5fN8
 SuBQ==
X-Gm-Message-State: AOJu0Yzd07DqZWvgdrT/q/CeDh2a1ipyUrqyPZcnXbhWjKmgfoz6LpxW
 WQ6T10bYKpuoCMcTRcvucQZv/aI1zjU+GcleC9u495e0268EgCfJKhCTjJcSq2zz94XnRvAHOTq
 kfTGfUs32YTLnB5pthYPFfCUDhgZcUQYZKr1NQqnTRSa0dwBtDPXfqCHCrXVyRVUYo/hlWreVZn
 Egs7xVK8+LoSUSo5xcexbC7C7cvQ==
X-Google-Smtp-Source: AGHT+IHgJdTYyl+t0FvuVFP+Ksw+njloJz6oLkdS3UvjbCBkwJLT4daZQ6zYK2wo3m1KAH3p9CagcbNrlA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:6712:b0:6b2:7bd8:d794
 with SMTP id
 00721157ae682-6cfb3402b58mr1522097b3.4.1724741168451; Mon, 26 Aug 2024
 23:46:08 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:24 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-21-tavip@google.com>
Subject: [RFC PATCH v3 20/24] hw/ssi: allow NULL realize callbacks for
 peripherals
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3MHbNZgUKCo8CtE18z77z4x.v759x5D-wxEx4676z6D.7Az@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Signed-off-by: tavip <tavip@warp10.c.googlers.com>
---
 hw/ssi/ssi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index 3f357e8f16..d1f3ce7c22 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -105,7 +105,9 @@ static void ssi_peripheral_realize(DeviceState *dev, Error **errp)
     }
     s->spc = ssc;
 
-    ssc->realize(s, errp);
+    if (ssc->realize) {
+        ssc->realize(s, errp);
+    }
 }
 
 static Property ssi_peripheral_properties[] = {
-- 
2.46.0.295.g3b9ea8a38a-goog


