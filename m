Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1FAEE01ED
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9BT-0000Qb-I6; Tue, 10 Sep 2024 18:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Aj-0002pA-SD
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:17 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9Af-0006tG-Qj
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:17:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso3687796b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006632; x=1726611432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxBBj8XHDZxd3pwPDQhaFTyzR1JvVS6yl60rcPuU8DE=;
 b=a0WfztixjUb2tgipuxXU/m7hVMH/ZWJLtYr/AjNJsjbMc6kihdo5SROlvHVQ6NvZmr
 W+LruOHKAX1Qb3ewo9EZ8KtC7mEFJ7LKM2GkxD8n3+eoCVF/TFad5q1wFAEkJt4+qR0O
 kvyXsZVVLqRuA9ORhcfJNkxRIsvLJf0CddUEydQDEZtTlGyTB9Gh8WP3NEMlrCA3yRMa
 Au7LilWj+wZh1HiTYc+NVIck7elT6NHRO4B0AiwufODwUa4xlI56bfc7bV9YUfFpYSCF
 oBZU3Ef2lATmr+2K+0bFcJcmSNwMdiHQDiSWgymQlU/nMt3e66DlxYJ/EjRPyhGm8qzr
 QsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006632; x=1726611432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxBBj8XHDZxd3pwPDQhaFTyzR1JvVS6yl60rcPuU8DE=;
 b=DIYHudGcIMcMrjwBNnTQklZPf/KzbnaA6C5JZsWW1raj8yIPIhtAF6p6E6cNtcoJ3A
 wj8RwsUBYXfSuDGZ4zgTjrpT3gErtmBebCmMCDXZSrzsrjUffUsHj0u68lL7Td0ueqmD
 Y5aH9TahXojm+ZUe1+6/gOB87ipbPQ7hqD0Q+MiRZ5knvEIBhLym4wnDRbPra2FdpqRJ
 q7wJxHe/pbt76oTgnQpUF/XzbTh8V7e3Vr4XSBkcicSHw/75JLtyBsyS261HLPaM2pod
 yI605KWLR0owTnXMlAhFajzKkzKLQugaLvY67PKMwfixmhi3TpCk4VzUOoiYcZtCjDek
 2UXQ==
X-Gm-Message-State: AOJu0YwR5sOOSqZQEDzjzO0GlkK3WE9YCy60tuMbQBoi4xseah3j2+74
 xMuQgUMYhZn6VboXZsKCY1Kk3FHNnI+CJvZf+0Vm0DIpziHycC04PKlA7T0QkSReAfVmJDrdys2
 eOq2L8hiV
X-Google-Smtp-Source: AGHT+IEXiP34uTnzQwoBvPtoZRfRUyfMSCqJ2GA6SrTzN26OOJqSvbL/tMxUKioN4UZqgJtB4WHk9Q==
X-Received: by 2002:aa7:88c8:0:b0:714:2fd0:357a with SMTP id
 d2e1a72fcca58-718d5e20a52mr15181026b3a.11.1726006631633; 
 Tue, 10 Sep 2024 15:17:11 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:17:11 -0700 (PDT)
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
Subject: [PATCH 26/39] hw/acpi: remove break after g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:53 -0700
Message-Id: <20240910221606.1817478-27-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
 hw/acpi/aml-build.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 006c506a375..34e0ddbde87 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -535,7 +535,6 @@ void aml_append(Aml *parent_ctx, Aml *child)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
     build_append_array(parent_ctx->buf, buf);
     build_free_array(buf);
-- 
2.39.2


