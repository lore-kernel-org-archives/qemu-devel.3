Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E83D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi6xE-0007I2-Jc; Tue, 20 Jan 2026 03:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi6xC-0007E5-TQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:19:10 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi6xB-0002Ml-HR
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:19:10 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso834837966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768897147; x=1769501947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpjuZa1zUN9rE3lpzuAcZJaoLNgB4G5FespEtcQVePw=;
 b=UpaqltI27QMr86nShdwI6CnfyZehzNIegMokxfc3XvB/kf5+wg1+2jJl4rzC/bUrgW
 +LgkzWXKtYYtsldN5ICjbd6OmEVUBHWaVHzMjn48PmXEFAIGTxONEb/jAY1LNfCh1Q1O
 ZV6ff8vWZ/v/necXLIK1n1Z3OovZlM7PBb8T7wDKjXk8k/Sc0RpGVqzSpmqeJE0VDqUU
 yhXMzaKWJBcgT/IFkGlTWCbRstVYozjXFQ7R9G1El2qSFsHcweO7MjQb5uOX1tZ5ngWG
 HbpccH1zNlAl+v3+sEd6k2sYOPr3ObyZrZjIYaAOh7vVqdPuEwYSQMyVlaOSLUtTvOFH
 8Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768897147; x=1769501947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpjuZa1zUN9rE3lpzuAcZJaoLNgB4G5FespEtcQVePw=;
 b=NeJJTl/RE8QpdCaHJxuCp8SdvEp3r/VviweuRwz7hm2cjmzEyRavx6T4cKQuia3ce2
 tWbKqIeFs9ZHzy5dLhVJiJpI1oQkUFTDsNdbcUJTaDqHUPD8FWqdIppieNDd7HwB/k3c
 v5QIBe4J90zGBJrr4fA7pB4jzwzf1NE83RV9N5A+3pm2rLJhIRCgtvFp/fctH7GflUxQ
 6jM30LHmQsdr6EcQy5xFynd5iSdRu3QGjBM6WFF9xf9wd8SUzSjyCVM7fN2DtpkP9b3f
 bZfC2XQtYN3BS3dvDmukAmRMlq8Hyw5bOKDB+C8UDc4VPzi4Gmi4GRqmD5Sn8VEwwaKw
 fgpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQBU8q24qkBY5b8JOLfmrEaXh2Lfkh0DAQfxZ4KJIReQNTacxQB5DakxFKynwdwU2nyPhfNxxlJy8B@nongnu.org
X-Gm-Message-State: AOJu0Yxhn3ZJ6yeD+fukzaPxCGBmxpRPXhaP2wN/2ViqeKWNO7fpasS5
 RHB4nCzm7f0wqmOGq0Q+yzTWnHOfzdyzZRxx40xNi7TiayxqvbnwRO/O
X-Gm-Gg: AY/fxX4c+3qnQrc0zbH+XMfkblPDTdfFdNKL4icycY4GYzpZHqSyckwZ+Rp5uqmA6Ho
 gMRvBNLBNA6qBNvs7OqcXa6hDIQc41BnFwBhbcxY2bIUA8widFn8FV+Esl90Oyl5bcbt5N45irj
 LB3IS8/4Wb5IIB9UOU81Nl43jQnsOduYv21JOS/D2QRLWSZXBGShanlJUCqQeXiWEHqEQ7HvXFq
 FlWN/SHGASFJh8s+7FrCH7/Rr/VH2Nh+fvXik8CpUKuLaciZQmeHZmJ0yrqVgG1u4Gc3upvbLLR
 aIWcMNaRuftdSxFubYx9g+fZtModumeDq6mrA1fiQymtslZXaNF74eGzxz1jAfh9Wb90CBJ7GPD
 pZ5P7pBEHtb9ghvH6UrgpYQMEGNLmvx8OQuZxigcR4TZ0ziwSUGlpjDXjPcvtto1lu2A8+gcGJO
 Rmc8dkxRUKiKqHJeKoTODe2u9WZGUp6xcNT3v56I5+
X-Received: by 2002:a17:907:e114:b0:b87:be08:815b with SMTP id
 a640c23a62f3a-b87be08844bmr545124066b.27.1768897146609; 
 Tue, 20 Jan 2026 00:19:06 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959f6e74sm1336542166b.48.2026.01.20.00.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:19:06 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
To: armbru@redhat.com
Cc: amit@kernel.org, berrange@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, maxbr@linux.ibm.com, mst@redhat.com,
 noh4hss@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 Filip Hejsek <filip.hejsek@gmail.com>
Subject: [PATCH] qapi: drop "must exist" from ID descriptions for consistency
Date: Tue, 20 Jan 2026 09:18:21 +0100
Message-ID: <20260120081821.884342-1-filip.hejsek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
References: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make chardev ID param descriptions more consistend with ID descriptions
elsewhere.
---
 qapi/char.json | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index 140614f82c..fbac5a1cb7 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -791,7 +791,7 @@
 #
 # Change a character device backend
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # @backend: new backend type and parameters
 #
@@ -832,7 +832,7 @@
 #
 # Remove a character device backend
 #
-# @id: the chardev's ID, must exist and not be in use
+# @id: the chardev's ID, must not be in use
 #
 # Since: 1.4
 #
@@ -849,7 +849,7 @@
 #
 # Send a break to a character device
 #
-# @id: the chardev's ID, must exist
+# @id: the chardev's ID
 #
 # Since: 2.10
 #
-- 
2.52.0


