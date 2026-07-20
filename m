Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38035C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluEe-0001eP-DM; Mon, 20 Jul 2026 16:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEX-0001Yi-AE
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wluEV-00059g-ER
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:05:01 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTcPW3397310
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=/jkfrt5wdLV
 wCz8umHCidn+gDwOEOrWGibdjwx7HTlw=; b=Jnu+/Mkx1FWRQVeWa63ez6yGGzb
 Ln+zL4bkF3ClbcNNwFxY6XBmS2g9rEpNx0rTk1Ag/VOZOGWeW8o7tRoK/s4QpSXV
 js16IZ3Z/BMTEqWQ0UpBMXj2SZwGZBDLbYLGsHjw5SEYt2AquJYGTGv8n55VR3UL
 nrEyjMyhMElcwBNsBstvd4Xm0kYHA4Cd9LVCxmOXXBuuU1DkpcQ04w9av6C9Z1Od
 DX4jQNkgaLrb/yhmZZnbQ232q+Se6g5OeKwzLMCx+Sk8iqzfw+/6irfTL4KfX45q
 r+oVdHrlY39L/wDzJmIeZoYwrq5GpMktuJXdo3/oxxvUOh7lzzQNCcnAs+A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvc8q86-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:04:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb711c88f2eso1030536a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577897; x=1785182697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/jkfrt5wdLVwCz8umHCidn+gDwOEOrWGibdjwx7HTlw=;
 b=KqH7I6q7/iY5cS91aFEwVcvzoo2DkQSo95kHO0E2J1EXwo4DEXUW0ESueCoSN2sUZq
 OuAQn+qlkzUyG+YfNf1EtnJA5TnRUnOqyb8to9LLtvNJrcnXQigyW+guV2AgVr4QtWJG
 YBFIoG4DPX1TxxQ284BL2rgAF/Rm6btiTm+zHkxxCrCsN31JXVFOsIYL9KKtCGLd3ajS
 ceoER3UsxFGUauCyiluqKn3ilhdC0NH7pUH88sGZ/VQKwIVwiBxm3TQapq3uBotgkopI
 /O1jQq/s1JPvZHpXEAb2aj8LfdwNP1z1QQ0FdxosHEn3ErsKj9nBvbaeGmTm4kfymQlX
 iscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577897; x=1785182697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/jkfrt5wdLVwCz8umHCidn+gDwOEOrWGibdjwx7HTlw=;
 b=rHVSyDyUAoU70F7fKRKUPb05JZmd+xEXrQnkq9oH+F4N3XKm/rD06vLjHzNHaCWzAr
 0bj3nFPpo8UF+IgsTq5N6yhhcOdPr0LQxLqbvfZxDfpdFlV7ZP2Xn4IhNeB4Hi2xI3p7
 2H2pHtX7/Ju5XAPX71yi9JuRYCLgEvst0WEO6LakXYzTVrsdwuvbNjXJBKoayT6oxx7n
 wqF1KUkMKoVr23ljK+RPOnrxkeiFYn3NXWEBnbcGBof310VzZLDMkkA3d2Tppn55wsrJ
 kGrK8funGHIThC58TqU4JizwajjGd1kDgPh0yvwzzT16IuJev555mBx7GUUo75L3JQ1I
 zh5Q==
X-Gm-Message-State: AOJu0YzTjpsFTAu9ZIztHZangQkKamPti4BJJqa0xWINk3I+KCxBal+N
 RcixTZ/RvyfEmrnYl5hT3T/k7EJmc1u7WSy1o8Ul4YbqZnyiHYkn/segO1XunpTImslfUMVuQ66
 FxggVX2YRz9SyjVRQvhcI4zgTuT23n6X2Ll6vcIdXVrdAvilltpw2fT0hXnKUjmeq4Q==
X-Gm-Gg: AfdE7ckNDfSiyS+NxZaqzVrMj444tVv2SYoa78o5QA5mDHNk186dOq8BfpbZSGbMwae
 GAePU1L0hM5Iu8x1++fAMXJZuW6YZ/kc2vO1nxAaAZeq9J7xSaXYTXOxLrj3JotofJ+oX5em2f5
 ObEgLuZtS9WzjrMb0mjbgfptpL306JZaKT8NS+AI8wk0CaGhTIY2PYRnYVjeKASHnhQL1sDOPOv
 gMzvPtN1w1FZlOAJBKJ423WRxodhayg6HSDMli4uFm5HJkWPbHzzC6SjSsEMS6lJO/Q2n8Qkalb
 2LFeY31oHtnlX2rwFwI0CrbAxetscbfP6A4LNsWinj74XrLbNtRNkkhBMFDg7+yl6z14c7GRz45
 I+mII13UIPk1TuqEc0bQOthnr8z4QqCKhHQSAlxUOOOJrxTHuGtDH+E/oaDvTHxSf+wG9tZU=
X-Received: by 2002:a05:6a20:1eaf:b0:3c3:9557:3b47 with SMTP id
 adf61e73a8af0-3c3ad9e2f31mr14047529637.51.1784577897420; 
 Mon, 20 Jul 2026 13:04:57 -0700 (PDT)
X-Received: by 2002:a05:6a20:1eaf:b0:3c3:9557:3b47 with SMTP id
 adf61e73a8af0-3c3ad9e2f31mr14047504637.51.1784577896778; 
 Mon, 20 Jul 2026 13:04:56 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dd90fsm38487229eec.22.2026.07.20.13.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:04:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 2/3] tests/tcg: correct why the magic syscall number is safe
 here
Date: Mon, 20 Jul 2026 13:04:46 -0700
Message-ID: <20260720200447.2145622-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720200447.2145622-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX3cdhRExwz55Y
 2kffp/K7P9VYSunmZTwEzRq4ahAY9/xM4ixWEXr165RcbqUys+so+1skdaMb06JRU+FCbDf0ZiU
 7BkhmF9yUWF7SOSk4WQGc37ZBexbDBA=
X-Proofpoint-GUID: AK7DK-YPNvSHG0rhTXWojxM0-S1dUllR
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5e7f6a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=5mCGn3sackZv1r44w-oA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-ORIG-GUID: AK7DK-YPNvSHG0rhTXWojxM0-S1dUllR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOSBTYWx0ZWRfX5uQ7Sshl1i3r
 aE4QweP4c20rFbOfmuvA1peZzNI+C/4ZijS0VdxRlkryZAWjNcypU0MQgEzQUUVg8XX9yoouWoz
 k0noNsaookcFTtT7cPT56umqwTqbsAP+DLjpg+GP7wpqkrV3pH4JvY+ZpCnjb4xtK8yMMUpW13F
 Btjs8MWSEhUtBiWsjw5f+IjGNX0OP5rvGGWFyUnUzZRTbuHFteSqOeI6Q3/HtwM9nCB1x+5YtSt
 MyFbXzEmqiwTbjDDLn6FR5PyNgG2isfJ/GPmD+3t2qt+S8Y88TDqT6swCaN1IVZrww9CEMF0p6l
 Sj+WNo7E25lKLfbus4UH3SvvTPIguKZ2KE60iqjty4NJXBNUt3oe9mFGxGoYp6f93b4fP/OVqq5
 73Sl7PeTqolQu+9M17QbT183HFNKkk4v03PLEw6vsNEsvrjqW947hCdjeLYW3gwozewtdDfU6xd
 wruxGvK6eKrO5K+bj/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200219
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

From: Ziyang Zhang <functioner@sjtu.edu.cn>

The comment said 4096 was picked because no ISA in Linux uses it. The same
comment already notes that mips 32 bits numbers from 4000, which makes 4096 its
getpriority.

What actually keeps this test safe is the filter, which matches on the first
argument as well, so a real syscall carrying this number is left alone. Say
that instead.

Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260719074730.1520517-3-functioner@sjtu.edu.cn
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/test-plugin-syscall-filter.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/multiarch/test-plugin-syscall-filter.c b/tests/tcg/multiarch/test-plugin-syscall-filter.c
index 951e338a7c9..089fb2a1107 100644
--- a/tests/tcg/multiarch/test-plugin-syscall-filter.c
+++ b/tests/tcg/multiarch/test-plugin-syscall-filter.c
@@ -23,9 +23,12 @@ int main(int argc, char *argv[])
      * "linux-user/arm/cpu_loop.c:cpu_loop".
      * As well, some arch expect a minimum, like 4000 for mips 32 bits.
      *
-     * Therefore, we pick 4096 because, as of now, no ISA in Linux uses this
-     * number. This is just a test case; replace this number as needed in the
-     * future.
+     * Therefore, we pick 4096, which sits between those bounds. It is not
+     * unused everywhere though: mips 32 bits numbers from 4000, so 4096 is its
+     * getpriority. This test is unaffected because the filter also requires
+     * the first argument to be 0x66CCFF, so a real syscall carrying this
+     * number falls through untouched. This is just a test case, so replace
+     * this number as needed in the future.
      *
      * The corresponding syscall filter is implemented in
      * "tests/tcg/plugins/syscall.c".
-- 
2.47.3


