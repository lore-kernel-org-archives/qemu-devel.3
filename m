Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF8BC982D6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FPu-0007y0-VJ; Thu, 17 Sep 2026 12:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPS-0007kg-BC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:31 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPQ-0000qQ-OQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:30 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350faaso682793f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664187; x=1790268987; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=++nhsAjVYxHqC7ITngNw+KCNgr01nqcmt43kfCcAxLk=;
 b=jbibokHQ542O8uMXsNu1t5mGejUGqJsxwWy1uNInCxCuAbzYNCjvrWhI3LoRXX5+4F
 vHv5ZGXK/qS1aL5gWfVMzep6L5CPiVyAk4y9wCaBFDK5M/F5XwF6qyE3klQXhEopMPrd
 y6nJ/7qb5Z1g26untEiSuBKhehvrrTE+708NvJ9YE5FpyX8E0KTsO8Iz6A86LCNEr5vt
 uZyuClOofQaa25tymqp9I4zJo+//KDNNBDJa3kCfoCuzpoMjq10YlFi0JN90poJy9TDi
 XqMIyzy50xf7uHMisdQ0pCvIInZ+3c2RP5XWIVB2FhMVYT/R06xL/mQnA3Tc0aZpsuAj
 6ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664187; x=1790268987;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=++nhsAjVYxHqC7ITngNw+KCNgr01nqcmt43kfCcAxLk=;
 b=tTDscVUk5Bx3GTGT0CnNZcjYSDpMHkiC6hOvt7Nt6NJaJ3LQPmriDYT5WxZ0TSmqQm
 HfRD7m6/F6mQhPPh44lh9ZrDXPP+mL/Gnp20xdqnNk8UNuAc6gg0RRa/IPLtXPbuupBZ
 kAIz4GKZk1Sji9lnf4lJKdbIMwurFHgoTs5ldV+I3qrUimkbU04NRvFbTq6ZyYMXknGI
 BKid+9e0iP7Duxmp7CpD3lvKuR22Kdrm/HBH0EKvg3sYwO/DKoWh0Ar9mY1lJW2ySYqv
 Ryabm7V0dPIhHZ7IN4H+uuWmbZYZNmJtJCLp3GFn0K3FLeF40udsFULCXthDXVxAcqul
 53pA==
X-Gm-Message-State: AFuF++lY7VTrn6ZjfYbv9UQg7Zyf+xe68ry+c7zV8EmRrKfWFCMzd9Am
 d+GfoFpbVmROjHq9pKjVMP+xopXroxmYMdzs4a8S9yh+9iVRQVHVIt/+LQZMIs0sMGA=
X-Gm-Gg: AYBFou0GsfWDhkMHtGu7Bxkm3Ts31Tm4vNyWlnYbDXknQSV3txcGdGbuR0b0wtFuBfm
 qNTILb5oXN7gi6Nz/LpO6hCuvCgGt9Wnimy2DFytWqZtqINu9C5QXrgSNBFmW/jqodjoW6HGdhD
 hDNvIYhwwIfducGAJBXiQ9NMjrsvQlNehwo3yf2FHsACS6cJskxnBDGmFbB83gOKAZNQRBiAWVH
 tfgM2ivMeqQ5MzHS4hoir7qvCWlJ0zzqBUNwLz5Bxmdgmf9FzpwpDWiO/PQswGAdmET3zcxQhB4
 qwTszgUvd/Nz5cFt6fea+YpiB25VNEMG9b4O9fLjNTcA/uO36HsWkn4aD9zt24ERWg2x/bB4DwP
 /i9pgaUSh8hZS+ziljT4H5U4DQi6gwOstKlMLNpcS0FB1UWh+QmwlLi/p+b5Ice8b0DdAf5T0+z
 RAIsHHRLvne4/tipWxGHSSyMhX2JXBvPsCxRb0zX3751ldJqlpHBzR/s/DbOSUeYTHQXyEM+Y=
X-Received: by 2002:a05:6000:1884:b0:487:71a:be5e with SMTP id
 ffacd0b85a97d-4870d067873mr10557384f8f.28.1789664187325; 
 Thu, 17 Sep 2026 09:56:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa70sm16797285f8f.9.2026.09.17.09.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3DC5A5FC4B;
 Thu, 17 Sep 2026 17:56:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 10/17] tests/docker: remove used _read_qemu_dockerfile
Date: Thu, 17 Sep 2026 17:55:54 +0100
Message-ID: <20260917165602.3405537-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

This is no longer needed since the functionality using it was removed.

Fixes: 07056db1b50 (tests/docker: remove FROM qemu/ support from docker.py)
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 10 ----------
 1 file changed, 10 deletions(-)

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


