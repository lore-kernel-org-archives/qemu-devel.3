Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D6DCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBSl-0008ES-IJ; Mon, 15 Jun 2026 13:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSk-0008Ba-28
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBSi-0006lz-K9
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:51:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFhvhD992813
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=X0pjq5mdGhv
 djlr9FelZgbUTAxb/UQb6n7EsSGDA198=; b=fK72qmfp5rWqJLxXqI1yAmFFZfR
 VGKg3JZ/+PsGI+yuUglh1EuvSP34WysQ1/BIx8IZoMEGXLVNIx8duUTHmVHDEe6B
 rKJh0abwjKNldNqs2ovQT+j1kxgtPKXMiqWL3/ZklaAOrBoNLwMu+XKihqGaW4th
 BRElm2k9Pol6p7AUA35UQBYfna1a9hKwgvxcufCBm9ozcu+5QKktVww3wVUM+90D
 I2WcxAqAh7Rk4NXVKbMecxRCTu/oLpNOv4ceM9QTu2ogWaU6Wt/goAP7WNVu6qNd
 URvz3VDXZWiPFQFXnCA+ibJ3dXQOflW5OmVu66Pz/Zjb8N9/QofOB0bGcCg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etgvhhn34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:51:03 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ec73b015so225539eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545863; x=1782150663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0pjq5mdGhvdjlr9FelZgbUTAxb/UQb6n7EsSGDA198=;
 b=IF5xmnIRjSxb2aXxizqXQdWU6B72INDHPsmbE/HfSf1lS6GAMzjlUwFkznMHEtI0dS
 fZATWG5LHrBucQTjahD1R6Np7xMu/PLtI6ShzOirXi0iwkmj35g2KMTB+iJdAC+WDigI
 XieEZu1LQEKKWq6NYQ0P8JXXcwkop0YA1CE5WJ92GAZ++4lIvsT30fcyfAUVwnTI57Hw
 jOjy2lOkfvgC8jFbKT/1aLBgxJNF4p8Hqp2QK5g1D0lhrq1TmfFOY5A1v2Pp6MzE/a//
 xMbpShD4Cu0Zl09sQMBfbEFScYn8vJMGj6pUWfB8ZOzSQpOMOuCGlIO6BeCt04daxMmp
 vviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545863; x=1782150663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X0pjq5mdGhvdjlr9FelZgbUTAxb/UQb6n7EsSGDA198=;
 b=arQBrY+4A44WkO3emKjhbr/1FvORRR1qRR+LFd9T1BPWG342Ws2tRd/Qh9OM6cCtEy
 2iHJLWhbevTjQTC6FDs0Cw8Xidb3SfsiOSqpNjAJsca/QX0qPWMM+bv9RAZz/irjB5tj
 rilorWii5+GBaX6EWz9Y8cz55vauj58ThVX9eCyvnYsGrCWIDJMSN8DtCTeQbuvsGS/H
 j6ySFn/uezGQ74rfTcS+smeQ/NORn8nWf+Ziq1LlXpDkme8Ax7eTIA7ps9yNVndvhu5B
 Da6G31m/wP3orcyKh4NENDWHvARHMhcCtAcqE/wA0/hIO83WTusdHP5+WaavpPaHan5W
 QaKw==
X-Gm-Message-State: AOJu0YwhwbsFUsIEPDEHftYUnNqIhUwDj8KQbXThwOiefWzvReywTC5h
 3ZrykFmnklaO9JEclrZ6sG1vlZ4mbnCiGiZWYKhlX/xWyxhnM3Iv2wsByLh8Rm6w/FODj5GI7Mt
 wpFitfm+P26y8pogtsId2/xEoW/pMPJUhyxJLhEhF8LQgIkKeVSCOZbfucu2So3zrLKVx
X-Gm-Gg: Acq92OGuiZIPGmF6Ys5qiM37+RZZ6x+oH4ekH68t5XvkC7XVZGOBCCawh2GAcwySdJV
 DIPnRkRFJ3rAcasjfFQCby2GTOhk094DM6nfpgtF014RV9nOz/I+pQf3VCtPHTg7BI2QOL9mIlk
 f7FUuZqnlYiBVlafcs0PWKWblcXZLqg4MXYK8i601KeLIIj2W7dgc+MztYre2DsPhey+SllyiOA
 fxGBOodo35H+L0KkkbhmXSEoB5AiPcU7JfJXTbAlHpjGoMHiYhlU3nBxXBGv78KsSPaIOjvmjpT
 nYqggABTZMVcUxWDGNNLqMs5qJmcfK0FIasOrGO4Mip0d6lP5GLJCtlhAvmC8Do5U4ipIyme7N7
 oGgg+8JaJLZ1PhYVWV6NyEH/6NVipa3qDR96BTOuhH9hkE9plrhhGuax3xiG3rILBE4PU5W4NZP
 MsvgrYVQ==
X-Received: by 2002:a05:7300:2201:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30ba557e6c7mr199931eec.0.1781545862634; 
 Mon, 15 Jun 2026 10:51:02 -0700 (PDT)
X-Received: by 2002:a05:7300:2201:b0:304:6d18:3646 with SMTP id
 5a478bee46e88-30ba557e6c7mr199913eec.0.1781545862152; 
 Mon, 15 Jun 2026 10:51:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5cea89sm16816037eec.8.2026.06.15.10.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:51:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/5] docs: update mention to ubuntu2204
Date: Mon, 15 Jun 2026 10:50:50 -0700
Message-ID: <20260615175052.2751738-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615175052.2751738-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX1X1Ztc3Sk7mq
 kZ4ICNzcTvLjRZyW8N/kd/ywM0h/eGBkss0oK9Edq9LdsYxBZSgsen7rmQRIPr3ftWXp7YZodG6
 +Iekd1wvRcoIR7BQ3jmOMLFGKP3o1Kw=
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a303b87 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=xZ6BDmoiws5Ospjc0qEA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: RBNsGlY5-FOIM8oUOGW3LdVr6JM5bHiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfXwFmfp3oEILdx
 r+gVNrt5aeixls6xZIgEM2Kd/BZfQRLlCUXYAKD4XxNw4ylkcAEg6U4L8ct///KIlaGz8dVnopt
 /NiPnEiOy59L2eLJbxehcZU1BT60zh1I/paB9i6imijkuipW/LoUPvuBP0QF8D99L7mnxN3mH1R
 cag0Qix+7TY1uvG3DfieWmY5XGJ2UUYi0IItxRx/zF+PDgrevSzqYXnOpbrV4xOVtbOf9Xe76Ih
 BzOOxpTRieQOczC1zqVhFj88Kiix8EEegTwhkbcYn/Q9HqBcVyaeqF+vdEdLY+kC8fUc4CrbzH9
 fKYsDFKvuuWL85XUONriPA0AvYHlKaUEM0rp3AlGMBeT3EHG0FsxbDBgH4iIiWYo/CdmmKTdKA4
 TKTixWruzADWvRcXb7bKAtBNQLKYpSKUN39gd5fdLA6BvloprtWLkOqAId6AXwUZXrwDkdtnJ6d
 +KAVijMX6DSN2I4dJkw==
X-Proofpoint-ORIG-GUID: RBNsGlY5-FOIM8oUOGW3LdVr6JM5bHiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260610192222.2709135-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 docs/devel/testing/main.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 3408b5836dc..c6821a36d99 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
 
 Thread Sanitizer in Docker
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-TSan is currently supported in the ubuntu2204 docker.
+TSan is currently supported in all our host docker images (for instance, ubuntu2404).
 
 The test-tsan test will build using TSan and then run make check.
 
 .. code::
 
-  make docker-test-tsan@ubuntu2204
+  make docker-test-tsan@ubuntu2404
 
 TSan warnings under docker are placed in files located at build/tsan/.
 
-- 
2.43.0


