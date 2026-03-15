Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6135D58B11
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 07:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1far-0001nL-NZ; Sun, 15 Mar 2026 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fap-0001m6-IW
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w1fan-0000eE-Nz
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 03:08:55 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35b905a05a8so356302a91.1
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2026 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773558532; x=1774163332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1EkWaHvbsvBNf8xjg+jC92XlcL8wcQLQiGSVioaaEM=;
 b=JWL6Hcy81i5O7bjpy/DtlVdfdzfQE6FkrOSMzhude0M0Odpugw5qPJD/HTwlqq4JGh
 67p1AjpnQYnQNriAfpv0X+oCRZlI7mzjUnk/HQhjvzmj19f8dhj4P17jeUh+0rzMlxaG
 q2Kqivz7n3pwSRvs3kHAbaHmmYZ/5AGBkGiQK5KUxZdzSgNRNMShLu3ph0t9DSsP2sYV
 DHHAhbjM8wbYVLVUDGg+pzPPLzA4rbOEPOm5ZHW5kd43L7hSjlfmSuYNHWvi1uGWhL2A
 b94aq3DK5gLPbHB70ovEn5FKSbY35tA3flpRfcJryYeZD5Of6pBWOGTpUCm+AhiVKp/s
 jlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773558532; x=1774163332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j1EkWaHvbsvBNf8xjg+jC92XlcL8wcQLQiGSVioaaEM=;
 b=qL65WmrwJrohouhiOHB6nCEza63Y0AAAHP09USftAyAvu3wul9exlJOuMy1XECDwLn
 7PfdMUi1qNnUOnvTAMsbPGVIuXMiH7maZuPJM5tA9qqVlYdCN9Gld5LZjzkXx084SU0g
 1s4qzlZ2miRKIc/jsUkPdDd/2fEGnkkFrpUV66SiRhroVbwRhZv9Y4VX86/iz9SpIZ97
 iEb2VmUBnpP54fQLF96RUya9y85OvzkHsTlh9L3s+i4DB72xC/mYwIzyJzE4WxlhPlPy
 1gJMJxsy3ZziT/Iq9YpdOtNZuoyofBEO13mkibawXrsrpt07JC9BpjTGWZnoCZSC3GrL
 pBDQ==
X-Gm-Message-State: AOJu0YxRyRCrYu5rVN5MJncYOEcHbZVCCIbAeU9vLzyV7ju+caVSf95A
 zdIsfNukKyeQ6qsIW++s15evEUVvyQMRP8smOyhClsRlSfSJuf+6C3yHj2HFUuQ2rILTqWWkJOQ
 hoaBW+p8=
X-Gm-Gg: ATEYQzy7YcMNX1GjAiG0DN/3pT7RvO2Wdk7PjGu9aT9AUpBhvIlFiGf3V4TZn6y4l/X
 R2uFQQ1Nobggdc1k7gk9rSqHsYk7fUE1qe3kx8/sn8P5s8FRz71Jkf+L8PeTH3g8TcYkz+G619D
 0aTj26snUdaJx6jl7LCmr9Kzx42ZmHP7xmJrn5siApPRnLP3ioWMxC8/BlK9vHnjxQCz4bMUHjb
 0mdzE62Txg18funUen1lnDLV+qrzcovfnyoLSSDTs++2MiMqifSvhKcVqcAT0v5QMkaD22RbqHY
 omatxwOm1OBHKzZAgkvG1vrsxfBHhe8W59NrxEPn8CIsFEURjRuiapJ60iOx9DWJHmXOpIsDsw5
 rhd9vdM7cbCeh+ax9lGqYfC+JPH9A8QwTaqMBdwGdfMfuwe9ncPqgE+xsKX0YAC7NItg3I4LCoi
 xbSEOwsy/E3zaSsxMIy2LQBnHY5thDc3fKJByXA41q1kUmqQ3wXpq1XsvXMiwVbDNkYEREfvRSI
 /c=
X-Received: by 2002:a17:90b:540c:b0:359:9016:1e72 with SMTP id
 98e67ed59e1d1-35a2208b5e6mr7653157a91.19.1773558532311; 
 Sun, 15 Mar 2026 00:08:52 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a24acecadsm3468233a91.2.2026.03.15.00.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 00:08:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-ppc@nongnu.org, eric.auger@redhat.com
Subject: [PATCH v3 8/8] hw/vfio: all vfio files can now be common files
Date: Sun, 15 Mar 2026 00:08:34 -0700
Message-ID: <20260315070834.198331-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/vfio/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index bab5f2b7f15..fa0ea6ecf0e 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,7 +20,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 stub_ss.add(files('igd-stubs.c'))
 
-specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
+system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'cpr.c',
-- 
2.47.3


