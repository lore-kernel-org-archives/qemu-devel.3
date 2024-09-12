Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D1DEE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeRj-0006fU-Vy; Thu, 12 Sep 2024 03:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeR8-0003rK-VA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeR2-0000ZH-U5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:16 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20570b42f24so7760235ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126808; x=1726731608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P59BoCfpfnoUAXReWsDYStuySlGSOxKrMipSHR5f/PE=;
 b=ESSz9u+Xmbp1P1wPbvvM3ZstVP5BRINJj7DHte7HVFcH+v55tniZsoHHOA7VxyUafe
 J0OZ+f9L1ppTDir4PBwAwQHAzyA5vXeCZ1/u/SVMYplOePMo5GebIuthWWrzTfXXE6CC
 iShNSFY76StU5cH/73aQbbAiz0/Ev3W2hpBk54vScjdnrQ9fTPWY5YrYQRxFoBR4nfZQ
 XlIO5fIujlGhAKL4qi+2Dah9f1N7VVO0kVRSDZ0v/RR+vdGV5cvMPKaEkzbxdrz7l74Y
 Q3c191eEtUKWhewygkq/q7NmhNHCpslpBvRNm6bqJ21VhTfELyWdXb1F1/S6cWu3csqL
 0Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126808; x=1726731608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P59BoCfpfnoUAXReWsDYStuySlGSOxKrMipSHR5f/PE=;
 b=VOHIYPX4nfYbwxEEZTS1GVt+j4tlJYME72+L6mwBao8TINQjjyU/yP3C4tDnD+YGQB
 XtncGaBgOYI2W7VaJtzjuFVRCYjCVKD9LsuAZ6gPVfX7VkgbYZtc0QRj8u3dwNh++jlB
 Ay8U4sJWsMnOGk9clh5+xwmDhdzOux+0F6PbnwY8man0pAY+tEbKs8icVpMGTFngIZGO
 JKWwGNfRt3nrZzpnQYAoVfjRyInf6knc5jQTFjdEXGtfEVWvu5bPjB0i9PGaKbGZrQxo
 To+P0zcUxqOaO3EHVcPufd8NWOtU3u+lxPFC8wCZKLHm/R31yboScLw1dCWxE8uXzFu2
 65/g==
X-Gm-Message-State: AOJu0Ywr4+HIAGw1Fr/aTWVQqoZ+HH8KQFSyyGclghu6Lz3MQvSAjHVM
 +tFS5EUlYO90IiqhTWFe2Eex9OOLOX/VpdwGD3TPkhCTC5V33pKO/YX0mMQh9vno46urZJmEGSI
 LGDtJaIBo
X-Google-Smtp-Source: AGHT+IHWrcePIqQHDHOWlFI4nJcx4ZMXRIsFR9KI7njLnd//xW7SZTBR6BsOUNPJAp3rZN3BYPs/RQ==
X-Received: by 2002:a05:6a21:114d:b0:1c6:ae03:6607 with SMTP id
 adf61e73a8af0-1cf75ea27bcmr3064643637.6.1726126807996; 
 Thu, 12 Sep 2024 00:40:07 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:40:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Klaus Jensen <its@irrelevant.dk>,
 WANG Xuerui <git@xen0n.name>, Halil Pasic <pasic@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Corey Minyard <minyard@acm.org>,
 Keith Busch <kbusch@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <fam@euphon.net>,
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 16/48] hw/hyperv: replace assert(false) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:49 -0700
Message-Id: <20240912073921.453203-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
index 490d805d298..df47aae72b8 100644
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
2.39.2


