Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFB606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jBQgCBgJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CC/cWvn2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKI2n-0005zb-Uy; Fri, 23 Oct 2026 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2d-0005mC-C9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKI2b-00038X-B0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:22:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5x2Q4063503
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ts79TeREy8Sq12zABKQMPXAqndH8RorOrpPYppY4wus=; b=jBQgCBgJevxUGLFl
 rjNVwmFz5wa6GlNn8cAyesvxT6xp8XOKyb63hxpgTSWQ078G7dAtgzFqzUiL9Au5
 DceQFhihV+OtNhV4n52c8reb71c29eQRV3zRERd/GO66J4btREh2ZOWyJ1G+ZpMH
 yvTdz83RbAG/dzeuLDm/9xVapS4G5ZqRoFPOfPLe73P00AioEERvhxmdyyyo/m9W
 wz1zNj49wIF9kCIxW1qMGQFWeq3fCH+nsMQoFtPgoABsKnxN79Q8AzHILdjh1bj5
 SoKOJIVJG4A3EkmgN67OikICTIlM8rkLKIFJsIm4BoZqcQBF8cwRXJI6jIiRRPBF
 /n4ggw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrchdj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:22:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f33438950so243208785a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772567; x=1793377367; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ts79TeREy8Sq12zABKQMPXAqndH8RorOrpPYppY4wus=;
 b=CC/cWvn26IrbLgnPRXfqfxe9NUul8XJLVAyYXMuLJPvxZEJzC0sc/5ok2aQR9tsPPC
 pDrAbRvYzFB/y0Cj22t+57kWmyRMFUHEzM0wEPGZtQHykP19YWm2RjC1TezU64+OePo7
 EOZsmPxwe+ElhuoJppoIy16Gj93BnQMLeapGx9S1g9P6ioUXwwhl/ROFwCNZsSXX6rIu
 VdSYDbimjLsKsD+fYsZbTSRY3freRBvFzJz7i9eNSgoLWgR2v0/EwuygVRdqFTkOX+k/
 ZPhXYDzxEWcwoSSpE6YWlVbvXX9AxKn5/qbDIHaQxOt1Nz2V22eYNstn8v+ASwrEr0rq
 pjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772567; x=1793377367;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ts79TeREy8Sq12zABKQMPXAqndH8RorOrpPYppY4wus=;
 b=ojYZBXY1uLMna7MZVikRqOd3plBTqK4JVcDU9Lx2f6WDRYbggcudzDD5r25CMsp9LS
 tNQI6ybBz4+jCg4uMVI46IHosLGM/I6nb8OCwQszTTCLUZ4rA6H/Bwxu63HMcYGCycxv
 eoBNJH3LYztXdPYQe7leEumN/9W6VxQCj9WuKtSAthAijjFPwMKonNyAtGzAiyw5n/mp
 fkc5iIwHfd3RYsoSUOJFUrT0JNHNzorzMCjeAN7gARAz0GVLszd1L8/xuiZDw5kY6NfV
 V0il+VGIAV/H7ixyrmWnPt/6gVAQKbwQwmCoOdXhX9iw0OJ6DUZVFHGQvR5c+RrabI8n
 7V2g==
X-Gm-Message-State: AFq9FYJtBlJgdcl8HVrqbZgnRqEYpe99yEebnu9SD+4Isgk81hHI5ult
 EOiTNCcajBU5+Iaj6tsjc1ufAJytRynrF0XmKXdBa+FX4vaC92W8vz9EAu0B5+9xsKSgoe4hIOx
 TLNszWnNPrugDcw0N+YWg2izZjTgP6U8Us/Yy3u5MqBzE6jJiXn4w4jGOj/KzDDwnJkCu
X-Gm-Gg: AYBFou2aC2hv7luqu2gKTj1HQlL9e85T8Pv6EAugl+x++glTVYvvl8uz1E5EzVNtUNq
 POMP9V4LHcx/cQ2nIWIjHaDxy8v1I9/kkCNtRZa6P0VRJQD94HYNO5jb2rXhky0yi4wRElbUOXB
 9KnwA8vU2jkBFnqe1V4+HBdTrpcDu/cV/nQa9yqCOSRGu2oXm3wX4KQvkN7mXpVG583c8YwAJxG
 YLbbrFXVaFFYgMKSS687mDXHyPXjfksK4tStKrUjvHqYGA+EootKz7nV1vVBfpjwJJb/dxKJ//g
 EAZCFHj+veK64LMh68jXlkaOkneKAK8hkRTTTIXbt9I/HeHTvJxeCKotklEjAoZTVVkl8Ou/c27
 dwg7Qxss2AW55rJ4+EcQV3/LnVFT+mu2OTwWZ8yXq
X-Received: by 2002:a05:620a:2688:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93f6f3cc32cmr504437085a.0.1792772566883; 
 Fri, 23 Oct 2026 09:22:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:934:ab73:ac53 with SMTP id
 af79cd13be357-93f6f3cc32cmr504432785a.0.1792772566294; 
 Fri, 23 Oct 2026 09:22:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d405cc0sm735823f8f.30.2026.10.23.09.22.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:22:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 76/83] target/hexagon: Convert to translate_for_debug
Date: Fri, 23 Oct 2026 18:13:24 +0200
Message-ID: <20261023161332.60153-77-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zQFki3SqotCBVX1Ke8miVb0MMj_OsnOc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX44NfSyE/S105
 XrVZGxAHiC5GUjJb9J9AcaIzvCt4+oP3L83mmWGO9KkDad5JWq/aAnr75sRFsORzyBv4jrATqjw
 4vjd11bzW13mj7+IkBpVzhLXduLn9CE=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb89d7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=e5iG3p4lFUziAqCKwoAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2NCBTYWx0ZWRfX+INrABO6p/S6
 u9419qceCY5aX/34qrIcyu7VaJX/rnRzG/ZGdKcn6QKv//QKEBeDLrRy+n+8ATG0K6hb1GsfgDk
 6HgurNo/fLLxATu14I5eD3fNePEbF9CnkMunRj+DRAlTT2SaZgj7kJXwL5MTfUh52D7nzEIE+2p
 9nbo491BOKw3xeqD94C3NF8I9WuWHpToA4W0XHG3rtJYtRZCysgrGZNC3vWLtNTTNUsu/nB5eSF
 cCG5DHpbG2r9eqYcI25X7oFHQgKB6W7fxVh5zIxztj3yJsNDkFqfo3FSttHo4p/u8lT086+Gs5I
 CnxPnvWk8lM0DoIJuky51wQW5SqJ976UtU1l4jR+So4FUjshxuNJ8Q7+700ClGQzpqjEMo4h4gB
 d/8NS4kFXgRHu0aWZFSSJrdCKBvlZgjMLZYHyDe5py3Xylq/2p5m4idRhetKhsIR1W1GP1qUQCI
 JUlagNoI3DIqghLOoHw==
X-Proofpoint-ORIG-GUID: zQFki3SqotCBVX1Ke8miVb0MMj_OsnOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230064
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

From: Peter Maydell <peter.maydell@linaro.org>

Convert hexagon to providing the translate_for_debug method rather
than the deprecated get_phys_addr_debug method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261022125858.310252-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 8df63e43260..ebd77e0f7dd 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -646,7 +646,8 @@ static void find_qemu_subpage(vaddr *addr, hwaddr *phys, uint64_t page_size)
     *phys += offset;
 }
 
-static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
+static bool hexagon_cpu_translate_for_debug(CPUState *cs, vaddr addr,
+                                            TranslateForDebugResult *result)
 {
     CPUHexagonState *env = cpu_env(cs);
     hwaddr phys_addr;
@@ -660,10 +661,16 @@ static hwaddr hexagon_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
         vaddr page_offset = addr & (TARGET_PAGE_SIZE - 1);
         find_qemu_subpage(&addr, &phys_addr, page_size);
         phys_addr += hexagon_cpu_mmu_enabled(env) ? page_offset : 0;
-        return phys_addr;
+
+        *result = (TranslateForDebugResult) {
+            .physaddr = phys_addr,
+            .lg_page_size = TARGET_PAGE_BITS,
+            .attrs.debug = 1,
+        };
+        return true;
     }
 
-    return -1;
+    return false;
 }
 
 
@@ -789,7 +796,7 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
 
 static const struct SysemuCPUOps hexagon_sysemu_ops = {
     .has_work = hexagon_cpu_has_work,
-    .get_phys_addr_debug = hexagon_cpu_get_phys_addr_debug,
+    .translate_for_debug = hexagon_cpu_translate_for_debug,
 };
 
 static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.55.0


