Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B411EE645D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeRA-0003Kw-Kb; Thu, 12 Sep 2024 03:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQd-0001e7-Is
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:48 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQZ-0000Ci-DC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:46 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d50e865b7aso637947a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126782; x=1726731582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7GDoQxngJ1TTnmtNF1SclRiQsQ/Y8kkCXT3xVb7e1A=;
 b=FEUHm9ONbwAGZjL7VmVXykEcFCOGPnOCpcjC/FhNP8NYAd40+lVQyperEIquQOElZp
 7K8PNb/JyY58zxcTIkn3Xnc1R3ZLNu6SRFtQJRDDtrtb9E8CVHgzUsLsmJOsTgHyk6f4
 /Zbb4qgNWCHIc0X5pEheLA4Api4tExF5lAPzK2wG1B7HJkt4ngPdUGUw87Ga+ctj89Kq
 hVB4n71kB4LaOtWMVABJ+MFAMssbpNiJWfETEQYrUsFmPXnVjm9S/XmCh9g5z5h4PtLS
 KSVQ0FT5KWkWwWs3qs/+Di5aR+rupDFQ3ApuAxDgWZre2Ah66oq8q74H4glDqKl1GzGV
 l2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126782; x=1726731582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L7GDoQxngJ1TTnmtNF1SclRiQsQ/Y8kkCXT3xVb7e1A=;
 b=o7/5QD6FiBqWajxBMTJKoTrozm3rP1HSlKwY3AOaQIL2kmGUIJmxvlHKgWuKr0/VzX
 bKs2tn2X4NzYIPTFX+bxthE4bozD3rKS3la6Z1hqQyjFKpq160QZ0aSWNe4+9Ot/RWZU
 FEoQdQJuwhi5vA08prhk54mj2JE06umKrGZ/zh0Ke8t20hoxqLrRT6tdvVi/bCUNDv0n
 DypfoKgolsrda1/dERyN5q5hmcDOtGaAVDghuo47w7RvwcPZb/m5nCkkLrCwFpDj4/UR
 U2X9RL9D2IL8WYC72HOojUyQIpEFabme3zWeZ+K6hkSus77pTNdMAgdY8vtNH8aHW1Oc
 ehUQ==
X-Gm-Message-State: AOJu0YzRjwyw81tFtBug8xT16XGnsdlV6jRFI5vlY9KN/FMnpjTeG+X3
 /2xW9fMr2TwyDMuuEjDGrXYtxcifAesiPN00ew/oT81VuK9o0yMCM2a0BWK4/cjCLCk8KGIDvQ5
 aB9WF6XdM
X-Google-Smtp-Source: AGHT+IH3UrYHsROVRFhqbmUT73S4ww9ZnrBNKPSzdT/xlKGzi9rQl1GCamlShW6aVRW6SwwZUuf8fw==
X-Received: by 2002:a05:6a20:7b07:b0:1cf:d746:22d0 with SMTP id
 adf61e73a8af0-1cfd7463553mr949162637.1.1726126782141; 
 Thu, 12 Sep 2024 00:39:42 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:41 -0700 (PDT)
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
Subject: [PATCH v2 06/48] hw/net: replace assert(0) with g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:39 -0700
Message-Id: <20240912073921.453203-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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
 hw/net/i82596.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 6cc8292a65a..cd416a00ffa 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -282,7 +282,7 @@ static void command_loop(I82596State *s)
         case CmdDump:
         case CmdDiagnose:
             printf("FIXME Command %d !!\n", cmd & 7);
-            assert(0);
+            g_assert_not_reached();
         }
 
         /* update status */
-- 
2.39.2


