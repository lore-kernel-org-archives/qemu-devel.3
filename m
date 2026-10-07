Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3A8CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOJn-0004lG-V6; Wed, 07 Oct 2026 05:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOE9-0007oR-EI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOE8-0000Wy-0b
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:21 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jgT63334707
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5SKg6Wzl4YVXz21tBE8WmUs6PxGZNlsfM1XXfXsLp8g=; b=ZJmV0FmuMpNX3Bj8
 yFd+za0M0IcpKZLS2C9Mr+X89iFkBjQb8UBHBvMhOjdSbQ2MEUAfpvtYkr0k+VLi
 0SnPm3qDzFiVxUBkXpswJLu+NKo3AbddBy7bCqgKJePwEwylz+yvIBfqH7lc2VT5
 VEHmCe68ltMo/DHjP3QXCAAf/eOgzM20cIKhlCHXoR6QFQBf40DJfO4ofIxGANtb
 pyD+xa7RVSve6M5ya1JS6xbGaoqoRa//S1usAnpz6xKyalew/wlPWbQRuoN2xdJf
 uB39+Hkjv7INJASz1SZpDqSgfDvoTIT7Crae01unTULKCPslyphZ2k6mSF8Any8/
 C2lijQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623fv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so851785085a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366378; x=1791971178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5SKg6Wzl4YVXz21tBE8WmUs6PxGZNlsfM1XXfXsLp8g=;
 b=POYkD039iMreuEXQEhPZx9q8bhU15HSuLIFWwJ6L5rZx0A2UggvYgml3KcDErhc6wG
 AageFDvJEC/6U0p6/Fhi/DWjA3T3ESSkYPHTTFjpOr6BJIDUQ5HACmFPPlSWB/NZ8FY9
 zD62IA0JYWelrLBgBPDmqkpdOW9o8r0ZBWNubNQzVWnzAM+fmrtmMCK3kxegPh++iAcB
 gzBsoAjeEFQFTLtvBYSZ1rQLkBiBkxsGbUsEmWtEEuKMGOkKCrENZ9VGrF3lN8e1G1wy
 mX4DKdNgVO3BZvYQnDbYrAhcyYAUgzWMKkoWmdyyzY3QrHJHBOlNoqKqwv9gXR9r/mR3
 HSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366378; x=1791971178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5SKg6Wzl4YVXz21tBE8WmUs6PxGZNlsfM1XXfXsLp8g=;
 b=EOfvCIbP/ntrNazJF+CGJVJEqEfHASborRPA2CEovjProg7yTwsBMNanfj1xGkjTQZ
 NZJfj11hqXLL2Dymc3YwqC7kW59Q/byuIGm3lj8vkXxTst8HF8d5XFfFTRnph9I6iS7l
 ezU8rFGsWVsKOYF7dWqk7ajX1HxRiXqAGa00b5jZTWTeQ8YD5iG8oZlFs/7kq+nPedSM
 mZLO66+W6aFnqoc7coVCB3U8wlu4K//inqx3P1HrbKtFnJBRemT2Q9WXklRZrYLO6j9A
 l6ruHqftjtAYxCYx4tMIYCWzD//cDeeNgwjX6pfHhEGN546ysl515KgprmbbMJzoGhFa
 PSPg==
X-Gm-Message-State: AFuF++ld9t0hb0n8VPonZ0ovsIv+vdzZme4LipPTnABie+SqmlAj0S0Q
 boMYCwhmf4veGwDWAT2Trdi76CRYd49juNLvKr3TrOB+E8GyjwIVgEP3NFg0guFIe2tMEGoXq4a
 2aD0fApcoBG+83FfgeMNDWj1K/p1J4b8cohPnI0PP+jToS/UNxULhhgeEU8C0fq/QeJeF
X-Gm-Gg: AYBFou1ZqDrt18FhRBA7YcP3QUHpvDWIrJ6ENeqx+J98jf6ny7sfUFvpxtawLs1lSWP
 iPP+fFw7giRJTW8gUj4O5zG1eF+0cEzBQE6NcHl7v09W8RUybQfsMnaw94VXSmcYEK7mIevZZ/U
 /ejdD5wVFTKXLNYKVeRX/X9yQcLCTjAm9pIXSgEh9sKaTyIOU0Va0F/fi3mhMnngNN4BKAi4dlT
 ElP/YoQLD24TTQx1ZNq59w/o8LhMiND9i0M3OvYnl0NJf9/OpfZBD+B8OLl8LBtHssxpuni/cxC
 guSm4A6jvu3BdUFDdEvyvPhH7qGp+u8MG+4Us7L7nRvm/lrCJ+vlXQX4idMzYL1HIxSScJ+hD21
 yf2pinysy2e7fp2AGzKwFXWpqbVWfI28vYv1pbzQD
X-Received: by 2002:a05:620a:2906:b0:93a:1ca:f14a with SMTP id
 af79cd13be357-93e9b74c74cmr325869185a.17.1791366377656; 
 Wed, 07 Oct 2026 02:46:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:93a:1ca:f14a with SMTP id
 af79cd13be357-93e9b74c74cmr325859585a.17.1791366376246; 
 Wed, 07 Oct 2026 02:46:16 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d123b5sm4280144f8f.24.2026.10.07.02.46.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 08/27] target/i386: Replace magic value by proper EXCP0E_PAGE
 definition
Date: Wed,  7 Oct 2026 11:44:56 +0200
Message-ID: <20261007094516.75732-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q6rLjD8WTt0gQ5eTVbT4HsSJOY7puXL_
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac614ea cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cqNPAgZy6cprIHpAkuoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfXxj3rznlY1GrT
 cMA2D4QjZ8NR0F0TYQHtk8gUnmdCMOKFitTuY+nHp1e/h57ffnMUbxN0wy8jIdZAnLx8QT9MR4i
 0VjYbSbE8fbYp+XjeewvAQHsIFkT88A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX8yeUiTdkXwml
 d7Z8RiXNCZsMxm6DkA9uEzJKT4dZqjChBPLZ2lQSYne1nHbi21cSGcJTq3AiJYXO2mt/DgC0f3t
 2CTy1fFBlRc8Mn9WqP/pTXVIn98CzzZRXIn30C+siNRP9sIBWQeUx8knpnSVps8QCPKPi1kRt7i
 Q5E9xT3NAX5pdKUZkLiCPk546Xjwz8Xp/nAduhkW8xXOp39SB09uvu7LVNj7jAUfoiYxj9PwMUQ
 MJ2qnoN4kriWtz0Ie1B6gddhpJCetckrfT6425TwJSLmaqff6ZpLBkvZ12J8iHO3fdxQvoGURvf
 J5cYpQ/5HDmqbWQfbddvfLtoFkkSaB0llU8i2QSX/D0q1yqKuVm7ydY3UHcmHqZ9ytiroR2N0rU
 QXBiYP8OGTalOGJ+CtLhYFpWXgiaYIcZUjZN/cu5tX8evLrDhCMXaWtaxVGXKqFmVW07JWHdwSW
 pHe25vFN5YsGSrU7lpw==
X-Proofpoint-ORIG-GUID: q6rLjD8WTt0gQ5eTVbT4HsSJOY7puXL_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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

No functional change: EXCP0E_PAGE is the 0x0e page-fault vector.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 6d424349a58..138d2384b18 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1215,7 +1215,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                      env->segs[R_CS].selector, env->eip,
                      (int)env->segs[R_CS].base + env->eip,
                      env->segs[R_SS].selector, env->regs[R_ESP]);
-            if (intno == 0x0e) {
+            if (intno == EXCP0E_PAGE) {
                 qemu_log(" CR2=" TARGET_FMT_lx, env->cr[2]);
             } else {
                 qemu_log(" env->regs[R_EAX]=" TARGET_FMT_lx, env->regs[R_EAX]);
-- 
2.55.0


