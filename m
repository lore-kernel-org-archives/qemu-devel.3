Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C38EE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9BV-0000kz-KM; Tue, 10 Sep 2024 18:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BK-0007qm-MV
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9BH-0006yP-1w
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71781f42f75so4835306b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006667; x=1726611467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwL33KJkM4Q6sZhv70DYnj8c/5K/FMceLOUvjv0df2Q=;
 b=fmQra3O1RchwVkBmA2kMEY4pkjxUPhCv7GexH08NrF6EJV/blkfsKk2+S8C6U10JNE
 XwyUyI7pzFkL4W9Yzx60TRj5LpydputZbJR+4D9eW9tOUS5Gj97aid9YPlg0t+WBKXzI
 0uM7JUEWt69OLb5irA7UhZDgnbtQ9rRfMwvkjU0UohG7HduybV7+J+fspJY3BIToFL2N
 8ILzYoJ+NG9cfp/otT3xm++0uR5+M8DGcOkJua1lN1cU5pl3hxzRjwCxHFsJInd8QgOa
 Iv267zyB4VjbA1z3tSV7CuxezZFFJQEoMgJF0jK3pAKapqwlR3djGtQWb/Zf6EQDni34
 ldOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006667; x=1726611467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwL33KJkM4Q6sZhv70DYnj8c/5K/FMceLOUvjv0df2Q=;
 b=nC+Mqtprqm9Wgm1BI2ShvrOsptLtVnff9qYjeiKIRwRifTtoAeUyP3Pa61Rpmg2DC0
 64ihlN8XtvAF3Mdz22UW53VX5oXVeCLUa0/DKPYhyBBupnMbgsYhS3rjwmthzC+4RF2u
 C02zGGTFX0heLFAvm62GgMW2Xnyb/B/pg+C1wRSf27F0FXPMcAfpIOcC6f/4+Od1Zaph
 0wRJ/jjku0dwG1bM0kISDcrXet/CLmgnbBrTeWVszWK1zMjd8TfHwQg7vsKAxlnwHCEB
 EdqSUitJDMi1UMhBtPMabZNt53BZDl7W+69GC7WARdoSY1h6XJ+GoA343wI68mKZ8Nen
 lqdQ==
X-Gm-Message-State: AOJu0Yy36mJm3LXXof44P2X7NpHxtMgRr3GHZhM8BgIgXhYajtjBcszS
 rvnoUtyL8xFLDhFrkXyWl5KThHmmb/RIOIeL/gu4KWrSErWOqkiY8BtFBCAsI5XrR9gkW2LN28C
 bkJQRDm/p
X-Google-Smtp-Source: AGHT+IGLJQ5enOtPE13aQ+/NIdbH6s0S5HLwnq2JQ7qsPrp+J14Xh+TVi3Hmr9X9Sr+7gsTyHm2Dpg==
X-Received: by 2002:a05:6a21:9d91:b0:1cf:3201:c3ad with SMTP id
 adf61e73a8af0-1cf5e1c8112mr3689026637.49.1726006667581; 
 Tue, 10 Sep 2024 15:17:47 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:17:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 29/39] hw/net: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:56 -0700
Message-Id: <20240910221606.1817478-30-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/net/net_rx_pkt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 6b9c4c9559d..0ea87344745 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -376,7 +376,6 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     net_toeplitz_key_init(&key_data, key);
-- 
2.39.2


