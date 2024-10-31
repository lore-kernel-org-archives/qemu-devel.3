Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291A8E68954
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MQv-0003po-Cy; Thu, 31 Oct 2024 00:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQi-0003ef-RB
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6MQh-0004qs-4Z
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:05:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cbb1cf324so4545895ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730347502; x=1730952302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stB6xsCXZvGGgXKJAPY9QdgEF+16xwQAb0j6tVuAwQI=;
 b=QJ3fHpt2h4XeDHUo0UbLB4hh7VNbO1TvqaAuymV3ZpFgjA7R1yVesL31n0Y7R7JDqX
 UcKymBK60J80KUcKtYH9SYgKhNPd3OOUwOEoLINp5C3HMXwqPWmOiHO5E4ww7Y9IPBt3
 geIDUwuLz87JBx6ZvxyEPSCXliaJH48DNGHBJ7gt9go9KU5+GAdKu2Cb1uEQAATj1KqT
 phQ1OghgGaFT3BJeYd6u9Y5N/gtPdjzYeCFdYhnyy3RGnkyF+/wo3jWiwyBBr81I4+xq
 BoQSBv/EhXqqQHKEoSKvyc1RthM1ba8ADO0lFrWbP6kxJ9syFYkqxzOWuBXplGs2NMI1
 5dMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730347502; x=1730952302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stB6xsCXZvGGgXKJAPY9QdgEF+16xwQAb0j6tVuAwQI=;
 b=w2rwUJf44AkCP7F+EaQV2YwL8IE4K32AECRQFtq5n2jQFdE/dDNN7+k6QPFKvmhdZC
 IiQTDS3ZjBMQBxAEXfIQriFsvQIxgf1j3YhhTIqFVFSuzV2jaxeKCqjli8dfSkNiwq5F
 LLhL/0LrsLNyym1x6KNisc0+hYkIRH+TmAnGGeHTnRgVRqCJDGYqvGrbPDSL2BPU1J8d
 DHNahCYI1CMMlP4/ef1DhxPPZcD00UxV44Cmbz3wE6MqMe1s2OOw/tVsXLQs0O1mvdRG
 Pzk1TGrJG4BOeJHv8Vj3beOXYWNVqxcw6k7VZ2rzet7mxsOPQeO3b8pE62f2PPgvqbqF
 FViQ==
X-Gm-Message-State: AOJu0YwwCVt5/SFa1y9VVStO5wCErgN17yKza2Rc96AE7lSTYx4FV0Yk
 dydK7CCwnLcA7saGA0kfPIfxqac04FbwHRLZFeO2/w4IiWzTgEof+sUx0MOYVzPebJ02XxVbZpX
 LZZc2tg==
X-Google-Smtp-Source: AGHT+IEyNjojfk3YLrfbuYwwa6l3GsRh8rmuKIQ9uchPrZ0E4gGV0nFH3OnCIuZG5z3c0+Wx+bkACw==
X-Received: by 2002:a17:902:eccb:b0:20e:5792:32ed with SMTP id
 d9443c01a7336-210c6c6cf5bmr217904555ad.41.1730347501863; 
 Wed, 30 Oct 2024 21:05:01 -0700 (PDT)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e93db3a023sm428438a91.49.2024.10.30.21.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 21:05:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 05/12] qga: fix -Wsometimes-uninitialized windows warning
Date: Wed, 30 Oct 2024 21:04:19 -0700
Message-Id: <20241031040426.772604-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

Reported by clang, but not gcc.

[5123/5678] Compiling C object qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
FAILED: qga/qemu-ga.exe.p/commands-windows-ssh.c.obj
"cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi" "-Itrace" "-Iu=
i" "-Iui/shader" "-IC:/msys64/clangarm64/include/glib-2.0" "-IC:/msys64/cla=
ngarm64/lib/glib-2.0/include" "-fdiagnostics-color=3Dauto" "-Wall" "-Winval=
id-pch" "-Werror" "-std=3Dgnu11" "-O2" "-g" "-fstack-protector-strong" "-We=
mpty-body" "-Wendif-labels" "-Wexpansion-to-defined" "-Wformat-security" "-=
Wformat-y2k" "-Wignored-qualifiers" "-Winit-self" "-Wmissing-format-attribu=
te" "-Wmissing-prototypes" "-Wnested-externs" "-Wold-style-definition" "-Wr=
edundant-decls" "-Wstrict-prototypes" "-Wtype-limits" "-Wundef" "-Wvla" "-W=
write-strings" "-Wno-gnu-variable-sized-type-not-at-end" "-Wno-initializer-=
overrides" "-Wno-missing-include-dirs" "-Wno-psabi" "-Wno-shift-negative-va=
lue" "-Wno-string-plus-int" "-Wno-tautological-type-limit-compare" "-Wno-ty=
pedef-redefinition" "-Wthread-safety" "-iquote" "." "-iquote" "C:/w/qemu" "=
-iquote" "C:/w/qemu/include" "-iquote" "C:/w/qemu/host/include/aarch64" "-i=
quote" "C:/w/qemu/host/include/generic" "-iquote" "C:/w/qemu/tcg/aarch64" "=
-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=3D64" "-D_LARGEFILE_SOURCE" "-fno-stric=
t-aliasing" "-fno-common" "-fwrapv" "-fno-pie" "-ftrivial-auto-var-init=3Dz=
ero" "-fzero-call-used-regs=3Dused-gpr" -MD -MQ qga/qemu-ga.exe.p/commands-=
windows-ssh.c.obj -MF "qga/qemu-ga.exe.p/commands-windows-ssh.c.obj.d" -o q=
ga/qemu-ga.exe.p/commands-windows-ssh.c.obj "-c" ../qga/commands-windows-ss=
h.c
../qga/commands-windows-ssh.c:383:9: error: variable 'userPSID' is used uni=
nitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitializ=
ed]
  383 |     if (!create_acl(userInfo, &pACL, errp)) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../qga/commands-windows-ssh.c:415:15: note: uninitialized use occurs here
  415 |     LocalFree(userPSID);
      |               ^~~~~~~~
../qga/commands-windows-ssh.c:383:5: note: remove the 'if' if its condition=
 is always false
  383 |     if (!create_acl(userInfo, &pACL, errp)) {
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  384 |         goto error;
      |         ~~~~~~~~~~~
  385 |     }
      |     ~
../qga/commands-windows-ssh.c:380:18: note: initialize the variable 'userPS=
ID' to silence this warning
  380 |     PSID userPSID;
      |                  ^
      |                   =3D NULL
1 error generated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/commands-windows-ssh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
index 6a642e3ba81..df45c17b757 100644
--- a/qga/commands-windows-ssh.c
+++ b/qga/commands-windows-ssh.c
@@ -377,7 +377,7 @@ error:
 static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
 {
     PACL pACL =3D NULL;
-    PSID userPSID;
+    PSID userPSID =3D NULL;
=20
     /* Creates the access control structure */
     if (!create_acl(userInfo, &pACL, errp)) {
--=20
2.39.5


