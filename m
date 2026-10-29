Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD52606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QNUHVUvg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=frYSEAbT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMWBD-0003kb-K3; Thu, 29 Oct 2026 15:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWBB-0003jr-NW
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMWB9-0000xB-8Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 15:52:53 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJkDDx3718410
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cHesrSVnIodHaYAN+waHM/nhMCPCtNl2KsIs9YU/gqc=; b=QNUHVUvgRQGm65Jr
 ZwIwGNd02JYPnEq1+ZL4ZVZilI2WM3iBaYdcm/7ow9K47v70LXBhgYWi/egW1vhR
 KkkbW3dULt2kl2S+v9tWagjAJkp9coEyE5oaqYdJv8qDenVoNFK45WvhMQKEX0zG
 /XHFtJpslKI/xC7/L3qMUl9pu9Lk/GLV3OnctYpXfR9YsnCdMMzrkKAoAVhoTWKb
 +CvltKOTX3pYLFtOseajaWsuKRfQhyEj7l7ppvCvTuifnnRdJVKTz8f6U9k/CGdA
 YLbsr6cKUXiSGpUunw0ynecGqwbGWFQRLgFYIznviQIZrCF+lI4yg0Cr8H/oDQuH
 GqzQVQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b2uy2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 19:52:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ae7faf4ff7so760001a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793303569; x=1793908369; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cHesrSVnIodHaYAN+waHM/nhMCPCtNl2KsIs9YU/gqc=;
 b=frYSEAbTS2BdlFTTudkMEJ4HqWXYG/pBIruvXxMjV7Sh9wFl9uMqTBUBZA3V6QQpVF
 /XKvBiDHoi26B3hFVdaD7FLrbMmB4vmQ24Nm6k9Bj7hByRDJGAr0VH05dBXUb0h0AoQN
 3Jf0G46Xg2Czdf6+GGj6pln9oGI8xZlb/+s5RkGflnuZecXr5OxapaU24zCUotw7HTz+
 S/18ncu31xiVjjAzbr+wCb2AtNG+jZSTuW4/irmXrWbOQKLuGRqipum9R3YwMNCZACBV
 8XRlQJnAoKGaNEofQ2dCV8iZEFe13C4Oql7x2ZtH1QNt6DDvsVHUbbiIzonP080hYz3d
 PAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303569; x=1793908369;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cHesrSVnIodHaYAN+waHM/nhMCPCtNl2KsIs9YU/gqc=;
 b=MLMPNJtMn0ZeAGvLqirv0pip8X66zbDZq1TBh5d7VmdyUo0TeYTTNRjvcwVouzeUq7
 dBubKTDRwFif93Ryh/JPw9Wq75bwCZKJddo66Hwr+LnZtCJseyFmX73UoGVd5etzazML
 pWRcGoIljvOdOOMkSTNEJgtMCVIiu+cCP/Clq2W/LMHvik+oXckprXyTEKz50tLBmzSB
 xiGscZsavWVi+fre5Mu14E+etFvrYJEpDKvUTPoEqyFWh8vg9fKYqBmO09G1tsDaGkJJ
 X6/hxRpkidnZmhni9QJx0srA/+TTEDDocX1yAO+7wv+9Ti8v/t+haN9POrgErzhaRKQi
 WbnA==
X-Gm-Message-State: AFq9FYIfh8tWeJpgReeiUCGM4YWifIcBY6NaOm3gfKwoULNCD39NZH4L
 yISqEsJFxPVH/T7uHA3z7agzXTAMB89SbAgiTvYepsR+ZtImRSgId5atRtJJrotNJ1voB0YD4Gt
 rO6h6YSkKLCmLIAeTcOpe/UKWzr1uIhnMwqs2rGzTT4IMNIs8j4OkGLGyEGwSAuw0rQ==
X-Gm-Gg: AYBFou16IwBVnovIRS7pDXFGem17No5iEe0LKisWjAdTlK+nthN3Ha9CsriRvcN1EnJ
 vcNnFDgHf1jw0tDc75LaMNDT7wuchGl4HOurBrOCMNbLeg//fPaEyLBAOl3MjXfd0EhpH30svJN
 sMB6sTGZVv1c0hJegFklMoSKfvPLUIc0c0veNxSA5JUisc4JsB51BuM+VBAyHHpkt2ndqRocHaQ
 QgAqt3N1F4s1y68JVB+r6/6pagEFnUcHlOAcgP2HmCF7OzFWF8aY6fYuLBdwvicuLAitPexRUAb
 QzDZccNv7dni60i7DWbz+hzI1ErL0AbRhf3LNcks+VM8d8/Ud/N9KAlTiGEPFgCGfpuNBodeVLL
 7JgWf7BChWOqwsHhdXljRBOVBb5tb87Vati/KkFHRF/F9xhgq8XH+yW9xhXd6/YLqDHDntRmhg8
 G1/PXmN6GHQyJ7y4VcTGLbgRsAIihOnzytE+Ka
X-Received: by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5 with SMTP id
 98e67ed59e1d1-3ae897eb741mr13476a91.11.1793303568557; 
 Thu, 29 Oct 2026 12:52:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5 with SMTP id
 98e67ed59e1d1-3ae897eb741mr13451a91.11.1793303568102; 
 Thu, 29 Oct 2026 12:52:48 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9b1506sm5275862a91.15.2026.10.29.12.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:52:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 1/2] tests/docker/dockerfiles: add release.docker
Date: Thu, 29 Oct 2026 19:52:20 +0000
Message-ID: <20261029195221.6125-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261029195221.6125-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfXwSpEZ0CfXyb7
 Xpykje9obyocGyEO7sCDYYr+/GoNg2/fwIB4m4lB0rrY5SmNRcA8f/P0jp5REOOHyZy2qv5kmkA
 FNdOy5kaIti80FbZbCuHO0TKX0bqmjU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OCBTYWx0ZWRfX0p115LZSc1ty
 cvfYcS0XzF22bfJBeweLLp6udZ0I7U7WHoGxdOXbk2NKTo7nJ6gTPGvPAAWND3PtFdfk7/RFQbj
 zCUWxnAUe0iaboyrm3OjA6lL+aDtocbz+QOLA/dgT9flE4nzLWvSqxpgzjw/ae87Web13k/qVfr
 tK/B4LO3H8EZjLj9Z1WHoQnS+X4b5GKmpvz08w6y+2yixMS3IVBjSUHnqUI+10AaD/sVJ9odxJU
 gQcE64O/bN3OOHlOvmnRySlB8bjCft6L6F9usJEV6GvClwvlEIEOo49T9LvWuQJRbdtjk+9fGj9
 DAx8SD8zcJ3K6qSIy3/NTJWCNwh24Jr0R/GeHIDj8tyrTegmq+dreXVx/ab2D6eoYeYrWbEBl/N
 muzDmL7NeQkHTfNux/vWNCfypeyjmUHiqkQ27sQobKNExHkHhWeDhUjZmI0g8BxB6Ldc+mHLlZx
 E2zbQHrNH+XAgqYwM+g==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3a411 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p0WdMEafAAAA:8 a=DfNHnWVPAAAA:8
 a=IH4dkz8bHYACMdZ4P1YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-GUID: wURm6JjtGmcvwZX1rbquajbpLvwnmvIC
X-Proofpoint-ORIG-GUID: wURm6JjtGmcvwZX1rbquajbpLvwnmvIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290078
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
Link: https://lore.kernel.org/qemu-devel/20261029000853.15166-2-pierrick.bouvier@oss.qualcomm.com
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


