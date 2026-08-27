Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1810AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziFu-0007Lp-Nn; Thu, 27 Aug 2026 18:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFs-0007JJ-FR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziFq-0003Jg-Ms
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLta6848970
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=; b=m66J1hAtz4pznhJ8
 CarPIytiLq34SJD8v3rab75m1Du+KtLywYr2+eE4mahb+zM/aQPKf8Ejme/IyGJb
 Bk7HxhqshEnWgody5+hZNGE+58CIDideAkISeOiJTPOhFkJ/cwXtn++0rQncQp2W
 waPBN1sMxZiFFNvh27glwYtoBPyHeNa017X0ginQtiLbJOe3dcC1TkTCAMybWtU5
 B7j+Igql7eRpZVc4J1qKjF/6KQ5JLrjNV3ptzeKBeL5ddoqCU4kyYm9oWIOYK6AL
 Nv5e16HgDVrglcUIi087DKRjK5eKpeWqps7xhiggYj2B4c5KVPTGakzOSGubIPhT
 1idlrQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a63q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso226289b3a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868435; x=1788473235; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=ikWzivhcktKlFVvqK2fd/I8qw21do6FV0PTU/Cb6ZxJAVVWHSSaSO+sMS8uHjMfHvO
 ZMvvoA3l0DJDhnbTPDtVpJo2vG3iLsOTlpWPfWrdiybRVSC8fBEXqg7Hs04TBWNjwDBu
 82N8lW3hZwW7R1DGGPyXbhzMjSOYZlFwTuKL12651m27Z3qBVBD8G+z+ZdaLZGjqajl9
 a3GQsVr5tcDajGHCJqXzmdlmkA98U1NvabUvV2yBDwgVlkeVXQPlBtm6BZs8X3ws06eJ
 LqC65pMUDJn0s5eRi63mNsWLPuQKPEXFt2+iMQFbjJ/m9Cjm7OhdzO8cp94FXagIN4Vr
 qAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868435; x=1788473235;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DRZYWFLWQO1W8mA/syKCtsAYUhUhOMUc9r7nLxakjOU=;
 b=hgs1zfHmhfy3eZiBfLre1KHMlRIELNaBOOl00V/VZq9SiNmwEaKrOiXx+j4uoO5Nxn
 duE/xizooi87ACs/FkX5TWYvTAFw83EGsX/aEBg/XnoQD14xTg7nHy6ySks+IYmfupf3
 F1W1MZ7kSmhbzdpq+vvFfk0cKp2FHtKu/jQgpo36JnhLZngvaaRihctS8GHwIwa53ivE
 AA64D3yUXw+FBmP3TnWwwMAAaaC9IDdFopVpE9YY1oRrKAwXltSVdXL21/Uxwg3paNhw
 d2bkyUK/3JVxR1k6c+BeNiS/7snS4bhbaOpxXNDszeDvsG9CRX/BHZgoByJoRsvKcvIs
 +9Ow==
X-Gm-Message-State: AFuF++mlowxiHXyEyDD/bTg40VWl5Q6KqceqPKfogkpNzyw7PaW8IxGe
 k/Qan74UigLD7R2yd6sn+GUvXYmtNTWnH/whlMghVqFjzLukKbwwaC188vLeViheh6ZzQvsCmM/
 qeYozNN5dLKmRGugrSQRuQh33vlBnhE7ZEtZGmIXGqgrhoQ2APi2Sd/ZDmVPCJbfvag==
X-Gm-Gg: AR+sD11K/WpHKax/t2CZoww78KdwrSKC2ziLavOJ6aRPvHrRJXVMeYAJtxlJtk2iwFP
 C55wYzDS7jVdo3Led9cjndzUg+FvoaBo2Swr83ItXHRbJaq37y2SOEjnM5BGqiOo7O3gYtla5W0
 /HWpzkhYuNFnU1XZL5af23Reskx6Pk6a2FJlljp4cPxYzrd1X+sJXwPwzzYa7npZlPfMzA0ocmc
 ywmjdYJaDu5LKAXGtZ4UzT3uBSaMYubedyhTtuSs8FlDuwtMf/NXck42KfaRdnx8uL4/3pPQ466
 5TtC4fuaIJZoEgNfn9zHBvzZQSfEtkRts+s8OTMpI+JiupbirSyu1ZX0N88z0xmGd1lNoXp2HNH
 szMnHeP+8pH/efWPyzv+e6ZvLBklg85WaL0IGieFIm7QZUTMcdm0YZ5U82KE=
X-Received: by 2002:a05:6a00:414e:b0:855:eb7b:5804 with SMTP id
 d2e1a72fcca58-85628988be4mr4641918b3a.4.1787868434896; 
 Thu, 27 Aug 2026 15:07:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:414e:b0:855:eb7b:5804 with SMTP id
 d2e1a72fcca58-85628988be4mr4641839b3a.4.1787868434462; 
 Thu, 27 Aug 2026 15:07:14 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 019/105] tests/tcg/meson.build: add wrapper record_replay
Date: Thu, 27 Aug 2026 22:05:13 +0000
Message-ID: <20260827220641.84885-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX8EnbOt6/oPeQ
 8PRrLnexA1YWodBrcPHr/S/gRaRpt+/8rOlTw2QMMNPdUaXo4a4AJwB5CWS4YIbU3MoBSF+Kwd+
 szA9hcYto93EZ1dx+sFe2C598MaNe2K7EuhT5ncdlK0GIzIun3jpFfKhNXDkmawKvXqtngoOK0G
 NyGBoH3IFMuxDQWWRlPO41DCB2folWl/bWH77BNLFusNoago1xdCor1DftPXYt18HokdWTqEC+9
 H+SX4+VxMKUI14YRtFRx9ThjdHgDZSziHmP9DJsO3SroDXQCq+FWoX5y9KBuHiMjWLAZ40F8oxf
 695E6Dj5MlWpDKhmoJxCXINY9IQyQZBOBus3dy28dKgRsgcwJQdjSqSNbO0GGS6oDP2HnkOobLu
 hoSk8Ntkj5qxW+5BqxBRJQ/5TjTfNCWAAI74TzHHNyX+n91JU9rDaykFID2cwlmzi5JqKO2zGNV
 DAESN23nhqlXuvcIgBg==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b513 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eEGzm6YI7CwNaHA9hdb_Su3m39L-iHXk
X-Proofpoint-ORIG-GUID: eEGzm6YI7CwNaHA9hdb_Su3m39L-iHXk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX9CSN3ukpzr9k
 Oe47XSkzKyHpOCQEnO+0ykVaVyp9ZV/AkDTkAg2SyJ+xzRvxcbHTe7fR2+kQSB4GmXgU6xNv/3u
 jgcZA01jSu8yG8BWDe91fe0YLXQXsMo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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


