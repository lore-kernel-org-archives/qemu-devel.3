Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8434CE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr958-0003JY-3i; Thu, 19 Sep 2024 00:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr951-0002kf-Dp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94v-0007UT-A1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7191df6b5f5so286980b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721260; x=1727326060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aVLlQ1azCZTPpBP5TtwQ0P5RnlTFYhwK6Tm+S/9eUGE=;
 b=sZmZYMIEwzYkertdAhYCDFEI09bhwEWFdDjoyMnuwtc5Az44Yg7DIb4zk3jCTmPQ4G
 93aTV14n+0dsWonbG5Ai/ygmW6Nt5cLjyoxH2Dw9LQnnZVtN32clgWHxlY9htoFGThki
 eOOmfAKE5xswVgHGztQTAf8DiyDZsjTqXiCHUBpKC4UZSaQ46S8QZxtMDx3T6uS+704K
 ZKCZ6nPhqyqrEmNgAq3lrQAYjRzMYFcI9Ko35NUsmqcu5opXXDDyCjuPXehahmxMk/QH
 yeW608UmoTuOGnauIFsSxy7z7/O1+vRd3QVSzgyioKFX/C8kxQFUO7ivN/OX+HwUj2DN
 8k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721260; x=1727326060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aVLlQ1azCZTPpBP5TtwQ0P5RnlTFYhwK6Tm+S/9eUGE=;
 b=qh9uTjphlKrmTsrQxgaVjsEhkZ+ozDkgBxJKz/onksmseEc1vUtD20WhHDm3bvaOhC
 n5Me5v/H93a+NaHIEkqRf0vTWAZRh+BOZnQ+yA001/KFrwK5ufFkSCGPpvYTmP9wz+o2
 0FGmX/39U9Ca0yFJ9W/zoWw5FF5jg4VXfrY8poYQRfmGH6WLB6aGzNUnlIk+tAGQoNjq
 oCxdDL7JrHm32MJ4UiP20al+nrby3IkEClthrBM7FX4BlFqlS4Pk3W1e4PLOkDLCM2cM
 U2wdtuJVAUnOMYmhzJNn5ER3bJArSFRCu8JU+HclyRhVsx22FFoqdZ93QLQkvm2J11s0
 0HnQ==
X-Gm-Message-State: AOJu0YxyCMnvt0ZbtHFiMkU3r48kNytX4TzNAw9rYBdi90v3FSquSdMZ
 vFoLX38a8QHIWXKXA+o7rxFaqHPEwIAlMIHz0IsofBBrTO+j0DK1sjY7mgrgpZHJvkHRG0U6Fyv
 i0xYzFQ==
X-Google-Smtp-Source: AGHT+IGrzvQ2fWBlgZ0/fu1uxdvH2ybmzImXSv0pyHCUPeGuO+jD1r3RwXqEDbd4priHhUIUEE1u1A==
X-Received: by 2002:a05:6a20:cd0e:b0:1cf:476f:2d10 with SMTP id
 adf61e73a8af0-1cf76239c98mr35848879637.49.1726721259880; 
 Wed, 18 Sep 2024 21:47:39 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:39 -0700 (PDT)
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
Subject: [PATCH v3 27/34] hw/net: remove return after g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:34 -0700
Message-Id: <20240919044641.386068-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
 hw/net/e1000e_core.c | 2 --
 hw/net/igb_core.c    | 2 --
 hw/net/vmxnet3.c     | 1 -
 3 files changed, 5 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 248381f9766..2e4c50ddbaf 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -562,7 +562,6 @@ e1000e_rss_calc_hash(E1000ECore *core,
         break;
     default:
         g_assert_not_reached();
-        return 0;
     }
 
     return net_rx_pkt_calc_rss_hash(pkt, type, (uint8_t *) &core->mac[RSSRK]);
@@ -841,7 +840,6 @@ e1000e_ring_free_descr_num(E1000ECore *core, const E1000ERingInfo *r)
     }
 
     g_assert_not_reached();
-    return 0;
 }
 
 static inline bool
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 6be61407715..5dffa12c64b 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -398,7 +398,6 @@ igb_rss_calc_hash(IGBCore *core, struct NetRxPkt *pkt, E1000E_RSSInfo *info)
         break;
     default:
         g_assert_not_reached();
-        return 0;
     }
 
     return net_rx_pkt_calc_rss_hash(pkt, type, (uint8_t *) &core->mac[RSSRK]);
@@ -747,7 +746,6 @@ igb_ring_free_descr_num(IGBCore *core, const E1000ERingInfo *r)
     }
 
     g_assert_not_reached();
-    return 0;
 }
 
 static inline bool
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index bb8583c7aba..8aa8c462283 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -456,7 +456,6 @@ vmxnet3_setup_tx_offloads(VMXNET3State *s)
 
     default:
         g_assert_not_reached();
-        return false;
     }
 
     return true;
-- 
2.39.5


