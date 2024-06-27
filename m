Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB62C30653
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrvL-0007Ik-DH; Thu, 27 Jun 2024 12:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvD-0006wy-Ou
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrux-0000KB-He
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-424f2b73629so22792345e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505454; x=1720110254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+otp2F30HYnVaW0wjGWSRpaE6+qcbVlZ832snl2PQg0=;
 b=tvg83VxAmfz2MXCFPVwKzMWas7xr7nH8rvDFpChf1Ki6DdasccECMoNZNQjWdf0QBW
 rYti6PYgTnhhfqkaPvEM8ixPWSqN4PYu8VMK+3hBTRZpGENTP0ooOFWUp4WokXsdt0+5
 Pe7PcWogyIMqTTP2W1lWkg2u4Cp5FF2WUo/D/sAEfpLKWWsPycaMKNmYTRPCFDjhjLoF
 +De9lCY2j0jfzf2qSf+xu3nSr2VYQpwGD4hcBi1Wy+VSCjzodL71yC0Rw46Vg1xj37JA
 qfr70cDuDOuavdYnH19mSSrhh+JZr64dLUr21p4G20xAXuzmtYka0fvK1K2LTC9E9aQU
 P5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505454; x=1720110254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+otp2F30HYnVaW0wjGWSRpaE6+qcbVlZ832snl2PQg0=;
 b=ra2VW0pnlgrR5GakdkkGnT/s62q1yQffwg9DzpySPPwMJiVUj+KZR9CE10QrLkIyT5
 B067sI/pfEkmD51FmXH0PcXa4ir1zNrperZYFiAtvbLhyOM+TPe4409X+i6eNyrm/US1
 i3Yx7Fh9AoDJxd2FHf+fFU6NrDKbiJkDUxA+a8MwZPcI83hJD3KpxZQLvqTUWvS343o3
 1MgJj8oKV+hcF0p+HKF2GEaXq65cULXewizG1O0+facFJEkvEoy2pEWlg6gDceKyxdt6
 iJdk1i68QLomSWvEKEHETLApW9d419lIJ/Mahx5E7xKKq9bwTbZYRp3YQCzyb+Xa0fd+
 6M7g==
X-Gm-Message-State: AOJu0YylVrHiIqWsVeIU7LpmAKPjFWz9Wy5Dr7MQBIIeOOHvRw3Y03ls
 ab0Jn0ZL5SqF2tQL1P/CFiC6TlduHVwhjH33qiKqQm8/3jyJN6RMNLjrinX9oaA+BPok4CT8kn7
 IEfQ=
X-Google-Smtp-Source: AGHT+IGCSYyWdY30jYCJ15tZVe9ufz+7Dl88gyGEfbHvHdLX3pyNUp4nZniYaFHyh8UyVsILBmk3hg==
X-Received: by 2002:a05:600c:6d48:b0:424:a308:1746 with SMTP id
 5b1f17b1804b1-424a30817fbmr69581105e9.16.1719505453885; 
 Thu, 27 Jun 2024 09:24:13 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8245d9dsm75125565e9.4.2024.06.27.09.24.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:24:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 07/17] hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
Date: Thu, 27 Jun 2024 18:22:22 +0200
Message-ID: <20240627162232.80428-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Per sections 3.6.1 (SD Bus Protocol) and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1f3eea6e84..4e09640852 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1507,7 +1507,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
             }
 
             sd->state = sd_sendingdata_state;
-            *(uint32_t *) sd->data = sd_wpbits(sd, req.arg);
+            stl_be_p(sd->data, sd_wpbits(sd, req.arg));
             sd->data_start = addr;
             sd->data_offset = 0;
             return sd_r1;
-- 
2.41.0


