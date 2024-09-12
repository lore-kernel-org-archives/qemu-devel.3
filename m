Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2DBEE6458
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeQk-00027F-Ah; Thu, 12 Sep 2024 03:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQT-00018K-8A
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:39 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQQ-00007L-Uj
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71798661a52so478409b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126771; x=1726731571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKzkwMvjulowmVZuCJWvk+8fDxucMHovajiMFoHCRQg=;
 b=EKvW9PIs9nyFZYiTEPQXjmkqYiHrDUzKCsFAK5Lm/XYb7wX0JJCx5N0Q3nXWjkDUYd
 HWibWnQKt+gDyOR8zW5X4CvflppdDoobmUMC6CSruRtGdnzeW+1QAwH3nQgIgFza0u05
 HlLiALb2hNcZ2uoz3swkA/m33ssM6ZSGb+QS0rCzmDnF2wYwtRnVCPBLVodDO9oNvMEQ
 /N9PHEavC9SVdf7G4wHTUMNCpCRpLrLLnaihLAO4233ZJDX99DhYBBr6DhUyIW3NlBLP
 3kM2VtVkR6w3LfjDbXIqsJLlemyhKccIS4kJR8F3dYtleLcJgPuRlY+ryx77zy+Cgjyq
 GpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126771; x=1726731571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKzkwMvjulowmVZuCJWvk+8fDxucMHovajiMFoHCRQg=;
 b=qfqZ7Q7GFtqSjSNdCpZWDkvLTHZ00aSkzwxmnpNKlbQbuOnj5xeqK+LAJ8IyylxCDg
 8uZMm+YFn1CAOpcF2naTEfcc+u4C5J+M/Dh0nNTRm7tGToI5cq8HZ58XhKUDJg+tdigH
 dt+r/5UirL76qMN3EvQBn+LbWvDI3YOMGO9r/WC5NT2Xt6gB15soHwxnn+kJLMkWgyxk
 eiw+Ofb2rRGp+YQ0H8SqMIjcE7FgSnuaO+RyxJQa3Koy6qrK4RUg91IkixCi7YZA7yPT
 uRYURHk9F2U70cax0cEbgIM/MxrhMzXPUlNi1uiu6jpJIpSwkK80pfhg78CI5h/sRjXC
 V2aQ==
X-Gm-Message-State: AOJu0Yw9o0pfYNNR6SUIcNL7QVbFEm0SuCR43UnINZIH+ChMvWWbpy7l
 7dSmaR1pMuqpibmToMxhcU6XGygvb5q0lth6/j2Yh8fBkDsfhSCN5ym//OxpHnnxg0MEuid7vC+
 ryZk4y+pd
X-Google-Smtp-Source: AGHT+IFV73zYW1Waxu/aZZ0kavyu0j3iUea6gq5xe8cf1PrugnTCL4VeCsbqhbUloiuceag0jwjTVg==
X-Received: by 2002:a05:6a00:1803:b0:717:9743:e4fb with SMTP id
 d2e1a72fcca58-71926456829mr2983283b3a.14.1726126771431; 
 Thu, 12 Sep 2024 00:39:31 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:30 -0700 (PDT)
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
Subject: [PATCH v2 02/48] hw/acpi: replace assert(0) with
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:35 -0700
Message-Id: <20240912073921.453203-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
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
 hw/acpi/aml-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe3..006c506a375 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -534,7 +534,7 @@ void aml_append(Aml *parent_ctx, Aml *child)
     case AML_NO_OPCODE:
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
         break;
     }
     build_append_array(parent_ctx->buf, buf);
-- 
2.39.2


