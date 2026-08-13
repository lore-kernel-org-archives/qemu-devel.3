Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02570C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wua1N-0005AL-Ft; Thu, 13 Aug 2026 14:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua14-0003rs-NT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wua12-0002J0-NQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 14:18:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFU4192375717
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=; b=Zf/LpJWyOil0GNtz
 GRXsvvUH9b6DPhWH8Su/QEP2fUsUChulGo7bBXRQ9026kAMnrHuvNj6t6MI+Jb1w
 21zVNxSX8kjkWRW3IRFRzP4cvXZukRrrWAosh/pYdmlMxbZhc0Zzi3nzkW+zOD9A
 hG6/U5SXBpzBIT7Y3ibo5Ptz4e1NKViVUTJZ2bKTPE7NLKqXMOTZbnhQXDcfBxXE
 cbAEdqtFP5o7jecRctFwW08J9etnwAoi3Hz7xSEWJYO813aQPbbmImIb8r7fPRiq
 mwa7KRf8kumLiH96qsR2ojg9YoehPXV74ib8m/t7kR7YfRXxnn2G+8RfHpQj1EJ0
 Ts6P1g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g14sykxta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 18:18:44 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eec6acbe21so2417106d6.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786645124; x=1787249924; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=;
 b=TX65oUiGWwsjk7Md6xdqIuAvgQnvKHGShuQ8Eovv+26H0LGjnQRphxpuJy8GHvZc3O
 PSAIiQ+Oxg6X90FcG7dGKu4X4to52k1QgNbaD3cD1n4ozJxMU/zvsp7iOKPiwu9Rxkh5
 y8KAXb47xej10Ly6VM3+L4b3p7tE/fiFrtBaM3Zmz8fKykixXV81shbSQ5ku3Gxwa8e4
 Y05lj4yCFTCrWeCfZ9y/Pwj0IY//RWzjkeA6f5PXcDxwd1JTPkIGBjATMlBxAfHRmMj0
 oSn0+j87ISi8V/JYHBnJodSb69eZGTTvkY19KnSHWeu4t19yCRUnqjgF9DkCQ8irSiSF
 TY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786645124; x=1787249924;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iZ4CQeHz0iJrXPv/eT7hao6uyv4DFIFygNCZO9k79Qg=;
 b=cYNOFLGvbA6xQkMawpl7yqTgUc3B1akoL608VlzOykpzHToM5L2iCO+hYKEBPmFvr5
 CmS33ZMMBDQEKaNfSKBrKxxXo/6qtp7bCbZx4hYuvRUpRC0CWGbNY9wRHcIGYTKqzgO8
 Rt1ad14Mn2e72heQi+hOLT/6MXFgiHM1FuM9bXUkVRjLQ44F8otmSyDAormTm6kOkJhV
 hV8zV/f7ZvBPwEOAU68rzP1V5O6nNLVQ5CkBAEAxXCbYdWuR/E7yAQ3eoFsrsWbdluMd
 PPKEDBOStzApafdhHh39PBC4piMAv6pWLu1eOrPzrOLVFGOl2hPpUryMdW9BDj5Q8e2h
 kjlQ==
X-Gm-Message-State: AOJu0Yy1D4BzhJAuUEayLx0DdoUNkdlLiQPSgPPzLfl1zuG4VUZWyXil
 B+1B++NuZ3pmcc6F3Um0HBdu5ShA77yhIIt6hUf01zcXlSHXEYwVvCAuzQuQ7F2UL3zKnM1eQ5O
 dqXFP+NkyJ1zi5zpA0LJmD230R4dsA8hLPpBiQ+xJC98Fm9Z5/gPD4Lf92iVMejkb4w==
X-Gm-Gg: AR+sD10DftiZPnuG11PzYd2NxJ+69Rw5EPHgxNCy7WTKOqFBIQfj/41JPPWzn+oL8R+
 e/M5Bfx81wpJGIgLOLSC14BVqm7kJFVauMPR55WAgd3+MrQeGI9ZyVsw47UNJhNn61RH2AC8Z6o
 FZH+FuF5nChOvSMfWM+OLGUJB9u/Nb3SK0fytcgRPie165uRwCzHSq3m91KMhpt93bNjOD0t4/Y
 KSZoAz9irRmS6dJTVgA10XKJTXROjKDkdkhLCGp+5CO7YtoHLBXlac4PVHRcR6u3KKfrRUfpU8a
 hmoThAWz8AVuAUQrFdPgCj+It6qxg790ZGlRJ/Y96iqM6XmDOmLS0nVs+LPSo2btXIlbrsd/xYr
 n7ZigXLfWMYDcuK9sxK6rU3U/t6BTlMihvZr4WNKxKQ==
X-Received: by 2002:ac8:588d:0:b0:51c:103:fb56 with SMTP id
 d75a77b69052e-52d73c6fae8mr83158361cf.15.1786645121413; 
 Thu, 13 Aug 2026 11:18:41 -0700 (PDT)
X-Received: by 2002:ac8:588d:0:b0:51c:103:fb56 with SMTP id
 d75a77b69052e-52d73c6fae8mr83156831cf.15.1786645120303; 
 Thu, 13 Aug 2026 11:18:40 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982129643sm73839635e9.4.2026.08.13.11.18.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Aug 2026 11:18:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH 16/16] target/arm/whpx: Fix argument order typo in memory
 access error message
Date: Thu, 13 Aug 2026 20:16:39 +0200
Message-ID: <20260813181640.6537-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZcQt8MVA c=1 sm=1 tr=0 ts=6a7e0a85 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=sWKEhP36mHoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=CJsRysG5a4fyhNKOOSkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX8uV6UPsO8AuV
 4JIZ1OaulDo0oaEsper/O0ZrpbYMj+MyhptLX/00IUZSBAIJ8sXL6CROamQyfo5KvdxCY2dT6K9
 KIOmGZev8KC675DzZjYlZSliM7jEpJEtFh2rSj+av/hW5Gmz5Qgkc20vjX0xWGlcW4U1o6sXLg8
 b0Z6E8a9ORFdPdXUTWck8Il0K2QiC04e3iD+za8EymLp7mJc7r89S+lvpVeZXDTOBftSskME/12
 ZwUJTNZRUIRdKt6mJBP9Uq3FfaIqX1PAElE9MHT2SraYwZXy4N5zlPNzUva+Bq4IjptYq8i3u4x
 TXuNA8LMH39nGRCJOak4Qb4iMqW6HulGRh5fBPA4omr6l/TrDhRvM40meXHN7i6qP8qOXwx2JyG
 bxe5FZhcS7BRCys+Ay5L4VznuMjmlK0+SZidh5S6W9CMmg7KYX5QPUeAPbRBkLmRc6u6hbF0GOK
 6uziVl7W/uvf4sc9JQg==
X-Proofpoint-ORIG-GUID: 71EpXrCSr_ATCylegEAfLTW3GYByVIQC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX9F+JgK9lEzfA
 eQCrPgVc6CAiDzGR8V0i6AFAF/60Kzt7kCFXxR4D3vzn3ioEOklUcBmjXtPFHBvoAaLO3o+pFq8
 tD1s1KoAeu2ZmhF/UxMfzt0MCEqW7yo=
X-Proofpoint-GUID: 71EpXrCSr_ATCylegEAfLTW3GYByVIQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The format string expects "Gva = ... Gpa = ..." but we provide
these addresses swapped, causing confusing misaligned debug output.
Re-order by swapping back.

Fixes: 59432082cef ("whpx: add arm64 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/whpx/whpx-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 5e4c25bb7d5..e59580d54ee 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -442,8 +442,8 @@ int whpx_vcpu_run(CPUState *cpu)
                 error_report("WHPX: cached access to unmapped memory"
                 "Pc = 0x%llx Gva = 0x%llx Gpa = 0x%llx",
                 vcpu->exit_ctx.MemoryAccess.Header.Pc,
-                vcpu->exit_ctx.MemoryAccess.Gpa,
-                vcpu->exit_ctx.MemoryAccess.Gva);
+                vcpu->exit_ctx.MemoryAccess.Gva,
+                vcpu->exit_ctx.MemoryAccess.Gpa);
                 break;
             }
 
-- 
2.53.0


