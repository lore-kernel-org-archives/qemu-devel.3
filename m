Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E6C61DD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNV-0004u9-T1; Thu, 27 Aug 2026 18:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNT-0004t1-Cv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNR-000600-QQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLwDs1117704
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=; b=T6PyXsNnkXZVXiYG
 dqy8IPIU9uNpAFnt1nthelCNRUa95ZbmWZ2i50rY24fHBtUvWv4caOOzuWNUNCUQ
 gAYUb+pjZ8R5j7hQzhvORcHWXgpCU7G+EOCJ+JAVeRPK4NaYazqkp4TaVpMhZBJR
 zlk+WXqftctsSG8+8uAojVpFXcv9XBf+Pjqi3Sa7QZD4VpRxV23wXfNKu0l3xrC8
 sg9kQLSGcGmjneAW9Vv/GdxL26hussJL3yygie13oLto7gxKNEXIQQc2wVPiz3zK
 5Vh9vmsAMoJdm5O5do0yeFkAP7fCrweWagb+hJMWTjvlSc0tnKHjIIc2qTc8/Ie2
 kK4FqQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hfe6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbee6bb8408so213797a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868916; x=1788473716; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=JHMDLusKws3nA1qSjtBUfG6gZKIoTnuqpAKbXiQC1jfQDvERmVUQ0I7m73yGPlYEl5
 F0s/8R/GgVCUOUCnbdS0A+jdM5lvMqc/1x0AwsHKkXRe8wPDXoGocyroDOYbs+a+iHv6
 r0kuPjfXzzIHyRO/fF9MbrZEYoT5paBJclCZ/zb4QmjLWtSHv8+W1uCutl81N+wwaluB
 AKr00m/LSwZ4j0mq1/RcNpyptSuZxWYGwQi91JRhdU8EpNz7jSB4E2RII6LMUtM1ja6r
 tU/iD+ujvkUl2eWEtGzDHbyFNzZsa8EQIIrTXc13sX+d8tgQhz2lxE4kXLQix6V+lhWx
 4iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868916; x=1788473716;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0uunQu9i2/Nhoz5dizdIxNmqCMS//LjLpyCjNL+1bs=;
 b=B/fgJgpBfaJlf0lsgRrwLSPUpNBu0eQRIJIsR+qHJlB3/B9qVAzCwW2Gt7CDIpRv05
 TvQcInozGHUcGV+LLPB8U+3IX45yssdOLKS/sfCUU10Bxogt5TkmFOVvxQOzg6fgw0wF
 ORw2qzupTbcgIFnkIywAuQ199SkLKb6fZbeUjRfFhzO99z8gsFPOT2pJ1LKCtUpOlgGa
 G6PDf8XfKplplH/atSk7jGdlS3ZE/tbdNsaUrEpITw/Dhq4WD4OGi/cEiBfXfUrrYhOt
 BEegIM6RRz19BHlirhuFUbAL6YlgfDacErtgAFXOSv/P/5oOfVtZDn2/z+poyUCicV+A
 a1cg==
X-Gm-Message-State: AFuF++m1G9m+TxkrhdJilAVhR37cdZRSa/P/OTgkW7f/iZ0klSAt85Bx
 WIUDt3S8Ylo8WyKJ9w6YOJvGcryaNgqAr6VPLGfTmMkGHlRZbsGZgNl+OyxZV0XWMCwOEs4F4Fe
 zOuJ2noFlXOgppmC7uCM3YtpzLQs68HjcpAMkBdzHN262nPAj2IAFQvuclxKglFoYkw==
X-Gm-Gg: AR+sD11QImT5xBCOieekothHaseCJuZ4VW7HzPAOp+yn8xyJoQ3NUsQSyjb47FOMNFM
 hFWNgjhnaRzvNR81pzl2fGyu9sMeQD+VL+z4pMgNY4ccAXIxc3spFRVCxqu5agmEuTG9aDTfxoN
 tY7aSb9Ka/ZKWFdJ8njdAr8iYNdbgmUU6SxZNYFjyuay/lKCpFbyUI90d291Jh4nPO3dnWjFs7C
 d5TQEK7hAkGYJGsrY50r2EPu5aO1YkcDbmLQPeOYUMo72md1KGpGyV1NzycL09iPMCNYJxdZNdm
 OLVioxC0iYVkdQov4JKA+vWqaXuNeMduyzTsy0fG7J9s6tCnLBpji5YigGqe4Kpi0j7Y2sA3jMS
 MrNSey0B9iUgz2jcImf6IbknYbe3bRcnJoM4w85VLFesqKHnfT4WnyCQwHS0=
X-Received: by 2002:aa7:8892:0:b0:84f:a170:4f5b with SMTP id
 d2e1a72fcca58-85629543c31mr3886731b3a.8.1787868915766; 
 Thu, 27 Aug 2026 15:15:15 -0700 (PDT)
X-Received: by 2002:aa7:8892:0:b0:84f:a170:4f5b with SMTP id
 d2e1a72fcca58-85629543c31mr3886655b3a.8.1787868915322; 
 Thu, 27 Aug 2026 15:15:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:14 -0700 (PDT)
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
Subject: [PATCH v8 006/105] tests/tcg/meson.build: introduce exe_name
Date: Thu, 27 Aug 2026 22:13:27 +0000
Message-ID: <20260827221506.91574-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX+gqFET3IF3Fl
 LzbtMUWJNMzLspGAJ73HSXLDemSNqyJRTeyOsgPjYbOpEsiZCawTjhJj4v1ML/JYBahDdJvDNWe
 X7EZxkhcF09JTIkb1246YrS6xiz1wjpl6rBT5TKM5U89Hbhy+bEy+ZCfUF5TQ2/bHnUnGVe9aRf
 +H90xMbslJUPxAt5pp6GucprHc7advpKUKm76xVdR9IpHcEyH4E3RAPjcqKembrNaaIU2LcTz/K
 bvqo41JcpxQ0JCHA77tjq30QoKJXLz0d5Me0PSUL1FaTIoDZvFXaSsnpIpMwqMme8UXACRZXlCh
 wQtbLEBjcCjQkv0zz7fJOQlPWYBhcqC6e23lvXUdO+oQf8ka6K4SAlqrHWg3OZTA/vxglCpcMAG
 FFbv2l1PX/S/jxSKjw4jPTpB4mH9x16+iDPiPll6dEV3cXNNkDvpHXzwmpPW7C8BrbdFDcBlEaO
 rWCQcSTCU+UwcZlOL7g==
X-Proofpoint-GUID: ScQ_kNz2LjHYXlfIkmmTF_nhdJvbPsTw
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b6f4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ScQ_kNz2LjHYXlfIkmmTF_nhdJvbPsTw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6Mp8xbRERSL8
 TFtzn7NoM/1wdb4sJo4D8zT7VR8aIuItD+zfRdN7YVQRVVk/KrXPaJ6tDp8aOoc3HkZ8Yc1q1t8
 EyIOUR6MgHL2y+aoFjr4fQgX2xdyeqQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.43.0


