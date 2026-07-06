Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryL-0004f7-88; Mon, 06 Jul 2026 18:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryH-00045F-TH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryF-0007F4-TZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEM1D1613914
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=J7sTK8i+t0s
 P9UO/TiisB4yEmM36IVj/ij/kpEgCxfM=; b=lGLY5y21Eb4/nwS22eu4X+/i04J
 MVpLE0TaaBJVnj+sD2pc4GNDrqcVUgkjJfcyd8h2nMSOUF7GXgjiQKNtBXygyVcl
 J/2hL0fpfwuPG6WyCc6RB7SWySuBewgGTepgrVGhCTptYBa0PxXHQ1JU0RXmeRhx
 GS91+3RzEPzl3ZDbmsy9qPhwgT2m3x0R3vGoX7MVhSL7gVqW23kUJCzIS3UkbmbX
 dFxcTFjVvCIQ+rDlaGdjU9e+aTB1JKyL3NtEjrLKzww75Shp44SbjACBBaX4NhQV
 9raLQdEc8UzMP6uSyuSWCwc4lOpWnrr4lbKqscNftPB6p6sBaAYILX1wA0w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53kb4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:12 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c892143db7fso2969682a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377552; x=1783982352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J7sTK8i+t0sP9UO/TiisB4yEmM36IVj/ij/kpEgCxfM=;
 b=ig4LyHjDA3+QsBWjtPtWDur2BY9UGZ1UzDD+TKOz/3VOJkYuJQe8r7t3o3aRw29Zzh
 NHlBi55H/pBjZGtauZaE6N8oW6T+O7bXd44sLH0vhN3f/OqbE7spkCHct0eSo3b8cd9w
 cfaFs0y9PsYn+Ax4VqnM+6TagcQReO/FKhp5TiSoMrbEY5u0KoTtJE5FqHsZzHuapl1G
 5MUKdRrlH26X6VKMOArmmsUBrhaMQ3Fo3xMdG2/vRK+C5zzRACvZdsLoIWAH7zDDmS03
 NWRCSmtOCGzAg1n+/R1mayR4LwbqauloTC6WSOvfVvSjFSKYJ4cf0kAz51A941BzeQ5N
 yvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377552; x=1783982352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J7sTK8i+t0sP9UO/TiisB4yEmM36IVj/ij/kpEgCxfM=;
 b=ppCnRsF+t9bkaNCMMijeEDm39rAN35bJypD6lCe6QdlUWJ+8FfKZtxHVZvgIRIWdR9
 ggbr017LFr65fP28oWXyoUNI83pCxQINsJwBXmAxKZqUOVgI7ESBA+jtbOmx/ETFJJ7D
 jHqP+KNwC+eWCCybUbM/Tep5ObAhyopD2d8OQZiT8mAeZUb4nyOEv6VkNLkDI2F9uAL1
 SxTegt7AJp0xL5rkjG9ABTYYRxa9ZBfACCKZhN0JR2E9aoBs7QNwEOCnH2N+2c1FliM7
 5ITyIuh7wNa9KEj8AkQ+EPfDhPaU85aoHEaTbE3ypInAJDXWKvf3ZFP/xqEDY03lWAvZ
 S6XA==
X-Gm-Message-State: AOJu0Yx//m6ze0ZnxpfsLg68uzZJ0qB9gUnwqqmx0hdkKaVJY7E+Vb71
 NLkpzRE6kvKSBHGByaB4eb5AaDaJ/DIfF9lSJcHSFJkHi4HFYHFfk4DmG461A0Y3NMxMErnNSKX
 PCWr/d2AIlPV7vlHuNje8ijFaWHzBCTLR4UhZgG3piqrFVoVgI+6SkScFDkQogTtadg==
X-Gm-Gg: AfdE7cm0RZ41ddChheMXR6wZSCXpsRC8aQcIeIx3WLKP8vA9EkNW3zLSvdLb+LMplt+
 5HlsVOLdXDIqH0dHpi3H+Q+ubV60UggCXcDxYMsvW5cn0P8HGE2pElxAFFty6YPNJ8nzy3OvohK
 bDqe7HcRpdqYncVMau7p59YYdNO4AnIUbHu47cGg2xwJp1m8XYB9QOX0cAo5sxyI64NvgEIaixf
 b7gYIp1OE3GWORzd9objlAtGF/l84cuwJhTT4qQeOIyXbo32rD/EFFPa7t1ga9OEhrIdNn0IaSU
 4DT39FexKqW57F5Fy1o15DtewQnfMokDUpc135tgDxn7MlP5DnIfPEMyoLRwna3EP0h2GN/oOTr
 cT7Dz/sIA+N1h95Jot0McQvtsDxOmo+DexAzBDPDyngf/eHNl2DZpZHjx9VtkSPH8M69sjkN4rL
 bWIfnxnQ==
X-Received: by 2002:a05:6a21:a92:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c08ef268b5mr3077900637.53.1783377551672; 
 Mon, 06 Jul 2026 15:39:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:a92:b0:3bf:ab4b:2d34 with SMTP id
 adf61e73a8af0-3c08ef268b5mr3077877637.53.1783377551206; 
 Mon, 06 Jul 2026 15:39:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 72/91] tests/tcg/ppc64le: user tests
Date: Mon,  6 Jul 2026 15:33:24 -0700
Message-ID: <20260706223343.988769-73-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u-NEbNdr0TgtSqljoJPJIF3rkURubD8u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX7HSso2bYCejy
 EWSo9hXPTfO8HCW/pDuXPxoGEwjWc5CWlX6V4ogkazGTWMmIHdPCM2qeCfVYSDfmtmkdnG5DeHL
 Tv/GE33of67hpjkd4pmpzTmCr0LZU4c=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2e90 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0UubJUxOnVa530in8RgA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXx4Gig94JKKCo
 sY0MTVVlW2ZeUNJZi1y7P59q/dpgIVAt79VoVCqpief2HAx20SXf+Gldo4hcxxcygNcIEN8n/tm
 fz5+0gp+SBtLCNCt4XdCPC9mIA+4Q8ePJU6ZHjy9k8L9JJeCeunYPTtxwMcmY0VFob3VHS14bbG
 ADrNtPCiilclbCI7Env8XJupIjdMp2eRMSWpouGTDSiuLIgREuGEfq8yudgdoYzSu4mJp1aNN7E
 iuzC8CXaJfv2lvRUhQY64tSkaifU0e+ako2rakHNzGzQoBQXItFdEPBvqDVjJ7jzavx95ll7IND
 zWK7orzUMGSlR1AJ3/cl1Wo19mMoffki0rvnseCz1tGQRH/LIrzrU3McBA/d6XjpkjgtxKGe8MI
 4YItw/ygOMogCsSOq2EuQ7TcgaCMszuyVmZNVbi3I4PXwydlBBje1IHsBYVE22f4AbfcN/KlhOZ
 Gtlmo9XdDoZ868xeMAA==
X-Proofpoint-ORIG-GUID: u-NEbNdr0TgtSqljoJPJIF3rkURubD8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/ppc64le/meson.build | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/ppc64le/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a23e63b8909..452af88f00b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -148,6 +148,7 @@ subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
+subdir('ppc64le')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
new file mode 100644
index 00000000000..1e464e23c14
--- /dev/null
+++ b/tests/tcg/ppc64le/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-ppc64le' in emulators
+  tcg_tests += {
+    'ppc64le-linux-user': {
+      'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64le',
+      'gdb_arch': 'ppc64le',
+      'qemu': emulators['qemu-ppc64le'],
+      'tests': tcg_tests_ppc64,
+    }
+  }
+endif
-- 
2.47.3


