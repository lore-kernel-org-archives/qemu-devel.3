Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3E0FDEE2B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxSR-0000i6-Ow; Thu, 23 Apr 2026 13:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSP-0000fR-FX
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSK-0005JC-Dt
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so5702784f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963791; x=1777568591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JYwWzQqSdbiTUNYH+gDTHqMgMIp3AmEiP06Alx9Rgc=;
 b=oewDSZeTM6cVSXORuG8mbK0k8KFlwFPxOR2peVgx7NQGt0xBhIUDyzwlatEBUkr+IE
 VvkfL/rs0FS910c66bRluFYmGVr9EBrHAd3IUMJjaY01C0XQlIAj5SPYueEvUazSR0cH
 QHK3S9W9alqWSa/qgcPbVVzkVM+hR7NIEpM/ajZj+H2J9m9ZTSrFulNpIVYeL1DFQL2Y
 HIfj1Bz2ilNKnfCEr7xv7sOi62++Xu6JrskWeaTO5Q8KRde7xxYSfCAiGY4YGnSc2S97
 essx+YOKR3ROpDcjN+rJuOV/9jQEC6PCM7NLyragh4SYaypmriC9t2Bz9opU9Cp2Yw2x
 a+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963791; x=1777568591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1JYwWzQqSdbiTUNYH+gDTHqMgMIp3AmEiP06Alx9Rgc=;
 b=bRU8O4DlFrPYm+M2N6RYT/23T8vVfKZ+Q/BO3DDY143yu5uTVJsoCv52CEoSn+ecUg
 hhAylvDPNrjp5BaVAVs5sEXxvZPzYctMVTTaofYS1FguZeIloW+H8Yc5RoIgJAFRRQ6s
 xSVePlsxOXkSZWbZUpWbCkiEYI9ykGeds9+fc6zBQov9tDxu7H+2C6mLstCCWHqf2Oqj
 z064SVW1R6Fw6yvE8Jo0mwuYiSSo/K9xPVrwwb5vCoZGZsVg2zLX54ojfWiVe8QnGzts
 4XuZUxpv6vbGN/5ZdhM19BbvXPdRIbE7bVz5aJY779bo/bKQ1Faw+YIcGkhnXsc4Eeto
 ehQA==
X-Gm-Message-State: AOJu0Yx7mmmlslIJ1tnfz0dKOu+Mi5xjhx/PxwFG4MVKiiTr9mVzuYSy
 sVbWVYcNqkQm3lYfi8ljrdMhhw+o8rf/dH0+GOk1ngOtSQMq3rWr8MddxUE3rDfocym1bREJYUj
 H1qfAn34=
X-Gm-Gg: AeBDieuk+1mOmWSUfIDVjUb7Owa69R5L9lYQcImE9CJqPbX/oVALK9mxrZe8OvpKtjz
 duN5cVwneUPvUWQvRl3gForxH6whTVNoDI7y7txwSfzN81h639Ie6fS2BLsVS6Keugh3jOC9na0
 Uqqz5AV83JXmV7uJslxVhTgm9UE2FPzc87M6ZDHXaHBKjsWqmnhiD6Ql5Zs2OMlsiisllQ3usuZ
 5mkhD+AloCGNFP9nAr0XQCNMSdtSjyJlqAt6H7CmExTw3L6qb1KM+zLB9wA5hKQwpAUisYY4JO7
 f0Tr3QLNHeqeSHAHSbEdHJaeCsbsDrTAuE1xhXKOKTwTIHSwA7ilcxFgOhPn/DuEuDjvgDiPPW9
 sehjt89isHWEMnvfym2jX97dEfN+9lFHuKuffz7yrGQtungxSCPycJxxzB1CNOtQ3LvrU9hp9C3
 10O4E2sWaE4oyyvH5nXb1+1s+vFzCRo3PTOLpCyl8Cvm3pynDBJ2P/1z8sLHPNQTnLOS3rJ+X7c
 3ZBklq2hwc=
X-Received: by 2002:a05:6000:25c4:b0:43b:8f56:1e1d with SMTP id
 ffacd0b85a97d-43fe3dc10demr43844816f8f.13.1776963790189; 
 Thu, 23 Apr 2026 10:03:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm51475613f8f.34.2026.04.23.10.03.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 05/16] hw/core/cpu: Expose CPUState::start_powered_off
 docstring
Date: Thu, 23 Apr 2026 19:02:17 +0200
Message-ID: <20260423170229.64655-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The comment about @start_powered_off is buried within the
CPUState structure. Hoist it to the structure docstring
comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e1f970caf..bc719d51b3a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -419,6 +419,7 @@ struct qemu_work_item;
  *   QOM parent.
  *   Under TCG this value is propagated to @tcg_cflags.
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
+ * @start_powered_off: Indicates whether the CPU starts in powered-off state.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_threads: Number of threads within this CPU core.
  * @thread: Host thread details, only live once @created is #true
@@ -502,7 +503,6 @@ struct CPUState {
     bool stop;
     bool stopped;
 
-    /* Should CPU start in powered-off state? */
     bool start_powered_off;
 
     bool unplug;
-- 
2.53.0


