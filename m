Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D38606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ea6eKaRA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FCJcR+Cb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWgs3-0006bh-J7; Thu, 26 Nov 2026 16:19:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWgrv-0006bO-HR
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:19:03 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWgrt-0002KG-MH
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:19:03 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJwknX1712701
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 21:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LX+n+ewBMZgUU72cP682uV
 VV2++sAULjxyow1lI9euA=; b=Ea6eKaRAiMdpgbPJKsamE6rxXbMd4+gLrqe8je
 hrwt10iV2UAsvBOukvWVU0rQrt/0mbhQ9Fl6hUBhSkNkkwoz68EqGiCEsRPk/Flf
 me4ybfQ/fe2XCkr0MpvmsclIS383bnmVTZNKvYGSJZ8fZcoqERpkW7gqM3BjuIqb
 2KGC2Yj2OYXMB9yzdAtJ2mLdlaFzm408U6pdadOYSvYN0UxwpBLvlkzq42TsgMaL
 xH85uTaaWLfqgre2UV19l4fmq+1sUyyHfeC4d6lbUbfx9jhK9Nc4iWUO3Sns4kMt
 bXWXhPqkgrfpcjqwYqXhif9W9vtOsjTH+NP82l+gnBQI5lkQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2hw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 21:18:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f37c94ceeso1335450985a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 13:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795727935; x=1796332735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LX+n+ewBMZgUU72cP682uVVV2++sAULjxyow1lI9euA=;
 b=FCJcR+CbHJ55TyIM+bcx4D7zPUClgG0nBJDakpsyYoMYKEV8zgBMKao1n5sfCiDVIH
 ainunLUsq/DGc9HaSpN/tTc7GQdKZ7cRnGTB/9473kaxaNQ7ShaNik6ezk3Jqu6A52aN
 gSvyHYPX/4b3QiLeVh4mAo0MqOnovqXZkSsgWN+5ElwObWZGRXK4EU1FrP42kDzyIaUw
 kcXM7t2EpRdQCZi3Wn5zkA2uMyZigzZDLw0DaM13dVlRLu3fD0ZShWL3fo29r2NYchm7
 FATCkgVJz1x5a/8/H68iPyJwOB0DTzV0OQjJmFgQHzzDBiTZDbBFDg1yo5xnYBwdSv1N
 4I0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795727935; x=1796332735;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LX+n+ewBMZgUU72cP682uVVV2++sAULjxyow1lI9euA=;
 b=L1OTf3/kHMIUUTsQ3GkRO3gzk5qqyUyUIzvtwYbh10az75TlnMsDBnPgTw4aohI82N
 7axvYLz8aRDGtRknMhNIdHMkfrpWTUXtYCMHqqEkYHevKzFYbI7dgQMdBYJcxXyiUCnv
 MhmEOM/bsi36P+NH0xXngbude4kq/yXIG4ncoyf63LvBlDVhJQpshVbiuGl9ifieqaK4
 Ah7KlxPzh3a0oOa7nFYCkHqXQTXLrGePfxyxmLXX1X9g82jVPSzqCwrf32hmfLiom77x
 ZWxp0MyQWnc+qXxGuFgAs+x0dnoG6pewmNaxwNTczPFE4UQpQRICI/M6beqn/usxQ3dO
 0y9A==
X-Gm-Message-State: APuU4Z8VN09vM9807OYkz/Xh91+CHr7sb7/4L+0DWU5CaX8QRYwm+bzm
 M9jd3V15QIpURJ6TfTHAMKHAH+iOQqWpCOnho7KbTwmzV1Oss8w5qhMvAX76PlhW4/tMUeZ/Yu+
 M4+u/mI6YWJl0KsNjsO8spPMXdDtpGUWfFwbnXXyjcabyzV4TquArPsJMDKfkslt1mQ==
X-Gm-Gg: AZFdTZdvH1c4aX5Pn2nn8TvSaHY8PziXALvHhkkWeSid2VBQj8KSNyDbd6LoO4jIEoz
 fzi5D6ADe0HSChgALD10pvqIA+6+XTA5fxnYu5sCMKHSxJfyYFU/Uiqyxm22BgB3sa9wS0AnorR
 gjqACJBao046kTYcR41FvaEVzdq1VRtQo3TAYKzDiO/VRWzzRSXdxrx4rCYgeYmuJWxADMn/02H
 K6XwifwX1Eg2PGpJI9Fm+bwIna996P2PUpehoHfWnk79wMSicaAwGwCrVJ8CI+jBZuHjgaqHiaD
 om3PClHOi9D0+3GHYjsNmNZeapAkBwTPaQxk1ekP87/uSaRUA4xtt72A7kEnK5tl3i/q0n0a9ph
 c/KLXdiYIFYlVZFfZGcuPZJXsB+RAkfKR5UY3yiXJR+RV70P2wSkxiFbLKGRBxOShDNFxMoDY+L
 //kb9tpXHGke+mPg==
X-Received: by 2002:a05:620a:6892:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-949b3572599mr3865242285a.7.1795727935141; 
 Thu, 26 Nov 2026 13:18:55 -0800 (PST)
X-Received: by 2002:a05:620a:6892:b0:93f:5a85:cf9 with SMTP id
 af79cd13be357-949b3572599mr3865238585a.7.1795727934676; 
 Thu, 26 Nov 2026 13:18:54 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm23673530f8f.43.2026.11.26.13.18.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 13:18:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] docs/devel/tcg-icount: Describe translator_io_start()
Date: Thu, 26 Nov 2026 22:18:51 +0100
Message-ID: <20261126211851.49019-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08a240 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=G4d5PqQyJUWPuj6nSvgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4MyBTYWx0ZWRfX7RyiGdz9JiEd
 U9za4o2kwekog49kH5syl2mSpdW9FONnaV4PCTVbY4f/CuxtH4/WPJ59p/uYK2QLd80SkGQNMt2
 3hAgwV8fVgM5MAf0CFjqJ67T0hAeXiHwcI7Q9BCzuSQuM/uDNmuvv+pvsx0NWjMlMKSEDm6ph47
 EnngPZdsAiIr5gN2hVj+jzQtyUa5+d0ofDgjnHc5Nsd6EPwcLlOGrARLl1APKxRbCx4wD/ijmuD
 RdBkitLGO1RV3ax2worENPWSk/YJ+6t+a69eNDFEZ6CNU12/R61WfqSqW9sCb/FCfR5MGeJlLA8
 XLFHVrjOQjsCrwI8or9qaOUmVSh546KSRor6jSN/iP4/19rUxqMjKn0XN7ccmmMWcEPP6umU0iT
 lXTaO1yaiW/K/iIZr/j+d9TkolQI+lC0b45uCR7xj5sIkD8+yFOUGUME/635PNiBEBnMGg19PsZ
 BiWyJxXrGE9oCKCkbjg==
X-Proofpoint-GUID: YKD5Dlss3zEaZ6vVIWTikfSup82i3kSJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4MyBTYWx0ZWRfX1nmf4zzU3b+J
 9IAj4l178ebGjFvfrzFCpie7pETslEnXrNJuL+keCzt+nXpCO6wWiWLzyk/6ox22oeOQi8XMGEc
 Cgg3135H8ohTJbruLObchHdwnwu9ZE4=
X-Proofpoint-ORIG-GUID: YKD5Dlss3zEaZ6vVIWTikfSup82i3kSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260083
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

gen_io_start() no longer exists, and since commit 18a536f1f8d6
("accel/tcg: Always require can_do_io") I/O instructions end the
TB regardless of icount. Document translator_io_start() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/devel/tcg-icount.rst | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index a1dcd79e0fdd..6541d98e170d 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -73,16 +73,14 @@ system registers are the common examples here. These instructions have
 to be handled by the individual translators which have the knowledge
 of which operations are I/O operations.
 
-When the translator is handling an instruction of this kind:
-
-* it must call gen_io_start() if icount is enabled, at some
-   point before the generation of the code which actually does
-   the I/O, using a code fragment similar to:
+When the translator is handling an instruction of this kind, it must
+call translator_io_start() before generating the code which actually
+does the I/O:
 
 .. code:: c
 
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_start();
-    }
+    translator_io_start(&s->base);
 
-* it must end the TB immediately after this instruction
+This makes the instruction the last one of the TB, whether or not
+icount is enabled, so that it executes with ``can_do_io`` set and,
+with icount, reads an exact clock.
-- 
2.55.0


