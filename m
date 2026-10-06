Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD717CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENA0-0001f1-L8; Wed, 07 Oct 2026 04:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIEC-0002RR-LN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:22:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIDs-0003j4-HK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:21:46 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2e2db5e8e4so604791666b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791343244; x=1791948044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUBUYMm1004qLffoBCfnxHxkOtu1Deu7Cd7SJnpSF68=;
 b=XmqLrfcXsYOC4zoEDnj4lv8CTpjD/4LMc0my4WID9CoCzCErWV01XuuLz5DEv+kzcA
 O/sFOjWiIcV3N85iJwdIS05oTjYYWhjPWsVCrDBkIVNvQ6qxaQvpD9c4ZKUe6lqRO6QM
 iDVQ5KZn4C5uiC/8oDB2KhTwJV8vWjxV9xp0xuzGcx9naCUgGlEVWQ4vDwHXRi7Hcyog
 vbSTIXCZpJdtSDSlbHIO4hGyiFd029i2Sc5Gp/RFIloQIy0P2WvU0Zz/eM32VlAdO47o
 hCmpxacyGjxOOsb0BXER2116U1JJg0a/B04UBsYnOd6VejnDfgjlKqWRLU+stxV6fIrS
 Kthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791343244; x=1791948044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUBUYMm1004qLffoBCfnxHxkOtu1Deu7Cd7SJnpSF68=;
 b=Ak8ksNfeZHaUyqVlSUY3vmXMMyMa0nloRW/YPG1Z+2ES7swthIESelL8nLExbDnzVv
 F1J8vktMDcl94nCkoM213n0pGiEtG2JvBJIxU1sWJEdgrhInXz/6m+Zem6SIgtDXxFvI
 i0ofwrG4fBz+Nihxr1CWLoZvlMouNO//jyN4kHKlAHsYTu7/3Rw153jOA2TlOR7/yL5O
 6yO3nUuRVL7ghH6O5myR8cAOQzsY8mCXo8l0HRD0kyVVeu+ukW9znuVOLW3H6qRlrk11
 hq7BbwgzGzhm2TnJtKvovIuy1JEoR5wjeHeVVTU8xdWxRzbX4y4vkJ37pxmW6FP3z/qU
 enAg==
X-Gm-Message-State: AFuF++n77GujeMx1gYlZhyXEJr2hhesYmWczdDVENabdPud2ZvnyQN9V
 Xoop8f190WZ361kAonIiEqZt8M0VhvOqfY6P0ca04M9PnGz2MQQs1WSJIGGd+w==
X-Gm-Gg: AYBFou1II+9Csb2HCpgnJ4U3wtsRJP4bokxkRIChrwBYqxGm4bzDOYjMt3etyutk39p
 uVd7IgfXP6BgIHDfobO6gPo5/eq+Er2EVTqmE6VWNSXBpK4uhox//1oYFLlUrGCKRzjlRCyJxpO
 AdHUhoNi1+SlX7m08u9QGHs4rvcQMpDFxm7sawoFvCow+iQWZTW354gxu2KIAi8sMb0C22dRfOJ
 fM9bKzrpNyJyhCBGg3F7/ExizpUeunezl2dMVGQI5Kga0b9vXcIyqvBNHmkOEv6koZ4G+kx2rlw
 amZE+9D3I7+KDjZ2rKXAmGSXNlzNmOOYlqmJLIkXLJbGuycoxVNg9XEF7tRjdMdSTdC4VXeQetn
 ZKpMmjhPJnMUBBan0tuzMoFHTDDvTgxCKQSFwSKCk5bw1wowz4rTk8KXJcFnY4hR0jnWAEkr9TC
 XW8WdneX4r88qErSAcocFdMH9essCad9k8uRmUNzUe0v+l0Jn8y10k8uE3PQsPP6kPrb5GbM99R
 7YVYUTPAPU41wokjiR+NQAYjbpNnQe83E9Vxg==
X-Received: by 2002:a05:6000:2610:b0:488:5852:6ee3 with SMTP id
 ffacd0b85a97d-48c47fe7a12mr16297550f8f.34.1791275725864; 
 Tue, 06 Oct 2026 01:35:25 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:25 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 05/31] hw/arm/imx8mm-evk: Fix reference count of SoC object
Date: Tue,  6 Oct 2026 10:34:17 +0200
Message-ID: <20261006083445.30362-6-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Using sysbus_realize_and_unref() requires object_new() rather than
object_new_with_props(), otherwise the initial reference count is
subtracted twice, i.e. ends up being one too low.

Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit)
board")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/imx8mm-evk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index c3215b11cb..6de0d9c4a2 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -83,8 +83,8 @@ static void imx8mm_evk_init(MachineState *machine)
     ims->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     ims->bootinfo.modify_dtb = imx8mm_evk_modify_dtb;
 
-    s = FSL_IMX8MM(object_new_with_props(TYPE_FSL_IMX8MM, OBJECT(machine),
-                                         "soc", &error_fatal, NULL));
+    s = FSL_IMX8MM(object_new(TYPE_FSL_IMX8MM));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-- 
2.56.0


