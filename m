Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F216C5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfds-0008Ds-7A; Wed, 19 Aug 2026 08:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOH-0004cj-HP; Wed, 19 Aug 2026 08:27:33 -0400
Received: from outbound.soverin.net ([2a10:de80:1:4092:b9e9:2292:0:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <opensource@fvhovell.nl>)
 id 1wwfOE-0003Ac-ED; Wed, 19 Aug 2026 08:27:33 -0400
Received: from smtp.freedom.nl (unknown [10.10.4.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by outbound.soverin.net (Postfix) with ESMTPS id 4hQ5Rz1pd4z1yY0;
 Wed, 19 Aug 2026 12:27:27 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl
 (Postfix) with ESMTPSA id 4hQ5Ry0KLsz40; 
 Wed, 19 Aug 2026 12:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=fvhovell.nl;
 s=soverin; t=1787142447;
 bh=10EQ17zKmqOuyw1lqd3ROatsVrfnpqopHxdMwTJ4i0A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fUtJvwOYH+zEYa4QrLRKpHli3kCUarHEx2RaeSBDisofZVzHKhTdT7KBJv/9UVCgk
 vKA6OJ0Ba/AZPMjqTEG028CvWAPDmmlDkx+QO2IkWFKyVd4SmoVGk+6i2+MIbPMJAq
 /RSbp/SZlHVk9e8+CWkOcl52LMqX2v/64+iG2eXa6pX4u7nGH5XumBNieKeKT7nxeJ
 9/PlljU2E99E3b1XAUwcWsir6p3hmf1j4RSsJaaSQHAtXGeTVuA+DLDfU2gzXx0yUi
 RqseuUQWoSHxdxLbqFioWES0QlYlhq3X2mHPynT3ktRoHOUj1TNNJLXEdoT4heH6H/
 pZfQFjZK8bzsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fvhovell.nl; s=soverin1;
 t=1787142447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOxko42FwzNrWnp98S7fFjV2Mtjg8Ijo2ZXdxnBCaOs=;
 b=U9bmtwuSGlz1oDXnuheu/VPNpwwlGNX2TqguVoQ4mBxcAZW35cRNlezufIByMGjvWmmZp9
 yhlNsSl4aiSx2UbIQoeHdNrCXeCMc0xfc3WdC10xEcnwq46p/D4uQp4xNeOJxG8QqZguDE
 fQOKIh+r23zIV4Hat66PLAoQQJ2gskcci/67EizJ8S3XJ8Qp7yVVwflb9obGXtqQdytKXX
 hvpeW/l5ZLiT3y3EZNr++y5y6YXjnd8rI7KSfRPIaKJt/z3qhk4xaLeBxZELJ8xULMsr8h
 VMv4k5XRU+R2IduVTv+z0GnOv4glnIyPqNxZSfBqCb4ZRBpwB+uFiVIpaLMY7w==
X-CM-Envelope: MS4xfE723QWRCKY6uc5u+rPv9wBTPOglQWor71PXGBu2wAxYbR5ADYeOLHT1LWLbEwfhWn6amtkHJFlteuDMdlgQww2dPpMvAHlOOfX63imgr+mK0s7d11w9
 2WslY9UX9jSXQG0om55oncPSZs+2h6Qo0WwSfcHE30sJ7vF8GCOVK+FZw7wh4cnteVkyOnAknRtSK17gWVyzuTT4+jzCfZ4unwmqcveLDtY66wtrxmFlDtvw
 4xCYOiipfCAYxyFH+O/CcmDb3ab9EX4uiM9KKT5NM3O3hbv1PY28V9brPdCTBG66msv2jB72Mp6PJAcFzzcKgr4JjP0N54CFbQrNCGNF4APcyF79gkhYFNUT
 /x2c3mqOhdkSi5NdNXdEKGwwVyjjELvAWeZV5bSadn2AuYr56NM=
X-Soverin-Id: 01a019fd-9f98-7118-a8eb-2c5918e87969
From: opensource@fvhovell.nl
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>
Subject: [PATCH 2/4] hw/misc/bcm2835_property: fix
 RPI_FWREQ_GET_FIRMWARE_REVISION response
Date: Wed, 19 Aug 2026 14:27:00 +0200
Message-ID: <20260819122702.54173-3-opensource@fvhovell.nl>
In-Reply-To: <20260819122702.54173-1-opensource@fvhovell.nl>
References: <20260819122702.54173-1-opensource@fvhovell.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spampanel-Class: ham
Received-SPF: pass client-ip=2a10:de80:1:4092:b9e9:2292:0:1;
 envelope-from=opensource@fvhovell.nl; helo=outbound.soverin.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

From: Frederik van Hövell <frederik@fvhovell.nl>

The returned value for revision is interpreted as an unix epoch timestamp after year 2000 by EDK2 for RPi3/4 boards.
EDK2 firmware uses the revision to show as human-readable 'year.month', and asserted to have year between 2000 and 2255 (both inclusive).

See [PlatformSmbiosDxe.c](https://github.com/tianocore/edk2-platforms/blob/master/Platform/RaspberryPi/Drivers/PlatformSmbiosDxe/PlatformSmbiosDxe.c#L763).

Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
---
 hw/misc/bcm2835_property.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index a90c7e6c863..a705e44b1fe 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -52,7 +52,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case RPI_FWREQ_PROPERTY_END:
             break;
         case RPI_FWREQ_GET_FIRMWARE_REVISION:
-            stl_le_phys(&s->dma_as, value + 12, 346337);
+            // Use timestamp of first released Raspberry Pi as minimum 'revision': 2012-02-29T00:00:00.000Z
+            stl_le_phys(&s->dma_as, value + 12, 1330473600);
             resplen = 4;
             break;
         case RPI_FWREQ_GET_BOARD_MODEL:
-- 
2.55.0


