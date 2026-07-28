Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAF0C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZlf-0006eP-3C; Tue, 28 Jul 2026 00:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk8-0002no-LU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZk5-00029d-Mi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:48:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aj6O2692939
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=; b=G/dXEHcHbMOBgqQF
 ZT3PHOKXeyLD6RLfT3LHk5HlV5WU3jqBydwj/Gj1yfb3m+7NnJAo2ZMfk8cpMLwb
 pK7VUYCqPVniyBIc0wNOlMDJ/uzMfe7fSxck/doljA7Y2RKkfVCixLSxcWB9alA2
 vuUiYzojS0aiuQ0hgPSZAxiiFF/ySJyZsQx659q0hz7CeV6/8d1rr5tZ+wTj++ys
 qdrRSOc+U53Sp49P7d7IEaluvRM+UiyB1DqBpKlb7VYsyJPxzNA3gFMIxaeWvMR7
 Rw+OwnL9c7zK9sv+SYMvdNNptm8JBlj/HAL2IhjfuH4GHOOGGwaoIYumAo89JsU0
 MwAYBQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jf3g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:48:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb687f82eso49951015ad.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214105; x=1785818905; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=TL+dgoaX/Z7ZhneOyT6l+17zYc84X7unBnSyMC3GOxt5XsDZw2Xr2Ds8jUEq08cM+1
 k1rNsrPXKzYVTfNnk+0SNOpTzItMmQ0s3jw6ai0doby6T6attz1xudWooQzIVhjpV5Ye
 a1gxTSS3IwCzfDTtLX8bvELH+OOEnHtLdcVuWO/kYMBnZ5aOyu8GJEXNNTAOWWmv3dOm
 drQ9ZB4AOWJ6cv+J8e/5ap8XFIZ4fwmWJl6PB+u+HROUy3LXS2RV87/8Kh6b+1AspqNT
 Dfi0PHm0qYRgRVmzMLiZ72ymHTO7KyXxIsi0cCDnJzP+A7afwq3eSuiBBxAWy9mjMgYo
 7juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214105; x=1785818905;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/8ap9T0s7XEWDdZ5TAWh8KIwZJAZDX5hIl8EXyikv0=;
 b=XxpbHiDyBZU5HGiPkbbpK3Gp4L1DTubW+xREOk+BksjwaCIcxuYdLpPp6CJv50IH4A
 tQkLYtHgG5TebLlwQ8HBMmfoGiakKan4Vr+s5WOaZeYmGzFuNJmGqQdAxQKmPr8G7oLB
 GtbRgEV0yEaILhKkHNjcl8QeN+rNAxSj95piO6NViUO/oD+h9y4QdyefOdhTDXgDKabk
 ZBSLJ9FknXlihoFeOUBdQsPjPDbh91ssN86NEixujvatIKxwXrWHFCnq79A1YlDEPK9m
 n7y8I7A0czgSBDPnWIBc/mC9n/w3MOVHDK3LVMILOKoIkFb6/3An56bhgd5/QrFYzNPF
 tXcg==
X-Gm-Message-State: AOJu0YyVEKlrG99oTBCd5FouKJ1MpCwKhclFHO5SH9IUIieixdmr0igH
 5smKweHKiT8IburPmZiRnAiT23ORUIJ9OiVEC8qAzhybsA7Jy+Xt94tEpLltXOxYhuiYP4gp6Xf
 htGo547DwpCZr6t9FwggY1pBjdtEiKfYIg1+MeUcGXu01/Go+pZIkUMrOYszmXu63EA==
X-Gm-Gg: AR+sD127SqsGY1YQkoeEQxOuY7IdQMLY+LLspA+sRMLI8kXR8/fDfrg8+kqtrQg0/6b
 PlKV2BKdgQy4bBniJH8d/C015DwDaOY0px71+IfrZL1GkjqkOQ4S5jx662j5DZc0pH0/X1ekwcP
 mvN/pgFk8jIA2a/7K5/CuFgzhkVzfS5GpxcIqK+89X2Czb+Crre12drFz087mqNIbJ4d7u5vWfb
 fo0b2NxRraZ+lu/PPK/nNkB2j3NBS5Hl0d7ejnZmXvXaNcZku7XvG2AjTv3ClWrVdlCWNRrA5E8
 941DW2XCJCpxEtb8h4pFbwEgoBJHAOU2agz0EEkC1hEYTJTEZf339UnUgi9aBd6qX+5c8hlE+6l
 Q/6ZD7H/pcuOvBx69DRJvO567S2v+xzEAS5fkjnHmcfg1glFzdAArmLpESPAXHnZrhbkH3Fo=
X-Received: by 2002:a05:6a21:328b:b0:3c3:c71d:9030 with SMTP id
 adf61e73a8af0-3c8ba62ad8bmr1222754637.65.1785214105278; 
 Mon, 27 Jul 2026 21:48:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:328b:b0:3c3:c71d:9030 with SMTP id
 adf61e73a8af0-3c8ba62ad8bmr1222728637.65.1785214104889; 
 Mon, 27 Jul 2026 21:48:24 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:48:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 069/103] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Mon, 27 Jul 2026 21:42:13 -0700
Message-ID: <20260728044248.137626-70-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX0uTqkZayEwpS
 lxuTqLF8Fqni6AfbOEchHALpce9KSjXsDMpAytBU7mi8GXShuAgfk05LQtTH6pgYWFD2cx0Au1Q
 /8CWD/OnQdHarH0S9UvqJS4Hxs8EZdw=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a683499 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Fbn9wURAhCV4_gqr_ywA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX1kbbMsLyxuem
 bIt37gWuYN0dotHfEOoDapavXLYqfoQtJMxobPkLx74V6qOQmW6iUsUopJ8YlKKumybVrcZdHXv
 5r/CTdvOfAD49KJ61ReDgbYSAegwUjM0gKNJQr+M0WPDBmbfglVIbUHq/dZyzUarLCYW99VwXGB
 S/r8XlXliwXEAR9j9aMiry/FlG9nvvWtDpzIeSC2KDcuR6ozLg+82OBW0+0YFqS3NYTF7T1H3Lp
 Z1TZ7n72DRGZyq5mLkmz92SlEqj7eIMT6Zop+ok72aKWg3TC2iR/LTw85EtIxiWmUOVY5bg8C+O
 p/HbNdElB/VixOnXFUiX60YwW3Y4IGEiqE54kN8v9YWY9MhInIiHmPOsAjbjspDER+0AAEwilLh
 wFl1RVgr4YL9iFk32VHF0+02LlwbTdBL4pACMMXaN5erDDRFkfwgS4/++BxLb1GAzyaHJPGH1Xc
 1D5dRNrDA4h1gQS8Q5g==
X-Proofpoint-ORIG-GUID: 8wgLJ7QXOa2EqT6l7nk7pM5E6NTjw8vK
X-Proofpoint-GUID: 8wgLJ7QXOa2EqT6l7nk7pM5E6NTjw8vK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.47.3


