Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD470C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9L-0003Uz-At; Fri, 26 Jun 2026 19:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9J-0003Tz-BD
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9H-00040Y-Nl
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:39:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMwpUu2164214
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kYsRi60bZ+X
 MseH7JHPo09A5L4aoD4jUIjMAggqIN3M=; b=c+Dj7j1WLMh+99CnQIuWp7VDuxY
 1/NrAW0UHI0rAs5fM0+LfIxk8yXyvQblvLyerSCJgpPsEQBUHATuKbahEa4UrZzV
 bYzOsc0lCx7NB8MS8pHWBJtBKKgfIMwyVYOrZZ2bdhXkbnvKQ8NM+5RT59Fv6NgT
 VWz092LOWGa73K2rxbubBqrxv3FGl6kRalMKZPkTIPMIdOxww9w1YWIkJ3l8l0tW
 /x/ITSuAU2WdDfnylkC1NAI3D7mv91l5lWQBjSRsrC+7QNK8K3J+inPfZOND9zg7
 rU2fAGjUoJUkqFzkGhf7OJqC0LZXjffoYJ+1H78BnFzLNCYo2PVtFTaZvHw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgdvkpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:37 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ca81e05bfso1094100eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517177; x=1783121977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYsRi60bZ+XMseH7JHPo09A5L4aoD4jUIjMAggqIN3M=;
 b=NNACf3bW1ZFsx86mvSh0Xh1moDecAVWXuUzs6681PB3mj86v2wBbsTxk+2b3t4j+RW
 f1jRPCFzGxp7AKFPADnznaV8+Av7vWhsUVN/jYKfi0gCwKdh/zZYNNo/Kswq0/Avhpxu
 9/6GjtduEJMvANhfj8FmTh4gqIN+9guWHVZutQpwEwCwWJtz+ePXU9QxY6OzrcIMiB7P
 K8R4f9FitFwzJTW3d4UR79RktQM2aYgkP5NyffubvLYDtKkP+ZhjWkapFlSGUkfMlmwl
 i9QyPZIJ2b5PsZR17ZBp0QPPpU1qWv/Laql/a8yqaUUPE19BBX60HM4E+A5RkePa0VvE
 ZRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517177; x=1783121977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kYsRi60bZ+XMseH7JHPo09A5L4aoD4jUIjMAggqIN3M=;
 b=tUDrwmk3BuujsqHLFZ/iDhAHH+I9LPZ2c5VAissD/B2GuJ23sKLaJRSSgJImY7UZOq
 /LSjzVWPb3NgsD5ZEqiIQJBizz7bkh+gt1Fpebd3phpnWg2DqNhMKbCESpBvLteg5YIk
 d+wVCeXEH99eK/QRdgV0ohGc/GP9Ej3IFa2vYMm4OIDFJaEJBy5RdKz8uPfMSsybXvLC
 3EmOEc/0vHBz1avolmY4YkUnsEpZM0k3kf2BAYzAwfnJP6jK9mTm+eo9KlXKVpf/WMTB
 GIDZQgNAW/PlCyvobOaiwahYhsRiuClIC10baPRtPtWsOSB3iPJOdVv3Hv5ofKmONY8h
 aA1w==
X-Gm-Message-State: AOJu0YwxKH5qBTqA2sHlriUb9Ue34H/xMMrP7IcfdVf4xFnhpaDFOP/7
 ltnt8OmM0/JRWo0IP0YNk4x/rOuJRqg/TvAoSxnTNIn0ZqoKgzbHY77Xnxko92SVGDyoddqW6Lr
 LRcxZEj3K+3eWL7oHp3oywUnK8mxQcjLYwkWi+S6DMSqgVf+a6t3N2Jnf6WTyiCp2cw==
X-Gm-Gg: AfdE7cnoABKwVlrc9rnoAQmOxnhukytlZqZroqO8vSveS98L+sZJKg0oaqKTjlq4LH5
 1G9nYWtz3TsCfAINamfKe1lV5V61vKaq83WmgBFmuFv6VzQ0QlPy4D/G/ip926J0APEkMeSydnz
 ArMayGWiy/qay1FOGiMEUscZ5iHiw3wPFcLEftzQ3braz7OFeT8h+l89xumG5mbMS1mDBHHsJ4v
 +y7TVI5TH+oFQrQOM7HbKxQ2Oqfc1e7jfM9+FF3tlZHcxKpPC+iZmgGAn6GiztW/PUrpuKLBAg+
 mRX9vQZFxgQqG/zdOkwlxcpwqzIYul0a+D+Cklwf56Lyjua/gbJHNknMtwzmWISpuFgek1C2uxW
 qTWKAFNuxKOpYzvr631EWMS1GgcMktbgMpQQePnv3C1qrQgeZJPZJ+UOo4AFg4rnfWjSLgEEe2P
 fWojYeMg==
X-Received: by 2002:a05:7301:1486:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-30c84e21e0fmr6931527eec.32.1782517176855; 
 Fri, 26 Jun 2026 16:39:36 -0700 (PDT)
X-Received: by 2002:a05:7301:1486:b0:2ed:e14:7f5c with SMTP id
 5a478bee46e88-30c84e21e0fmr6931503eec.32.1782517176325; 
 Fri, 26 Jun 2026 16:39:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 10/37] tests/tcg/plugins: build list of test_plugins
Date: Fri, 26 Jun 2026 16:38:51 -0700
Message-ID: <20260626233918.158740-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=API5kwXb c=1 sm=1 tr=0 ts=6a3f0db9 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX6qUSY5x1dF+f
 rl/x0aukvg9D2tVU0iTIzBbg+GNXhWikWBHHY1whqvVkGfX3Rz74eYqYAHmy20cMToSHOr/RHg7
 nDK5HePcIUu3hu6ezj5mB0Ge0rDQ4Jy6zpjd7xrgyZ9mICLAFMarb2vneKqIZfcPKPBJu9/A84H
 B74yJKtfhq0diIDX/RNoq1IrEhM27vkUX21aipHT8g0wh9IHjDm5s8f9XDGHxVObqkX9pO9ugG8
 IBCwPkgJMLfqlXWnfhjH5nfcPqigG3F5Va/VjAf7xJg6d+F/PC3R/OIyi5W9p0PsBXO9kpME2yJ
 8aEhGH3VhFQJxw2cjRHYdYxM6mRKKUCegou0kEFPCJ1wMDLRjDKyVess2hr5rhj+69D/hfDLRSn
 FD9QD9PQFcof+xlQK6FoWQqllTP0oMye/iZ9CqvHJmMUDT0mRHT8fINfc54xAToPKPIjR7VsGab
 eGkS44S8Fk0TjNSGoJg==
X-Proofpoint-ORIG-GUID: dSBR1aIT3kimP2bhJ-PM2cEUIsPFINh3
X-Proofpoint-GUID: dSBR1aIT3kimP2bhJ-PM2cEUIsPFINh3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX17igrTHQKvG+
 7ygQbFQiRoCFhKjMzlR29SIycgQEZnfP9gvTo/YhcxWpHZDZhshRfTYJ7h5xJAmpcp/TcqhwPIi
 nLYlXrRmDFAThZOSKg8G2JbBJUcIHtg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c7830d2c17b..f5f518fca1b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


