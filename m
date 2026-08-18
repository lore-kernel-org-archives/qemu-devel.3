Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DAAC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUA-0006w1-I5; Tue, 18 Aug 2026 15:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU9-0006t8-Hi
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPU7-0007WW-Ty
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:33 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH4vW3003284
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=; b=X65bdwgtMHszcOC2
 mTwXKFlx0I22CjHlvk9TSLEusfy+/UV0DKoBA27FZwgIWP42ryRlvucUw2Ck82eH
 20qT4333m6k+699iwut28oahIbtUvdMYe/8sW5615mlUs9SHoceokDbQajYZC2L3
 1PTVEiENfKqzHrtM39uN5iMGES8xZqJsXFVhyORTb6btOT6NfDyTbtpie/qoMA0o
 K/oZIGOJfMrp7g877qHalY1M2au89tZrE8uHvzi7JzimS6+LPYoLGgjSW9nieUdN
 IemOSaKUZJ+ZgYK+yLgs3ym2VwwquEOs/Ah9Cn0HSSL6Z5HPmGORa1ML1Mivw3DN
 dINNLw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4frmv40v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so1401425ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081299; x=1787686099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=;
 b=OEXg2eGR40JIFoWX2pGjSs7XH5Jni9wzTbHsryEkoERP8rgs/ducmn0pIDpeddMUIX
 wjP5F/WhsHqGAUc+CBCdf6007eLdLL7CTogEWrP8c3cdFVM4lcG3LMn5GYiXV0TvKxoc
 BI1llUulbWmBhxMx24sThoQkaa9ty3mxepXpYPaCbFLT4Ikup/xbiXVcUF6L+HTiUvoy
 FnHEfmibAPPcNs6zm/njFXak7YEcXAmc6kH7bHsH7j9ksXOGBG/zgu9EmbOaz8BVxwT4
 kMMKoO5lGcwz9x64kOsMfCfAiudMisrgHLXJN7/NVSU/9L2t06ogc8X8E//11G0v/z1R
 1wLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081299; x=1787686099;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M73bynyQNUHw9mOJCKTaWimWobRclxFO1rbi5NLu9GE=;
 b=st/Pehdk1yq4B1Bt/Wb0IQ6WOh8QC8rD6VEzuywOPWt9vwcBtiujkspV/jeq8VMGFx
 8mlH063y2qQXl0W++fvOO79e10+4oS4yNQztgDUUF84JgikVMM6OgZmFQqQsE29zaBRj
 nu706ap6koxXTDAnDlgz3zjFRV16WAltUk4PkDB/Lk8M8sTvUB4syW4g/FdoOjRc98UD
 02agp9lT9D19V8sZYFiLfD720kJSr493RbY+o4h+NUrl6KgX2qezERYzXL+mqFEK3C2x
 WujugbOyXx0ALMRJHNi7c2d2DKym/yr8s2ftJiVAdvWPcwclJkkPDBeRFUav6SzSmEf0
 EEuw==
X-Gm-Message-State: AOJu0YztNTPMX0rzg/xCSPLgLNllIlyFBVFfZzarfT7Ny0VYasnzga5A
 pPUfl3qQzJ8yl8Dqp8MRK7D5NYAExFE/bwm0RBidO5eYtPDtlhVa+A9JEFUdGCFbMQUIcHcg6Rm
 0vGXJarXyiZBLGb2M0nh1aKNjpSxvlvnq/eNBlZsfyZUDWh3Z90wAuNpdbGhZ4ZNM4g==
X-Gm-Gg: AR+sD10TvtYlvqjB9cXxDm7TpZbVPMrVcj849gMgsKvsfQuYJqGz70RMXBtDJN2iQ9W
 MrAI33pkada+G6zakMyjQ7F8oSlifFYtk/IyhYDAk+WLUGfGc6Ali1r4LVlc00+VH+fpGivEa4z
 xpi4+Uv2JlCRyDKMV2L0jyEDPIQokoU5d32LKNHi6FrqcJOgsK2RllUMI8ZGWGndQ0iBc4rBI8U
 gp29Cz+fB19+IN7buxk8uQB83/dBFY1L63VwybQ4YUPTW6avr8lZS2uTXLSUy+NBEF12BYK1dXu
 kQZfKSjDbAQOp/T/NFufQgbeSqZXiz2k1lC/AZclb4mPomcZ1hvY/f4EBlzgZKmDGEjsw1nuQsx
 iyysBn6qhUIKneQa9PlrIPlclGROS/K/AqZMw92WW5kJRMkB7iJ82rSHhhbE=
X-Received: by 2002:a17:903:38cd:b0:2d3:7122:833 with SMTP id
 d9443c01a7336-2d5cae29fc2mr100585055ad.15.1787081298930; 
 Tue, 18 Aug 2026 12:28:18 -0700 (PDT)
X-Received: by 2002:a17:903:38cd:b0:2d3:7122:833 with SMTP id
 d9443c01a7336-2d5cae29fc2mr100584445ad.15.1787081298390; 
 Tue, 18 Aug 2026 12:28:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 061/104] scripts/probe-gdb-support.py: add mapping for mips
 architecture
Date: Tue, 18 Aug 2026 19:22:25 +0000
Message-ID: <20260818192309.22169-62-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXz/hK5e5+0F2u
 fky0oNo/CqZqVPXNjv84urfrryZ9US5duBggeDhhSKgTKmeqqxFPolBY23JAgQW+id2CY6uqYvY
 nvT56Z45fdVdj34MwQSyFNLlQr1MLtuJ1AhYadgsJtwdyszDfytEielaHAttGzFyEvd3tV1tvw5
 kstAmvo5t7FSce7J0yf0hj/wKt4THH+bLlhtP4bVRHzlLtMAqq4bNLABkW3Oo62VORVT5J1V54B
 ihBDz1GODEgf6XtSl0xSRD4+t8vUl4be3rpuGARL2PHGSjpgIrxccAKLm0SJJG2YLBJSC3T7RhK
 eMPDezs8SQkIII5Z+34KKOqJ6sfXp1U1C2R2a0IwVmi4WVc58IzGky5I5CwsTdb5hN/JEq5sk3t
 IF2+rDi5FQ1Pe1OWwTzG3bgLLlDCYY62nWpllBd+Vl/A09x+jyNsbXm34B8zgUFtYjQTt8dopXT
 0FmCd4R79iCBv/qp7PA==
X-Proofpoint-GUID: HOe1CdhpT8rotq6Cdu2I-gLLErKJkwr4
X-Proofpoint-ORIG-GUID: HOe1CdhpT8rotq6Cdu2I-gLLErKJkwr4
X-Authority-Analysis: v=2.4 cv=GtlyPE1C c=1 sm=1 tr=0 ts=6a84b253 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6TioWX3XaE2h
 hM19H6Ek6uVA+Us3+XVan3QVg835BOB48k2jb0JM4xHPrnN/MLRcANgK+P2zkvOLGWbDF1+BqNp
 3fwpe4uefD8WhM0fktmqeEIvBWyEtzQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/probe-gdb-support.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 43c70302873..da91c528ad9 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -35,6 +35,7 @@
     "Loongarch64" : ["loongarch64"],
     "m68k" : ["m68k"],
     "MicroBlaze" : ["microblaze"],
+    "mips" : ["mips", "mipsel"],
     "mips:isa64" : ["mips64", "mips64el"],
     "or1k" : ["or1k"],
     "powerpc:common" : ["ppc"],
-- 
2.43.0


