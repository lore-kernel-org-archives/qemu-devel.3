Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F43CD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3ID-0004mj-Gi; Thu, 21 May 2026 09:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hn-000478-EP
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hg-0008Vp-U5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:18:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so4895120f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369470; x=1779974270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gX4uwIwh+gHTvHNlBYIefbjuQa7ojD4zYP/K46jOPG0=;
 b=x3IikaGdVHn45Z+cf1hRJoI9wswbTq/+HpBTALgLWePEGKKIfBw+PZYk4iO/cNSITZ
 7RSPE9Fjd878iIau2w05b932f6eQ83FzC8NUCcovzLbYPyFIqWpfSLJ1Ur8cne98md52
 Fz2lObOInc/sRIkZT8soBa6+5ezrObRgTXnb7pMfadE3zM6QIZGxlrbPN748upC0a9yB
 tqZb2iDa6r1wVmde12moOP4K4IAz8Uw2V2jqt9azmApX8MPjltim/w0CIICntTFNfSeZ
 iNxVbpw6lLPKkizKEm3onAQ0RvEnPmKO6vxiHxyiyka28qennAJCOavASVVahsEXMPgU
 BkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369470; x=1779974270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gX4uwIwh+gHTvHNlBYIefbjuQa7ojD4zYP/K46jOPG0=;
 b=Oow4b2wgW9wQYJhZiIyOZ0LZJ3oT3sjTXJMQ+594q4EuaMoZ/IpGjX9krxmKQfss7O
 J+kTJIedOQwaGxdHZrXL2e5ng2KfpO2MjSJ16922+mAjVc0Bqmzu9CkfVHEg5mkwodB5
 TUROlAD7DPGkkpsuaQFEmAL+Vgu0GzXW7Upt3PUfrE3+Xu0G1w32ppQIJgNCdQz98c+u
 EIZZ4SON5agVC3xyDo/b1a1dSn/ZiJAaKDCFogloucPUyBOpK7L7nVxqtgNitFmjd6oJ
 uNQQLKTqLhQL5j4NmdKFdrZtkMRKX2BA4v18lCaYD5JtEwmSyjT8dCzU/4m5Ex4jx/mm
 c9KQ==
X-Gm-Message-State: AOJu0Yx3W3mrHX8JxQ/JmHkPFMTOkwjOkqAJjjQ23RjAubYP/lJDB2TM
 9hw64HZKbqrpNPY0optGadotu9YIONt1HMWFiQxV1pMoICOgyqnRlbewO+4t8J7jzwU855dZHF6
 srhi7CEo=
X-Gm-Gg: Acq92OEdajLdP5ixz7LP1FR797Ad4sBeF0x/+lug1bXlOPEhgbR11/aTN1IXboJ/ZwJ
 YHhiN6kACatrsBYkvu4qv4CmKlWnLIzngTZB4GrnRafvYmWHcVBaWZ4BUc4M8l06WpE40mO7ocE
 WSP3UdP3RGZFMcniI7idWdJD8DJHpdY4X0cBgIjfePD+VgjtI5coa7s4sHZBr3j85EsJVWPAuHi
 +/D8nLizSkmPcnQvaLemneax8nXSzdGFM6qhiED3ljERe7lGk0Z2eOeeTGWgZUB+2wbUO9nzkSx
 6GFrZq9cZ7EwLeK++bwxLqcRk6WUYgmH2YNHo2RNq4ttd2KvQ+1nIJjYBo9iWqDtKUVK34/2CME
 md8CgpIxH461MrgIUjFsCkz/aTVf76hLnlcIpjF08q+gAlJytA4yYvAQPQx8VF3cphsiRsULowX
 6sI6Mss6AwEZsnKW/H6pE4A8o=
X-Received: by 2002:a05:6000:2798:b0:45e:733a:a0ff with SMTP id
 ffacd0b85a97d-45ea31290bcmr2916217f8f.3.1779369470093; 
 Thu, 21 May 2026 06:17:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92ca4esm2870798f8f.22.2026.05.21.06.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92F3861015;
 Thu, 21 May 2026 14:17:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 14/16] MAINTAINERS: Cover python.docker with Python library
 section
Date: Thu, 21 May 2026 14:17:36 +0100
Message-ID: <20260521131739.540157-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62754d18341..bc054a6d97b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3484,6 +3484,7 @@ M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Maintained
 F: python/
+F: tests/docker/dockerfiles/python.docker
 T: git https://gitlab.com/jsnow/qemu.git python
 
 Python scripts
-- 
2.47.3


