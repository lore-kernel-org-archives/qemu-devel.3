Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD35C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSE2-0000vH-4r; Thu, 16 Jul 2026 15:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSDt-0000qy-0p
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:58:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSDq-0000K9-Ju
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:58:20 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJooGY3841657
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1e9Jo1lVKu0FK+FZ4W5sslqq6VV+iUVq7ayVPUwQZVg=; b=nqmwwt22x2e+8Tox
 mbvWUKhUw+qzOEhg+lscHRzwlwFt1JWuTeuqKQRgDSwDLddMlhFyyutL+XsLZv5A
 Wx7aPmYy5x/0O/48AEGVv0mlG9seyZE0r7V8bZAAlcM1UijYf5N9r+G0LQyuIlxD
 O7n5L8I8oSGvp4QJlckDm4WTpqK0gA7K/cM0GpuTryPKEKhUNV5XQATuh8YUBal9
 VQVnCVt2CU4g+CfILp7ZAjSHHLP1+IRj+/K3NEWPujb1/U0Mh/OS8Dra+SpXv41X
 TLsPJEyMotyrawg223cRCUC+JQ/5Md9L6yJn6YlgXyW2vMr25670MeuUf1Q+g88t
 Yu6iyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u80hfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:58:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dad28e86eso8560068a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231896; x=1784836696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1e9Jo1lVKu0FK+FZ4W5sslqq6VV+iUVq7ayVPUwQZVg=;
 b=c/2aMoSZ06pHRWexE4FWOF06kP5Q3kBKoOmy7zCP6CFVsK13IL+wsNPJ/2P6Mbd1Uu
 symaexk7C+iRYZcnIbrCsDjIfE9y3g5WkUs+RbpuJRIvDF1rhHh1/rFyEFW/aqSuFGEl
 bkx9mNjuOoIuiprIAmYrrVjoWDaA8CaSG+qx8aNqpLl1JzrwXyWzIcd7dmblSxR6lIVr
 AoPiVzhEiJkkz9zFp4cjNYlc38NI1ZW6RmSJdywE9xwSBkOyaZj6AlH3MNGHOdlcHOej
 BKC42b0ddM5NQUzGjUetYLPBP2Kh13GG3waunCD9upRdSWFr2JP8YM1jMa8gCqzeRP5T
 txZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231896; x=1784836696;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1e9Jo1lVKu0FK+FZ4W5sslqq6VV+iUVq7ayVPUwQZVg=;
 b=ghxNYwQ3YM0MLLX01IIkqb3w8ANgbwb3eo926xcaAN4BFARgcqq+bysbJ5ZNhkZn6d
 tSqrptpHUVRehM4eAoGTcLHHdY5FcOuwHNYUlUxLmcAs/gE+RTz4luSHwGlUibm09bQ/
 TrNnJUAQca6mN1UymDvFXcQT8Y2MzEUX+IzpM4V/CFW7SeImxkO4PxyraroJ1ZWNIrMp
 vk+yB2SRx9zZOIW+PiGp/l36ORut8dXpXSo9GyNnHlob5mLLPxOwb1h0lE60aoeLdIOK
 a5/8T0xik/rH/neBTRCBxSqCktntJ4rKbk+SCN+5soSIf6LSbQ5v2aHynO8fwnH2IMmv
 xAWw==
X-Gm-Message-State: AOJu0YyH+HK3E0AuPwfF8A3mEr7so0xYvZDgzec4aN57AoB0l73U22hI
 ze9UoyA2GWsiw0FDuxEvfDdMl8PkxUWcAlAeyaJfo4hJ9btCB7o7LXtL/TbrWOHoSvRbmZZX1C3
 SLU4RXIciP9Z1XQ+DI1D3wWDuAlHyqXvoyEjetLTBLKW6gtL5h7E3sQD4fH2J/3Kvrw==
X-Gm-Gg: AfdE7cmcdIP3LdljREc7IndGntt+c2gfLW7wEreMPw2Y1k3wcsHbojk93Da/T+BzGTs
 YiF9IgPPIdryqwzivBtqYEFLwvwemoF8GWyXcWpO0FYJuMarZEM9LVMxNKKk9Gsd3OKAAx+TKyC
 VZldv4LRIs/71PVb3BqsAInjZVN5kd8vJpL5kP86k3bK/5RPHj6QFoKY9UCq0LrDlP/CrntsdRa
 SCNd1UDb1A0LC8mFvnVbjU3k6suWv09S8kk1kOpJYRATQut6bsYUQr5ds/vLF1VmlgKlKJPI2zP
 zAtFtv5XnW26fEDYgC09nuDpmEzDaKVJh0PVIUk3vh6QU4V4IgwSr1BAN6devyBY+LBfcLDwev2
 X3ZlpTm25NHfoy2O+4xRByZR5SWDLlPuZ4spufdG+02Ss6VpPdmsMiU8WqleazUJIW/fG6Hk=
X-Received: by 2002:a05:6a20:c783:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3c3a5aadb15mr698396637.3.1784231895906; 
 Thu, 16 Jul 2026 12:58:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:c783:b0:3c3:935a:af2c with SMTP id
 adf61e73a8af0-3c3a5aadb15mr698362637.3.1784231895375; 
 Thu, 16 Jul 2026 12:58:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c23c0sm14140471eec.24.2026.07.16.12.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:58:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/1] tests/docker: ensure container command is probed at most
 once
Date: Thu, 16 Jul 2026 12:58:07 -0700
Message-ID: <20260716195807.3219466-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfXzxxbKV+31Qgh
 S3bDfBXKxHAl6FeB7hYGQ3eMP2pk+CA6TEyRR3XRAwZU1TKxo2cEH89s6o86g6noHZNMYe5m6h0
 HM2meQCDl1ht4Wc/rpUo9GuO5In6OqicVt70j51kEuMHwj8FPKZ2YsO39ydSIAc5n9h1JPAs7J2
 MsFlCc89DK5RE+UMN3bmQeVq4VnGaaVXMxn6VL+4O03XQKmg3By78Msmb+DKtCBPKWiRlXlXsQR
 GjYlKQxt4er5M/QCN6gRtgAnF7mJ7k4fz2I8K8ZnU8gVSfiK6ixQnpmcd0DC9/NBmUjLOMzaQd5
 zPZP2VHSBI2DrGfkQUMDYTwfaAQhAfdwPRtbqlAL1O8z+XJ6yB5FbznOrL921fLDri9zLf5vIkz
 GSHKpsRSu5fiyQ9ZAGiTCWsaByoqchHASt8mAeoSx4GBSOt54yhGAI0GQ9XjGwzz9sMkuKtv09W
 3mZCU53wWL++BNirJmQ==
X-Proofpoint-ORIG-GUID: EhrRSMFzmNsDDjEGKeJBMVnpxBbDw6zT
X-Proofpoint-GUID: EhrRSMFzmNsDDjEGKeJBMVnpxBbDw6zT
X-Authority-Analysis: v=2.4 cv=VMvtWdPX c=1 sm=1 tr=0 ts=6a5937d8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8
 a=KJo2S6goiHL0rFSjrngA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfXy6gLPUZe9ln1
 rz1EoLZ/jKqtOGo18seheJgIO5ps5ebsIc04RZgw6tUprgZPCTV0RUJamiCyzb7xyjYeKYtC8j0
 yw8+Vp8+cr6PqfGMXIKvPJ61eTADMfw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The '--engine' arg accepts either 'podman' or 'docker', which is
not sufficiently granular to map directly to a command. This
means that  docker.py still has to then probe the exact command
to use.

Meanwhile the 'probe' command prints out the full command to use
but this cannot be passed back to docker.py to avoid probing
again, so the caching is only useful in the few case where we
run a container directly bypassing docker.py.

Address this by replacing --engine with --command for docker.py.

This in turn requires the --container-engine configure arg to be
replaced with --container-command.

With these changes the container command is probed at most once
during configure and never again, while running in an unconfigured
tree will still probe on demand.

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260716102515.1503404-1-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configure                     | 25 +++++++------
 tests/docker/Makefile.include | 13 ++++---
 tests/docker/docker.py        | 67 ++++++++++++-----------------------
 3 files changed, 40 insertions(+), 65 deletions(-)

diff --git a/configure b/configure
index d8bc10060e1..6ddfe4b5342 100755
--- a/configure
+++ b/configure
@@ -172,7 +172,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
-container_engine="auto"
+container_command=""
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -734,7 +734,7 @@ for opt do
   ;;
   --disable-containers) use_containers="no"
   ;;
-  --container-engine=*) container_engine="$optarg"
+  --container-command=*) container_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -869,7 +869,7 @@ Advanced options (experts only):
   --enable-debug           enable common debug build options
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
-  --container-engine=TYPE  which container engine to use [$container_engine]
+  --container-command=CMD  which container command to use [autodetect]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
@@ -1291,12 +1291,12 @@ fi
 ##########################################
 # functions to probe cross compilers
 
-runc="no"
-if test $use_containers = "yes" && (has "docker" || has "podman"); then
-    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
-    if test "$runc" != "no"; then
-        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
-    fi
+if test "$container_command" = ""; then
+    container_command=$($python "$source_path"/tests/docker/docker.py probe)
+    test "$container_command" = "no" && container_command=""
+fi
+if test $use_containers = "yes" && test "$container_command" != ""; then
+    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
 fi
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
@@ -1415,7 +1415,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
-    test "$runc" != no || continue
+    test "$container_command" != "" || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
       # debian-all-test-cross architectures
@@ -1736,9 +1736,8 @@ echo all: >> $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 echo "GDB=$gdb_bin" >> $config_host_mak
-if test "$runc" != no; then
-    echo "RUNC=$runc" >> $config_host_mak
-    echo "CONTAINER_ENGINE=$container_engine" >> $config_host_mak
+if test "$container_command" != ""; then
+    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test "$rust" != disabled; then
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 4725c39807b..0adddb6a5c6 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
 endif
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
-CONTAINER_ENGINE = auto
-DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(CONTAINER_ENGINE)
-RUNC ?= $(shell $(DOCKER_SCRIPT) probe)
+CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --command "$(CONTAINER_COMMAND)"
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
@@ -41,7 +40,7 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
 # General rule for building docker images.
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	  $(call quiet-command,			\
-		DOCKER_BUILDKIT=1 $(RUNC) build		\
+		DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
 		$(if $(DOCKER_V),,--quiet)		\
 		$(if $(NOCACHE),--no-cache,		\
 			$(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
@@ -152,7 +151,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 )
 
 docker:
-	@echo 'Build QEMU and run tests inside $(RUNC) containers'
+	@echo 'Build QEMU and run tests inside $(CONTAINER_COMMAND) containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -219,10 +218,10 @@ docker-run: docker-qemu-src
 			$(IMAGE) --executable $(EXECUTABLE),		\
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
-		$(RUNC) run 						\
+		$(CONTAINER_COMMAND) run 				\
 			--rm						\
 			$(if $(NOUSER),,				\
-				$(if $(filter docker,$(RUNC)),		\
+				$(if $(filter docker,$(CONTAINER_COMMAND)), \
 					-u $(UID),			\
 					--userns keep-id		\
 				)					\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9e18b984f45..d2f39b5645b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -35,27 +35,6 @@
 
 DEVNULL = open(os.devnull, 'wb')
 
-class EngineEnum(enum.IntEnum):
-    AUTO = 1
-    DOCKER = 2
-    PODMAN = 3
-
-    def __str__(self):
-        return self.name.lower()
-
-    def __repr__(self):
-        return str(self)
-
-    @staticmethod
-    def argparse(s):
-        try:
-            return EngineEnum[s.upper()]
-        except KeyError:
-            return s
-
-
-USE_ENGINE = EngineEnum.AUTO
-
 def _bytes_checksum(bytes):
     """Calculate a digest string unique to the text content"""
     return hashlib.sha1(bytes).hexdigest()
@@ -73,12 +52,11 @@ def _file_checksum(filename):
 
 def _guess_engine_command():
     """ Guess a working engine command or raise exception if not found"""
-    commands = []
-
-    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
-        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
-    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
-        commands += [["docker"], ["sudo", "-n", "docker"]]
+    commands = [["podman"],
+                ["podman-remote"],
+                ["podman", "--remote"],
+                ["docker"],
+                ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
             # 'version' is not sufficient to prove a working binary
@@ -222,8 +200,11 @@ def _dockerfile_verify_flat(df):
 
 class Docker(object):
     """ Running Docker commands """
-    def __init__(self):
-        self._command = _guess_engine_command()
+    def __init__(self, commandstr=None):
+        if commandstr is None:
+            self._command = _guess_engine_command()
+        else:
+            self._command = commandstr.split(" ")
 
         if ("docker" in self._command and
             "TRAVIS" not in os.environ and
@@ -411,8 +392,8 @@ def args(self, parser):
                             help="Run container using the current user's uid")
 
     def run(self, args, argv):
-        return Docker().run(argv, args.keep, quiet=args.quiet,
-                            as_user=args.run_as_current_user)
+        return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
+                                        as_user=args.run_as_current_user)
 
 
 class BuildCommand(SubCommand):
@@ -445,7 +426,7 @@ def run(self, args, argv):
         dockerfile = _read_dockerfile(args.dockerfile)
         tag = args.tag
 
-        dkr = Docker()
+        dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
             if not args.quiet:
@@ -512,7 +493,7 @@ def args(self, parser):
                             help="Docker registry")
 
     def run(self, args, argv):
-        dkr = Docker()
+        dkr = Docker(args.command)
         dkr.command(cmd="pull", quiet=args.quiet,
                     argv=["%s/%s" % (args.registry, args.tag)])
         dkr.command(cmd="tag", quiet=args.quiet,
@@ -590,7 +571,7 @@ def run(self, args, argv):
         tmp.seek(0)
 
         # Run the build with our tarball context
-        dkr = Docker()
+        dkr = Docker(args.command)
         dkr.update_image(args.tag, tmp, quiet=args.quiet)
 
         return 0
@@ -601,7 +582,7 @@ class CleanCommand(SubCommand):
     name = "clean"
 
     def run(self, args, argv):
-        Docker().clean()
+        Docker(args.command).clean()
         return 0
 
 
@@ -610,7 +591,7 @@ class ImagesCommand(SubCommand):
     name = "images"
 
     def run(self, args, argv):
-        return Docker().command("images", argv, args.quiet)
+        return Docker(args.command).command("images", argv, args.quiet)
 
 
 class ProbeCommand(SubCommand):
@@ -619,7 +600,7 @@ class ProbeCommand(SubCommand):
 
     def run(self, args, argv):
         try:
-            docker = Docker()
+            docker = Docker(args.command)
             print(" ".join(docker._command))
         except Exception:
             print("no")
@@ -651,18 +632,16 @@ def run(self, args, argv):
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
         cmd += [args.image, args.cc]
         cmd += argv
-        return Docker().run(cmd, False, quiet=args.quiet,
-                            as_user=True)
+        return Docker(args.command).run(cmd, False, quiet=args.quiet,
+                                        as_user=True)
 
 
 def main():
-    global USE_ENGINE
-
     parser = argparse.ArgumentParser(description="A Docker helper",
                                      usage="%s <subcommand> ..." %
                                      os.path.basename(sys.argv[0]))
-    parser.add_argument("--engine", type=EngineEnum.argparse, choices=list(EngineEnum),
-                        help="specify which container engine to use")
+    parser.add_argument("--command",
+                        help="specify which container engine command to use")
     subparsers = parser.add_subparsers(title="subcommands", help=None)
     for cls in SubCommand.__subclasses__():
         cmd = cls()
@@ -671,8 +650,6 @@ def main():
         cmd.args(subp)
         subp.set_defaults(cmdobj=cmd)
     args, argv = parser.parse_known_args()
-    if args.engine:
-        USE_ENGINE = args.engine
     return args.cmdobj.run(args, argv)
 
 
-- 
2.47.3


