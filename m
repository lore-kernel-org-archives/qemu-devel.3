Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A89FDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4cv-0004Tw-Vg; Thu, 23 Apr 2026 20:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neotheuser@ymail.com>)
 id 1wG1sL-0004Oe-O7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:46:21 -0400
Received: from sonic302-3.consmr.mail.bf2.yahoo.com ([74.6.135.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neotheuser@ymail.com>)
 id 1wG1sI-0005fk-Bn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 17:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048;
 t=1776980773; bh=p7LbBei25EyTgYguVkdRiAaODdHuFPggdNi2ulFPuxg=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=O0qiagcAMc80K3iVLaf4vRWf6QS6NSQS0qywRcD+38kgNaMjDnwoHYvAYp0UkaAdvVefuegnp8s67dYgw0ydMZuxmJ3NET7H2ko66lwMVqTS6pRreXuQpbov5eEcBZbohW9v5rNkCAdRXfTm81Sd7oG3fcsNQuiTqmIlrWeBdyMip5l+U8Qf++4jSTHKiyOhMC4uy1bF7+JnBHlZGBDDGQslXHu+hzc+gfXmwFj54l2UuKN9HrMw4hroOkcjCGkVrOv2Ca1UfVy+v0anqL0Pnlk+rGCMHNdz2Kl9GOmQbBR6Pfo4Cs+vwDyAxh/qC7gYBG1FUdOhjJc4u0gtJdXtOg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1776980773; bh=wTo30pfIvHMPAeW+jzUjmtNs+GztZWCYhfdMzZ99IfJ=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=TEHe9o6GoSbdhqYhX4hWZxdWAJFzL6rpudE4wejUmBk4LVkn31Z8RFX0VMrGOfZGj+EehMr7JBMLZKW6yeO4Fkaa0ZkhSdgJAN/3jIEtp5qclqnPIesBf++6uCn6Tc9VKVmY7/a51R1KIDexexKl7Q071t9xTkln2sTq1+CdcJ7zLGmp5wVvASIuK24QNlKGOEV9Oety0UBIabWrJcPecNfIrpD0+41p4bqGoPTRasF7PmalfUAeP9vx3KN+h4PjyjcQFbxEL9e0wHwdODUsdsIvvL+NLmIZZxF+zZMORXy2s2senovbxnjxR9wAyDWGmAlxJZ4eihLX+qh5qcVfJw==
X-YMail-OSG: TQTvqiIVM1lubi86qVmXp0WFpEHzppuRnzhG7mQ6uDbMYfxXIZKLcIWyr41eJ7l
 k483SYhuCU_Dv.t_kT8OhKq3cJxugH0PbyxJNBGDTrvjaxLQpeb1t4l_OuyOgKMDhj5bJxFns6_7
 9YDJUx5ZS1RcRz1.yyDpkgBZHDNIFalGETmPWmwX5D9fHVnOseJdkk.xhOul_.xUaXbAKv0l982O
 pYRKtsrxiccztQmaLX0gRlRGOcKwU2RhGDXvq.B1zqOqMcc_VXx2sId7c_H5_DKcogudbqFW0uqo
 XX9cddaQsgXJIeCwUbg6eFtiUwrDvrG6OjGzQrVQtK_M.buk6QqFH9gjXhX_BoO.UMe131kaLSYq
 YG4QkJOkyfrPafvDiWMKp47fcyz0a7IYX6tRFR2eHuOWpEVLo0Q97Q1qWPJZZAn6nDAs72Dlt5eI
 Y5WWfi6Uw24F4y0iMI4OyhKCaZqKRuCCYKYoKeOpwAcejgPsic6m0vB8O_YzeDE_V3l7yu4EzR1I
 4PwSh94x9WxhAPR.mFYe2El.bl.HcwwvE5nEGbDbC7YAok8axzRNc1W6ZuKv7cXAbJrqD69xlpoH
 5CZzDOsC21fptEvMHhjeTHRKmdk.uXzSJtUmHZ_CD5UikFVhEbdoySMS5yVYHnnbQgt_.4ikfG3X
 DlSZ0J4XopYQFRr6OA42eKrujh2GTNf6djM9P1CSG0lAUhSrnqOrQjYEPtX_No7KPdrCIo4GJq0B
 FmlFEO.eJfmsgKFs_.Ypp3zmjOVq4zznDCQzoCOm3bh3cogmjUW0sNK_QfP74xwHoi0KZyLWpBnL
 EjvGrmbgGrpMmYf2.2oJQsTtWQxQxdS_V0kFjAmp4AG2YpRo9yIErHAjdCQvE.NWA0B7JvUzmEKc
 Wq11mkaIaGnlRM0OtebYAODG4X.DT8AxAFUHriJsORkemYv_7YPSAFhlLQ108SU4_ozQEEsXO85S
 oBpOREeVz2Tnx3HucLqHw9TSNK_XA6o0T54PIIXqUK1W.FQej8TMpsGlqCElu57xqciiBeCA4a48
 zPJPiwD8dcKf7ro0bRPJ_epuc0kEd2TpTlq0Tm1.paepF99HciFpyU_gUlN7H9gtr2wuqTergFhr
 EK.KruGpCDO.ZVpS8WFlvgnwTu.sPlqjlz7pmW18k0DlK7jK2k6SWVmWFuZ6KoUNLtnmh.o..VNI
 1yTVWnju6ylG7HYQC6wIuPSHKISlPEDaUEQDryeoIyHi8SqoF5MCHnd2E6hG7GlfCU6Dinz1hvSz
 b4czZa7CypW8p5GFMxvlZBM5.j1Oa7uNGyCjwyptpbp0pMTo3tKr0KDUjwOQ0bIPF6lGC_cVuHDR
 6ZAlDcNVRucYILuWtmYl45UZJ.zCKmg1.VUaVBWp.Yy7rmngsHyMM6XfC.vrDmYmmEGW4b7OX2D0
 Yw7umQd8DBIJnu1PyqGt4Iltu68LjQ9AWPMVp2PItihup07hkzPW_jzqcSVO9e7uSnGzidDvZKPo
 U8.O6nF82bMCXuRUKQ3paPbMPUiCLbALPTqcLzsRIqAI580uBrTST3h.XkJ8ff53ffz1Jsqfrl9C
 n2EEffDCKOcaWgjNSmJOt2XVTTKiSGtl.rRljqa3RCYOgt1gKaXkmSbaf8gKQklsiapqDw1DaB2R
 d7BjRZCrqHDybnJ7gqeiSDtqbjDIypHhbZLrKLkp0a2mQpVItgPcoDt2OlWBVK8fdCD8SX1z7.XK
 AFkSkoDdZYlE9TTBxNEQMEFiEkti5A4LLBmIXkmRQx0t7Zw7PZUQSi8piE7QkvVARNWplkmsgUc9
 TR811H5yTTkNB1ojzD7iysvu8rSkWPxwMrA4dIOOWbPP._w8kGZ76p1D0t4ehNOXk0xFXk.erBYG
 UDrKsD7T9iCaQuRd6CiZ5XBfsdJ07RcE8xL5jPEzF8o55zBQXwJG9Lw1Tlj9Vz8onsSbxLOylkPf
 bsRA5BcV0p_KZUkQIBA_E70LCGywBl7pWVJCE_erghmv8YqZWPs8DmDV1WXdcOlIwiKEWzODWCP8
 egFOygTUhjibsOd4WJu.Mer7nsukIeAyUKNqJXmEWsbz7_oY6nXBBnRR9816AbPsmGpBfiqjCLDx
 tpCQTwlEWXMsgmMeikGqN7Pnu4Prdyyjoq2_i7kQ5j15ofHh9BAJ7YxQqcmSw6WbCk6Cr7h75gZN
 nDQ28fMwj6CJS0oZJ8DCE_eigv9T0Kh.aadaaWtjcC3DIDirmeD1izTAQ9vtrSdBbI_ghtiLNJYB
 653GSEhm5vgc2Vtk1j1OYGxvVAlTU6Z8B
X-Sonic-MF: <neotheuser@ymail.com>
X-Sonic-ID: 9194a338-5b23-4e87-950f-ca31bdc63f1a
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.bf2.yahoo.com with HTTP; Thu, 23 Apr 2026 21:46:13 +0000
Date: Thu, 23 Apr 2026 21:45:33 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <1107055211.1670477.1776980733834@mail.yahoo.com>
Subject: [PATCH] raspi4b: Disable L2 cache
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1107055211.1670477.1776980733834.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.25559 YMailNovation
Received-SPF: pass client-ip=74.6.135.42; envelope-from=neotheuser@ymail.com;
 helo=sonic302-3.consmr.mail.bf2.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Apr 2026 20:42:33 -0400
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

From 8d72a46d3653a46422360e2f6c19b6747ca05abb Mon Sep 17 00:00:00 2001
From: Alec Ari <neotheuser@ymail.com>
Date: Thu, 23 Apr 2026 16:42:06 -0500
Subject: raspi4b: Disable L2 cache


Signed-off-by: Alec Ari <neotheuser@ymail.com>
---
hw/arm/raspi4b.c | 1 +
1 file changed, 1 insertion(+)


diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 3eeb8f4..9580711 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -68,6 +68,7 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
"brcm,bcm2711-rng200",
"brcm,bcm2711-thermal",
"brcm,bcm2711-genet-v5",
+ "brcm,bcm2711-l2-intc",
};

for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-- 
2.53.0


