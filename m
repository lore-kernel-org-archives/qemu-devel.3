Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D415BEE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeQl-0002Ap-As; Thu, 12 Sep 2024 03:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQY-0001Ht-EU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQW-0000Av-LJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7191ee537cbso486239b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126779; x=1726731579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLMdbuNc1S53EAbOcoLtqlHcp4TS6A8Qk4ILSrig2co=;
 b=VM3fWUXJKjzFXDb6Gz7xy/i+D7/nagGsHuY2KZGlgMSfWnsYVo3jUDF3euo2nDybdk
 0gxCwZPMXTQKfjFIc/7MOwC249ZxwOT7gq89pdHyV2YOXK+963c4ZxIsUjwuYahp/+aa
 pG73AfZWVmLrk5MZZSxGbl6XNXkvVTUF82O58tQoc3p87eqLq16CXpxlCu3ynjp6VNze
 Vj9wbxg4pHKjy2zuoralTkX4RwttJQYy+BVLeahg0WzTgH0L+adv/Q+Atl5qtYiOE/Cd
 Hjx8si7+bDX70ZP7yG7ILfC6RnYzCLRSvLb6MLm5uIyg8Lp46lUdIWwNjUze9XTe2lEY
 Qq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126779; x=1726731579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLMdbuNc1S53EAbOcoLtqlHcp4TS6A8Qk4ILSrig2co=;
 b=RDRMY43wQ+eS7ck1cXy3SpAM/FasmhBxkJNaNXQAqMUz5z1On+NgPWA/jtyT+afdCe
 KYGl4xPovUClLxmxyfK23DmVsYxKrrk3XSitBBZ4lvRXRUTYdHDTKIZbHkX2xIVg6tKv
 oRj63o2pOQfhxJYZCNqLxUXcU8kRjzLK2bRRM3NJTqCbLEKYjy4zjp4KDf1mWx16vLNW
 It4l8d2ChehbK/sKOQs9QpxrFJ/2iazRt2wDZutke0qr+2aOd/dKY23qExpmubHRTJTQ
 5mAmSizwM1WB8WF4ttITjigIKYqskPbNi/LgX2cbAzWPhiDjakJgzja/7Hh9QV8a6Zht
 /7Ug==
X-Gm-Message-State: AOJu0YwyHqOSeB+aXqT4jCr2iDv2JmOuf4Q8gXnZ4YlN1p1Fps73QWQQ
 /CtTf7Tx0HDN8rxd6qlQAWVOUD8FTTNcVit1Zqc3vBopVRNjYE7Q2zPT11/927snrz+trsK+CvO
 2ySr81uvn
X-Google-Smtp-Source: AGHT+IGsYfpgGMtUkJQV3ZoeaZnVF1kzOMAI4k+7EcIVricIQ5VNOKh5dVOAemjBCE1kuSKrF+5BOQ==
X-Received: by 2002:a05:6a00:1883:b0:706:58ef:613 with SMTP id
 d2e1a72fcca58-719262066efmr3042407b3a.27.1726126778888; 
 Thu, 12 Sep 2024 00:39:38 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:38 -0700 (PDT)
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
Subject: [PATCH v2 05/48] hw/core: replace assert(0) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:38 -0700
Message-Id: <20240912073921.453203-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/core/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index fb81c1ed51b..1b5f44baeac 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -380,7 +380,7 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
         }
         lb_data.data = node->bandwidth;
     } else {
-        assert(0);
+        g_assert_not_reached();
     }
 
     g_array_append_val(hmat_lb->list, lb_data);
-- 
2.39.2


