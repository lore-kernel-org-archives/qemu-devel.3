Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BDAC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZpA-0008BC-AC; Tue, 28 Jul 2026 00:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo7-0006Gp-Ug
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZo5-0002YL-RG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abjt1303539
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=daoGlI2ileC
 E5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=; b=Yk0+SfRrIzJEnKh3FWt+YSUTTKE
 mTsZU9fk5oWQUdE57RbY22AXDp1libZm2j0VFV7ZoiIYf1rE2FesGX1jad3KAaWh
 /PRTVejV40LW87B0xwD3a+ltyAUPR62hqLHFiS3KNJvael6bGBKWpFUPj87SVr7r
 rQR8ZO3FvD9CdBvSsrIwWwpnotKooqxebgj2LrsgqZgbT0eEts9m0Xs4YFiAtiP0
 2QzD+FuceA2CJVm2uOAzLOXDvtszz4p2gKGNy4Zq2WSA8aDIWnVlb9BnhbO2N3qD
 2Rp3yEqHB1kgyGwlQJPKEkOxSFG/v8uwk4WM6UXmMTYewbxbfzPxKF83VGA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp8agxk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cccfa32670so46241685ad.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214364; x=1785819164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=ZmGclP6dxDkD62H7nuHQWfE5rwK6tLtclasnzNngMIjV00Xr6aQC1j1u9SU5rv22+C
 O41g5KybK31PFZhlElvqC9IsyvOpz0k7olwxXpUwLeeMq/K4XP70ITgR9TpVNtZMW2TD
 OFhXa+YpuWz2dunXSlKYZHOxgdlCzExpuTUb4VrZzXuGx0kn6a00359ImyFXj74zZuJx
 oOiYJI+8XMhAlLWzY37r+L5UIf4tXTAFBAPlwxgVlN4JbzMaXJpXS6eDGoNI01NzxcXA
 ZtF0ttrVQ6BQFBF90avJb4nsWPYCiZbTitXdQ608LKlKe/aOC0yT5m/P72LyzJS27tMu
 HDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214364; x=1785819164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=daoGlI2ileCE5+NKrfWfvG6pzTbDBfXVzFqgSTYNXxg=;
 b=lVjltfm3bgVOmTygS94qQdQHdZfo21iTKaHW26Sd8KWdo2tP1OFGX+KVdRnLqLTADP
 Ps+LMXvEcXDqY+29mTFYyNvqlTR0McRx/VefzaK8f52A1QMvmXDaYstESNBGLxyGMQnX
 IvcoB0vwQtFOCfzbt6EznCJqnV/pPrKFbnpRMy0np10t869pxiX3pMCKUiO9ySRdM30E
 8pNloCesi+p0AnJ+MwVmPbYi2OlzRshJzcyx6PgNNaVSLtI7/oQbdBobNLyXNb8CiYO9
 csuHU7ypLy7S90QshmSUMF/yYgz+JqFF2M3mwnKiZzhZ0/Fx+nilXSkXm5b50TuW3W9Q
 SQwg==
X-Gm-Message-State: AOJu0YxiZuOk30PIGpIaHJjjU9TB3sFDRrBuLwJpvhVo0DXUw5q8Hact
 H6sSyJVqkTwOCveTgzE0ghaFh04g1O35OgjgwG+fE1Ay3UYV/Y/4ZZo9HPgQ5OG7H2bHv3B+8IE
 VuFB89/MS6rSQ8DZNBJdS1I4SvelH+nK6eRc6zVDy7lgQyOSNWstInmGpF6Zf0C/ewQ==
X-Gm-Gg: AR+sD13yHxAk7CXkIKP15AG1TlcljTqukVmF6REdSREILjUXDyIYQl+0J/udbs/Iirx
 Xs4F8QXbPbOEGdRZ7FOVd+9r0i+Aeu3MYaRJOfY4qB/vZbGG987xFsw9BkpDRcXzR8BpR/qF2hO
 PPOEh7tsX27Nrm6XXqxdN3q4rOxxno1uvttEILWOfjc2ZwQ2BI9MsqK2c0Rk6ks9GQHKicNRNm7
 MIjwl1Lgh2oU7JtJVpyahnfgXYx1xWPXDvzs/qe1ChvGLewervZS2vQgJgtnhsqzRo7BR7iHNdl
 +/x4p9eTznXDfpfmlhWsbzDnM5xpzXFCeKOBzFdek0c2On70+WDkbgRQGhZbcFUa+0jpQ1QiJjQ
 s2W64M7ZlGIsRRJG+zkUdvg/3qNHyS++zH4VoyU15qPk5rInR3lrrKPfC1sBmkx+xiKQtGPM=
X-Received: by 2002:a05:6300:670e:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3c8aafa2ab8mr1088080637.7.1785214363884; 
 Mon, 27 Jul 2026 21:52:43 -0700 (PDT)
X-Received: by 2002:a05:6300:670e:b0:3c4:3321:4fe9 with SMTP id
 adf61e73a8af0-3c8aafa2ab8mr1088065637.7.1785214363480; 
 Mon, 27 Jul 2026 21:52:43 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 093/103]
 tests/docker/dockerfiles/debian-xtensa-cross.docker: add test_kc705_be
 toolchain for xtensaeb
Date: Mon, 27 Jul 2026 21:42:37 -0700
Message-ID: <20260728044248.137626-94-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX1vo82a7d6vfl
 CGRCznYG98jjyr3OVGuP1K8XvZ9pRCvyjDE5SIum3lVEOQPzD5jNj1sQQ4BIar9WwSTQcKYQyB/
 VRQYjYzasjxEL+oKLx9qP/fwWZH5iew=
X-Proofpoint-GUID: 87bsoYYR8fPp5JaMVl3jBV-wd00r9wVX
X-Proofpoint-ORIG-GUID: 87bsoYYR8fPp5JaMVl3jBV-wd00r9wVX
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a68359c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wlx_lthn7XJiM5nFl28A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX93R2ri+NWqZI
 ZmtTM/xZyVrRoKZ5fz17RATO7BnVhfOEGIPUVr/wFNibcGOg2I4eWY3QJbXXv8Z5Z9AvTj668I6
 VIptUtWLptf2jsBOAhhWPAvogAQYNqlhWzvFxeKdo5dJbl29NWmzOKaKgwQxwZpBsAcEIxMlBzg
 g6sRSJQUr2ZhqqLXrzwxamPn/urWfZcotJWYjntG8WD1x3eHNTxLaOC1I3GQ2S6DNAoeMJ+t5sI
 2wXHVIFykrMZE7oy04U69YLsgsdFgKhUysD+/STF7nv7nmPQ/vBV+SFnuGSlkzHLUqsaOIJsJfA
 BQC5/vfVeh/HdFSgol9zAQnEK4yXVoRCQiGZu+n3oh5LapgLHrHoI5qcykTVcVPLC4/fSDH2Ln2
 N/eD9ZnO/iLNdAaaiPrVa6pyXW0b+DyINDD0w3MstZFLc4J00SdmVukbS/Ea5qsmVK7Khx8+iKZ
 2gmDsfcMsbT/ey/1Fbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/docker/dockerfiles/debian-xtensa-cross.docker
index d9130fc3378..0eb6d98cc75 100644
--- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
+++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
@@ -19,7 +19,7 @@ RUN apt-get update && \
         python3-minimal && \
     dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
-ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400"
+ENV CPU_LIST="dc232b dc233c de233_fpu dsp3400 test_kc705_be"
 ENV TOOLCHAIN_RELEASE=2020.07
 
 RUN for cpu in $CPU_LIST; do \
@@ -27,7 +27,7 @@ RUN for cpu in $CPU_LIST; do \
         | tar -xzC /opt; \
     done
 
-ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin
+ENV PATH=$PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-test_kc705_be-elf/bin
 ENV MAKE=/usr/bin/make
 # As a final step configure the user (if env is defined)
 ARG USER
-- 
2.47.3


