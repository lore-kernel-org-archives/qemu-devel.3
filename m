Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D545CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBvM-0007Ju-UY; Thu, 18 Jun 2026 08:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvL-0007BL-Ba
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBvJ-0001FY-6M
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IArkdB1608939
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZnijWLVZ2cqLcUf71H8csaeefEmDohe1sfAdJabvGc=; b=JLLv56/5flWUngfb
 Km4TmFsr98QTAPz8wMO6BYfSLb/ITNvS8Y+f8iN4S5Ho06kJEEoi2TY+UyD57kLg
 AJq+WB4L/EbGlkJTMY9MO+xtWKAGOoONYm5/2gGNudqtfyd8OlNmI0j+T0jWNyfn
 Nr+IkU2cfsRC9fqhjeXQj9zkUsv/yhaLiN0o6h6apq5/Ghycz1054sab3KhSdWy+
 +AeuvH3yI37ZuJxokPhyJy0J8j01+ZXs8KECtjr4xzqFijqc1wSXYRrq3HbeRD2/
 d6Z7RYqV8nNUig3Kd7r4t9HzGehKfZTW1ttOAlZ3VPH6X+CJZWxu4i2dZcunWdiQ
 yf8ynw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7kk4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:43 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-486660d2abaso1317813b6e.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785963; x=1782390763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ZnijWLVZ2cqLcUf71H8csaeefEmDohe1sfAdJabvGc=;
 b=ZWJuo8EUbHhVxDgfEa0DTlo8jlrif4svCjTbjwIyexWICOYfXzHWTAhb8kN6kqH0+V
 ha7lFFAhPn4udQcMTCGLkJl+AfEQOjqEccjMX24Bgi4Ky1Bhvg4dNKafzIVXbLbl0u6d
 3c9QVecY9/exzanVFKhtTNYJ264GZZ3EKE2P7ar3Ey1TJEzWUyd4aAlaUdrjAXBj/MaU
 c1FBNo8tal+S8stYYlJwcHBhWgZJfnC9OuN18zkmJu3UadnC0Z3MY5B8uo0NHcX9Jg8O
 aFcwpbFXFpGmqg3Przuyt0akVpHlNTaXvTipxs4UsyNp7KqB2dKiizHAVGhEMulf2nDa
 Rccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785963; x=1782390763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/ZnijWLVZ2cqLcUf71H8csaeefEmDohe1sfAdJabvGc=;
 b=CNmyE4qGT6YcOeu+UXvim8nsdXpsL+48w4rKvMIVNTHYr5ypJoAuc37pQ68jw0GmGS
 XoiNS53s2nwFGjGw6dj2ES3lp/2scEz32NKVturSPR2m2l6iC5x/IkyIxiQeued0qMAq
 pMzJs7qScWpEbKrRzoHeM9CLncXsFcOgnr5QxwQI4mkPPJdw7kuQAEO8T9ufZa/++s3n
 HlYpv6AougYq62gBg+ViGW2UMHL1mjRhsglXYoxH1OL1JKqf6eQKJZatp3hnEXuyZVlk
 G4RVKsguGf9SS8OfEVtD8LX/F+EJT/VNzrpFL+EnsPRlg08WgBV4VFpaRBWvSmvpCFVl
 fdYA==
X-Gm-Message-State: AOJu0YwcDRzS1BgX8XESfrUM515S6p2FwJFJUa1f0QC0VXlYkrwS8wmE
 ViKeHpakUOquyblYTFGqCRFy+Pucq8sWCVL/0HIZlbbo/cjf8NgM2SYGiUB8mGwcdKXZnA5z11q
 p9frFcBbvXXeeIdDnChH1Z1h2tTWQOmJBWRGSoimjveyxKL8m7gvbAthAWYBjveJJQg==
X-Gm-Gg: Acq92OHikkdM8j930Gp6+cOFlJAzZYl/7Q51FBJ2lN1StNKBE+9gGxX8eoOYx3KnXnS
 XtcmuReEAEBCrbVlGl9/9BGaSk6c8LIrIwXZWDjV0OwCqC2wj61d9K5mxphwa7hEBYJUBpqLSJI
 tmBriHcNatgtWzAJwBGR9CYdy6ggIPDooznmtlsuNNmpq85t/3K/yXe0cshc4Z4YbpQeaTFdtuH
 yYOlww65wGJD1A8pGeM95wIv0iaKBk+aEofGHx2pftXLPW2/qNXeSQQUmFv09aFVq4HowiCDJ6P
 Mdtuk0lNEltZg8Deg/Hy3abUh86VNojwWYusD5LSnKkm1LWmaPhRnphkOZUds7j0JsZ+pZs4LgQ
 oKLcVu0gWSRotTmSZZUPfZUzFx8bGLowSQ1FVkX+D3rRvCGMsXDdHRRjN5fGePOvllJPG
X-Received: by 2002:a05:6820:178e:b0:69b:94ac:da1e with SMTP id
 006d021491bc7-6a0b6036b1cmr6418641eaf.31.1781785963169; 
 Thu, 18 Jun 2026 05:32:43 -0700 (PDT)
X-Received: by 2002:a05:6820:178e:b0:69b:94ac:da1e with SMTP id
 006d021491bc7-6a0b6036b1cmr6418624eaf.31.1781785962726; 
 Thu, 18 Jun 2026 05:32:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d70sm63224350f8f.19.2026.06.18.05.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/48] exec/cpu-common.h: Avoid including unused 'exec/vaddr.h'
 header
Date: Thu, 18 Jun 2026 14:28:12 +0200
Message-ID: <20260618122825.90331-36-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX5Yy8QQA4KeWl
 nlxPCd0FvrH7bUjqfIoPU3NSoeG++kbGMWHu9ttSs2lbLR15yk+o0YUNsupORJkDhG/+x9cr7EZ
 CCkgGgEsW6JFXrm+4FBb/gI2UXcHQXj1je8J2lB779AtR1GrsCnhfZi3FDmPkwgpj1pNmpYkl+v
 cGLakS7MKNwLno871spOHYp/zkIcDqY5/6rE52f1Si8eAEkw4CHjnW5MK9rCXfBE1MAfzrdUtVG
 x2zxL5ObmvE6l+TiC7PQ17XfHStmihnNpye1iAYdybzA6xqv16LBThbq2M1ZEPxmradfDwjnQ3s
 VWhi/6gePY56quBDcpg89scJK4xfQ50fNs99AjcIz/tetg6nZW9N6o2d5ZGAC9jgqt6f2asCCEF
 lQ7r8DYaVdaJpw9XK1CqcQB22zhJFmE6WZ+xFUZyID61ioUO9C7s+rJv4QVbQbyv1T2hnvNCc7C
 jMtVr3pulXKefoCtqSQ==
X-Proofpoint-GUID: 3llvlzytzbPluN6HoOn9s1su-reM9JHr
X-Proofpoint-ORIG-GUID: 3llvlzytzbPluN6HoOn9s1su-reM9JHr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX8PryzXsIqeD0
 M20HJ1BCRfdc8iPMn06yBUEtAGmzVKWAhlpf6uQMoP97ALW+mGXP1rkbDJkcm3UJTS04T0B/E9X
 /wlhrWublznyzU+7Y3QMKBz2JuMUIC4=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33e56b cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180116
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

We neglected to remove the "exec/vaddr.h" header when moving
cpu_memory_rw_debug() around in commit e9048f099b3 ("exec/cpu:
Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and document").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260617160426.64461-4-philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8cddd32ca8b..7dc8cab3263 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -9,7 +9,6 @@
 #define CPU_COMMON_H
 
 #include "qemu/thread.h"
-#include "exec/vaddr.h"
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
-- 
2.53.0


