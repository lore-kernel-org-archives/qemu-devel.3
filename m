Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE2FC88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HLR-0004JF-5n; Mon, 14 Sep 2026 20:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLN-0004Hi-Ex
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6HLI-00049W-Ht
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:48:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxd041983822
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mUGuWUujQTh
 1SV61sGuPBe+ZIgo/M4JsAL1QiprK/Qo=; b=KsDrUiGMPvWKGIuYaJqSo44NKYC
 yG4gg/uR0VtXbkB+btd+tmTQbcT2P+ogI+UGZFMEwWIbrgBEJgJVnQ5ECFgUD2YU
 b37BM6RbSlLJJcybZYRTy2IuwUzuhMJ2eiTJ6cj75F6W4I9wPPZ2i1emszaVevBd
 2omZzpB2Fz2DtzG4StJwKJPNjyWD8+STPXtD88bkvIGqObPse+fXIQk0QLrx70Lo
 FH7vsnazb35GiPKvN1wFevIMS2SuGy4G8uvGI6r0xZ3USbeJ6p3E8LlO7sJKMOa4
 MSy22RdnrFHIW74CGSUToNJDRFLi/wU2yMCw0rlDP7TrRD3D5wSUeRT3dYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpnet1b8k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:48:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d7443e0f0bso70991595ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433290; x=1790038090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUGuWUujQTh1SV61sGuPBe+ZIgo/M4JsAL1QiprK/Qo=;
 b=j3MBSCtqkV3R1O0hzaXdqedunohaWjhQiMzBRtweWRalOIRBF4J0pGYCPwaFri8Hyy
 S7DxwNmq8sFBrzSqJkxk+6GDPVIIPavCRrd9cwrGsbC+EpUBMvLGBbQ31Yd0o4f2DjRU
 JwL6bUf0QoKhEiIoPU2XXnfLuKBEtUWAQpzKCjitWzzLl7hbiCxpKHC1sHjv/pJ+z1UH
 P7HTNLax+2/FpMn6rMSNifwe9wPvfarN7RBD3wjxKoJ1hvdv5uOgBUdB/xtcD1ri+PN1
 wN8FhqS/XubMhY32qNsEtNvAVWH+Mvmdwhv9OZrMxy6ij73z/Er3lHLHyR5O9wOWX6Xe
 ovmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433290; x=1790038090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mUGuWUujQTh1SV61sGuPBe+ZIgo/M4JsAL1QiprK/Qo=;
 b=kPA7S52lnlri4eHcF/GZXzJG+IQ8qHeqDhYiweluAJDJ0geiio7k+uzrk+r8pyagnE
 fKa8oYnF6UqQXIa42vyf8nkU7GerwOs7IChJsV78fMuEaAAWsrylQIroCKU9HrWC7PO0
 c3Q7WR1c/KQ7dNKVlE/41ULoYv6mJVQKVZ4UK5Qo8qyFCMZ9nnNtRCgsx6EBrh13cWXk
 4RaGP5/9ihvNcomZcCEGPTM17SK4HzS1vQ6gbiI5dSzvykUzXHSJCcgtkKqVixLBNBbd
 fIv8plgvJ7wIMJJu3/139Cxo+vaFcpP3SBTfdiIC1a9EkVNYeKp8TS68qXcvFygq+umS
 12lA==
X-Gm-Message-State: AFuF++nqrGrjhFGq2XKV3pi75ZtZXEGWILoTs62JeKq0UMZ67N0ZDRwT
 bA3c+ovSATmtHFfXcDHJvk8cnzsgpoi5dHKK/7gYNC9fVoeXo9cMRR8nATsTB1GAZUl83fj2ZD7
 Lry1p9oewu3YUEcBXU5eWN3n4Neg5UWQOJE4jbpHbPt+4hw8f2tCAywcbAYr07yiZDg==
X-Gm-Gg: AYBFou2oO1l8QLgm5WtYxJBZfiYRMiCaM5CaQBsN42BZ8F6OXQ+pkTSuihn2l/btGOE
 zhpttzwBVRQGv76J76po1+XpJ0eB+d6Pz82IaZtCwhWJcQR/aHhxPmo7JRXaGNKzBvW6pI4k/a5
 dXTSc4erFOP0NeSodoArYHgfTCH+15SfA2x8BThLLz3Do95qo8cet4qdSwXMrFslzLjrN13gr3m
 MV+9H5b2EbqIZx3l7iHXmHMYTMzZoSiLaSWCJ/9I55gVJHYVzRKy7xfyqV9ujK1TGmvnK3F3E/y
 P6OE3PRYeNJuN8oR44IKO5a6BsOxv8pyLTQmjqghEBPKXGGLOI/oLkmiI/hGwhkdyOh0J2E75A7
 GqVlfetxRitgkiLhyo0RFY1G8hxTidL7fxdylWe8pegYLD7vio+V3/tkfi/0=
X-Received: by 2002:a17:902:ec82:b0:2da:f1b1:56c4 with SMTP id
 d9443c01a7336-2dd6c5b0e60mr97220345ad.3.1789433290447; 
 Mon, 14 Sep 2026 17:48:10 -0700 (PDT)
X-Received: by 2002:a17:902:ec82:b0:2da:f1b1:56c4 with SMTP id
 d9443c01a7336-2dd6c5b0e60mr97219945ad.3.1789433290015; 
 Mon, 14 Sep 2026 17:48:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf015csm31978309eec.4.2026.09.14.17.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:48:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/6] roms: move vof from pc-bios
Date: Tue, 15 Sep 2026 00:47:57 +0000
Message-ID: <20260915004802.5749-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfX6bB+p3xXselj
 HimcIx5zROg9UpHbBf6XVO4ciZyEPOp2DN1750rFUEhdUEcnmSx2AM910YPlzWeuHoxD3zXWVuE
 wpvP9pRXSqBZe+hfhaeQOBkg4FFYv9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNiBTYWx0ZWRfXyhTvdpCQrv66
 b68UCTtYP0rYidYoPRBL/B3kN0VACrVuTSL7m5bL/9xswTOsuXQB47jPYzWC0YjXESpjTO1HzBt
 CNSRn6On6FI1JP9FYmbla7AdI1bOE2Gp9LFwCFs3QRYAzHp25/4CSWKNrtNGoL0pVW1G0iQBlBQ
 Afb2v6JOhv+3sGaRj1KYspIug8foKXtsmhNDTDRwZC9/UKn+eKLx8123VWfNcOlkuBNpWke8Rhc
 pcuxU70LKBjjSftXW5NniX1C8JzASJEiC0e6bDiN+avzJ3SkLNthxHOEX7UmUTodCk8HaYZ6IsK
 n3l+4pJMH2OOF7iA5tPA5Q5u89l69smJP5dgiwhnODpFWapREIBYJYdmhv4iUtFWOzx6oLBYljC
 3HQIHYjDoKQN72C+0kspkmRTKShPiRKH3cwty58ugG4HVqVkSqHeavBoyJ63pmyBA/vI+f1lKcd
 FuFpt48LXUiPZcVF0/w==
X-Authority-Analysis: v=2.4 cv=PKKaavqC c=1 sm=1 tr=0 ts=6aa895cb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=_I5Uiq0BsOPedNGUF8MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: lMAri8ZivfmHiFzKmAd4E4D8fK1Mdw7M
X-Proofpoint-ORIG-GUID: lMAri8ZivfmHiFzKmAd4E4D8fK1Mdw7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150006
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 MAINTAINERS                     | 2 +-
 {pc-bios => roms}/vof/Makefile  | 0
 {pc-bios => roms}/vof/bootmem.c | 0
 {pc-bios => roms}/vof/ci.c      | 0
 {pc-bios => roms}/vof/entry.S   | 0
 {pc-bios => roms}/vof/libc.c    | 0
 {pc-bios => roms}/vof/main.c    | 0
 {pc-bios => roms}/vof/vof.h     | 0
 {pc-bios => roms}/vof/vof.lds   | 0
 9 files changed, 1 insertion(+), 1 deletion(-)
 rename {pc-bios => roms}/vof/Makefile (100%)
 rename {pc-bios => roms}/vof/bootmem.c (100%)
 rename {pc-bios => roms}/vof/ci.c (100%)
 rename {pc-bios => roms}/vof/entry.S (100%)
 rename {pc-bios => roms}/vof/libc.c (100%)
 rename {pc-bios => roms}/vof/main.c (100%)
 rename {pc-bios => roms}/vof/vof.h (100%)
 rename {pc-bios => roms}/vof/vof.lds (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf895732c2..da1f960651f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1752,7 +1752,7 @@ S: Odd Fixes
 F: hw/ppc/spapr_vof*
 F: hw/ppc/vof*
 F: include/hw/ppc/vof*
-F: pc-bios/vof/*
+F: roms/vof/*
 F: pc-bios/vof*
 
 PowerPC RAS (Reliability, Availability and Serviceability)
diff --git a/pc-bios/vof/Makefile b/roms/vof/Makefile
similarity index 100%
rename from pc-bios/vof/Makefile
rename to roms/vof/Makefile
diff --git a/pc-bios/vof/bootmem.c b/roms/vof/bootmem.c
similarity index 100%
rename from pc-bios/vof/bootmem.c
rename to roms/vof/bootmem.c
diff --git a/pc-bios/vof/ci.c b/roms/vof/ci.c
similarity index 100%
rename from pc-bios/vof/ci.c
rename to roms/vof/ci.c
diff --git a/pc-bios/vof/entry.S b/roms/vof/entry.S
similarity index 100%
rename from pc-bios/vof/entry.S
rename to roms/vof/entry.S
diff --git a/pc-bios/vof/libc.c b/roms/vof/libc.c
similarity index 100%
rename from pc-bios/vof/libc.c
rename to roms/vof/libc.c
diff --git a/pc-bios/vof/main.c b/roms/vof/main.c
similarity index 100%
rename from pc-bios/vof/main.c
rename to roms/vof/main.c
diff --git a/pc-bios/vof/vof.h b/roms/vof/vof.h
similarity index 100%
rename from pc-bios/vof/vof.h
rename to roms/vof/vof.h
diff --git a/pc-bios/vof/vof.lds b/roms/vof/vof.lds
similarity index 100%
rename from pc-bios/vof/vof.lds
rename to roms/vof/vof.lds
-- 
2.43.0


