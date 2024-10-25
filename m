Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B515D149CD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Oac-0002ew-VQ; Fri, 25 Oct 2024 13:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4Oab-0002eF-KE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:09 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4OaZ-0002Kv-JX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 13:59:09 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so1499583a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729879146; x=1730483946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAOVHCwTqvGVM4ACuCCX8FruNg1taG4au+Wt+fsR7+4=;
 b=qo4i4cjrxJA0rv0Y1i0ljzkSW/Co7Wf+lBGraFcpk1uceR6DzYKNKctzNcdlEOfYJa
 BKfD2c5DMR2tk7d7RuBBPu6a6tSEF5UwC6RFjHNGN9fo8LOC7PF4J8A/pY2z5vg2oq97
 CqhlCXyhx7JZFgNxZ+Z4r5f2dI89IX/mRpu0NBP1hDXqypJzZQZ4UYyfd1xe06hlgFZq
 eVZ3T4725effT7kW6NGR2k08MIuhJ2Nk0IEveD6Qx8DgX+QTlV+GQ4iZs6mwuEd9upob
 u5m423BVqpPsLqnkcCzP/J5W3EGAFSA2OmQ8soFKOK9G2qdpRkd0c/aiPvP8+hqu14BB
 pIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729879146; x=1730483946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAOVHCwTqvGVM4ACuCCX8FruNg1taG4au+Wt+fsR7+4=;
 b=X7QbcN3jgCYrJVrkHczGnD1WmJDCXYDq+Qm57dlL871oa5AEO9E8WSrBI6UvO3SkSe
 36gGbUQW3Li/a/vLxji0ICw9Wy4FniRrGPgxOiGBeqcklVvIROe7x0bBRi9WwPhfHnkR
 YkJppkbmaVsWzNkIRPrDiSTRvuo8w8zvwh2WpK6s/gOQQMlP+CO0uyEDUUnPhBHXJOuL
 nUbh+LVYkfYs0kWFIqrPOkD0al+y/BR9hGy/52dE2bDy6MNwBVGpCHOzFseH1t6B8gpq
 WOQAThrOe4IcexcfF5lu8hnogp/IIvDsct3Th+qjWeasHfMnFBwFWog41+M8QSe2FctM
 ugJQ==
X-Gm-Message-State: AOJu0YzrtwlOL40FOFRQNPg+7ImqDzzrkwDo4VA9KnXoP1cW1BWEPU3R
 GoBH1QqbXs3kDi275sDkIxmRysG7z++ZEJNze8fw0vsVXuyb7L88CowMQF5bbSG7uqdz4j2lk6C
 05XVbww==
X-Google-Smtp-Source: AGHT+IEjRkcxbszPnEgyonvOq5XBYIbXh8O3CHSEczuMSre4Z2oZSbl+PIA1Y5ReoVdpjuc3Ba4N6Q==
X-Received: by 2002:a05:6a21:478b:b0:1d9:3456:b71d with SMTP id
 adf61e73a8af0-1d9a852201fmr48491637.50.1729879146208; 
 Fri, 25 Oct 2024 10:59:06 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7edc8679eecsm1358056a12.26.2024.10.25.10.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:59:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 2/2] cpu: ensure we don't call start_exclusive from cpu_exec
Date: Fri, 25 Oct 2024 10:58:57 -0700
Message-Id: <20241025175857.2554252-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 cpu-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/cpu-common.c b/cpu-common.c
index 6b262233a3b..0d607bbe493 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -194,6 +194,9 @@ void start_exclusive(void)
     CPUState *other_cpu;
     int running_cpus;
 
+    /* Ensure we are not running, or start_exclusive will be blocked. */
+    g_assert(!current_cpu->running);
+
     if (current_cpu->exclusive_context_count) {
         current_cpu->exclusive_context_count++;
         return;
-- 
2.39.5


