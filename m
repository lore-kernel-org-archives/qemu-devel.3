Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B455C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ22-0005hg-FM; Fri, 10 Jul 2026 17:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1f-0005Pl-Eb
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1d-0003Vg-QA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:51 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ALCl6G1931562
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=; b=oz7AHSoEVdqJQCyN
 5iuo+DNZnC+xeXMb+aDifJjmqwNMFAX9f+epGw1IUAxWznpDZV222LcpDxlC1isM
 7IPnXEHkDGFnQrEgjyMGbufUfpuLJOiX5al5bHtA/SxxXXLI/Y+ApfmodBwL1UHZ
 wwNwSh3HX2AUMUydtx73HX78Q8GX8PxUHvSJAsnZ06DW9p+CaR+CenBmebwmPg/E
 YPDMKrrr+PO341wPTZkKnSpsO98DzgNk1U7bQho2ViAoIE9+dyOLD6VFHxvlhPEa
 HglVYH/QWOwzeZRxBugtB+Y4M/WYa3suoDonFaFIeBu4UXiBZbeesiq8XePDm0Nd
 IVMH1g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb8f2r2kp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:38 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso2059111a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719878; x=1784324678; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=;
 b=BocM6/ck1j4phxRup0YL+uwEB4aGs8V9mp131snqcFbvC0DZbRg3k+Uh2naIZOamuH
 qrIuXV8jc9hI8wQoyMKcxxQvNdyC38XyE347P58JarRHHMhdrJir4DsdVdAmXgKSH5PY
 8gF19vqK3Xza8FQYimQ0gDHuk8yiFsWc76bk5waebcGdoM0RipZZdgpixUso42cYyYct
 kBMsRCIu9KFGRjUpEZxp5s250WrtNdSIOH5qm1mBBCUlEhNNm9EyQEXKGaBrl5M31U3W
 HgiqLrzfPvHJPuehzpox0DK3otraxCujQt4hnCYVVkssd04PdTT96S+CUVNEgKB6qPfA
 Q00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719878; x=1784324678;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6qG7zCVGxjw8Z8MwNGwAb2KScaQrvETMjxwX8VWO6tU=;
 b=tVEaVreos8cyrB+eIFetqWWq0/ZmMWsQUACqOrDo6d/975UZNrl9LrmkPNuKRIGsQX
 J2AVf9O790ztV4Rd3Ud9ldiR+gRYggCuOPaBgCikLzWM9C0wGc/0NTlBEZjbODFKcgcP
 5neAgZX/twIGrcVfQPbgrkHk9Pta8PAu8iQORBb1ZVcXLJkhBpqmHUPJWSOOkj6rOlBi
 q0svVBeHlVZbCAEjmfnOy7eRnrYQx9P/k97x0JfRm8ADYd+zC12xGa/loHrxuq3D0fed
 cQIyTARFayH5uUpxLQMr/YDI032i389BXiVIl/TCJrXvsE3M8p7W/KAS9HegDJQ9dkgQ
 oldg==
X-Gm-Message-State: AOJu0YzIQWN++hgcZH0LGsTnNJj6u3Dg5KJGoQiwEoVhD27TiSBm9+lt
 YBQIK1St9R8V52ulPaYHuAK51SNY8usc8eycTXdtd5lWxk4inWqsp5e6v5jD5eBNLwvS3y5WTXJ
 J4QL7lEMRDZpj+sO0eFepJpzcR1tCd3S78xSVVuhbzMaLJZBZMW8XkeGuk0nbG5g+wA==
X-Gm-Gg: AfdE7cmjZntA4CquNnUmUZPE3Ls7c8hxQakjRln9TYWvlJoT99yxKFU79TXxjA0Grry
 nnRcHB+cvgRXrtOJBQAkG7Y3qoUklB52SAoPm74RoFhUvw1Oi0Mw0DwNzawtzbxoznNrAYg33zw
 5CoBBhZbD5kIr49WQZzv5HAAlnyO0DGHQK7UU1ZKWGHzWY3nhNzUzPZyxOVLddepHaOE9RqnkB7
 dcD2D0pDjHIkM3JoizvDQ2FUG+GfgVT6R91r02h/lB0eWNU63hdOd/VNQr2w734O9D42uIb//pY
 QjHGmCwg1E5xJFQDgcoVlKUhA4CDkzc5H8M8y6x3uP7cJLIVDqNwITLpjFWCEIrGqYA7/3dn4NQ
 ujolD6SEUoAAoZVb+iMMIrFKfvaEnZwzYF9Bsr+xOBMSL1HOBug2xAcMqdDK7wqMPMLKEi95Yep
 RUmOgL0A==
X-Received: by 2002:a05:6a20:9190:b0:3bf:e2f1:1b12 with SMTP id
 adf61e73a8af0-3c110bdfb14mr751822637.41.1783719877935; 
 Fri, 10 Jul 2026 14:44:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:9190:b0:3bf:e2f1:1b12 with SMTP id
 adf61e73a8af0-3c110bdfb14mr751799637.41.1783719877495; 
 Fri, 10 Jul 2026 14:44:37 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 24/98] tests/tcg/meson.build: move gdb_arch support check
Date: Fri, 10 Jul 2026 14:42:28 -0700
Message-ID: <20260710214343.2065491-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLavDxGx c=1 sm=1 tr=0 ts=6a5167c6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XzjeZAZuwW6bxlwlfogA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6chedglEOtNywq3ASbOrEm5VpeSxSa4F
X-Proofpoint-ORIG-GUID: 6chedglEOtNywq3ASbOrEm5VpeSxSa4F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX6ZPkiDQw8OID
 sopghxol5xAyHp+jGEJpPMaZVqdMU5Ay1zroqu4CbJqRzGypCF4lGU6hweO4borXoe0ql33giO1
 KuAcna1VcECG8yPoUwo5BYvvuAjOjWs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX567a2Yvpd8ei
 MR/ibhQFoUPtIxmUD5qKjVeVmjKMSF/vImB2PVUjdMtCdq/L6Rdc0GBnsYargPCNePcUFlL3KYp
 QckOsf1KkmkOiQW3j2OTdAgFZOORwb9B/QHnPJjciMLNLnueVZKHNqwoC1YCvE0PxodmkW3nqTq
 Mq5k9+mW3slpHXy/lu+5setRtp3wmfmqCjgTgYgmZPrXSzLx+CVpK9UWZhPrXM+J6W2BSIgPyux
 cnwMfdQ/LPU8TltMdT/wx20YaAvUGVH2G+SJihXGSUtkkbOz0+svzXfXraonaLUBomcFP9XF58C
 l6C7UHVbO+LkNKXRFnaU3PUGB3RiKRWwVLy65gAOkDyQ6ctZhGYyTDGjZaQd09Bl5ylrYsqs7YM
 fk65LQCThoIcTm9MrDZecNNAGjuW/jW4LsEtjCRtEPCQYoDBYMkrMDYKLvylmhhe8GNMfd+4AVJ
 EEGs0uwbUH7VoA92Z6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This allows to report the correct skip reason instead of saying gdb does
not support a specific feature for some tests.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7384786f7f8..c227bb52381 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,10 +138,6 @@ foreach target, plan: tcg_tests
       # if set, we'll skip test and print the reason
       skip_test = ''
 
-      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
-        continue
-      endif
-
       if 'plugin_test' in setup and not get_option('plugins')
         # do not use the skip_test logic, and simply ignore the test
         continue
@@ -284,6 +280,10 @@ foreach target, plan: tcg_tests
         endif
       endif
 
+      if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
+        skip_test = 'gdb not available for ' + gdb_arch
+      endif
+
       if skip_test != ''
         # still declare test, but skip it and print reason
         cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
-- 
2.47.3


