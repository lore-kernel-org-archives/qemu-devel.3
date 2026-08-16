Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9591AC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcE8-0000kH-7l; Sun, 16 Aug 2026 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDy-0000Zq-W7
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcDw-00020S-Jf
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:52:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl7vt2398177
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9+WqiaNjbQjH52OWtiPMQB3boxmC+X78TDrAgIexTRo=; b=b6ri+u4GKdYJaTL+
 N7dXCa5XmuUxOSXLk6WZM3pjaPYbTGqGBd//7zHiB45swRqRPI+HmoUjSEJYRDa0
 r++o6lp75Fkf8EIZUCqbnmr3LEf5p+XQiDCliWMI2my5BGuXNq36UbJUCkN9O4N8
 GeHuTzEEh8fWSfJFYb54rPhmnSyqqwZZfQPh66sgIxfcgd9Ragx+BOs3Ak6pgfI1
 rL0p9bpXa5zbeRsN1sAroXfuxahC0Wys7d5/+kV6uXzS0ocmVclh4N/REc16hBOu
 3ue4rImQTrwGe2gwzFZ68kiavD5avmD36YwRyEzuh6GgZN6X3YvL57gyUoXx0Vfh
 QutQ3A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3nwm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:52:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52d91cc174aso35868921cf.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891951; x=1787496751; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9+WqiaNjbQjH52OWtiPMQB3boxmC+X78TDrAgIexTRo=;
 b=AxYKWtRpjYaaauqgSy8hQFoXRcOkht0/bdV6R8cA+13H+prP45HH/SovP++riANa0o
 9uwW/8QM9P00jpv3iY0RSnk7KXoov78L3alDZFnrT8xGK8PUXdfzHJflF0jBARh0tCB3
 rwJ5v1W3cjtrQdqJOENr208DqfWv6C1Lx0cZUYK3OmgyZiJShCT2+yCqbXJzBJzyoe+i
 cj89Nnvxx1ldzOHLhySQLwRnFTf0KeJL3jXgwNrPWwrFqqQC3Im8OKdNykl2U3S5y2q5
 RibHVDoEyWx9W9hwKEG9TqO12/JBXZUuYGeL1rRoMlSpfP3+U3+uakguh/q7M4+O9VpB
 u18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891951; x=1787496751;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9+WqiaNjbQjH52OWtiPMQB3boxmC+X78TDrAgIexTRo=;
 b=UKF3MMcW1TKJeHKrRdC1IQZzDatoZIaetm6Ve/StZDWLC4t4+xKfmwJFEx2cbvhIwi
 HXPC+qiASiJKhGsA606ceSoJea94MtAL8ZEkxpw9ZlvWe0IN2uQqiS/I8kkTIDQ5HL3I
 9mOiqvuHAGs4iwv6ZshGG55aGV6/yKhJ8ynHs33u9T9YnJPXfrMOtSgheRlrYcAXf+RW
 Cx1DU8bqhXGAOrSfaaMtjBXPvtPH2vAD9CVE9bjf4haq6CGnMP+hbNk6SP9DatHV0eeZ
 cChPGq2uwm5+WYYBgJRq6Y8/NSEDi6oxMqJSCSJSIq/xBjtqmDZfj1BZXo2j6FV9qveB
 7xbw==
X-Gm-Message-State: AOJu0YypaNxX8d08a7d7EJLDvlVmQhLpEY0qrD5ikYSoNQC+QA+DJZwA
 NJ0/mXDB4VxjiWAb3LFzPi2RJhnizr6JICVMm06NhqMwL3qtcvugP5L7C4jGPKtbb1slsx6vUQ4
 shLawr0O0Ni83S2b+QyZedho7JFm/MruOluHjklN7BWbD2c7OsiQLuWDQ+hIpTojn5g==
X-Gm-Gg: AR+sD12KH7/q7/5UOuB+0gsSfx9OucWFbyOW3ajsaos6VpHp6z4ETW6OtonwwdhXu3a
 BcQQb0TA3i16M6K/GeIiYeH4J1c/cOp7fHFHZdo0wp4yRzK3lXraNmskYQfpo4VZQyBGchMYO7k
 hFExX+AKwafrjbG3hLAP6pwhmR4IYfo1R19hjn7Jpd1B+bYSdC7yQct1dakD5acWrLfBmMgmDIy
 q5tju5h6AMMTnbU9QNJO/Po/+Fed9sapPjpCS6Do2XQUS9SihOKBj00krvBWSo03W5HgbYT8oQj
 g4c+jIfvLo0JDF+m7HwL4n+JlPbwkpALxRdVpXWVc/jAJZZ9e8ne+G5M2HxMb+0Vy5AVD/0cjJs
 qaJdFqihbfxkyHN8LV7Nf7Te6QJwXANLWzhORu14tiw==
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr234300761cf.18.1786891951129; 
 Sun, 16 Aug 2026 07:52:31 -0700 (PDT)
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr234300441cf.18.1786891950747; 
 Sun, 16 Aug 2026 07:52:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499961098cdsm66810015e9.6.2026.08.16.07.52.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:52:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 46/56] monitor: Remove unnecessary 'block/block.h' header
Date: Sun, 16 Aug 2026 16:45:45 +0200
Message-ID: <20260816144556.69009-47-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfXwbSq7CB2/QqY
 WvekK3dEsSBiHINj5ogqrQu5CF0JVsfeI5cbL+gm585Wy4Wwp7fBTvcoqdrTIF/c3DbkYAcp9Za
 UHz9hA557PQH2cUEkM1fnx6s0DuwFw6aQNcCR9qNaQuLyeUrLKk0bvHZjPtIUzF6hBKgyS1v+wo
 0GBeW0rx9qBtFZTpCanlitBvJdSk9f+wf45K0JC4U5LoDApikVvfXiyAc+y0szS92nqstvreM5s
 ZKjnVGT6h6oWvcVKMdd0N+b3zYGXk7t6OqUK1vHRh5ors69P2DjrK179NNwF7SzsTZhNNqtippv
 Acaq+nFwUVNI8MQel207zo6ZNFuvjDW6GX1S7GJcj+h8AJa//KyMy04CJN996/okDuzwmiKCW0+
 Ty8HrGGqsur8qqqqNjxk+5xoiHsB3+TObNSRT4EcFHuccO00BiclXAk2aDHtyLdtUSVall0qqwt
 ANXTV2uxC8ogyAb5L5w==
X-Proofpoint-ORIG-GUID: ozW30WdICWR16ONzfeMBMOv48daDujV_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX862TfZgwYXyg
 3QpIDI7xE/XUg5QTSSTfx+iCKATmw7EzwUst+QoI1MVVj/Cj69vYGjWYF3ILSJFHFSY7a9ia1wo
 R46A+VrmohesiJ8nWkROqUqUZxEao0I=
X-Proofpoint-GUID: ozW30WdICWR16ONzfeMBMOv48daDujV_
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a81ceaf cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=hs6llZlkumWZFO0I0y4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160119
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Nothing here requires declarations from "block/block.h" anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260812211708.92824-12-philmd@oss.qualcomm.com>
---
 include/monitor/monitor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index fa9f4a8a75a..fd98ee2c71d 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -1,7 +1,6 @@
 #ifndef MONITOR_H
 #define MONITOR_H
 
-#include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/coroutine-core.h"
 #include "qemu/readline.h"
-- 
2.53.0


