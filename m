Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C94C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBq4x-0002HB-75; Tue, 28 May 2024 02:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBq4v-0002GM-5o; Tue, 28 May 2024 02:12:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1sBq4t-0003t0-FY; Tue, 28 May 2024 02:12:56 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f44b594deeso3561045ad.2; 
 Mon, 27 May 2024 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716876773; x=1717481573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UOYmS8T0Cx+2/DDJl1TfdfW4v4z1vX3yBulGuGUQO2w=;
 b=bR4SPzLlocxYX9eAUHOgLBSyQ3iKJU6ZObNQkK7c8w2M3/ONHN3kg3NGUc0U8peElQ
 68QN6j+3PEmnh4/wrFvBPXbNv2P/oFVQSz/EvhRB/5F0ZoJDC7D1e5tFirTlwR0NIEz8
 X5HANo8606HEUHwWtfNzMeH61BsDRUCLKMgTdVQAId4w9p3XLvKp1hCJEcdJpeLIGUjd
 8+rP6+l+VxvZWxt5FHB1uCjCoSBjbx8g+wuLfOW6mTISYwIr7hom58At+GTazxHyKkgU
 J7kfZrXUf3WRD2+9KT/kLeeKJJfzWY14F9xL6qPXvc69zHr+zvW/gRso5X50PrxXIl4E
 UgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716876773; x=1717481573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOYmS8T0Cx+2/DDJl1TfdfW4v4z1vX3yBulGuGUQO2w=;
 b=XR8O1+5X3iKM9IBpMkeuSGzWrso2124qQvCm5Zp9clpJGlFC1ZsIbiMKpjZr6cnywD
 MnVzz0gAKGQsUD5/uXDIjfEKaP0oueFVtL9wBTIAtf4Ta2Ad2t6VyuX1pM2Zh7ksJLC1
 1ZqUyaSEKehb4y1z5WkFAnRsnpgZQ18Db5TbT7zCNrcQnmp1zmmM05cfga7WsIoK1PqU
 TguGa7HbU1GjtQo/rJ52omDCg20P/yvzc/HDAS+pF9dUbY5F+aBzBe47IaauMMMzXV15
 VvBBeexmtVrYTH8Sraqs+5DW+R26rObVumsuCaDAqtuo5NpUhi0FVBph1g9uOtSD5Y55
 9pJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBKgw1euNDCCwqmMM2F/vPcIAFFqUwHTH/CR/no6lluzEREBZpoO8+T9rCzox+AHs4K03jGVb6+qcJPXb0N/7/ZZz8hBA=
X-Gm-Message-State: AOJu0Ywy+zro4IqtGmJm+oGsCtL3vBIiTa5fVbKeJ/YKygayYyZuLm9o
 ieaMqyYFHj4hCmvpowa4wqMrmF8E53w+I04vRJjW8csxfEof/YxF8KDcjw==
X-Google-Smtp-Source: AGHT+IHRcKIXbkUNPhBqSl/pqk6DfUfN1unHHgxAZHcAo6/0vNhDixsmMIH14GEeKvoYoW46GxBqWw==
X-Received: by 2002:a17:902:e741:b0:1f4:75e8:2ea0 with SMTP id
 d9443c01a7336-1f475e83b00mr65738085ad.6.1716876772881; 
 Mon, 27 May 2024 23:12:52 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9c2a65sm71780415ad.272.2024.05.27.23.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 23:12:52 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, minwoo.im@samsung.com
Subject: [PULL 0/2] ufs queue
Date: Tue, 28 May 2024 15:12:30 +0900
Message-Id: <cover.1716876237.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x636.google.com
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

The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:

  Merge tag 'pull-error-2024-05-27' of https://repo.or.cz/qemu/armbru into staging (2024-05-27 06:40:42 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240528

for you to fetch changes up to 71a82d3f0555e65c98df129ce0e38b2aa5681ec0:

  hw/ufs: Add support MCQ of UFSHCI 4.0 (2024-05-28 14:42:32 +0900)

----------------------------------------------------------------
Add support MCQ of UFSHCI 4.0

----------------------------------------------------------------
Minwoo Im (2):
      hw/ufs: Update MCQ-related fields to block/ufs.h
      hw/ufs: Add support MCQ of UFSHCI 4.0

 hw/ufs/trace-events |  17 ++
 hw/ufs/ufs.c        | 475 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ufs/ufs.h        |  98 ++++++++++-
 include/block/ufs.h | 131 ++++++++++++++-
 4 files changed, 699 insertions(+), 22 deletions(-)

