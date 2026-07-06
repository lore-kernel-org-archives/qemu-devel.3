Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621F1C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxC-0006SZ-Nj; Mon, 06 Jul 2026 18:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx9-0006A2-Q1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrx7-0006nX-FW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDxXZ1478014
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=H5TJUrT/GIS
 YR3E4uwoZQ7NOeeNyRMEsDjogqE6h+AQ=; b=pckgCM7P0YPquAPdmLAW578UQW6
 iNrcXFKkX5F7PFzzZrKRETtEjjsVBkclAKSWYKYk04P1Qs5vgxNkAt0xmYWwQSek
 WyDS6RGqFyb3BpXuWZuy7niUnVwVEXAEL7m5y+0t4YOrm+ORk7kxbVgSEM30eQbx
 FjER9W5AdtTyDkZ2Xr7em/njkS4O8d8PeDzFyO5AdO5mJtt3bZkKcBVQJPbARwEz
 ADhfHRsjq7gWueZ25hBxlzGLifBuKzTjMzeQLFTVXzG1eAj/SwqY+WDNdDyDmVp1
 h1HA1ZRczID03Q++e9LCZjjo/pwdifqTY6sTLHP9KoNymTQUn0I+35ShOGA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbmek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9fe2607511so5204043a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377491; x=1783982291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H5TJUrT/GISYR3E4uwoZQ7NOeeNyRMEsDjogqE6h+AQ=;
 b=Gcnr+JyTEJFzpaeqqrvhTdP6h5CaPjX4G48bMkTeGnSHBsF7S0nEcGJLsqq9pc1uac
 6hzA7dPxKCX5qTm9/yj/hD9tCBrMCeogTthfbLtA7f88L1ymudMMCnWboIY560/b5fcF
 SRt7cJy3e6zgcKzEUZCVSrF+1i7eESnl/ijsxUkzBmqlbi2CfSsHaYCutgu0jnkL4bxo
 WnZKP4KxIyOWO7NRHTC+T5UdYnVcyfim7BdeZPriySP5e8GzJBtZ8ueedZE2sekcf3VA
 MZsdDP4AVRhQy5ANSyNKBCplsShLYekbshKbDq1KJoRNG/UEfVibM1LNikKXR+CrsN84
 Tbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377491; x=1783982291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H5TJUrT/GISYR3E4uwoZQ7NOeeNyRMEsDjogqE6h+AQ=;
 b=GL1mksQU9CqmmkNkUcyFaeJMTTLrvMfMjF1bdqeOZExzpiORo0aegBbkXx/W3qhYDU
 5sUkdpAvFqHqvGyhZIxCV2+hUY7aPnOu5Q1KQySS3P/nBXRBDMqQ1zEpBGjEObAbI/ma
 F9/krXElV6kOzJUrQfR3PmcFtavqHgo5MuO1pGHm4ZqRYVhhFoCBRoUdHrXsEUYa8gbB
 Ccg56MN9WogSEO/MoZ6Ik3teWh3f2cnWtwatocMWuBK02beXXHDHmKqh63pNZT3lbxdT
 UNv7B55UzQ7fDfxTFtYu0KOlVWQyt/r6UwnWwUN/r1UIXEesA31sbipLiYNYCI36X/6d
 L46Q==
X-Gm-Message-State: AOJu0YwoZImDv6Ye1emJqNYkSIU5tgBwS4KSwmEFJ2fN+YDqcaSEC+vz
 7mz+f4LxDddHvspJdSGoQnYVICnIpm38Wc7V6HIBRNCBceAJufJfyz7CTGgMpmF/nK25hC9qPl+
 6KhUV6zkmQw1Y1XQNmGKMPY3gqk8/WnqLXB2K5e/RCtrsWmR8R+cauV6uvqbenRnjZQ==
X-Gm-Gg: AfdE7ck0scJSuzcqU2ZcCG3iI1PeS8IYEVVNdpZr1FMvP8QUpUGeCdAzZGlkPjWJM+Y
 nuBq94c4kw057znAESKacutPYHJZrKG1bfvlsZltGeRATPnuYit7M7m4QM3Za0nZXGxiDsr6RjG
 EDiyBum29qq+SlTUGQqUO/Cvc8TPepWFZ5OlN1zaVdQFNJd6mS9b8SLQE0Sc6UzwL82uXj2x0Db
 iEpApv7DpEClxQ1I7RPgJBafg7I/r8YNFVkQdFgAdeAMqT95aT8V72Gitl4D67PKXuaWjnIrFYQ
 oJCshTBi1LSNDqCKyjxmy2tN1pZLWL1rBPQ6XeNNkSriPXWGXmxP+l2SEzVK+Plh9RFNL8MtZox
 hfSTbOrlzEfL0i0sLC5geZxXceJbxBeieAOaTogrLsdi4wJHV1qNXiyO7kj82AHm/jUoaEsdvPm
 EEcOjzCA==
X-Received: by 2002:a05:6a20:c79b:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3c08ed4916fmr3062775637.5.1783377491511; 
 Mon, 06 Jul 2026 15:38:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:c79b:b0:3bf:b182:94e with SMTP id
 adf61e73a8af0-3c08ed4916fmr3062748637.5.1783377491067; 
 Mon, 06 Jul 2026 15:38:11 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 43/91] tests/tcg/hexagon/overflow.c: add missing include
Date: Mon,  6 Jul 2026 15:32:55 -0700
Message-ID: <20260706223343.988769-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ut-aXc2gVrbQBgdUoY7Z-JPAYr4P2k99
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4brJq1GGo8Uz
 waVX2oZMwHIZqS5kPxE9ip4Ibd6gpmp+fGiZPj9QtdkJGWAOm6WgpIMK3Q+eWmjmph8eB0JagRZ
 VnREubKJ+Ak0gzq7T8aQ4CEDPmgivEdyvPiPyUvJXMtSEeQOnDRmEcWzPEctuq7Dsnx9okqoCse
 /TTs8BzpRbGZD9vSRicmjJuW4rNuqR65Nkm12Ny05zyQTvRE1utXGsvI0ZrDcsPHrv6o2d87rJh
 eqUvE7N4OZ3VHQ4j2oIuz8HKC9BQccQLILHD2IUJTpC4ePNLW+AaqC2QO8ZtXl5p6RjkM519z6b
 wUB5zonzXjpLg/z3gn/rQSnbZRqJfV5Z1k5v4PXyB4Tide054f1KGJu30Y9Y/vRFK6BIEi0m5j/
 bDbw7AfcrU9Z7Dsgd7LCwurfEIPNG0GHSVe9HwCyg8Hn6LTwGo8KK3mACciQLIZbqJ9ZJQ/KbQh
 OK/7NsGtLcjIOi/XhkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX+aieunWuK39z
 2IgwHOGqcLULXfRAUaC1QH0aT27xLr5mxlybYF2EQ2ZOhLrbTQ86yXkv9S1HfaK17uJfWNmxMI+
 9LrHmfQ+jwHgAS288p17BfrAJa6Z9Ck=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2e54 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=mDV3o1hIAAAA:8
 a=EUspDBNiAAAA:8 a=H5hdhDAz1JtlY5RMWY4A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Ut-aXc2gVrbQBgdUoY7Z-JPAYr4P2k99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

../tests/tcg/hexagon/overflow.c:59:1: error: unknown type name 'bool'

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/overflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/hexagon/overflow.c b/tests/tcg/hexagon/overflow.c
index 7b5b9ebdde6..9ac2d6eab62 100644
--- a/tests/tcg/hexagon/overflow.c
+++ b/tests/tcg/hexagon/overflow.c
@@ -15,6 +15,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <stdint.h>
-- 
2.47.3


