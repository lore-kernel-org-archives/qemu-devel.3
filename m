Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BFFC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcAp-0004xL-IR; Sun, 16 Aug 2026 10:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAh-0004Za-Hu
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcAf-00012W-Dq
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:10 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDl48D3449783
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YuWFBrxiGzUvfPEtcY0H/fClp/z0hLFGaXj5dBbppCM=; b=HyZoUVpXbWk0h0Q8
 ttEclAOjI3uYVajYOWaOv0M4YndX66tW/+nSdS/zfGdtbBjgJusGC/VYQlPZ1DyJ
 BsB1hbUnMPYV0pPz/B0nw/aaluxky8SJXbdw7++Myxm9+/BWCSY1MPObSf2N3SCV
 kOqvPjv8CBWzJJ0h9po0KOAjmbeY/PwHQsO3MZb1DaFJYX3UAFQ68frrRQ6a5DPc
 jdeKwc3n048tNdDL5YE14N1NTZtgeYn0lnam5776iVX2oxeuWv6ncj8iBippXkdF
 tO2Cn3EbW2M35iKtEzHgaqszot70JkvPmkL3WDAcpVabCNCWfWBnGBW+xeDOBcLW
 Bb8l1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghk3mtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso23446171cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891747; x=1787496547; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YuWFBrxiGzUvfPEtcY0H/fClp/z0hLFGaXj5dBbppCM=;
 b=FgZ87zsOo/v45NJK6lSULqZIWj/uca6TFVpdTj1DafWs+w1Asw89032L7hQzsdjn0g
 ykDMwPMyiDuxMol0+AApFJ5bpDoVg3UU+T9tpUktdz5Q3vLmwRqQI5+PBfVu8c6aHBRU
 8dCSjDPmKTZBD087i+vt+mPDq/DZG+AZSRg3tx0ek/K4VGHi4xw3Pht6WiyinC/IkMKj
 QktrEA0q7I4uXlJ5fCqA3v/qzFXPWrbh9hvAeDA2+IBiV4jRSH/ihd6aHz9O5Q2+G5K5
 9x0yY2VzweZhj4afjvW8e1v+0vBhpuoLmCwMfH3uIn02v2NXn2FLkOZ/8VHiibnCa7OG
 +X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891747; x=1787496547;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YuWFBrxiGzUvfPEtcY0H/fClp/z0hLFGaXj5dBbppCM=;
 b=n387iVynkpZCdt1bX8iQQ8H4JgQz9wh/goYNzTk7SvWCa585C7HTue0y6JN56tSqLE
 mdlCfsQ8V3H3918wvNQ3N/Mc28NIPlo7ygg4O2HM3UDMwZQeePCTHIFyEMx4K/Hj9V1J
 U+guUM9hdLi1CoQjUUVh3bBlJP/ZwxnbQ/snVgIUrQjMpMIylpII0ELkBrDj3MxSAA6b
 cKgPdzGmqaXgR4k1PCwzqP308EVCt9pujFWmeo15jK02IQa26W2BeXAJJVc2BHj4EJP0
 J0I2u5WX14ECJ/PF+On52aHpBHLhpvNcEYiOV3UJTsqWqjkZeDIwjS6FS9SbjJqdsNhp
 TgUQ==
X-Gm-Message-State: AOJu0YxlsOAww69LpfprjFG0+l64IuVnsT8LLsftkzqaOGQEL5cWV7Xq
 KzFlBipGCJM/+Lt7+LgrG2bJxMqZcG7u9LEXlPazU5adavA91hV+uinscUkIxjZt28mV1l25PaN
 4CDReBlvOf7tOqYfKtAI+8Oyde+n9S0ntZ182BKV/61lX7R22zCIPh6A2AdLEKwwGHA==
X-Gm-Gg: AR+sD12n2CwAhqt5lEta/Y6tJDU5IsER79fXazjlraKWj+NaEi35ITSbd5tuUOv5+k+
 WsCEEDPUMZ0i/MH9zfA2fnskQnk1tL471BBJv6hH4YAIgq3kguJJLve8v0hF81FG0ZYxhWaJfoO
 K1uC2qM5tk5ie4KX+/xZHVNGoomkG2pZ/fakQMUD5Hr15wSpahu8fFKu9Ql/snBDX072Rf63kNo
 M2wvHiDXZtmgIl7DIJHO2pCVLluaNJKuIIJ94dM5Dsp6jJSZJ9pLHXCjY0U1puxdGCAoJc3IpbC
 P1BeghFL4Vda9enmZAXGSKfc/BfH4ieosLxusa/zhuY2DEMkbYONA2MakhIXDGw4Lwr6a3332UY
 Th2HO61B/t4oeAoTr/uQdfIkN/Wrepj9f0LZCnfxgTg==
X-Received: by 2002:a05:622a:4c89:b0:51c:291:82eb with SMTP id
 d75a77b69052e-52d74b40a81mr283272301cf.14.1786891746980; 
 Sun, 16 Aug 2026 07:49:06 -0700 (PDT)
X-Received: by 2002:a05:622a:4c89:b0:51c:291:82eb with SMTP id
 d75a77b69052e-52d74b40a81mr283271991cf.14.1786891746581; 
 Sun, 16 Aug 2026 07:49:06 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996128cffsm47386945e9.15.2026.08.16.07.49.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/56] hw/cpu: Include missing 'qemu/accel.h' header
Date: Sun, 16 Aug 2026 16:45:21 +0200
Message-ID: <20260816144556.69009-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX9eNrK2ds2V3u
 tdn93KPsqg3Lj2HF9nML1DiKGluyYyzwMOk63IH4GotkSREPf5BPBB4oe1hIu5hrYkGPQkgC9LU
 XmDd0kg6yCYoea0wVDUwLPcyWsA8efw=
X-Proofpoint-GUID: MTdKgU4eCdfnB5O5EHI_ebpU0KVvGTAg
X-Authority-Analysis: v=2.4 cv=f+14wuyM c=1 sm=1 tr=0 ts=6a81cde3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dLWNzQe4hjyqgpnSovcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX24b2Pe3lHlOw
 scw4ORwc4HdJ/edhXYMZy6Z8p1VdVd6s26Xc/y2Z2kUfggCDM3EPO95yXtxA3011aq122JFnRNG
 mQnl13YpquuHdX1ZMgzR5eUJniW4nMTgQG0Bmookm/wy7iFRET7ilhE/u6+QQKYMvvO5x4RDZ71
 nJiD08v0mh+g7Wg11l/9ciHBNmZ0CyMr490Id2oKAVo5PtZWzq9pzqwSGR0QkMIId7VajFtz8v7
 FBPzYI+0JsyZ1IvHgc0cN8bX82XDBTKQgiSiWkJ2MYbtwIeuUy9Gf9SfP9dNsD2eCvD7tCIyvam
 SMBXRhvRQ+ua/IS4R064S98HWRV9ksPKHGjTCHYvpxpXzKOTqGrW5J6NL5zOjzLanTwRe2Kkagf
 dZZb8qi0Wxa3J3z07JyotnkXwQdxB/GDvk06s9RZzK48yTqwnLLrOKo6xBMmgBJKXdJPqJe6r3c
 42eKi14kI1FKebBT9lw==
X-Proofpoint-ORIG-GUID: MTdKgU4eCdfnB5O5EHI_ebpU0KVvGTAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_common_realize() calls accel_cpu_common_realize(),
itself declared in "qemu/accel.h". Include the latter,
otherwise we get when refactoring unrelated headers:

  hw/core/cpu-common.c:233:10: error: implicit declaration of function ‘accel_cpu_common_realize’
    233 |     if (!accel_cpu_common_realize(cpu, errp)) {
        |          ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-3-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f84..8c9ff25e04a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "system/hw_accel.h"
+#include "qemu/accel.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
-- 
2.53.0


