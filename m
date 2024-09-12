Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39696EED617
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somQa-0000zs-VY; Thu, 12 Sep 2024 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQZ-0000ou-1s
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:15 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQV-0007TC-IF
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:14 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d88690837eso964923a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726157530; x=1726762330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BppHFYoQrx4qC3DO9Sb1ugevP84fPlKPBSZdTDngGiU=;
 b=NYxM+ZNe1LWd1ZWDPQSCuNtUtcVipevVUwUpDd9l/HofKvRGu3pPziBJbVD1tcp+9k
 1s4D7IHxiMLkMPXBja1NHxM0y63ftWx5XPjNBxkoUJAOzRxYgoRSpbXOLp/1GQtc97bN
 Sw9WL9PLmbg/mAln3+yWzD+JZTqM/NbTF2jWylTCR+mTtwWSvk6E/P4fVl2C4XPxY/TU
 kyHXatDgGpt5UcgYlT8uDXyYdX9KkEXNP3wjBOYpCNe3sjNta4K+ci1Z6hHtaCZ7AsMn
 k8uaIa2L6RKfl/Az8UisJCliF5T00rxpHrVAg+7kMkhMWhElKN5HhqKZ27+zLdO9sHWe
 d/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157530; x=1726762330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BppHFYoQrx4qC3DO9Sb1ugevP84fPlKPBSZdTDngGiU=;
 b=pwDCjbEEMZh5k53/9UFXsD/rlUoyZekubq5TZ/HUCSAFbv01Su85Xl+xtPT7Agr1ry
 Cnl21LYPR0E1aYQoWm9lHIIqt5ygnzb3qxAhsxceDpwviF/NVpJ9488BRWGTOBnKuDPw
 debrmXb5qLHedrUZyMLB8R5npwE/EgHKXW2+zGKBNuxphMUJJSxAv/kZfoeuoDR1m7Uq
 r0n/GZUU/CGwAVptkRtjNmQyDW74o+3AOImcjexCLpH/MbLgYn72zqXzvOQUUxlIKm+s
 Q+mR4em4A5UUMl70vjkcF614zQCoVdm/9VoSfi9u8ShxBSLX4rMr/8KHgzenhNCHblSk
 ZP3g==
X-Gm-Message-State: AOJu0YzugMnRIZ9BW4RUy+SvnEb+jt61+HuiqSmlfAMbjcnMdrKHrGNE
 8GUYzvACH1uOm7Aqw1i3Enazvl6mZf8akgQLiDwYoF6YEjovZ04mCiZ/LLSeWtxDuVPONa0APoC
 dTTjGFiW5
X-Google-Smtp-Source: AGHT+IFXZnFHApOhxp7HbQT8QxnSQy+ag97AShW2GHgmcSAhB2K9e6P9OwzQbkNk0mR6Kpm6KHVR+g==
X-Received: by 2002:a17:90b:4b48:b0:2d1:bf4b:4a6d with SMTP id
 98e67ed59e1d1-2db9ffa1590mr3873451a91.1.1726157529892; 
 Thu, 12 Sep 2024 09:12:09 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db0419aab4sm10868139a91.15.2024.09.12.09.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 09:12:09 -0700 (PDT)
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
Subject: [PATCH v2 46/48] qom: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 09:11:48 -0700
Message-Id: <20240912161150.483515-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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
 qom/object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 157a45c5f8b..28c5b66eab5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2079,7 +2079,6 @@ const char *object_get_canonical_path_component(const Object *obj)
 
     /* obj had a parent but was not a child, should never happen */
     g_assert_not_reached();
-    return NULL;
 }
 
 char *object_get_canonical_path(const Object *obj)
-- 
2.39.2


