Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77961EE645A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeSE-0001g2-Oz; Thu, 12 Sep 2024 03:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeRG-0004LC-J2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:31 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeRC-0000bb-FL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:25 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3e042f4636dso346319b6e.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126817; x=1726731617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THAU92UrM0dCOcON0qgAWJPM/1rIMc3WLepZV6d4U4w=;
 b=kro1XKv/1q1SZurjp8JX/217lkWYC3UsiqKWG7TIHrM2jIaqofPMYaa45IFn07XX3b
 34sa5UwVHf6dxJqoxa4blHip/lmXS+ZUwJWJy2/9HA0kLmVsmLkBLjn8CVKLc2yg0a2Q
 Z9vGQ/D8uTbWvCv3JWlK3ixPFKb96ZUM33K8mSIVPS0fUsfyFdOIxgUPgk58xSjqzGHh
 OB5t7UxfoRSk+OSdqWA4uB7JCrl+FSOq4I6h+HtU6KefpjY+EOG8loDuLSUBg33cRtE5
 LdvbebSzFn2Xk3vs2+Rq7uiA/c+X6iHtWx06jtHXnzKG7attIVt9DpAno1z1F28FyS6D
 qU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126817; x=1726731617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THAU92UrM0dCOcON0qgAWJPM/1rIMc3WLepZV6d4U4w=;
 b=LWIOXb407zBxyy5cdHszoxDtMwQTUtD6oWyuA2LyeKqZzaFbI8GM1jR7YZdTlfgqzH
 usUjOvXK/KAyS5OvvB7yMc8RKIHhBUk7QnrxswFwOXMTVU4dkh/ybOTSL1Vowmocxf+t
 9v4unnlNOyGlwTRwxjgziPssecwHfUpQTymVBppgVD67VuLlv1jQ75wCVny7NR8lztgy
 mgcwHgp8e64N7UkMNUHL+7WEwGicJjeqOWBsZpuVc/g+Ym+OKe74aSeg1gezNqnFwbT7
 zTOciQDeEAh+1MzM2z9ngW8v5SQfbuL/og2qPA0hiP/lissw1HgtqX2wsXI6/+LIiDwI
 wf8Q==
X-Gm-Message-State: AOJu0Yyiii0AI15ZBAL98/hnqNMP6ohFg1ezBff5rYcgqE1/0fZTvVNE
 DADOgZCjroPXuaq8p+SkRQJWO6YuXiQ83ARjv2v9i1ycTp8htk2xz7NDUdmJ2U28Dns+6V3o/6n
 pDH80nrBD
X-Google-Smtp-Source: AGHT+IE18OQNSYCTciWDcZ2tARjoD9KTkXd4QIX1a/2fI71lIh2I9Gute7KgIxVtwws+/7Dh8z96lg==
X-Received: by 2002:a05:6808:23d5:b0:3e0:45ea:7fbe with SMTP id
 5614622812f47-3e071a97f6emr1220176b6e.13.1726126817031; 
 Thu, 12 Sep 2024 00:40:17 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:40:16 -0700 (PDT)
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
Subject: [PATCH v2 19/48] hw/pci: replace assert(false) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:52 -0700
Message-Id: <20240912073921.453203-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/pci/pci-stub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
index f0508682d2b..c6950e21bd4 100644
--- a/hw/pci/pci-stub.c
+++ b/hw/pci/pci-stub.c
@@ -46,13 +46,13 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 /* kvm-all wants this */
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
 {
-    g_assert(false);
+    g_assert_not_reached();
     return (MSIMessage){};
 }
 
 uint16_t pci_requester_id(PCIDevice *dev)
 {
-    g_assert(false);
+    g_assert_not_reached();
     return 0;
 }
 
-- 
2.39.2


