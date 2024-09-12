Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4ECEE6457
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeRe-0006CW-Uh; Thu, 12 Sep 2024 03:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQu-0002ov-91
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:09 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQs-0000K0-2w
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:40:03 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-710daaadd9bso335233a34.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126800; x=1726731600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F+rVp3/BLJYyjxO33P6GwzzAqjbQ85NDH2br5JtXUaQ=;
 b=LGSkZnRljWDM7uymPWgDkrJXtxwNpgUSYPeRnmsHK+vvxl2kTaQyV/jv61LzjM3tEA
 tAUGB2JijT8NPhnWRRAi5Lhj2m4PiJxbR7VePAVRdr5mYp2j21eYHlXzfsUNrfd+cmKL
 VhiT+Lr92Rc//ATeNXAbzqCGqcWFixArz8R+CBX2vbMeXG+ZUhaGVferKu7E7GpAH4EQ
 KjnfGOvnowDsy6A9t1X7ira9Wa3Y/aKyyvkvuc0o/Ps9V1uuKVlXvM8MXJ7gEu+fgKRM
 TafiyXnnCArKWX8OVIxvbf2uhFoBwz7AOM73kFxWMwCdnZYEsacjpgL+8KiBR/DSBnOb
 6hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126800; x=1726731600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F+rVp3/BLJYyjxO33P6GwzzAqjbQ85NDH2br5JtXUaQ=;
 b=Op6h9VDvef7XCxHzBP6LaGWMvjjFi7TRD0kJ3pBeUF5sH5nnoNZsetcpq23PwhZG+r
 bMVQq/QeXIg5Z7qz6RgBdul4ES/GfCH9QBd4rEUDGrwJkpB6fedkaPeZkvV9koYlhZ4R
 A2/GL2pNP9KHHfNKeos/gRzvcGP6VWAflErO6nUnTt4a5/r31JNbVOK2qrR61ZjqthAG
 bO1LL0rEPI3hJDm2zfqXJrp5FmumHMvcj0W+TuJ142RVSNt5TPqUNwB96Hij/X+J0Quu
 bSZyt4hAfWVWRtGCl/EZk6tIQd6WXIx80DpnEQOlc/WzZr7FbYIkYMjunfLZQ3PjHSnV
 HfoA==
X-Gm-Message-State: AOJu0Yy9fnrq/ukR+DKtswT/2VAD7OnAOSvNFMSfO9tPDtfgR39qjmXE
 yBpsuF9JuM1XEz7gtqCqw1bD1gYfqW7uVqYmrK1kA/ff309lGXLRq3nRpyqC2g+W9WjNDx4EjIS
 odiYW6lZM
X-Google-Smtp-Source: AGHT+IG6+n9GSh9VOQuGu9AiTjxnE8dPu+UEy8HMFEQWjdljbFKlQEVbTyzIuHmcncyWJBtD1Vjx6g==
X-Received: by 2002:a05:6830:4994:b0:710:b19a:cea3 with SMTP id
 46e09a7af769-711094727c0mr2302235a34.13.1726126800291; 
 Thu, 12 Sep 2024 00:40:00 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:59 -0700 (PDT)
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
Subject: [PATCH v2 13/48] tests/unit: replace assert(0) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:46 -0700
Message-Id: <20240912073921.453203-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x332.google.com
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
 tests/unit/test-xs-node.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-xs-node.c b/tests/unit/test-xs-node.c
index ac94e7ed6c2..2f447a73fb8 100644
--- a/tests/unit/test-xs-node.c
+++ b/tests/unit/test-xs-node.c
@@ -212,7 +212,7 @@ static void compare_tx(gpointer key, gpointer val, gpointer opaque)
         printf("Comparison failure in TX %u after serdes:\n", tx_id);
         dump_ref("Original", t1->root, 0);
         dump_ref("Deserialised", t2->root, 0);
-        g_assert(0);
+        g_assert_not_reached();
     }
     g_assert(t1->nr_nodes == t2->nr_nodes);
 }
@@ -257,7 +257,7 @@ static void check_serdes(XenstoreImplState *s)
         printf("Comparison failure in main tree after serdes:\n");
         dump_ref("Original", s->root, 0);
         dump_ref("Deserialised", s2->root, 0);
-        g_assert(0);
+        g_assert_not_reached();
     }
 
     nr_transactions1 = g_hash_table_size(s->transactions);
-- 
2.39.2


