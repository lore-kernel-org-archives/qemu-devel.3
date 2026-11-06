Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C9606A32F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jT8pboYq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIy0-0004qj-2A; Fri, 06 Nov 2026 07:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xPIx7-0004Ym-1W
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:22:00 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xPIx4-0007ys-SK
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:21:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so4107095e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793967709; x=1794572509; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2DW6Xzf4I84A5qxbaoRMU6DhXLmTOQg+Q4cDdubr34M=;
 b=jT8pboYqOk0LKjbGrOKksNUS1z7gAY8Oc4TQ+ffLd8KvTNhpBbeb6beSTsPfwsSH/w
 A/ctDtND8xjR55Pvnocs8VRj4W5jn3ckM+EmgBwZ8Xky7HgsSIBrNhUXKjMYRpOJnEvL
 5rtyJbQRvIIBgg0zeL1xCN9aI5tRotaQ19BsJqvmWrfXr1vKW6bcJ25P5J9RbtviRfzk
 xZom4ZG40SWxFoxKJdNjYq11sLc1PQkIDZXT9y9vi41qis7Uq95m0jHPN8vVaVBL8Ne4
 VO0AgoIihJwtMUWfJ3n+f7oQEJ7VAQD63FoxahWZ6mlcQ9awaq5+kcOLJtSwSdDtHjBi
 Y26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967709; x=1794572509;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2DW6Xzf4I84A5qxbaoRMU6DhXLmTOQg+Q4cDdubr34M=;
 b=SHPOPnuvqzqDodKSLBO9PwX3oLemdDQCGO67/WTDcwXo5fgd4lfblyforS1F35sfjc
 tkdNzY5rcl60YewGkrL/Duh3amC22BZUnRwGX9AhhkyKZinYzazhMifpy3gRVExKUx0+
 VpVjPUCcFQTQ/2ZUte7l8daWJMNe57dP97xBdqzIXL8f7zG6/XEsogcYU0VeYEOA2d5+
 btoZB4FnwisJFaeOcNwdl2nna81Zut96AVff7mBpm0rmomdeK0HDK41xIO0vcfRPC5xz
 bkTmoIPYlS6rqadJrAVxC9NDXMjQZ4mrSheaQNaR28GX7CYomI45Xl218OCSH6sLNdz4
 pPoQ==
X-Gm-Message-State: APuU4Z9lsvYIvRk/6ala+7uBHCHUAyQgx/xymLD4pm+w+pipmsC1Zsdo
 MlufRGEe+37eKtMPpo7Ivm6khCJBmN5Z7ERsCXtAx0fK0N9nQP/EWixTCHIcX7Q4Moo=
X-Gm-Gg: AYBFou2DgHTtVilhKBU3fka+D3N/n9kFCsD1ogOGMsEiYgS0Dt+w66Q0y0B7rdCxr7n
 VyORN4xxURof44wwYSrxj6R/y86roni/VWZU91D/g/UAoUkyJY/HIMmvnBr7lWOUvaf6THd/9mp
 e4Z1Rla/6jBIll90OfJiqeDYfcjOe7fQPOCSZXKnB0HbQoecimKvrO+IzFT2k0Y4P7d/kXsAVaL
 lfKxEog36Ku5hg2oUxBIETj++46UcjDE6rB5lkjMZm2DXZtETMRbfVv8i4EMHESy0mf0Jwq1BA7
 7vlNXCDfV5+JL+pL1lkF8dsktTJxdp4OnMtctIHUGtfUuzyQgiRDbt2CAz+gJnPs+zhnMNkWPU4
 GlaITiqu5z8BtSis815uTb9h2lFv5+SJuFzwWPov1qAXhSqDXXIxsGy5A81O+YvLJmW2kTuBg/H
 vYq9hlSeJ+moYc6GP4xqfoBlk4sVC5VRuLK+nCLlj0h/2kcEXEkRfxUrUyq5sCDVwoljp+qC8yd
 K9AsjGGnIE6aknfPFwQt/nsPeNxjtKFfiCe7IoPBLB/s3o4ruEYdZ0U3PMnOBqpSGntK0dSx5Yi
 NTzs5DzV311yYYi92WH8cwIdOMG4
X-Received: by 2002:a05:600c:3541:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4b6df029074mr39134805e9.13.1793967708469; 
 Fri, 06 Nov 2026 04:21:48 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b5725061e1sm147719865e9.7.2026.11.06.04.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 04:21:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C1AE5F81F;
 Fri, 06 Nov 2026 12:21:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [RFC PATCH] docs: add a diagram of the development process
Date: Fri,  6 Nov 2026 12:21:11 +0000
Message-ID: <20261106122111.3005638-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

We've had various versions of this diagram for a while so I thought it
would be worth adding to the developer docs. I chose plantuml as it
has a plugin for sphinx that we can use and supports sequence diagrams
which could be useful for documenting other features in the code base.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
vRFC
  - I've bundled all the plumbing together in this commit but it can
  be split up if we want to go forward.
---
 docs/conf.py                    | 22 +++++++++++++++
 docs/devel/index-process.rst    | 47 +++++++++++++++++++++++++++++++++
 docs/meson.build                |  3 ++-
 docs/requirements.txt           |  1 +
 configure                       |  6 +++++
 pythondeps.toml                 |  1 +
 tests/lcitool/mappings.yml      |  3 +++
 tests/lcitool/projects/qemu.yml |  1 +
 8 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/docs/conf.py b/docs/conf.py
index 914bae67d9c..9fc7be362ba 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -66,8 +66,11 @@
     'qapi_domain',
     'qapidoc',
     'qmp_lexer',
+    'sphinxcontrib.plantuml',
 ]
 
+plantuml_output_format = 'svg'
+
 # Add any paths that contain templates here, relative to this directory.
 templates_path = [os.path.join(qemu_docdir, '_templates')]
 
@@ -345,3 +348,22 @@
 qapidoc_srctree = os.path.join(qemu_docdir, '..')
 dbusdoc_srctree = os.path.join(qemu_docdir, '..')
 dbus_index_common_prefix = ["org.qemu."]
+
+
+def setup(app):
+    import docutils.nodes
+    import sphinxcontrib.plantuml
+
+    # We manually setup the plantuml extension so we can skip nodes with
+    # diagrams when generating the text based output.
+
+    def skip_node(self, node):
+        raise docutils.nodes.SkipNode
+
+    app.setup_extension('sphinxcontrib.plantuml')
+    app.add_node(
+        sphinxcontrib.plantuml.plantuml,
+        override=True,
+        man=(skip_node, None),
+        text=(skip_node, None),
+    )
diff --git a/docs/devel/index-process.rst b/docs/devel/index-process.rst
index ce0f4e73197..1c13dd3f7b5 100644
--- a/docs/devel/index-process.rst
+++ b/docs/devel/index-process.rst
@@ -5,6 +5,53 @@ QEMU Community Processes
 
 Notes about how to interact with the community and how and where to submit patches.
 
+.. uml::
+   :caption: QEMU Patch Review and Acceptance Flow
+
+   @startuml
+   skinparam roundCorner 8
+   skinparam shadowing false
+   skinparam defaultFontName monospace
+   skinparam sequenceMessageAlign center
+
+   actor "Developer" as dev
+   participant "QEMU Community\n(qemu-devel)" as list
+   actor "Subsystem\nMaintainer" as sub
+   actor "QEMU\nMaintainer" as top
+
+   dev -> dev: Develop & test feature
+
+   loop Needs revision (v1, v2, ... vn)
+       dev -> list: Post patch series to list
+       note over list: Code review on list
+
+       opt Review comments
+           list -> dev: Feedback & change requests
+           dev -> dev: Incorporate feedback
+       end
+       opt Review tags
+           list -> dev: Tags (Reviewed-by, Acked-by, ...)
+           dev -> dev: Apply tags
+       end
+
+       dev -> dev: Prepare n+1
+   end
+
+   group Patch acceptance & release
+       list -> sub: Maintainer accepts some or all patches
+       note over sub: Incorporates patches\nfrom other developers
+       sub -> sub: Add Maintainer Sign-off
+       sub -> sub: GIT branch foo/next
+       sub -> list: Sign & Submit Pull Request
+       list -> top: Pull Request delivered to list
+       note over top: Pull Requests from\nother maintainers
+       top -> top: Test and Merge Pull Reqs
+       top -> top: qemu.git master
+       top -> top: Tag Release
+       top -> list: QEMU Release
+   end
+   @enduml
+
 .. toctree::
    :maxdepth: 2
 
diff --git a/docs/meson.build b/docs/meson.build
index 4d8cc545fcc..600d3283299 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,9 +1,10 @@
 sphinx_build = find_program(fs.parent(python.full_path()) / 'sphinx-build',
                             required: get_option('docs'))
+plantuml = find_program('plantuml', required: get_option('docs'))
 
 # Check if tools are available to build documentation.
 build_docs = false
-if sphinx_build.found()
+if sphinx_build.found() and plantuml.found()
   SPHINX_ARGS = ['env', 'CONFDIR=' + qemu_confdir, sphinx_build, '-q']
   # If we're making warnings fatal, apply this to Sphinx runs as well
   if get_option('werror')
diff --git a/docs/requirements.txt b/docs/requirements.txt
index 509d56bd1e8..1cafcbaa38f 100644
--- a/docs/requirements.txt
+++ b/docs/requirements.txt
@@ -3,3 +3,4 @@
 
 sphinx==7.2.6
 sphinx_rtd_theme==2.0.0
+sphinxcontrib-plantuml==0.30
diff --git a/configure b/configure
index 42dffed28f0..b0dedde65dd 100755
--- a/configure
+++ b/configure
@@ -1020,6 +1020,12 @@ if test "$docs" != "disabled" ; then
         fi
         echo "Sphinx not found/usable, disabling docs."
         docs=disabled
+    elif ! has plantuml; then
+        if test "$docs" = "enabled" ; then
+            error_exit "plantuml not found"
+        fi
+        echo "plantuml not found, disabling docs."
+        docs=disabled
     else
         docs=enabled
     fi
diff --git a/pythondeps.toml b/pythondeps.toml
index c9a697046c6..c21d127ec93 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -30,6 +30,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
 # Please keep the installed versions in sync with docs/requirements.txt
 sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
+sphinxcontrib-plantuml = { accepted = ">=0.5", installed = "0.30" }
 
 # This test group is for dependencies required to run various tooling
 # and tests that should always be installed at configure time. It should
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index c99f007798e..eca6748ac09 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -3,6 +3,9 @@ mappings:
   bindgen:
     Ubuntu2204:
 
+  plantuml:
+    default: plantuml
+
   python3:
     CentOSStream9: python3.12
 
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index abbd3e3f0b8..de4395cd3c7 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -89,6 +89,7 @@ packages:
  - pcre-static
  - pixman
  - pkg-config
+ - plantuml
  - pulseaudio
  - python3
  - python3-numpy
-- 
2.47.3


