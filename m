Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13829C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMw9-0005fL-Tv; Mon, 13 Jul 2026 16:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw8-0005ey-Aw
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMw6-0006PB-H9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:32 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9PCE2256696
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yyvOufgw5vl
 YJMYqVC2VCpbtXOUSPRcyAI5xWwROQpw=; b=VK/P0F69Gnc2LiENh0UQv99N7W1
 cccG/Hp/NQvG32qWW0/K0S5J1sTZZ5hnSeESGlxn1LwtFRasD6/DNsONZJbHGtI7
 kAab4zh3pe/fw98SEavUj8lgmrjdAKX1YPnP3cYprVM+OvopZW0VzBgphGzcJFeY
 qi8118N0H1xmEXcHw7JhlVqHB+hg74sjQH7tW+yENLaEypZyE735fH7YGGnMgCKW
 61tX6L65hYjjkEWSfGXMhTBPLvkP6eVxFcNVkxPr3IowRN5YvULgaGDE9vCfOiHx
 0aGeUDJizoNwQkBvO4D/20ZdCguT6T1O0VEDP80dtFflO0ep3qWBdn29s3Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tdw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so4609013a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973248; x=1784578048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yyvOufgw5vlYJMYqVC2VCpbtXOUSPRcyAI5xWwROQpw=;
 b=HrEal+HtTN/q8GV8r/AbyoFJ7krK5rAStymnHvOLZ1enXnCem6qA7KipY22yTmfPxr
 Sq8vR/6OyyzSi+qJ0g04/XsQAh+ItG+spw8kiohiyoV0rzwYyAfYr+pm2JRkR2Y7Y/eF
 RxpWOTfQAtnHo+Q39OKcVJma3BlSWt+zvoSFbSwAW7cP583RAwXt80T63wsIJtW9FdQ1
 OfdZq/qj3mf8krZgR9VsmCTjqOQuXWHT3ur07faXAXngNF5LYlUlywfThVrUdqUxxW+t
 Fi7M97xFfMiXuhqqY4x8+7ywEPYBKS2MyjdCPfPiSuESONxH+IG6LZUDJdGq2Zul9qxM
 p6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973248; x=1784578048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yyvOufgw5vlYJMYqVC2VCpbtXOUSPRcyAI5xWwROQpw=;
 b=gOoOOt8UJU2weCHWSqwBnYl2WnU+pJ/wjFudgwQbRGEYeW92k/EVvqAqpLbCxCk/ri
 q4H2Ek5OIXdkCLpQKuv6BBLLyqTWNYVjzgL79F82p0aJhuum/0TKH/5dgKnPskczUO3l
 IRWPrVaWHPUXyM0GTw3jQI7vaxVdaZ7Xle/kBO6aWvtd7cLCqKhpgJckf5F4U0x4Shjo
 Z0CTGFZbgySZAWrIcQtwqhI2wsb1VTIpEnSxGfObdFxgIiAcUfuwsb6NcT1yeQz38Mr+
 FZhfBr5uJa7aMFhjqnK8dnY1nQzy6qqv5vMMAlB+IDduaZNFv51yhdzpeeYvYF5CaXXe
 6Svw==
X-Gm-Message-State: AOJu0YxbeDk9vRCDoPt2VkrsbaMHcAjpIsBkF93XmBlG1tGmVfaW4g+M
 DBEVzNzdiJJg3cO7DFT8YiYuXpjqT5hfF+y2MCFq/tZBE/xnJfHtfWw7uqbkgDpj8LuzRUzcAj1
 8ZAx93mQznOYbUlB1Tai+u5v5X6WSVHa9ReIHqIwfDSdX4SbKCvDQFPNeG2wx6lnGx7Eh
X-Gm-Gg: AfdE7cmiwnuRItwTsFk8V6gRu+bLMXkQ/gPGgWBDdGNyIh3fEasgKC2GDICG36W/9Ct
 dgo12X5BY+DwCpQuCU0JfQxiTt/Z7EWyV5F2A5Bf5zMjUbYcmn2VrlVYR+F1srgrdCyh+Xd99XN
 TMthbkOmTD99vjGN/fMf1pp0mvmkW+8f6CJkGKlgJtsSGwSI6Nn65XGgC3eNUZAFknaHlsDrDRj
 Iezc6JbSWgbt1zsFeqQxceOSdeUHBhUoN6hOZkP0o/MJPD90Kfap9L2LTw0xUIYH2Ks0I388+jE
 /0WdDHUSRGPYcqu5dIoBboVS/dKxv73m+WzCDWn1fOkcviNskp/nizTmtnbAjiBIiscbGq8Scfr
 IWAPT/YCqLhuI7akNEhze/5bg/IwqGVApeXAb95yP3VxmJh2yEdqD0otZmf+CcVlJI1cqRCHyJw
 ==
X-Received: by 2002:a17:90b:5111:b0:36d:66d4:270e with SMTP id
 98e67ed59e1d1-38dc75d17admr9456266a91.5.1783973248248; 
 Mon, 13 Jul 2026 13:07:28 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:36d:66d4:270e with SMTP id
 98e67ed59e1d1-38dc75d17admr9456244a91.5.1783973247724; 
 Mon, 13 Jul 2026 13:07:27 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:27 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH 01/14] target/hexagon: fix get_phys_addr_debug with in-page
 offset
Date: Mon, 13 Jul 2026 13:07:09 -0700
Message-Id: <dd52bfe14af72beffce026a67e930b68dd6a67e7.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX8HzAT/tJkJFM
 uF9a5rsVe3EesFa1tR9bE407zQinWns1FoZholapcHyWJNr/vaX1r3snWX40ycfc4GC6WZTOKhj
 uzRcl2YosKMnlyz0khxqSZjNcVW3i7wMM7fdRubN1rqeNsiFJ3mrPOjJzixbJbPMck4My0CptxZ
 aleMkbdpz7MWpQKYAVIDGekWR4Fa/Hi4SHLlrWbRqQT7i37JbO4IkPJGqxt5D7OhwgKlhFFuD6D
 R4vFuB+bcujw2b9db6agv266BPdL1EdBPq1hfC7AAjHxseeEOAu+qByCA+U4AsRWDnLilSVQ6kq
 z6I6+7Bp0IKj9T+SpBi4vrfFZBq276Pe/Zk4wSrb0WVW37RBCoRtLxe6gycyFLlpRy1G5MNg95H
 5AOPFjU+rqsMC4jHJxhH0wpE9FLUyxNrO3J0x2wHzBPu7rs0rhsLTv+a3NihmTqY4L2DbrOXGxN
 cCF1GhpfyXVsR+EUSOQ==
X-Proofpoint-ORIG-GUID: 4NkPJM1X4QNMkeN_gctGpGEnK7x-XjmH
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a554581 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ERpe_kbT2-JOHJ70sIsA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 4NkPJM1X4QNMkeN_gctGpGEnK7x-XjmH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX8ZYOknA3PjYs
 kBlV8JOOLzIXSk8pGfjKtgCJNKJe1ppKiRKYlBcf56U2Gko2ZJ8M+1C3/CdgcuTQbgr9jte9snd
 Jf3t/RzAQGmSHpFWPhhzpmik9XSPahU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

As documented:

     * @get_phys_addr_debug: Callback for obtaining a physical address.
     * This must be able to handle a non-page-aligned address, and will
     * return the physical address corresponding to that address.

When MMU is enabled, hexagon_cpu_get_phys_addr_debug() returns the
physical address page-aligned, not corrected to reflect the exact byte
the virtual addr maps to within the page. Let's fix that. The
MMU-disabled case is already correct.

This would break semihosting argument reads when it is added for Hexagon.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 42d93e5da47..028cfe9edde 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -569,7 +569,9 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
 
     if (get_physical_address(env, &phys_addr, &prot, &page_size, &excp,
                              addr, 0, mmu_idx)) {
+        vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
         find_qemu_subpage(&addr, &phys_addr, page_size);
+        phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
         return phys_addr;
     }
 
-- 
2.37.2


