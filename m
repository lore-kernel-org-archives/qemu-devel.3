Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78CEEE01EB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9Ap-0003Sj-3S; Tue, 10 Sep 2024 18:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9A4-0007d2-H1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so9A2-0006b3-3j
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:16:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-718d91eef2eso192990b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 15:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726006592; x=1726611392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5hvV7fm4k2lFXirrgZp/rTlQTvUf+N/hoDJJrlREps=;
 b=iV6Q2JwnHS0FwqsQgzbs2v5/xhDtAcmVUlh4UZTTgEtD4YYsezqkKrFLx3ZcUvMd5F
 ff6+rZg7VTFz8IigQ2a4gn5Xn2t2fN8thq2K8l1Kvn7DwZjkWPN0zV39tkGx3zepJcUi
 TO5hnztTkVRYO9oxVOl4PjZuhioTLcmDJyN2ulHNVlNhMQI3ZKIqvWUru0EGUHi52Yi+
 gzbNqj+QtyQa4swHPcMfstcyc3y2JSdf86ZMYyruMaxlObU6esSuqUOcFfEnwWlBgvXP
 iZvbyBTLREkuCMDU1mg8+ookrfk5TQxP76c5wuS4O8JACrUiUoFgeFjQGrQbTfPvVltq
 AG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726006592; x=1726611392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5hvV7fm4k2lFXirrgZp/rTlQTvUf+N/hoDJJrlREps=;
 b=JBu1Ln9Yo/8mKTq3rJDLMOcdECgQuXTjzU/h/Gdy7nar5w//e/3XT8PsioK2uWldBi
 tDW8naXpg7TunyciT/DMAxZOO21Sxi0rGqOCLNSe+8cmZsVwkIR5ZkJP0CpKP+VcE4Bl
 OenI4UtbVUZB9JcMAZVQ6TcPGRpPENUetZDOZVjC/c88PauKI9qODQZSpFVtGiGNJnLY
 Ifd0qJKwrIZMN98pEP39cdevA5NKDlKodjGGxj5Mpe343bNdQCMsY2Hub7b29rCctJ0x
 uxh8CV3+r8fOot3EZ8FHjaeSD3O+G+e3V+p+RF1xdUcwBstMjGBS2vzXYoFNYyimWpJM
 TJFg==
X-Gm-Message-State: AOJu0YxpV/dlLw0ydO9qTdgXiIK7eqrBGDWFNS0n0tVdeHy/prvJHtSj
 SdjiMfsoMHFNla7MzFVmHGEWTsFffVZpd3o7aFAsDqniCcXh8y159I658RgHB+o3aEIbmGeBx9j
 GV9JmyLzA
X-Google-Smtp-Source: AGHT+IHrtwn2gYefVYx/2/5eCHyu9r4kicYal1I+8TgQBE4ci3czTkRyYRsTQrsB0YAMlykwKK3uTQ==
X-Received: by 2002:a05:6a00:2d28:b0:704:151d:dcce with SMTP id
 d2e1a72fcca58-71907eb69b2mr7001325b3a.5.1726006591899; 
 Tue, 10 Sep 2024 15:16:31 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909003d0esm1884055b3a.93.2024.09.10.15.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:16:31 -0700 (PDT)
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
Subject: [PATCH 09/39] qobject: replace assert(0) with g_assert_not_reached()
Date: Tue, 10 Sep 2024 15:15:36 -0700
Message-Id: <20240910221606.1817478-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
 qobject/qlit.c | 2 +-
 qobject/qnum.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qobject/qlit.c b/qobject/qlit.c
index be8332136c2..a62865b6423 100644
--- a/qobject/qlit.c
+++ b/qobject/qlit.c
@@ -118,7 +118,7 @@ QObject *qobject_from_qlit(const QLitObject *qlit)
     case QTYPE_QBOOL:
         return QOBJECT(qbool_from_bool(qlit->value.qbool));
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 
     return NULL;
diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2bbeaedc7b4..2138b563a9f 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -85,7 +85,7 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
         return false;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return false;
 }
 
@@ -123,7 +123,7 @@ bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
         return false;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return false;
 }
 
@@ -156,7 +156,7 @@ double qnum_get_double(QNum *qn)
         return qn->u.dbl;
     }
 
-    assert(0);
+    g_assert_not_reached();
     return 0.0;
 }
 
@@ -172,7 +172,7 @@ char *qnum_to_string(QNum *qn)
         return g_strdup_printf("%.17g", qn->u.dbl);
     }
 
-    assert(0);
+    g_assert_not_reached();
     return NULL;
 }
 
-- 
2.39.2


