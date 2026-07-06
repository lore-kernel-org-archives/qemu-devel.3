Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38739C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjgy-000571-4b; Mon, 06 Jul 2026 09:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgx-00055w-AW
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjgv-00070L-SJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:48:59 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxM44218465
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ezeLT7Aa/ivxmDquoUgoQqlFhX4EdGQYaOxRI/LK0QM=; b=kzMFlwvbvlcxPeef
 Xc0lv7SUdCCaRatqKX/KLYRU8cOavylDMYX+ME5h1OB3o5K4PLYxijvjbC50H1lB
 SISpi1/8eYiBfHjLo5Lgj3UAN398oqRjJVI6WtZQC0DITNXIayLPGV4y6V1GhrjJ
 GJrJOMgk1CCT9Zr2fili6ozJ0BShQavaS+CTavKCHkFfhZafVFSU9IcrxteqYL8Z
 2uaBUCAcminVHJC3M4FPMkkZhUGXoCsgj1mPlTDkoDCEQ5p6qBiS04yEuQirzCaX
 YWW8q6u4tztETXEZ9w6d160VA67xov0yuISQ6C8KnmK9jJ675PULiU9ygnArKvQg
 /Oj9lQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hs9cfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:48:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5740so351251585a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345736; x=1783950536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ezeLT7Aa/ivxmDquoUgoQqlFhX4EdGQYaOxRI/LK0QM=;
 b=Jtn1FAyqESJ1pUm+g2SBKc0N15hOhoMWP+3zK90sNOCfAghENu9P68ihaWIL3r/73a
 uVWzFaXK+PRCyry7E4iuKjGqVv0JjCoZo73SfkFpfnsVo4DToz1jSw5nUeUzG8rz/OUo
 78gjlXZKAf0VM7pgec0o6hA5NEtyl8BCFF7qwipez2EOkHVEoedE3UlmPqJ8s6X3f5sh
 /tqi5Y6j0SIW9NgEJAJcBduJaZdA2CxcxlMPtoyPG2D3+2F+jy9AXXNSUwtciWBOBEej
 RqjQVkbUrll2tIfOwPHA9NpmUowVDVvaxIciCyZQemtqSHZfE/34jR/ABDBE9i0QeIc1
 qQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345736; x=1783950536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ezeLT7Aa/ivxmDquoUgoQqlFhX4EdGQYaOxRI/LK0QM=;
 b=BmbDvIGBu/LZkqN6zJM8vkxv5vYdFKopbXUhF5L+bNIv3qzoeYqzyhcovzo4TNANT/
 p77vsPwxpeo7Fs0rfOYJ3G7roHy8a8iEbUPZwkFVep/UTWDr7OrBNIBJ0z+pHIld3c25
 qbpEQT3atrtQFpt+TwI7YJvg8YUceV3iVwbUGIufc/1MIZAT8kM9i0d9kVgsRrvu1tjR
 TVvhaLlJxByYSTtRxWuCLNLHmTAFuWbn3QDXYLKRg7I46Zf8BBDP66vebb4dbWHVWQmo
 +aWLxKU2bbSCkD0TXMyQwhqVAwl/XMn1fWCsEIUTT0pmAvKhgtXndDeJHyUsNDzh69tn
 r5dw==
X-Gm-Message-State: AOJu0YwuUwh8sxfN1JWwDDZCSkgVzhK0iDC+jZs1UJ5TG2EgX6T+TCwP
 I8jAVh17dsNNNw2AqPDLb/buw6jH9tIpyTHc+Ek+MdeP2JybwIgt5no0NA7tfcvajBc2LXMtzxW
 BDALy76hDOClyHMz/1rtwH2+Y2ibXHWvmjYWkK1oc5Sy5PrO/U0Qcb3gafLKtuTWxiw==
X-Gm-Gg: AfdE7clT2SMcKEwqwHr4meZ0KylCkS/9boN5EtTBiqa8jZE63MG2x2MkA3DyC+nG1FD
 fvbZrD5QpuNKHnzpmR+Y93InrTz2l+atwoBeghxTzY6Is2dyIy9/WhBl+z5YDAAviQWeBSv8FgE
 mHU+RlxuE8h4mT8kMK9QGpSH5JsusgFj3lS2xtiqzHKFaV13DdNjcJTtSitHpbLpRTn4WCaq7Cf
 5IcYqij23hS6hNg6lH1GU1BYvmGNSCrpdgDoyWjh9F1rr54LSp4eoUP11HXv9PYqdFEGRAi3Abc
 L7doyvRZRLc6ubrhVxmkJnQemruqB3yXXMbTr74dR3CRUtOLvJ15dz2hc4cgYkIVSH4DVqawAhn
 JYB2tZ2X/Mjs8CAnwhJXnjeVsL8oSft+KBvG8rHSaXLegQcXHApU6AbKrrg==
X-Received: by 2002:a05:620a:1a0b:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-92ebb5e23d0mr77959885a.34.1783345736215; 
 Mon, 06 Jul 2026 06:48:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:92e:76a1:96d3 with SMTP id
 af79cd13be357-92ebb5e23d0mr77954285a.34.1783345735474; 
 Mon, 06 Jul 2026 06:48:55 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cfb6f199sm261861475e9.3.2026.07.06.06.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:48:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] gdbstub/user: Directly call gdb_breakpoint_remove_all()
 in user mode
Date: Mon,  6 Jul 2026 15:45:17 +0200
Message-ID: <20260706134527.84808-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: AgLh_rmb3eQ9Ug1ouBgNnWSv-xvC5No3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8ndhkazqgIkI
 SHcgXiYLUOO7JzCq5ww1MkRx2ifRY649dVcOFJk/vMnJqjRQ7ydjrls60ppqgUVHtWJgNO4azCg
 OrGC3wYdYZxUXCYayKm9G+3ZLKcEoxHIssk8qLRd9KGSui6ioqsUr1OMs41rlS/vcKAHAVe+fJ1
 I1mA5eyVBb8VTLyZ4eSqnLiZQzA7tc3ojYaYaITQJdi2raWAbQH3G40ltro21gpJ0QJRPuOWfx3
 QIUxBgJSmlp44wjFF/3EXPAbr4ySxkXjkXNBiHPOrZX03EUDHhHcgLAwX5KiGpRcu+7FFTJEeiT
 T+IhLbKVP4jdhlUp+rdq8bcSqPhHvSKZ3Dhd3QXUDTNdZqAiekig2rS9YpcjymxW22iAwJRKRsB
 E+/19HCgatw1dRSPbUiNToI+CUHXxEMrICvsrqlgHWQ/ajKhUGS78MwsnRJZ+3cLE+SIOSsYcG2
 anpwLb8PGKmFq4gbZlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX8Og3fJpW2MnL
 kCyW9uiIrp2PCdqA8Ffpeggo1XR7spMV0v1HOzkj1gjqI2zFGAKwi7vT8BgnhwLLzUXUwLtEdUa
 MvXcUDzzf+FHzacF7P/5bPksWdmvn38=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4bb248 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=zxLOgqzoZ8asriTz2EMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: AgLh_rmb3eQ9Ug1ouBgNnWSv-xvC5No3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
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

No need to deref external methods with unused argument to
end up calling a method defined in the same unit file, call
it directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260705215729.62196-23-philmd@oss.qualcomm.com>
---
 gdbstub/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 299388b9f71..90d6ee49fb5 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -557,7 +557,7 @@ static void disable_gdbstub(CPUState *thread_cpu)
     close(gdbserver_user_state.fd);
     gdbserver_user_state.fd = -1;
     CPU_FOREACH(cpu) {
-        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        gdb_breakpoint_remove_all(cpu);
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-- 
2.53.0


