Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571B9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPm-0007Dl-I5; Tue, 18 Aug 2026 15:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPk-00073w-C7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPi-0006dl-FB
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGp552494350
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=; b=hL9Ivjkn7v3D4I9g
 28rKAfFPNlJcPiaYGbzkeAsj3RqFB2jgj7BYNd7vXhJK/Okv6KOb98j3iN/8a74y
 nmsf05sqveGi4n3EV/oQHOSKX14w5FFOpYHdxuZgnkV9k05VBujUfLkHVqodT7+u
 h3yK23l4y14ywP+SH2PrTpa64anX0LG10DcTFCPjRYvqnp6a7bSrtC6Z0nHeGCvg
 1jVLW3t9NXLsSd/oF/FeHVl/TE6tv49oERF2RMHdspm1HG8fW8c3o/dMK8ahZj4W
 qc+KX7jLzQc8Ig1V6qZye2vO6AfD5r4Y/6tmVjLGtRt+oNRFhYUbxYLDx5/kfdrj
 +madhw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnha64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-848568a6f62so340920b3a.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081026; x=1787685826; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=Ai9t6dB1jjoxXVPtUJqXi2qbCs8WuRVyKMrnf59pJe5WCTGTUcbwx0ffTHt9k7OjLS
 EFhWWkiUupFhDOu9xSFodL4SEFhn0QIbhbNpbbMZOs9O1RTqyLpxVjHN2BlhrCM46kAt
 2t8AuJXfRl/nUVtWSdsueiqvFA5+mrW054uaU9LFslvx3hX5A1rlzt1Qx5/9TWh13eIq
 1IjldIGK2aLBJdLd8FNs/zqxkfNI+hAEyHPBnPZwZaQw4hrd1DGD55yc/REOwIUAB36P
 PxjHiOdVGXKHFODGbjxMp5yHwNj2AfH8gKIppqkwa+0RMhQLiVcc60bwCmOTGL7EYMjI
 Ob4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081026; x=1787685826;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=YthqycKbPOI1+kHVDfwPYn/yEWLDZ17UWuNBfr8LJOeuWhE8Y/YoUuACMQqe7NK9mu
 cYH7NyB5boLSHbAy3Nc4W1lgnpfFcvNMoL6CMvkUgMO0cwnE3zZTHASsheeD55PkUowr
 DicTDDXuhf5vSfD6t+6Du+TvQCBRZ8lL/VrGnMbZwZpPpT9mQkoyg4f+0/JDfRWonqUI
 jpPPNHA8GhT7xvm82bEPiXkBjh2gISCXFtt9RK7FpZN0DtI7/DB79Vgfb8fSTwO6t4uH
 EZcfvIq9CaBj2EvWDYzAbUG1Dfns9xaCai786WVjts+iFaBPcPpLQUzZNzSxD+gw8Mcy
 ZTvQ==
X-Gm-Message-State: AOJu0YzKsovb4+aK2yOJretv/Zt7UiYO/BofkYy5o341v6XVIsoGab+9
 Joruh92wW1PXl7ah7mj0xVe8Gd0U6+c9fYFTzqG4qTem4iHa1Sxb2AtjdicP4D8Ft/6z+fBQSxq
 yf44LLqAEUO2/goY9B/eYffI7lvMXcjKB5lhxcJuA6ariJEu54kCx9bxiszVPmtdvVg==
X-Gm-Gg: AR+sD10+g0PZ7Uck8s53wr3LykaQ0hSt4mgM0HjINpYBO4ZtgbnXBy3aXYWe0sbVIBn
 TEHlm2tqG7EA3muPk9jvgJasQ/niKSggh4n7pBtcJyc8aY9jHCh//pAGGJNKvWgCj3VtZEI8rcW
 iaa7yFJYDbFnqhCjiBA464N6v9iL4EU+EexfsGSUFgjQf2qA9iZPTQwOtKlaoMHXs+bnsSYwx3o
 nOHFjreesEfTYDWTQz3AbtsThrNqmePvBC65fXdhcbqr7jalfFA69lU+n+ZB616GiXjQ5F+42lM
 EEDcL31Gcl7c9SDye0bXcR2fuR6bSs/WJfu4pr9DUM1gTAG7Gwu5flMaXbXZjZkyfjg6EU+JFGc
 /wBoaFWJE+SlDK6bmBn3oqEfKiw4SsxFqojQRbAOPeqUhQGcG8JLcrR+B+Rc=
X-Received: by 2002:a05:6a21:71c6:b0:3cc:feb8:ce34 with SMTP id
 adf61e73a8af0-3ccfeb8ce9fmr307367637.17.1787081025839; 
 Tue, 18 Aug 2026 12:23:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:71c6:b0:3cc:feb8:ce34 with SMTP id
 adf61e73a8af0-3ccfeb8ce9fmr307289637.17.1787081025445; 
 Tue, 18 Aug 2026 12:23:45 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 019/104] tests/tcg/meson.build: add wrapper record_replay
Date: Tue, 18 Aug 2026 19:21:43 +0000
Message-ID: <20260818192309.22169-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7ou2CRh9QAOK
 KBVxe9Uz3TaCTu3ty8zie45kY9YTxWSDqdC8No9F/dBEy8OHwYU7mkU4besTNDFFOcWQoqFWQ9r
 G7Tvazz+ERdH4+1oDJmH/mI1pIlSo0E=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b143 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: c0DtYaORyUfYWgk5olMxVktfQyHgT2Lr
X-Proofpoint-GUID: c0DtYaORyUfYWgk5olMxVktfQyHgT2Lr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX35IgsN9XUyls
 3hCEYXgk+cKnyzAprpQ507wOG2vsGcMbTSeB1dDC00mWDRd+nzeT0ZBuz0luq13NdU0RHPvVgIW
 f1n/RMMwEJCUJBqOrDl1uCblx88EalrPdrIWp8hEVOnwJSH6bRh/yAiZheo+bgRt2Y2iqpejD3B
 quTD4lw4bhWdrGNAZr74HtqVlo17T6dr2nJVcoLIWCwya/Koqmfnh/bll8NAIpi3LgBTzxCi0nl
 DXdh3l0NEophNqA8v37bvIQrUzFBsWsXItyq0mFOkafZ/JaAGSPKm/WVJR8yx3lCONinQ63zT9O
 43t2OLlBsY0iyHHgKFRIOZcbHMK/MXSvGRLxyFtdXLhlE1XcZIhVdzSvwIubbU0p5NfTE5pvBVG
 Ng593wmbbS+mobT7ttrQkyskIU8BRUpAO5ZTQBEPBQvUr5BxRQWzIxsUjRctsKjU5z6ljvx2uvo
 jfNW5SOFaBBCmVGRUpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

Runs a record and replay test, and make sure the output produced by
both runs is the same.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/tcg/scripts/record_replay.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f2c5d77bfe0..328592b28bc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
new file mode 100755
index 00000000000..57775a2d4c1
--- /dev/null
+++ b/tests/tcg/scripts/record_replay.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "record_replay: qemu_bin [args]..." 1>&2
+    exit 1
+fi
+qemu="$1";shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+set -x
+$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
+$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
+diff $tmp/record $tmp/replay
-- 
2.43.0


