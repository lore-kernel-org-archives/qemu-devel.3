Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C3606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a4dB/1T3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FMz3uOiI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwe-0002dI-Bi; Tue, 24 Nov 2026 18:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwW-00029L-G4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzwU-000828-WE
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb1ZU3274646
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cLEN3X/FM31H87zueO9Ngt3Ye14JQWiUpQUVKUXTEmM=; b=a4dB/1T3AHCSlO7D
 zdaPcJtqht5bwiTiZj9cBdjFX1HxgcC+K/wffIABva7NA9jUYqtiWjppfeqfnHD4
 3FrNyjV9bzQRXwezidlRvZcT8JNRaGE1GKuIq2nlGnAcC3xNFAiGAGnacVeqIAgk
 6LKnMRdAmocCcuVW4SwAaalR7MmP66TwT9GxoQbVqj358CqPtwmoq242+evEVWhO
 yMQS/AcbtnONjzz01UNUfUTOqp3MIzlQUs1EaIypCQXfiODvGSBSVHRdjdqScUbJ
 vJaeO1dJ2XjSskSlkOI3fg5M+j2uketRy4H0MiS2/BLdzGo1E/FOyCXt20r9QnEP
 J4PLQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5gnf8rbg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so829546185a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562933; x=1796167733; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cLEN3X/FM31H87zueO9Ngt3Ye14JQWiUpQUVKUXTEmM=;
 b=FMz3uOiIuR+zvUC60A5pmE2S/rDbZiIBrlIri6Es0/yEuQHPAncbNjsEhVcZ06jhOk
 7hvrc5DGjh46ELPuv6av2UqzK4Pz/wSqqLMqb7YhdvER9sP6dcdRAJao3dI4soxHwk1S
 8mj0puOYeY/I3mu/Z5varaDX9I+OFwCOX7w8kTXG2jhyOAa8PFBps3aN4OwHI5n5m/0N
 rLGPVr8MzdXPSq0tKsJvtxJE6a+OlNwhA0Kr6u8F2p+QBBk6mJAg04+U8t4tEKiqdknZ
 F5IhcT/xu/vcUw/x+fsp7phuHsKai+AGHLszpICwc95RuImyMJt/tKUOo3EuPoKZdY4e
 07wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562933; x=1796167733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cLEN3X/FM31H87zueO9Ngt3Ye14JQWiUpQUVKUXTEmM=;
 b=QIfCI+3yYN9ejy2jo1KlmRRukhPR9OjhLjLA0ClRSwd9YHt6enNEdz0hcEJJk10awT
 eGxwHxWeYDAx3c7Vtgj5lAQ5cj4qGlxEnTVFzNBgzh4Ssihcq5VgIAL8MyR24xHbGcHx
 4k2O8FyXWsjALb2hKb4UQy0yhxyZWfyudwcMDfR2DWJ4ullSCyesLD8sn8NcPpgHzBae
 KifSu7nFa3fa05sdA/ulLIQqMdfhsM2gHk2ZRuR+7IqNsR3mS2+WNS27xnmpleVhEv1U
 YpIg8DdRPAguewj2+zk1+LLo+Wo0w8oZF18NxlcAPpJJazbFoj6zleEKGFZZ5mzeKNk7
 TMew==
X-Gm-Message-State: APuU4Z9USYl5PTRS7cqtUO9xo4k9zek171Gi34cegxtJRSPUbYSk+dgW
 v+4qO2r/2vgJ2OKfGIJQ3MBKGQ1wWR4D89Q6w9m3lTatYPmGnkez1CD6ZC71s/ffXuaI2X1s8XH
 zjycRkRx53R5uLah5k9dgTS9K3LgSxeSvWCJZ0oQ/nM+o8ejFQJg99KBDdu9TF8gTZ+lL
X-Gm-Gg: AZFdTZdQucshVTJ7U6NNnPXEVfn9kqnzqy+BIomjjZ7a3ZnCagWPzaEzgoQZSnan7R7
 LGANKL6B+KI7hxHzKgNzy6tLMNJ3OTi0PxyPdlr0UxAeIAyM8RWOLFSSrAckjH9QAiqJ+Yv3VPb
 8x495nHeohq65Z7w7aFgDAeFd/4b8nnRYgoFE8nWNpRDz8rJaI45fnSkLjCz3MgZWg5TGUQhyxF
 tBci8x2Vcgv3zTVkDXUjiG8dzrrgM7Fciweh87lzXJjKzqyyCNhRQQKTU9uFAxg4FNy3cT0JWXN
 y7Ws4z4BSphcS3jTcQtJVJWzxgOrK32r2oVA2eWgkNuqS5nmk9zr2wM7zmfzTcPmXy27Bf3VG7O
 kcp2PyKDnozgkQ+jlYS2PTjpR7egIf0u/ID+TMJqulQWYnP9ejTPuFUcalRYaeBpzwybUW2ZLb2
 BpBPnTymNNTPmrdQ==
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-949ba9db70bmr2812568585a.46.1795562933529; 
 Tue, 24 Nov 2026 15:28:53 -0800 (PST)
X-Received: by 2002:a05:620a:1307:b0:93f:1e3c:4a3d with SMTP id
 af79cd13be357-949ba9db70bmr2812564385a.46.1795562933026; 
 Tue, 24 Nov 2026 15:28:53 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm274284455e9.2.2026.11.24.15.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] target/mips: Fix microMIPS CACHE offset used for ITC tag
 access
Date: Wed, 25 Nov 2026 00:27:16 +0100
Message-ID: <20261124232722.90234-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfXyewq8Saj0Naq
 82s6hcvgpBlggxaixMzZVRtlHyhdpxkr4seRZTbQWCmjAmRewrGirKUj1gahzkTUYb04WvCNG55
 x95v47KCXUA1zKdWw1jY8WB4iN0NyiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX/CuViHtnobxw
 Fr8vq9xMFDttQ83lolNhlwl3QbY2WPnpyiTTWUFL0ovz0SMsUDTxOgZP4aKkZ594ETdnwoHd0L5
 YgWWNCWud5O3vTyYqlCDxC7AfuGp3MhCvja/KUKMtYAfQXaYRJwQIEnMgVtq85HA3FkmLKFGoCM
 N66LZmAZ71jV1Z1Vvm29fHp0PIjJ7lkzWvM2AiW/Ys1ruJbfqkpyjQRT0WiTQUhDeW+hKAr5750
 u+rt/ECC4lLzYNzY5gL31Ms6nb2XRDC54ZNsTO5BoMtdU0myXyYUljmBYfJDBU67MwUqlUkF8R+
 32gwWFF2I6YU6GtF/Wdekzf96/lzNRF2Tt55ko3s1ZSZA3FDtll3AEXPoRPJFwS/KSyQ8Irg0r8
 h7Wj0ShVlNVLHJEHflgnhYeoXXOVEThrloB/vUV+y8Qy64XR6Sx0pT3UCDvJsRC+9T/7aP69Dmf
 btDmUcFSWJxbTk7cXJw==
X-Authority-Analysis: v=2.4 cv=f/Xdl+yM c=1 sm=1 tr=0 ts=6b061db6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7P_dIAytZZwb0VuAAYKnIxIqYd6ZX0dU
X-Proofpoint-ORIG-GUID: 7P_dIAytZZwb0VuAAYKnIxIqYd6ZX0dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240092
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

CACHE is encoded in POOL32B with a 9-bit signed offset in bits 8:0
(MD00582 rev 6.04, p. 144).  The decoder passed the generic 'imm'
(the low 16 bits of the opcode), which also holds the minor opcode
and reserved bits 15:9, so the ITC tag access used a wrong effective
address.  Extract the 9-bit offset, as done for CACHEE.

Fixes: 0d74a222c27e ("target-mips: make ITC Configuration Tags accessible")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-9-philmd@oss.qualcomm.com>
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 4ad2b699615e..21374e3ec60f 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1820,7 +1820,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case CACHE:
             check_cp0_enabled(ctx);
             if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
-                gen_cache_operation(ctx, rt, rs, imm);
+                gen_cache_operation(ctx, rt, rs, SIMM(ctx->opcode, 0, 9));
             }
             break;
         case LWC2:
-- 
2.55.0


