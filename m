Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B3DFDEE27
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxT7-0001LQ-6x; Thu, 23 Apr 2026 13:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSd-00010n-SA
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSY-0005RQ-TH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so88621845e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963805; x=1777568605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1NXswT2g4EmWOQS8rfES2kgf/hXgcwodQ+5qwGBtok=;
 b=F8Xkbu1U4nNVUGh1aKDlKOn2Qqz5jOtlaLXk+JVIhL2fRLa5y2Mr4+Ft4Scm0pgkht
 62skfHF6D/mg6YDSFfgNgVJAqMyfx8dly9D6gB23md20t+95ezfWT0tgsdXvaF/Nj575
 ttROP3TzAsWEArFw7UOvfHrCB4RTrQZ8KdV3SSZYT9xF3ui5O0dXRfYH1q9OGv6q3Gfd
 N5XYRJC72LzyJwPoCp0ao+c3aQYJzZE8W+j3II1eAh/Q6gyUzfH5yVAQF5GVjQXOKuvW
 gH2b1OOCVfecd5U4zmGufowjGx1qA4cBcKQBDQ20+Wiok7zf/Y08r/26F1vfFXqYrr5e
 M4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963805; x=1777568605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1NXswT2g4EmWOQS8rfES2kgf/hXgcwodQ+5qwGBtok=;
 b=Z6lYqyoR2DuiCfwgK8y+lxQ1txndddzjpzkO7KC6yPen5V6Hsie6Gy8PJ/MtCwUKuu
 /lCM2xsxNj+56qN2ruFoLGReXmx5tYfix1lEf62hyg/I3QiLqbRy7/4uw8DagrmXElga
 BeHYl93jideRN5aIm9joFlm0UX/S4ljUyINKccNM1UPm1UsRZAyYO13W9SRmTFLDxHjq
 rJnmeK94LJEpeLdO9uptCIC6WuXmmVQX2mPumsRW15DzHfwdCDWnD/UYcmNo0F0mmGVV
 3qu7fTQVaVXkf07/Pi0d97NbL+3Ijs1a7d/aCQbKp21aPUBGZEZsjb8Ktq3r+bVDNvRn
 JDYQ==
X-Gm-Message-State: AOJu0YzBG75KHMH2BNZZvpz51iFUqbf68k1XPz2VZS0jaPBhflfvVrsT
 G+3Vnx4D1ztp5w/aksek7Pn8WrGUEEjmytx4HqyukmHbqhd4+kVmnZj05nYhKHDb7/LnOb1W5cw
 6+oaR/24=
X-Gm-Gg: AeBDieuuvxIMkrt25II7qDq9b0fehwtxDQlwQO7eJREHNBasy3U4e3977HvBrdVfW9L
 +c4+RBCh9Jey8qJXczZWBWmrt0LtA8DpD31HEkqOlUFdRAelv2yqY6hsb2/bKTv+M9GfQPtaafs
 cJ75zvH26fNCtsMpIf1tV+AupY0KHiufcN2XhLmpTEg0O6P54aBqgRa0fINsL4aTtRcJYDjV67Y
 4JNn+N4VsBYhidzmIT2DNbDNQde4r8dl4WhFyuuHHME8EdwLbk3QyUDFz/T8DVa2gTUFPbi48qE
 xS0qnt7QcHVcFlG1Dc0CnVONVDSQhUTdC63lsvzZjEBfvaiR6poqMklwxXJc2CYo3pjMPWFZFkr
 /Y8walShIoKD9mLayHpLxly7IJ1hwb862Z5uzJkmkHuBP2FebrDmj67KPLR9aQ+lIvOOC347cP4
 WyG64wk+RLhWq37VMBdjSUMMpqDJpx80x68Piru2KSS/ZecraiabzjaP0VMau2Ck0Xcvef2SBBf
 0cRQnfdB0A=
X-Received: by 2002:a05:600c:6297:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488fb77155dmr372134825e9.17.1776963805093; 
 Thu, 23 Apr 2026 10:03:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm556148625e9.10.2026.04.23.10.03.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/16] system/cpu: Reset vCPU %exception_index before resuming
 it
Date: Thu, 23 Apr 2026 19:02:19 +0200
Message-ID: <20260423170229.64655-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/cpus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/cpus.c b/system/cpus.c
index bded87feb1c..b4c7f94332d 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -621,6 +621,7 @@ void cpu_pause(CPUState *cpu)
 
 void cpu_resume(CPUState *cpu)
 {
+    cpu->exception_index = -1;
     cpu->stop = false;
     cpu->stopped = false;
     qemu_cpu_kick(cpu);
-- 
2.53.0


