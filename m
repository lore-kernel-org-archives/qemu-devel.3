Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4221C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HLL-0004Jm-6D; Tue, 07 May 2024 05:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HLE-0004IR-PQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HLC-0007Q7-Od
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f45f1179c3so2031383b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715074949; x=1715679749;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apzsRecOwxYlD+3KkUMAHR59Iv8gB2EACXeGK4OKruY=;
 b=DMhhi9zFijIIhD6rIxLME6A2Be98f6EXuopT98bxpvnVdQobmeMP5qem5vFaPN1wMC
 KXQ5d0nn3qBJQl8U23oVWct2TW411fjVl1lGx41gNuAT8dGjaiyi8n9PtiRhLN5VdPUB
 qZZTB9K/Wkq4khbogO+N+mXlqM9AWNma3uZcr9rsCFU3lp15vs+CRWOzVaakIL361RQA
 /VrWLcXCFkqyJc6fdXdIb5UVWovY+/I3FNlvUbZsY+pbN8JoJItnNzd0a3YdjFc2MZFr
 DYGV6fR4S/oxgxcmaTdg1l7Dhw/7ABx5udpbvA85zRc2gtEhZeEW4w/hSYNcCsobkMdH
 z/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074949; x=1715679749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apzsRecOwxYlD+3KkUMAHR59Iv8gB2EACXeGK4OKruY=;
 b=Z2pRdeM6plI/V0v7tOvYAQ3XjrWb5hcyFafWCzij/h9Ko4jLfzlC4z9ojp35MZ3Gnf
 aYuuF5e4TArtG83MVCAq1huQuASBzIOiZAFxNUF4ufyWAzIZpHnI1lqstoyoXCnowmSM
 Y6xo8wxgz4Z5TMljJPQWu5Yk1jd43L8KU8dNcBm90b+jq91sHcVTgeUQPd2SHPmBV7CJ
 ttrtn+vZIslOzXtISo9rshx9vRjXJrj7FYEf+foZaAIAQVmtEXLEjMPJGbSqPQQIK/r1
 jLh3hijBYarFMJfV1B3dC3ealMRWVR2Ir3HSXNmfNlqqOd66AC6UF5avzboBWs5Gbp+B
 ZmMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRgBN042kLkCLWPTJiuuX+GS5HEU+O/vd+vElcCZIeMHJvLIUZ/7T4Rp1EJtdAeoc3SrRMYSqZzKBhOYI7nqflhU+4Y1I=
X-Gm-Message-State: AOJu0Ywq0iXpVsp/YsbzNd29KUI8bnxqumzfIF+uSchG10tdh5rp4I02
 WSnRMTvXjQstUgN9Lo6W8taHgZvarbY2er1ylR3W9cXlRYSvhKwbCcI0BEfxwIk=
X-Google-Smtp-Source: AGHT+IH5BS0VWuf9WZLAUQhqzpfnFusPfq1xQJuPJ2gzRK2A9UzYqOvx70l/c3sgHecJE1jyPEf26w==
X-Received: by 2002:a05:6a00:2287:b0:6e6:970f:a809 with SMTP id
 f7-20020a056a00228700b006e6970fa809mr13726473pfe.20.1715074949336; 
 Tue, 07 May 2024 02:42:29 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a62ab04000000b006f45257d3f7sm6434114pff.45.2024.05.07.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:42:29 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 jag.raman@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v9 3/5] Update subprojects/libvfio-user
Date: Tue,  7 May 2024 02:42:07 -0700
Message-ID: <20240507094210.300566-4-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507094210.300566-1-mnissler@rivosinc.com>
References: <20240507094210.300566-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


