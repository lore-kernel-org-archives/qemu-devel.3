Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51230606A336
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sMbF9dU7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNMR-00055c-LG; Fri, 06 Nov 2026 12:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNKK-0003de-I2
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:02:09 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNKI-00015q-Oe
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:02:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso9567335e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793984525; x=1794589325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=J1BVPmQZ/GJrSRCV+y9T1PrlQFktof+CTNDrPCUcoNA=;
 b=sMbF9dU7vfwjb23nkn+YcGNiJNbpqqJ2A1WYlwiIZxNgcxucClA0/fHetMRVaA+dPW
 UIsVW7sZRArQ6ZhkKIMTG6J81OSq5HbUhimiAyZTdB10SN/hdJt7dUtZWBLz/Kn2PdJc
 tCCDCh4523/tBYlU1QwEjmCVW3rI4ChMN8/nkP8jd/sPe0e+OOpUNlF1Yyrwd1/cK3/k
 Z68t0QMV8xHVOr474cbGpCbrtYdQ/7uKy0K2CvlXqdkXDoezux3gM7z+L4kTn0hHdI+d
 WjAXDEmabZFwZwMAEMYFMd5TcInxYZYhjAdwF5NLCPq1uBM/GPYRJUb98v5WyIZ0MQz2
 KXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793984525; x=1794589325;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J1BVPmQZ/GJrSRCV+y9T1PrlQFktof+CTNDrPCUcoNA=;
 b=I0iU4p78Dm96KnU7OzFdSuRg7hAti8MKCfuud6igdJLeQbx9KUFvY9ZjyGJ8bNl+Nr
 tLUt3VhGN1C+xo6Q71dLC8xwo6ePyAdl19+ZFoU7AwJhcqQVPB6MLWL43UaqoWJk0CQy
 i+x/aJOMuU0k862LefT+27ZU/Vmrkrsz9HOZhZocYD3rl4AwQsA+gY0NCUTW4S4Djz60
 Qyc33IStRpwjILHMAORckfGITO3mjzgmPu9DMpj3NpwRygrwsHF9A/gY9xrV6a+MGhQ9
 YU/9hAZEuuNzqW2wvePIJ615XPkelPo7AcAYsS0NN4bLDMGBK0CKS0AdRonrND3NcDr7
 g0MA==
X-Gm-Message-State: APuU4Z9rWmGCKYRIxTdejC3gdBgPIdtkc1Jk2qYhD4nRuu0idmyz3Twg
 9ATeiiB2u1Ge3PdDYCCJovQ5XjRQCCaf8CtcTiIrsn5YflM6owmZ+KkcU6ur6U1mSLBwXk3FAnd
 /Lyx7SVg=
X-Gm-Gg: AYBFou1Fs98o8Y0gkGDS/Mwqyw2xRGKNCR0CBkgs2TqhmN3UtZcvprNZ9bFfUcBWau1
 YsxZl/6Hrl96j9esdj4xJTgf+2nVMMWaCVXHFVS7QrrSo24IdHQUUAW68vJU6DY7PsejO2ZpiQE
 po30JSp/EpMlswLfEm5ri/dw6Y0jLH1mmIbdhFbdLdQJfqX9NXfdpsgTdyinL6F8tv3vvlYTva9
 CuhV0/jqs/7qmwy9L+5WMErJqvj6gp0JduXQ2dEQmSQI1k4T2TvA1PXsUwwGIMdP/Jj8rmqZdtU
 o+VkilKPV3ebVNYeUpDL/Nq82UPnO+tLqeNJ/SoTB6vZWz9wiA4svKQsFz7el+/qGEggynvqI1l
 9EgGRkWGj7/03qsP3qAkZlouTbAuYRaF7u/U09XSRTBe6pji8emarvjG47W+omz5lLscPWAXzQz
 sbvrQKR2tx+fuGUKvyWwzB7T/4POdqzsaSZhvOppRQzqd8VT51dIfhZ1xEvcZEgASMUSqKaGCV4
 XCntn1X0KIiWEP0ldF5/gu50+OMxvjA3sJr0NT1CdGFFjQTkTpVkbebQhh2lQJDiXZKAL3qyQZo
 iHS0YCkOa80yaTdCshW5+1/2sjiWLsqQ2+zWcpY6Hc5/HEPxyf5ZxjJ+jKx2QQFMqesJss5GtUa
 J7a5zztw2lNdSsxTVxMRa96yq+axpeSjs4g==
X-Received: by 2002:a05:600c:8718:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4b6ddcf599fmr56605395e9.15.1793984524704; 
 Fri, 06 Nov 2026 09:02:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7700224sm4878308f8f.33.2026.11.06.09.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:02:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 for-11.2] docs/devel/testing: iotests check script should
 be run via 'run'
Date: Fri,  6 Nov 2026 17:01:57 +0000
Message-ID: <20261106170158.3858169-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The iotests section of the testing documentation suggests directly
running the "./check" script.  However if you do this then the
script complains:

WARNING: iotests is being run from outside of the configure-time python virtual environment
[...]
Please use the meson run script:
        /home/pm215/qemu/build/x86-tgt-san-dbg/run ./check

Update the documentation to match this.  While we are here,
standardize on "run from the root of the build tree", which is how we
generally document running things under "run" (e.g.  the functional
tests), since the iotests don't have a dependency on their current
working directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: Use "./run ./tests-qemu-iotests/check", for consistency
with other uses of the run script
---
 docs/devel/testing/main.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index b0ca37fe2ba..3195f997e85 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -271,9 +271,13 @@ than "make check" tests and 99% of the code is written in bash or Python
 scripts.  The testing success criteria is golden output comparison, and the
 test files are named with numbers.
 
-To run iotests, make sure QEMU is built successfully, then switch to the
-``tests/qemu-iotests`` directory under the build directory, and run ``./check``
-with desired arguments from there.
+To run iotests, make sure QEMU is built successfully, then switch to
+the build tree and run the ``tests/qemu-iotests/check`` script via the
+``run`` wrapper which sets up the environment:
+
+.. code::
+
+   ./run ./tests/qemu-iotests/check [args]
 
 By default, "raw" format and "file" protocol is used; all tests will be
 executed, except the unsupported ones. You can override the format and protocol
@@ -282,22 +286,22 @@ with arguments:
 .. code::
 
   # test with qcow2 format
-  ./check -qcow2
+  ./run ./tests/qemu-iotests/check -qcow2
   # or test a different protocol
-  ./check -nbd
+  .run ./tests/qemu-iotests/check -nbd
 
 It's also possible to list test numbers explicitly:
 
 .. code::
 
   # run selected cases with qcow2 format
-  ./check -qcow2 001 030 153
+  ./run ./tests/qemu-iotests/check -qcow2 001 030 153
 
 Cache mode can be selected with the "-c" option, which may help reveal bugs
 that are specific to certain cache mode.
 
-More options are supported by the ``./check`` script, run ``./check -h`` for
-help.
+More options are supported by the ``check`` script; run
+``./tests/qemu-iotests/check -h`` for help.
 
 Writing a new test case
 ~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.43.0


