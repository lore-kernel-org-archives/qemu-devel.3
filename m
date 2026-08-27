Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0281FC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziG4-0007W0-6v; Thu, 27 Aug 2026 18:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG2-0007VE-OX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziG1-0003Um-5C
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:07:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLuCV547180
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=; b=CWO5AKO+y4hfSjbz
 P61X2piWU/EyX+UaanwpRv01EH1sVPS6AC2SXXF3K+Umt0/6TSlZbQpNt04hz6wZ
 becYs/Or36KXJbZ5NNXTUz0CiNgjZHBjpmEab+djTD+bwRbmk7jFP0UPXs+qjka6
 VToYSLoMI84aNSnvWbKxJBY3X1AzMRXOAZstcMf0BmV0INRUYXUm9D7auYjpLVur
 PKw31IqvLbIPjzXHGJ1WOgYld0yB6B2GjnxZA9mwLCAUhzr+UD11s7vQabpQt6Ee
 ginfRCALK1W4GslD50gcTtU7RsOoZmzbgvsuyP1zf7cDrugIyzNgXDsVDwuNTh8D
 EFwwIg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gak562spy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:07:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e1da97175so269688b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868445; x=1788473245; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=M6WDqNjUbLqK0833jX9Q0gPyeegpM+EjluimUF0ph7S39k8iP2W6LgfKmVoNK3pfrW
 OX9r0VTLkRhxwepML/sNHooi0ZLjQh4nf9KaaFbavZEojeV4GglHIENGw841JeP2ui9X
 CNO7rIwX6pDg+nm0GiTsiqeqgEqOBOPjSgQW5AW/AUgcY8v6y7SRV3/96UZZgbOhyAaB
 Og9sSW6kahXcVsHO82imILQsHhcmGcC7VAM7a2NUyJS5Un9XdZX62m76mNu+tkAFXKBk
 HLF0m79VGTVIbYOES5oD9gMLge4hY338G8v33yEYSa97J/19NM6lbkeMvaKGGlCgtl2l
 4INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868445; x=1788473245;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=A8GKAKuc8NbwvP7BW6awqIIGsXCYBoeS9qNVw68CYFOD19mzatzxA9q01+HC0IjM79
 BpbrbhdFnLecw8ESyrfSBfvXxqXYIeJlpij3iCxUz3CUYpTlF6lKtCSMO94qy+2pDkW5
 VOawCfmBuqRD6RqsxWBm4GoinPP6xwbpNWpyJNDf1PlqTQg+z50BfsO45ulzGTX9iq+O
 vPBBdxT3dz6D229AkBelcKyIMVQOzZtN+rmoKLiW4NCqYsB2QmD6pLGA4hPeEvNBsCb2
 Xx3QuLyZydH+g6NhOj4q2gv0x3y4QgXDlQF8eT5ap5rqQRKMNg3D0t0qBjfRGkqydbbD
 xq+g==
X-Gm-Message-State: AFuF++k1vTSGJ64nUe26FOLVL4aAHQIq27RFdWgHhj5EZf3lUCMtkzjJ
 KuFPh0ixG3KSDGm59gwRnB3MZiblWiU7ZB/Z0UHn9TnrJXJ/sKm67GpXtLwbKT0cdNU/FqP0WOK
 r2oVyvPwFeAYnjR0kK5YLs2f1OQO7BFnZ7rwusOzMEz0NsDY1rEfzzOtXSFB4NWdm5A==
X-Gm-Gg: AR+sD133Luut/TMeJVtcee2L8iTObRo/r6XEfWFl/W6HHY4irzpGka3fZUQZEO+bWKt
 +3wUATF5eqFg93jI2C66oCgf3NgpoDyhinGfKogxsFRdIAUf3uFU88KuZglr7BCv2JiMk+zouCf
 qjIEvI6e3p6gh/YjaM3Bj7Ovlphg7cm60Qz1QE3MeZKE7UsFAxTtZfLpZJpKKgfXqjvmcOv7HJy
 A0JIkgRysPRof36zN4CBnZVbnELDcUJpNzP4bk+ie83t8MYvGH5hDBh2RhjglDi8+5BMYr8W9Gx
 qy/Vy2Eis/P8kKW2+ywA8CVh5kkRSnvwmobxspAPh+3rLwK4A+5AwfCE4gwxUmdZI9wSlT6PVBD
 rN+sBxEgDOcZfXmLAuWftt+beLphHFMG6vHWpE4Q5jvU66i4TowLGKb1RSew=
X-Received: by 2002:a05:6a00:909e:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-85628893892mr4725463b3a.3.1787868445036; 
 Thu, 27 Aug 2026 15:07:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:909e:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-85628893892mr4725352b3a.3.1787868444498; 
 Thu, 27 Aug 2026 15:07:24 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm2523713b3a.44.2026.08.27.15.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:07:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Bibo Mao <maobibo@loongson.cn>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Song Gao <17746591750@163.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 026/105] tests/docker/docker.py: return error code if probe
 fails
Date: Thu, 27 Aug 2026 22:05:20 +0000
Message-ID: <20260827220641.84885-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827220641.84885-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX9kJBqdydvta4
 peHJkLG2j5m3pBrYOYoYilfUp6qS0UiJ4ZTpU7pAgHHgm02m7hbOInDgAHBNXrcN7nsC2zLoO6A
 VLIRES37DEdKh7XPrw46YFQwEKs3VQg=
X-Proofpoint-ORIG-GUID: yR1nOiL2WywMm9Rt-RhXCVbcu10fOcI-
X-Proofpoint-GUID: yR1nOiL2WywMm9Rt-RhXCVbcu10fOcI-
X-Authority-Analysis: v=2.4 cv=G+Ms1dk5 c=1 sm=1 tr=0 ts=6a90b51e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXzh9yGWec9MDN
 mYCrUb54J38cc9PlKePWeg9PXEo4BsI+joMcd1uNBbmwZbfeQklDuR+aAhc3y0eOBNoHBlIUn/C
 0QUFiZXdV5e0ROAllF3rnypfBJ//J/O1VaB+dKb3DUCAXd89wfHLx6V2nPvm9y5NHE9ynUhyucm
 +61/5taa6EsvQAMyrl4fCd3bTok/9Oh0JU6VB5gOeJf63uwVcUAfEG/CrpFe8UmccloxXEqjo3/
 LnxFYChJq77FrRaEjac5UEWdX7+3285wOkwEKQxMS8S/12glVzZ3TobzmC4bFefFbag/Yrp9B2n
 ykn+P0cm+yj4d1qX3csS2owIeaQAI5NHq2Em1dR2xtrlGvWJ4+2ksLhqyQuDkBnRE0fECrFE0t7
 S7dIsa0PAwY+pZlfNpZCEdiXPOD7e73SzVC/K45yVQ84nZ9EjI0SVLMt1lMqM7AwEhPk2muKHTL
 GTLKtpb2NPRgl2VpFaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
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

We are not necessarily interested to know which engine is available.
However, parsing "no" as an answer is not intuitive, compared to
read an exit code.

Thus, exit with 1 if no engine is available.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d2f39b5645b..fea6d0f85af 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -604,6 +604,7 @@ def run(self, args, argv):
             print(" ".join(docker._command))
         except Exception:
             print("no")
+            return 1
 
         return
 
-- 
2.43.0


