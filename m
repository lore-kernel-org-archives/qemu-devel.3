Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D68C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 08:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE3CK-0007Jd-Vh; Mon, 03 Jun 2024 04:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sE3CJ-0007J5-GH; Mon, 03 Jun 2024 04:37:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sE3CH-0001Ez-95; Mon, 03 Jun 2024 04:37:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso2767363b3a.2; 
 Mon, 03 Jun 2024 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717403857; x=1718008657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QEbx2P+ecMDTIrGE3yN1fS3yEWIZ7usEZBfr+KnNm18=;
 b=f6LgLvAuRYIR2+z2vFHtgGcOf29gEJZN9kecprxi6Dc0bqlyjtOdpx38qCElZRko6n
 RWbkBgGAXH2FLYCyYPLd5aqQP+P12D6OGyPTu8Vim1ds6a3uEiRh0gCPEJngKNNHaiLP
 rlV7DFr7KfuxoB88oEQR6eT5bZamEq2S6u8ol6dlRKmZgQDuZrAFGCjnezjBA3gxXhud
 pQ03zYA0bYb4h7UIi2YtF9l44wBLhxlEfXKCz6hyS36r1dcS1b6Bv4J6GYuySJa1qyTc
 JkoMWW52yn90smee7AgPuoly8gu3CPTlZdrtBK8PzvvJxnsKSVqZWnU8xlDfTA2rx/IB
 KPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717403857; x=1718008657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QEbx2P+ecMDTIrGE3yN1fS3yEWIZ7usEZBfr+KnNm18=;
 b=pcGAuVs+OJAkJl/koesI4L9aNAu09HdnDJGsYpodgNbCD3m9foAeL+W8AvNDpRx77h
 FhCamjeBF413c/kMXcU8pH8z5D9HCFK+q3I7yzHE6k7cLxOjCFYIL5IeqO0WgWYrxBhK
 arhWEM9DT+RpAU7MJZH/wZBtsapBAjiV4Mb0tsDO+QOIGxlSd3g2QjJWDdEDF4s0qDEo
 mZLhZYN3agLEuEo/VKexHns5Tp7u9oYm9j9P6yFEOeaQbY/g0o/P5OSWvKd9OovIxsn9
 3yTjaEZJQaJqacp35UCPyDBjva9HdeSaIzag1q57ejqdZMuB6vPsdLz056/V2VvhGfNF
 01Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW7rPJBNAJw40TLaFPCtlSnyiJv2vnAhcVruMLVx3YViHjD8lhCs5uISmPTWLVp3PW9IsbMUgl5z00qcgtB+UCqCOAZYY=
X-Gm-Message-State: AOJu0YwAPlgQx9287RmglfymSDJq9kkWmbXq1JXp9ptqEOREIvE1rBNY
 D0N7UMWFU71Ski+bGj7iP9M9fRc99ntdaw3fxFJAM6HN77HsdVyifizx/w==
X-Google-Smtp-Source: AGHT+IEg40lupieJZs7+BmsrOggbZJrFSTq2C5S3W5XBeDpaeM5D2IE8KhDsqwTo7TYPdalVQrau1g==
X-Received: by 2002:a05:6a00:22cf:b0:6f3:c10a:7bdd with SMTP id
 d2e1a72fcca58-7024780a631mr12586478b3a.18.1717403856754; 
 Mon, 03 Jun 2024 01:37:36 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702425e0c6dsm5020762b3a.89.2024.06.03.01.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 01:37:36 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
Subject: [PULL v2 0/2] ufs queue
Date: Mon,  3 Jun 2024 17:37:23 +0900
Message-Id: <cover.1717403572.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit 74abb45dac6979e7ff76172b7f0a24e869405184:

  Merge tag 'pull-target-arm-20240531' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-05-31 11:10:10 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240603

for you to fetch changes up to 5c079578d2e46df626d13eeb629c7d761a5c4e44:

  hw/ufs: Add support MCQ of UFSHCI 4.0 (2024-06-03 16:20:42 +0900)

----------------------------------------------------------------
hw/ufs patches
- Add support MCQ of UFSHCI 4.0

----------------------------------------------------------------
Minwoo Im (2):
      hw/ufs: Update MCQ-related fields to block/ufs.h
      hw/ufs: Add support MCQ of UFSHCI 4.0

 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 475 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++++-
 include/block/ufs.h | 131 ++++++++++++++-
 4 files changed, 699 insertions(+), 22 deletions(-)

