Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QhtVu7jg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FoyaZ89d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmp7-00072v-SM; Tue, 27 Oct 2026 15:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoo-0004XR-5r
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmol-0002Bj-8C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHOxV2945716
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gn1qZ8VWVeVW8PyoeeLKU+L9P6KAemHz+IFCpmOFx4w=; b=QhtVu7jgQHqoP1o5
 2PvrWr3cnlOC2vZQ8q6iYJEoyn/ivwcw94p9STUc0pnmv4uhx+Xd1EN4ACuMrM9u
 vC9QF6OKW7bnF86xhV9s/i2efV208lj805AJ+50bqP/fWD+xTlSfLRdkGE0CCeK6
 shSGgQ9ufu480JZsUWLnfqCsOmTka/fl1TqdeCCbGzQaJaJka+eYZ9V5fBQL/rKm
 8aMcpHoyGV8q98AiSnhINtgA6e6NLvLzNc/iWHUm14fr64+GVRAldTfYhhrxM5Yp
 mJBigMkzzVayP6nnsMZFzuR5XalllfZkrI9N25kT9Zqeq4y/CELMAN1iq9OZ+5XT
 AWcY5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq6apg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:42 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so27427185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129202; x=1793734002; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gn1qZ8VWVeVW8PyoeeLKU+L9P6KAemHz+IFCpmOFx4w=;
 b=FoyaZ89dtyHI9wYLW0+XU9WiLe5GhI6tTji7CKc+5DMo06rQneeE4OnmHO8JquvjyC
 uaDDDdGUI/mf02Edu/iizoRE3t14y0l7pAKxHG4/oOGVhiSNyHlNaShDd/2nFrZWTcMN
 Y8StU/CbUYq3Xe7FThEBZoyXcCXmTXHOUgoy6XY2S+SEbkOZePJNv3UlClpJYWPCTcPN
 dybhT8nzpO5Q8+I+p0Tn2Q+GHUjxZR6MU2tYtiGz/H08Iok7Gx9a4eYFzTcb+oC0aKNn
 ztq0++CzOhsqem5AsXf01l8xjo8qctc7dkeO+bmkLomvnDT7npsQ5w/4KQItKF4fSN0v
 insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129202; x=1793734002;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gn1qZ8VWVeVW8PyoeeLKU+L9P6KAemHz+IFCpmOFx4w=;
 b=x5wxlSj3bTPUG4Ng5VxEcTCP9sDQ709IhpcIvPmNICPmHF8QbYKRDXE9o5O3SZAR6y
 BsOpmepFNlmKVNMlu2yjOWEzu6Sc66B4MrP4NZ8jIkT9M8o3JTjuV09ugBGazWV/4ulW
 ATTgPPTej3RFHDtmuYGbLqyXlIL6Rgz2HwGsp13abUNRRkCJyHJKzMb7RGUcUitoa39Z
 0UOidWN/fxO73j3zk3YGmTSn/bfJwNz0jnpKc5DM7zVpKzDe+2rY03Mv/jfusb4LItxG
 7yg5TKRH3TE6NyqsZpulKi2B9UuT+Mwi6mW1q67LWNlw/eQx9Mz3WQRK3NItTXFNaBrs
 Xw5g==
X-Gm-Message-State: AFq9FYKKAGOyNWiq98gEG4ff22KQvsCp0m9GEL65B5HGhggzKDg+g0vU
 Xa39NdvystztnuLYZLJAaCTTyMOtoTTgzZnKkTbAxtI6Bv10Y9v67iFpZktCgP9Hqxb80Cwcx+Y
 62hPAW9ekq6BRz84ldEwoWKueg1cZ/2vcqlgGbbM6RZs+EUhK0euUrzGzPj9gf+xsOg==
X-Gm-Gg: AYBFou1S6J4JkgupK2zhW86iymOsskYW1eoKlU8azqyt63LY5AUOD8ygUZeZJairekv
 ePi+3ImeSi4btapL0PRtLyXj5ikHWmJwlP0J9L4JPTW8mV4zfGAE75awJSaZHiz6hrqSQcMvEVl
 FWorljyyp+AMwIeGeQ64amObmh8KBBN4ST+mcu/OASlojqxPB6h9Vao+ZHgUugG83GT0CaCh7BL
 IlM0/6wuJ7w3ZyXuCS1yycq1IzFbhut7KEwogqKuRk4z1WR+1iRxlthk5e6db5Xdy+9yVje9swQ
 yVn+RgKC/TIEs28OTQFMX8vEZDckFYyyYHsF8QFaW9rEnQdl0YwhJvEmaPA+ySNa828FgzBoLgB
 bvDHT5UZ/tmi6ACR70FBHon97vDv01e4f2DKCiliSED9FFuNh7/qFB8yJ
X-Received: by 2002:a05:620a:4441:b0:93e:e1fd:b87f with SMTP id
 af79cd13be357-940ef9c9453mr1581028285a.83.1793129201664; 
 Tue, 27 Oct 2026 12:26:41 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:93e:e1fd:b87f with SMTP id
 af79cd13be357-940ef9c9453mr1581024685a.83.1793129201199; 
 Tue, 27 Oct 2026 12:26:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f36asm24749128f8f.1.2026.10.27.12.26.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/59] Kconfig: Extract config FSL_IMX7_GPR from config IMX
Date: Tue, 27 Oct 2026 20:23:07 +0100
Message-ID: <20261027192341.9197-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0faf2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=8JKbvHrISIDU7W56SM8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: nJiSS-EzYr8Oey0BCXTsJXsUTWq7VX5U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1/yTCL30g8+T
 m2gu4ekwdg39kc10CYQugPKdLFv6UU2vNBcF0ZP20ljD6/JCqFNR06R8eh/lOEezdS8F6rZKpDp
 cEKuBomVu7iKSqfVvYIUthpZ+S2FA9o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX7vHoW4J3HJKx
 5ZmAcFjEV2JL/CEbSud75QaVYYvZa4o4AdI/eAoM3SofjmKQOO60aw579PU/jiFZz9bhtvLF5jG
 tOvtu87JGvwhPpd+c5WvnwrJzaq13ZizCZrmR6+AiDZO8cLigUtYR/glNUfEoO2+IYvL0+x6a+K
 bR5qqXCmCUcX9qKdXc+FLQa1m4Qi2FxEmoTllbRkOMAaHwU1q9XY9r2n0EkQUEVYgzROl17+GeT
 tFxM/t2r0giMFyFLap6qoeSA6jA9H5HOVZ5x+ei26xoHOd8ix5N+qk8IZAufHmKxGHHI1hyFmON
 r8KL+P7O0NewXlGm683XdguPFnKT9OVzuD7m7g56ZEFe9YTS1PIU+l7fnqLJfO0Tq1/yRnWbFg2
 S7gQ+SeMxBZRle9m09xVhAAF05+QwpJqsve/9yZePtswT5rUodgsA+7UNQMQCU/nu3qDNXkaVhm
 mB0r6okiDPU5CZnhnTw==
X-Proofpoint-ORIG-GUID: nJiSS-EzYr8Oey0BCXTsJXsUTWq7VX5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
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

From: Bernhard Beschow <shentey@gmail.com>

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config FSL_IMX7_GPR to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-22-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 1 +
 hw/misc/Kconfig     | 3 +++
 hw/misc/meson.build | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 53f723661cf8..55e09e3d9957 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -579,6 +579,7 @@ config FSL_IMX7
     imply TEST_DEVICES
     imply I2C_DEVICES
     select A15MPCORE
+    select FSL_IMX7_GPR
     select PCI
     select IMX
     select IMX_FEC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d9991494b7fa..b329d6bfda97 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -97,6 +97,9 @@ config IMX
 config IMX_RNG
     bool
 
+config FSL_IMX7_GPR
+    bool
+
 config FSL_IMX8MP_ANALOG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index cebc5f0d6ef4..d6f1162ff9c6 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -62,6 +62,7 @@ system_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 system_ss.add(when: 'CONFIG_ECCMEMCTL', if_true: files('eccmemctl.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pmu.c', 'exynos4210_clk.c', 'exynos4210_rng.c'))
+system_ss.add(when: 'CONFIG_FSL_IMX7_GPR', if_true: files('imx7_gpr.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_ANALOG', if_true: files('imx8mp_analog.c'))
 system_ss.add(when: 'CONFIG_FSL_IMX8MP_CCM', if_true: files('imx8mp_ccm.c'))
 system_ss.add(when: 'CONFIG_IMX_RNG', if_true: files('imx_rngc.c'))
@@ -73,7 +74,6 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx6ul_ccm.c',
   'imx7_ccm.c',
   'imx7_src.c',
-  'imx7_gpr.c',
   'imx7_snvs.c',
   'imx_ccm.c',
 ))
-- 
2.55.0


