Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA1AC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LuK-0006OY-38; Tue, 07 May 2024 10:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuI-0006Jq-0M
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:35:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4LuA-0002HY-T5
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:35:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f4521ad6c0so2354326b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092493; x=1715697293;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apzsRecOwxYlD+3KkUMAHR59Iv8gB2EACXeGK4OKruY=;
 b=Y/ZdWqIrxLKNKqGsD+aEAbrU4ABYuhAIVrF6HimtSIaBvidWPLvCsLi/SK3mKNOuqo
 wj0kYN+VEliu0eoQVYVZHJUEDAzrVX5hFFOUVrCNoQdBTd6T8t4xwTsBiJNMfREBoyNU
 3uEj5lhWAoH80rygRvgq/7/4wWMu+bkJAvJPSXT23IuKsCJ4sr9zBpb00L6JgWJz1KuT
 GBsMZ4+UI+N7L6/YCCKEOd979FnwQXnWtNWFT4dW2WFXGuhadUpQWF7OjIgmemCHUufP
 +BFFxGXSwFxGOAcy99x8ekUgKZFCDa4Z52pgPYKP9onuXlucWIhPrLDfFTmgokpTnO2v
 Ybww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092493; x=1715697293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apzsRecOwxYlD+3KkUMAHR59Iv8gB2EACXeGK4OKruY=;
 b=cPtJDo7I1L7KiDr/7NxCDeZOIPMfB4KLiyvvGi5saVa8WUk+rwoyPqWEhYIaQKNfbq
 hU1OW+jxPkO9N/angPAnP4j/83xM6sVcXlxP0HrT+TY3jmtqtyHrGnUlUIx42nUUGcBj
 CNRLY6z2NQ6ksVrXldcafRu/B91jNwbJGbXHokkxqCfm6rks5dqTQWWqleU9nI6WxT+B
 iDxDnhUGY0uSOmDt0Wd5AwDpqaxZPWi9huSznR+J+qk6x1PP3VWBLYiY6Xf4f6g+NoqQ
 nA10UFhFRVyPJcu+IXobUOU7KMzorXrXoezP3vFD89lxs7jXDA23f9KyINbtvqTnX5xV
 qdkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/andLeLFH0TYdFK1Tj8wiIc6xdMssMc5BTnI+3lO9dkSUQzXd1qhOgJhVhquSi90z2bhoEpDubw+JZY39e3A2rD2pC3k=
X-Gm-Message-State: AOJu0YzjUjchSYPCejZPwxe0E8rFlIrrvp/ii5ym2VjbnJcyYNdzshKU
 ZW3kM69DhFmrOEnFlUjmzi7cVE+26JrCtduFW8aBVtJQN6gZpZLsbncEI4er3lw=
X-Google-Smtp-Source: AGHT+IHBYFND3WPc+fm1E02Um6ZDNPZ9QUtDuYQUMJnnAOh1GgdJQCdRtC2cmqBaJXMJwG09chBcfQ==
X-Received: by 2002:a05:6a21:1786:b0:1af:ac67:1307 with SMTP id
 nx6-20020a056a21178600b001afac671307mr7351479pzb.21.1715092492908; 
 Tue, 07 May 2024 07:34:52 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:52 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v10 5/7] Update subprojects/libvfio-user
Date: Tue,  7 May 2024 07:34:29 -0700
Message-ID: <20240507143431.464382-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507143431.464382-1-mnissler@rivosinc.com>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 416955ca45..cdf0a7a375 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = 1569a37a54ecb63bd4008708c76339ccf7d06115
 depth = 1
-- 
2.43.2


