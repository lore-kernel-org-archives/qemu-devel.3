Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C07606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZCDngQv5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KkNEvaey
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrIm-0004YR-3D; Fri, 30 Oct 2026 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIk-0004VT-DY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMrIg-0002N0-Hh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:26:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UHu6Wq3430798
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wPXrh5g8kF53RbTwh48RpR45J4qfOxXYj+zhnpZeRbo=; b=ZCDngQv5N3Phdzfq
 uFIzZUneF7wokZXe4Ow7b9b7NgwNrAgG+MdVNIiDA82AvzJZqZ+gFSsHVovT+b6D
 jhd2sL1HozaE1whChHCSXx23kqn3xp/58gjrC/kiF0I2ImdYG7UNUFjjNc+w1g3w
 B7taOA7J9oNBXmk6ayU1ctouRLnIkRSjOvHmdzs5vdeGa3JjPmFu4+T+qcGFUMvt
 QiioFRslkj/fnFXcpoyifCdzj/kgc5MMP45D3NjaE46K8nsvkq46BohKU1hbX5nJ
 GTq6a4pSIWZFyhwpcpohZ43AN9XIUAE68fWm4aedcwsqOLf8ImRJb+VF2Svl+r2S
 XvaDoA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qmfjs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:26:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1e62510cso221695385a.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793384759; x=1793989559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wPXrh5g8kF53RbTwh48RpR45J4qfOxXYj+zhnpZeRbo=;
 b=KkNEvaeyu4zUAYCPtb599IuyYXuFLcShBujjc7+uJH5sIX3R+SPZDNO3g2cipSH/bx
 JRkEnuMFn6dG+K4NAvTd8W4KYLsNe0U7Q4Wyu5OZT2duRTFkksv/titXBnq4x2Y5LvHW
 I8D/AeEAGtjqgWUykvtkUbUF35Kjk4XiB6Koh5CVwcHXylvLU4o+v99oAyJYfTbzw/F5
 CcEpUvW/I4H1EFn1dnO1KrWOSqhRqvEeJwr/4p7x4q35/ltJlPy+OWaPse4AMmvFV6Xg
 vho/9lTpnyXNVWNqCHzMb2qG8Fjn9WQ4ZmMkwzv9Hqye6DYCQFjTmZSLal8ugW/DiRA2
 3kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793384759; x=1793989559;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wPXrh5g8kF53RbTwh48RpR45J4qfOxXYj+zhnpZeRbo=;
 b=p3KBURNGj5IQTl4jjlzsURaMkF1psOHrSxqtWTW765kR6lZEl1RNXV+7rXCg+GWmDw
 tN2jDj/HGNlE7ik+0fIrarmncn4J8D0+vG5Cytrw96EUJhat8DRAiDBZ2NtqDkMJax4U
 aZBoxzPz3acOmc2DQN+F4PQVMxQ/e9u+IFy+zggUzJinY82DrYdgI3OM7T3j8bB5kdI1
 x/kaMSq9AwRyxxik00irgnKc5WMy2M83WdsxR6/t0dHjUFef8Peg3GewsYeWdL/oM1cp
 TbyyfDhsKgCLf0j5McAoEfVlgDoonV8RObtzVDI2U/NO245KmdXrpi5sCVRWzhv1Do4U
 ooKA==
X-Gm-Message-State: AFq9FYKwtmsWBz/DP40QrGjb7NDUIGBoodokX7jy5rAQATg0vOFJJwW1
 OrrkMGhmW49l8wZWhvQqNq6sDNR2IGXT4nH/1rR/PeLgBFaumxkgrAxGLSlCvVCO+clevFUM1dY
 LEuEneBRBFPqbJU6ia2swpQraIyQB1MnsLOkvnMxdFJ1X7i6c8kW0PVVfaFSMVIFtD4iN
X-Gm-Gg: AYBFou20IibclFYUG8ZUpdofLppdbTQ6Rj9hzjW2NrMI1y6rs3nl4kquYz5+tR9D/K/
 OyFi8kZfiK5+GEA6vHbQPOlzlJ53IgUH3QX6vdtwHiFcCzsag3rI/TRvSga2pzE6YAiV1G6GsTS
 rtIlCIAPqiHaCDRsT9tBr0poKNcVlsOMsDNB7UVI6jyanFjgxDo3FCtaLhkfTA8W2cm5uycN9ul
 Wu3haRvTtJo6VxyEUxsYXOty6syYpfkvWF77CE5/8lIUWh9olc4ox7LtLnvpKiDMWwpQG8fga1k
 yccl9XuNoHt/j58BLSdH66K/5Dxm/qp3RkkYNwtvc+Ix4ihQTV2xPgYxOeBgIt3aLJHuLvYgzzY
 NG0fLlmf0tu95JCJ2cMMWt36seAjJqOG6U8A4uRGSa//CKW4MwHvWQyqb4lBo/N0A/+zRzurthb
 ggp7sHBxSv5KfvDBqYJQ3D++DD3lRdwQ==
X-Received: by 2002:a05:620a:4409:b0:93e:f97f:f245 with SMTP id
 af79cd13be357-9442173e65fmr530434285a.30.1793384759277; 
 Fri, 30 Oct 2026 11:25:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:93e:f97f:f245 with SMTP id
 af79cd13be357-9442173e65fmr530429885a.30.1793384758792; 
 Fri, 30 Oct 2026 11:25:58 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm50035595e9.2.2026.10.30.11.25.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 11:25:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/12] tests/docker: Add the mips32r6el toolchain on Debian
 cross container
Date: Fri, 30 Oct 2026 19:25:34 +0100
Message-ID: <20261030182546.2508-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030182546.2508-1-philmd@oss.qualcomm.com>
References: <20261030182546.2508-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfXz9FRB4ZqoTcv
 hgJ23rtjR7VzKM/dldWM8jO4tOzXNwhJ1iPJB7UpsmnjpVFcBPemFm9iepk8JJ+fWqzp/rmEnoF
 k1s8q319+vRyqSTEsQJgo5v06+BWZv11+NsWBdjSU1EJRymoywTibnkt++iU9p3ooF7iSjZiqMc
 a+PJYjKoq12VZmdNUoJMHFkXBlSbJ5ITa+OTrPH5S4OlpbbzBiruiMR5BIT06Md5Ck6w5asa9MV
 7+A5jL8t70FjVNMKBKFHvaYG1Gtn+5OGcxwLWNLpYGWwzuihjqYlSSeFoTlwDgPP3HLEvwXeFaM
 CLg521cKWfcHC3bqanODTTErhd+Zi+4c2uuznK/1Eqm5ZhaH7EO99Eb3hKzbg7u6OuZsoI5FRSn
 Z5pK422ubcfmZtAQ42GgJvrakFQnprSZS/QNRAzo/DIv6mu2HG3dmIW26FaHxOwDmtkcN2d77IO
 5R0FR7Y9Iyq5ajIokWw==
X-Proofpoint-GUID: xEDgYEk-GmfZIU2i9pN7gM3p-toV8HEM
X-Proofpoint-ORIG-GUID: xEDgYEk-GmfZIU2i9pN7gM3p-toV8HEM
X-Authority-Analysis: v=2.4 cv=IumL47/g c=1 sm=1 tr=0 ts=6ae4e138 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WYtM1JM4fG2UmubedU8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MyBTYWx0ZWRfX1GbgBLdm+p8j
 tjpe9geW7Sk84i3WyxloWEDXmQlbZWU/CGoFGxWd9f+PYchwZTDLJr75KhFPMdpcaUXWE9rE0Sv
 EYinbWK4N8zqgIG7sJTa+FujVz0LPH0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use mipsisa32r6el-linux-gnu-gcc for the little-endian MIPS32R6
tests and install its compiler, binutils and libc development
packages in the shared Debian cross image.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index eefc03c49a4f..4bbed2cdf08c 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -89,6 +89,9 @@ RUN apt update && \
   libc6-dev-mips64el-cross \
   gcc-mipsel-linux-gnu \
   libc6-dev-mipsel-cross \
+  gcc-mipsisa32r6el-linux-gnu \
+  binutils-mipsisa32r6el-linux-gnu \
+  libc6-dev-mipsr6el-cross \
   gcc-mipsisa64r6-linux-gnuabi64 \
   libc6-dev-mips64r6-cross \
   gcc-mipsisa64r6el-linux-gnuabi64 \
-- 
2.55.0


