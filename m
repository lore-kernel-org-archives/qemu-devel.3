Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A74EED61E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somQX-0000fq-Fj; Thu, 12 Sep 2024 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQU-0000OH-UG
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:10 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQS-0007Rl-KD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2db89fb53f9so812249a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726157527; x=1726762327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qewOobu1vObZbuzJ+iuWYysDqS1YnBarNPQM9eHAdiY=;
 b=b2mbY4/lvd8nQhUsvPSDV2BdbE2nYtPINuzKz9JeMt7+YEtM32gLH2fYfBeUksgubD
 RnGKpIBVcsJZlrW6d/0YVm0GXrp0b7IujPRaeMNxonM+bqIdOYPqjIebffZz+mrilPYn
 Jd/5g4x0+1yp3/IQ+5IhlKeufNG9fpBBLSwjG/UEqJNJRfkIXuafnEpvNRjY0b9NDeur
 il4HsBFybko+8A6B6cealurtyEhs/AuQ8GYtgCI8pzAoORYANg1RYYkJAhRAxkRv0u3i
 jH0Jfd1c8Qn2xsw5N6FWSf6zlD1YHUe9zaNkoqg+R3vw8BRmZxsHrdW8nC5n1QW9k0E4
 h5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157527; x=1726762327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qewOobu1vObZbuzJ+iuWYysDqS1YnBarNPQM9eHAdiY=;
 b=ldpr7eH5E3X88zItqFwA3oGLIdl4qH/y6wOxumxcDgLDPRcNZLicTTEZEeCnImztsp
 QDSyLLB6aKMID8iBr/37izSi1A+6S1LV+7jo7pgZcqYprL7kTck3TW/98jvrhAJ2wQY+
 zMY1lMlfE/wWusNvP0lfgi7AvJKHUkCEBQD9GFZey9OXzR8lOLqAnkMoX/c488AuAZNt
 VwuvlZr5BuWWyv2/Re20XHaysmNaVAqF9PKdWj15UOCDvqa4t+OIeY59nB16b8Xriwns
 PCfawvUeZv/bmMGeDhA2Ww7yowLlHSOlrirgG9EBFWE4oJ9RANiXTuTU8sJgshle8mBr
 5yMg==
X-Gm-Message-State: AOJu0YyElEnRqCfcBgOzaig47w79vUke2cSIEetQd5j2Y408xdetiYGP
 VX4eDa37TCdq6Mt7RXV2zTW+U8DIuJArNk3I1fxco+Kl1T/xmOexZ2m0c21Hj7Lvh5Yc4MUC9wc
 3J6iCKcUn
X-Google-Smtp-Source: AGHT+IGfJHrcD4FeIRzLtjG1yF8QBxXB5+wVdXyMPyemp6yKvRgw1X8BWW7xKjm04CE0VvSJxj+cTg==
X-Received: by 2002:a17:90a:2f64:b0:2d3:ce76:4af2 with SMTP id
 98e67ed59e1d1-2db9ffee48amr3456585a91.18.1726157526967; 
 Thu, 12 Sep 2024 09:12:06 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db0419aab4sm10868139a91.15.2024.09.12.09.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 09:12:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Weiwei Li <liwei1518@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-s390x@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>, qemu-riscv@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Jesper Devantier <foss@defmacro.it>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, WANG Xuerui <git@xen0n.name>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 45/48] qobject: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 09:11:47 -0700
Message-Id: <20240912161150.483515-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qobject/qnum.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/qobject/qnum.c b/qobject/qnum.c
index 2138b563a9f..dd8ea495655 100644
--- a/qobject/qnum.c
+++ b/qobject/qnum.c
@@ -86,7 +86,6 @@ bool qnum_get_try_int(const QNum *qn, int64_t *val)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 /**
@@ -124,7 +123,6 @@ bool qnum_get_try_uint(const QNum *qn, uint64_t *val)
     }
 
     g_assert_not_reached();
-    return false;
 }
 
 /**
@@ -157,7 +155,6 @@ double qnum_get_double(QNum *qn)
     }
 
     g_assert_not_reached();
-    return 0.0;
 }
 
 char *qnum_to_string(QNum *qn)
@@ -173,7 +170,6 @@ char *qnum_to_string(QNum *qn)
     }
 
     g_assert_not_reached();
-    return NULL;
 }
 
 /**
-- 
2.39.2


