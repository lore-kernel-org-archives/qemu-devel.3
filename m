Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9D6C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWj-0006Gp-34; Fri, 18 Sep 2026 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWD-0005nQ-VA
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:55 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWB-0007r5-Ru
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:49 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so4909635e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741486; x=1790346286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3wung1AfGiKZuM1H9CX1YqJ2dUNZTd8PQRVx9YSOo6M=;
 b=sUwhpVh2mLYkBlvqXvd1YOmAmJMOi2Kr9n2rtZfg+Z/zXNUKJisI0wJKzPU/lnVjfK
 XWxXWBkRKN+Wm6f4IC/ohsaJWEyeDMObvwdiSmMy9XAh62IjaWM+UvMOSltmh73bo3Rj
 ugPO3pqpXtWlTgazGpK1jGPjf6LmmPKfmesGxV+juLnfU+org3/OCU1EmZVAoFre86hQ
 RW/ujcYP4bqOUy4pyYfBT2ZAA2Of1P3eO1bJxfUZPxWxNS1JFXpncJ+GsUeyHws5sNUA
 dq0TkI3oGQ7YWhJJrCI1r/FY7FBTXhALSChaY+hFl0MAHD84H/xQql2CK+5qfvtQVxw4
 sslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741486; x=1790346286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3wung1AfGiKZuM1H9CX1YqJ2dUNZTd8PQRVx9YSOo6M=;
 b=066IOrQCdur7QY6xA+hWPO8VLG+TQx+ngkIZeOqZ5g49wiUqvxp8rFIwNEOGJuKkUC
 r71wE2RRKC2XlTk8PAJsLYTbFHcvhJco1SyGhlCVP2WZ5vyqm0qu+G9IkwEV5Rq6faNK
 rHxargfVO34KPDCh1d7H1g/+iwB3u+mVDai6m+faQAiZ/apGNfShA6faGwfne8WY3oa4
 Qg+DkUOaeDaRnZh4rigxPQlFQqUsx3sVOcDykasz0450ldGXmrEe/Nr3/pzNkkTt0RJG
 aLgI1+akhTGVvTHUfCgTowY1LhjEMppEtR49ktRIC7vTHBLd/Rc04AIksxBDm6SHOiab
 sxbg==
X-Gm-Message-State: AFuF++ldIT9a3FGhv8wwWuB8AP85jwCwZ72PKLldvC/pFmb3vqQU15nx
 7ykfe276xykvttBg4bfFfn2nQJxp89oS50PewDKs+HOlVI59zIxbRe/ufEjtj1xTleM=
X-Gm-Gg: AYBFou3AzJ6DNuhbbslLmJSvSOEZVHWXkg7BgYzt3nUYFL0klFVDr0iOcwtJsN60TWN
 ii2LvJ8UhzkUfQAL2GmALEUPsAMP13qV5oA41rdlzPj3P6g9a2MIuCHRG30QM9yT/pXZZqyEI18
 T4NTBDz8M73QFLP1E9HQNIweQ3Y0hGxCZhA5ORoNJO01xwkaIUWsmyIPuljlN+mpcKjkl2xUGYS
 IRLUmoOjugi9a9Df7TX4cZ4XzlOHcTDVKwl4+GEIWZ0OR8cY5QqVe9lYZn3bwVaugbKtXGkL9uB
 WA+NFD6zPLSiePSkWch6IFxkiT0uh7tbuV0eBYEZOjdmAPXW+p1MqEZzA8xRCBhyZ3/xu8tuuWV
 6BIQW6VFF8o6sLFkDvD1kcA0li5ci7myLRN8PBlz2beDG73NNHqJLuXDTPNtf+CX2bKjk4p7Lmk
 suDOxU4fabmqpERmsSwDmMl6DWFH1y1o5x4gyAyY/MYvn5yLx0vYaOQYt1PlfNbCDBX8+RHu1kJ
 LwYtkQmSg==
X-Received: by 2002:a05:600c:1989:b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49fc5714d14mr37659425e9.11.1789741486482; 
 Fri, 18 Sep 2026 07:24:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7d46399sm77551175e9.12.2026.09.18.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C0AA95FC7A;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 11/17] tests/docker: remove used _read_qemu_dockerfile
Date: Fri, 18 Sep 2026 15:24:22 +0100
Message-ID: <20260918142429.336497-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is no longer needed since the functionality using it was removed.

Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 6090a9dc957..fd0cbdfe856 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -175,16 +175,6 @@ def _check_binfmt_misc(executable):
     return interp, True
 
 
-def _read_qemu_dockerfile(img_name):
-    # special case for Debian linux-user images
-    if img_name.startswith("debian") and img_name.endswith("user"):
-        img_name = "debian-bootstrap"
-
-    df = os.path.join(os.path.dirname(__file__), "dockerfiles",
-                      img_name + ".docker")
-    return _read_dockerfile(df)
-
-
 def _dockerfile_verify_flat(df):
     "Verify we do not include other qemu/ layers"
     for l in df.splitlines():
-- 
2.47.3


