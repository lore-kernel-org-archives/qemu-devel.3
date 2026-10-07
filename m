Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FB7CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOKB-0005fX-HQ; Wed, 07 Oct 2026 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEk-0008VB-F7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:47:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOEi-0000ix-Sx
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:46:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jgTC3334707
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GKl16ZoVaP8tMxw8BKMzyZ6bfNNSNSAEYQ33XCrq59I=; b=RNh2zXQbDg1vGfzK
 kfTWg94Fejvsz4L/gt0CEVATYvDfeV9T2rmNbhT3UAeM8ENAjmMP8A3AuWix3jx5
 oKOK+nYpwf3vGf543z8zfDxxX73bSDm8D1jihMP38Y4R1C28xzyrFWVWQH8w1FbJ
 7DFN5bb85HifSahpJoSHwaeufJWx//KYuzt1HLCV/tXCjq/4XMOc+IP5KU9s+Mx1
 KadpRP9Yn6i/GVnUjUczhmwnF3vQZBNaYBwWaFGHzK/58izodx4+ctnhSBxcjUsv
 n89PlCF8sfZ8BNBC0Ufo3dXCsAxdSKKyKcvKdXk1m2MuJS743famRsj7aRZbIo8Q
 O+kWgw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h54623fwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:46:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so734848985a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366413; x=1791971213; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GKl16ZoVaP8tMxw8BKMzyZ6bfNNSNSAEYQ33XCrq59I=;
 b=V5u2++8LGl/Bf6iYHJwQOc/tdQFG9MptUY0B+zac6tB3AtqzbCMERlgXY56CWZ/aY/
 YgX4GycdO2R0f+5cw8PtZEbaVUAcrc8JOuLNVdB4HecgA3WjJLhUmYfSkMa6K19jw7z2
 EpTFmRt8JgBrb2NXBbuKnxz2tzzXj0tuVGxpKbkw9VrElQXVGsQQxFO2NO3Mt8cwAnnM
 yLBs/4f9Km8LXRudQd3AT2+EmY3fQM0HXOJu7EpX/lAzH4dklO8OICaOF4IQIXbO6giw
 YAMt2czkhVC7ZiP7RguOhdLmXJLSSeBPsd9LkE//9fy7/oYR0l4b9X5/6DdsnlufNuoO
 N0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366413; x=1791971213;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GKl16ZoVaP8tMxw8BKMzyZ6bfNNSNSAEYQ33XCrq59I=;
 b=wvqcZngk5ljSH9y0PdE0pndDb9sX7gTzfZ5Xznf7Tivqz/AWu15OYTcgwDclFS+Lqs
 xhVbp5XPdcf3UsTTY3lNTcNoEf+qgGXONP1Fxyfd08ugE7L/whnTvv6jvqvPmeooOCyx
 gJ8x2mRb3e9UTHm5Xeym4iQyc73jG88f787M5bOZd3yCzvi6ropdeDLQhMol4Y8aUHnp
 wz1WXLpP+H8W9nNOe1VY80ehxwoAMowggsssAuIbzTBQJ3qKxFZPMzyvRPFLz8r5CPHu
 NeXi+70HGAuWP2aj02oMjc8AtLKJeMp1hL1iTD0HTXoyM+tuIJAaYcmXTje5r+Xfzkou
 M5Tg==
X-Gm-Message-State: AFuF++m1St1yDjiMvAaxKPLlkKMmrr7qfTkeRcf3yVcvZc5m1Y2IjJ0a
 xwaex2UARo3nABM7bVEhAoCvkiZq7jjgdtxyzNWBqT6kpLNuS1PnxRPvm5+vdgjw9zzf3NsDOG6
 icZGve827RZnjTBlQBT4H+IbSsp+I+GxP6CHWyKQd4ojSjokaHS7bL4FIOFUGl3V9ye3z
X-Gm-Gg: AYBFou3hAhHj9OcYsXWUCpPy7oJ65CF8SHSEoZNzfY69WCLE9s24R5b8DrhArQktxmS
 8uZjME/JsE2m0ESrn4xBivojW5+7qrc9mne6Xvofp3crt/Bo60MUKlHdgnTXbmz8MSHP4+7EdHw
 6+3rMj8gSTyCMyvv7gPx9d0eH+QkEN/Q5cFwnS0ftn03nAWub0mP1XTgGqQaKwS9US47vAZUP8k
 bi2OhPVlPdDTxxjxiwtX1aQufXHV58nQamCo5bDoZsbiG1hTo30ImOxxht7nN+qschW0rlfqhHS
 F7ZJWYDWbA66DWc1VhAsurug6cRXCJKkO/uMoCljQipfaHGVdueZmAzIVayIM5wXS+yR5oy8rCu
 QvzJH3gs8aenIKaYQgfhBN1qbP73M0CBrMMrK5Q2C
X-Received: by 2002:a05:620a:838d:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-93e9b700bc9mr311872685a.24.1791366412814; 
 Wed, 07 Oct 2026 02:46:52 -0700 (PDT)
X-Received: by 2002:a05:620a:838d:b0:93e:6a4b:3ea6 with SMTP id
 af79cd13be357-93e9b700bc9mr311870285a.24.1791366412349; 
 Wed, 07 Oct 2026 02:46:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17fc4a588sm43994825e9.1.2026.10.07.02.46.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:46:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 13/27] target/mips: Remove unuseful EXCP_LAST definition
Date: Wed,  7 Oct 2026 11:45:01 +0200
Message-ID: <20261007094516.75732-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: V26Jijj2l_Nx_0lWvfmyiFXAFH5VWLht
X-Authority-Analysis: v=2.4 cv=ZZiIpcVA c=1 sm=1 tr=0 ts=6ac6150e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=6PapexcjMrqzk0dJnxcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX16NI3n4pI460
 fuXHAmVW/N7dhSJpftC1zTZzMpSfc+llOvvRjQW1bVKmj7IJuHHsYKPLKHD+laGPJ0tp5yGbp+X
 8nRhzk7TVDephCevW4metDewUL93iPI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX9QIl5whwY8Xq
 O3cbHttbb+jY/wQWO6zGzYTLTbKQLb0uclTQ9WjC9uqs1Uzan1Q4Lq1wnjc/kMdFaZ4+kKF3G3u
 eAv/oHymIBaR4eihdRvo1NU5N6R5b8vlYuCBj51E+BQsbM3FJ/33ci0es/lNfnxIb9H49EB3gs8
 TXvjQzRKfoAqFTOMP9dWSdf5RnEgknC5qJqWsC2pvLbWdgrhkNYtHXUiDAUafeN0+RTOGygt4bP
 uYu5bYqk42NOsOURnRVu183+881yGUsBdU8TCkfRLuoCnibR/gVH4NjmxRDoymnpQM0ohYgJ+yM
 Xny0RjyvJkzB/+NRn/kclZFady4jTrDFkgt3mGXnwoMNOqWlbkNRuh0pZbdEN97xtrOakqBKGPl
 YPwwEn+/4i8cZu0DVrlsHLjmq9JlzVnkdZoIMnZnHZzMOuOK6D8xAuFjItD+kRURc8H5DXjnKj9
 FywIFTc1QSMRgMCYI+Q==
X-Proofpoint-ORIG-GUID: V26Jijj2l_Nx_0lWvfmyiFXAFH5VWLht
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

Check array boundary with ARRAY_SIZE() macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu.h           | 2 --
 target/mips/tcg/exception.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 32549791a18..5d8b78a70b8 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1347,8 +1347,6 @@ enum {
     EXCP_TLBXI,
     EXCP_TLBRI,
     EXCP_SEMIHOST,
-
-    EXCP_LAST = EXCP_SEMIHOST,
 };
 
 /*
diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
index 630b8b809fa..2f02f9be877 100644
--- a/target/mips/tcg/exception.c
+++ b/target/mips/tcg/exception.c
@@ -88,7 +88,7 @@ void mips_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb)
     env->hflags |= tb->flags & MIPS_HFLAG_BMASK;
 }
 
-static const char * const excp_names[EXCP_LAST + 1] = {
+static const char * const excp_names[] = {
     [EXCP_RESET] = "reset",
     [EXCP_SRESET] = "soft reset",
     [EXCP_DSS] = "debug single step",
@@ -131,7 +131,7 @@ static const char * const excp_names[EXCP_LAST + 1] = {
 
 const char *mips_exception_name(int32_t exception)
 {
-    if (exception < 0 || exception > EXCP_LAST) {
+    if (exception < 0 || exception >= ARRAY_SIZE(excp_names)) {
         return "unknown";
     }
     return excp_names[exception];
-- 
2.55.0


