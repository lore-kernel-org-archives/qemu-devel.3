Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF43CE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94T-0000AE-G5; Thu, 19 Sep 2024 00:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94R-0008T4-Nn
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:11 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94J-0007AW-Sw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:09 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7db299608e7so261291a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721222; x=1727326022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=De4sKLPybVhT2+Pc9xtI+CTmpF8ivUBlmtwhnsMRIOQ=;
 b=H8Q65y5Ao5sBkRZk9kHAZB4bWbl1BNRmzMwZCNSwh7ZMBMbaH92/bYXa27w7uSVNbv
 Jmow8uSLPK3B9tUQLscDD5uXizmsIO39xEbNBcAysEqaJD9W1uSB8OprkqN/JWP/T10M
 Gdd6MMEH0JXirEa7h+HzjVCDN6h6K9KwNTvwQpqEHQb1vKJYoZRhRmyEgCBGGJ1mvecm
 QzBl8i9MGJu7aMcDtIyRBYvEMX5a7mbVszuc4MmDYOpI3yXOE5ARQBWzttkDbo04+JRS
 XNUDLppI/VQq8m4UZQz+Jx/j+Ik6UGXUOzJbwkd0kSdrJrXr09k5AvryvhMG4M/r+gGN
 JMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721222; x=1727326022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=De4sKLPybVhT2+Pc9xtI+CTmpF8ivUBlmtwhnsMRIOQ=;
 b=WehQq/kgfIDCQn31aONq2+Xo2XGxHd06xHnHEaAlE7ab790G3jiorNA0cDue1qIe4j
 6Qen4/SWFvexJQbpFHq/3SeO9ZQkAWfKynhgdc5DPn6NgZz9ALnMSllFbdrkk9Qmr8N0
 TMr4ZVcovMsHB4/27bgCSjaHIBoZl6OsH/ZsLvx2i4D+8TCX1LmEbuCJ1g7CjinuDCre
 bEkv7pCdhW6evJSJ5wdEo9XdVYNH0bsgGTtBEXQeIQq3IJykRqbK9wMnyn15phfg8hPu
 PKCiNWhnjAJIs2fmR8UUSrA/sFfSsjegQAOfmzq2o58xniWoOIL2uhJ5dqHnLW2/JcgL
 XszA==
X-Gm-Message-State: AOJu0YygKwB4vg1K/y4u84youckFanxNAmXzUYQVEjo5q3aIJO3rzmFW
 zEdguSZX0wWymefHNP6vGMkhOU95woxcnfbsEcqCgFlNGhltg/U9ZOutmWEkJTaPH4lcztym8jU
 +erhPwg==
X-Google-Smtp-Source: AGHT+IE2Y81B/LKedghyO/XIB5KqiZokca4F2Biq0KEcZsGPJCLDi0vE6MjHgWLkzwtVTNzR2l7/8A==
X-Received: by 2002:a05:6a21:3a87:b0:1cf:4326:5602 with SMTP id
 adf61e73a8af0-1d112e8bf15mr31788153637.36.1726721222472; 
 Wed, 18 Sep 2024 21:47:02 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Hyman Huang <yong.huang@smartx.com>, Halil Pasic <pasic@linux.ibm.com>,
 kvm@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>,
 Peter Xu <peterx@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Corey Minyard <minyard@acm.org>, Laurent Vivier <laurent@vivier.eu>,
 WANG Xuerui <git@xen0n.name>, Thomas Huth <thuth@redhat.com>,
 Rob Herring <robh@kernel.org>, Eduardo Habkost <eduardo@habkost.net>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Ani Sinha <anisinha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-riscv@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Weiwei Li <liwei1518@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Helge Deller <deller@gmx.de>,
 Yanan Wang <wangyanan55@huawei.com>, Michael Rolnik <mrolnik@gmail.com>,
 Jesper Devantier <foss@defmacro.it>, Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/34] hw/hyperv: replace assert(false) with
 g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:15 -0700
Message-Id: <20240919044641.386068-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/hyperv_testdev.c |  6 +++---
 hw/hyperv/vmbus.c          | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index 9a56ddf83fe..ef50e490c4e 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -88,7 +88,7 @@ static TestSintRoute *sint_route_find(HypervTestDev *dev,
             return sint_route;
         }
     }
-    assert(false);
+    g_assert_not_reached();
     return NULL;
 }
 
@@ -187,7 +187,7 @@ static void msg_conn_destroy(HypervTestDev *dev, uint8_t conn_id)
             return;
         }
     }
-    assert(false);
+    g_assert_not_reached();
 }
 
 static void evt_conn_handler(EventNotifier *notifier)
@@ -237,7 +237,7 @@ static void evt_conn_destroy(HypervTestDev *dev, uint8_t conn_id)
             return;
         }
     }
-    assert(false);
+    g_assert_not_reached();
 }
 
 static uint64_t hv_test_dev_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 15e0d600c7f..03f415bf226 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1874,7 +1874,7 @@ static void send_create_gpadl(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool complete_create_gpadl(VMBus *vmbus)
@@ -1889,7 +1889,7 @@ static bool complete_create_gpadl(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
     return false;
 }
 
@@ -1931,7 +1931,7 @@ static void send_teardown_gpadl(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool complete_teardown_gpadl(VMBus *vmbus)
@@ -1946,7 +1946,7 @@ static bool complete_teardown_gpadl(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
     return false;
 }
 
@@ -1996,7 +1996,7 @@ static void send_open_channel(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
 }
 
 static bool complete_open_channel(VMBus *vmbus)
@@ -2020,7 +2020,7 @@ static bool complete_open_channel(VMBus *vmbus)
         }
     }
 
-    assert(false);
+    g_assert_not_reached();
     return false;
 }
 
-- 
2.39.5


