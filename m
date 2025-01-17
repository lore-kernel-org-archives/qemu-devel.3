Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3460FC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdi-0001da-7g; Fri, 17 Jan 2025 08:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-00011m-Lc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcx-0002GN-OF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:13 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so3390692a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121390; x=1737726190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Id2YhFWnCyQzMpp3/7mwnf47rokh9cmGN9I+7TPRgK8=;
 b=DmjWh9nUkk4nwTWoB1GyfB3jY9O9pAGmtm9f7hUsNcc5KRrfIxuN9SE0TK8m53E3gz
 PWFZjAag5/60sRKESENJbpquA0NJ7byVsc062bCfDjRibzQmyJqD97xAFgwzenO/QJEh
 ffd9tWe7zJyhVxpTY72JCpuvKlVAfzfevRCRT0Uyf9WJ00SUxokUligGk/yxoLRBwbqR
 VNs/LbxmDm5mN8PksXY8UJONacOyO+NGRe21w+WrfrHWcVocAdm4HbZRqtgARLBkKpKw
 vtkkM/DyLr01g24tG4+dOJ7/D/RSoq/PCBfbdeGyswIm3M1h06wmcekLzDXGa3Ao5rRK
 698A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121390; x=1737726190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Id2YhFWnCyQzMpp3/7mwnf47rokh9cmGN9I+7TPRgK8=;
 b=vQii0KeTKDu/tYsjOYBh2cP7vEfgEOJ5mZ2lybk4GvP6dNaF8WX3J9pAcB3IjYv1Je
 OF8ayDqqjyKaAu6EGgLbhMPcZXY1LV4tjw9lXzch+DeYhkpQuSy7IDYIaw6CHSYkv96G
 9vYkZsjQXvqSB1ajtc2KUFn/tzSKfVc4Fixu4j66ZKsTgHygfH4Xop5tNHXJntDAyEvn
 4TymNQaTB8Ni+ffRFrzzUsa915POyR0aZ3qc8yrbUqIbr8zi+YBdIBLdD0W+csxaDUnR
 8IQ3afsjKt4tVDe9i1cgQ1PAgL4mDW+mOTyjA73sbjIKDNCwxUKE7w1X4ijZPBpRwJv6
 /xLg==
X-Gm-Message-State: AOJu0YwFkDPz41dxdA+bWD+D7X/9zu1l+OGof1ASrhZ0oescVPDwFWQk
 7Cxwbn7vydv44cZHPtsJou5tDOtblCWzS7sPftkkMBggwlv/P36bGVEZJhj3Hoo=
X-Gm-Gg: ASbGncveZVwdn6ZWnfkcM9Bq1H0ti12091YWG7XLY4yQvzgIeWjxiJXR4b0kzDDqr7U
 yqLyuLz6zDW/NaoLNlIWwXeoyZ0wuLfOlfApPNnqIaPW5U/RJJNdHwgbuktnJg7t9P7q7EeIFMs
 gCuw/er1Jir97Z/oYGRaK6TDSg0SO4+oSOCpyaOI9C/VubKAQ1pZER3PSv34tamnRw7A9SW9ceI
 9AmRmPnBIcybKjkaKAYwyxeu+flI5+zHmLxuJyvk7NCXLqCIPAcH8E=
X-Google-Smtp-Source: AGHT+IEPd+S7xaBMlDOhOLhpY3UdXL6s9Iuj1XG3lbVuG0u9x0Ee+78PiRQbvNfwEx+QXIX/c0nlhg==
X-Received: by 2002:a05:6402:35d3:b0:5d0:feec:e15d with SMTP id
 4fb4d7f45d1cf-5db7d2f9af6mr2005904a12.8.1737121390315; 
 Fri, 17 Jan 2025 05:43:10 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edcd89sm1504127a12.79.2025.01.17.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C31F3608E2;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 30/37] include/exec: remove warning_printed from MemoryRegion
Date: Fri, 17 Jan 2025 13:42:49 +0000
Message-Id: <20250117134256.2079356-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Since d197063fcf9 (memory: move unassigned_mem_ops to memory.c) this
field is unused.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-31-alex.bennee@linaro.org>

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 605687befa..3ee1901b52 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -784,7 +784,6 @@ struct MemoryRegion {
     bool terminates;
     bool ram_device;
     bool enabled;
-    bool warning_printed; /* For reservations */
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
-- 
2.39.5


