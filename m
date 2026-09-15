Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF7AC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbT-000824-KT; Tue, 15 Sep 2026 16:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZf-0006sZ-Df
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZb-0003J0-CY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:14 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so1683685e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503370; x=1790108170; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=VWEpMMhK2PIrUJfKgFNPVfZ7RKom+0iKk+vatiGQnwHLiMyS8Dndtk/kP0G3EVqqS/
 fmp8KMw53MXZM90xiDiaobtVZAkrtEcDIYLE4dyQdtf4b/hGxFJEYqgHD2n0WppZBoaQ
 m9ff+fQVr+9m0aYCNlCUDYsuD0Z57lalVZXuOJmf3Ifrr/Z9Nwo4lMvZpwj2hvVYNCtw
 ARz/csbtnbA3epiqGk761WqbvoGy7uluBsIj/u1UbWUyrm+PhgbwaKUWi6X9DnGtnNOM
 JSfAjsJAoZGrNAdlVNgcNn32//FEBG8D6eZtOFsuyU4oEWqUDOvRuf+0lcVRGLNVZSTQ
 L0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503370; x=1790108170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=985RXYgmuubKbGZhm5YGlCDe8xIWjFc7WGyDS1rZ3h4=;
 b=aEezQ1EMEOxRmZuOlRVjicb5AlqqoULTqRq475ZBFZsTLyRsOJMqV8v0QF5wlvWTNS
 6OK4ZJjQWg8dIrwAa/UrvKAUbtXYD6km06HAid1OuEfi3KyrW5C+Xxzbvy0aPVxxSJIA
 ycU+v1ebz7+mh1CVO5fPP7pqd9+r09fuDepM2PUDG0GeqlLBYb2glxE0UUJOoeEeMkyI
 I2ASN0D7MCzSuIT6fwhVfyn4lsVzZ0Bm2Y8siRKhhFKA3WQjJspZ6a35lzyIN9XLiffe
 L/eu2eT1gaUx292PW9ktWLct5FRUqG3hXsRAgNAzbviaiFsgs9/+iytIcRr45JgolrHr
 RRpA==
X-Gm-Message-State: AFuF++mAsJzFwGvJQMW3jzwSgExjvzmaRMQlBTgPO++FCr4SRd9A+UU0
 WnRQ5XpJYH5rG4RK/LCMHahj6yYuR/wJFFVx+oTVF6qGkcybeyTcZLGEILHd8L0vd0M=
X-Gm-Gg: AYBFou3cp6mG/FzI+xVNCNpcIfedk4+8EFtBmNE4m9yZV2jI2+A4BkVt/08goZ+DXy0
 gvG81o+nT12ab72g7Qyjb+9fUWFl+Ec2dWS8z9RgeVeubgqdVPB0DumsnbSEUFju5Fq3IZsm1Yz
 Zcb11sHfLC1sG78y4SFiOuZoK7eLP6cvxBAoUau7s0q8vdefkqefFPA06U7c8ESY+ft4Y2gfJr0
 Mfxt3Nb+I8EWIPMldyn6/XzylPxQJ2CxxkNV6xnIkmxarSYiKuu+z0EOG0DOVC4j3gP8S0jjkb5
 zT4vI1iOUOyyGMArXuFT3Eszi98JWgGLjV7+LXs04JlKM/uzyAfj5XRb4zTbY2Yds86qhvbMmAT
 qAHrjFhevVNzc0OgvvVMlMIETs/IhCrkrAsl+1merJS3hv6WjBrgWWHAgdBGN2iPt/o56/lKYbt
 KXrlNZofI1VU4TphhkjlbovzsUwvkT8b9ibQ8QGy1/ttTfMn2PfGbDzaNT7r9SZx5iE2Mxtgk=
X-Received: by 2002:a05:600c:3548:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49e822a8fccmr28817495e9.26.1789503369870; 
 Tue, 15 Sep 2026 13:16:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da071asm16257725e9.8.2026.09.15.13.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1582618F9;
 Tue, 15 Sep 2026 21:16:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 10/15] tests/docker: remove used _read_qemu_dockerfile
Date: Tue, 15 Sep 2026 21:15:55 +0100
Message-ID: <20260915201601.1207839-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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


