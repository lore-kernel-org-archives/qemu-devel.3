Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34210EE6457
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeTl-0004ys-Lv; Thu, 12 Sep 2024 03:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeS4-0000OC-0t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:41:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeS1-000131-1F
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:41:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d6ad6050so518712b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126872; x=1726731672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Q1mMHu0qY1Mg7YdLUybGWIueKQg5CpgXLD+/9rtI1o=;
 b=nivWtVvWkGoVDdKsVO31t6fGY4NRzhW4EqlT9kbOuYSb4YWVaG+4E72wPB/tV1fKxI
 0RkYLDgbl6lrwsAbf+bEnlXkl2QGAdPWSKOiPGnBPFY0xdn+Ee2bIHMg/uoyaB7T1524
 d9MjKKtHkwuzDnaKUKFs1kRRn2DujPwESIdIv8ZLSaavlN5MUVk7ZP2GmSSjY9Vn3n3T
 p54niT3JStdQvOCFuY1eESk1Di814q7Z8lz71JNQpZ5sciEneMKc0biXT1X4ZYir6z4o
 h8YF6uFlJAdrERwe7ErJSE3RwCrRhL7RHjKUvNxiFVCPosMUwYoFKh1C7wkxC+KEErXh
 GHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126872; x=1726731672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Q1mMHu0qY1Mg7YdLUybGWIueKQg5CpgXLD+/9rtI1o=;
 b=Lok66+W1rHZaYrgCcFNSzYXCBKcMVZjjPvFQatgZUmiW5x/iCwPEav5YRtcaTRDUki
 Q9grZWNkT+8b/YCJNIoNEuBK8WnKgbVG1e+zF1Hp3gByIFnUJQjudwF1BYj5t0qxh4Qm
 8bcCPyTy6eVPqsZ0miK8VDpjCPYujXgx7vkFdHSo4cTFQDMJjZrBeFGWqlZ5gLVtJtk3
 XCa0QJv5NMi1aExyZ78m9wTd5xJC6FqPmmw1vq4GoYUnUVsC2Y3OTeNQhhyKZO5mCicp
 bF0l/j1VCtIEwjLctmJwbpTOtVv4lqBX8rew2q+W3ClmdQ147XqYwOoxgoirXe5HgWLc
 IYuQ==
X-Gm-Message-State: AOJu0Yzi9PXXxIbP16WA/RgFx8VgVQoaGJtWcT5uessdKkesgQBkyJ7Q
 Nf3KmCAbfjbJ4vUyjg7CZ5gUxs3Yj/saRMxg2ybBbUpCUeBhokx9szOf54xRhw/FGhg0vdVuJ5g
 e4aTCr3yY
X-Google-Smtp-Source: AGHT+IE7t7Xs2KH5JUIaVOe68OuWPwNTouEEYSj6TZqCiSQvTjYgxD2YaXeBSDQ2jSGG5jMqgQ5hKg==
X-Received: by 2002:a05:6a00:1906:b0:718:532f:5a3 with SMTP id
 d2e1a72fcca58-7192607ec83mr3028275b3a.7.1726126871623; 
 Thu, 12 Sep 2024 00:41:11 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:41:11 -0700 (PDT)
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
Subject: [PATCH v2 40/48] hw/hyperv: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:39:13 -0700
Message-Id: <20240912073921.453203-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/hyperv/hyperv_testdev.c | 1 -
 hw/hyperv/vmbus.c          | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index ef50e490c4e..a630ca70476 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -89,7 +89,6 @@ static TestSintRoute *sint_route_find(HypervTestDev *dev,
         }
     }
     g_assert_not_reached();
-    return NULL;
 }
 
 static void sint_route_destroy(HypervTestDev *dev,
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index df47aae72b8..be7d3172c4f 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1890,7 +1890,6 @@ static bool complete_create_gpadl(VMBus *vmbus)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 static void handle_gpadl_teardown(VMBus *vmbus,
@@ -1947,7 +1946,6 @@ static bool complete_teardown_gpadl(VMBus *vmbus)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 static void handle_open_channel(VMBus *vmbus, vmbus_message_open_channel *msg,
@@ -2021,7 +2019,6 @@ static bool complete_open_channel(VMBus *vmbus)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 static void vdev_reset_on_close(VMBusDevice *vdev)
-- 
2.39.2


