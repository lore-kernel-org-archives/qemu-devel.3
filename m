Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47305C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNV-0004ti-Er; Thu, 27 Aug 2026 18:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNQ-0004rq-0q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNN-0005yU-Vh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMcAp850290
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=; b=orwLkvlpRB6UmvHA
 ZmNkMjhKe40dmPsQic1rjvecBCHPxgzgJVgbpw8veD6yS2k+z+nR+fzeO2ZKaA8f
 gi0INZgbsTHMBEEEtHCYhP/U1sl6l3IO1mmG7wA5OoCLhuIlmDjdk0mlM1rtLKzD
 4gXGcREcXZLTtF2AHX+qrGCpu/gpm6qngVboYbu9kbZktRwd6Eg4cjXeCe0T/we8
 aDrpDWHk3HfH6IrFP5OMae+TW+iy97x+PvFaAvTOsAqc3J4n7cPvdJYV4VhqQORl
 vPOWUxkoCg/XgAlWryWCUn6Ew/f3mhaIOcEbKaIP9FvaqcPntwjRM3axM/p9vNB9
 XKyFbQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr6a71y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8485d853b08so628747b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868912; x=1788473712; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=X0G/rILADhySGhxLsSsDgUBnlq9FEtDUtJG67MMq52xCsevsbdiarwNW+sCKU13qm+
 RroVQ7TTM9vhSjr5/v0Bmynxgwq0GcSprcAYrkoAcOogkn5bN9Wxvz+UqIPT86f0RTMR
 NgPFgmeIDAaGI/LS8NHvmh8LxTysl5JYYVJuZW3KJH4t4zSjdHyx04djO2nAiJXsJG9j
 6gAMHt8MS4dAW9oZQKTBlMMoXmQir2Q4Ow4G3UYTXfvBNlgzq/4NMcEDnoGnJvynPQU4
 gKTlDrxFcbHliUcVP3cxEzMeQt9F2+IQLWiEiBeoUgLwp+Nk2AmclFphDF511ZfhfgiM
 kUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868912; x=1788473712;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=ezhUxPSb1FRqiGYGVDgsWnUJflu5ukPIgiATj8UySO0gCToS0DztcwLf8ZQVDKBWN1
 J3P0B6y2CmvmqP1eM+HX06BtlG8IHh1ndEX6bOwvWdZ37m7+0ySt4/E9uOxz/jB7vo6W
 YIHnzzjhJnLA2o0u7TQt+5G7Tk/OoOPC0pUYFc0TcwDm54hFYMMsIKVKuQBaJSfeRIUW
 eRNamrBX29S4kTYnhpCLKyaEWCtc6fdkeEvry8XUbsHjJqEgxiIKup0YLzPl6E6lxHcK
 8Bs+t22a9OZaOxFpt81bYV/O9wskntwWTck53ZOwJMYLZ/F9qSgjAOCBOY8OA9O9m7Lp
 vytQ==
X-Gm-Message-State: AFuF++km2w+qdv/c/yf1DQ1lS0r9oI3hxDUtqRv0rDw3yt+RpMyRDpdD
 bm0wS08D2ob5ARqvyP6a2IPxTVgeGjaJ3sEVRrWtK1iLaKdOBRJo4d61heUcitGqO0sQN+4w3kX
 bpKIDkeezHB1Q+YL4MCnyncaZCZW0DsoJvG4SWLV+BjMYwphV7YYmLhL0vMd7wH35vQ==
X-Gm-Gg: AR+sD10sd1XaApTmlvVnsxLpc/Wl0ILlMSRlY8ENovH8lgAu0KDh0etb6mq0A05RKms
 JLmwC1m0sNlDhmlG7l+nSqM+Pi2ABl4AlecK60nQu3Xn/E/ER6ExxdL7ymGKaDRJ3hS/d9/Zc1l
 jE+tXWWHTPz1RTM+/0KXeq6eWftg4MY5CfADGjx1oNNChwzFf9Jh1B3RgsD6rttclNgZMFFMZ+s
 V+N6CNfeQ7PvQruGBEGE+SNPz0OlSA+WuNzGn7MosJFyiyNUzcZb79LDlmTcNs0wJ5yEYQ7pGI6
 4NVvw8Cbbcr9/u9KOF14mBENNCnIn/gPjDCOtoomt87s3GOP/KUu2rdX2kYoscvQ5Kd/kTNxzfd
 5O/tB8ryTcST5y6HAjfaIteKlpbszc+IKBYuCH+CqjtvblighmJB9DjKMvRc=
X-Received: by 2002:a05:6a00:1daa:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-85627dc169bmr4571152b3a.4.1787868911953; 
 Thu, 27 Aug 2026 15:15:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:1daa:b0:848:3f07:c5a2 with SMTP id
 d2e1a72fcca58-85627dc169bmr4571060b3a.4.1787868911479; 
 Thu, 27 Aug 2026 15:15:11 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 003/105] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Thu, 27 Aug 2026 22:13:24 +0000
Message-ID: <20260827221506.91574-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX3/F1QPHxIel9
 WKozn4lyGUMUUjMw83ctYPUTRjg7sChBOdYZpIm0z8ryZYHL2ABn7cscr4W2c4yTRwHnQ/4MGLC
 LlIFd5pduO9ZWltS/Oh7ZHno0U6B1pVbPa7AY2JmCbrZ6KzkaetrHJ7Dd18hHw1NnWlaWL1lab2
 7qc5twQ/Cg4f5v2aAsjZkDtp4ixJzh8xq+Xs2hxb/bIruLKezBgW3GKGjpYgS49Cdnqw1oB7xoA
 Q8ODyfnZWtP0oKtSqhpsdMn/VH9Ct6LjYhP52uAKogRB7x2T06C2QENGwQg4FGc4XSBnekeDrrq
 Bc06QKMKtKkwcUb+u0KHCa5pZWr0d5uR6L+vGTWB4UJrV0BzF6JlHg78LpU3XKH8V+f67G+AqOA
 imhs555uFN164rcmhfecGK8G95ChffEQJcFwAqczFygOrxUxwdbGF6OaZDXNSTeuogI8INlxpg6
 1eRFru3NfVnXEUlFbpw==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a90b6f0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: m83NlHPXNj0g65Fp8hPScnyWVoXbqnst
X-Proofpoint-ORIG-GUID: m83NlHPXNj0g65Fp8hPScnyWVoXbqnst
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXxerSKyVitW9E
 e0RLFFBrhv//JVBi2mt314UvraMdf5aLP/korx8yYrLUYJv/KXerSLzVhjoHmiVKQpZSd7DiLYW
 e6XHQwcZjLFuDSAZu4omCWW04eB4UYE=
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

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 9bcbbb11286..35050acedc9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,7 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.43.0


