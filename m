Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29A606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YlILoPzo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S5ctKzry
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDhe-0001lD-T8; Wed, 28 Oct 2026 20:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhY-0001jz-I9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMDhW-0000ER-Mc
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:09:04 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMAVq32428939
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gkkG7ylAmpcRku4JtK/ff051MCvMqQjlM1vb9OyiFo8=; b=YlILoPzoJBrVIadR
 hWN1VJ9q2cKHR0guZKXCcZb/PThtnbETS1sCAKsGxnHUblH3grA5k+aM8cIErvaj
 Xm++Ey2746uPrxTTpjdDOnYLyNRyLrYH1WkzoQtCuD06qLDsDRh2NSgS7EP9e6cb
 CuMHGA499AIVwm7A2u7AUIvEQwNcAyQgSKsYGG9ILnPaYkbn6j18Bupynb4LH4Yj
 7CrqbTWhN59bu04BHZ1u8nZ0X3vw6nOwGPeTCTAEtDbh0mtrER7KhhXwCZdRJxQf
 /+XYQE9unU4hM8Uqd5BJzMKtFcSxylECjo5+aL8bHHi2TThhJxba5MlQUjDTzbvv
 Q13ZhA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhwc2ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:09:00 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a03834d8ffso2065808b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793232540; x=1793837340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gkkG7ylAmpcRku4JtK/ff051MCvMqQjlM1vb9OyiFo8=;
 b=S5ctKzrya7/Ga5B/3ys57OVFZeewOQztBSqIKyplJxfDfAl2Phew+jsIdRpeekLAj0
 4RZJE6GjyzMRx4k4QcsvJcxPpPf2TckL2YHcAWMuG2HRZ0g6gIvtEHI5xSozn1R4tK/s
 qUTEEM+2gFkQVT/2r1x4ZcoVoi4mV8fh6WmCqIUtp+3iUqysgSzs3bIxDGy91WcgKbD/
 UKhKP4jZ+lNBmYUm/5AoC67o1hpUeF4eowbQdBT0Nl10udkmiUcGRt+xHsE2Col2Wn/8
 agQYyAx4g+AHPRgSb0TK2Pgi4XmlkGy1PnMwi66JbzGAh51s9egV8FJ7KQjCWwGHm5qh
 6XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793232540; x=1793837340;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkkG7ylAmpcRku4JtK/ff051MCvMqQjlM1vb9OyiFo8=;
 b=PRpGnj8WTlmXZAiNAUKdaUXgX1kl62vgETJ2lMljFu8dNFtM1gdCQelj3cN902a02Y
 QUF5egHSfziNaJaPt3MsFx6F/iZ89grYqmimPsYP26S528F2NlSOD0ojDXYG9+NiEdLL
 +PXudy9RH4scUALjxNMhRAmu1Qrmtz+JYcGUxbRuIz+uMgDoVgCNjdruq+5FPhM7w3F4
 wUmkOOpK/LiocMD4l80j7EeO0Oxl5p/dj0Y8btIiIc4PNoi9hghVj43F21AnjVD6EG9e
 q9WXwYvXhPtYgbwREpTPwRZmHK2EE8Yl45fWqZNiwWh1FPKy05yU4/OyUPAWno1IVakl
 Z7Dg==
X-Gm-Message-State: AFq9FYLjCxtFXfFSx0JvnQyrkbLRrX/vKaQHfI8AAgt8rSIdxYIVI9TU
 vTB2rG4AySNySs96QZEG5sNw8j6deK5VsAfr1iUCMsf1SB/yIH8vzaHiuyeqP265DbOQOxePtBm
 SVOy/WUdDDtyrcp0VKMLSeV9qeN7qIKetHf4b6nO5SAhDxgPM6U4s00SfyHPMQq5m7w==
X-Gm-Gg: AYBFou2ysNNJZ+Ue6IDN1KSxoOgERRCOW0rwzwNs2jv5PwFZHWcibeiTd0f0FLtNZhT
 p7qNxn3l4RF2xmQAs633kjfGt4/WMh+iZpAosR6JSIjm+kdli/nluAOS1H2/BdzxpISUsimwpVs
 VRbs04RHt5qt+EE1S1IbHiZmqe17lZLII4izxWdHeZ3rCOwtjutDN7EhCx1zBadY/m4V1BRyOl7
 XlA94knYxuU68CZq9OBwVuHHbwGkGh3g7Idm8ljxDg0ffB8EscnORx4OE7feSedbjCmSMgcgph8
 IfdKyrOYrHNpKVoyd6J1sN2ty75r17c5BisGq58mGXja2MDcS54ZPKkO4oQlhnuVsO57jjyYoGL
 TK9C7mqBFJHHI6BDnEjvgu9ICKQFJktJubom2b39Yr2FzMVZGjDxGAk0/de/7Q490Dk66O6OD9k
 W+OCR+jNBUZyvmNGsQXc+U1K2rYSwPI3xmHf5n
X-Received: by 2002:a05:6a21:b84:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3e9020eef8amr3076074637.10.1793232539777; 
 Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:b84:b0:3c3:875d:c52f with SMTP id
 adf61e73a8af0-3e9020eef8amr3076055637.10.1793232539280; 
 Wed, 28 Oct 2026 17:08:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd8ccc682d8sm4644744a12.18.2026.10.28.17.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 17:08:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, mjt@tls.msk.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 1/2] tests/docker/dockerfiles: add release.docker
Date: Thu, 29 Oct 2026 00:08:52 +0000
Message-ID: <20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rnnAXZLSXJKBKWhHM2efP_FWQh230BWA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfXyq198zT73/5A
 247E6qUNUXwMmpnsgYU2wGzVgvAdyYXFHZj192uhbIMVP8eekXvMfuyaDlM9D3/fxZI1IqSZSTf
 UQsGRMM5DlIO/rMA3rfUcgbZApdA3b0=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae28e9c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=DfNHnWVPAAAA:8 a=IH4dkz8bHYACMdZ4P1YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: rnnAXZLSXJKBKWhHM2efP_FWQh230BWA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDAwMCBTYWx0ZWRfX1hcAVfoY4Uu8
 02yh/30NR/nw1oYrDeUIk5BWPEPsHDm/HeFiQVmm4cicbSxtcUKU/1glM40OX/tfOvd9C9+Br/X
 CbN3hOxuFEemC3UBXd4heviYPfXChcJMkIwOvfOOCuZc5hR3Bt8V5UA3UV+BsN5eURJ1Ye4IEIB
 VqPqGg8NiGY+bhzacZzC45mM9nAfqliuprcDzgz4GvaL6C/SEqUiix+mxTMq6RUiAh/Mu6VouAD
 CgVoXkhhgsLl4XygKNda4ucOlQXNiGQtqHr1tICtJzdOqnt6tWojFv8ZyfSyji9Wa0w/PyF9gW+
 li08/pRx90rie+QsuY/y8RQFK2U81pCQib54aw0V4SgDqJnUedgDQuQ5oLIBPaSgk/oShesnAP7
 WdBbXA4E96w9pD2Yc5uCtRKBjDCf6X/IvgME/mVxERJthh9HbQQGEsNAEJjY0qP5SX8FMewXwiB
 j5B36w7FoKrVSNki76Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290000
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


