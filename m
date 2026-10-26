Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB406606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S4SCYbkQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DTII/U1O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRvS-0003Tf-CR; Mon, 26 Oct 2026 17:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvO-0003T0-9Z
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRvM-0005PN-Ka
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:08:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoqSZ4080966
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8IebwTkS3O3
 332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=; b=S4SCYbkQ7B0SGyyePq87ZhKowz+
 LEBTmbW9jogTrbe7A61t6H0AmsbeixkHFYfSRF1Oc3kBe0UcSGvg+6vkToz6hp2H
 Gy2VnH+VXu4iDL/5ZqTWR12ufCnuM8DZziAdFp0wA+wpUge5jFvREqJG7x4SnF5K
 xBYu+T1DsRSM/7YP+urYElHRb6GVWBIcubvqOgLfZO3HbUJt/OPNOY/MQcr/flmd
 U/nArRoHeIU105fzzqEo5f9ptM8hDC3TfRsGz+2CAvuDxN58ueZwXFw25SMFEAwb
 /zZr8T/xQ8ZcBHQ+O0C+T9dFTScB5E4JfJ+bYDE/qw+SFB8ht5lytFiMS7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj56y2c2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:08:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd8b299b05fso3462329a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048887; x=1793653687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8IebwTkS3O3332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=;
 b=DTII/U1OdAcTUX91D9F3V9cPr2j1jSSSdVGp/0u0O0wy8fvWCKqiB6g9ZlUZJ7XqMv
 QJWlhDbmfh5LMjPHEM5tMs5bxsdL6Zq4OZo1NWF1iyJhQhNS+0XRtQrvSOdsIU0Ffkj3
 DsGWGb8EOX3WoWYoYjkZnrgX7N2tvN7C3GCQYZIebT0/svTlpvY4/g9NwibDLGQ0D7cr
 vyYrHnLkymhrCxiuL2RchfpkcRUaUL6No22mfCeVLWXuTyW9zoORpajljeD0I3nW4deg
 jMl5ZlPtABdSoVZEuIyBP8E9/vqtGmxVK++RUWddgdyIfDscnx36xK3TYQGnjlKp9Svi
 FcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048887; x=1793653687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8IebwTkS3O3332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=;
 b=Aj+RBklOOdvUPx/B3GcOLS0Sq9xiQ+OUsbd0nVMV8HZheY/FQ/vjgVQyWp1FyOieqT
 9po8vV8C46IgKZy9/d39xdq3K/4Qiy3ivFC1wPwf2kmMbqt6DGjRAq4Hc0277TssI0zP
 VMx1RoaemchO7YIt9xALYcgP4gBvQbHva6tbMOtNQUY/Kzw++oiykSsgcTRL/EqMP93J
 DJ+kWor1sFl8e+RPA7e5BGwIK3YJXVgFCcnoHDhoXNTL1OY6y5zOZvWN6Y9SyGa1S0yt
 5XcUnoW9IKIxK0+UKPpfn6GFZbdKMxW2F9Tr7UZEFzfwBnFa53liwa20pN7jg39Gijsp
 Ahzw==
X-Gm-Message-State: AFq9FYJeU48g0xBOrFUbhyBzZkS4IF0do878f1g7vVUm5uuNDo8EV3iL
 HsIEoOVTmskEF1vozJZUFiU8+M0IjEfB6Rk0K4chQvbQQEHgx+q9w3Riyg2T+tKhG39bDmAhKS8
 c6xuLaD9iJ5z6eKpLE2XQF4HZNKsv3WXJNOMkGJSNiabDgA8bt8O1/pD/NPfvrB54gw==
X-Gm-Gg: AYBFou02RkddBMBG6zjM0/VXdunCD/bpyPpJTOm46yllLWjNhNnx3OcVC0JrEGLhuEg
 hgefpFYkbaw/lM+4ibd8+LJHKkRmh7opP+00FTD5yfEPMnylcLY2ttcVBDL0ZIR2BmvXJLyCARq
 r03qWwILaFYe6fSr85l/c9++wN676jnoBD89OKPux2mfgoL/nxUJfixjJdu61Hg2Ev4GoSGDHq8
 QdekQF+xps1uazLlx5fFnQ3g0eJaeDbagDMn5AdXIreYo+v75eJmE7vtKufBA+gt5JJm9yYEbhY
 u+3tf1XVHtlItyWY2JBKYJxFw/Bs3+/nyfV6hkmiu/l+SsW7zNK5jWn3wYLCn1b/m4AOWveKTRX
 9ll/ytAXDgRUFHddpGZ5PSa/8qmph7+yFd2Ezmh+cGpgk/Ak3BOF35d2gaNMtAT4=
X-Received: by 2002:a05:6a20:5482:b0:3e2:8c69:90d8 with SMTP id
 adf61e73a8af0-3e7bfbe8384mr5480093637.45.1793048886564; 
 Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:5482:b0:3e2:8c69:90d8 with SMTP id
 adf61e73a8af0-3e7bfbe8384mr5480082637.45.1793048886122; 
 Mon, 26 Oct 2026 14:08:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a36bb2a2cesm1650508b3a.36.2026.10.26.14.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:08:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v4 1/2] tests/docker/dockerfiles: add release.docker
Date: Mon, 26 Oct 2026 21:08:00 +0000
Message-ID: <20261026210801.179790-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261026210801.179790-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX9uwrAszbFiu8
 H+iXPpEtG4XpPYwHq9+sHQeQ6XtTAQ+Sosa8Eixwkt18eShMlHO52F6Ks68QYa9s8fFtgMIUfvs
 8AJNq8USlzJxQVtPuFgrsXKi1mHkWuE=
X-Authority-Analysis: v=2.4 cv=eMeGH3p1 c=1 sm=1 tr=0 ts=6adfc137 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=IH4dkz8bHYACMdZ4P1YA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX2MlN4MBZZgnC
 IWM50P2puBA4WofFr4FaAXVcmNa82sw/0q9R8cu/OBoAPp7WYiCcWvZNSdwVW8S3Q5nBVWMTUwF
 Qq03Tl68Mr0ZAhZjTZDsVR8GWg2EDaiXWardMOvgZ/BAalnIH3KmC6OMqbrDw0avkyOaH84eMEZ
 r2CcISrO74L+otrdWNzyV/0u1NRA+JGhBKhVs1mpezqenI6BjOZsm/bG3RLn+Plt22XZRFdrq8j
 m194c6IeB1ZeeuK9q9edv0u5SFyhWtJ2a0zTARuXJ98lvY0EjbQ6DpEKBuG77F83y6so9R5vO39
 Xr97ExQwknHKF94oN9RAkRzMGqu3Vut4gzD/5Q8GpvA5295VSOlBdJWtAI5kHeikwQEMYU4je+b
 4aiin7hF93d8zAf9DWDyxSe9t0LUMvUc8olvpMBpxeRBZEqdSaCXA2te+9ZpCyZX1I75pAAWvt/
 txVv4tW1FiNvyEfZ92Q==
X-Proofpoint-GUID: dcnHjfFFkGM5arRUPkI0V_-mIS5LQVar
X-Proofpoint-ORIG-GUID: dcnHjfFFkGM5arRUPkI0V_-mIS5LQVar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260084
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This new dockerfile allows to build a distroless image containing only
qemu stripped release binaries, their lib dependencies, and installed
artifacts (roms, keymap, ...). There is no shell, no python, nothing
else. This is achieved thanks to a multi-stage build, where we add qemu
binaries, artifacts and libraries in a new scratch image. Image has
the minimal size possible.

This is based on Ubuntu, which has the advantage to have working
containers available down to 14.04. Debian old old stable have broken
apt sources for instance.

This unique dockerfile works for all qemu versions >= 3.1.0 (2018).
We could build down to v0.12.0, but it would require more tweaks in the
dockerfile, so we keep it simple instead.

To build the image, you need to provide a qemu and ubuntu version:
$ podman build -f release.Dockerfile --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0

To run it, as there is no shell, and no defined entrypoint, you need to
choose the binary you want explicitely:
$ podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tests/docker/dockerfiles/release.docker

diff --git a/tests/docker/dockerfiles/release.docker b/tests/docker/dockerfiles/release.docker
new file mode 100644
index 00000000000..ca6babde01e
--- /dev/null
+++ b/tests/docker/dockerfiles/release.docker
@@ -0,0 +1,48 @@
+ARG UBUNTU_VERSION="UBUNTU_VERSION_build_arg_must_be_set"
+
+FROM ubuntu:$UBUNTU_VERSION AS build
+
+# add deb-src for apt build-dep
+RUN sed -e 's/Types: deb/Types: deb deb-src/' -i /etc/apt/sources.list.d/* || true
+RUN sed -e 's/# deb-src/deb-src/' -i /etc/apt/sources.list
+# archive.canonical.com is not reachable anymore, and cause a long timeout
+RUN sed -e '/archive.canonical.com/d' -i /etc/apt/sources.list
+
+# build dependencies
+RUN apt update && \
+env DEBIAN_FRONTEND=noninteractive apt install -y git build-essential flex bison
+RUN apt update && \
+env DEBIAN_FRONTEND=noninteractive apt build-dep -y --arch-only qemu
+
+ARG QEMU_VERSION
+RUN echo "QEMU_VERSION=${QEMU_VERSION:?QEMU_VERSION build arg must be set}"
+ARG QEMU_REPO="https://gitlab.com/qemu-project/qemu.git"
+
+RUN cd /tmp && \
+mkdir qemu && cd qemu && git init && \
+git remote add origin "${QEMU_REPO}" && \
+git fetch origin "${QEMU_VERSION}" --depth 1 && \
+git checkout FETCH_HEAD && \
+./configure --prefix=/opt/qemu --disable-docs --disable-werror && \
+make install -j $(nproc) && \
+strip /opt/qemu/bin/* && \
+rm -rf /tmp/*
+
+# retrieve runtime dependencies (libs)
+RUN ldd /opt/qemu/bin/* | grep '=>' | sed -e 's/.*=>//' -e 's/(.*//' | sort -u > /opt/qemu/libs
+# store them in /deps/lib
+RUN mkdir -p /deps/lib && cp --preserve --dereference $(cat /opt/qemu/libs) /deps/lib
+# copy loader (with its original path)
+RUN cp --preserve --parents --dereference /lib*/ld-linux* /deps/
+
+################################################################################
+FROM scratch
+
+COPY --from=build /deps /
+# copy qemu and all associated artifacts (roms, ...)
+COPY --from=build /opt/qemu /usr
+
+# build with:
+# podman build -f release.docker --build-arg QEMU_VERSION=v11.1.0 --build-arg UBUNTU_VERSION=24.04 -t qemu/v11.1.0
+# run with:
+# podman run -it --rm qemu/v11.1.0 qemu-system-aarch64 --version
-- 
2.43.0


