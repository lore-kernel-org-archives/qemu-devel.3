Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610D606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zIlt4Fn3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxBy-0006bc-3n; Fri, 27 Nov 2026 09:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBv-0006Xt-Ed
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBs-0002TU-3G
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:47 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so79026905e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790683; x=1796395483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CzHrxbVYm2ljL5X7sLxas0TZrJJBiyC4Di8vucAdufE=;
 b=zIlt4Fn3x6irpefokEB7xnVpvx0ugu6LOG3y/z4thHdMmQyO5zOMdbqKwD6Xpr1f7C
 E67Bkscz6/vw8O0qIJNMLTaHqY3Vd9v71Vt0dOdgrRPp1i+AzlyUhTq5yxYaLxEWLWfN
 tQFNrp89eC6Ki4Fdu2aG62wCjrSxzzoo/e+JLZiKnbJbR65XZjHV+XrYhrr/FGiMZOXs
 cj67GZOLi7czSnIbWcU20JIh2+PotFsr9Df7Th3CeKk8gnw6akxR9yija6bbdAmCqBff
 Swlxvcl+gHzzIPMaLCqb2fWg0y9y0Y2ZtMIlFm6OY2kOgPjqK5aocTi37QCwY8NBrcPX
 rLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790683; x=1796395483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CzHrxbVYm2ljL5X7sLxas0TZrJJBiyC4Di8vucAdufE=;
 b=2jXLDcko/PtV9bKzlukbR11W/ez2NcJzf829ZCd/VSCpkS3oxblzvlywAPv9pCCWkp
 buGtERGKGfNhD7xLpP576DhddVilCl7IWrp4mrMGK/7wnBwEM8bVwp5ykDceAUWYpCMI
 ZexekqbIPdBAvOzFVXi8K5YFsRGhliOu60k+WRlnxjsuGrAGOpbaOw2qREDVM+4w0ydl
 exrvusbxpv7+C8Ln5gFJf/zV/RfwmlbkLC+6uWbMItoqpH4m3tekpkrdDqKPJSI3TaIj
 nN07uG3bPA7GGI1VVs8l6O3dNxtiCWW7HCrM5eGhTr0hvJEV/vRGTz0q9CUf1jYfDuOS
 qVUQ==
X-Gm-Message-State: APuU4Z/Mt9g8us1j8yH3tOn1z7Y4LncQ6rX4EFf0BOrJ6TmS0CTupQj3
 HDL6mbMT3B0PNFvQv267EViz392fhQP+PJf0t/pzFjUFMVY+JlCSE0uI9xN3mapSh8wgZFT7nA/
 MTvPf
X-Gm-Gg: AZFdTZcPmcvLIbnoJ/zM8+vk+KbLD59LegWasGOS+/plnniuKgVUHWsvcF+MqJweft/
 wkWhiYI98UIP69SBJiMg8541RcTJhbZth5lRqjlsnMlN9Gj1diiCeQ2gcIXyC/93uoOsegSkQ/n
 OyrQqd0KYjaA1s/0Wi6/OnWUKcNVi5vqaMdCqzWiY9P9rPqbqon+OjfKB+XyFA74gMV2a/RVyQm
 2nv4ipZct16d1bY0DaTlgppwJOTDLSBmeCVuDAFW2FOc4Ck88tsxGdqoHMU5fr7CZDe8leWlfHN
 oQpmxDLCkHKVvVEyZ8iTvYS/Q93YfwjTyVwg9f01NP8dHCTcNbCqYRbdatYLBiCjkgAUcAu5reo
 rTYiUQK/Q68dNZsKvQhG1TVzd+fyFMOngFzgfRhXu1DAtjHGPo4TJgjDyQmuyEClQD9H4ZagbqU
 gomuwXSLfx/g9LvwKXyHQdCkWNIfZ4nstZE24g6vMTnPPFcri67noFDAyP80JvDqSljjFb7Vp88
 5+BV4lYHPAMFfR7BFbg83JT53CwfvG31voB/m15UrxC/IUxxCOL+0iO2L6VuCJOmcDVUvIYJsx6
 CkEXUCLVZPnuWf0upf/2ByHym5CazxLp3bo8qI3hynZCK8JUBWYbzDq/oaUNKc/Ocsd8Pp2Havm
 2FWN8BZyusa+1ATZsb71qErsG8Z4GKLSnyg==
X-Received: by 2002:a05:600c:1549:b0:4bb:6a2d:b440 with SMTP id
 5b1f17b1804b1-4bb887e0699mr501315265e9.2.1795790682624; 
 Fri, 27 Nov 2026 06:44:42 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm216862975e9.3.2026.11.27.06.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:44:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH for-11.2 2/3] hw/nvram/spapr_nvram: register VM change state
 handler once
Date: Fri, 27 Nov 2026 14:44:38 +0000
Message-ID: <20261127144439.627586-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127144439.627586-1-peter.maydell@linaro.org>
References: <20261127144439.627586-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In the spapr_nvram post-load function we register a VM change state
handler callback, which is a one-shot (it deletes itself when run).

However, loading twice before the VM resumes means the post_load hook
adds the handler again, overwriting the old nvram->vmstate.  This can
result in a use-after-free on resume because the first-registered
callback does not delete itself (which is permitted) but the
second-registered callback (which is not).

Follow the pattern used by vapic.c and only register the callback
if it has not already been registered.

Cc: qemu-stable@nongnu.org
Fixes: cf472f48d57a533c ("spapr: fix spapr-nvram migration")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/spapr_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index b0f9fe8633f..0b85412e3e8 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -233,7 +233,7 @@ static int spapr_nvram_post_load(void *opaque, int version_id)
 {
     SpaprNvram *nvram = VIO_SPAPR_NVRAM(opaque);
 
-    if (nvram->blk) {
+    if (nvram->blk && !nvram->vmstate) {
         nvram->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
                                                           nvram);
     }
-- 
2.43.0


