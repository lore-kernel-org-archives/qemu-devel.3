Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501D7C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg2zO-0003yD-Lo; Mon, 19 Aug 2024 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sg2zN-0003xN-EJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:04:05 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sg2zK-00072u-Fr
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:04:05 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3c0d587e4so2937103a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724076241; x=1724681041;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+hjeHCHtdkd2RYRfSgVvQKkJ7Af9cnuMXy3JgW7EfI=;
 b=MH2WaFpnVvHbab6ZzSX204oQLvhZXLrfAxRLt6SZfJSg3ZekqcjpDfuoYBoDVotLiw
 sG5bXbDMpH2iYfz0QimhhapWM1JUwtA52sZBEGcP+XarF4mPQEJ42ALkWbdC9iFrL3MF
 eA8ZfbBZ83xYGEMZ7MYaiJQle3HdNnBhlkHr8kEAVR6PDX03d99qoP0Vt/JMGnmSHM5x
 lG1eSb7g1qjFeOlviimlzAUH0xPBL8Rm6lgv0zIT+ibm/VJ0G8fGOkA0sZGGGT9jIunx
 mFPedRRQvoH8Q/F7NWUL3LzkoxeOjEsGoOZWcD6cEs2//iGLr4MYdkb2qBRt6TTVfPQc
 SL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724076241; x=1724681041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+hjeHCHtdkd2RYRfSgVvQKkJ7Af9cnuMXy3JgW7EfI=;
 b=qBtAuEf4/eawK9vyZ2qZL7PJd7esfaSlyRqDuFR2amT24K7cKo6HRoGW67mVtYFAUV
 y2gKrbQxK1GSjS5KavX6NR9HSFw3Idnz/SJG0hQEj2WAyN8SdpYb797WHVQ2R0ZjRsPT
 XYzJcRLpjReEXLyKLEpvT0C4yFu9BDk2akQlURXTFzaKkIoy75GxLf7zyS684GhqXGWD
 IW7d5JgAkxE6AtX8MPVLgRIXDws+XpBudLuw1PHCoOYaTpnehNlVopwD9sLxTa9d4AQd
 jXgPtV8sfroHR/GBoElWcHtJezFa531SYGHQrYYSr/YWNcsms/mGFYW7oDtQ1LqtY3x4
 ChVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXldM/1p9c9nYW1crcf35+fAvgRuF0Nrdp4OpBWj3kUXEtcA/GiOfiNZLgx5wvH1Rzjgy0kqsM5b5RcwzSSMeEIDHtequY=
X-Gm-Message-State: AOJu0YzfmWH4lW6TOFeXnEbs8LjIRMXTAoJXH5jjk7pqkvrMXJSkS+9t
 P7zNSgB3kxrrK4hdHS9uPyyAYTXlDzau9EeXJRZP1KP3Cw8oeQtpTvYMM8rJTqc=
X-Google-Smtp-Source: AGHT+IHIK46eRb2N1D/vSf1jCS5eHuWV8eZSxFwv2JYV7ANzzFlfKWrR7nzTyGLgfqa5VhSJ/f6kgg==
X-Received: by 2002:a17:90a:3986:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d3dfc368e8mr10120665a91.1.1724076240900; 
 Mon, 19 Aug 2024 07:04:00 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3d0b3b6fcsm8341174a91.43.2024.08.19.07.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:04:00 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, john.levon@nutanix.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v11 1/2] Update subprojects/libvfio-user
Date: Mon, 19 Aug 2024 07:03:54 -0700
Message-Id: <20240819140355.2958821-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819140355.2958821-1-mnissler@rivosinc.com>
References: <20240819140355.2958821-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Brings in assorted bug fixes. The following are of particular interest
with respect to message-based DMA support:

* bb308a2 "Fix address calculation for message-based DMA"
  Corrects a bug in DMA address calculation.

* 1569a37 "Pass server->client command over a separate socket pair"
  Adds support for separate sockets for either command direction,
  addressing a bug where libvfio-user gets confused if both client and
  server send commands concurrently.

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..3dd08768ed 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = b1a156d86f55a8fa3f78ece5bee7748ec75e7b82
 depth = 1
-- 
2.34.1


