Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8DFC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLp-0002Td-5z; Thu, 27 Jun 2024 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLV-0001j2-J2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLS-0006YW-5x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-70675977d0eso4113864b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495564; x=1720100364;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RVNKACznzXJwsczryHdNsSEUqVvGG/uCg/TYBM83LM=;
 b=cVJreDbrNyiOhrzWdpvWoa3z5kTvuLhjDXUTLhXW8Uq+PdTonjEkO5lC5EqN71ahAN
 IjaXltu9rXc5H5oOkXfYMya8dZpXB7hua4brkq40WAAl3gTb3TTDxizO2l1+pI226awh
 Ac/nwwLoZFcBhrQjBY6+Mhc4noeBOZyFDGnRremwIxIINr8UCL+uBgDjzAXxcYDVS7w4
 eEBwU3FmuXuj3iggb619xnhrkrDmYBQI6RRu+PC7wtPoxV7CcvqMZckrZPelGkBSJp8r
 P7Eu2HeHXVCnoFwP2li37eB9BG/di95dKsqc2EExVtqFq0Wr7/uUoQvXw2EBrC6UzxnQ
 L89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495564; x=1720100364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RVNKACznzXJwsczryHdNsSEUqVvGG/uCg/TYBM83LM=;
 b=wVWH4IL8LkfWAjT56guzW86mLLF3vojw8Gq8JZPk89+yJICWwPyRZGD2UA5MN+X9Wm
 9KIzZFhxuv7eHnIxELoVzh9rmQMbkOmooduuPLJbIMQwbF6KHTUrSEptVxgd8KiYHQ7o
 mX1t/6Peejv9eH5ExkBR3OhYOnnIVQWoxkaGmuFiA8XjyWeophdA3wbGbBzLwnkUiQQ+
 oN/WV/8kCkDt6fgf4/21NBqNQPied/U6GxwsJpiyLZVrvBKmvxJhIO5V/6gzLSblqpL+
 yxK80/22t0PE4lN1wGgVvVhW1/brovUCsx6eeG5Dof/CVMUUdfGQ/5u/TRZ0zuDU0tOj
 XB0A==
X-Gm-Message-State: AOJu0Yynt2iMDJzPjFEPiX5RRRLQ3aoQYZ2QgQjb8Gsn9dZhelSpUQud
 KWF1+PV0jMmxGAhtdI8gtgPEY4fbNCc2LyNluH+Do68ioNW3BzxItsRHk+gL1sg=
X-Google-Smtp-Source: AGHT+IHi3SFb6IfzyjZU4LPjQOe2vtYPxvsTt5zgvDsBZjlxp/FQibJVmn1SawfGhDC4rTTaywaq1g==
X-Received: by 2002:a05:6a00:3c94:b0:706:7153:92ae with SMTP id
 d2e1a72fcca58-706745be252mr16837324b3a.19.1719495563984; 
 Thu, 27 Jun 2024 06:39:23 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b4a0fdbesm1331259b3a.127.2024.06.27.06.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:55 +0900
Subject: [PATCH v2 12/15] tests/qtest: Free old machine variable name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-12-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/libqtest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f89da7b80797..1605c0c9f615 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1509,6 +1509,7 @@ static struct MachInfo *qtest_get_machines(const char *var)
     int idx;
 
     if (g_strcmp0(qemu_var, var)) {
+        g_free(qemu_var);
         qemu_var = g_strdup(var);
 
         /* new qemu, clear the cache */

-- 
2.45.2


