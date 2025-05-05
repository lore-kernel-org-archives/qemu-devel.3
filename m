Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15022C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 12:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBunG-0002FJ-V4; Mon, 05 May 2025 08:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBunF-0002F5-I2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:33 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uBun9-0007xm-8E
 for qemu-devel@nongnu.org; Mon, 05 May 2025 08:19:33 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b1fd59851baso389527a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746447565; x=1747052365;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lQnJNkvK3K2yzADBnJzSykcynBAmHOzuYLLnyoCCgJg=;
 b=xgN6nP5+oOLxvDsm+I5qwa3b7hECxV3+WAnyTSCRj02M7T2b4+XhSBoI14MfOn90g3
 uuFvCiOZic++n0ejVsrnzO1V6XFw+WaGkDjmxcYYMu7YZ2SIhMnpvoI53ixJAAyxPhOR
 MzeH6/w43D8cGWGi7gRVLFQEjTe0V5mW4RerwH/1Z681riA+cLPMueBx4S16/ktCYUM1
 aeY4Wvo0Scu0Oh+u907IJDtK6mTcRvt7xwufLw4Z0163m7nltbZnB0c9m9USXaU6czDm
 LrXZJ+hiSwpnwV3wKMMAQEFf37f0CRo3mlly3rAcdRMUEViC3l5BmKWetz6BOOxOrPyl
 +OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746447565; x=1747052365;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQnJNkvK3K2yzADBnJzSykcynBAmHOzuYLLnyoCCgJg=;
 b=bGuiOCM5r7trzH524wEsEvIeyaNWQQHWTaB1YPRasy2WZdE1AOmF3OPIXRD1GtpAKK
 jVZRkvBkXNIKxF5oVpYIvHSkHG58W05Bu2kWf5TFr6529gCdCyTj0H3z7uoStPhLgxzC
 UhzD+s6vpOJRL+EMp2OuufAJhy+7coWc8lDPyvy2A/20wcqcKjba7JjqHM4MxhZerwVj
 3cxKiN570+JVA1u4tZMLRBZdkbJ0qRVCp0/mckodHFICnYuaAndWXLyeHBpruBAOiALs
 DNEAe8BdsNV5JOWiSv2MGWZuk2v5HCWA0T//22WNcxOVvNGIB7sv4Ov5K8xFJ7coKjRW
 yNBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvDfm0aL7GXa9HN/5rsYW1hWqYVcbomTLD3GLP09pR88bpQZQeHnUoZBjcAbT6Yc15yVqyjlIOLUJ@nongnu.org
X-Gm-Message-State: AOJu0Yyq8KAGaGM8vDgWWtH2amwUH4DFhixQvLLEINtIOX4G/MJIxK+Q
 DfOLBem2sy3IDTtRss7viCJEcq5wgnvpbu5CB9Q7HzfRJiq2BmZ119/BgzAGWME=
X-Gm-Gg: ASbGnctKBgFjXIo36+Uxj1GUymYRDXHkTbdxBI5DQK5wN4ygbEe2pLDolBP7Jw3f1+i
 28jgVKkmrtyn692nDq/re6afO/38jUaSZBpX9CFSrRC8d+AvxGCUh78THADbUnKjvUDCYaG4OBf
 y6XZiruc1r+Wth8gghDnEL46Jq6Itu5C8dXP0VA9CAzbZ3xz+yEdMS7JMHHhGNF9tZPFx53/425
 UfpnW5lMqLFE0JsPduYLoQACW4AkAZL/nsTS+vmJUD8TsEjjD0jGnijXho/yYcE0Y9nFPwd09JZ
 i8lfmqDZui6OXDBz29aG2K3KSdc1DhtZuO9srIG2wPFezhof7l+NQF4GUw==
X-Google-Smtp-Source: AGHT+IEK2kfJpJXkTOZVzZbcxRTNs6IpFxwx77S61M2ERiySx1XVoyLssY6Gr9HiL8B/4l4ycoIBIg==
X-Received: by 2002:a17:90b:3bc6:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-30a61a32e79mr8693328a91.26.1746447565322; 
 Mon, 05 May 2025 05:19:25 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22e150ebf35sm52798335ad.21.2025.05.05.05.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:19:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 May 2025 21:19:16 +0900
Subject: [PATCH 2/2] MAINTAINERS: Add docs/requirements.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-sphinx82-v1-2-85f2418b33b1@daynix.com>
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
In-Reply-To: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

Add docs/requirements.txt to
"Sphinx documentation configuration and build machinery".

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f883..6ae5d2665e16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4328,6 +4328,7 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+F: docs/requirements.txt
 F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst

-- 
2.49.0


