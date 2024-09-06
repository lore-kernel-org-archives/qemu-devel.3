Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA40CE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1g-0003gt-Pm; Fri, 06 Sep 2024 09:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1d-0003da-NV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:22 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1smZ1b-0008N6-KY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7178cab62e6so1729141b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725629357; x=1726234157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=9dpN6UTabdxrCMDIaKbzwY+9Eryvs6AbbHROSoMHetQ=;
 b=jtJ1ZVTYNQ9OSRnGSfZ+H3pQQM6fONmQ5YDXH66sYYB0D5giDtNaVDz0HNQsZcI452
 gwYjaw1FeTgFE2R/LSc+4RUPV+7cN4j47XaeQcJ2kOkcSkajvGbO+NsmEcdx57dLgFCZ
 wwlwf27YRYL5TdOnMXYLXej+VT7beDoqAT7n/AowmP7Hdop26pZoKCDox6r+MJluFcCk
 Q1S8rKBRyTywcosptzizUNOs6ngZzox9nUzWcGN6jYki9byqfiMy4GMAmdHm032aVfQv
 hmzoLJeQKlAJqlU3DdjG0xEjMa4cUHqwBPTdc+S2D0Et5mDTzebtIKzJP9g7wDJp7Aq9
 GoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629357; x=1726234157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9dpN6UTabdxrCMDIaKbzwY+9Eryvs6AbbHROSoMHetQ=;
 b=E/xSjOt/FDoS9ACkXvYr5p26FUi6h/+jhpVDPMI2tJNLjVETp9KRAYm44EMva+FwJR
 PntcorFwoXTW3yFjChZhvTvplccCO25wSRlJ/rYLrCQkzYFk7MLALZVRITneLpAx4kgs
 DtPovKjAVQk6ujOP2HIhJoVeC0wyNkKRiJfZdyyjQAkZ/PstZXkHOmXwFGsICxPTMKeW
 yAEet2leThiWzghKZfIWA134VJGAgLcF7kGhUusJ9dT+/ISdvu0um8Z1zc+nCHXXxv4d
 kGWxuZ6iEXuZWFOSOMU5VhdmzfP2bTqDaCP5xkRQCAy5JaiNE1kv2lBVo+Gu7aW5zuVY
 BdPw==
X-Gm-Message-State: AOJu0Ywt9X2GeQzSzupNfgMG8Okm93qHA+U27RpE4R/WD7taSHCUuN0/
 KJhZEHACrGTMlSESWnlRNv5hucwovmMZcVI0k+h5Z6W8df54vy2Rlw2M8Q==
X-Google-Smtp-Source: AGHT+IHWiDjD+/+jjzmN9DKNcFHGxdyedMD3Rru13Z2PPw1i4O5PtHIb/pl73aCpBslTjKfC673xAw==
X-Received: by 2002:a05:6a00:94a7:b0:710:591e:b52f with SMTP id
 d2e1a72fcca58-718d5ded3a6mr2415517b3a.5.1725629357543; 
 Fri, 06 Sep 2024 06:29:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d4fbdadea7sm4890919a12.93.2024.09.06.06.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 06:29:16 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/3] tmp105: Improvements and fixes
Date: Fri,  6 Sep 2024 06:29:09 -0700
Message-ID: <20240906132912.3826089-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Fix coding style issues as well as a couple of implementation bugs.

----------------------------------------------------------------
Guenter Roeck (3):
      tmp105: Coding style fixes
      tmp105: OS (one-shot) bit in configuration register always returns 0
      tmp105: Lower 4 bit of limit registers are always 0

 hw/sensor/tmp105.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

