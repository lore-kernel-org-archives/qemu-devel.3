Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8435606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mssS9iIw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YXbxsClg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0iq-0000dG-Lm; Thu, 22 Oct 2026 17:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0io-0000YH-Um
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0im-0007c4-Rm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:53:14 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIIFmj1512548
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tpjk1+Qe9swmsdgQES3dhfKMOj1ues0IZ8zIbpawXfQ=; b=mssS9iIw64d7xOVC
 I4mKqDHQ/h+X5nwKkocfJyGd1nvmr/tjj32LWWETD0/8TNpTNPj6uJWOpFoCZ+QB
 I2XtgnEWHp28bx8bK94ZdQU0r9qtfj0r5/vxb7ltRpdNpCgby1z3NhugLjAxziuL
 NTKyFWFgudgzQaR1n0dxBFeM/aWQo9ICErqcPlLGgreewO7eOlEN08tUwRT38zmZ
 zKRzrrf5h1VOrUdOItbw+Q9pb7tQ/qNBq9E76BL5TFzLKYzFcItlgifrKufDOBij
 oDQeu7RsH/JXbBqvm0RcLtfWmxfLEvc9GyGPC82NqkWGgCaIzC+VcbD1nDbp9LyR
 DiznqA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmp8qjh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:53:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so48274985a.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705990; x=1793310790; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tpjk1+Qe9swmsdgQES3dhfKMOj1ues0IZ8zIbpawXfQ=;
 b=YXbxsClgr6aFI81Lk+IAcf1/MvK+rwWothy4haU7pfkL3YoCQpIi+CGqNv7OggGpSC
 qzRsB6AjeHThHiSRbYRkX2yjDYt1QDdCB1YsJ5zzg/ZVvWXTycPh+2KoCOiK9l6I5gy4
 vK5jVgeY/MtNIQkpcEW+lUibSxSmvkgMPUpc6/IYxXrruu5mD2JmPUiwrG9z+C/b0y21
 LEs5HTxOn6AN/7DcQ5syMFmd8kqCgB2TERNcM2vZUN+R2jdkoWQOz52lbAeUeh/mxiPo
 3/zyuqF4kL1u0LuyrVBJLaWlqsjADr2ZX0B+NRUDndHXXP4XGCRPwrK1ivyX2VDWMJ6E
 Ys/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705990; x=1793310790;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tpjk1+Qe9swmsdgQES3dhfKMOj1ues0IZ8zIbpawXfQ=;
 b=KErZ3mxS0xyw/zOw6xYzzYDiVqrfzs/5AJ1frlCt6Q9Xwv7OX8AhJ0J0mgXscsfq19
 Ja3BuBVGcQ/zq86Mo3RoneEfKDsG/309fSJUyR60okh0Re2betq+/sMZVB3Ycl44nx7z
 1N3D/TM1dH8HIldaXazhEYnrQfxesIhsFgfPGrLKN57DQvevE3GQRHBFy2lZfqhbJj1l
 4UzA3UeybRN6BSBCriijPCqh/HjsI5gzw5yG4/cT0fsws4WAV7bBQoV+HN0L4wAkLbtN
 aacBKJcSzcoeTo4RNd3Plx6NSre3RfZEf85XaWBkXPp0ucg0xU0JCP9p0s3JbiQzfRgN
 8aKA==
X-Gm-Message-State: AFq9FYIO6PCdfchLoyOEZ7YL0OelCbioveoQkBvYb1Cq51wuAmc3guwe
 vuqZ2jfOKLMqx02efFD9oJ/hvExo381EWQrpUoPfYk4DQFbfaqHRz2POlHkFs2weU9c4KRh+YRr
 UQmWHfFyWAu8dfsm6GNrs6istqAGSh6yPSVlLMAloReaIVdc0a9A+2GaZexg0FTrdDQ==
X-Gm-Gg: AYBFou1B34+CHeD8q7k5hlUURQmJnpd3OLHA47+ma2VAztoxwARQpn2dF39MU+iyWqv
 9ym7/IldjWJQTnrOIHjiR130UnWVHNOvsjDUznI9FOqv4JFq6AmWwapq11ZCZ9LnggfignDkEYB
 mWyQUPThul15xfj1SwCQULRhDMCOGRVE7K7tBV0Pxyvewgl8GTiXS5HO7jGh6GPEsi9YSCiXt9H
 PZelqafDftgoitksOd5qhBTvQGIIlKlEBpGBTSpQN0zMWZAIY3W289jZw9IxSvmt149cS1s03sY
 ibhJUnGkeAdnz0Jmoo0FfcWzmPooKGqyKW7jKrwDuPq6/dqemWEA8uJWkCaXtxP0E/b2TbJHWw/
 2WT9oXWxtIiOfceTPa1ojugAeWT7HJ74b1+nmbfw2
X-Received: by 2002:a05:620a:4009:b0:93e:c35b:2332 with SMTP id
 af79cd13be357-93f6f853ebdmr146807085a.73.1792705990291; 
 Thu, 22 Oct 2026 14:53:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:93e:c35b:2332 with SMTP id
 af79cd13be357-93f6f853ebdmr146804285a.73.1792705989806; 
 Thu, 22 Oct 2026 14:53:09 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21034d740sm27833995e9.4.2026.10.22.14.53.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:53:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 15/33] target/m68k: Use a static table in
 m68k_exception_name()
Date: Thu, 22 Oct 2026 23:50:55 +0200
Message-ID: <20261022215115.19680-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX1DYOV85CKWzF
 AXN64Y2NIGF26l0pcDuI2jCFJMt7SOvy2xbNSPX/M9FOGM4Lep29Q2DtXon53EkMcijhu9oslcS
 YcSTKlrnC4Za85ck2wfAZJHUqqPKxY0=
X-Proofpoint-GUID: QtGiwwFCYA9cydQ4_rWkDw7GXRU9xXwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX37iB1EicmSB1
 KORZf6ZuwkbDQorVyVsVYfbCr8LjhEaX2lNAv7OTKKkEB6t0Nvd/n6nPbRmCwjKJqOCUy5FunYW
 RX0o8u3cbFDgfb01r4kPKWxrs3eobAHTqFTw2foJWeIYYfVcQEmTGlM/d0BpY8/SNUjjFipt3nC
 rozT38jcrVTT9vvrBdU6GOe9hSwS1RcYaOIxNX710cHvsFWJvxI3pjC+PgMZiBfoJZ7RyoHHPbx
 FWNF8fpfJSv6gfD3PI3XEaC9y2wFoLka1n+YL+rJq4zoHdXrZTgtMLAEeXGGCsQrSTsjJRmswht
 gdEyUT2u2JyoQBI6BhKsBZfeQRNxHMaOxoZmJWcC79a5Q8DtMK5C1wqbsNxQR9r2qH04z9Ft/Sv
 LYySkZtBRXmBA/GA2VCd3qAzPLYKbUfU6e0tE8mDZOFJP8P47pWJz1lMXwY7j9XHxDnqa2cHgxW
 i6qk8FMrOXJFOUf67tA==
X-Proofpoint-ORIG-GUID: QtGiwwFCYA9cydQ4_rWkDw7GXRU9xXwG
X-Authority-Analysis: v=2.4 cv=BdBNQbt2 c=1 sm=1 tr=0 ts=6ada85c7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MrkvrxfUm_GaFPyPbecA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the switch statement with a static lookup table.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/m68k/op_helper.c | 153 ++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 99 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index c600f83ddbf..c9db8a1b39d 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/cutils.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
@@ -84,107 +85,61 @@ throwaway:
 
 const char *m68k_exception_name(int excp)
 {
-    switch (excp) {
-    case EXCP_ACCESS:
-        return "Access Fault";
-    case EXCP_ADDRESS:
-        return "Address Error";
-    case EXCP_ILLEGAL:
-        return "Illegal Instruction";
-    case EXCP_DIV0:
-        return "Divide by Zero";
-    case EXCP_CHK:
-        return "CHK/CHK2";
-    case EXCP_TRAPCC:
-        return "FTRAPcc, TRAPcc, TRAPV";
-    case EXCP_PRIVILEGE:
-        return "Privilege Violation";
-    case EXCP_TRACE:
-        return "Trace";
-    case EXCP_LINEA:
-        return "A-Line";
-    case EXCP_LINEF:
-        return "F-Line";
-    case EXCP_DEBEGBP: /* 68020/030 only */
-        return "Copro Protocol Violation";
-    case EXCP_FORMAT:
-        return "Format Error";
-    case EXCP_UNINITIALIZED:
-        return "Uninitialized Interrupt";
-    case EXCP_SPURIOUS:
-        return "Spurious Interrupt";
-    case EXCP_INT_LEVEL_1:
-        return "Level 1 Interrupt";
-    case EXCP_INT_LEVEL_1 + 1:
-        return "Level 2 Interrupt";
-    case EXCP_INT_LEVEL_1 + 2:
-        return "Level 3 Interrupt";
-    case EXCP_INT_LEVEL_1 + 3:
-        return "Level 4 Interrupt";
-    case EXCP_INT_LEVEL_1 + 4:
-        return "Level 5 Interrupt";
-    case EXCP_INT_LEVEL_1 + 5:
-        return "Level 6 Interrupt";
-    case EXCP_INT_LEVEL_1 + 6:
-        return "Level 7 Interrupt";
-    case EXCP_TRAP0:
-        return "TRAP #0";
-    case EXCP_TRAP0 + 1:
-        return "TRAP #1";
-    case EXCP_TRAP0 + 2:
-        return "TRAP #2";
-    case EXCP_TRAP0 + 3:
-        return "TRAP #3";
-    case EXCP_TRAP0 + 4:
-        return "TRAP #4";
-    case EXCP_TRAP0 + 5:
-        return "TRAP #5";
-    case EXCP_TRAP0 + 6:
-        return "TRAP #6";
-    case EXCP_TRAP0 + 7:
-        return "TRAP #7";
-    case EXCP_TRAP0 + 8:
-        return "TRAP #8";
-    case EXCP_TRAP0 + 9:
-        return "TRAP #9";
-    case EXCP_TRAP0 + 10:
-        return "TRAP #10";
-    case EXCP_TRAP0 + 11:
-        return "TRAP #11";
-    case EXCP_TRAP0 + 12:
-        return "TRAP #12";
-    case EXCP_TRAP0 + 13:
-        return "TRAP #13";
-    case EXCP_TRAP0 + 14:
-        return "TRAP #14";
-    case EXCP_TRAP0 + 15:
-        return "TRAP #15";
-    case EXCP_FP_BSUN:
-        return "FP Branch/Set on unordered condition";
-    case EXCP_FP_INEX:
-        return "FP Inexact Result";
-    case EXCP_FP_DZ:
-        return "FP Divide by Zero";
-    case EXCP_FP_UNFL:
-        return "FP Underflow";
-    case EXCP_FP_OPERR:
-        return "FP Operand Error";
-    case EXCP_FP_OVFL:
-        return "FP Overflow";
-    case EXCP_FP_SNAN:
-        return "FP Signaling NAN";
-    case EXCP_FP_UNIMP:
-        return "FP Unimplemented Data Type";
-    case EXCP_MMU_CONF: /* 68030/68851 only */
-        return "MMU Configuration Error";
-    case EXCP_MMU_ILLEGAL: /* 68851 only */
-        return "MMU Illegal Operation";
-    case EXCP_MMU_ACCESS: /* 68851 only */
-        return "MMU Access Level Violation";
-    case 64 ... 255:
+    static const char * const excp_names[] = {
+        [EXCP_ACCESS]           = "Access Fault",
+        [EXCP_ADDRESS]          = "Address Error",
+        [EXCP_ILLEGAL]          = "Illegal Instruction",
+        [EXCP_DIV0]             = "Divide by Zero",
+        [EXCP_CHK]              = "CHK/CHK2",
+        [EXCP_TRAPCC]           = "FTRAPcc, TRAPcc, TRAPV",
+        [EXCP_PRIVILEGE]        = "Privilege Violation",
+        [EXCP_TRACE]            = "Trace",
+        [EXCP_LINEA]            = "A-Line",
+        [EXCP_LINEF]            = "F-Line",
+        [EXCP_DEBEGBP]          = "Copro Protocol Violation", /* 68020/030 only */
+        [EXCP_FORMAT]           = "Format Error",
+        [EXCP_UNINITIALIZED]    = "Uninitialized Interrupt",
+        [EXCP_SPURIOUS]         = "Spurious Interrupt",
+        [EXCP_INT_LEVEL_1]      = "Level 1 Interrupt",
+        [EXCP_INT_LEVEL_1 + 1]  = "Level 2 Interrupt",
+        [EXCP_INT_LEVEL_1 + 2]  = "Level 3 Interrupt",
+        [EXCP_INT_LEVEL_1 + 3]  = "Level 4 Interrupt",
+        [EXCP_INT_LEVEL_1 + 4]  = "Level 5 Interrupt",
+        [EXCP_INT_LEVEL_1 + 5]  = "Level 6 Interrupt",
+        [EXCP_INT_LEVEL_1 + 6]  = "Level 7 Interrupt",
+        [EXCP_TRAP0]            = "TRAP #0",
+        [EXCP_TRAP0 + 1]        = "TRAP #1",
+        [EXCP_TRAP0 + 2]        = "TRAP #2",
+        [EXCP_TRAP0 + 3]        = "TRAP #3",
+        [EXCP_TRAP0 + 4]        = "TRAP #4",
+        [EXCP_TRAP0 + 5]        = "TRAP #5",
+        [EXCP_TRAP0 + 6]        = "TRAP #6",
+        [EXCP_TRAP0 + 7]        = "TRAP #7",
+        [EXCP_TRAP0 + 8]        = "TRAP #8",
+        [EXCP_TRAP0 + 9]        = "TRAP #9",
+        [EXCP_TRAP0 + 10]       = "TRAP #10",
+        [EXCP_TRAP0 + 11]       = "TRAP #11",
+        [EXCP_TRAP0 + 12]       = "TRAP #12",
+        [EXCP_TRAP0 + 13]       = "TRAP #13",
+        [EXCP_TRAP0 + 14]       = "TRAP #14",
+        [EXCP_TRAP0 + 15]       = "TRAP #15",
+        [EXCP_FP_BSUN]          = "FP Branch/Set on unordered condition",
+        [EXCP_FP_INEX]          = "FP Inexact Result",
+        [EXCP_FP_DZ]            = "FP Divide by Zero",
+        [EXCP_FP_UNFL]          = "FP Underflow",
+        [EXCP_FP_OPERR]         = "FP Operand Error",
+        [EXCP_FP_OVFL]          = "FP Overflow",
+        [EXCP_FP_SNAN]          = "FP Signaling NAN",
+        [EXCP_FP_UNIMP]         = "FP Unimplemented Data Type",
+        [EXCP_MMU_CONF]         = "MMU Configuration Error", /* 68030/68851 only */
+        [EXCP_MMU_ILLEGAL]      = "MMU Illegal Operation", /* 68851 only */
+        [EXCP_MMU_ACCESS]       = "MMU Access Level Violation", /* 68851 only */
+    };
+
+    if (excp >= 64 && excp <= 255) {
         return "User Defined Vector";
     }
-    return "Unassigned";
+    return STR_ARRAY_ELEM_OR_NULL(excp_names, excp) ?: "Unassigned";
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.55.0


