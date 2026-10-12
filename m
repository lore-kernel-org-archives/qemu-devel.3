Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F8CCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSj-0006PI-I0; Mon, 12 Oct 2026 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRh-0005IU-GM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:18 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRa-0007DH-Vh
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:14 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2e5d08214dso272899066b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824649; x=1792429449; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=puq+I/f1P3zHu9XcUtJORJDrkzlXLnBkSTnzbUTtoew=;
 b=CYS/YFFyOq+OhxYhhPTOGgW9J/OMy7B2HDpSj7Ib4P8GTdpi4b3npPRr8N1Wbjv9E2
 pkE2EWgAZPIMGgeOJ5FUsJzdcHwl9QZtRiiSZasIFpX5P/5kB/xoidEMriRtjaD4HpWS
 S4Y8pmrFgiHSGO7noKjLptwT471LpMEkZrXIvXdEpDtgWPKpm5S53gemQP5nOXdYh/u1
 ljIgoKkAqy84NMk/xnxteJCpKSTRGCsfC7E7Uu90pm25tvoRsCF+bhtoKNs6JYMXBM+G
 CEj6FaLlXX2Rtf9AHb1O+3zehmUNRvGsnAy5xFJtG8xTuRqbVD6N9ZnHk5VlmeHK1Xph
 sivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824649; x=1792429449;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=puq+I/f1P3zHu9XcUtJORJDrkzlXLnBkSTnzbUTtoew=;
 b=d232y2NVXAmmLeqvdSG2+ip50q0+JJv3t7TkbOGgGaKqAA4EVjrZbEhlGECT7caxMb
 +FauTIoKaSkGB4WzCAC9E0CSgSW0+2UIHZC1W7xqGWaQKFXggqAWIwN1od10huAtxrNV
 fmhI6u7lMGg82OWWrTsi9I18R6mNeeIZsi2zvzKZa7LBI1gZeo0RAExiznR+6GoaliFq
 Pt5G85/qozXOvjp1hMO9sWBcMwFUz9x7V7Ld7XgK0eEjtQvS31h3eZUUTF0odM1MyRIT
 AqbA0uN5MwvuLWccdjy7bWAFzisZoj2yX0nqok1FEC5STefC5jE65Ni8wK2vy6afWQrt
 DFog==
X-Gm-Message-State: AFq9FYKxSlTCf3wE6ajfbRprKcAtBXRcrHjO9gvxZpNvNiZpqJOK8m5F
 CgEKNbX15Nb5UGmUWvHYScI7bGi/qHG9NB6+SoUJoNCc3jsBIupPhAp6Cwj3WiMrwDZfC3288VX
 SsDNzLJU=
X-Gm-Gg: AYBFou3vRnWGz9+O8PZqeqdWNrOpEQsT150YOhmNWHHTsT2ganmAg1qOBysAQbqHqZe
 Sjg6BZD04fVLUCRH8F8GLBHoYAb+o3yqmFbqXAF5brVeDrzsM82Ab46p5FocxUT2lL/j0ODU6gG
 7HFVJm5HTmf+MrbqE7GckXH3YpMG0YBe5jl6f7ACG8xZWRfMydqLCJAsHaZrrQiljWJZDyfjhBE
 ImeDfDWV45L2akkuXsKFhDwtN49GELDhw5xtizKHdru9XlSTMJoRy0QSR8O0nR4QT16N9ZU6Tup
 m+9hhKHs0oL/8I+hFXaVLOt9XYrifaFSSOB3zXX8JfzaTBnCZ4r38E1XcAZfWYBhzytTI1ro+J/
 sQ1Rzh0ZoMbf+TQFeHksQgS4/jgUAXBXT5sDlQvkKFKrHefWQV6GK1suENBjszWiu9Sk5O9rl4s
 uSNsWqFG/XdOOhSH0WNxy6qEP1PN3H6CtGYHhwB0i8DsygeLuWPOCawjPVZ8VlMspqHaTFLfc=
X-Received: by 2002:a05:6000:298e:10b0:487:2387:7c9 with SMTP id
 ffacd0b85a97d-48dbaadb47emr14052488f8f.14.1791824630035; 
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6b82sm387958f8f.51.2026.10.12.10.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:33 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 530B85F9D3;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 03/16] meson: move gdb detection into the top level build
 file
Date: Mon, 12 Oct 2026 18:03:17 +0100
Message-ID: <20261012170330.1144446-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Currently gdb is only used by TCG based tests but hypervisors want to
use gdbstub too. To be able to test this case we need to always probe
and report the gdb we have.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                  | 15 +++++++--------
 tests/functional/meson.build |  5 ++---
 tests/tcg/meson.build        |  5 -----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 48da6cf3e6b..99c836b3ae6 100644
--- a/meson.build
+++ b/meson.build
@@ -163,6 +163,12 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
+if get_option('gdb') == ''
+  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
+else
+  gdb = find_program(get_option('gdb'), required: true)
+endif
+
 edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
@@ -4720,14 +4726,7 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 summary_info = {}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
-
-# FIXME: the [binaries] section of machine files, which can be probed
-# with find_program(), would be great for passing gdb and genisoimage
-# paths from configure to Meson.  However, there seems to be no way to
-# hide a program (for example if gdb is too old).
-if config_host.has_key('GDB')
-  summary_info += {'gdb':             config_host['GDB']}
-endif
+summary_info += {'gdb':               gdb}
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 if host_os == 'windows' and have_ga
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c7362dd00ef..68c601d4036 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -83,9 +83,8 @@ foreach speed : ['quick', 'thorough']
                      separator : ':')
 
     # Define the GDB environment variable if gdb is available.
-    gdb = get_option('gdb')
-    if gdb != ''
-      test_env.set('QEMU_TEST_GDB', gdb)
+    if gdb.found()
+      test_env.set('QEMU_TEST_GDB', gdb.full_path())
     endif
 
     foreach test : target_tests
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4c0e30756d5..f46216521c2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,11 +1,6 @@
 env = find_program('env')
 
 docker_wrapper = find_program('../docker/docker.py')
-if get_option('gdb') != ''
-  gdb = find_program(get_option('gdb'), required: true)
-else
-  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
-endif
 prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
-- 
2.47.3


