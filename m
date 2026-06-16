Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF21CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYlD-0005bB-3d; Tue, 16 Jun 2026 14:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkq-0004ru-IV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYko-0000V6-0p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:19 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOcbg382311
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UIQg4+/jWnC
 uz+7fw91XflPBlK2moTKwrhihIzUNTG8=; b=e0EUx3Th9F2DCSjO9bOHL/d7Zt5
 LIb/BUShFggkkMNIuk1qa8wH9iNEJW0kiiN4tlWfD+/VJDT6RJbaTqK3lyXFS3Cl
 zAPYLlPosT8LyweYW62rzkO2/nUEq2d73T9Gjr/PAV39nS2dPI9mTv6pBlJRJyWL
 h/u1qsyH8tf1CS7wpOFq/douQTZaFxTmlbuskD1Bi7oAqg1G1CNrkao/8+QOCzyX
 kWtt+OC/n0ceA1GjkimASVToOs8hBHUfHRgROoJCNoWzKD5TrKBI3Jif5tahgWQk
 9T1YCDrT9oTy3Pm0Gaf9TH1uFju92xLv09+ylGTb9xXZcVd03XoMUdGVuYw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu4dkjfna-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84238e83851so3200452b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635385; x=1782240185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIQg4+/jWnCuz+7fw91XflPBlK2moTKwrhihIzUNTG8=;
 b=Vv/xjEWTv0oD6RZoYYzQqr7l0sJ3R6LYdONdSR4pEPwDlmleGGt3UOAOzHIPNU9dYe
 wzDpnLs4db4zSYgSS+BQHCPRYR+HCD2Ln0p7tZa9tdcNlFSusNkTDIpGliPYj7uPhIOB
 EVuz0C44lMKerah0nB0xfBDFW8v0xO9DTs5tlaZ3uKjKPSkGE1uMUJIfo5SJpRu9yShE
 01m7pB5SfSlckSGpb/vK33s8bEJn6yIyOvKoCCF/KnnwIGIRFuJBrZdfQSaOENn0RrXA
 bvFMk2rH02DT0uVjOZTqzVT4DDicLYn4ZWi/5mmOndlGuOztIGPv5lhsVGyzuNG9CyKw
 Acfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635385; x=1782240185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UIQg4+/jWnCuz+7fw91XflPBlK2moTKwrhihIzUNTG8=;
 b=Qnxuz6F3qzuLBeKNsP27YsPC36WkQCjreQnoUaCvIR11VW69QOKulnGLZIhOEddOwA
 tjUWAckO6wDiku3FkCCwf8rly9Qi9Ng3Ny1+kp8Jon+4E8hc7mjz0F3wrnRRF2WacFOx
 9Kdsqt/rnwbmyxUHoUrlhuN2J0relvFwJz5Zm+KFD85L3Q3BvtvsGaL3GTJ7T2ZXKVzV
 d8sOLcQHi9n7/Vr2DA/560xLvpE5wWdch2tMxAyuU3yXmKHTqWFzRTcW8baKt0sHqHJ0
 oDE/XhN+JnXhqbGkkdSwARdNv2T9nM/rPOoxUtNTpFzc1XMpH/K5X0o7wO0IDUjw/gPn
 Q0iA==
X-Gm-Message-State: AOJu0YzB88OBltZ3gKn3jcp+c2OSmmQqENjjKy7iPvYjq1UDrfNpEL3Q
 omQ+6j35WPT4o5Eyk8Mlr1sG6hhjkwuaiS9SN+vzEk7PtXmfA5SvfJAVY7AjCgC8Zj6O1osD1dK
 fpZu3Re0MxBMJBFAsMVRiE1nKZEXonFCcbyk8PPhlvBOj/0ejQmwNl5HhNMI4citGw86k
X-Gm-Gg: Acq92OGPWnBIU7DYZUsCC/hQoTIQ5t9OhYnXBsHjpSHM6HJoDofrN1rwFUBnOaw6NxY
 RXH29MJ22gOYvXezQYCm++VfxO6LaGdYcRPFYuzkQaI8LlwODWbhHeWUEsI4ZlRChvzcmJrjRpt
 BllaHZYUjweslGZSR0ZIU74EN9hC7gsaTgZS/ppeSxyqVStqc/d4c+Uecqh5QveWiv4VZw5EQi7
 yRKVgZPaEN0MKf18MpPgvxQKJFH7l4eUULD5FyQYZ1lleBsg3GYp82Q1Kc6BlKeh4QIW1grURZS
 wVRpAwDUW18tx+gOSS/X3p+FIppftsGUHmgyKx6fzrJYSSxG6s3xp1OUcSqO1OttTmE9e2obZPx
 dUqhugsld/u8/Z0VZd5QfAHbKEHW8UbO7WYpEz2HOEetmTtisf8tQSdFUsIUQWxzZFFC2m3IRAT
 +YqRsS4uM=
X-Received: by 2002:a05:6a00:10d2:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-845245ab745mr307936b3a.39.1781635385026; 
 Tue, 16 Jun 2026 11:43:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:10d2:b0:837:f79d:909 with SMTP id
 d2e1a72fcca58-845245ab745mr307916b3a.39.1781635384645; 
 Tue, 16 Jun 2026 11:43:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 24/26] scripts/checkpatch: ignore spaces required around some
 operators in C++
Date: Tue, 16 Jun 2026 11:42:28 -0700
Message-ID: <20260616184230.303038-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2C5OUf3fuw8c4zhE8eLj5yL4wvLTjvIV
X-Proofpoint-ORIG-GUID: 2C5OUf3fuw8c4zhE8eLj5yL4wvLTjvIV
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a319939 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=nUVG7euvARLiU1CHTZIA:9
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX/vg7a1zMjunI
 o3pB0ux9hFyFyXyPHAFG+Ds1J4kjoDaUy7tNxyhqoNvqzHVmJTbQBncD6dAMgctntz34eQGmf5E
 mZOkWt93cgrz038zj6zrb0JzOg4+rq6NY8SzNPLrlfsakKXu1MSN9cMG/jJHrOXEpqqPkxSkc7N
 yl0mjpxQ1iFhwx1JpoirTdJtmss0f8uRe0jY57eEsxCR7o+1r9gar0mIvbcJUlaQ/6QXYBd7WUs
 +79JwaVj+FlVjNUmDjLUs1jdaZa/GLcD2mHusi1WrLsoXDQJyz/62ZaWVcZ1TFNB6wVNoHYtK0h
 JpQUIAMCLK6oTZpePytNlK5DJR9EaLpcNWnuABEJdB+7wpDBESehOdndaJi/GqxpASSlmSydcVa
 mF/+Y2MfBhcI9UjC3fKBPVulGAGe4igRUYtJbHrSBqT11lQ4gf8mdABEoEIIzUJXlOc4dWownYt
 sLrUDUQxIhd1x5nKpIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX88/hZmcAutS6
 5Oco8cBJ8GHrTTizjvyH/poqPMB6DL3c1nmdaB4ObH4Iv7FoHDn4wHaNYEsKLGgwsPBhZY+cy8u
 iy4BNZfxQiitPFWnk5m+35YrS4Vpqvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160191
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

C++ has a different style when it comes to space around references,
dereferences, so don't report it.
Also, closing templates with >> gets wrongly confused with >> operator,
so just relax this check.

Some examples:
ERROR: spaces required around that '&' (ctx:WxV)
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                      ^

ERROR: spaces required around that '*' (ctx:VxO)
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                                                         ^

ERROR: spaces required around that '>>' (ctx:VxW)
+        std::vector<std::pair<Vaddr, uint64_t>> v;                                              ^

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-25-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2189db19f54..538e059e265 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2621,6 +2621,31 @@ sub process {
 						if ($op eq '::') {
 							$ok = 1;
 						}
+
+						# Ignore * in C++: templates and
+						# pointer types are incorrectly
+						# flagged. Example:
+						# static_cast<T*>
+						if ($op eq '*') {
+							$ok = 1;
+						}
+
+						# Ignore & in C++: & means a
+						# reference, and this create
+						# issues with some constructions.
+						# Example:
+						# auto &[first, second] = pair;
+						if ($op eq '&') {
+							$ok = 1;
+						}
+
+						# Ignore >> in C++
+						# checkpatch is confused by
+						# >> closing templates. Example:
+						# vector<pair<A, B>>
+						if ($op eq '>>') {
+							$ok = 1;
+						}
 					}
 
 					# Ignore email addresses <foo@bar>
-- 
2.47.3


