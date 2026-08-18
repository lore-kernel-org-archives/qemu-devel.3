Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C41CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPm-0007Fj-Tq; Tue, 18 Aug 2026 15:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPj-00070s-Td
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPi-0006gG-4X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGx2h1549021
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=; b=WQUlNdfib2JQkRoV
 ClI7B17iW4HS/xbwxs4gSvCk7gfouS4qOtX7nRzOC5pjmrVHvIW0CO76TL8BQWM7
 BKhxxA9lblWbk/oIEqyA4DdlY59TeU0c8e7RpXf39jLjUAHL+p7Dlki73m+1Izl4
 iffKOXwIza7i9YUixpvfDYVsaZYerpyvsYxqdjDlmGi8rvwedOJFQaN4zvOlmkkO
 hB7lt9kJHLsA3/XPRrgDVBDCkUXCk9sPc2LWtQ3uEK/tMchehoAfGAW43VlNw41x
 KpiUXVjE+30eb3vla4KaQLjJcL4V8DVUGJcwK3PekP3kGnFv9LgMZoP56PGlf5Wa
 92qysw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uj1gpck-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso2374635ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081036; x=1787685836; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=dINvZt9sOgB2x62nAMsjsnO92/S6PUtN22HX32mRTjHWlDwDUeN7AUC5H06zILDGYH
 hIzoTaTpzYYGDajHB4Ik1OGN2EMsMZrWITK8SJ2/7AuGGDLrV7rAj/MaKAHM84S8SVWF
 ufIugawedPCVj+HGkuljpzB0mQKCi8W4dOdLa/8xIMWlVWnscHzFbbAxi3pOKq+Pn1wR
 oKjrumYgH5L34jxF2/2b0ZGtAabXQvWpxH389mkIzy/XGkFrx/MXxJFaypfecUiMGRuP
 Y1nQ+W+to/5A+xh+dv1/Joz+bss3/ebwuLx0O169yuizREYYhia5/BuGeIub+i28kWDD
 7brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081036; x=1787685836;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTjnP6YGK7igY4faPuDs6OCMohdl1EcdIcvjs/2JPd8=;
 b=WjQwwoV14vraMfVjCzO3ho1Z5MYpAKQPzIyzABdGkiROPJsx/KQ7FMu6/b2BZium3B
 Rg4ZfJ/3wLp80um48rZogylQCWTmSujQmmxIfcFUVX6floqNvgJFPQgJktDIoL2N04zk
 bhMP9EMzadeEbJ4ahulZioTCUKuBXl0kVsoKey8QEDPN7KzuengknCnb7Ab7BoKaySmM
 uOweEGP51VpTi6VlY6lc5f1VmvBO+KW/4tPThCvk2+y5mjCqnU5vfE+3mqV7HULNykbt
 ayXouAO3uL989e2xJ45GrXbhoo2Jas49cDTMOxpZTBrBmjOJoSvBBrG6Hr7c8Ph0kjZc
 7J0Q==
X-Gm-Message-State: AOJu0YyfCm8N0lQvo0Lot7As56bC++Z5zoh/+bj2qkyLiTHDDUsN2PMt
 lVelaiXUf3OCF/MTIGBYDvrDawqd0vUesiQc+GmE7r5OyjTR1WjZA5dW2h/YB961HUJBv7vvQTg
 SvM+DaWmk1Sli2bo0sR5TuOCUdxJqwOGPfhogBcQcvwsx2yzny2/gZnO469xlXRebxQ==
X-Gm-Gg: AR+sD135Z4i4AYUg8N16ArhD8gdn/n6v6Ke0ycX+Xm/vKfUU/hKok2zFmlwqYBRFPgr
 w0aacWdBpgRMMAhmCa9/Q1ziOuo0uvKeLUawIXpx2H9Jk8BJFjI6SZhVeaOz0i4A7JWUHhVLZSV
 a2B15xMERpKUxLkkv3Xo3A0+oIdOvm/dxvO8e2SXd4SS5K6m72VS3yMFPFQPwNMu0KeUcHyls3F
 tBfSUBqxl4CbXnLBa+PVvDuQsgY3iE9WV6pynI7/i10Ggi/6qjrFj8EFHwUB5wJtOND+VA0zqsq
 To3D+QzJydBmZC/zemNUJhagMEU1YGZ/ZKzWtttlxiHKcx5iQaYzQIz57oMxc46OGMctLfPIo+l
 ASYorugyaMWbEGRBx/I4FUcUlCgpsIYFzAC5j+I5VsATszQIWj9oBHhnHMUE=
X-Received: by 2002:a17:903:944:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2d5f6b21181mr1848935ad.10.1787081035576; 
 Tue, 18 Aug 2026 12:23:55 -0700 (PDT)
X-Received: by 2002:a17:903:944:b0:2ca:d91d:d3a7 with SMTP id
 d9443c01a7336-2d5f6b21181mr1848015ad.10.1787081035111; 
 Tue, 18 Aug 2026 12:23:55 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:54 -0700 (PDT)
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
Subject: [PATCH v7 026/104] tests/docker/docker.py: return error code if probe
 fails
Date: Tue, 18 Aug 2026 19:21:50 +0000
Message-ID: <20260818192309.22169-27-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: M1doFxikRSAZwmHA9jUpqN4oJTe_hp3S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX/AENiJq4Ax9B
 GkGJR4BP6L3w7ZU2MK+ebnhTIAfRnKz4+HX5MNsI2tVUzkMijms+IURvcoG2OCPSpyq7RNXrAaI
 wv+K6uzV8ScukAa3/yR3wha0x2Ql0zg=
X-Proofpoint-ORIG-GUID: M1doFxikRSAZwmHA9jUpqN4oJTe_hp3S
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=6a84b14c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=27jwiZK16oKz2i4YsWoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX9H7p3rc93xIB
 JzhvI0FczXrkzfMB5Vr90BDlGKQXVX3j/aYCNMlxD0s0wAc2Qr8G65aXbPfX95Ta/o/VN3TWT0f
 GYkRv1YVEe9YPTBc/6tKj3+ant6KoLLXXns1xVygprdpmcsRd1HBZ+zjA0kxmqfkw9v/KdrFpU5
 sbOuIqATqbbmQyXgvdVqqfqDSK1tl3emGDzdlamafMD6kvhUJrb2dDEY/Yhn6rgtw39BTRpenql
 BJw4oJvqtH0PM3oSSJDswRgpTdQJYCF9Kb1mYu69ZeSIf2zFFea8mCIBNXqZ370VuBVqvdvUXYF
 n9akFK2PgDNcO4e1NkA1p+aI/QLYIXKRbzVmjjNmVxxMUKWbh5CtpQ2Np8gnPnxIJJk6BLyjFMS
 G6hyDmXQtxjkq85EXyrryR7c+20XDN7BFNRsHi5TuplX18ricDZNTspr3DSKt0HyI0AGXLA0zM0
 4QBwsqiBJSS2IItq4+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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


