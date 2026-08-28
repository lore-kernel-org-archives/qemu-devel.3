Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDB6C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05YR-0001Et-98; Fri, 28 Aug 2026 19:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YN-0000xx-Vt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05YL-0005oi-Vw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:00:07 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMUB5S3777796
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rBCEKQcDYst
 8FL+P3lsTLAlKApXUvbVZjTMWLzIPKE0=; b=hjHPqB399pbQ3f044iYHyGQkNNp
 5Iz1VarMyAiozUmMSc9/gmzJM8XhcwsHIOmTvA5qbUZck4r2h48zZRlIbhbTBMfc
 UhkcDGASfUU6WYhEwSx4Um0lcoNz71BiQ2B9EZbxQ+tcaOe8uQAsKDtG/L35hHAW
 6Y0TbZ3sovcFY5b2GdfX6oiYTjNcKL0iqnBwY9ElDfy4f9MdEyTy8kIUASzBxTb4
 T/GMaQxqlBYgSmLLKDd3Rf0KaaTbsWMzQYPT8XhM2Jbr3SO/JxXskUdO/QA4dLxL
 33CretKe8ephV814o9CSfSftBAsoSwxoxQZ0r41l9BYhPQ4gbmL2GZlAW4A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbj3er84n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8fee6af3so2069628a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957993; x=1788562793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rBCEKQcDYst8FL+P3lsTLAlKApXUvbVZjTMWLzIPKE0=;
 b=US9VsTW+qoZT3kGgTV26ViXnKxWzU64KQvvhyX73xWgXEtcni6Mg7rCmF8JHEk1ydq
 Mf4QlFLYk00RRLwKM17eI/9kgQWMZyHAzcfwMrKhHh//qgw9O9+gVSWn6mf+c1QzuEZp
 FFR+FJ34olkTGQ9Hr8AlSIusOzqIB/PU3VbP3wAjIu3tvWIkaKx9KA0zZVOlgAELdFgI
 D4i7Ixf3QhYM7345idtEwjkWCIhukzMYvW5rZJ/rZ4xB2rZocoDJXGnkLj2Bw+7bflE2
 8UjDLzl0MlP19FZgiK2iAeugMchQsXQbjJ/LM7OQAshU9W3AicON0pVyiViDiZi3/U8e
 Mjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957993; x=1788562793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rBCEKQcDYst8FL+P3lsTLAlKApXUvbVZjTMWLzIPKE0=;
 b=MGmvZ7ADYKQ/NnTdITxm1yBu25omWn8bh/ROEPoKX1nv3HR/CDaKNeYHSX5giwbY/W
 QkXmFHmVfJCO3PSbT4H/EuGt5DEqG65S5Hje/ShaQIb14MHDA7cpoAkImsTX7ObwaWmA
 735YiuqpiiSZS033tLlAmN8JDLPc17itUfafDDOD9B8A2c/8choTqj4r/rdGlU5v515u
 lBzZMK+kgTuN6jMl39IU+ptJ+xPu/MIQ0jU88oQYY+O3n+1Mmcbi36p1VLfHQbW3mM88
 2yHFeSrZiHWwdasWiH3Ig01Gnyn39wU1tKHMJIHq7OPyNNckL6z3X+a0xzOf16U1cr1x
 Zc5w==
X-Gm-Message-State: AFuF++lF5mJM/PzFQuUHaBp9OPNUA6rN+ysbbFsEhuM8vObdWh9PNThS
 ZaM+rU0ltnRNpOHFrSqxBNYIg9aFRkvBTVjPPAbkvTzOHHioBmFKU/X0hHhxJuSqXp0Nk9hseAj
 buZm0UQDZ/RSRS3o8bsn8pyWPHfYRbMuU3ZL3CT37eeSW+yJ41d6J0psdcNOTM5n2Lw==
X-Gm-Gg: AYBFou3p6hiKqbMDfVPggnzl+0lH/EAvbEVsbpnkAgoUfJRpMaFY8OFe8knW+Gzrq2r
 NY6yLXzs2YSkLQ4bA6GFYNQ0r3IFBgP89mOvCNMUrPUgpCkHoyhVCGY9ZteHhPKnpJf6V/y+tKv
 KVl8B17p+oiQGoD2ZYkvqp99L50vzKzDxAh2HkHAneEtsGYyeh9BC7LR3at/7TmM9jCo/CbTB+Z
 ektmWbqaMdl0zqdIEKj3TssPdQGKDJ1vj4O5YPLNAT3PaggR5rMtUz5J07aa9H59edw4WoKDzYC
 41ipwrLe1o3o/Kk3eJDDaXIUdUshDz24Qc/ab4Pa56vCT5IjBw8dE2foJvf27iqa8TcdYnH6ia5
 FwIDgVUss5E1j11Hk5F2SFADV0wdVUv2LDInBrngY7hxKIcYPoJfFzu3rIkw=
X-Received: by 2002:a17:90a:2ca4:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-398a2a3b659mr1798001a91.19.1787957993230; 
 Fri, 28 Aug 2026 15:59:53 -0700 (PDT)
X-Received: by 2002:a17:90a:2ca4:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-398a2a3b659mr1797968a91.19.1787957992761; 
 Fri, 28 Aug 2026 15:59:52 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 36/47] scripts: add single-binary-compare-cmdline.sh
Date: Fri, 28 Aug 2026 22:58:50 +0000
Message-ID: <20260828225901.367438-37-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: peWzvxuj78NxF9PX5FFaBPuuHpv9XaBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX8Zi2MkU/lIdj
 guhLMyiiqhTK+hT/PwEeVMcPS4UK083wjQJQJjU/Agt8KxQZxLyJ23NC5Yn8T6WL4c3LKibbr26
 4R+/1WeA1SDx1vzQXsfkvaSiUYpTYVSj+30lN+jJ4I0JHM039MLB77iEz51Bkptqa2BEEUcT6Tw
 8hYSPRD+9a8WYFFcIrG2pqQeDP6WEYQZ2hM+kHvpuE+8IPnB/04emzty52atLI57hWDhwPdP1qT
 VQlX+O62QKrkeIUWFiyYcsQesxSLN/x0JabEytUdkh5GlU08IK4lToe4/xZVGjS0mWkHmq0wnGt
 g5ajnN46f669KVwbwhVZNKwgWCvby1XbMBnLoBIqiG1uOPex/D6TKOhkKXU6bUH7bYQM2kjqE7l
 4uUnNJEaRX1UJy3O2qu1zIMMswZIBA0MrI21hMT4tLRi64/a98Q5vpvSWxcTuRmwtBtEWnJZ31X
 uPdkiAydR5AXosUgIBw==
X-Authority-Analysis: v=2.4 cv=QLVYgALL c=1 sm=1 tr=0 ts=6a9212ea cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=XUr69sVFxOoefRFJqTUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: peWzvxuj78NxF9PX5FFaBPuuHpv9XaBT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXxOhzKOvGsTSh
 qEEXWLmao26V4Fo61+8QIY1iEoDahrQ9/0Bsm3GtOIju/ET/1XqvSzM48J1V126QpO+2ZIk7sY3
 d8Qp1aNIDrKc16wTTuVVahmjFCkxvLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
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

This script compares output of single-binary for each target with
original binary. We compare cpus, devices and machines.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/single-binary-compare-cmdline.sh | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 scripts/single-binary-compare-cmdline.sh

diff --git a/scripts/single-binary-compare-cmdline.sh b/scripts/single-binary-compare-cmdline.sh
new file mode 100755
index 00000000000..a9d4cb4fe43
--- /dev/null
+++ b/scripts/single-binary-compare-cmdline.sh
@@ -0,0 +1,51 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+targets()
+{
+    ./build/qemu-system -target help |& grep '^-' | sed -e 's/-//g'
+}
+
+filter_version()
+{
+    grep -v 'QEMU emulator version'
+}
+
+filter_usage()
+{
+    grep -v '^usage:' | grep -v '^-target' || true
+}
+
+filter_trailing_whitespace()
+{
+    sed -e 's/\s+$//'
+}
+
+f()
+{
+    filter_version | filter_usage | filter_trailing_whitespace
+}
+
+ninja -C build all qemu-system
+
+ref=cmdline_ref
+err=0
+for t in $(targets); do
+    echo ------------------------------------------------------------------
+    git diff --color-words --no-index \
+        <(./build/qemu-system-$t -help |& f) \
+        <(./build/qemu-system -target $t -help |& f) || err=1
+    git diff --color-words --no-index \
+        <(./build/qemu-system-$t -cpu help |& f) \
+        <(./build/qemu-system -target $t -cpu help |& f) || err=1
+    git diff --color-words --no-index \
+        <(./build/qemu-system-$t -machine help |& f) \
+        <(./build/qemu-system -target $t -machine help |& f) || err=1
+    git diff --color-words --no-index \
+        <(./build/qemu-system-$t -device help |& f) \
+        <(./build/qemu-system -target $t -device help |& f) || err=1
+done
+
+exit $err
-- 
2.43.0


