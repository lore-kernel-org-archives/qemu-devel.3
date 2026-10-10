Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C58CA9ECE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 23:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFgJT-0001Ei-09; Sat, 10 Oct 2026 19:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJL-0001Dt-BB
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFgJI-0003qm-4Q
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 19:17:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AMBceu1771071
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=up199dogk/U
 bIVHHhg4rc/M5BP1+vi6CFnHEWl4UEG0=; b=JC2kFXG5zJ9ybrkgJJtE0l6uIiA
 xK1wbMaNS8v8EeVwK6vR7PYwrW0Lrm/ZcKq6K8WZLZAaNBSH9tBU7nUomw+8JVdb
 3uzZlxohcPvmcqlfRDxBzOvS2XO/FH5VuXNNxXw8jC3rHsrBt2qvgWWuRSShEufG
 3PzdO2E9jUfeTw4GyNHeGX9kho0QY34dMzEiUHhmuypA38g6/V66TI95iZK/mWIs
 QGIOstZ9Ct6kVyWegjHCPBLsAaDdi4L8Avf4nzVqBRUFiXNYxWG8nuq0jOk1P7dH
 RxMMICx/q1NGr/1UaaCEQmRNPEznTl//ABr9+Eg7/ZCi74aGlig8bNZsOTA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7deuhy2y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 23:16:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso1375870eec.0
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2026 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791674217; x=1792279017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=up199dogk/UbIVHHhg4rc/M5BP1+vi6CFnHEWl4UEG0=;
 b=O7z4kcQ6wdFASvxmzZ0HbX+cMJs8/VAJnS6Py3dhaRvhJW4YRlbL8y6rNZf7edVbBb
 a37WUUE6+rZ9PLBkUW9aELNG9adUlNnUUlOkR/AystMwxLsayIP3Vdi8VieIk4XD6kzL
 P84/xKZrjaishbH0yLdLFtDTZ5vfMEbXKtWHCMQGMpDLnXLrf/zRYzP3sJLYgarWxzGj
 N4bwVUc3+ZmxSPlQPMcYryxk074B0oYtZsDaZGNLRcRAkztvHTLET3Alwi2pp26BqwLZ
 OmNalgxDOaLYu9jTLp5mZHceEDBxZcUDiL4nrjE+rxWkby+UQi9dv1VzGY9szPlxiBAD
 j9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791674217; x=1792279017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=up199dogk/UbIVHHhg4rc/M5BP1+vi6CFnHEWl4UEG0=;
 b=1ZlkYnTZoQbY3l0mpMWNXQwyPqVx12rSJ4YHDJxtnhqBgsEJkf44ropJP7Hdbpn8oZ
 yy1cJeRnM45/i7zSlgXUkYEwbmL0lkvHE8dIsBfbmkY/PFOGS/DylqJrWPvzo7NWvIw3
 pYiDfmEFosL6nI9rgM2FLNhTIUNjmNbMgLrDGQ7gdwl5oKD7Pil/imYeKs83lyvlmjlX
 GeVIEkRKL1W2uZWCi5OIGtCXuYa/k7tNOSYK0vCVC9+Y0fLXNLQuK0DzuNPYc8nTWs1O
 ARZF7saE/1cl+f93+6KEpccS1yR0wvfqWjHmarvW1lxIz0JXUkrR1Z2VUvZSvyRk12Nd
 Eg5Q==
X-Gm-Message-State: AFq9FYLA02zrhz4imtjPSS4Vyyk+yoBKFYI/yWOklB/O5NFVUBncCzTj
 oVNZUh+jyJuJt3CsFOwuL/GktquAPLSnv7+AgHarjVZZk/X76Zukf9IQ9qKMMHWrXQpvvHRAZ1R
 YAXWQh03oRnZbkCM4fSrRo/Prd62MUnRoUQrmOxBd+go0nTJB1qc0afiGWsNdCA/FaQ==
X-Gm-Gg: AYBFou33f9JhRMepmqYbFFEFWUHxAKUAv3Yci3jNZQSpe7gKTm1aFn/fC1efMivB8n+
 8ZQNGIRDzzCDjV5elABuIhaZrDKDEZbKQBS95x5ARm7x1gBJ1IqOcOiiEDTKNib2+jf2wN9/UOg
 6SsCG2WuQqZbE/4TSl6Ofqgh0A5vDIPCxCbqTcWXMxIXbv8wS36r3YYHRQk0ds2+r+jannGLH9W
 WatSc2YoK6rF74TZDAZrtbOsmB1ofpQmQkQ4addFeqSc1mX04vMIq+7pSTXZstCWr9Phk4gFFaW
 HaemLTzM8HAyba10eF1R33GBvsFuCHS11bIXqmx923NsVEqxhchTKAwxt8IseESUPh6gpUF3by3
 e+aY7b2SrkzUCzZWDPA+T6Z22NrPSzOjVt4+s5+BUu50XL5tQLomaUkMPRkX0
X-Received: by 2002:a05:7300:538e:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3537e033581mr11272176eec.35.1791674216785; 
 Sat, 10 Oct 2026 16:16:56 -0700 (PDT)
X-Received: by 2002:a05:7300:538e:b0:34d:2c1a:987f with SMTP id
 5a478bee46e88-3537e033581mr11272147eec.35.1791674216177; 
 Sat, 10 Oct 2026 16:16:56 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca67b21sm18285396eec.11.2026.10.10.16.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 16:16:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, mjt@tls.msk.ru,
 peterx@redhat.com
Subject: [PATCH 1/3] tests/docker/dockerfiles: add release.docker
Date: Sat, 10 Oct 2026 23:16:46 +0000
Message-ID: <20261010231648.3105-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261010231648.3105-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JKYhfdHX4KNba3RFp7UaCAP_rNaol-XO
X-Authority-Analysis: v=2.4 cv=Aud7T+9P c=1 sm=1 tr=0 ts=6acac76a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=ID6ng7r3AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8
 a=GUVi8RmzAAAA:8 a=4HQkHWYM07Omh7VlaF4A:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=rjTVMONInIDnV1a_A2c_:22 a=jSdgSmmMQx7r16_JUfbt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX/+ADOkq3SK1k
 NoWPCRlJgKxuPbQimBHPOIAj2/Se6+Dd5R+dqLnf59EICSwIwfh6Qh+Ytx51qtlVjiZVCbPFvAy
 OoQZbYwsn47iwMKGvRo3nXh2pEzDzFw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA5MiBTYWx0ZWRfX1S/NWu7KbtSq
 BX8gFYPq2JOfDOOc2a+dYJ9rxhX+L47Al1d1IVpsKsOdOwE8ltuZv72xOGDUgyTKwjqwExWaP24
 P+dMc2V03wfKiAFwljokLNQyIc2Hg1LpagD8s0Ovl9zCvMIssduJLXwYesIj5Ukl1UWhN8dpBHQ
 LHcQ5Clx6ug/0frEwdsG8Jn2l0KsHtJVb64ov6u64vuRwEMdY1jt5DHZdjNVBtVfTTsKg49bhDd
 Enc+cVcH0osqEZL6xRGzzCb02vv17UtzYd9Umt/7uIZ/5eUhYmLm+Filv+P0voI0pc20CqHFPCE
 nIFakkq9QefOCdONi62OzOvoTNw43HiD2vp8TLZFhPDanw9Vk6/HuORoSVz+KMT11L5G+zN/7kr
 I3hBa32d5GEX2do4bAWGHsvrq4HaLdfKnRKxtrXRNsEgL25S3epZNXKiCeLZNTVfwztspUudgBd
 suPnp9yJJa5ay0QWKzg==
X-Proofpoint-ORIG-GUID: JKYhfdHX4KNba3RFp7UaCAP_rNaol-XO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This new dockerfile allows to build a distroless image containing only
qemu stripped release binaries, their lib dependencies, and installed
artifacts (roms, keymap, ...). There is no shell, no python, nothing
else. This is achieved thanks to a multi-stage build, where we add qemu
binaries, artifacts and libraries in a new scratch image. Image has
the minimal size possible.

This is based on Ubuntu, which has the advantage to have working
containers available up to 14.04. Debian old old stable have broken apt
sources for instance.

This unique dockerfile works for all qemu versions, with 1.6.1 being the
oldest we can build today (based on ubuntu 14.04). Previous ones need an
older compiler.

To build the image, you need to provide a qemu and ubuntu version:
$ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0

To run it, as there is no shell, and no defined entrypoint, you need to
choose the binary you want explicitely:
$ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version

Notes: We could optimize a bit further, by creating a base container for
each ubuntu version, that is reused between all qemu versions built with
it. Given that recent QEMU have around 800MB of binaries + artifacts,
and only 100MB of library dependency, I don't think it's worth the extra
complexity.

Notes: Also, I considered create one image per binary. Problem is
that qemu depends on other artifacts (rom, keymap, etc) and it's not
easy to identify what is needed for one binary. Thus, I think it's
better to stick to one container with all binaries per release.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 67 +++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 tests/docker/dockerfiles/release.docker

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
new file mode 100644
index 00000000000..24fcbf7c719
--- /dev/null
+++ b/tests/docker/dockerfiles/release.docker
@@ -0,0 +1,67 @@
+ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
+FROM ubuntu:$UBUNTU_VERSION as build
+
+# add deb-src for apt build-dep
+RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
+RUN sed -e 's/# deb-src/deb-src/' -e '/archive.canonical.com/d' -i /etc/apt/sources.list
+# archive.canonical.com is not reachable anymore, and cause a long timeout
+RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
+
+# use apt-get since apt was missing -y option in some ancient distro
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get build-dep -y --arch-only qemu
+# additional dependencies that are missing at some point in history
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build flex bison
+# python3-venv didn't exist in ancient ubuntu distro
+RUN apt-get update && \
+env DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv || true
+
+# patch cc and c++ to inject warning suppression options
+RUN mv /usr/bin/cc /usr/bin/cc.real
+RUN echo "#!/usr/bin/env bash" > /usr/bin/cc && \
+echo "exec /usr/bin/cc.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/cc && \
+chmod +x /usr/bin/cc
+RUN mv /usr/bin/c++ /usr/bin/c++.real
+RUN echo "#!/usr/bin/env bash" > /usr/bin/c++ && \
+echo "exec /usr/bin/c++.real \"\$@\" -Wno-error -Wno-int-conversion" >> /usr/bin/c++ && \
+chmod +x /usr/bin/c++
+
+# 2.9.0 => 3.1.0: clone git submodules from expired url, replace them with gitlab.
+# 2.9.0 => 2.11.0: issue with libfdt version, solved with dtc submodule, which
+#                  was removed later.
+ARG QEMU_VERSION
+RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
+RUN cd /tmp && \
+git clone https://gitlab.com/qemu-project/qemu --depth 1 --single-branch --branch "${QEMU_VERSION}" && \
+cd qemu && \
+sed -e 's#git://git.qemu.org#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#git://git.qemu-project.org#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#https://git.qemu.org/git/#https://gitlab.com/qemu-project/#' -i .gitmodules && \
+sed -e 's#git://github.com#https://github.com#' -i .gitmodules && \
+(git submodule update --init dtc || true) && \
+./configure --prefix=/opt/qemu --disable-docs && \
+make install -j $(nproc) && \
+strip /opt/qemu/bin/* && \
+rm -rf /tmp/*
+
+# retrieve runtime dependencies (libs + loader)
+RUN ldd /opt/qemu/bin/* | grep '=>' | sed -e 's/.*=>//' -e 's/(.*//' | sort -u > /opt/qemu/libs.links
+RUN find /lib*/ld-linux* >> /opt/qemu/libs.links
+RUN cat /opt/qemu/libs.links | xargs -n1 readlink -f > /opt/qemu/libs.realpath
+# store them in /deps
+RUN mkdir /deps && cp --parents $(cat /opt/qemu/libs.*) /deps/
+
+################################################################################
+FROM scratch
+
+# copy qemu and all associated artifacts (roms, ...)
+COPY --from=build /opt/qemu /usr
+COPY --from=build /deps /
+
+# build with:
+# podman build -f release.docker --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
+# run with:
+# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
-- 
2.43.0


