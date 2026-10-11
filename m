Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85469CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFwP7-0001Zm-5o; Sun, 11 Oct 2026 12:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP5-0001Z7-3n
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xFwP2-00078D-TD
 for qemu-devel@nongnu.org; Sun, 11 Oct 2026 12:28:02 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85crX2954362
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LB96PXPlZyF
 zeseItNhsm9LBmKTAImNw8DavHlYT6lI=; b=CgE5Yr5Eu0XJMwcNqEErHFv7ziW
 QN5b8yupDRA6ScoTmDd+FqlwysE/a0ujoI6lrTnmNBaD5Qlzz1FWiMvDy5k5K3xI
 Zjt+uDHGt4VyNIGiPzVhOfFe0BCN6jY2VA/21vvroqgloR+SIs+qUKk4/WzJtHZj
 sc3YgDlIFUOyUnyO+ZQreadHy2dqSSmOZIbGF0qCWrwF1kVJzi0gLk92+ohRAOEx
 E8sVbkM7bIt1nz4KlR9Q6cKWFc+5HuuYnXQM5X+Kqc0oi/yAtSXABpx1lj6JOfZt
 kU1pTbMQehWzT97XKhZHOhzxvsoz3A43iOA/7qdbSScoXoCqFPj/KRVr7Sg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7deukb8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 16:27:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35ac5255f1dso21330eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791736079; x=1792340879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LB96PXPlZyFzeseItNhsm9LBmKTAImNw8DavHlYT6lI=;
 b=HTOl/n2Cjuv3JZ9n6ljnfYilfnRv/B76yhqFHAMue566WiGveYvbZXCpfHraKsA03K
 8FbRHSWT8r2TLO1zt6XK53JVa6U727i49TOAAqWtJxra5Qe6ZxjXoQlUrtNi2mRvk0nm
 VDe4WfOFfufd+4z1p9XsLP07uzEEQDJ8GGIdrhIX4s+j8V9+gsNR+ezBagAySU/SvT+c
 hQRqy1ncHLiD9FkyI8Tu5zMd3/UEqH3z+A6QMGjPwnBwc66xjJLtQTgxbVL+6e54DojN
 RoBSvjYHBW7WD1BgaxiWNB1j9fDEbKPYy7vBdwgSAxMETbidnZNq4TUr2MRDmP3ujX0a
 Ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736079; x=1792340879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LB96PXPlZyFzeseItNhsm9LBmKTAImNw8DavHlYT6lI=;
 b=gkFBJKwKkQrU/gzy0wy+h4LuXUBZjf9jMq8Hq9XRngvjlPieAVhCHA3dhdJ3gY/x/u
 v72sn3Qxxsy3wx97BSFrg2L1+S5sr9HWhqRsNkRHQpwTQGqKuzg2dulASbG2YkvYK+QW
 sJFVCqttQPNvUEg3mz8yWfwlLQQffKXuqa/taupEHOvV4CC/+R+3aVg3t1bHYgZuamRq
 psuPXAmtWoDLID3dcxOQCT+AX8YCWZ5ngJ6uQRnaH5j6igVvWR85pyX8sLbCLUjP73oi
 NAi6UUd8SvPrUUAlkIrkrC7BjaWR9s/hKlDLjOV/f1AiuGp2odI3XEi2W/1X737Z07uQ
 Kd3A==
X-Gm-Message-State: AFq9FYJ183h0J9lNlLaQ7ZyU+1UR3f3oJOBLyx3zYfwITK0pjgTZbkib
 bE8IPlY0fwoejw9cJDi4Md4yluEYUJeEVUSBtULNYVjn5plROQvv6zybhzANJAjWFt+rDI5dqWp
 ylaIN7GUXrz7kgezwo4feAfmA0ttYIIgXG4vZLCW6mZhnG1ANWiLp/iHTCjciHO/jbw==
X-Gm-Gg: AYBFou0VdBlKLymAeb5lZpnXRZAnkDa9TJSNbZpMy/xhwTu0X98UZ65KR0v7EuJTVaw
 +5HIXBWtOBJ5hl0UiTC6Jh5JZdFiKA+NCuayjVXQUzZrBabSZHDVz/vpYGEUMBMW/vp2ivuhXTQ
 jkvKEFz/LGfDhDIZBFFlE1xv0ENwNSkBDwiUZvMkm+czYXm21HJnPA7a7D2EIR4SoGDK0lgryfa
 yF9V863KSLBCXCbekwiQ8rU3ZbIwtlRjmpeNzGR0RFK7BThjv8Ph5epyrqMJkDvKaVqWSy/uxFD
 PRIPJoGE6hgo6eqXr+19NByFz2FGu8aJJzxh+ix2hlCaGHtPLNlgj99wMLdUYbI2s4UJ5I7cLFn
 Qar5J8wz9cXEm+QapDXBLtwkHw9rLeR14ngSNUtStoXNmZyx+FaOwkmO6wxqT
X-Received: by 2002:a05:701b:230c:b0:14c:be8e:69fe with SMTP id
 a92af1059eb24-16a57922026mr10511706c88.5.1791736077504; 
 Sun, 11 Oct 2026 09:27:57 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:14c:be8e:69fe with SMTP id
 a92af1059eb24-16a57922026mr10511684c88.5.1791736076850; 
 Sun, 11 Oct 2026 09:27:56 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm25001242c88.5.2026.10.11.09.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:27:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peterx@redhat.com, mjt@tls.msk.ru
Subject: [PATCH v2 1/3] tests/docker/dockerfiles: add release.docker
Date: Sun, 11 Oct 2026 16:27:35 +0000
Message-ID: <20261011162737.3024-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261011162737.3024-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7Ce_oe_NSXI_kzvYDsg0RZi0F4KbpoHh
X-Authority-Analysis: v=2.4 cv=Aud7T+9P c=1 sm=1 tr=0 ts=6acbb90f cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=ID6ng7r3AAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8
 a=GUVi8RmzAAAA:8 a=4HQkHWYM07Omh7VlaF4A:9 a=bBxd6f-gb0O0v-kibOvt:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=rjTVMONInIDnV1a_A2c_:22 a=jSdgSmmMQx7r16_JUfbt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX7AG5az8fxLiE
 El16uMmJi3IGAEXhoZ/x9sB1QMAGGICtfxPogcoM5Q0AK2ypV4bkeva8HbljZhU+FI7NdqRKsnd
 itELh+pPN3FNHcb5XZceYBjTArs1LYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA2NSBTYWx0ZWRfX3fXHwRr2g+lH
 Hj4R/GS4GBRmHbTQHuQS0bONxoTUBBuOdl7GGKYa3XdyUShwjZS4CpqGbxFR4pBCNHg5tb+TPno
 v69wTjY5aBPb1RSZ/BlH3utn+yu+qZPIIwD558Tm9FqSSA+/21el75xNiFh7JR3D0sBh8TeKDFe
 dUKY4BcjO6YOA+6lGiuPaq7ncpcIkwue+p6uKBfEDUOGG2bNFuT6DY/Wo8t9FX6iWDZEC/6QNh6
 XZW9/z9SPkVw4RNpQuTgcOCcv298BkpBFHSut/Tge4PeRK/VyUWT4LY2Snp2ulYIWZVjXuGWb26
 6RBA9CdfaYjJkkaRGELEVR3tsVgty/VxkRW1aynAvBEf88S29MPvafZ45zvCWvAgtHg09uvmDK8
 QkUdbaTyAipzFFbWiXtTczQRtYYwAE4XlvoYaMAPubIh3SwIif5kzG712yxNISe/0PxBYe8XypU
 1piftuAteXhXE2/ecvg==
X-Proofpoint-ORIG-GUID: 7Ce_oe_NSXI_kzvYDsg0RZi0F4KbpoHh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110065
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
 tests/docker/dockerfiles/release.docker | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 tests/docker/dockerfiles/release.docker

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
new file mode 100644
index 00000000000..4567280ea59
--- /dev/null
+++ b/tests/docker/dockerfiles/release.docker
@@ -0,0 +1,69 @@
+ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
+FROM ubuntu:$UBUNTU_VERSION as build
+
+# add deb-src for apt build-dep
+RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
+RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
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
+if apt-cache show python3-venv; then \
+    env DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv; \
+fi
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
+if grep -q dtc .gitmodules; then git submodule update --init dtc; fi && \
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


