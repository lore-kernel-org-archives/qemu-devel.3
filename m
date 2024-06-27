Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCDC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMs4n-0001U5-U5; Thu, 27 Jun 2024 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4m-0001Ta-70
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMs4Z-0004UA-OL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:34:23 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso8534295e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506050; x=1720110850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d1CcvX3aX1G2iNs9CoozlDg3h+fT2gyfRGPEkvbBQ28=;
 b=zBv52BZrn0OkXMa5y4HIaRdQbe7jp/Uilz/on/RTQEzi3RA2zwUAdUTTqk7foly/g1
 aGhdCGcRRUiDz76wQR2Te0+hixCzVb3tSXf/T8626ylOxuZvysHmSNbGEMlbThEgxRij
 MKgtKE9wXJZVJaAxFgSpLH4KeAzGfxcIQJqPEaPkeTlPEqVbmeFKw5mlXMCRdYBwdBOW
 QZu4ehThCHeM4lSHJsgDcwFWnW7hAdKpYU3ifl++W2vx2sKlNlW5mS8UqNqvs+qf86bU
 HFLXR7tiX3yCCtlQbX6xKqdTheJ1oMU9s1pezGK69ZRVpfl7mzgsKzNGJkMZ3gTFWwzw
 /tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506050; x=1720110850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1CcvX3aX1G2iNs9CoozlDg3h+fT2gyfRGPEkvbBQ28=;
 b=brTrZqoYxz3a48ZqeCeZhjccGTVfw0fYJY3E7e4H7PvUlEDW2/SRy8PFtChNmgKFTC
 il4hsbyXCN+AK4WzIU1ukDYRjdSAUGWtCdlvdrrbLftUn4W5Ve4/BeXjOa9UZ0KB0TmF
 Q/JQxUICNVFe9XQ8hhCRj6+BJtdYvQhrab7SQ3rYkVAfl49XR4i5joyPJlNbp6LCHMfH
 bz59DPis9Qt3bEXc+KEyauuLaXFXlhHl6QdmXN3MKS+YPvYFLU1DcGe+D7+b0KTzcyzL
 7owxIYMqOcC6rgwrRMIQ5uyaguf+ezlX+J/qunRHEDtcSMqvGMuzvL9ltquVRaKdSDky
 5GUQ==
X-Gm-Message-State: AOJu0YzThwjcCdEfiTsX0zOWELPsBLjjNp0tlVTFPRx0FGZLJboazS2p
 MAzsbFdGamxJC+JUx/Ts6VvTaPaclOO1Fp8WEoshJBw3A+HA1JEWYwcpxz8AdW2w8clGgOq7JGB
 7eWU=
X-Google-Smtp-Source: AGHT+IHqXqfTWaDz64yljby+RIRxJLod2qvojhCzpIQr815RdNkgR0ffxLG/S3O8xl74gyHHFoRR/w==
X-Received: by 2002:a05:600c:32a9:b0:424:d9b4:c26f with SMTP id
 5b1f17b1804b1-424d9b4c441mr50023605e9.11.1719506049949; 
 Thu, 27 Jun 2024 09:34:09 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424554sm73962025e9.37.2024.06.27.09.34.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:34:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 0/7] hw/sd/sd: Introduce sd_cmd_to_receivingdata() /
 sd_generic_write_byte()
Date: Thu, 27 Jun 2024 18:33:56 +0200
Message-ID: <20240627163403.81220-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Consolitate writing bytes on the DAT lines by introducing
a pair of helpers to reuse in all commands receiving data.

I'm considering adding some 'process_completed_block' callbacks
to handle the different cases in sd_write_byte(), so this
function would become:

  if (sd_generic_write_byte(sd, value)) {
      sd->proto->process_completed_block[sd->current_cmd](sd);
   }

But I ran out of time...

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Based-on: <20240627162729.80909-1-philmd@linaro.org>

Philippe Mathieu-Daudé (7):
  hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
    sd_generic_write_byte
  hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK / WRITE_MULTIPLE_BLOCK
    cases
  hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to generic_write_byte (CMD24)
  hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte (CMD26)
  hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte (CMD27)
  hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte (CMD42)
  hw/sd/sdcard: Convert GEN_CMD to generic_write_byte (CMD56)

 hw/sd/sd.c | 109 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 62 insertions(+), 47 deletions(-)

-- 
2.41.0


