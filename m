Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B4606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PlPF697g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b+vuk9yb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUDM-0002PH-KI; Thu, 29 Oct 2026 13:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBU-000779-3d
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:45:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMUBB-0003ga-Sr
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:44:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDbr73689755
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a0PaeL8Kq9xXQ68LcaL4C9LzPYWjngZnEBXFQqSQpZs=; b=PlPF697g6lzPQIbc
 35FHAnUwNHPZJ0PLH5GHY6xKyfpJm9RuzHYvFUOONTq/OSnDOVwV4EsVrrnd2Z4q
 8BDOMRqn2nMRLt4XdEay8cFCXxJNehLF3ZUvQtA6I+OGklzNLULlY5xlR1aFOR7+
 LJI9jX1XpUhRvwA4Yi1p4oaXwr+LVHQlPkeTAq4dQFNXiBYGcR4MTQ/36Iyz/hNx
 KN/mrH6bmOP1hFX6fiMqXhJSbtlkvqcRc2sZavdB4ozhX82bcP8coo8AfALOO2Dm
 5Hu+ELIY9AUpnYU+MYPKWYPZ0LYjLFcX+HwmfUrafvkghwfxd24r6o0rfc2e+oUY
 h97wAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sbham-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:44:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf7856ffso538693585a.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793295884; x=1793900684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a0PaeL8Kq9xXQ68LcaL4C9LzPYWjngZnEBXFQqSQpZs=;
 b=b+vuk9ybUvj0I+GiKNPw+lPpJXXY1ZYmJfcwBRRuYhYqm1arN8GEzRSd647ys+JLMh
 //EmC8UAV3fyg8EuiXXUZv1Np5s98/nyDFh7ezw0mKXnYGQ/Z6V/C8JyRFVptmVfouNx
 GFFdx/N6R51zf7E/N9ioImOZmHUiQdQ+V41dJBjR1bnXDVcKW7wEY6hTlOmjN4m/XjOp
 LAAguXjF/QvWqCT5GhmFgz7BaXaMZ6Tq+NvHOZpnwqkZvjMey4fBBe00iWZR/TNWV7vr
 PaDraaIv7drFrkHjNT7gkxS6ryL7INQ+AtWzFEXjlDO/2qTmHyd4zzsXYCbeBUlunp9J
 V/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295884; x=1793900684;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a0PaeL8Kq9xXQ68LcaL4C9LzPYWjngZnEBXFQqSQpZs=;
 b=kaJ5sccgxMVDZOyaX6o1eG4dAwN38H446jxsG8xTqbV/hwGaEJEAPY1WJLqAEqMXiU
 jNvm4/IUtKMeRSSXZ538Z+h7+WnMQj+DPMWZYh1Cy/BQptM0uyeMvh/A0GK4Q4u9/1xD
 bg9KtGBL9HgFdMuS4a9+Zs8MvtmU4ytzdaUsweytBjLG3DNRzwuAz4kF2QXdpn1I3LHQ
 kLkgZjhzIs81Qd7gBexuQfNDe4Zinc/f0R98kWFBjAVNv7yH3P0gPHly0ZTKPi3GOG4j
 ZWlnswH9yqZLJkiGkxlStMPTP8ImUwS79q9/R3NZaGi9Uyzx4xMwZ2IDVHrWsLDPocMF
 1Gtw==
X-Gm-Message-State: AFq9FYKbALiuqNYqrralAyiuFOLzeU9haFH7Ig29kaBVCQYxpyUxVYGt
 2lTsoQaAnAilii8kLL0O+tEh5yGECIEGali7t/m8MZaFeqB0qc/qPjYKBJny+qVPSHOZ4QknzMc
 Z94TwHnalAl/YCwaq8vOrSNCLA46CGRtDYRZu5r9AQcTt0jU3Pwo33ZPKrYtrRhr+vl9W
X-Gm-Gg: AYBFou02+NGu7R2d7ob1nahv8swAOEXs+Kfkwc+i08xhBCadTIVoubO5kgCvCv9mdZa
 mSiMAtoV4A8a43O63W9m9Imj8Wvbjw1vWN7Su2ymJLKXeR2d+k+G91EktLcHxGP3N9G5BdWtccp
 22A60c7OfhB4rtg2NTR2aA2iPfbQJfKux8i9+xiysTG6+sFT0dtQ5y/jzXDcGvnVXH5K8zZb+wa
 Fux3cO2b6LbQd/sC8dcdVgOBIBpzwXxorDPlQoZOuUeDwvvBKsf+vPvHC7vdrrj4zLi8euuYg3u
 uFvTgnRrfPUKdceeLMYZcESSb9xyok/B7vxJFhgV3SjwNgAd+6EZ/8+85DBo7hiLNLfBN5u85cY
 8gMK/JyTKmHUBPWf/fy0y3EyqYOpyvwVeECObzLullJsIMPcKH7Obmsb9lCHT+iK18TrPbVNaOA
 E29g4LSnXt9vuuXCY7+3z1SIqj3VVqfA==
X-Received: by 2002:a05:620a:1999:b0:93f:2610:fb77 with SMTP id
 af79cd13be357-94408cb0768mr958841585a.45.1793295883992; 
 Thu, 29 Oct 2026 10:44:43 -0700 (PDT)
X-Received: by 2002:a05:620a:1999:b0:93f:2610:fb77 with SMTP id
 af79cd13be357-94408cb0768mr958837885a.45.1793295883432; 
 Thu, 29 Oct 2026 10:44:43 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm5432845e9.1.2026.10.29.10.44.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Oct 2026 10:44:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/12] tests/docker: Add the mips32r6el toolchain
Date: Thu, 29 Oct 2026 18:44:22 +0100
Message-ID: <20261029174434.27985-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029174434.27985-1-philmd@oss.qualcomm.com>
References: <20261029174434.27985-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX8Yc6LS+jKRuD
 MjhyO0emXljvNFQ4czBcl5USw6+HDtlrKvR/FIApAVYSKo3BW9A4qAb3PiLBB3FzGAujEP7l7a2
 7a0woSwLsqyHO4XzfCIEFchQOTzC/90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3GzYHbD0m/29
 joQiHEMcqPJqLduY3nX1G+8BHrysEEFwIPoMNT888sp2i6hnsEnD+ncxOASHXy+tvJWAAUnibIg
 haBQhklMoW6Jxcjb5bU8knQDPnJWpLSWVz04XA8H/yETQWqH57WLrk+zKzJ1Q4k5r9YUbRUQP1t
 EALe2d7Z8G93epl3uvxEfVpGFoWhYSm1QdVDEzLAj4XD65ctsIG+HksOw8n5W8Uu2RQng6gtNsN
 tQsjy7pCFpELRVgwvORDQwZALo9hN+QBH8Dwqan4tTboGB7iUroIbBN6rqY6qky4y8rt1N/OH38
 l8UmDmNwkF70VvMxkOakJ2VmPNEsZfNF0CQUBmMgY6BuJobpUxzsMHSkesWLzAjB7B6kUHyV+ko
 Xy59l1/IvQSTDb7I8sQcT/bUg43blg==
X-Proofpoint-ORIG-GUID: n8l8gbuqQl6CyFbBM2qU63N44PGcBlTh
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae3860c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=VbLNOaZG8fVy0AOA6ekA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: n8l8gbuqQl6CyFbBM2qU63N44PGcBlTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Similarly to commit eaba84a5e1c9 ("tests/docker/debian-all-test:
add mips32r5 toolchain"), add the Bootlin mips32r6el glibc
toolchain, renaming its mipsel-* binaries as mips32r6el-*.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 .../docker/dockerfiles/debian-all-test-cross.docker | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index eefc03c49a4f..d0e59df84ebc 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -129,6 +129,19 @@ RUN apt update && \
   rename 's/mipsel/mips32r5el/' mipsel*
 ENV PATH="$PATH:/opt/mips32r5el/bin"
 
+# download mips32r6el toolchain from bootlin, and rename binaries who are simply
+# named mipsel-linux-gnu-*
+RUN apt update && \
+  mkdir -p /opt/mips32r6el/ && \
+  cd /opt/mips32r6el/ && \
+  wget -q https://toolchains.bootlin.com/downloads/releases/toolchains/mips32r6el/tarballs/mips32r6el--glibc--stable-2026.08-1.tar.xz && \
+  tar xvf *.tar.xz && \
+  rm *.tar.xz && \
+  mv mips32r6el--glibc--stable-2026.08-1/* . && \
+  cd bin && \
+  rename 's/mipsel/mips32r6el/' mipsel*
+ENV PATH="$PATH:/opt/mips32r6el/bin"
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
-- 
2.55.0


