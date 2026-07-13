Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D7C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJMj-0002lz-6r; Mon, 13 Jul 2026 12:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLw-00027d-Dk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:56 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLu-00005e-Mc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:56 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47de008b020so28417f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959473; x=1784564273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7KH3n9Yh8CVFIsNDzYj3Vr6eWkJIVPvpoM60x9GrIzg=;
 b=mbLmAMcbtXyyIzqS7Hw9N7sTlJrl6NNDCpdXzAWTJIYrzKrFK2BxzKxyRdja30dDwk
 FWUzAQClJVcT1voqTfsUvUGnRefl+TgnNxEZBR7DoWOOsB+2Xx/z3Rtc+1PpokzEIUQO
 9eiMNe66gZ2qGPLXGXbmGrSuWRjXTev/rEM1q928R2IsOWDJD7cR+SontJOXscuK5hW2
 +FIEYNXkjVCkN0BL88E17LXdCOtle+gnzPEYaAbiEpYHJXueoyl5ADUV5I/CeAhWmubx
 75fdXYZkzP49zXQsmj73662tOYbwJTMO+4Dg+U8OqEewGRM783PbF02jP03sojjEg9HN
 sz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959473; x=1784564273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7KH3n9Yh8CVFIsNDzYj3Vr6eWkJIVPvpoM60x9GrIzg=;
 b=Biy/SeX5+cmszBcGhCP8XwfK6Y6ZyM7kY/4TJCRHtjOhlgKPz7vT8nhYoNjkjKfXgg
 s6q8caOCAzIRriIEZi7Vsn7qB39auFx+jQpOege9hKocuZHwlLw3PqfvyYcVjJ+wQiMa
 JIzb4W+zrfVqYtviqyOwDpwafGJhdPaGcubWFrOsYEmt+VVp1HwS6+hEVhJSPQ5ZEKpA
 4x0AL4+dB4sB0kVS/oTw3Pp0S6/+uM6N+15oY0+x+GT0gQr4PGKAXkEVFx0hIf7Aruzp
 sIdo8J8O1y5dMOM9CdLSmZS4iNd1K4hz2XhdlOKa4l7a6cMHJCd4MTygsgLD3aRt4Ra/
 8/JA==
X-Gm-Message-State: AOJu0YzsLQau6cHTL1gLiYWvmODWj6QIeW1bU2a5UYcDXjJVtx5hHsPo
 1RMpff738EwDd638MtI585/HOGWNgXHnhc+fCTS9hxJ4qt4Q2sO/EG2s84NYcAX8bDk=
X-Gm-Gg: AfdE7ckD7sJx84764I08e1NCFqgTHV6631tOb42sUlZcTOPA2hFEZBu+wL64UgEIt3P
 jWCEhgpwjBxhokFi/nuRHlT3wlnRt20IWii5Z2zLtCGGk/cw2ONRGbu8h/vNTMKXFmYLUDhvpIH
 PO9tbe8Nm0K6+Wn6tzmWHmt7VpqwWRdbVmHOBfgafn8UM0I4nUyAGncCSxiAG9hFJz9mgyiHFVl
 3jJZCkzKGXWzu860TCTlKccgNJQx5mtf3Wz7sL52Q+eWstRx8GwrTjkoI8bqHJqulx7F0M2mxaL
 ULMnCw67NAw55HXYvO70IUjk5KNOQIUd1uH8QVvPDfd79/J/hbZel1ew/+odSAAVmYqcFdGZxpF
 cTrL+J/Ix6Zr9o2F89LrjWT4Uep8Q0fUg/MYSNfWGyI/93vdPD4VVJgIUtdHFwkanX6S9Gow4ud
 4AhufVfRQJrIFu
X-Received: by 2002:a05:6000:430c:b0:472:8043:f00b with SMTP id
 ffacd0b85a97d-47ef697ecfemr17598692f8f.14.1783959473073; 
 Mon, 13 Jul 2026 09:17:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm459553f8f.24.2026.07.13.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F15385F8F7;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tomita Moeko <tomitamoeko@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PULL 5/7] contrib/gitdm: add more individual contributors
Date: Mon, 13 Jul 2026 17:17:43 +0100
Message-ID: <20260713161745.53889-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713161745.53889-1-alex.bennee@linaro.org>
References: <20260713161745.53889-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Acked-by: Tomita Moeko <tomitamoeko@gmail.com>
Acked-by: Julian Ganz <neither@nut.email>
Message-ID: <20260709080040.4157324-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
index 178b393b8c3..190941bf72d 100644
--- a/contrib/gitdm/group-map-individuals
+++ b/contrib/gitdm/group-map-individuals
@@ -46,3 +46,5 @@ amarjargal16@gmail.com
 me@sean.taipei
 kosasihwilliam4@gmail.com
 philmd@mailo.com
+tomitamoeko@gmail.com
+neither@nut.email
-- 
2.47.3


