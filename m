Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88181C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSV-00084E-I2; Thu, 27 Aug 2026 18:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSD-000616-2B
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSA-0007Ol-Uc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:12 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLecT124903
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=; b=A5AOc0pwqISJVqtk
 GGLESd66811ea1HSlKsT3856yDiaLq/W1nr43PfcAUXf/EfMcG1KrfxNQDTkFr4N
 0jrGjSgH2X3kM9SYKV8EDD6XiNnKv40I8Rk5xmfkkul9ti5MhFDh68s8TzeJb5Cv
 eKT6wnTAjB3fmZW6C7Lqu0iQA4CvM+JweSf7reXelvyHf8RqNAiH9RfvQOAyMxFZ
 hwp89s59g+0MJis25ceGW1xDRNfrUeJlvd1b8UgtpfAN9TWpK2U8iCAwZFZTtc22
 Nv1b2fpH9knb8odrmu9YZkOm+mxjpE2X5U6E4CIT83vdvCAz0cSloRc80IfkogL1
 3CpdMQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7tw6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so333509a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869199; x=1788473999; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=;
 b=ffMAi83ekURPwj3G+O4HWYbsrnER3z3Agxau07bFGd7ld7cRDdacsDbqPYA+dqXDT0
 qFmsMW2/HcUhdZyKaZd91WY++iEWc6uSYXK/8rEz7jFR969ycNgj5LGsjzfEZhUPLplo
 iHHse1CU4e+77Y8uflPdIuKUlzU2mLRMgaBOAMaxc1OWLpgDEXP98m3Y5UlGmxpAH9VH
 0THLrKp+tYi9xDzsIVq1TDR2Xw+piKH9cVf4XP5uJElrlQa55FvLpjteRB/3QoZSc4F0
 4jptReGQtuPXCgV2fg2bG3YSJ0yEe+UMwmxRuJFRtmhfTnxVW0FTPcQpFq3IAoJ9P+ve
 B2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869199; x=1788473999;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q4vMgFhsWM4rjoh4uwVn7kAYmfdW+X3xe0f7UD1qC+A=;
 b=FBxyIxF76Bg7NSRCLa2ItE8g2uxfAo4uzzUwShpKSYPzLP38cNvlrHMGGbotSCXNpr
 flhVofAbeH6KeRRismGX9euKYipSWtKLGOKZ8lw6Y+lc4MHQnsvnm1V/xhqQ4fV96Vvh
 eH/4GseEpGimpewmrn09my2Xkp3DhVEKsVsIz3lF2GeZkJcbhfEetL9fSAnPeJ3cmDT7
 db8lCo9v0cJYyDQ711eSMGtex11B8uVQtAAvrDSZTsrPrsRvZxW+5YZ0fKEtPWwH6Kyk
 BagJ7qnBIWy47BARjvu6cyhnQ1ohDmxOo1gsPOC5FcHX0YCBWnDi9ahy7S4vjwc5ulqP
 35zg==
X-Gm-Message-State: AFuF++lUWuM3flT1MWGx+C5FUVcN3Mo3+We9jnL6GD3g6s6/moH3zFcu
 lTnzeLa7MrxlObyHffDx0nX3sX772dGm5RHUpU+DnH9iBd8BsvZgEJbbZALy+Dw8txiuIt7orp4
 hZZWmw8eWbFbJrof1XHjJsE2nWnlpyik/iTn2Q4jq6jOJktqzfVdI07mRZLGr4HY+Jg==
X-Gm-Gg: AR+sD123EM+AbMMQvPWluO9H9jZf9oigtizhLybjCrxv4jXU4VaVmrP99h2KM9cj/mG
 wsvB5f14ICRXAa8j/lL+QSzPz7lCuznevSUDqyiahqyjQOruvuBIhD3iQVH0jLeY+rvlaUO/EaR
 mCcACnPxBmYGaMNkXJf/5ypbBWVH97Gapm9umgqdf0p9gpTcaKlZJe3PC3yvOQGL+8Gyu2wUMJ7
 10QWgtffzXwoXFsm310MtKnkKyjw3qVD4a0HGPiHHU12gjMDHUTPNn3yVid9ZNn8wN0ms10B7RT
 1Cn1P4BXSjnDJ2mi67zb1/42l+iVD4WnpH4b7x8G9JQGyMahzJGiSgOrqHh40ig6lh0TNIAVBF9
 FpYUGNfuNSn6SPZZcGZwNxjp5ygq6yAwg+fwN0WuP3hIw9CelK5VBIcToTuo=
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-396d0f1a83fmr4429029a91.13.1787869198811; 
 Thu, 27 Aug 2026 15:19:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5890:b0:392:e5b1:d833 with SMTP id
 98e67ed59e1d1-396d0f1a83fmr4428956a91.13.1787869198386; 
 Thu, 27 Aug 2026 15:19:58 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:19:57 -0700 (PDT)
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
Subject: [PATCH v8 069/105] tests/tcg/or1k/test_addic.c: remove unused
 variables
Date: Thu, 27 Aug 2026 22:14:30 +0000
Message-ID: <20260827221506.91574-70-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX9QF2jTcooKFc
 kngIHWphOYKYap6o+th5GGHGCR3BaERd3pwrrNnt+4G+VU24Rq4wdpJwDdMBwjE1JoDPLQaIVvO
 B5RvKYwYnDwQAZTMyz2ZQF8iYMNuHNr6N+gbBnTxA4vWAIcR6sS5+yoKXmpWnD55387GpqQil9f
 +u026wy5cHDTCliiw/ROMedpsHCzwqFfwG9I96HvBwWn6wvM9vsR6Dj4cjnVsRdtvdEzge5O6a2
 p4LTUhNFOxgPOeswslPeCOSI1ZD/hsB57hn9cGWqsqvC/4Wx2+n96z7O3fHbFtCPvDAWrV3E+cT
 oPiSQMlgro1tp2G+Q+UG8ENSCnXvDTsM9Y9I2k99ug1o8r8uQuynTIWUIJNVWx9lm2Km9D55r7I
 2VgXK2Z+ddNUtsPzbGJWp7aczYPy01ShxHd3YbWFaA42ybq1hIyW5xgWg9iox6BflKwYvcsMM+7
 vizshpfjtn3gAAkh5Ng==
X-Proofpoint-GUID: Ugh568oWW3JS7SQwriJSrDX8g6s0bOox
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a90b80f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ugh568oWW3JS7SQwriJSrDX8g6s0bOox
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX2ZIcaEPv/o12
 sU70JnzGHVVepD5/D8EyS0az5hHJ7yjpeP421FK81dAUT+FD/miMNPWjbCaQg85qCfNyAiEOBsc
 SRNJupRlfVpXdlWPH6hHFzPhaNuRSoc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_addic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.43.0


