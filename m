Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA2AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfiGx-0001FU-CP; Fri, 03 Jul 2026 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGt-0001EO-SB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfiGr-00023Z-K8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 14:05:51 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663HiOwT695391
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 18:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=; b=BjiETFJw7CQIxKeq
 nlFWanOu6WQkCijuM3lN8FpWkszKsf7eAZvsqLDPGVKLPrcQT1newlbCbMDMq9by
 3gR4CEKDt8uvmtcZuXsa+iT09OdlOdQMiMQbHlGmlb/fGklOswGS2T+pO6Q0zY9q
 Yk65Bb/dhWKbFBet3quKMi9NyPu91Aiw3fNj6cVczjd9l9sWUVpwjKcPgZwKqhNr
 evTSmQnrrhfCR/G2WWlAGjgfZYcAPRu9iYmIukF9oHBr+PONrLjqZGdSQ6MWI4lg
 tWRvTXLkm1VsbNDWnSO+SxTCuZLhVezVGz//qcVRnms5V5ECr8aDBCZR0JZ99G5q
 iPqxQg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a849utt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 18:05:47 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so10260606d6.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783101946; x=1783706746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=;
 b=cfTrRl3qSoWCa9aAXJSqA2LZU03bf9mcAuAQZayFlLXPIKGcjECoVsLndYe8nYLT23
 hVt1nHt6hEz9CRo1hJn1F6c6lY7o2DUwNpMcdhAN9DmGN2mKhZlNbyYFAFCWnWgRM4+G
 vu8wjBKQxRM/flpPif1ySpn7DqHYd+Z+WO19V39oHe2XergsBj0z17CNKG70/Ek2FfdS
 aJppQhbKNXm5b9GmxywaYRXFkg7M2tvKYG8ib/W5GGHGfIgpIaxEgyPpLXXoKQpUudiz
 Iw+hwIPHmzePIeOe3zkr+0Wjwn4bNMG2B4GAoBsKAEiKLEgysuyz2eSYDvDy3LLK5RM1
 WCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101946; x=1783706746;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=;
 b=iaPV8mnhruCXGePxWxui1tkKUR3LgOLrqy1tNOL3wxx2hfT9F/xCm8LEsjWEEG+LOO
 GdtZ4vY49y0MjyaOpp6XMx8zdymnbUVmwWj80G+m3afjMpXhG1UiimrJago2IEEZ4+uB
 LuEOgRst0wq/kwYgD5PaGQ5SrsR/I8G0Yez0/SQIBt/A5JlvnK7mAl+rQJ1Ccny7W/KP
 46Yab0+/y2CGjNCevHCpCf+68BiT45Tr4nY5S9WR/OwIxoT9saigu7ihd3LiqIn0RGN6
 zxB1UBN7U9edEI+wak9/XbRtQyFlapwVPWi3Gb1Nn79n4QAWVf/70678qwVHt07+Zic+
 lXRQ==
X-Gm-Message-State: AOJu0YxQ/Py6UC2C4VGJ/mvuozCiQ/lHXtp2F3kuj2dPDIL5qEzD2xS8
 FRzFnEp8F97cukxh3VdViEpRRyxvVuYyVMAi1uXUbmVjLxpTSmp4dCtui9Nbk0NQZZCVWSAeUfv
 Fu/qUQ6jmTFFZzcuPchA/3VFH7y6QO6lMJKpFhCJ4fQkyA9bE4VdulI5l1QH9DLi9FA==
X-Gm-Gg: AfdE7clLKkGRqDzSVTgfsj4dguq5Rl/6fOxhJP+GeK3d+AN14Q0DhQuNKWMHUAvOtAp
 N+Y5rF/DRv376R9iNGY1HZuSavbaexggGd41VgmGku/aK3ueYO/ro4VB+mmWkRNF92VbpTJ5nxh
 SyRwkK37GJz48KwqxQPIYZOn1tqapFC+IifUq+Jgmzk2UQD7xLlCQknA2BbmfgOqseIpofjkPG9
 habU8/NBuXofsS2Oh6B/WHnHm1f2uzZvWOWG6Y+VpiLkUIpvhm7EyS6HTiO3v26oaCP825+lvFS
 kfvXJffgUyZbgEhGr9wz/JI5Kt6bWqYqXghInniKNprwQ+yuOjifWrf5rErzMHiYfFrTPjRh8kt
 X8bLILHnO33FjDyUq7zq91Bvs3WhqUrfLoa9JRLt8GG4heg==
X-Received: by 2002:a05:622a:40c7:b0:51a:8c9b:6496 with SMTP id
 d75a77b69052e-51c4c3851acmr8126831cf.58.1783101946422; 
 Fri, 03 Jul 2026 11:05:46 -0700 (PDT)
X-Received: by 2002:a05:622a:40c7:b0:51a:8c9b:6496 with SMTP id
 d75a77b69052e-51c4c3851acmr8126151cf.58.1783101945966; 
 Fri, 03 Jul 2026 11:05:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2d688sm22560081cf.17.2026.07.03.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 11:05:45 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Zephyr Li <fritchleybohrer@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 01/24] target/riscv: Remove unused tcg/tcg.h include
Date: Fri,  3 Jul 2026 15:05:13 -0300
Message-ID: <20260703180538.3346781-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
References: <20260703180538.3346781-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DZd9us3xotooP-aLG4JdGU5Kz1ochRB8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX8HmvzoOwdOvU
 RD/m6BFZJoEMQ/YKewGdlcR6zan3met0JXaBV98TY4+Vovb50c57cENgIGiNXvaoYjMkI4HZyNF
 gMzo7UblW3VoZwRqJJZUYZQlWUnfC7U=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a47f9fb cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=beEPI9FAKrdLFu6WGxcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE4MSBTYWx0ZWRfX+0aQgO0H1Bbd
 pl57AFobsQ0xZbM/0CDNRBDS7gj7NxuFWQg/xxRyXd7NmyyW3tzhETsqYcjLxxdJJQ+t8glULto
 JuvcXsWorNUt75hy/Lsgqs77ulozHjdP4X/NufjpqL7pa0QK5x305+jGlfVlpBLu4wBVpYGpUZb
 wmo3ouEYN61ns4FQDxLC9zkUs8gsVM8mfVDbFj7EiNd/XsAnH3HT/odvIPtuj0eAfSnP0hX11Lp
 Kt36tYUmpIlvqzTJ01dmVP/5/iwSwSoueLbixJAcKaQoGH4aE/3q5aE+RXczSezMheyO/r+Ypvb
 ytegHK3oPru+0FzGK7b7Pvzx1ZblEgzqsuma4nU6cSwWeInaE+1jK1lpNQ4h81sMQxfWP7uGs37
 GBVwv4se8psNOAiSFvCbs9J68IMDi5beSeIcF86k8tEg8bNRoiDNDcfjIKkG7NSj2vjr49Jp4kg
 vIifpuTzOkDR8yu6v1A==
X-Proofpoint-ORIG-GUID: DZd9us3xotooP-aLG4JdGU5Kz1ochRB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030181
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Zephyr Li <fritchleybohrer@gmail.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4d2eb281bf..7664e686fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,7 +38,6 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
-#include "tcg/tcg.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/debug.h"
 #endif
-- 
2.43.0


