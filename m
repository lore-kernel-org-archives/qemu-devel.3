Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB015606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JmB4iTJi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zk4i03E8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLRv0-0003Mk-Ts; Mon, 26 Oct 2026 17:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRuu-0003Go-EZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xLRus-0005Nk-Cm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 17:07:40 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QJhc8K2703209
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8IebwTkS3O3
 332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=; b=JmB4iTJiNgR0A39IgM4a4AVo18g
 n9nL0IuFtFr3MdFwo4+EcJY87aB+aDvyrxBKCP3rFWZfz2KnvgcfqY/PpUNvqhOy
 y1AxBHuGxsuVcADdE2ebbOO35JKH+TnkOoZdfEqP7ZEPd2QW7wHDYYL7cKIuW8am
 IFMmaXyyBH3GW0y0fFbgRIdPo+8vYDEJo7WeIY0TOJgJ0gXljQP1HVCMpi19ef4Q
 Mo/mhD7P5ndTiUfdO05KqY/kEDBBqFULoPislVofqUutnUHmcn9xD0o7mRP/U3jp
 e4uHv53sS/xUzZRZ8VSEe/R/S1nhIeF5Lwbu24NroReJ2MvXYlsK180jbsA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54gsy6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 21:07:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cd6532dbd7bso2027435a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793048856; x=1793653656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8IebwTkS3O3332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=;
 b=Zk4i03E8Rv1ypEizdghFLojRHqkV/HvzLp8ofQgYVfkequwCqfy66m9TB8REkxjYH/
 7RT/vhl2MtrBlT2nRjMi7veV6jvh0kQLmC98LkMf8cH6I2pBUSmcRJrx89DuSuIWs7Pu
 Z2RWHnW31W5wuo1mhNxH4KtcZRtl2y/0r8FtXRWoihr1hIZvIthTRBr6iT3Kfn7uHcUD
 gOoXvZc8EYLKYz3Uzl8fjA1M7YOO2RduiN4DMhvd/iKuewowEW9s7mQG/5AJvZOtFrlf
 9RCBbh1NM0LRKvRe7CC5bC//kqLUpWCGXnIUjo+KTMXSnHpI5TYVHLLWWrjxiYcKLaTb
 cPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793048856; x=1793653656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8IebwTkS3O3332ps8Y61IJPQbHUInn5QXa6/gwP0N/0=;
 b=mA1Igy999b6uxqRv+KBAEQUuQxJk2FkadLwhV1FAGcbCAMatJVCxOKAC6+cd47LO9S
 5lVjRFbxhY7mqb6JhRyXM+OTtngipikLcAqBzHF2b0iN1TvOtAzKQCYcVY8ZwSGs1QF2
 Gm12ERCMdc++5RuNizFB4P1CajY/3rwjcStWLRg441aiJZTTmMsTaHvxLu2tLoxwoeBf
 id6Yltye7kFuPwo45RGPOI55HrQKbKwLDVeHStDL9WuWWvznGoHpVHjacFe6ga2Wyur+
 /xDElHHjDSTbAR4tPhXMK5pu1/6QgG6FD/hzsgl0qB9fTCGMdPLZU6fSVg3y6Ooeert+
 tgkw==
X-Gm-Message-State: AFq9FYL0GZXgHbv02eGzL/LjlbM/3FXQx5ZzA0O2jy+0ZOo0BIoPSQZL
 rwg7lh2tqVfCBC2wdYehNsZc+X6ti3kSYzpIwSsG5fcPca/rWXFSah5GxkxhDvJQ59eT3VholT2
 NB6I1Ac8b6cdzbpZP9uS3VbaswTsCLZmqhn2H9J2TtNZAH//wi8YKRwXppwLSZAMq4A==
X-Gm-Gg: AYBFou3XPe27jWezsvqjzNOVGBB58TWCH9zGzmrQIEmzRropm4dyaN1zaY3M88VK20y
 LWvKEAwZGDMPsN6zc52mk5f0SCX0LsSPEpkMTBVPmORSCAkGg7uuUfebU1ZNUkm2SltnKjksFXB
 9Z2UwT2/JVCBuMlWxF6rFkb+XXtGRbQIGa86ajZwgcdrixjQLbsYQAhqcsv1FyHhiUUgEXRPvdn
 MqWabeVGzViI3VWLZgOcSPG2ol8OHNeGtATlU29ZPhIGpeNP7t5oT3jKE5vmtRoeBLR/tILFs3g
 viQBiH+F7+y4UKGNp05WG9KxGHJVbAL1/OwYBQKtmwYA2Wf8OS0p03BBs9CFKpQbHaaebSQP63F
 dCJY0jKw3jzrKNWF/bwmioR7BK3VHuoQAY35/22yiyA+B3fC5j9SuHho662vFAoE=
X-Received: by 2002:a17:90b:1c8f:b0:3a8:699f:959d with SMTP id
 98e67ed59e1d1-3adeabe535bmr7132259a91.31.1793048855796; 
 Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8f:b0:3a8:699f:959d with SMTP id
 98e67ed59e1d1-3adeabe535bmr7132236a91.31.1793048855270; 
 Mon, 26 Oct 2026 14:07:35 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0dda7sm6421185a91.4.2026.10.26.14.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:07:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peterx@redhat.com, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 1/2] tests/docker/dockerfiles: add release.docker
Date: Mon, 26 Oct 2026 21:07:18 +0000
Message-ID: <20261026210719.178107-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261026210719.178107-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfXwEJrVxs1uuq1
 lNcQVksQA6lYByVDdZMtXxeJ4EOh1An+cu9xp+csVR0ov2G8JjLirPihsmBp595CeotIrdFAvD7
 mqkV1kNqR3ScuhtWcBWQtYJ9CDzfEDU=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfc118 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=IH4dkz8bHYACMdZ4P1YA:9
 a=3WC7DwWrALyhR5TkjVHa:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: -KwzaPIizW0V0VC7JM2BSoTUDv0Nvz5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NCBTYWx0ZWRfX2quHeoLwq9fD
 LLUeVDurJ1D0wrBnp0Jgbg7AOoPeRbBzswyEjDbgHDSuzws5HAfOgoRVtHr7XnpFcXJa6HviYlY
 qJ4aspCR7/s3Cq15quFj6H6o35SZCVCP6P+X6WXJebxgnzIjguZn0R+4f3Xnq8balC7GAPhfYAt
 uwqilfEIFBGzkGz/eJ5zpj/XOKDHqUtlG1PEYZB/88cFAVlh5KOK6SzCFFd6QmPKhJ6v/32Nq6x
 PUQ268uK9X2OwLR7moGmCR9AYQQNTVf2UXoMbX7oNeNOk5gFEq1FC39oS8snLvV42CjgAUFqVAm
 5hpelLPs5bFgQ1o3FttE/dFTIfknGsGx7xiDiuPHBjiq8z92zYpHLOfHXtovwS+m23tt1+7ccZ3
 xayXb2NGMCnV1v17E6gsaTJHG12q9fHxLY9EXoztMjyMN1/5J5hXIM6K9s5kekKYifpAjEzShqk
 00HXFZFRBqom5kKow2A==
X-Proofpoint-GUID: -KwzaPIizW0V0VC7JM2BSoTUDv0Nvz5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260084
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


