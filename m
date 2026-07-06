Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7D8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgs-0004wM-4v; Mon, 06 Jul 2026 09:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgp-0004mf-IM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgn-0006xu-U8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxEZY366750
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JWKui+psW7jN2NrTTr/B6Utcfax1vmqny1Trqz6686w=; b=H8J9Fxch+Cvv8/Aa
 UcSeNJ11cAtVCb1miYNXE9lG2BAut83kagAwx9gcT4PXpilzjmXgzTPj7IBoyBW4
 jwYGHaHfrQv7b8W10+qHqztPnjWBxUG+6qacYPGrBmCprCB4Uk44cIPMH3AXFOUV
 XrBmjvG99qxjwHSHsyJPRwsD/cdHlBCl4fmWXscy9lMi1L6ud6KFV3oMQBR86LY7
 CLITljhYfN3uISkBsIblfpaUNIL6JgUrOCC2rAbArBiDyrEh2Rc/4v9qjodobuuw
 aS043ZUX9/3jNDxJ2EVZiQP/qaaBzOBbJ3bAirj5gjzmo65PbnDB2LSlsyqe4mOZ
 9mwASw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891us6nt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e68cb7a3eso564985885a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345727; x=1783950527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JWKui+psW7jN2NrTTr/B6Utcfax1vmqny1Trqz6686w=;
 b=LK4Hly6oFDBlfvprN/g6LcrlJEWGyfFE7HnXKQINJXEzYpsRuS6ruq37ofuQF2omJ5
 KZ/0dAMIy3Rw/YzCagVyfeJW96W0rEFeIu4ZEi1gwhllrTaIOk1D1i2/VI+pbPFnKzKE
 vqVuTyyJ30DUSDndERewwaUoSNi3oCXs9drscCw4RuqTdhY4+ed2bt2KviUReuyX3nEN
 oJYIW4uR4mtJ3pmrsBHgmHiKN68IhUx36SYS1y6cLsflrzeNF/5PhyA/dd2GQqPQnPKY
 AVSGBsRC77rNKUwkI78wdoAj5qEt/I9MiyOBZ61r8LkWpqfjXs5o76AGxT5QTzHC7cE2
 ZLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345727; x=1783950527;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JWKui+psW7jN2NrTTr/B6Utcfax1vmqny1Trqz6686w=;
 b=HYU1CRn72IVx3xyevy19wJdeOI1bKYg4Xwe98QQwRdBU1McfV5N+eGm6zDK4px8CUP
 ANEfpy4R7z1KgHfJsAY/MeM9HNTAqlwWDKhuprPqyNIWLT+4XcjXyEBrOmSU6ZO8lPde
 lZ5dEqr3XbWIpVtkYjw0esrUKXjLCAa/rtbhAbjbjUCbnhXqcLVA+Yt9wnzcnlGsPKuj
 KaNh2AxTPrPfAacvIiUvFG31Xk0DXAIfYia6mYllblsz8mSnByTbDgGlC+FilIfqd6al
 RXIRjwlbTCcLqMDhcERrTGnS2cK9+AI+9eY2CD6WLWecg3D/4HcU9cfipluzd43ctK5R
 pvdw==
X-Gm-Message-State: AOJu0Yxu5K1dkUPnZK2wxXFgrRbl0CWD5TWvTrQgGTLWS7xEa7Aa0FWW
 gdg/hXHn62vxPmEhgC6Za95RN1fMZJ6/R+5yrI/oGbVH9K2i2jDLgZSWEPJP5S5+cGc3+7j//IB
 nLdIey6IGrtLfcyGaggsS4mp9ntAAGdRlxOXxn8ileb7zZArqIdD5Ac3Yudhm5Dt5GQ==
X-Gm-Gg: AfdE7cn4n8pD7OVwvP2Qt8a3JGhI99RhvSCsVlna/9zG46lGb5Ofl9YfbyFahyA/rZW
 p7oJHoWBx0/WXd3tVQvOtGAh/pWpkY9pvZJlCuIUZHpK7SB54bXrE/TTcXzISvBhVOVtbwuci5M
 gf4NnkH4OeJqqWH8iu7x5Mhp9oJcQ3qd8XZ2f+fUSxmzy/+L32G1Cqi1jwlyf01leIqgJwzeGjl
 yv/oCj/WE0oDAemB6emUQ+V+5pbAN3YpITSCTJ7MevPJdCX8GruKHKYcSfd8a6sGaLnl1/2nV0T
 Srk60PgYtte3HTCUpwHFia3NzsYZFpGVAZxXnKTg7syJz9MM5eZFhByI3/F1yRUQ0YJv88P7vx/
 wEJtZz706r6jChj906+Ew4M15nY3J/6QIBNwpqVTG5RbgSkWqKqKjyaj8Dw==
X-Received: by 2002:a05:620a:684a:b0:92e:57ec:a4d7 with SMTP id
 af79cd13be357-92ebb5c05a1mr81009285a.73.1783345727481; 
 Mon, 06 Jul 2026 06:48:47 -0700 (PDT)
X-Received: by 2002:a05:620a:684a:b0:92e:57ec:a4d7 with SMTP id
 af79cd13be357-92ebb5c05a1mr81003785a.73.1783345726820; 
 Mon, 06 Jul 2026 06:48:46 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm24746903f8f.20.2026.07.06.06.48.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
Date: Mon,  6 Jul 2026 15:45:16 +0200
Message-ID: <20260706134527.84808-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5XLK7vvC71xp0Kt3b6sgOWEQpdK8G-XX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8Kcxa1Yfsxr7
 EaAyj4P+1Ec7+4vxeAK+q0fl9/HJ6Yj/bc12V+1pTpgFdlNSpf48oicGKkTEpNhaRVnjJHv7exG
 6xHcy37WXHzh8yMTEPvDj5FLYylFs7I=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bb240 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Ucb4Co1tYGy3ov5cU_AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXw9i4IrDGAo67
 8K2jWo0NB8L20CCnStmu7VaUo4kfGnPQkcbyg9pGdwpw3LpepyXPNtnNiewur6ecvAOjHfqaD6O
 6UfcCR1kfFeWzRzmmYKpRzDW33DS1RbD3w0R3gT6xLig35e72wvwlW0adh/oW/SS3oUuF6K3E2u
 cUNHno8xhCoYT+BaO9bXpjfNX0XK2zg4dJQYnEXEW2FtNiVZpW8NkNrteF9pv5Z8/Sm8ZsXBkwE
 B427lbnFagVIpUJs/49HzKdL/qnizqGTXhmVEopzhdr0noVocJvZ4qBF2zcHukjf4joQ7NSNUsq
 7I0rGgD4JmVHSsuVfq83hwmP7aZnYR6dRY0ol1A3t63v4mBxCeIq5nY08YRTU2NwfdFK5c/CW1w
 S9CxQFX2JWa1UR9HD+moyKnn+/NCzWv3A0zoKSSgUMX/KSC0q10waJFZwdT5oRU4R8JZ/cq59+k
 G6zdcqxeGJ2sns11uzw==
X-Proofpoint-ORIG-GUID: 5XLK7vvC71xp0Kt3b6sgOWEQpdK8G-XX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-22-philmd@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 927af6c1db0..1043fc61874 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static inline void tcg_remove_all_breakpoints(CPUState *cpu)
+static void tcg_remove_all_breakpoints(CPUState *cpu)
 {
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
-- 
2.53.0


