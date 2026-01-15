Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA27CD46617
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTuY-0004v5-Eg; Thu, 15 Jan 2026 15:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgTuH-0004tC-VW
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:25:26 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgTuB-0007Ji-Gl
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:25:21 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so9245985ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768508717; x=1769113517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4SGDRIGMnOYPWjOMPlSBEyglc7jQCe55ED0RKSb2Zj8=;
 b=V1t9M5WYTfyhwMDkGR59jCy0LIAVGmRArqSY7o/gSbVG5JjvDNsX0TLappNmMI7TYt
 sanhSh159j8uW9jzgjouOanxGazCckcIoGDg5pJhnujhuANhFyuk/Qic1QlG5NMx+CnR
 qMCXew3JJuIC/+ucRL90pIEci38qEa8WJjzkh8Z3Hv6cDLiIRJ3cq+jpVvUFnobW/gdl
 S8k2FugR2wB296q8J5YH37xK4QCBiMc6V3aBHKkYr2hcs0QKT+e7RHZF0sXO6PqcfNn4
 aKszwhT8Mv9grJ75fgKS7mqryPrZbURdGM575RVQrcKW+sDDHzrEyfvkP5YjH1iG+2LR
 AUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768508717; x=1769113517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4SGDRIGMnOYPWjOMPlSBEyglc7jQCe55ED0RKSb2Zj8=;
 b=OmpPvYAFa4VoUowaN4JgM3K+Oqco07AljJoaaTWvB2mjz7lS3tLLrMMQj5NK6kHELE
 CJFEnrOg7ZIsH2rwq3wlDHzfk1CN1afFRW0gHZO1l0EuSvzj+nY0w/BBVvDpKwgL8a13
 zZe5RfMnWBu/KkjLtONgS8sVLNganQbYVWnj1hXK/j1buY45114eV5ObvvYJjnWVdpyE
 83YkfnZSpBV8799oWN40hM+snHT3ibllgQVnOdu4WfECqAHFYSmM8uTSWnrh1gYRYrHT
 gJ2mbS9917mo1w+8B1APZt8OUi3QYRfzAqLP+BRSmjrEFtz/eYz36cuMfxOs/kveBYB/
 CdJQ==
X-Gm-Message-State: AOJu0Yxp7wus3QUhh4GTj/YzZDroN01pOAtS2gkPecIHVPJUHZi83jqs
 9AKeAPFVHDkaTRLNJX/QbFwuxpi7pO+Ys70Ux8mN0ld+r2deBPytLVXjp92XdbevLxNWfw9tAEe
 9UuWm
X-Gm-Gg: AY/fxX6pO2qiZRQ+QasyeliF3YuRWpglNpK6DlAwDtbdAJd+a8pmDTogUbYJNCE83nB
 /rbZNY0TrNrUeld3//PDk6dl3g0hXiACenfFmmpn/4EHNnRLkB9tb37bMRtnPiUyZC5w8Fhn66p
 RexZ4Q38+8qBZEdjr4QbikRnNToxcQS4RucwlvAuZVrYlNsmZchjIlb/0u1pEda1NFGd7c5UDjg
 CDuchPRmPdVQftDWCNhWQyYjvOeMgfZQlaCQPjYzxP+8+U8FM9bsRsoumEF4ja7KGmWQ2XOLEEY
 tLkub0K755ttvE1OJjhWTwgZ3gjEuC6Vt3p6Fp3Tt1tGH0gOLVnT3CinRB6VhDiyY15aTw8jHhs
 tfemC9hd7a9isMLfVI9D6aR4WbQKL74w3ibeg5q1IY498omoNNB2KCBDCa/n6vuFMYMt747H8HA
 AUhq5aXARoIryAEXBPaDedxdqdF8UBl4gEbgXkZOikWF+bO4lkrZohYKImoA16kfuR
X-Received: by 2002:a17:902:d549:b0:29e:1415:df95 with SMTP id
 d9443c01a7336-2a718943c43mr3240165ad.51.1768508716693; 
 Thu, 15 Jan 2026 12:25:16 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ce6a9sm1488065ad.34.2026.01.15.12.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 12:25:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, stefanha@redhat.com,
 pbonzini@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] MAINTAINERS: add co-maintainer for TCG Plugins
Date: Thu, 15 Jan 2026 12:25:09 -0800
Message-ID: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

I would like to help Alex to maintain TCG Plugins. We talked about it
and he will keep the priority for merging series, but I can occasionally
merge some of them when there is a special interest.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ddbfba9f01..d80cdfbb6e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4039,10 +4039,10 @@ F: include/tcg/
 
 TCG Plugins
 M: Alex Bennée <alex.bennee@linaro.org>
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 T: git https://gitlab.com/stsquad/qemu plugins/next
 R: Alexandre Iooss <erdnaxe@crans.org>
 R: Mahmoud Mandour <ma.mandourr@gmail.com>
-R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
-- 
2.47.3


