Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AC9C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7QZ-0005PR-PF; Tue, 07 Jul 2026 11:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7QY-0005Ot-Ou
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh7QX-0006OJ-Bg
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:09:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4759b4f0897so2015318f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783436975; x=1784041775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XrRczSBAYb2cx5H94f1mxpl9lLabn0hVDXP3jvgAyr0=;
 b=cAoqlPX8xTDecTmDgIxQIa0ds1C/sEpMITH1Lj2I3kOzELZ1b3TKbxuL5k3fFIE/2e
 FT+mNJbYzkF/aEGMnhDLtc1/5hm4hjfdTUQJMp/jPYaQa7R4rN07trrnYGNm5zZVB5Nt
 R8xk6+8N0c17UuQ6lGtj9FPqAPQd/WYmKELluTXQrAhOTT19MQ8KNmGp2rT8Js1C8wA+
 zMfIVeFQry9bbJAr0YBmSAuaOTCm0DnQsI3l9Y+rgopmtZ6alEpuGRVuxff5BbBIyPKZ
 OStzbgfVBVZC3JhlRC7TvpxJLqcMOulKIYR0my50cs3+vLzcIKKrkkor96NfszO2+L+9
 fqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436975; x=1784041775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XrRczSBAYb2cx5H94f1mxpl9lLabn0hVDXP3jvgAyr0=;
 b=YpVhvEksqksmI6A5OEwzK29SaERv1aGuqFwtY9haTqOhMKin00LmXCq/kP51+FTqTo
 4Br6YC/99BjWsgK/BH2SHq+BrV+MJhxyf8g73KI4fST68HOjvzyRBxpW17SFu7azONJP
 KypziD03/xF0/n2Mrb/M95cctNsEmXnfDo6hs4oaYyWwlQUUnAhdmbG+BqyvRy4ak1QE
 Jp2dM5CYa55EbpvfZda/AJpfFB1zgRvysFcQxLIRIFyxraXQNc0u6DYalkb4L81u0iCZ
 Hfa/Im3W2KO7QHfd3SD3wotDUwPazmShFByua7YopA9Dcsq1Z1icNN4k/Tw9m8HUookB
 wnQA==
X-Gm-Message-State: AOJu0Yx9t93UALsSFGLMnEzW23h0ftW2rdDjHfYiS2caDfmaoIBPzmTC
 DRgc5kn1V7hkquHs5y/v3ApTxumY4IqVkFzWErXgmfk0e2PIf71+Bw944yvfeW2EXV0wcTDnL8B
 c9/R7m0E+NQ==
X-Gm-Gg: AfdE7cnnDFTb62d3fezTj3ickMeX82PYAImfi/vDaLMLkLnZdG322TSXFxIIKzJ6eg8
 69KOGRGSazWE2PrsWgeDesh2X94DfgjS1DPQ7ppMiKTxSORNfW9yyx7gVQ9b6PgZAmG9vAy60Ja
 MWeStzy+wbHTK8NlEa/yS7D/MSOraqleBMntNacT5ny3QMYtl+eOaldUB37+X4khIFkECHdV4/z
 d/6806+kuzyM9k1KGB3eRH2fgl2fwUEXQhPXwZdLrRwohl8IT0WioJmDakDQp3/oSatP/mwutUa
 U+mVJgypFW1HBwowYyCUj8GREV1orRiOAO/c0XNvv8aRCm2zvr5FJO/AgkyPrLzpKmy/9Kg0MdM
 2zG9Y+wJVXxi+nLfLe5zeBXuAuscL08BVIIlfYSiaQ7GTJkxhAv+4cWlYHrdbMQeB2UdHAWw3He
 ToT2MfwWxwZBSUMkRC0yuL4cNOCsO3Nz/HLfXGY5maP4k08gL/05kjXbBKV/m/hPpkqNeI4FuLu
 N+Y2S7mNR6WgXnQuwzWIe+YUFDMem9c
X-Received: by 2002:a05:6000:40c5:b0:47b:69a5:7243 with SMTP id
 ffacd0b85a97d-47de66c6f38mr6611860f8f.12.1783436975335; 
 Tue, 07 Jul 2026 08:09:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e785sm34181813f8f.8.2026.07.07.08.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:09:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/3] hw/display/sm501: Fix various error-checks
Date: Tue,  7 Jul 2026 16:09:30 +0100
Message-ID: <20260707150933.1410507-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

This set of patches fixes three bugs discovered recently in the sm501
device. They're all of the form "guest can misprogram registers in a
way that defeats the bounds-checks on the 2D graphics ops".

thanks
-- PMM

Peter Maydell (3):
  hw/display/sm501: Catch bad coordinates for RTL operations
  hw/display/sm501: Avoid overflow problems in bounds check calculations
  hw/display/sm501: Don't allow guest to set ram size larger than it is

 hw/display/sm501.c | 64 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 9 deletions(-)

-- 
2.43.0


