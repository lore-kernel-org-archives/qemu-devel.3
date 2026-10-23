Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05046606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBDPn/RS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZDyFqyeW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHwJ-0007PO-Kf; Fri, 23 Oct 2026 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvl-0006qM-3j
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHvj-0002NI-0C
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:15:44 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG2p2g3228243
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VncZoTQlrUVdzYLn7zRmM0fOXKc3qUJbQhDPlG4NS6Y=; b=WBDPn/RSpfDogPQb
 neONjdH8FzG/b/Hqdq8nFiHw2XjvDeYp60XGOm0goL21PZ+N6aue8z4SIgRZzKXG
 37x5oDhatzjjXgHTduXmiDrYF9PVC3BhREKV5Fta4CgEDx9+LR+9gmRR4tiWIRzp
 ZWRELWH5IK+P6YXwOrO92Jqnf9cW3GPfya1oXNg9Bl/fv32mJg5j65EFP/9j9tCn
 s3BuQYDaI9J4lpEmtI91Ft9rGDlFRN0P0ObdZQqVPcmJmuof8GH9+F3KkpKjeX0Y
 vI31PnDAj/225Y5tZu/O5MoDy0RUwuNrZwqrlZ+V6HzG4a91EEWgLzqTEf2pTqYW
 GqlvAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart01qu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:15:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so177232185a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772141; x=1793376941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VncZoTQlrUVdzYLn7zRmM0fOXKc3qUJbQhDPlG4NS6Y=;
 b=ZDyFqyeWePTGbsWo1O/Vu7EESP8jtK+8azkHSULXrJNdp5gcSh6DNxlkOVb1NOnDU7
 HWL5mlLs2pY2UlpfSUpC44SqgycHsbWj+5j+zydPOBb2NzmhvFs1G9Cd1VxyX6ugQ13v
 1oeuzpGIPcQUV1QM7GK6bfhFP9iuIG/TYOCcshQLJPLolTaRqm2H+03NSwM0JRdOXPo9
 YuJVhU/elixHixTRRmrCgdYX3iiUQsDPNyl6FLmsdbi2AhciFLiDtyoHITHSOCcDA25j
 bvJB4u0h7NPw2Jhazq6Nn4VEALgA3Ktwmz8AcobktRn3VyKrWpVlELCWz1LevagUje9B
 aQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772141; x=1793376941;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VncZoTQlrUVdzYLn7zRmM0fOXKc3qUJbQhDPlG4NS6Y=;
 b=JR4dNtoo93QZL+qTkMDHDoG+RioOpgJONXVSnN5RQ5IbiNLjXTmFN3CvQr8rmVqPt9
 a0glL7K+QP3Ca3MS0rwQKjkUyW4Xn6LcHE2QS5YtgGg61xhV74+Rvq2DBn0iSuey2HNa
 pE06/xLEdmAN5O/6xeaRoGTfoUgKtEMcNVpbXZpTyKPMiX9lmKepzwxFv9NuaskWFu8j
 b2Np4ZDuL7Ltga3Ge3Z9l1MkXBrZ/qLrfu2A8qATq0+7luee6HRB4r0KYnAVEUs926zX
 y6I/joO9orQtndYwYic36dWYU3bd6UCqb1++fE7ugwhpjTZe7GBQ/G9KVuYE32bPMJ+f
 1oeQ==
X-Gm-Message-State: AFq9FYIoEIpqExkC4eRmmcTu7JoAFsmn41UWNe7mvA8DcY2qKoOMn9zv
 /l3K+g1wjCeA5Tm/bM24KihfdjkIr4IbgJv2EOIlqf4SFkBjFw8cS7j1o7maqxFEK/TtNQSqwZf
 LL/BmR+r6SjkUCl6GEtkxWjspLFSGOIdIhVeCG37hcRx42ndWDB7OG+IwNoNWwj2b0/mM
X-Gm-Gg: AYBFou3xmrWDMPVJ5D0x669Hh09iY2V3kSyj2QQrENpOgP+u2TRB7Mm3ieDsqJPokcL
 C0ZfL55WMj/Zj1aCL9PBFoljoxIRHnvBxAIqAV13mGThYj/W7hCsXeWzqZiibwfEIINid9KWlTW
 jumXm7z8tMjAApdeKrZJcbiLU8PxeilAja1uEpRsCf3qmACn9+mvdvmYZvjed/FkFsnPO44SvzS
 UkvSHXQ7NzmiGLlYtx6gVYKwI9St0ySCCXwu0DT6u4QJPuzthQMrFGAoJOg7juJhjPFGNcegAcT
 CBZP+tB/0Aku2skdMLS4HENCqkT29KNDlWOesfu5lFW7Cw8f8t+BEvYbmnWpuGCY2HjWWd7sr75
 RZlkhU4MaDey00D/qkowjUvrq/q0NubwQhnx2E00b
X-Received: by 2002:a05:620a:269a:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-93f6f91d456mr520065285a.24.1792772141238; 
 Fri, 23 Oct 2026 09:15:41 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-93f6f91d456mr520059885a.24.1792772140750; 
 Fri, 23 Oct 2026 09:15:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d3f0b8asm770601f8f.11.2026.10.23.09.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:15:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/83] target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()
 again
Date: Fri, 23 Oct 2026 18:12:25 +0200
Message-ID: <20261023161332.60153-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX+V5rtAavqRZl
 AULK8wm4v1Q5aQ8TWTaRjHiO1H597c7sEYYdZPFSmH21RBQwOLWiSZTKWain89BcrDlL9lNN1sh
 idMjv1vbIaVdmhZZZSuvMzC2P6wbvgcBMfTdz4Fi54Vmd4A5OnAQf/mXYicNSri1i8V8LeUgi1X
 kCJ3hHkVoE9sCkT4yn83AGFTspnSiyxuDSV1w0qGNfTGHXOLsZdlQYpOOAjrwGEE3tSzDAGnXjr
 ti8lGSLQQ5YTDclaZuf7SyN5JSx3ZwykrzKxDDEK7WOT6Qmy2MpcA21MOCQ3LfRVyXLCwXt0lsh
 92BnQcLG0FqZVMykNQg8wrKqtladaEtNCJ5LQoa4b4a/dSprphLAPJemINMa0rCQ5MKq7KNZLqK
 YkcUIzGuGKwKUbymSpRWrrquqdfX/EVD6lUHNmZtzrNuA6115PazOBGSQztOKEAiOnAdhfWKMzA
 omufvp5w+Ki51X3RUDQ==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adb882d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KOFfYGMdUDr6h6J8HrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX9PS5UaZSs+bx
 SrnMB1IFq4SBJ3b7rAk0+OfnhIXkC1YR4cgcmXNahC/0xJvqqVcnAR+eT83tTpjOFLjHLUEBLMv
 zni7ghqe8q3xybYe5vkHdwjwhFx5v/Y=
X-Proofpoint-ORIG-GUID: rprKZR_VpA5Dcp9W_OYDM8-21U-Sn5J6
X-Proofpoint-GUID: rprKZR_VpA5Dcp9W_OYDM8-21U-Sn5J6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 780fbbef2a2 ("target/hexagon: gdbstub - Add sys reg
support") re-introduced calls to gdb_get_regl(). Since
Hexagon target is only built as 32-bit, replace them again
by gdb_get_reg32(), similarly to commit previous 7831e5f48d2
("target/hexagon: Expand gdb_get_regl() -> gdb_get_reg32()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
Message-ID: <20261023135336.49641-1-philmd@oss.qualcomm.com>
---
 target/hexagon/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index ca6d4a98369..85d9845cc94 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -96,12 +96,12 @@ int hexagon_sys_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             val = cpu->globalregs ?
                 hexagon_globalreg_read(cpu->globalregs, n, env->threadId) : 0;
         }
-        return gdb_get_regl(mem_buf, val);
+        return gdb_get_reg32(mem_buf, val);
     }
     n -= NUM_SREGS;
 
     if (n < NUM_GREGS) {
-        return gdb_get_regl(mem_buf, hexagon_greg_read(env, n));
+        return gdb_get_reg32(mem_buf, hexagon_greg_read(env, n));
     }
     n -= NUM_GREGS;
 
-- 
2.55.0


