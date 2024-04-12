Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980D8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEHh-0007sC-4a; Fri, 12 Apr 2024 06:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEHY-0007ro-4i
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEHV-0007mM-Ja
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712918235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8ZvKcsH0ceQnfvo7hpTorewYLfN4OJB3ZHS+i24E7jA=;
 b=AlnYEEF1llgAQOmBTfEqZ62aaTMKOhH/5OAGDeLHF6yv2X3jTL+Hc1znkDc1X74fM1wZEd
 E+cYVLqDL2hTbDnrnL+BTna9cRY5xc/pVhilPb1PTNOCJUd95tHSal2tLytuuJVaXXZJTZ
 LuHtEpIy8WQNA5dviJdM5hFrd8UdgME=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-F7XT-X5bP0uVqVjsVde_zQ-1; Fri, 12 Apr 2024 06:37:14 -0400
X-MC-Unique: F7XT-X5bP0uVqVjsVde_zQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51eb0c14c8so33502066b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712918232; x=1713523032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ZvKcsH0ceQnfvo7hpTorewYLfN4OJB3ZHS+i24E7jA=;
 b=aJRpO+rYh5DC6uExLWp5XgftpADYf0Cw0cVVM0baYiHPeH1v/4NIgFOW1oCelcStNU
 KjGQQ51rSw2TPB6ZRODjvAlZ3KMr1Z4SMaakWPr8hUNKFeX3syCL23oWpKyn/QJHYn8j
 qq7xnF5wo09XrxltjbLIS+2v3pV7CteqPZWcpsXjyTxWt407gNT9Kcr0T2eGi+1QSDF4
 +hRyjZgE9SI2lLJlHFbwtJjsCN46Mf5DBo7dMFh7EgvA0dSYpk+yHVbQd2km4ml+kRug
 ocWjBo0nWGiQNBctgnwvfJ5XpYjJYABMxxSdd7WSsVe0ymT6QApt5MZbldID5Qf319gr
 9EYQ==
X-Gm-Message-State: AOJu0YzW+zWpmylSPYkvxH2LRNJTKw1tsfx6p1nxQr3Eanq/nu7xhlUu
 uHc7xBzH16TX5T28EhBMrj+qYQIoHr7a91DdT3Xz5Jz378u4lN5e2L3s4prc8yG+Fd6U8qV/S86
 JDE6AEW5DNzap7PkURPzecAKOop5O0cHV2D7Aw9OXxtD5gFTDaCyebBQULnx7KPRjnf/7NP5A2p
 A6mmfCozmnSiIFXlxlqdNvd5cyvzPeXBHaGRhp
X-Received: by 2002:a17:906:fa0e:b0:a52:396e:8cc4 with SMTP id
 lo14-20020a170906fa0e00b00a52396e8cc4mr722824ejb.68.1712918231754; 
 Fri, 12 Apr 2024 03:37:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFndm7FoTcjb+Ie2AvcnIAPEKj/R2MvSMJo8Zo2nRDdn39mFGsEWIpC8jFowRfifbjrBsKd3g==
X-Received: by 2002:a17:906:fa0e:b0:a52:396e:8cc4 with SMTP id
 lo14-20020a170906fa0e00b00a52396e8cc4mr722814ejb.68.1712918231192; 
 Fri, 12 Apr 2024 03:37:11 -0700 (PDT)
Received: from avogadro.local ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 nb17-20020a1709071c9100b00a4e6582edf8sm1645313ejc.102.2024.04.12.03.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:37:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com
Subject: [PATCH] ci: move external build environment setups to CentOS Stream 9
Date: Fri, 12 Apr 2024 12:37:08 +0200
Message-ID: <20240412103708.27650-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

RHEL 9 (and thus also the derivatives) are available since two years
now, so according to QEMU's support policy, we can drop the active
support for the previous major version 8 now.

Thus upgrade our CentOS Stream build environment playbooks to major
version 9 now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../stream/{8 => 9}/build-environment.yml     | 31 ++++++-------
 .../stream/{8 => 9}/x86_64/configure          |  4 +-
 .../stream/{8 => 9}/x86_64/test-avocado       |  0
 scripts/ci/setup/build-environment.yml        | 44 +++++++------------
 4 files changed, 34 insertions(+), 45 deletions(-)
 rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)

diff --git a/scripts/ci/org.centos/stream/8/build-environment.yml b/scripts/ci/org.centos/stream/9/build-environment.yml
similarity index 75%
rename from scripts/ci/org.centos/stream/8/build-environment.yml
rename to scripts/ci/org.centos/stream/9/build-environment.yml
index 1ead77e2cbf..cd29fe6f275 100644
--- a/scripts/ci/org.centos/stream/8/build-environment.yml
+++ b/scripts/ci/org.centos/stream/9/build-environment.yml
@@ -2,32 +2,32 @@
 - name: Installation of extra packages to build QEMU
   hosts: all
   tasks:
-    - name: Extra check for CentOS Stream 8
+    - name: Extra check for CentOS Stream 9
       lineinfile:
         path: /etc/redhat-release
-        line: CentOS Stream release 8
+        line: CentOS Stream release 9
         state: present
       check_mode: yes
-      register: centos_stream_8
+      register: centos_stream_9
 
-    - name: Enable EPEL repo on CentOS Stream 8
+    - name: Enable EPEL repo on CentOS Stream 9
       dnf:
         name:
           - epel-release
         state: present
       when:
-        - centos_stream_8
+        - centos_stream_9
 
-    - name: Enable PowerTools repo on CentOS Stream 8
+    - name: Enable CRB repo on CentOS Stream 9
       ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
+        path: /etc/yum.repos.d/centos.repo
+        section: crb
         option: enabled
         value: "1"
       when:
-        - centos_stream_8
+        - centos_stream_9
 
-    - name: Install basic packages to build QEMU on CentOS Stream 8
+    - name: Install basic packages to build QEMU on CentOS Stream 9
       dnf:
         name:
           - bzip2
@@ -42,7 +42,6 @@
           - gettext
           - git
           - glib2-devel
-          - glusterfs-api-devel
           - gnutls-devel
           - libaio-devel
           - libcap-ng-devel
@@ -61,22 +60,24 @@
           - lzo-devel
           - make
           - mesa-libEGL-devel
+          - meson
           - nettle-devel
           - ninja-build
           - nmap-ncat
           - numactl-devel
           - pixman-devel
-          - python38
+          - python3
+          - python3-pip
           - python3-sphinx
+          - python3-sphinx_rtd_theme
+          - python3-tomli
           - rdma-core-devel
           - redhat-rpm-config
           - snappy-devel
-          - spice-glib-devel
-          - spice-server-devel
           - systemd-devel
           - systemtap-sdt-devel
           - tar
           - zlib-devel
         state: present
       when:
-        - centos_stream_8
+        - centos_stream_9
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/9/x86_64/configure
similarity index 98%
rename from scripts/ci/org.centos/stream/8/x86_64/configure
rename to scripts/ci/org.centos/stream/9/x86_64/configure
index 76781f17f41..1b6f40fd785 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ b/scripts/ci/org.centos/stream/9/x86_64/configure
@@ -16,7 +16,7 @@
 # that patches adding downstream specific devices are not available.
 #
 ../configure \
---python=/usr/bin/python3.8 \
+--python=/usr/bin/python3.9 \
 --prefix="/usr" \
 --libdir="/usr/lib64" \
 --datadir="/usr/share" \
@@ -157,7 +157,6 @@
 --enable-docs \
 --enable-fdt \
 --enable-gcrypt \
---enable-glusterfs \
 --enable-gnutls \
 --enable-guest-agent \
 --enable-iconv \
@@ -180,7 +179,6 @@
 --enable-seccomp \
 --enable-snappy \
 --enable-smartcard \
---enable-spice \
 --enable-system \
 --enable-tcg \
 --enable-tools \
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/9/x86_64/test-avocado
similarity index 100%
rename from scripts/ci/org.centos/stream/8/x86_64/test-avocado
rename to scripts/ci/org.centos/stream/9/x86_64/test-avocado
diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index f344d1a8509..9b7d96c01b2 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -174,26 +174,26 @@
         - ansible_facts['distribution_version'] == '22.04'
         - ansible_facts['architecture'] == 'aarch64'
 
-    - name: Enable EPEL repo on EL8
+    - name: Enable EPEL repo on EL9
       dnf:
         name:
           - epel-release
         state: present
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_major_version'] == '8'
+        - ansible_facts['distribution_major_version'] == '9'
 
-    - name: Enable PowerTools repo on CentOS 8
+    - name: Enable CRB repo on CentOS 9
       ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
+        path: /etc/yum.repos.d/centos.repo
+        section: crb
         option: enabled
         value: "1"
       when:
         - ansible_facts['distribution_file_variety'] == 'CentOS'
-        - ansible_facts['distribution_major_version'] == '8'
+        - ansible_facts['distribution_major_version'] == '9'
 
-    - name: Install basic packages to build QEMU on EL8
+    - name: Install basic packages to build QEMU on EL9
       dnf:
         # This list of packages start with tests/docker/dockerfiles/centos8.docker
         # but only include files that are common to all distro variants and present
@@ -211,7 +211,6 @@
           - gettext
           - git
           - glib2-devel
-          - glusterfs-api-devel
           - gnutls-devel
           - libaio-devel
           - libcap-ng-devel
@@ -229,17 +228,20 @@
           - lzo-devel
           - make
           - mesa-libEGL-devel
+          - meson
           - nettle-devel
           - ninja-build
           - nmap-ncat
           - numactl-devel
           - pixman-devel
-          - python38
+          - python3
+          - python3-pip
           - python3-sphinx
+          - python3-sphinx_rtd_theme
+          - python3-tomli
           - rdma-core-devel
           - redhat-rpm-config
           - snappy-devel
-          - spice-glib-devel
           - systemd-devel
           - systemtap-sdt-devel
           - tar
@@ -247,28 +249,16 @@
         state: present
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-
-    - name: Install packages only available on x86 and aarch64
-      dnf:
-        # Spice server not available in ppc64le
-        name:
-          - spice-server
-          - spice-server-devel
-        state: present
-      when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
+        - ansible_facts['distribution_version'] == '9'
 
     - name: Check whether the Python runtime version is managed by alternatives
       stat:
         path: /etc/alternatives/python3
       register: python3
 
-    - name: Set default Python runtime to 3.8 on EL8
-      command: alternatives --set python3 /usr/bin/python3.8
+    - name: Set default Python runtime to 3.9 on EL9
+      command: alternatives --set python3 /usr/bin/python3.9
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - python3.stat.islnk and python3.stat.lnk_target != '/usr/bin/python3.8'
+        - ansible_facts['distribution_version'] == '9'
+        - python3.stat.exists and python3.stat.islnk and python3.stat.lnk_target != '/usr/bin/python3.9'
-- 
2.44.0


