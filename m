Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6989ECE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94S-0008Vq-9f; Thu, 19 Sep 2024 00:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94P-0008Le-VX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94I-00079j-Ap
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so370627b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721221; x=1727326021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ5w0lQctWZKvW76VfUVnQRwnSRhyDW+QKlbN5pvMwc=;
 b=mbYACRhBaJEhhDhCDzguhPgWshefpd72/hITaz2ipHkz1dmG/7ALm/ryEkxCbn1uv+
 u2q74ZR+CvNgJ3tr7SSHG3GORNi/uFDFqruL/F9EkOwzdYxn2wfuOwgA7mack9K6AEK+
 FjEF1rhHTrGWYeeqnuXQL72OELb/R+GKiaGWpV17lgizcBz46cI+uiZW1eSohlTRyzz6
 TCzBus9zCJdOsMXxXfJPEKTS3FtsGBM3UvxDz34LRFwzUiZOgqD+0w+OJft4+BjS4Q7j
 w/NzxMzwAyUQV5TVC9CSVa8Wcg2FNhROjhug5OjPMe0wXQkKzNjoen9sLKfN/GrioVna
 FitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721221; x=1727326021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ5w0lQctWZKvW76VfUVnQRwnSRhyDW+QKlbN5pvMwc=;
 b=wA/+FgzfUiYXRCM01osFHLB7vXrcyL1mrmjO82/+FD0Xun232xrFAG+YhmAIB9Gg+e
 UUS9uz5IfxLzCx+tVleCSyH1K1rBNSsKj32B0vs4SC0k2IUfTKYYGdf4qWke6kwbLoKD
 cD9HVmNsMWDBBW9Ag04EUGdURs4N9yHuMc3bxUZdrKmhyTvoxJO8ih38m35jWR32QUz2
 J1/FWUcSBujo37CIWFLT5gAZRTiqGMf2G9U/sPfDjlZjF/nsSLua4YHu/N2SdrF9L/BG
 sr3/jf1hF6vjKVtwgVD0pinC4cVjeUxMFLmJPcEJaS3vpBYMuZQeDn94/2oWr7Ri5eFq
 NQ+A==
X-Gm-Message-State: AOJu0YzpWvkQQ9M1yqNhrpnmmFNP3G8ULKPuCIZ5LHhrj0n0jXkrcGBz
 9M/jMWvJA03Qmc2hgVTAYKFf2A/yAQB/4cRI+41OS0p4Hokh2OQLU4Gw5XTCJRLejRsy/YR9W6j
 D9tL8IQ==
X-Google-Smtp-Source: AGHT+IEAmbhCRhYWmctGVCjASbSM7CCQw3PaPgr2ecmIRqDI7EbS/ir9wSwBUY/hOvsMNKhE4LWwDw==
X-Received: by 2002:a05:6a00:2e9a:b0:719:1df4:9d02 with SMTP id
 d2e1a72fcca58-719262069f1mr36784043b3a.25.1726721220565; 
 Wed, 18 Sep 2024 21:47:00 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:00 -0700 (PDT)
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
Subject: [PATCH v3 07/34] block: replace assert(false) with
 g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:14 -0700
Message-Id: <20240919044641.386068-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
References: <20240919044641.386068-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index dd359d241b7..803ca73a2ff 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5299,7 +5299,7 @@ qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
     } else {
         /* if this assertion fails, this probably means a new version was
          * added without having it covered here */
-        assert(false);
+        g_assert_not_reached();
     }
 
     if (encrypt_info) {
-- 
2.39.5


