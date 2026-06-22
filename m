Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4416CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkPK-00029U-LL; Mon, 22 Jun 2026 15:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOR-0001SL-1O
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkOO-0001vw-Jc
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:33:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXPq11592138
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=novCirPSAB+
 Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=; b=hKYKoW6wQjpTP15CRsMrZ+0r7C+
 qqHdPsCrWoLpVs1RPrrqd5o7sMISAsL8404/1K2nXK4aa02R0UcSP9JwVL/AGRO+
 QN6+k14odJYBgIfi5wO9Sdzi/v2Tqn2mK40MJh2tuKXTgxSLof3EOHpkSKMUtkd2
 MY5n43zyykVJLLPYRksgDqFFtvNI/zNaKn8/JcHzMBO6zO8S9AiyfccwQm1Lw+5v
 A58wAsQt08uPiXr/XPC4e5fJ5wr5p+BFxKv5nVNJkbSz2RVO++5JXPbc4/fXSpDa
 xbPbH5s5z4L/ptarxtH9YlMhZHIEOQjkERFJjgZJJY6ewaJZAScotosK8qQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41dxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915d3261c5cso1004858885a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156779; x=1782761579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=novCirPSAB+Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=;
 b=WX2Qh9BEl+uM/6jb1WU3b7NfQYvLn05vaCGlrJHvlIXbaNF5ti2o51HyNdVS5GmlRY
 tQykE3TAN9jEIaBiiWi8avW0jA+StLBa8SzaonQWMlKZyxYSjftkP1Z7OQ9dGW2wWkco
 aaQJ5vGitglhihYtIHD0RJN6t+v98uIX6KvyBufWnQbuTey11TVGMpfQZFDLS2HsCB/v
 134pZ2gfUIWkUbraflOakZqrvLezkSITc1vrp/JhTPTPu0u0ZtgdZwkFga+ZmSAm2Meu
 VKyO5aXbEGlELxh50F6ohyC1Umw9LfJAnmVXRIDCNcgjX1n37MaBOtsdInQqHPYnlfoA
 am5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156779; x=1782761579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=novCirPSAB+Ybo1QyBdlWXtDjYfXG49M7VvGodoMtJI=;
 b=ECrSlOhNpurbrWX8+gIyeiG8Fthvn7TwDEQeUDdDjwf/WDlRFrPpf0DobPyT4j3IIh
 4KgXFGakkNVvVQzyZdIUft6Hd/eIxg2rP01rlNbMvloRCsLkVjHnVW892RwJKNVmRFWD
 MrYIfnPf/S38u8N8ArD+3R23v7kMzHiPLpNE3tf7b569GQPvQlSh/xTes9aS7H8iGOsn
 KDd8GHPEaNo6fxqAVSVQGisZq5ybGwahd0PRfQIku5uLZ3f0rbHAKiTsmSFGDBlFO603
 aIBI1gL+nmuhK1Z3bMjSf3HZ9x5UtsUltBC+xCxa1II7X9Zl5PXzMffG/P+8QcJ2siaa
 P/Mw==
X-Gm-Message-State: AOJu0YyzQ4sAZLNh2VhzoHxR3eVpsWZj78QESb0kabjYtVKWT5fDxhsB
 O7Q5DFXpQWJxvVlae7jJmyC6oQ6txe2PezvW+QZi5+ie1MC+4KaS2iTOaGX2sh/9vcDE4VA6bIm
 f6Mfx/Bta+ZejWlAHX1Oho7BEPEkYMzeN5lJIPFpWP/+y6IIT/OWoHPyZ3fFF/WE1Sg==
X-Gm-Gg: AfdE7cmJqIOJGKJsR+y8WItHm1UePoZl8PWJdwUUB3/emSAfwOeXy2GJjjSpNHoHtKE
 nQbBV7zCkxakpIyr83Z2X8MhajSEJJtEWXplB8up9x/mcfo9HJBdiDqwAqeHNSthARxDHCgOkvx
 OIAepr5tCfmYue21thqy9+V/RUrGPhtZWHleQ5Zg4bqvoaB6dGEMV0xcvH5qlS4KsPLq8bWoFFe
 JOh1lfBfdGG6Qd7sXPVvuMzVgmz+ufDdPAXQ+3aELSE4MGxqXuvQyUM3h8FrI1ws7yY62j5ShwD
 EUvPd9fSsZroF6ldQorTDZFRZKHKR8xsgPPiJr/b7aKKaawdJzHqUx0WGCFop7Y+Ns6RNl7Q7Sc
 edSCtWCqLekf5p6fUsE/NnMb+h3nDZUAwzVFPEZ9jKPHtUg==
X-Received: by 2002:a05:620a:4386:b0:915:a811:1707 with SMTP id
 af79cd13be357-9208f05c719mr2351405785a.5.1782156779076; 
 Mon, 22 Jun 2026 12:32:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4386:b0:915:a811:1707 with SMTP id
 af79cd13be357-9208f05c719mr2351400585a.5.1782156778633; 
 Mon, 22 Jun 2026 12:32:58 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:58 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Zephyr Li <fritchleybohrer@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 24/24] gitlab-ci.d/crossbuilds: add riscv64 KVM-only build job
Date: Mon, 22 Jun 2026 16:31:40 -0300
Message-ID: <20260622193141.1449724-25-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX5N6e/9r7A+Wp
 oBTTdPJW+yP9EGE+XnQoRUyHtcgo92pUYKtQVfO9kim0zNM3ExHiz86He+OC8fbwLXRhapVTRT8
 +TNOBbIG1zy58PIxosjvTF+Ltg3VpU4=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a398deb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=BEvAcZqKd-QGyfCP7A8A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: lUBRjtYzaBQCciB9_m0gKASMiRf5o3rV
X-Proofpoint-GUID: lUBRjtYzaBQCciB9_m0gKASMiRf5o3rV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXxX49Y/KO616K
 3+WTWh3bB4MllJSaZnt0j2CnNlFMQg89dxjOFdIyWdPhVf7K2MAG3z0iOLZ5Na2fNurtbHHtFY9
 8oKeGWDgVInFjQEz3U1pe2+jtw+QMqP+P8OXcijrzGUVsnF94RARUGO8vBHNvGcg+mLc7UOse/4
 QCZw1sKYkZsS+FhC/KOdNcu635kQqrHBki+nnm7sIDpA7g6hENq3NBDd94f8gUGVQx3ClTz4tlQ
 3PYruyRLpwxTSGMn4MpSOGdNQBPdA4CP4VC3fb7ZvkC3CdBhFxe8WCgLHRInTBVfp3HacKZzIL8
 /vyA1TpK0XcLLsDzzfFmQ/3TR3A+reyeDNX6si8dd9hMCCm2yIX0xzw59C6IVNoG/snruwoJqnr
 7GNNKR+w6cFhi0QGjZ37UxQuX+vL7EnNElsv/QwObGPtX3Ic87UdD2ygjST2KqzEwkMAm+E9fSN
 Qb2YCUU6xPxGEuBdT+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Add CI coverage for a riscv64 --disable-tcg cross build. This ensures that
RISC-V no-TCG/KVM-only builds keep working and prevents TCG-only code from
being accidentally pulled into common RISC-V sources again.

The cross_accel_build_job template enables KVM by default via
--enable-${ACCEL:-kvm}, so the extra options only need to disable TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 .gitlab-ci.d/crossbuilds.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index eaeeb533ce..a823aaaa21 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -59,6 +59,14 @@ cross-riscv64-user:
   variables:
     IMAGE: debian-riscv64-cross
 
+cross-riscv64-kvm-only:
+  extends: .cross_accel_build_job
+  needs:
+    - job: riscv64-debian-cross-container
+  variables:
+    IMAGE: debian-riscv64-cross
+    EXTRA_CONFIGURE_OPTS: --disable-tcg --without-default-features
+
 cross-s390x-system:
   extends: .cross_system_build_job
   needs:
-- 
2.43.0


