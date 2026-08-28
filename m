Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09EDC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bX-0001ek-4Q; Fri, 28 Aug 2026 19:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bO-0001Gr-7W
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bL-0006Cg-1f
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:13 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTU6H1173226
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Nino6JBH84A
 Z2+4nAKHJPw/s41dW82dnegwr06zpYCE=; b=eBkUHuOwrpAD/N73iIHM+RaIl87
 2tcwvVNGO8VoWbQGJP6sxDIhbROq6D1PMcaA6hC4GTvyy0kQUgQnNllESnmOoING
 6GREhf4yFPe46oXt2BPF5tZmjbbSsufshxWvQLAmAKLCE66K/tBVtC7HlAdyENuc
 ssx8xt6Imf6/RGm628Zr7LdmvJ5Mcw06wFFTf81RPB6ZNh06k8OiY22Zy0LvC7N1
 Qsk3bYUE9ODXooH4xq4hrouC9SBqElDcSF6YX+uYgz/uR99fE0Mzlgyr7VUH0BzI
 WbG45YbACjFepl/Z0IGM7L1G5NCSclOkTkVxaTQEKZoiVwUllW4MkdBUkvg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjkh7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso15788115ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958189; x=1788562989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nino6JBH84AZ2+4nAKHJPw/s41dW82dnegwr06zpYCE=;
 b=feGKqZgCZbmbrmbks2eSWztRbzSbTPL2YmwCenuL6gMELMn1UDC5Xlo15PE5zY3PFv
 Wzk4OHn4ui3EnUIwJhwotEZe1oPgeSithVp2Nv77nnz7AEDXrFxMusr3KB9KRuNhjQcB
 GqC4YJPFy6aWSkRNljPT5tQ2aVdTFl8bVZBif9wZPv2xQaynTukbQE8a2h6jiHTberPL
 Gd4blkwahxsMPvemm8+E/rNY1fbljsWuH3SG5V6xo3qGI4+9YHl+mnmB43baVlUxvzb4
 mt+hzhr1c+vMMQB+7DeFdT1miVFAnsrqYhde/uL5jYFJtfv5mtyVrGpFbT/ckJ0rtaa3
 9+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958189; x=1788562989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nino6JBH84AZ2+4nAKHJPw/s41dW82dnegwr06zpYCE=;
 b=D8IMrgtA5uSwabBaUeOnEr+ol6h0VUf3cekEE3lo+52QyXESpFDvsudb2r02Qbrxju
 uwdgd1Hzy9Hd/96jDWMgwqXifoiyv7qJh0zHepQmKGSpaxd3NgoP0UQJJXukK4K2fIKA
 gDEsQLOyecLgqKViC5T4RL9SVVnz4H1Ts+g5aA82p3GFq0erPo14zzZ+H9jfQHO/h0vR
 9xstlVGP+CPlkhJmbu0lYw2OobIl8ffxMBZrYid6sI2rcwQbBLAQR36M9jQl21YxvL9C
 yD9whwhAJgD+lNZ7llenpm3Hb4nNRKHAdc8RVemeugTe6RXlkBPqM29w4+SypprKt+LI
 oKHQ==
X-Gm-Message-State: AFuF++moBGpDBQ3JTeyxloO6lnGK8CEoNtnoKOHgh5yX82RyoV9m8669
 +opZHapRRnqUs25HUFPQmT1Jdi2qa4J7BXWnxWdzZwCrP9CtbOs4gaKxYPA+4Y6CsFp7nG3CU/P
 BNisdu04I3mktmAFeVqRCtLs2z6xZIOYP+n7/eOs81UexnDkJJTaAqauiNfYwYaBXrQ==
X-Gm-Gg: AYBFou0W2qz9bvcPFMZTKlMYVrrRLgbrB6wE/U+AgpbczWQIBYfbnSFbV6amFzpqqP7
 xc+xBbMm1m/MZy9jrovRsKWSFzX1UKmGHkw5AaNWixIdzbXzvuV5lkQBQUyOl/3+7QCEFkeQpHU
 FDjtGciqxANbJFXm9LYVnIOwvYr6X14hQp57L0QXHn3VQKQ8Pd2gq3Kb0DGmUSuUetaGISnekJv
 YX0AphyLUL2co7I8LJ+phQWATDHYHH+srwalnj/ifuAePlM22kNBw9zT23BxcyJRxfQ1xLnlSyE
 wLrdHA2h2LmyhciTeUzgOffWowhfGaiw2Ntw9gBS7hTtSGXd0VNCivOqolQJtU8pt5VfbxAbSXP
 Enm5FNyERlRyFo7ZRhsGZ9rcsjODYXWkf7gNJG9CO322Vb8YwO4mzQb29zCk=
X-Received: by 2002:a17:90a:6c90:b0:398:9beb:5c1a with SMTP id
 98e67ed59e1d1-3989beb638amr2593313a91.21.1787958188711; 
 Fri, 28 Aug 2026 16:03:08 -0700 (PDT)
X-Received: by 2002:a17:90a:6c90:b0:398:9beb:5c1a with SMTP id
 98e67ed59e1d1-3989beb638amr2593263a91.21.1787958188208; 
 Fri, 28 Aug 2026 16:03:08 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 47/47] meson: add microblaze to single-binary
Date: Fri, 28 Aug 2026 22:59:01 +0000
Message-ID: <20260828225901.367438-48-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6H3byTPRd87ZhnhQ47owXZBMvQlOrNbC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX180N1TvjiYho
 xEuzyVPorRXM34/0x+wM0uDhlOMgtztHRKaDulOV0xru8ft10SC4bWxLg9gToYN20W+6HGtY44B
 edyCbflELCAL3CGa3eCxpYzB3GATGCs=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9213ad cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-xtC0e7rNwfgX3VXp6gA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX6Rcfoyn2ZKg+
 AXfcl6vpmfPoTr2BcwgEJQH7rpsfxyN8btoKWw+vBUv70Ae4x3V2dPgJLU7T0HwWlUig6m0kWk+
 juTQkno4NV81eiCwXymSfiCIk7nVnZsq8PlTVhcujmUGneuKZqs5+laeINsP7RV24ATZk2n7w4S
 wxPUG/RO/EbK+drA9RgNlU5SQjyUfQ0nYF6sLKt3RSEx/+DGKIvjMO2H6ZZARSd2+nKjpo+lmdU
 DR1teTFfGSnHgwXwPq7OdL2/DM223qDEroLJaOGSe+/bQm8VtpDf2w6oYAgPh+BaccgW9u3xJsV
 AkVQZHxrobEsLDsoXxsQ7A3ERPIL+8gq//0SaUcxiEe99dFp0UllnRWX4bV50OC1BhIiFhSlAPF
 WVlCUqyPlbZfkKDfzhmTnV05woRN/8kHazR82/Lbqg9PBEmay6fssXX1A0f7k2p0dqZ96X8YIk0
 +E421aJRgIYf44RSc6Q==
X-Proofpoint-ORIG-GUID: 6H3byTPRd87ZhnhQ47owXZBMvQlOrNbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

We still have many devices that are not yet filtered for target
microblaze, but the goal is to expose them.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 9cf441382d3..9b9f7271194 100644
--- a/meson.build
+++ b/meson.build
@@ -4258,6 +4258,7 @@ single_binary_available = false
 single_binary_supported_targets = [
   'aarch64-softmmu',
   'arm-softmmu',
+  'microblaze-softmmu',
 ]
 
 emulators = {}
-- 
2.43.0


