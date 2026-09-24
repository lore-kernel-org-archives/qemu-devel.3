Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6991C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lLT-0004VP-DQ; Thu, 24 Sep 2026 11:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lLI-00049f-A5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9lLG-0000YL-Ih
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:26:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC4lPw2285758
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NgErSkNw1Kcg7y8aZEKk46GFw761x7MCaXpzJHcfPaI=; b=YkDZ+gO0cHTDMtVO
 SPd0VJOhVbYu3C5Ov1aY9Uvkhhy6KcbHqvhcIfmkqbiCygOsw15fri+2bF+b2mNl
 6AHfjxmbcKAWQa+KKlXjUNArqUXXAHatmpVXZQFYy00RqkqgvqxxwP+vzd9UiLvw
 oZYYicBA8zEFafH40nffLfuS9EldbX42vltrr51tFqZkyK/QoA2IY5aubiDJTLwV
 PauRb8x9mQLOyMFP3g5KNumvn70Ze812OJEu5plhpWC5QazLAOZ6WaALDXoU+svU
 Lu05gZRWgTuT06x4eL0Rgk4EU8fPfRbIMiKHcwr9e7ah7c9xOQOZe5qX3bJg4C1U
 IqhfyA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvx8ajd08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 15:26:32 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7ac2663eba2so1628817137.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790263591; x=1790868391; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NgErSkNw1Kcg7y8aZEKk46GFw761x7MCaXpzJHcfPaI=;
 b=FTBLXfLShCbnAT3Z7CpQ/c/WmQ+ZqeG+6yG8vd/Kj9T02tnz5EbWf7rb0Q6D3X0L+D
 yfKsxkrNqV6VK5iNDWVASVLBg2AJ8rRw4q+UfGNo2J/t4Vnpwe0rjXbtcKvz202XyYoX
 V0Y4KKFSijykkT7w4W8JpgE0TXp5K+zAORTJsbJEQmhJ0lq/iXCNNdDsYbZ07fOUATXH
 X4NF2xR/2I+CA0LP2F8Nk+h/kXap3EvBkJINZwvPmCWu1kVEPm4iscBi4nuoxF2LR9k7
 8grPYx6gvXifUeh8k0brA1+D4hoYvMkfxy1SkQFS8j+3XVlg26k1YRPpUyqe2q3j3RZ7
 lu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263591; x=1790868391;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NgErSkNw1Kcg7y8aZEKk46GFw761x7MCaXpzJHcfPaI=;
 b=ELPkDTqRGl4WT6Y/ZYJrJhpjXEuJvG2418TQ0o1bJQSwyPBhknE3KxoP6VDHNLE0I2
 jlFS9Gq2gGkPp0ktFMXhRX6o8ELEI0ydN2c4kLw6v/nRHFligUi7gEBPaybRTFT+TzJQ
 4wCD9gI14QrcBF9xBc73nOjI4bi4aqmXJmwVQUy8j4hMbHYltGgN8VZCyhDLwXJogAUX
 HpKdSv6VTsLccSe1fX6rhShShmzXXq5tylHd2GToR1WAn1cqYdwePsT8PmJLBp3So39p
 ynG4jpUfJka7WS4ZVvxANFJef3kuAAQF7SzD7+zxn5Jpw7ljY2HGhTfMhYYYbA58h4iP
 fWEQ==
X-Gm-Message-State: AFuF++mKXoJ/WzbMGHvDoQ7zH3b8n9kZ9QhdwtiCx7eFOOCeyEUH/l2+
 DMFGw5NEM7WZfmTcG+vF6cEYBOLS+XsQOkdA7aqEzSIW7ILZjjv6JIui4LS9N8GGmfoNHZTzFlX
 O+P/jPUDYqPY3iA+2bDLoP6QT8sq12pRDNuc5uRRVq7OChy5jzFaEf56C3cbS3BfIrA==
X-Gm-Gg: AYBFou0paCAMAHOx3s/ZoIr3cBFEDWx9rWjZoPD/HwDLQqiEM4Ni1YxWsxSzIEcEqFT
 nU+FoKBnsDaX+SEHoepor+5obc0ksZ0gHZ29k5ROsQwAOhTY9cPWNsALVz2nQtxwjecWI3p6v/V
 7uOLSedZn0XHNiw+e5n3Ulm7lXpvjWv5n7nCVu/7hCJntrP3qUB+g9TG9ZSKizw23BdaNTXenBP
 XsHJvKm7Kla08XBZtYf0EYzSUHoi/CPVhHok3E+Y6JT+3SpQRXeHSuYFteSHE3MEIFOUBW+ipJb
 il7btl9MTaGCYHVjiJzXCRaVGRB3PVTisekGIIIbYptptDXpEE9BirE1IEpTsehLOPUp2KarTNX
 E005+ehQkkesMeb53+zqqvXHeFODlpReqXDv8iJrD
X-Received: by 2002:a05:6102:c86:b0:7a7:198b:674e with SMTP id
 ada2fe7eead31-7af1f4085b2mr1490665137.35.1790263590900; 
 Thu, 24 Sep 2026 08:26:30 -0700 (PDT)
X-Received: by 2002:a05:6102:c86:b0:7a7:198b:674e with SMTP id
 ada2fe7eead31-7af1f4085b2mr1490643137.35.1790263590212; 
 Thu, 24 Sep 2026 08:26:30 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a19bsm16428480f8f.25.2026.09.24.08.26.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Sep 2026 08:26:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] target/i386: Use an acquire load for interrupt_request()
Date: Thu, 24 Sep 2026 17:23:52 +0200
Message-ID: <20260924152353.36209-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924152353.36209-1-philmd@oss.qualcomm.com>
References: <20260924152353.36209-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1t4KjHwE3uog
 xOU6696gtFeB6OW0xsElsrptrm/F9kdbTDMQ4eTiHY4GhmgQ7VeLOiKnrCCL6f0dgdDt8JBPcrd
 V2mkeN4zZHSJlWyLirZcdg5tFdcTYKA=
X-Proofpoint-ORIG-GUID: tB6MaplJ-PUSRo7-9AvLZwY-cdzoFKU5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA2MyBTYWx0ZWRfX1Z4F41NMOCdL
 zrDcsmsegxMu42MS71JCCoE64R4kPqylkHG9nXbNP6OzmFtGzXUabTtfjl3PvdiHvD157kPbpAB
 KSNxxkKMNC27/wzgSmBspxS+QzG7g57EiEAowNr/+ijFPhEOiPvB6O1o0FKFXNTnJ71aLYug2xs
 hDxVx2gZBgxmy2XvHtsbqnbXixxEuPGtwrSdp5ntRi2LJ6KL+GNrEUrZ4lA7P/XjuaaGfxE/140
 C7ueUfpY8eGFIWbLgaqon6RASW/wS0OsdXPZT4thl8gBF+6uVWGKaXEgthl59tqidxf2jItGwbX
 Sf7JT76R64WqhmZLcmwn5VJPyWFgwVFAxUHjKqMwIiizdsniECqvzGsrWn4HVsVXqLvvKZeF6pU
 lGCyWxhgt5TI1J+U+7VwTR6Nosv4BZGab5na8OUb0IfwsN4b+GHH5MvzMxQ2ahP6XP0PWeKaKK9
 Ox/gDwLX22GArhKV2mw==
X-Authority-Analysis: v=2.4 cv=a6SlZkSF c=1 sm=1 tr=0 ts=6ab54128 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=8gObA4T9cFbzhFTk6d4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tB6MaplJ-PUSRo7-9AvLZwY-cdzoFKU5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240063
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

x86_cpu_has_work() may run without the BQL, but currently reads
CPUState::interrupt_request directly. Other threads update this
field with qatomic_or() in cpu_set_interrupt(), so the direct
read races with an atomic access.

Load the interrupt request with qatomic_load_acquire(), matching
cpu_test_interrupt(). This provides the acquire ordering required
before x86_cpu_pending_interrupt() inspects the CPU state.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260923171116.31276-18-philmd@oss.qualcomm.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b97f144aea5..f3bc6911c10 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10640,7 +10640,9 @@ int x86_cpu_pending_interrupt(const CPUState *cs, int interrupt_request)
 
 static bool x86_cpu_has_work(CPUState *cs)
 {
-    return x86_cpu_pending_interrupt(cs, cs->interrupt_request) != 0;
+    uint32_t pending_interrupts = qatomic_load_acquire(&cs->interrupt_request);
+
+    return x86_cpu_pending_interrupt(cs, pending_interrupts) != 0;
 }
 #endif /* !CONFIG_USER_ONLY */
 
-- 
2.53.0


