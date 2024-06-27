Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C20C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLn-0002Ma-QF; Thu, 27 Jun 2024 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLO-0001gJ-B6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLM-0006Xf-BS
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7067108f2cdso4256063b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495558; x=1720100358;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bOTqGJASqbN+xq2cvidGDOZj3Yf25P/ZsUr7Yh4tZjc=;
 b=sJQmCuwgbShIncPBnBQaiqJgjpg/UDYFFr2kfbd4pvIRt2mCj2dp+WJ5TFD9PeJIDn
 gbrKLS1zKH51hwCQuoPXnHh4pUxlM4D+lHMY046ucz8ByRn9f9yj/TGK4k/vAC+pNDEm
 N3TxBayynRDcRiCH3hYIsCqgqrHihXw9rxULSrFCLUIHgp3fGyo8J8O2fHXBVQcYrmWn
 XMMTyhW6Pdf6gw/v1KNUz+FbssgTh4Mm+ueVX2DOaTY0LZI4LKmcy2kX1NuzJiNu3/mB
 qLY5pKO/iG4dR6tiVpc3/CzrXxgVoan7q58jzfa8NvHasJgosdHTHC4spc+FfwsofH1Y
 p2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495558; x=1720100358;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOTqGJASqbN+xq2cvidGDOZj3Yf25P/ZsUr7Yh4tZjc=;
 b=RoUM2X6eai3vb3B2QDXjcHELegeDhcOfRAI8liksbgWOiUxU2wHXkyptzNJ0O5l7uJ
 M7betqr8QtbZ0PDeoAjzWHcUUsxqd4eFcS0nU0IGQ5e+b7wwJAxJPcolWNbFo3DImoE5
 rY6iKLcfhPr+XflaGAlVrPiXCaOpS+Lc34bQbqRD8dVIwrAxgvuL6gL0ZQl0mZ/+oDae
 086tulRQGaMvoSVzFAjenKId0qw1pwy4DjcBVsokGc0A/iruKncaMQq495O6gRfztjC0
 Dxh0WzEqeVQuz3Rf6t/tDj74qgemjZJp2ClaD/kdFlOXCqr0EF9iyCBKGkvYH1QmfDdd
 LYVg==
X-Gm-Message-State: AOJu0YypLzJiVxpyNXgsfmkH5Jo75UtGyaStPCqm7otSgC7FvVN9dhVX
 uIDEuwLHh96+Cp8lPA2Yx/aFWACPOCZLq6b6Y9K3YtQ0bAiIvs4v+PwyN+Gyiec=
X-Google-Smtp-Source: AGHT+IEWG5kSC0j6fCgKsJMYPuPASJg34e7zfzd1IrPkvGFbb3HCzQ4eIvOXePGeln+k/PXzaWks+w==
X-Received: by 2002:a05:6a00:138f:b0:706:6895:3c85 with SMTP id
 d2e1a72fcca58-70670ffbfb9mr18643834b3a.27.1719495557805; 
 Thu, 27 Jun 2024 06:39:17 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-706b491cd54sm1338229b3a.79.2024.06.27.06.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:54 +0900
Subject: [PATCH v2 11/15] tests/qtest: Free unused QMP response
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-11-750bb0946dbd@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
 tests/qtest/libqtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 18e2f7f28278..f89da7b80797 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -744,6 +744,8 @@ QDict *qtest_qmp_receive(QTestState *s)
                         response, s->eventData)) {
             /* Stash the event for a later consumption */
             s->pending_events = g_list_append(s->pending_events, response);
+        } else {
+            qobject_unref(response);
         }
     }
 }

-- 
2.45.2


