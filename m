Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1433EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPx-0007fL-1k; Tue, 18 Aug 2026 15:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPv-0007ar-4l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPt-0006gU-AP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:24:10 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHHAqZ1454288
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=; b=PLzTxW0Qjbdk35nG
 CTYoWAQjlIZJCMpHba/ZX780CG62O6vyYSlt5HO1L4r9x3idt4J/pp0OkMHgJAUB
 SMMWhXINn8/J3diomaNT45kQS4pBB/4njk7u2BbBS9Xe1fjC/KnjkOQQGwnrlRo2
 c++EnDiBtrZRdRfmGwidhuPdz3r/hpUMxjhb2e+ZSKnyCJM9hh2N5cNuqm0zWMu0
 L9nKpdevp1is5GrOVLw9tzU3R2CjXvT0VEMzhiVbQ4muWwEdfQV9UShk6K2YSIEi
 CN21eh5ji1jFfg6t7EMO8bWqHoiszPXnmUNoPQSxVH9b+aUprIZG9D5sZaK1yay6
 VYRymQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qxj1udg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:57 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbedf42f199so139899a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081037; x=1787685837; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=boPBSAzsuUCX1OBm5NtNYlNSu9J48idqtQ5idE3Ghz4VjMrA+bV9HlWPbF5M7fsSe4
 Dd0TqLDPMQrldz+/U641tfN5/f27DStOv1g50QyieBPFwtPg5t08MM0X80TLJZ4nKBuz
 pYdBxZ+ov9vyTA8+x7jMTB+hnKm1sfwOFIiZPQMObx8punrwlAaay075WFxYqSQzir62
 AQt8Bl5uvtuQFVyGlGFZrzwu8hQr5V3uHmqDauj8msErKEnjTE/hvW1tmG6nV48pUlqD
 ZSPusdAzNeLXVkw9PNXwDBlJ1Y5WPwCNRq/M/tLUsnprydhNixDk8WnxRwsDyQMTx/lH
 LaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081037; x=1787685837;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLma5rA2yLbR0swPh7bAIAXRqc6qV0VXcf4yAANWjSs=;
 b=fCq/xhUb9hppesqfbYR+Ix9Gern4KkL8zfSj4SRMHVFy1UQr46sjQbN9LvW3sPJXeA
 Tj/AurbLs96RECx4rF4Pum6ANs1S5VXBMGMWm0240Zlrt1+EYQ3Wt9fOWk1jJxJ3tZWA
 OTX+SrSTPMtxJ2gbus4FrDYfnhrPSbflbLpRcpbnKEBjI9bJemLqaCIe5sRfbTH/mU5V
 DfnbHk3RCLmYCR8clDGMIEUn6BP2HZxaq1TiNOJGLA+NUfNjCFaIXpoxh+4bjOsPoWn5
 WWMHlenxLtxNYai6ycG8SKiZu+ZNc8Yd1k63KMb5gdRl0LxAlq/UMWkVaq43NXfrbZ1F
 uYEw==
X-Gm-Message-State: AOJu0YxUTCF/4y/ycbFtTbMEBs01ppRGoA/AW0YUgLYKAQyH12B0NXqw
 Vw/schBRUP3YjXoz8gQRfskxC0iBUX8LfZN0tSoAqnCLp3MmgHbIyyTBrzEWCoHFKB1/C7QBl1p
 rQ4E+Wx9jbhIsuFXyQ5mVuDjCDsXEuHwumaSH/NfvLeII+F+/6tN7RWysDSA0Vc5G8A==
X-Gm-Gg: AR+sD13Jvx0ccmFjzLFSg421ODiz2+Hz2jGeNOiQ/lIh7P1+SsadlrwkyPZWl1nbtoM
 ApL5niwLb2nNut7yMJMyKFb49KtGiexE9BEdMZbLBGBYQinda8FoRTMrba+gNrpJ8jZgXaBHBHw
 jzefPgCKO3VD4OJpFQnuYJIXeojezyAd+cl9hfv/k/EOnA5UhwFMfbffsUDZ+w+aoZwiSl1VSIk
 cQNg4XIvMTGxHHNlgCKYhWBnX0ofzaqTyu8EMFUCwmddPcnkRA9AyCAloA/FYQdd2Gwenhb/2AQ
 zPqUXVgdvN6vi2mx6yaBR0pqLvnk1hiva8QjEOV0ZKXGbTjCVB28eXF+EHupVyNQVwPzNHGEHW4
 VOM4vV5ZhU1lysBOiKeNiY3hWyPTQU+QjDAou3GdirkQHs9HtKytngu/tQmM=
X-Received: by 2002:a05:6a21:9090:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3ccfed33bd6mr303779637.6.1787081036866; 
 Tue, 18 Aug 2026 12:23:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:9090:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3ccfed33bd6mr303693637.6.1787081036378; 
 Tue, 18 Aug 2026 12:23:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 027/104] tests/docker/docker.py: remove "Image is up to
 date" info
Date: Tue, 18 Aug 2026 19:21:51 +0000
Message-ID: <20260818192309.22169-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX2myANFOezz8Y
 BrQ7OQ+BGNom1umT28uM6Axh4CfBEdqut+DY7qI03RO1B42wiIlXy9gvrNgdS32MQ8PyBuh9HkN
 4NVbYpT48/va1/XF/1cQUuq44+MYLI0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXxJInGtFOEEra
 bbvCaVzcgX/dgrYxRoIAla5uGswEFRuvjW+mOPOf3BQ5HciN3eP/zUFg73Ot2/ZyLLrGCkx8OrN
 SZylMeTzl8sugWtBZzPIqA8jYFHmLy++wcVoMXr8H19rb3w5DwUZnJNKnrXkWwAHosGMaFZLXAh
 WwKZkqG02xj3JCH/P70yH8WMSXgLMnMlYlgS75U3jxjZV3p8aPFZIOSY70lK6k1MNnkHUdjD2FB
 CkNimRz+0Ji7+jkbHABkbONbaYtJX4FzGSZT598MFmwvr61R6rHk8nYLKabymhnRBsh5kfwaXuI
 7v574SJRyl2myM06DXb1FI369yTxMixYaTw+y4kUo/RIRzICQVjfEFNVf3u/QQtoOFEA9bCcsi4
 AYKoIqxHWeMQgOqULnhM9XTkl3eg4ZzNeFLzVzIvOnSzb4Hqm9QGU3voxuftWeG6p9XFu86xK7f
 MX6f7Wu9+/JT+aWOHtA==
X-Proofpoint-ORIG-GUID: URCEKrrHZ5wDpstGqSGj9ZUZNMQssZkd
X-Proofpoint-GUID: URCEKrrHZ5wDpstGqSGj9ZUZNMQssZkd
X-Authority-Analysis: v=2.4 cv=bvB8wkai c=1 sm=1 tr=0 ts=6a84b14d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=3L1wqYL7HJlRHUT7mJMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

It's useful to print build output by default, but not useful to mention
it succeeded. Reduce verbosity of tcg tests build.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fea6d0f85af..315fa2ff848 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -429,8 +429,7 @@ def run(self, args, argv):
         dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
-            if not args.quiet:
-                print("Image is up to date.")
+            pass
         else:
             # Create a docker context directory for the build
             docker_dir = tempfile.mkdtemp(prefix="docker_build")
-- 
2.43.0


