Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1BEC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfguC-0004oK-I9; Fri, 03 Jul 2026 12:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfguB-0004o0-2W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgu9-0007gx-Jq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIUvD488825
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=; b=XluDBY3JqiIj3Mp4
 N1Z+pzbkd7KLdhZERM5L6Fk1rfUx6oPZ2yBEQAmhEo+YWTzQjO/v5jDOMW5LPkJ9
 mfSCbjOXGAOItrCe/ilaAhKY4F9MX/0JIrqj9VCEICxQ8krRop86H9f0MefWmoJG
 Sn6ZV4b0/XOqRBeXLSlTaEsHCS73W+pqrKcYj3fQRny854jMTilwb9LyZ2J2blTF
 SnXOQcyISyhaJ5Rbe//q0DuFXoEvIPTJf7uZy7qEFR7BAr91gztCRkPvdrl+lIvy
 0qTcDFS9Alrfv/iiADsymdME8WtdnKKEYgJhbsTFivqXBxqUic48rImyy1WmNZpE
 NBAaQg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0ymr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so63456185a.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096696; x=1783701496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=;
 b=J4g5lm42yKWz415r4z2S78pN2+n1J/f3c14ab0xyTpPUefUxGdu33puPshhOw1+E9G
 oPkPt51s1FnleHuicoyeWr+sJYi9VHtMaf6yygcF2n5B1+yhsPgjv1ifJ9S20tzpd6kN
 NIi5KEKS87Js6emNro/zowDzOCijBv2VjvENa5At7mfinlIXhzjlE9sLHtkMNkhZ9o1D
 kJpocfbMVMsWDOaKoitIKKB54h4SzRahUQzgl8c8vfhXlZgZiwVu/oDGfk8mIrXmFIaB
 u8icsH/4SWFh89R9tiO28YziY6zUjtIB0wEm6dHyjfz7ar1vb86pJ1ggS5P933cI65Rk
 wT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096696; x=1783701496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=;
 b=tO1Vz29ZFoTy1iKFgTbcC+DRPWqD+w/sXr6AAi3D10F3YF6/TKZt1Q605RhBhB8n6M
 kn2b8VYWqe7jL2wl7SQnVMwz4VlDaf/K89YTzSNeoV/p2tQVe71t3dQWtmXnV49b2iG7
 ZB2Yd0W0zh9WhDDu06MyQDOirmcVK68PzTcY60gPfHuYkmYwUAGYFw1nItDSR20MtEQ/
 lWHCRnAu4lH8nTIGMX8v5UVcubBn0wUinyksl00areVbHH9biCn5a1I3hosxCdm28uNG
 0Ub/nRrThnxa89pbfiodCCCyW2evVh8xyKg8YmVBEygAL4/wKLIxUZ32hn3OK4fIOdjJ
 jr8g==
X-Gm-Message-State: AOJu0YxR1bEWdJWGsKOSS8LL6/lyS55KlvVUMB/+MU5k+sQNW7lUVcRG
 xCeB3DFePgbLHcIUYoBshnLcHtkvoIwWlfyVR69GquYhQq6WdQ+8kRGW9zL4DKTHWehHdMb4MyQ
 rTOGl7Z3ZkNDD0SC7PAAd0LT54uFPQaIqn8ABjTwcqHAtzoVnbhzhkWrW1elQJH1nIA==
X-Gm-Gg: AfdE7cm29qRy77c6nROge+/8TOOqjdUa72ozrm0BAHTh4n77bUbEUPFturTh+rOBaag
 iguqjEg4qk91aKzeefO0m3WTEAzdOU+GTcpyhdzg42/+8U3jh57EmGLWC21wvVtQuYNKE956Vik
 pE38zNszJvX4FPFyropK4Av2Mj8U2NGyzohxTeynXJz+JrBoa3SDJYlLjYs+LSu6BkEshmbSo35
 D4pSlezi7VOkww/pBaIraqoAuNZTs+8yW3kahJ26pwCskr2jiaRINfXfoNa/bgyZHo0HpG9t8ln
 VA0ob+2Fsb7SEcj3Yl/zbnBAe2Uyu635DYkjTGkJxyaLxnhOj8EoxUogzSMdP7RnM4T3GN2+ozn
 hVzS7azdFPP35hi9VThHAfojgUCEUDnXmdyHmWvdG5HPYJWOVgWrhZjHBF5bY7gNVSeBM
X-Received: by 2002:a05:620a:404b:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-92e9a3e68d8mr28214485a.29.1783096695927; 
 Fri, 03 Jul 2026 09:38:15 -0700 (PDT)
X-Received: by 2002:a05:620a:404b:b0:92e:54b3:3f86 with SMTP id
 af79cd13be357-92e9a3e68d8mr28209785a.29.1783096695351; 
 Fri, 03 Jul 2026 09:38:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63ba971sm223584525e9.13.2026.07.03.09.38.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/33] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
Date: Fri,  3 Jul 2026 18:37:25 +0200
Message-ID: <20260703163757.55500-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX1Ud4q3wGs+xJ
 jUDG1O3iHo9BVwC9LeWtKM89FPXX3oauSjOCSMLIwwd9cO+Sew5Rktf2az00BwrNHLCARVxMfPd
 KL5Z/lWns19B7h67Ypb2UmQC7ql/tTE=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47e578 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3EoSZDcWmHu0mB6Y37Ojw7YFs-nGvpSx
X-Proofpoint-GUID: 3EoSZDcWmHu0mB6Y37Ojw7YFs-nGvpSx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXwEUWUMXYJYYy
 JaCl5Vlt2+trUhyqSHGqZSMiNWfJzXMz1ExqKjf8+gkImsVS1yPZ4gMCKqqcTPeRCZhQ8bPP7dT
 MF7IjoQM9u6AD84KZm083SKXfoFiBKfmWw1AQADK23zvUs9dJgeBB0J5n/GYoZpEmZ/iZcBtxif
 21QnRkRUzSadDAFaOzbf+zOlAM76FDMK7+5lPu/JQfEqPWmhL6h7vPUtwUpv04UCG0h3jHnC8uG
 1koqHTRgx9av64TQ9wzOfK2M9FWBorlHpVWTGpfY+thqCUE/m47ZLUTiCfMEilhJgNQzls7wF0F
 Pi+OwQfVr5Ncv5NrpGR9quSlKJ4COjtJLNgQHrciYoNQx5vqoBD3L+Gg7q7T9u0fIfVoZHDDkZF
 bdZC+gUwLT/lV1vkVKayiNJLO7iKyD3mCtO8k9YuudABj/fIeCzju2hyfINLqfVAqLouNjsqTmw
 4ClpuqObBKjIk3VeMrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

Common vCPU cpu_common_post_load() handler calls tlb_flush() since
commit 9656f324d25 ("Move interrupt_request and user_mode_only to
common cpu state..."), no need to call it twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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


