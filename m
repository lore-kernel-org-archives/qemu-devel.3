Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE8EC145E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxQuh-0001WW-AZ; Tue, 03 Mar 2026 09:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuX-0001Rk-FP; Tue, 03 Mar 2026 09:39:45 -0500
Received: from out203-205-221-153.mail.qq.com ([203.205.221.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <1486344514@qq.com>)
 id 1vxQuO-00025d-0z; Tue, 03 Mar 2026 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1772548764; bh=4s6GhIz/LSpZIO/hl6zrWpB0pLOj22cJ8alqObYUCYE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oECznp9DgI7Y32HIvaCPO2pUWM/tjeF584efykBqOWiGzOiICtdE5eOHEZBic0NTe
 3/ULg+gVvh6m4rweVyBYsYeuC7IJDLq3CK4fH1+nPElxYlgzjuQ3QM2eSHDwdwzB0+
 AsFUnjQRBJB2J3jQUJxTPziQgnX7oojN3VxrLxt4=
Received: from archlinux ([180.154.0.12])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id 7F901C7D; Tue, 03 Mar 2026 22:31:57 +0800
X-QQ-mid: xmsmtpt1772548319twfy3fuzl
Message-ID: <tencent_AEAA700C0455D77E3FEC6487B62AD68A5108@qq.com>
X-QQ-XMAILINFO: NXhC3iKcc9GRKPcWaPK1oUbBKYfATGRD9jbs4Kx9OgwGhzS8A3U2M1TIHPGr2D
 UyDLem6g9EwFimTfh6KVCZBNcME+aHcaErVze9+2KzU9nWNjYrHPbit/deOB5IzNPdmgeSepgev0
 FujB2hMQl25mV7jnpZ/4opvU0D+NHZlC2UWBe7zb1xtVmPqE/hXvSDfB/N3h+fITjjuw1oJA4YtC
 HtF38UL9WAJKZQZDDi0K1e/BnhMtDgttH/SzCv2SbyXdVz4gvB2SwT8v6yyrQOPm/FEPXZ7Dzy/g
 +qGVQ3yJoGl9JXeliSr67JZtIGn7E7viK9Qybt+2ZkUDoqZ/lI8Ng1WpqYF/R03WN1yT7+r7yYcU
 6hcWC6LdoGA+W72dz+zPSmNSJC5Bl40vRm3NKeZRJu9513tTgFWPgeosvB8CtiKpiFvHcIskJD9o
 anxQl7a/TjgAgjfzEK6CnlL+bSjQsUHshIlNjLtAc/t6bLgtUD2O27mionAv560jk7AYC5sZnTPG
 RkA+CSP13YFmqMfJasITlT5PqD/pYgH/IfdSfQO6kmFB7L3itt3zX97KuAYyZfM29RFvnrHpkCCE
 MaJBBDTr114NUl/469axT0lXPb4OJTR3tlRMMBABZanRrXRNaoaAH8DhcV3AoZrbr213Go2Oj5m1
 AghbmIYcGDJ9p8wHEPKttbvxVcwKcTEFr/P1o71REcs044nAyUV98eN15R+kA88NUP8/KVxQt/WP
 WMQ+VsvYNeMWiuKEgEDGm9Hbg6oItC31f/oaoBf48DeDo+H0UsSh6x4toMFSi++PKL4eTDaTINBh
 aGy7L2YL4b5giRnoV6uazrR/p9y78xH5fhv0V8YX61FvT3osxdu9xmLkY/PrVLTiinBnhbapWPhs
 EyE4xRMg1vHrT36xRzIcbAjjGRyJ97kvJBXm9H4NA763gqoAZPV/TbWo33VB9s45+DQPpVQn4okh
 8QzRkKsbRI8EjOnNUPS4Hkle5+r7rtO/3PVmzAh9eFp+pVYtDpeOGqJ8hQcyg3rGMNpQWDEtq8RW
 DAg6wXz6XwkEtnd22Z3rOxMwPsnvvQJB0Ju+mCQ+FerMEx4qtTkQKOb7aKCYncfTF6h0m9og==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yucai Liu <1486344514@qq.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, jcd@tribudubois.net,
 pbonzini@redhat.com
Subject: [PATCH v2 2/3] hw/display: Build i.MX6UL LCDIF via its own config
 symbol
Date: Tue,  3 Mar 2026 22:31:55 +0800
X-OQ-MSGID: <20260303143157.80437-3-1486344514@qq.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143157.80437-1-1486344514@qq.com>
References: <20260303143157.80437-1-1486344514@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.205.221.153; envelope-from=1486344514@qq.com;
 helo=out203-205-221-153.mail.qq.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HELO_STATIC_HOST=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce CONFIG_IMX6UL_LCDIF in hw/display/Kconfig and compile\nthe device from hw/display/meson.build.\n\nStop compiling the LCDIF source from hw/arm/meson.build so the\ndisplay device follows the standard per-device symbol pattern.

Signed-off-by: Yucai Liu <1486344514@qq.com>
---
 hw/arm/meson.build     | 4 +++-
 hw/display/Kconfig     | 4 ++++
 hw/display/meson.build | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 47cdc51d13..59ef60946b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -87,7 +87,9 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true: files('fsl-imx8mp.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_ss.add(when: 'CONFIG_ARM_SMMUV3_ACCEL', if_true: files('smmuv3-accel.c'))
-arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
+arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL',
+                  if_true: files('fsl-imx6ul.c',
+                                 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1e95ab28ef..b3593fe981 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -25,6 +25,10 @@ config PL110
     bool
     select FRAMEBUFFER
 
+config IMX6UL_LCDIF
+    bool
+    select FRAMEBUFFER
+
 config SII9022
     bool
     depends on I2C
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 90e6c041bd..9b0b1ddf63 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -11,6 +11,7 @@ system_ss.add(when: ['CONFIG_VGA_CIRRUS', 'CONFIG_VGA_ISA'], if_true: files('cir
 system_ss.add(when: 'CONFIG_G364FB', if_true: files('g364fb.c'))
 system_ss.add(when: 'CONFIG_JAZZ_LED', if_true: files('jazz_led.c'))
 system_ss.add(when: 'CONFIG_PL110', if_true: files('pl110.c'))
+system_ss.add(when: 'CONFIG_IMX6UL_LCDIF', if_true: files('imx6ul_lcdif.c'))
 system_ss.add(when: 'CONFIG_SII9022', if_true: files('sii9022.c'))
 system_ss.add(when: 'CONFIG_SSD0303', if_true: files('ssd0303.c'))
 system_ss.add(when: 'CONFIG_SSD0323', if_true: files('ssd0323.c'))
-- 
2.53.0


