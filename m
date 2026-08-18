Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6DBC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY0-000372-7R; Tue, 18 Aug 2026 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXs-0002wJ-Dv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXp-0000Dm-Ez
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:24 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaZKx1940439
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=; b=PHRXjLZARfa8Axzq
 RSwPMZjiYpamOeOTyZ0Jv/znXUn0W8WsRPI1LSJwyKr+Eo+0eA4KBrNI79iucCJ7
 yVHsQTpU+f4dPNdg7up1HO9t8kzvaH7JgPlkdDLF5yosvYk8GDIe43PCMgK7yjV0
 FuJaIFVDOa2m0GtTbizgsP9n2xAXvQawYRNG5w1hnWhbQnfqR2yOSgGa0zsUsDCu
 g3xUXaP7VhOVNKMrR+X+ZNkldd026gBZA5Pjp3EFTiQ8UfTCKMLkO/uxLxHbUI5P
 KayFLIsjq6u+0Nq5jD9pmcmEJVAH4KfZ+vvFmFnlyNY4pB3wPju8Z121c3BCSyRj
 AG2YRg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu06nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c89704da8c7so209426a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081539; x=1787686339; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=;
 b=iNKvDLg1ir3a/UKcC3DpT3iGVVMfs8afxucyl7Y2Tkrh0O0IZAdpSvdf0+w4TPp+Va
 Cjh6f0y+9NhPB6KujR5RdvzhMhfa0YI1/d2Uce6FrMQsHES7S4leMwWp/2JgS6V1qhu4
 Eb5ags3jbZOJLtSduBB7RoPM7gDw/n+uvqZaV3lXGXJqgMIDaqvHz9xVQJ5NZAgEjWu8
 4U+VBEATfltQOUPUAglJk4GuM/L8I88cVTRJhtyl+gnxKJOrFgyVCwsTsH38VmWwqt09
 pDE5Zaoow8uFGVqKUuGv0wFvFcDwjz9UR+3Smb/ypmcI+n6rGf+YG7Mng7yhnDRqqxuI
 77UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081539; x=1787686339;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NrIp+DZsd+nQjheRQ1gcH+UWlnZp+GjS9oaS9w7InsI=;
 b=sORdoE22bHwcoLPj/vpQ40DvpBEN3quSKH0579ERTKUjdYTTic3GwGWWYtPCm5pwcE
 DLYXG+i2OZ8roDpRtcAaxyatYHmOE4Ma07sPSfLRAfqLy4yCjR7sCb1LGYFkNKLpMEmr
 FG4qsfjDqCzRNYBvVyV8myy39NorKSQI+YidboJxp/tXaUsHicAPgg8TIuj4FBbGeWQJ
 VZ+XvmfaDO5jNyh7liPp7fQaA/orrCev5KNSaIoaJNgnCWfWXS7e6MMhTltNvtf85UKt
 2WQ7g/adnIiG4Uh5oQijemkEr31dQiMkYMbQ9sifB0yn8ary4BjX/DccyTpgaFYUk/bn
 A0MQ==
X-Gm-Message-State: AOJu0Yyd5v09b5xK5IcRkMUFiwyD9hLl17HFcmTm4mVhk7thLZQzrvmW
 23nMgjfbOJP0GrRqhOllNLZOYBeRx2TDDYq7VMJVWG7h+XA+97ZMN8+OJm3eLi3JAu2sqvVh8+f
 JT/WTyIr9KDvjV4x/XtbTgLI8oHXB9W3la0iAZCR3Q9VIvyUTOKqSw3Ykpuf0uTWG9Q==
X-Gm-Gg: AR+sD10AqEk8BKjpzj2IxDNZYtUzbirvokZ3Fjng45HBAl9kosrZ41nbUoJTnPtxdb1
 LX1oGhtwZGsuxlUD/crzLActPW5F7IzZ4+dRWya5+Q7oLC/c9H9s2VIQhHoq7Ta28NO9PjOZlBf
 dHbrj+2sgCxkEq/+918Qd5OSUv2cyp2RU/XOF5ocybueBqOeWxduxJNbyDKZysqJN9FAcnwKXKB
 crhSFfejF+U13ut8xe+s7y+ocQPX3ZSgYbGPdhdbBOTtw9TM8RYGimhfE71QTU8S23MIezZb/TF
 RcbGyxq7B/OOr08U1TX17pURIBcTWRzY4h7kefdGJhgg10m+4hhvFFctbD0T8vQlk+CUzb1xcnW
 hvjVzi8wPefOlwTLeD1i2yOWsZ+LwrTtUI2XDjCFiU5P2q5rFBgyruLoxZK4=
X-Received: by 2002:a05:6a20:939b:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3ccff33255bmr153697637.9.1787081538821; 
 Tue, 18 Aug 2026 12:32:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:939b:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3ccff33255bmr153642637.9.1787081538439; 
 Tue, 18 Aug 2026 12:32:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:18 -0700 (PDT)
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
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 082/104] tests/tcg/s390x/head64.S: declare _exit symbol
 after main
Date: Tue, 18 Aug 2026 19:22:46 +0000
Message-ID: <20260818192309.22169-83-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iOK4cpSnnfPhGaNcAktyDIZg443Ywrkv
X-Proofpoint-GUID: iOK4cpSnnfPhGaNcAktyDIZg443Ywrkv
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b343 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzDpbveHungC6
 iKqPLVbsffAEWfqv9uxD9LB8OuLDCwnlGRNlbcniHO0usgHaLsbwI+uZ80SfBpAjFdGlyPw7WOl
 1L+DOg5wvvXZ0pMq3FLEVb8vvWLmo/V/eIDmgdWrdSlfDyMVSkAkCBIuSs1/ZDErIsMQxNaObxY
 nuxtw/hlOzAh6dQVPd2pUI0c2R21Fd8Yu/0JHYlVCPOALSRg4i1z7BnBfVnTg+uCDrp73qGZj7P
 EXkTn0g4O4585/xg8UVrhJUEXhx9JPj+Jx2XgQYRiKYS79mSx24BYD3yRRW++AoNRoTU8L6m9Cg
 mSebQGQ5og59m6mawKcBoV88MZOC1ihbnYwr4ntebNfaqOGWFJzUazIPoPdfi0CScgmiEC4cPh+
 XiNUXvl7y60Tzmu5NGB7DnR3qFRo1ZD/Mdw0CJyJ4z8Insn2C+JtTKv+YB0AgeW89O/pOmxR3TN
 xoXaP+KH6egWBY7Mo1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0MARPw7zSZE9
 wh/4RxY7Er0lLSx8A5BQlCD3FFsPm3q6gOPfnwgtGieVm6anMX3mLQ0x4VLx49U2YtfED1b/hh5
 WhM1CabX7mRC2RCC4h6H151SR5RJoQA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/head64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.43.0


