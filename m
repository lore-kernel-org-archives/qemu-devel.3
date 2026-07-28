Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4988DC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZh4-0008H7-CW; Tue, 28 Jul 2026 00:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfW-0004uy-FM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfV-0001cE-1L
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3abKR1527466
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N+XFmyj7niJgMtI6P9oae9JnIwd79/lXL05LMf47dp0=; b=E0jvtMz2v6ch2OZ6
 fL1dAKFMfrhxpYPQHLYMb+ktTFOgQK9FE6Jo32CwD1ZVysHL8pRJejXKl0v70adm
 55Iy/RC4cdJneG5kJh1I2feKmoc9ZOIDi58IN2XeQDMg8NlR/XKzfH/5mGnHJcFt
 sazQ5BD0uVjakkHceY0VkFqQpnQb1okT76f79RrR78KeSyo9147NOIrbsAbgdyOh
 k7X8FbEMn833+oobhKZ1OecbrKWWIV70BlCFMR1kCYBaNi4GW7EKpVwKR262fhGt
 fiqwWsFc5bEDHehgitpkAf3G77axE2Bm0GK9aS0FINbmdZdIzoZXeT9IGLZtfyzk
 inx7xA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:42 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso4244349a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213821; x=1785818621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+XFmyj7niJgMtI6P9oae9JnIwd79/lXL05LMf47dp0=;
 b=BbfalcxXRBSuKvToGuQISVX6uQP7hqUmtcPgK2hgXl34QR1Pdz5tX7TS72qy05O1D9
 BgrIji3Ie4IBHJNslTDkxp+PlM2Y8ZzvPBWxAXTm1SC9v8MM3Mc+Ma697CxQORgyNso8
 g3yZUlkmJuvKA/PFiXpKDI2zmzmeHWbU7yDL1/WhyGaqaOmk8PxZzrlhyzQCEgkzdpzO
 jIBKNs5NxgjejnBJYkAUV5b4Y31GXxJBYrDe/BjqqsrC72c3xd9yrzewhcJjS/l1cPBu
 89M/E7oA3Sny4IadSahy+hQZK9LBPwcBrtq+Vk7tF0mBoz52xYQCd0q7wQsNXy3OI8Hu
 Duyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213821; x=1785818621;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+XFmyj7niJgMtI6P9oae9JnIwd79/lXL05LMf47dp0=;
 b=JuXcCeEiR/OsitRgsxwm7CYF5rtGq+swlQ/Nwg92U1tmydTJOG0Cz3Fe0gqFwEelBt
 Ndq3G0s7rJCAy0da+AJYzMwNiZFFAjKfpZIMVvDbU3X5cyQ/keVs6xZAXCAyr9da4f9Y
 fWXCx8SPHka0wsNo4wSocynwc5LkJSOrKrzt+F3O0xbYBjIO8iPLX3RVwopgH8yQwbuo
 uqcMxEuKjy8FtMhYoWaV+lheIolF/m+K9QTq01EVgCQOuslpc2bg3ryKKFHcunXgBJPC
 /cRqRVRQR8mvu9mcmq1yRwL0vb6mA0DudSJIyzOiLgg9bjjQ3LGPxuQcUTOY3CLzuBfR
 gWuw==
X-Gm-Message-State: AOJu0Yw/HcFwH8J9bFdyySRqQprDEF86kwUo+baY6kK6lFEntUQ8Asrs
 Jwmno5Y+m1nkfmoEonm24QwSVck3zxus5K1FW3eCylPREiaIyIVSuksoNyhpEWkSp5pewjEwUHb
 0Blh2WkbUlWkzu1sDxvtGjBPE7mq9OGbDI1FXCZQne+vgEpqfbkHAljSPyaSHmWn9bA==
X-Gm-Gg: AR+sD120HBzTR2x11fEKdpqajzCudp0vw3ilQeNm5PfqDz71rB2n43Zc9U/iYZL+hXo
 ZNmrdfGJMGLx6GBO6ul/hcZKvFgIBehNNEE839Y24L6bCBd7SQXvT7UT1CpBolhFKzHUj6MHzhs
 6i1F9fG/yRFGGlrJ/rk+XbCKaNo/uZcO3/U+CT16LHuNjlbmPrnmrBCS9oyM8eViSMXeEKIrK9C
 mUoSyRxqW3Hj4gd6lN3nmYnHp1/2E7WGN0eqFm4T3Q57j/DyvG+pvrU0VyD+l2D38J2orm9t5VN
 SxcF1KZaooQppPCj0z24pYCKVymkvskpk8s1wtQ/rBSbHs5axDz+bZmSSkVo8qXEdnc+pn/lJwM
 NPAlWuBI+SL+JErE8tWJF9IZP4NEvh41qWne+WZnaXikxC1Kyo+8mjkNp7zopUirggDHnGjg=
X-Received: by 2002:a05:6a20:3944:b0:3bb:106d:77be with SMTP id
 adf61e73a8af0-3c8ba612828mr1055505637.44.1785213821108; 
 Mon, 27 Jul 2026 21:43:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:3944:b0:3bb:106d:77be with SMTP id
 adf61e73a8af0-3c8ba612828mr1055491637.44.1785213820712; 
 Mon, 27 Jul 2026 21:43:40 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:40 -0700 (PDT)
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
Subject: [PATCH v6 026/103] tests/docker/docker.py: return error code if probe
 fails
Date: Mon, 27 Jul 2026 21:41:30 -0700
Message-ID: <20260728044248.137626-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX0BlnMnUI61oP
 UXqa579/gwTEiiCedw+ZygMgm4blYkkQPb5SKbHpFgEaaOjlzEWcFZZTrhggEGJ2pDZtZoLnW42
 EK+gNpmxoNwcAVk77Hi73Zsy4Gbj9oGlA1pU5hckx+Biw43ROwsOXt+mt4M+qZP4nGSmeDgtqtI
 7IP3QdMpeuV+sis+6mMxeF0STLg1tLJZRn5NM/O2+6/AoFHgq0SAdtUKkWTt+iA5Y5xSVkspbhC
 s/gJnMyLQabhLqQtLPunMseoUpNYimDKUuAiG1euf9Fvl0ExLLAWTR1DdMcLkHlA82fyZ4vVwwo
 Rbdn200otCV5H2Y06YZtWI3P1j290BeJnZwwC+JtIYQVTmttu0Ktdw6RzDlscPcqSl+k5HUWh5a
 jQLwXZMlOm70atgeLfvo8vCyln41SoQtbbPI3f0So+xYRiX+0mByDrG54y6NX+g9VpUP4JIk2+Z
 ZD7h6jzXmFHxkBS8aZg==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a68337e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: T6cnxdocYPH1MiqebOpEIOlNfANpGzsN
X-Proofpoint-GUID: T6cnxdocYPH1MiqebOpEIOlNfANpGzsN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX5oLzCif8tLAc
 Qk+HtlnNrBq8z18gkFEDhX77gC4seGz6ev4bBfBFV8tSU6lfBFs9kfYPTSXcRGaIkft7QXwjuaH
 vTHXiW7gzS68TnWCLr+O8JXdSg6o+6U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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
2.47.3


