Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CBECE8D4F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 04:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr94y-0002Ro-23; Thu, 19 Sep 2024 00:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94u-0002Fv-NY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sr94o-0007QT-8z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 00:47:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso288200b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 21:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726721252; x=1727326052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htcD0BwVI8E53kI5D4tk23OSCVl4GJymUerem5Vd+Nc=;
 b=EaEVxZ0HLuprq6O1npqaLYBKvyWVVjcPPKlZp1EZgi5Jnv+qr6bVNCr8n/gVWJVHoD
 YuvuOGAkKDSVzBBOfpXkT44uOxaZqW36cYkhgSjt/PenTgk7ofbinulF4r6Byvp3W9fR
 +83HCo+PKAd9oMyrvaeHWIAGysVuUWoMD5ufcj2frDkBMENRtxeN5tvGCN0yT0xg90El
 CNWkeMAxBZmz+aHxviCVB3FQrSGiDd41FEFEnehfFF+7H7p+xzSoi6hma5yl1ZcEcoi9
 BrevB3I07iC0r4zI4gZwRFzFr5p7BtmaI0JxzfrJ4HNoSKaqmCMnik2eWjyloTLj6frC
 6L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726721252; x=1727326052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htcD0BwVI8E53kI5D4tk23OSCVl4GJymUerem5Vd+Nc=;
 b=O9WpdEq2+W2x5d9fdz9gQfJ4FeYaTOaIebLEMFhmr3tZltjZ/m3IggEvZUmrScKzGC
 VJXTONT63c4lax7NW5B3u8aupLOLEpOeXVEUYv/8+EA18+1Sw8kqM/lYURBzZuCRlXzL
 JVJB68NUQSJKmzxR6vA+jJ6JVhApv8Od3fw9sir7AMaHgzEVHK2dsPH7jl3rFujFVSK5
 wtL5enXE6ro8QsivpqMdN1E99pvekX4vgRYE/kWcGQ6dEV6O2ozHtECwK6RWFc6DCobm
 d5FiDRpJHmm3ksyV4XT4jjz0uFVb2u3rPkFwhgkXXohq9BTK9/BuOrh7tXAJxFBOxtsO
 11YA==
X-Gm-Message-State: AOJu0Yz915xa/XJkl+S4uPHWYskvBd7V4R5aGUZYMjrmY7kNN0PhZxNe
 4MasqO5vsFQP6gbB6yJvk3DNx+wqa66dbFDpkyro29VVP+ObefCum39MKxX/k9vHYVn4odqwagX
 wlcu40g==
X-Google-Smtp-Source: AGHT+IG3VDWYQsL5o+dqVWGrfQofsayNLblIyTF0AVQE/kr+M4nxrlPbIJFiaP/P/b9fsRX/Gu2PzA==
X-Received: by 2002:a05:6a00:124f:b0:714:1e28:da95 with SMTP id
 d2e1a72fcca58-7192608198cmr37650198b3a.7.1726721251825; 
 Wed, 18 Sep 2024 21:47:31 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc279csm7478601b3a.188.2024.09.18.21.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 21:47:31 -0700 (PDT)
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
Subject: [PATCH v3 23/34] fpu: remove break after g_assert_not_reached()
Date: Wed, 18 Sep 2024 21:46:30 -0700
Message-Id: <20240919044641.386068-24-pierrick.bouvier@linaro.org>
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 fpu/softfloat-parts.c.inc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a44649f4f4a..cc6e06b9761 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1373,7 +1373,6 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             break;
         default:
             g_assert_not_reached();
-            break;
         }
         switch (b->cls) {
         case float_class_normal:
@@ -1386,7 +1385,6 @@ static FloatPartsN *partsN(minmax)(FloatPartsN *a, FloatPartsN *b,
             break;
         default:
             g_assert_not_reached();
-            break;
         }
     }
 
-- 
2.39.5


