Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0624C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu80z-0007PZ-Sp; Wed, 12 Aug 2026 08:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80w-0007Nd-CJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu80t-00023c-FZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:24:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4F0b3320091
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=; b=cCpbL+8pqNtlC6C+
 vEAjazCbEcGbFiQ7XnSTf8uFgiqCRnX0qvu01dYRt998lqUVEOmTLlg+KjpAS1sl
 pgL/dFAcILQOoFgyE1qxi4+OaXgn9USDDiSuweGf+SMKgBD1C+ZOrDmjpDfaEDK6
 vSpjEQZhEEcDtyfOm0OEccnnCyrHHqBx4CpAo21TkycF8gg2MWWz4gFx+9Jg1pP9
 0vhn6juom7IU+3DRwLzSDKr5iD+L7bZ84X1VDzou4/nU8BD8w4KGBEVbKOIED06u
 Khd7FQB78cmHra7eABDYwXWKQBoZxFMyhZfllBS4L6kyyW5q6dNhnVsDFjERDOt9
 DxuwiA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0pmyrgqm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:24:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5283fa0656dso26105751cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786537493; x=1787142293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=AqdYu4Mk6Q90oO9jsrAcqzMm/rKi+CsxymVwqNDqKDUll2oXPuBB8Jr9VIGscvrP1x
 hWmP+kRh8sKGZBdAaSbHac8NntMsnS7ZGU86XEvQnI3E/GdoMEFCnV0FjiMVvONEkT6M
 k80jl8f1sDTb2TRx136Gfok90yEqSCeEKt2Qu+xC76At2gA6Hca8nkIv2rWsgV4aosoR
 NHMB8Ln/egndvWSQi43rWdMNhqF9/HeeKOdXyAWAESvX6PONHxuGRDJ7Ptj/FmABEF3V
 8NjWG0DqGqmEvWvgjISaSS0pzB9kvnBReaa52P+4q1zBZT/oFsM4lmBSQokBHIkuVC5d
 pmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537493; x=1787142293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=09Cz3K5Hfu2RAtmfX/9+Mk8nsbjxtr/nJzshMm746yo=;
 b=OCR6aP9oE9lo9KJ9Bo6nqJx/E0LOUUYasYb9bR8mgmga279fZVQkCIYqUS7B5T/RMC
 QB09LuABjEQUhJ6ioA74GCVHNt2cMuG6C6bDfaabblxVnrkMHmeP5m1Enduy3MlWQ8yW
 Wt/8e0VJcWoIS4LLAFI96RJg9F47lWnx+ROcXaPL4jq7Pivm4et7NaLXIpNjyBH18jz5
 wPARyXS50zFfPHzdXPvx9IPqjz1FQR9HpzUCpMBGbQBXL3E2q5xhNiLxlX7pc24Asrx2
 GIt/IVQKVcLcPO0AMKdzX3ryDVSrEMeq0+OlFpWGK1P0XnzXUwCPMrgJEf67aBN7kKCO
 Y6/w==
X-Gm-Message-State: AOJu0Yyd4bfH6dRAXbdpwYJETSYQ2y6e0q6xjwjmIIqY0qIshGvzeTWP
 zQ+4UDNpSI2YwK2Je5+6VPefzF8PXU5bYFSuFSlxAhoimK586NKzApPGujCQMd9cI6tUmN3B/jN
 bwBkCHPROBGRRW9dvr07q9C7n/9KejtodK2+ZdzSF1Mp7TUyXbvr1GVbG7wxSVZZ2bQ==
X-Gm-Gg: AR+sD10W+ALHG7zhLYQ27Fjvu3DcDEJXoYhS2UYd8JdEIK5VWPep6bQzAI2BXAvvbuf
 tBGTqnPC0D0KpKzYfKGNHOZ5jQGmZCvbXG/ZAMFYASDySj2cCMh0vIFvbXwN1Ch7YrvGVp49CNd
 oAICNfEGxIr8WvUhaF1kCSKNYkdyxTVpKX5I40EyRR9CMbH4EwnZpM07zIo9bH8+iESp6GWWXoM
 dXkpD1g0P08lIJAIJ3uTkXzG6PrkD8b23qmY8p+OmiNrWTqAIXhehIHX+gqsJ3zTAcEKx8IgBjS
 XNEFzL6CUQnR8LpBKchOoiB4RBK9tb6cib/64s6fgZr8udG5wnoVP45xro44Mu4u80bbDj+moX3
 JAm9Rhg+qiMg9tDM3P4jpXp8IiytUEkRm1tRWOU+BgQ==
X-Received: by 2002:ac8:7e88:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52d601b466emr61985391cf.1.1786537492999; 
 Wed, 12 Aug 2026 05:24:52 -0700 (PDT)
X-Received: by 2002:ac8:7e88:0:b0:516:82e2:7788 with SMTP id
 d75a77b69052e-52d601b466emr61985051cf.1.1786537492556; 
 Wed, 12 Aug 2026 05:24:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c9942aesm41861205e9.13.2026.08.12.05.24.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 05:24:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 11/14] monitor/hmp: Remove unnecessary 'monitor/monitor.h'
 header
Date: Wed, 12 Aug 2026 14:23:28 +0200
Message-ID: <20260812122332.72975-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812122332.72975-1-philmd@oss.qualcomm.com>
References: <20260812122332.72975-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfXy75Udvem46zH
 GUDpMiEJNOhI4dGbNv3yhnQF26Ljd4aYJ47UCzhofm8DqjO1iw7ODh0d7EiqXTsr3jTMT+mCQQZ
 HhS4NXmWWuDUhcJVcEmYLeD9AZym00Y=
X-Proofpoint-ORIG-GUID: uTzDH2_7qE53AWa3fAWz7hsilIbTCq9R
X-Authority-Analysis: v=2.4 cv=C/fZDwP+ c=1 sm=1 tr=0 ts=6a7c6616 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-VyI5JErSVUQEuwvVSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: uTzDH2_7qE53AWa3fAWz7hsilIbTCq9R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMCBTYWx0ZWRfX/BlO0PaUO/1k
 +VUBAcgvcSx4wbyaYnIB14ZATOHTQ1OGlR3qQ7uPnM3D54tiQZe9J2ZUf9ii+cf/VJCLKjH4Gt9
 Yr8Uxn1V2rkvONs5o34hEf4e2DpcFhMpS8dj+ElP356Llnq5fiT44PAYEW3jN6lHY3jNFQMBjCD
 hgfly6UBtld0qwCXxS8ZNlfvbeS1EszrGhwNieuBr2/c+ow1I0311zDAbjbdyluSw/FzwSYDKb+
 +u0wOh/tiSIT1Es4BDfBvFRupHwo0lWnELhbu2UFXmsMEvmWAOoWf4gy6WDRIy+FY++0KHa4Xne
 6zItnGD097dGu5zgCSsHeiHrsfPy6oWf35nbh0qyf6QVgy5igwEpIrGq40g3pr/nyI1DmBAOgl+
 kZdY7iKQ3HzgVR822ST4SSSSAn5OeaNKMiJ2G9lxp0Or9ERSzmw0RnybCaXZ/XFu+vLEs0dxGA7
 8505Gp+NmjnVEv38bjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120100
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

Nothing here requires declarations from "monitor/monitor.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/monitor/hmp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bff..9be7fe28988 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,7 +16,6 @@
 
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
-#include "monitor/monitor.h"
 
 #define HMP_STUB(cmd) \
     void hmp_##cmd(Monitor *mon, const QDict *qdict) \
-- 
2.53.0


