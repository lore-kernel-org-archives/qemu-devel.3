Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAADC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjeL-0006LJ-0l; Mon, 06 Jul 2026 09:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdz-0006GU-GL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdx-0006Ad-Pr
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxEZB366750
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4EtMpkgj0GkYsE/DLtkwyBvThOft3GO+shbpIHeHnLM=; b=bsS9Hv6VEY2MCCT2
 Z/Gkf7zG0iR11LLvfXscSSR9zDHpPV6IOkYrrL3HWLIRgQ93cPyj9gsI/3nfMcbb
 Osi1yQhdA8nnZQWP2jWjhsNX6YFm/H2qvrhn2RqeqE7wnNHD/w0USolxltVUv1Lu
 zeNxv7YH2MHOJMhfiZ7iydhkgU/gS8dJ/o/LQ945BVHz2+7rwxd63PkyBR8Mmz2Z
 b5tm71sDRPR0tBcIxFN/nUa3baayqExxQsnjvt2JC0sithqx2AL5+xX+yG5m72JZ
 H6BKQ0ere1O0JAEZfngkf7mvPtOyz/S4HMGPtKw9dELLAUlW+1/4KaDlJo0wvbEx
 0dHx9A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891us68g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:45:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-91ed0e140c5so549788085a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345551; x=1783950351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4EtMpkgj0GkYsE/DLtkwyBvThOft3GO+shbpIHeHnLM=;
 b=JQQGw2ZVp0r1k7QEJ6EwRAyud2+HeiOQ5K3rpa91xo1XfnfIIMoJbpUWHGeP6JMTLk
 RuMVrjQWXpzthVXevju1LT/cvs7NYZcYdjzpEehBS56Nrn8l75tSUMu9Q+SfFvT+Q5zs
 8vSX/20XpLtR9l4Irpe6Z7EJoy/tUDlpt+rXK9F76s2oCdRiXX/AUFQf5eBAj4YRu2ws
 82Mi+zpse+7YAGHu3IdtSl7wg91bVRjL80X5I75SzvkpWaKqejguDekFJNPRASCca628
 dJw7pueetKpkRf0MvS1VXQUruwkeOpPTmF6OBlLgXWbcFbGmgwTjAhCgm40HGC33/ZRh
 kp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345551; x=1783950351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4EtMpkgj0GkYsE/DLtkwyBvThOft3GO+shbpIHeHnLM=;
 b=VmodYcVIN2kUYBkvgYfo1ByjkHhj9Ffg8NKpNqzhSkZFHMEfGRls0gRznjZoEraeaj
 QJqukjhQpWsdX2EgPphO9159ylKNbnfYXphA2k1TOXm+gtkknV/2udkAEXM+nSaJvx8s
 I3N1HMC6cLol4l+nuiCJXy6nrhsrYCY36I9tFAQN5VonpC/oUhYRUj4n1Ar00I2htrwv
 kN/bqyjFg35vQ0et0IPXRinhEmgXBdqY/kAF5zcQj+EcpllOxNRi+tj/A+wvERuvlzNH
 SAeNUfzoCQnx089fwcffOSRAwM2y0sl0A6fBuJFAs/QU9WrPgeSYB9/ZnZFGYumUtuHY
 kXMw==
X-Gm-Message-State: AOJu0YxxXBIhabrrVQ2k7cAGWbgRJq9SqS2pplqD21q3olrHEcqDyVhb
 Vt6AKTQrJarqZkegfiAgAeCIp1O6HHLTZPwZa6cqslUIAIFJmny1p4fLmUvokSV4cJoh51rS9Lm
 DYgiZvDditEz3zvh6fovUUKLKnDobCeDrdIfGMEGwK32sE+JBAGXpy8jTutBhR+dYuA==
X-Gm-Gg: AfdE7cne1GYhl3ZSjG6HFGCY/009WYy6BFqH2E9PiHiucyf2eMZOTYkd/TobyQgQcs7
 dmqsdqzyqTtxF3gl4S3nVxhHoaf0USOkVKpZLzbOeiV2WxumFa7CfoyJQ4pQymt51heVmeZiCAy
 kwXH+znU/kDGvJ3lQFKNa7KB5AYSZdMm3C/uZ00wNhe9ABDm+sHsc5ktD9n2KpaMz0g9ofuX5yw
 pPCIyDWau9URpr2zaxhevEehi0gemY1KQvzq2ILxLO4tRAvU5ZCye+V1VexrLSN6gyHHp05D7XW
 QZDJ/zLdXjDRFgddo7bkZUzSw0U6HYVU3ZalYYKYOEFND5UIXQHkPXB/EWWLyA0PrpjjSutzcWD
 ENGlz6CIXIlZbGB/pMawLcmdF25Y5/W+QkwxlorBgiyqb7E+AeaXG7I2kiw==
X-Received: by 2002:a05:620a:19a6:b0:92e:5936:f65f with SMTP id
 af79cd13be357-92ebb4b5a83mr90724285a.7.1783345551285; 
 Mon, 06 Jul 2026 06:45:51 -0700 (PDT)
X-Received: by 2002:a05:620a:19a6:b0:92e:5936:f65f with SMTP id
 af79cd13be357-92ebb4b5a83mr90718985a.7.1783345550723; 
 Mon, 06 Jul 2026 06:45:50 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm24167062f8f.6.2026.07.06.06.45.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:45:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/32] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
Date: Mon,  6 Jul 2026 15:44:57 +0200
Message-ID: <20260706134527.84808-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kY3LSWoA3pxKAfvEZcO1u5YYT5vwh5cd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX3tFXhFNLjBeS
 Oce0stoofWJicMYCkbR60hcyJja6iG51uNMfRvFpCLHGAu6Usr4VsP9sio+3q4WJtryu0nXPlch
 aVP0gvSBB6lAE8VrL1XsPMEDV4RAEL8=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bb190 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX5QJyrHNKYHwN
 pTYVo3a1LLUREuJpQEPquuX8IOqoqAXCw77XSZKA2Bg9eS4hOKECHqF4ZzvtBRjH23m/ILzYZnq
 8YZ1GhxMCZRTjPV4z/xlIygpKxhgx2n6s9DPGYaHMJxoEjpyYec/BJCz0YSiJwWDYKcPCwZf54l
 Sw6C9ba35cOA3bwDv0uB/lADK1inc8/ELv5fd1dMfMjfQF7NCQBkUwYZuqCEc9Q664lvSP+03Jw
 r67PRKP/DKqWlRDX9p55pFE4v1BK/AacEOgp4or4fXN1LPdzbML52AlHsxfj1/rkQVRl8QEqkww
 5aZn1MqfiApFOEqA3NaDHKIDhMw36WEaGJSoBgspf9WNmMYNbJx4nAcnTEgfBQA5E7Xr6EyOoFP
 Tq8RICD7jY2McLKTje637eSeAKbA0CokbcdNh7PdQhOfI3F19+gAecIFlFIiNiiEsrGVxlb9tTj
 0snhOvRUvuOqg4x+NiA==
X-Proofpoint-ORIG-GUID: kY3LSWoA3pxKAfvEZcO1u5YYT5vwh5cd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060140
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

Common vCPU cpu_common_post_load() handler calls tlb_flush() since
commit 9656f324d25 ("Move interrupt_request and user_mode_only to
common cpu state..."), no need to call it twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260705215729.62196-3-philmd@oss.qualcomm.com>
---
 target/i386/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 1f5c517e562..df0e0c178e4 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -401,7 +401,6 @@ static int cpu_post_load(void *opaque, int version_id)
         env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
         cpu_x86_update_dr7(env, dr7);
     }
-    tlb_flush(cs);
     return 0;
 }
 
-- 
2.53.0


