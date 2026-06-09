Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1098CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JD-0006xN-Tn; Tue, 09 Jun 2026 17:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Iu-0006eq-0X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4Ir-00082E-Ig
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4hcs3229313
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0hQu54QMYIl
 yDxg7BT6SCUjLRp767RiipdPlv6BEBxM=; b=gqJlWazqT5lSbKAGGiVpfxR1KOW
 bdIFm/Jv5c5wqcNI49T4PUu4vme4Y9elzbnlkzNGm7uGjf1k1zjoNNFHAoDfTdEN
 EaRvjiubxn+Tm3D/10XKkEhAW/qH3dIKGZo0sS5Sh3aEV4zZM34tGmwFtZ6nYkas
 GASLPTjYsxEjNHYrPF1aaNf2/kok4xYSgVOVP9+GGQ8099Aw7PccjpbwwBvSrSs+
 Tog+dSkobWVIY6zk9qTgVqRbS19ZU9hGoeASnWff//t/uygNAKP4/8rMoyJpmJuN
 6dEbXhhvJH+5SvWP+Et1mO13q61wxLs14vL7mz9trOCRcm5TSdQlXNW3YjA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wkg0v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:47:57 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13825e1dc0dso10306258c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041677; x=1781646477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hQu54QMYIlyDxg7BT6SCUjLRp767RiipdPlv6BEBxM=;
 b=HHVMmlUok3svQNr1Wr8mzBq0toYNX+ey7zTifsGkIg0XxpEsu8ZenbGOZ7W+wUmi3b
 6/URvFp9SW/U3T87A1FgtJMmnRgmUNej/LY+cECU9g6gdKlY+5xrm/MJUZTaquXv7y1M
 wt8zhZ9qF+jHN1IZRpgQ6JqwDQFKfB3jKBieqwPwE+P/2AVYzoeaUniud9Y+/fiha2Qk
 xBCS5noIizXmMbBy3EKltuaJ9nmbq0tLCmiFJpuDHAoCvtnrBmzPn3PVmkDpKpIehY/6
 1nFBLTnatzDKfrUin879OZXCbvjlcMbLXQmUUjQIgNjlPl+vZqD6Vx7qUrCZoouzmjSi
 KMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041677; x=1781646477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hQu54QMYIlyDxg7BT6SCUjLRp767RiipdPlv6BEBxM=;
 b=QtY49gwJUzeiJeNhoTbDWtkxjsC5NKRHh1lhGl58srgfpWheRqMKuxYvxE58FZkswj
 rX2LJnmZvtYHk08KSCAcgOw5dfEq3EgXNSkgTYG68fSR/jROx+Rr+hhpVSCKrqqNY3li
 aojGiENDKXn35mCzIttLI/75HyPm6wfnDcQPVQtOiohzsI8+4kM584twla6RH3Ca1+1X
 Q4LB8N9baBBnSGboG243CR8gQv05UEdnoPiuV1+8F8cI7r2eKwTZPQGPrSec5mQuETgi
 6hNbGNZccBFa74hrOqq7U+i+E8kYzjY5YtxuK5AuRR1AeIIycsiCgS4H/61y7aig4Fir
 jgiw==
X-Gm-Message-State: AOJu0YxHlPWZqPbduck+PfI21S+hddJw8M9pBrFGvCtX/M3MWBkFVefW
 9MiwFBngMBalNqq6IAFw0wv270vekRN8W5QAjfW5qJb6JHeJXW3Ix2fPazPYtnsXK1Iw9nA/mRE
 xfTWVUzeeStPrSSjrd0FA0S0Nd+hc7UCIPMhs1+28codtEMgV0nrO4hDubdGoIKAyBc9Y
X-Gm-Gg: Acq92OHf6Loduum1j/tVfm43lgnZYaK+7IXhULpEHOSAGpW0tpzjuM7UxPnWdF5oFtH
 IeRVMTyB4rf1ONTbZLo+DvltwgBoXpduBJ+FEpZgpCq6bp6SjXLyBWi0yRWipyVuFRhihZhzRll
 EfGyae0wXKKbwsT84Zv5TmfUu3BS0gufrgKodd792/jjkVtTwKYvqpn0EEvcJJDNk/AqFwOefL3
 pjrFKyX19hIAlIolAMUDMCEjExP9PHZeHFUu6J8CE2x2DRJMihqG2wbkUhi4d2C9IXqzKgFSO4J
 lQCz+N5XGEetrUcR7DZl0kigXX5BzPycJLd0d61YrUo1aRAXacXwU7FUkl9oCbiFJYc+PctwQc7
 Cg1p/vxis7aPYVEQYN9vxqSoa+b7eHhXJlTty1/GO0mbMyjRRA3zMq+TZa6WjvG5prbFEWbQGmY
 WgQLj0LH90389bhJ1W
X-Received: by 2002:a05:7022:699d:b0:137:d08e:e5b1 with SMTP id
 a92af1059eb24-138066d7b7dmr13058520c88.16.1781041677292; 
 Tue, 09 Jun 2026 14:47:57 -0700 (PDT)
X-Received: by 2002:a05:7022:699d:b0:137:d08e:e5b1 with SMTP id
 a92af1059eb24-138066d7b7dmr13058497c88.16.1781041676769; 
 Tue, 09 Jun 2026 14:47:56 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:47:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 05/27] tests/tcg/meson.build: introduce exe_name
Date: Tue,  9 Jun 2026 14:47:23 -0700
Message-ID: <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNCBTYWx0ZWRfX7rWcK8t+Xw54
 uJ34BYSnSvLbKvstYQvrIBPPqW2aI3M6pTuKUfmFzmPA7nyVxN5Xa7bmfxCJ3UHBnjwaMLtvZ7N
 QjsftQwH5K+oTz0YKvnQN0WdVtihEiDs8NtW0Lb9+q0Nd1H0QYsdXGibMBORqXcROGaYDBe0cV/
 zooU+M2JeIog5BHeIt861IpUFe9EIeJrbzPIH42AuK85AEgQbsQtmQvXVR7QU1HFDgH2r4MsZj3
 jI+Wx+MghNZ8jbP4E0fkxzjdlDqId+7pawK1XX+/CfPuGgtJHRQBav9KKVrTUK00BGWBHzn86GO
 1Xox13+IA3Xqp0Oywo4WHsuD/HU879S0IRT+J0pGydmT1NQgZTX5B1Rq9QMHQUzOLYdrqm5nyHM
 9ndAvBINOuUlPubGkOLbnabvdVkluq0+ntGq9HuI4HW1Zp4pY/JD8yYoC+qgn4iVhOCOi1QpqZj
 Kn50tT45cblJutaQrgg==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a288a0d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=vdizb8zAaNHivpZOFqUA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: X_PDkE26gYwrnfwQgrX3iYn4cjPYT9qT
X-Proofpoint-ORIG-GUID: X_PDkE26gYwrnfwQgrX3iYn4cjPYT9qT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090204
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 72d1a9f8986..2c6d85c586a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -47,11 +48,23 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user mispell a setup entry
+      foreach key, _ : setup
+        if key not in [
+                       'exe_name',
+                       ]
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src)
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       test = fs.name(file)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.43.0


