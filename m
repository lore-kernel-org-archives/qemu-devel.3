Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F1EE6FE2D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbD4-0007yY-BG; Fri, 06 Sep 2024 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbD3-0007y0-4Y
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:17 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbD1-0008AB-JU
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a80eab3945eso246221266b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637754; x=1726242554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NrqrsICLu1S605ONmePhYVSZHzgc/8eXv2dixDfwGvI=;
 b=WWdVqpCb5BHWJcenSLwuXzrD3SsP3Vt1CTalbitUvrY7o8U7biiHTawpj54eTOiSk7
 o3hh8P1F0OyTAC6U9X/6YnzJYm3nvW4pW3M/0oXfKssgFu+hx5owSGImvyiVEQQi0kSl
 0TvqT9jazZLSuLxuFM6C9aZ1RtCcsh2l6pqJvQiMmi9jGkmru3uZ7J2IfrcX959VJCRT
 AEWgzfWMbUMO3U5l3m9HOSCwCv/EDkTd3BmeOJzseBHofELLvzLzpPqYl5IzZEdZtYYx
 TvjgRlQC7jTEuJ10N5CKcixbpmhD1MRuG6QETFXvR7a2g/r4tS54silGQFO3VoiJilsv
 YMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637754; x=1726242554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrqrsICLu1S605ONmePhYVSZHzgc/8eXv2dixDfwGvI=;
 b=PWlkKyKGGw8gJkTrHTIFQUM+fPBRAKpeEVIkmdRVcn5uocu8yV20lrCTkt5Lin7sM/
 GlxH+AYo9WSE/xgsZibofdoSBt87UR86vd7k/1IWaPlfoUe55rF0x9tX0I52Kaw0NtBe
 XOxb9tD1nuUJcNbDwdxmAp2R0T+DSq8IHGmSpqyRnMaQPEfLbAY7ZNlseUmyLGe+PgXd
 9QWP1Zgn2Q4UPdIHS4eqffQwekoIjS152qb6/cuMOTtelXv+FmrhRGOSz6Fym9Z8pjvG
 WE6H1aNDAaXVDGLNPgQeheVI/E78LR8FUFXLGGe6eeX1Gkd7I/6ksNxQ7VVD0k57tcze
 h/Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jXVpx8mw6Eit/PGB3b4o+AN64xSDAG7F8tgeoCuZNRTNA8k1rH5xVE+N8a+o4E8UC8HtqFdClc0r@nongnu.org
X-Gm-Message-State: AOJu0YyDhL5rIEElo8DJx5162hdEY8bFFSMF7tX42dLHMar7TreR0SpA
 yNmYn24l74f9oTsMKwAvjwBn3VgORZ6t9xc2kJsRN5ue5GAzMDF2UkAgt6iDQlQ=
X-Google-Smtp-Source: AGHT+IEYtJorgHLcBFpkApIIEgnRaqjQnwrXNnDZz3CPv/muJwfqzkVnVo4QY1LkgkFMkK44gRDgYQ==
X-Received: by 2002:a17:907:961e:b0:a8a:af0c:dba9 with SMTP id
 a640c23a62f3a-a8aaf0cdf7fmr169398366b.16.1725637753813; 
 Fri, 06 Sep 2024 08:49:13 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a6236d290sm289717666b.116.2024.09.06.08.49.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/5] tmp105: Improvements and fixes
Date: Fri,  6 Sep 2024 17:49:06 +0200
Message-ID: <20240906154911.86803-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Respin of Guenter fixes with:
- Use registerfields API
- Clear OS bit in WRITE path

Supersedes: <20240906132912.3826089-1-linux@roeck-us.net>

Guenter Roeck (2):
  hw/sensor/tmp105: Coding style fixes
  hw/sensor/tmp105: Lower 4 bit of limit registers are always 0

Philippe Mathieu-Daudé (3):
  hw/sensor/tmp105: Use registerfields API
  hw/sensor/tmp105: Pass 'oneshot' argument to tmp105_alarm_update()
  hw/sensor/tmp105: OS (one-shot) bit in config register always returns
    0

 hw/sensor/tmp105.c | 66 ++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

-- 
2.45.2


