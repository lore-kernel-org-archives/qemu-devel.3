Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57B606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nu2hh29r;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XumG8tPM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWj1J-0004IA-FQ; Thu, 26 Nov 2026 18:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1H-0004H4-NL
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:51 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWj1F-00046P-7K
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 18:36:51 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJw4Fa060973
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QONOBStajQYCwKzBtGV4nyPtKNWDG/mhSu+eYFrVE2Q=; b=nu2hh29rBe4H6m71
 O1x+wDbmH6VUDyI1GLsWxoU1v+DbMeosG0Abww5b8GhaPuB0f3FViJsy7uO8VDVK
 HhpTR6qdN6dKH5m1964nYsGlZiUN2LNMU1lTX+xbFC0Cn5ZxzZe1MLzkIkUxetOx
 xFO2Wk5I5H5SWYxEUuDF68pHlMTQHqrM+QzhCsZuPR1167aHXQ4vIT/zrEmpUgvW
 Lb9lMoHEil82XlNdW07W3IpmyTWTacFO2+/GM/yQAAh1B2uvr1rZmsAvW5+g0Ggr
 7BGTW9flaiApOTmtPFyFN6FmVw0z138YxQ9VNMqrfdYUL1Bdph4mKGgc9mAOk4Lt
 LAE49A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u4hrfyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 23:36:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso1348046485a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 15:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795736197; x=1796340997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QONOBStajQYCwKzBtGV4nyPtKNWDG/mhSu+eYFrVE2Q=;
 b=XumG8tPMKcSF+HidebH2VRQSF3kZpUuv8atOPvGZo8u1b5s+qS+XImZqHsU6nRuuhi
 D9iOMk2SgxwY+rgUWR+pZvPHLrF/aLNXVpDNs37VBzje+OelcqNWKNJMsRXzAt6kziGR
 UjF7/KNhwr9A3iApYoHaaZisywo/taTeb5G/hmhP9/4a0J1mWNBus5YJHnCCVrYHiWZG
 a+K8HdK4/cpn+ApfNjTBsz6Zgitv5lxnKTZA6XJl7hklgrO2JGMA4aNX5Xrwr7WKjSJs
 QBeN7oQpSy0TLZT0JTESPyS8Yzj8JNjQiUyrvB0T4AB/QkTIN785IqxOA6pO3Atha7VG
 2DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795736197; x=1796340997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QONOBStajQYCwKzBtGV4nyPtKNWDG/mhSu+eYFrVE2Q=;
 b=jgOftqB/y8xGSDdq7MQz80L64CD+tvAqX4q2ao7QxL2CbtanCMEAYsUgkcQoLTwUd7
 tCO0ENPdmuDFvUjfGkwlCdNP5igikoNfZkY1YJD1NpEZTVm1RCJq3yUdi3YIUomArub3
 CEDss0kXfmoxVYhtqU6rQol9iZYWU6qtqhK4fxL3z2BLddVGj58Y3NwLPzfGG0ocLsoB
 XoQVLcbrMjuHMGZDtGza0FWu6dQwbLGuBaXzUw5540Bf3aAF+ORcTThq+6MyBk3YiDh2
 3h8WYHVJWU5oyjwLIFK2QjLndI3EfQD1VhCohjjFE1TYWoybWJGWYhlKsSwpasYciWIA
 uYYg==
X-Gm-Message-State: APuU4Z9j+F1ng3aScGYrrvlv5zHiqwj7dFLKVslIl6K5R9KxGN4Y2fNs
 V1ChoCAtl7V7Y6+llxaetMwxBDkkKRYvy2PScBCv24I93mxYsCg3SJ1yODeVH87XPy54eicXjMO
 N0Dq3b8dM2eJL4hFmdrhJWiWPIVpxNyexM3k5SUQAqJkFyYjE9iZkU6wZDPFRQjybfA==
X-Gm-Gg: AZFdTZeiLe3NfkLxrNKzoArgbPtWiwBrslLHC8JQJ2dIDckA7a/1RRTFRS+tMHQFCvt
 otXczWI0k+vey+nXyf8Ov+XQTO3/1yX7TiICcWmLoWKQcZubIkm+QY08qOkdqIoabdYIFWSUSm3
 4ZuMVyBYITduA9shOZagpmY9HdqjRNG4gNY1uvpBbQYGtPpgATuMcAcX2BFyEu1QVPXCNLgr380
 7gWkbdZp+qrg5uvSc1a7ECEHAEOHyy7jHcnNlGN7jQgZIxskPBb2cwL0DiPNrUfYEXkBBcuRpKy
 0s1VzFKvm/dDBvtJQLvsGeK2gq40Y9dv7ydi3d8GTS0YuYBZeFlljKyXe1vmGRTiL8B1iObCR97
 945FVKKKeaWUMjBgQrcTlhUaHsVApnnDfhTPGruWuvnlEYxUzP7b8YBlp9wgZzDo02A44dcpVln
 T88cw2S+zQd5RAiA==
X-Received: by 2002:a05:620a:2792:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-949b3402246mr4031067085a.3.1795736196880; 
 Thu, 26 Nov 2026 15:36:36 -0800 (PST)
X-Received: by 2002:a05:620a:2792:b0:93e:64ac:5dfd with SMTP id
 af79cd13be357-949b3402246mr4031063485a.3.1795736196370; 
 Thu, 26 Nov 2026 15:36:36 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm44575008f8f.3.2026.11.26.15.36.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Nov 2026 15:36:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 04/24] target/arm: Update TB flags split comment for 64-bit
 tb->flags
Date: Fri, 27 Nov 2026 00:35:42 +0100
Message-ID: <20261126233604.67722-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126233604.67722-1-philmd@oss.qualcomm.com>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX9aATD/WfXWAm
 I6gJpMQAuVERdr/ByECysttPnC4TX74xO0xL1WeOHny+6bWovieVtyy5C8Aq4HE84iXdbgf3D5s
 0PpzsWfiKElJIrzOU1hdmNb/CkW+xS0=
X-Proofpoint-GUID: B7q7glYbjPGDNFRjPc93QliBjkdpWsec
X-Proofpoint-ORIG-GUID: B7q7glYbjPGDNFRjPc93QliBjkdpWsec
X-Authority-Analysis: v=2.4 cv=M9fYuCws c=1 sm=1 tr=0 ts=6b08c285 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=EmkihZIgwSgxwUNpL-8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MyBTYWx0ZWRfX0jQLB294ayex
 8uWbLKYRsGVKMCLgGi/TmUo2emUhIJSTR8QNlucWNErwXAuNlSCg+1+0CmF+ygnZS4u8N0zuBwr
 siVSVFX+FpahXWkf6odyd2qXhsQSPFXZ/pAvOSv+yQbCRvRA9LZfT9l2Iov3mWQGoOdzV97bICk
 3XsWsSRoVAwoi9QpOh/Hd4gZzAYsGN841/dRUodq8MguPX97mSANVowYPYwuvE3DAAA8NIupos/
 1dgVPE+3oEB0/48q+4G6rd5jOVWoVxKpj9jObCRC7volQvD4815YbT9foZLR+OYdmyVvdnb5zLz
 05OvPbJLqxpHEKUrQbqjaQ/2KLA5htjlI9/wfCk2gD6maTLbADQ09QXs7WvH3P9xrKfs9/+Gfxn
 3vD5m40094LErqS10rUU9wyQ2uuXMKrLBLYLP6ZehOD3BNPTsCFBkkAd1Oo5EvY5xt7BQKyLy/s
 3twoEQIoIDIuYGiZlaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TranslationBlock::flags is now 64-bit, but AArch64 needs
TBFLAG_ANY (15 bits) plus TBFLAG_A64 (51 bits), so the split
with tb->cs_base is still required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/cpu.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5ee9ebf352fb..59e44b76a08a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2484,8 +2484,9 @@ static inline bool arm_sctlr_b(const CPUARMState *env)
 uint64_t arm_sctlr(CPUARMState *env, int el);
 
 /*
- * We have more than 32-bits worth of state per TB, so we split the data
- * between tb->flags and tb->cs_base, which is otherwise unused for ARM.
+ * We have more than 64-bits worth of state per TB (AArch64 needs
+ * TBFLAG_ANY (15 bits) plus TBFLAG_A64 (51 bits)), so we split the data
+ * between tb->flags and tb->cs_base.
  * We collect these two parts in CPUARMTBFlags where they are named
  * flags and flags2 respectively.
  *
-- 
2.55.0


