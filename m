Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECEED3ABD1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAXpG-0005st-3v; Mon, 11 Nov 2024 12:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpE-0005sM-El
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:40 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAXpC-0007g0-Vw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:03:40 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f76a6f0dso5310871e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731344617; x=1731949417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tneVgwOxeXMOJV2em6Sql32Iu0L2oPoZoYGFpR4RHFQ=;
 b=zl9Py3+M+FoFA4dSZJJjN7RhxvZV7yJY2AHdCsYbP7SBxkDPeGWkAdwjoVIn4M+Ub7
 gLLVQzdBF71VJ97Js1/HrV+u/5RXLDbqeWAfSVk6eYLPjMdCsNaRQTts57DKognqitSt
 l8O0R2Hm9rU1NMDPzJuKmBLkaxEiKEQ/OuFALvGIFJiE7wli3+8IE3P8dL4o57TdB5AM
 PSTeSKd7IXNX9+v306Z/J6P3mmj9jCJohQe5DzUXqgOKFbAvFW8W2tPSOMVsyh9Lnu8K
 l7CqnZHt37ET2clBVC3W+bP8VWGuWhJa//ZsfZ0ZKE4A6CpvyGmlOFLcWINJ/nZ0OePw
 cl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731344617; x=1731949417;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tneVgwOxeXMOJV2em6Sql32Iu0L2oPoZoYGFpR4RHFQ=;
 b=jXpaJsfJH3rZZgq4ONaSUdK3NnjMNQrbalNHk1JjeS1GugyKKKYjVE5mDUTLFE6doG
 TBn3InhRGIlXlgn/V5eKNrVB7ck0M7tZPomN+3TZ8lWn5eopfdEa8/6bEppw+VuCMDe5
 mC/cQVpqTy/qjW1vNs6eB4fbbvJWz4dFIlQTutARxho+HEMKd1s0sUJs3oW1/2H9CdUP
 rVRcipD/VrWwBEGv6aspKxWawjRqWb9Ddsprm/d9p+nbCE56uvfWVHUHr2JRRTNyaMKa
 QlNtBOnoiTdIJl+tnxGbtc4phQNqMYeHG0NibqAUg4nD3vquDx8fjK0JRfjki+/5+U0N
 +G7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEJVteEIRhjTyKdgSVZUNT7kReXX/Xs9MKbGJADGvR+LIQkOuIt9aa7OwM29B2BwDA4uU4Wnq8mLgM@nongnu.org
X-Gm-Message-State: AOJu0YyelEbopg9kmJwQE8+DaDrx9HH7UzT/O/auy8yWKdsZWLV+ocVc
 8bLYA+e4xlJJY+o22QPHZkQQcuRBvs+0/gHlQ2zhvygdhmfvX+encN+OMy5q0WA=
X-Google-Smtp-Source: AGHT+IGfLnFqlqbWTJxLgMF3x0EK3XTwiNWJ1yjCQJ9EP9/TnuJadWqAN4VdgZOy3pi8+h1M1C/1qA==
X-Received: by 2002:a05:6512:2256:b0:536:568f:c5ed with SMTP id
 2adb3069b0e04-53d8627ced8mr6197116e87.1.1731344616446; 
 Mon, 11 Nov 2024 09:03:36 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5871sm182492055e9.37.2024.11.11.09.03.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 09:03:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Fabiano Rosas <farosas@suse.de>,
	qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] block: Fix leak in send_qmp_error_event
Date: Mon, 11 Nov 2024 18:03:31 +0100
Message-ID: <20241111170333.43833-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

Respin of Fabiano patch using g_autofree,
and clarifying method docstrings.

Fabiano Rosas (1):
  block: Fix leak in send_qmp_error_event

Philippe Mathieu-Daudé (1):
  block: Improve blk_get_attached_dev_id() docstring

 include/sysemu/block-backend-io.h |  7 +++++++
 block/block-backend.c             | 16 ++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.45.2


