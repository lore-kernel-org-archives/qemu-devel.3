Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09285C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYD-0001zL-Dm; Fri, 23 Aug 2024 02:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYC-0001vV-G0
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYB-00036S-0I
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7142a30e3bdso1844971b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393610; x=1724998410;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mkj9QVgkoZ/zBUH6wc7gaGhuVa7cH6Hj+4496VYmMzM=;
 b=WHdCLbViTbltS9UjB7fi9ES5zDYLAWVBMC50Yb+boWcOFu64u/1KVFniP27w19x3TS
 7QKEanhVOWD2Quns3SbV9+Lws+qa01crxcbtCWNjV5KtBDaQ2A38SMXv4B3wC5unfd3p
 /Do28YTtf0kP/H3tPMF6SzOs5UYODg0ieuqwSo1Int39Z/iG/wFMFDPTLpTIz7drWqvK
 LggBwxRlkTLQH/Bkrd0i/dyCao6r844FUO7CXEeLs/8e9Umfkb+rC3DK35SgGXAmyTg5
 EOeQcmAXrKApKvklkuBiKRgulLgjRoPwdvV0gK8kqC77Tz57icVW7i9Wa9S2Wq+VVooC
 zpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393610; x=1724998410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mkj9QVgkoZ/zBUH6wc7gaGhuVa7cH6Hj+4496VYmMzM=;
 b=cu+yuNVQN0LZSPcXhkw+dvCKzIBT7carjpjXRoqP6DYP4N5FKxzWT6zXlKvNEI5Wta
 D1KyTj8mkJ3wqVYu1VbL8xQ5Rgt2krm+Vf1qeEu7tNmZztI2gJdIq/JcUfi69d0e1AuR
 UoAKQD7Z39iLyI0uIIREaiuUY45OqgN5KA+hTAibKMUOsDP4/aa+HEO7ZcT7xYqkb1o0
 LhrEYhDNKwOTMumnS7S2JcnRUEB5a3ISPWQFPaKEI7ZbYYu+zFR5zojPTaavpRmGNP7Y
 nNu+VDEcJGlEdvvptmttNAoCtw957o/l/Aj+K5wIXqT5lLojqIXrR4VjgyYU/fRa12Rv
 ZAzw==
X-Gm-Message-State: AOJu0YweHV8mSIK49l1XbuaSMuD2egu/a9c7SyNAHf8PM3Z4KuhSyAdo
 dmPJ1pb9PLCDOqP2nr5ceT4ccvcCEev5p7lInN5GWO/5RiexSAd4bqwSwOsjwg4=
X-Google-Smtp-Source: AGHT+IEG74UASIaEWHM/rv95T1YlnQlPc3vXPFvHAVPLEoDkbH6Ut72Tyj+P65GxySJ22VRewXG1BA==
X-Received: by 2002:a05:6a20:c709:b0:1c0:e1a5:9588 with SMTP id
 adf61e73a8af0-1cc89d29d0bmr2475725637.2.1724393609598; 
 Thu, 22 Aug 2024 23:13:29 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7cd9ac97f5fsm2338485a12.11.2024.08.22.23.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:29 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:06 +0900
Subject: [PATCH v4 1/7] migration: Free removed SaveStateEntry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-1-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index deb57833f8a8..85958d7b09cd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -874,6 +874,8 @@ int vmstate_replace_hack_for_ppc(VMStateIf *obj, int instance_id,
 
     if (se) {
         savevm_state_handler_remove(se);
+        g_free(se->compat);
+        g_free(se);
     }
     return vmstate_register(obj, instance_id, vmsd, opaque);
 }

-- 
2.46.0


