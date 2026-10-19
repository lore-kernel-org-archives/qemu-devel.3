Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB451606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ROtxPOAZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KksyB/62
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuu7-0003Aq-WB; Mon, 19 Oct 2026 17:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutG-0002kn-Tn
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIut1-0006Jc-NV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJKNCX3628228
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 95h5shfXaGLW4/c3cxkX6qd0UQYgJOk3FyYexxiJj3Q=; b=ROtxPOAZDb6oXAi8
 ouDVM3M9PlRAbzP6VsrjpdLbf0V8yCdYIEeb4TjF3du+Xuicuggae0s2oD1qS3IA
 ELurPplV9U+JbREbYeOiDGMb4Fp7Cdw6iVLt3bMDjGDrYuCxXZKH2aNE+Hin9x7r
 3gFNzIJ7N4zC51KCjZ8/3z0FYT44b7gUJmu6FF6bUiVfpDVbiY6zCK0oMj3+klMO
 Voq1EwQoxB0Hz/MjRFRDw/7b6sm1WhdVPUjA96g0g169Ntsz2/mT3yset+RSETH9
 yeg6KlBB+AvycejoLF/ENG91TT3lKnr8supcalS9Xc99myYwRuzrlPGHgrKX1lwT
 KHsDcQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr42gqgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:10 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso5345764a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445230; x=1793050030; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=95h5shfXaGLW4/c3cxkX6qd0UQYgJOk3FyYexxiJj3Q=;
 b=KksyB/62em3J4fme6DFhwuejpJ5OnMzVu0KpR7OvpJCD4GWRIus7dcmQuavNYlxzz4
 gGsxNFJ/UooX82oLGGAvvz7VYnIhsiGGRmZW71DLLlIo1J1cTJerUCkkjDMQTXeXeyp1
 xEu3UmDP2siQSOmc/lQkxLfKUR9Ld4eMdA+F5NXsbbFctPk3UUvQ3myvpxBNEGfSkDed
 Wi5CKJSkxeUI5pD6sl5DHwC7mpEeyV5EapDnP5MtSh2+jVqCctXpz6JM7b9TXHsGWWFQ
 vJa8pCoZAWMGYboBWpMbnvfYxZkaj1WDGj6htmdxaP0mkLaD/1kvbSfh1GMgAfcMbwAf
 eZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445230; x=1793050030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=95h5shfXaGLW4/c3cxkX6qd0UQYgJOk3FyYexxiJj3Q=;
 b=TyC021THTxL6kmP1HsBgmHUqlTG+BzT5unCa+D2FDX0jmqmI7a5qvkYmk1k0YQEnZ/
 utOy5DLR8VuBhIal9+eYM4Qq/c+ng3URLuH8GsjJYI4bHTmmdBCWsxQ8sQBgYTRENLMR
 ORahNl6LiEGJj9MHirt9uwpvCJ7WBHv/HzeRfMYGcu5DamGibypui8FroCU9DlUNNxOV
 XMaolyZB3BjEzRKlqf0IizUAeXkEnmCeJ+3bohSZaruvv5X7BavOYPt6/ODkMC7cdm7Z
 eR9EM03E9wMjly50wXyNaFlLC0a4RVAGQvtJw+82ZDfWUHDJzonV/zJ0aWQ6MP0RGiJJ
 rN2g==
X-Gm-Message-State: AFq9FYIhrnYpMmvGI/BjRVb49/y3Qza33gQhaRP4jVhOznP6w2Rh05yf
 DihN6C5YbcQurrtPmwfcfGMJe+XC+3XztvcQz9WZ7XOq5IvTF+YspqTiCLWtcRx7ev0y2FP+Ppa
 4bg/W7I5X8Bh8DETfQPcnpwhEhtzVM9eZZ2UmG+Th808uETy25+54jHf0kIzgAOrTaw==
X-Gm-Gg: AYBFou10zl9wRDCrjrNt1QpuLc2ku8k81H6NUNo1mnC54BS16N2ajBQ2Zqizx2X/Cqx
 5cL8RrTmJgddPdf5Su3pzdD5OQCv5FUjaMjmUziwqgTCKc803lFPs7MyZJ0gLRfeusmqL38wSlf
 FAdK6WgjlcmsEOa80PolHtIc65PM31R+8tIqju2lZH3PeymQOzVLC3ZLem79DvqP21a92oqaEJ/
 gCifGzDGzwN9b3yDwI0EdyOcj6brPzK1rT9tavws9iCx+kFBIYNeQyNc1ckVASXBFXOJkvblAev
 jhdn5Q2pZYLEghXvRrFh0qaRNIDYnzaf7VTWKzWa/Yr2r3CGUQgsCh0QqBmQ7fyc+vA22C4yenh
 lUVmQC+b8tdkEy5oto9hTL8rMT5d/lSjj1HFx1WiMuaoIzUPFQpzOuUCAFukWYos=
X-Received: by 2002:a17:90b:2d06:b0:39e:6c6a:6580 with SMTP id
 98e67ed59e1d1-3acef165178mr7016119a91.67.1792445229780; 
 Mon, 19 Oct 2026 14:27:09 -0700 (PDT)
X-Received: by 2002:a17:90b:2d06:b0:39e:6c6a:6580 with SMTP id
 98e67ed59e1d1-3acef165178mr7016107a91.67.1792445229289; 
 Mon, 19 Oct 2026 14:27:09 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 05/21] hw/core/sysemu-cpu-ops: add get_dump_info
Date: Mon, 19 Oct 2026 21:26:32 +0000
Message-ID: <20261019212648.154493-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX33sf0v/dZYve
 fUxKT8+diElbFyYQiS9qqj+02zkxiiheu9Je9tqWCHObtsCwtt/1TgqvK5BqaGEOe7smfSKT9nc
 Iizn6AFgnqnOd5A7hmiHCcuX4rETBVYmpmHY0l09ok9+FxUheXt3JSs9DGWW/zVILxYke8efYsN
 LU5KUdBUJpEiub8VwYXx2nLXcnnXCG7sCAgUd8ERXTgnijFiIX8mbX2zRm7Wru9ghbMBwDA//t7
 lY3gyAwllFwxar08h4/sKYdWZPTgc95Vgi0PeScbx1OJ6FKCmJfZoEltxwa8lz8QjuoMjyH9i+k
 93b7/il+4TeAMUYV1+C5N7v2ah6tbeqLWqygY/5clIbVUlIwsq+Ai1Z1PxMdejl4YmGDbFWRGwc
 YX7hcT0Wxs8LltzXcT8Y0rxHGdjszgFpTTokP6aEByH3e98n/2pjS/rSGRUAoHgEZ3eCm8kKu4m
 EAI3F7dEiYzcKkR4B7A==
X-Authority-Analysis: v=2.4 cv=Ve9ir1p9 c=1 sm=1 tr=0 ts=6ad68b2e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=MPCGK63B0krzei8L5x4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX3x/j3xgK01+Q
 EnW6SBt9uXNhqnqH7ejECQMLkvrxu4I80MG/m7sMCR4/1N9eqWJGsDOeAj6iNPNHyDeSy3IP13z
 pCD3U0bkw1jLSCDA3+c7LNayUdchhfY=
X-Proofpoint-ORIG-GUID: WSuJMrTqL5ANtEY0ZBHEQBOO_weBc1Ec
X-Proofpoint-GUID: WSuJMrTqL5ANtEY0ZBHEQBOO_weBc1Ec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

This allows a specific cpu to declare its implementation of
get_dump_info, needed by dump.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d..2c7d0b94767 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -94,6 +94,12 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     * Returns 0 on success, or -1 if the guest memory can't be dumped.
+     */
+    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.43.0


