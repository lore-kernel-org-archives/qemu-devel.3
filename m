Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BF1C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziRZ-0002qD-Qg; Thu, 27 Aug 2026 18:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRL-0002QM-Ku
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziRI-00077u-WC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:19 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLsMR653834
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gJk15R3owpZTSh2kXMfU0JoX2snQfHEBzK4pw87s/UM=; b=T9gUMc+R0m/p5jKK
 FPLzllPK8IkYZOS9fNfXjlHsurA0tMc/wUEMgOnZTTleY7vMkRyr3PsxlIODUlEA
 V5ShEa4Ej6N8q9Js4TTYwRF6z3Vr8yL3syRyQFKx7vqx0tKyewnWiLboOaxKkFko
 XPHM24A5Bz1WZ4dosdYmUVBWhSytHyRyFg7fcbyvLVTvD/2HkvaobQnS3+ivw6Ls
 64fX+8xlpRFm9EEJRekk8zHSt43IpdaPBcjy90ENDbna9u/cKiAuEDWl573pCbPg
 Ym5e2Y1FchTfGSLhbKniXVTakk2mKv21hCM8vnjwnmfZuIpQ71fht9YbBFwjkXQ0
 UFi4FA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuke9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-385d2703b64so1855342a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869155; x=1788473955; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gJk15R3owpZTSh2kXMfU0JoX2snQfHEBzK4pw87s/UM=;
 b=aBqZ5dTGDEISaaBy6+ulImCzJ1DoWzQSoOzhmnZRpiIxN2TUVGu0faOmgCQFcW4lcK
 rl2pgGU6VWVIIy8uHi0Md0rJ84HX8gDkKCmlLVVc1Sdk+mjxY23YtEqRTl2Pdc3BCa0L
 7WqnRv4PJlrMR+W7bHjb0AWnNkjWbectoO5sb07kizMXEGb8j0ybCjDIqAy8eSFchuAD
 sJ1SeBjYfj6lwlK8EiD41N9ffW3fFsOCXzUH53aCU8kP0VOmiZSLu1YvhGPEGrgl4R2Y
 M7tz0wKPzfwKbl5F1OFp62DmeCVYir5vjz/BSpDTdLnlH1cH1Au/eEx6sU1LTONMG8Q+
 R2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869155; x=1788473955;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gJk15R3owpZTSh2kXMfU0JoX2snQfHEBzK4pw87s/UM=;
 b=M3LBhmol858/4T5hB9icH42Gx7PvvJfMU+QQ9+6ahVgWv5zyIrbRGrk08i6KbU+I+y
 Qlw0UFru8zWaalQmlusqj2+MtGBb2Za+7OSr3wTxONN910M6ANGWhmcb8RPsAHhguGbr
 65Qe7sC45kjo2iHgcm6h3Mso0bN5J+/uBgUQRO2+IAx06ursjjAi6tikEQtLzHDgngAD
 Hi31aJL2XLA9aKd9mfn0LXIzZirMKOeR8VgvNYLS01ULT25iIhVFtD3nv0fMoEjW+W6i
 IVbpuj1hPLyAUhaMMkGCBGukgFhpa6WHxid3YKxaR7MLQH3gbT8+kFUWiSt4cLlklptv
 y1aQ==
X-Gm-Message-State: AFuF++lzceCOq0V43PBhaYtoYOoZIfsd83SAaSBu9TQgci/w05RNBKVA
 JbSPCc9Du0rfHvUv77HM9y4qfq/Vw7tBCmG76VmY55bIde2wF13Ki19EgCF/7DWGKifYDQtwhjO
 e4uZqGSmdZ1sbYp1CtMyTKrcFRrwymhsik7DquPgM8KiBxnpmF5/v77a5JnskMEa9Zw==
X-Gm-Gg: AR+sD11oEPhmal6MVhBbhFglC60BN9MkYYQkKllsryALrhtvyJQvQQrHCJ0lSE5CbkW
 OTfcVjD2CeQe8oB9NEF+l01iWmNJ3w/Wzea4RWnxI8Ut8THL6Bu4ABMzWPdwS9bUQ6tZ6FiNQUV
 OxCtFXY1opQ4Sq9CMos0qT69fusFuZsnPtfxPE0A9c9iclTKqIBkc2iP0mPDxV7K0OldoYLXucK
 N+SZN1TSTfBR4QVksp0iy9SWQvEQY8msXskscTaeLHVE14NwrMnK54qizwJpNUhkcLtDZ1z4mP5
 I0GNz3a2xoj4a4dRApCcJFMeBIO1QN0Z1NUQCNI6klv4eVQcmtiZ9bXtYxzpMoKXRkO0JmQqdyk
 H3ag28GkDAEzF+5zWtSUJckzJXpgVaYXKIEWnFWRhSsHvhr5/DKltqkc+j94=
X-Received: by 2002:a17:90b:1dce:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-396d0eba0c5mr2540447a91.5.1787869155029; 
 Thu, 27 Aug 2026 15:19:15 -0700 (PDT)
X-Received: by 2002:a17:90b:1dce:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-396d0eba0c5mr2540408a91.5.1787869154611; 
 Thu, 27 Aug 2026 15:19:14 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:14 -0700 (PDT)
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
Subject: [PATCH v8 049/105] tests/tcg/hexagon/overflow.c: add missing include
Date: Thu, 27 Aug 2026 22:14:10 +0000
Message-ID: <20260827221506.91574-50-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6hknHL6ROMUplE-CWeRByqLbjQHbZL2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXx74R/SYGjiNY
 nVpgBTNdPDseRzbof1uoXODvSvkistb9uauzgUtOgR5JBnYJOpzuUwunAEG8O0G57sXSS/etsoy
 3A2/jkFvpeaSYo33lhK68f601m86T7FuyyCzQjlWKetqwZQDQJDMeB7RNX1xFwzJqvrGji9y5J3
 g6bl3CO2tIDj/7OieTCQcpmYy762GbPVjVlludcho5YELZNF2fdw8oBpouiFgrG+HgVxn+utqkf
 J1NTTJth7+P7TPKDyIUTY0GfeImLQuqFTTRol9FPtD01Ov7lQ2ulJIpDX5JJXR0VEtMBpVbNaHF
 TQvPhwKmXwCilgFPMpjNdYGSDu8wD0YkNrUHdGPWGkzT6SgkQPQKaWRGwV9D4lWyVgTk0J72y/6
 WnObimlU0E2DbX5t9WSYjtiM78g7KDUA//cX7nju91SNp7Gc+hP+ehOXg2F+X0EDsSqXHnDGems
 5AeA0aoSPv7gCbgYCTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX+XRDI4z7Y/8o
 NgAhBpO4UwYXkL2de8C04YnhDDnqdereAupJTr9QwDk8CdUusfpdU0M5t7dhThGNnylu/o2+2U6
 uMJxiY8Jdry6TMsaaaj753x9Adc1Lko=
X-Proofpoint-GUID: 6hknHL6ROMUplE-CWeRByqLbjQHbZL2V
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b7e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
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
2.43.0


