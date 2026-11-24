Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7BF606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K42mUBBz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WTUcNhAS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvgo-0002v3-8C; Tue, 24 Nov 2026 13:56:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgl-0002uY-Sp
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:23 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVvgk-0001Jb-BQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 13:56:23 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXGcs119505
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GtI67qZSAJ0nLth2ly2+vyCHxzaKYqUTj8rC250doDA=; b=K42mUBBzGJdvruka
 WQFd/c1n0y0gO0KaMQ+EhB646xA14RGbTUH6V/7z0eXf6Hqpy2IYh2PXN33tadXw
 CKnVQ5tNEHCG9D+qazzmVGZrYa6CnnBhosZ1NNYBIh4bKiVX3atGMXA5ZoeegONL
 TeAuGAQ7JRwF4BG0eCvJor9RSyKgYL5gbIn+m07ljl9DlXnsgl0/FCHeYt6UAIgu
 aoAR0dqHbVnztK+lY2ZjZTAvyDdlMu1fzIpv39FM+FI9jS1EP0C/nrMYWTxzCYfO
 w6pPuZkLE52/Yk0C6Fw7wWoK5MiqOZBI4onk2Hvt5MnQ9Sxcyr/itIpCDdWFpF8T
 XQOIrQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5effrmen-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 18:56:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so926051985a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795546580; x=1796151380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GtI67qZSAJ0nLth2ly2+vyCHxzaKYqUTj8rC250doDA=;
 b=WTUcNhASKEqudGhvoL7m4ynzLLUn4aH4U3x2SW9zYYUc6q7EN1RdTAIjiGohKBzfGF
 Ygk61DxW6/V9kZ+TJNNrjht/9sE1EcVplCC5EFwvnO+sj3rNXlz7Fbo/XtCZnpIjlbR1
 f+/BzhcDBxOhgoEZYIDKtge/kMao6kBKschxin/PxvAheUO2vof0oSXiCgVisAmoBis/
 1M6gJqYhEcMfTTogIr7qff8eRYLQCHLsAY+Tp4MQsc+lj3oxsBAtqqaT74XyF5DD6RU6
 xEOnsJy9d0/lzK6aaBLdSrdrTQOqOICzOXfASdP6lLRaes6EE9auZitzgkMiUrvSfyjR
 Ke7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795546580; x=1796151380;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GtI67qZSAJ0nLth2ly2+vyCHxzaKYqUTj8rC250doDA=;
 b=TALA73CXfBQYROubTgFjhLfwUosuUfmgm3ouT4rmLRkJgp5nDIMTjMZpXwm+xCFYk8
 GLpuWblqAUQrXhDOxZNb4oSXrVmpvzVfUhIpJynA0iW4WqOxCl+UR1E8IcCC15AGk7Bc
 pXwy7+e+LoMTvcPfPgcs0AP0mOO+ElQTzngnQbEderF39GFmnO+u4tT2v1qZPcjaoXUb
 NZWIZnLqfwfqi/kzBcJScOWmGgkNWiK9Z5RuMcXgndjXvlmSARflJQDsDdWy8bJs5m8s
 4rsiYuQLL5HJu9ZDYYRaNAstr1JhKQxpRVa1EksI47TszPGq2RsCY/IE3FT1beBHew7H
 kTXg==
X-Gm-Message-State: APuU4Z9jMlnvu5wkTld2tfLXgc7njs+l6OkrZQhGkxy0wFrKQX5nV83z
 lsKx4y1MWkDMGJ/IVItvfFjyOuP5+WR1evyMwt50nHvKJBMDymu1fkpmt7f13rU+W7LVLlekVmJ
 ZxuoBdQdkHP++SE6FM3Js2BP5TwbLXPiDYxzbGHS2CZPgWAT9jitTiOQy0eE7vJ0HgNhH
X-Gm-Gg: AZFdTZeiWHttqOO+56zyq076YJIPJjOhjaQpw6NtyefNgpa4rgUZ9BmQtjycZnPP0zw
 RZMH0i7vQoyyzRybtdC8g/EgrfHfalEKk9qiZzfrLvHqFPAcQgnc/JyiyDk0jvI72xKIX7F/zHp
 DlWh3klA6YlBe8PWmW3BzEUhdXFPjE0BJLrS61rMnRmvNWvAFGUyNqlEKZwDgrQGuq0MfIBdFXo
 DQDu0zYmhlz5/a4+mvypqc72YvRJmnzv0TkrQRoJCzH+qURG/yuIHPsFLqo39YoL1yfPqLZKvxV
 sSe1W8TZ4A3vIWBcUDQOvSDJfsIiyE4aZreFHDiTNI+PdOG0bFCjU4XfKF60MzChOSuzIgmEuUa
 GXc+rAJq1rO2LZlcDAhmMum25AfRRJsTSddZ76984CGPxqQJ53ASFibqWNezJLj6aX4NHGX0S3Q
 J0+EE5j6s4h1/NBw==
X-Received: by 2002:a05:620a:1992:b0:949:743e:9149 with SMTP id
 af79cd13be357-949ba8239bdmr2765138585a.6.1795546580315; 
 Tue, 24 Nov 2026 10:56:20 -0800 (PST)
X-Received: by 2002:a05:620a:1992:b0:949:743e:9149 with SMTP id
 af79cd13be357-949ba8239bdmr2765134985a.6.1795546579887; 
 Tue, 24 Nov 2026 10:56:19 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm29959233f8f.5.2026.11.24.10.56.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 10:56:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-11.2? 3/3] hw/block/pflash_cfi01: Reject out-of-range
 blk_offset on load
Date: Tue, 24 Nov 2026 19:55:56 +0100
Message-ID: <20261124185556.81132-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124185556.81132-1-philmd@oss.qualcomm.com>
References: <20261124185556.81132-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eo5KXYpX c=1 sm=1 tr=0 ts=6b05ddd5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=HH7jAQqVQHSkANCi50IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX4sqyjzrkc55W
 /RJZt1mXd6RVfZGi8UBA09enaeDdhqfrEjTK22cOJDvCOfR28hLJHNXTOpPUgAL8DH5grV0WpuM
 p0C7S7aVZxH4DXC1rURUOWR9b//ofYVweFIaiMei7/GkgiveuTJlsL+4A8sBq7bzZMvuANePMxW
 6gjibJPqOaYO0sonDW2DyQYB/bMG5XZKdkl1lMDx1Soi/6kffkx2KXYtncPnGuyxNI4odfqIjYz
 jIj422U8kpweCd3dDyHyxW/e6vhpH4IprC0UE6gyjI3wOg55jTwuwiVdEXcuqkl/pLY901bf73R
 PLShs7iGPKo5km/Qk92DPOU8spF5nR6i2acJhesA6Shll9JDiWtUMUIRM65leScco7A+Q0s/0y+
 4NoFxHaNR6rcgzylOT0fsjTh8fUindg02KJT0RuwrnkcKHqukn6AxZ+YqIUR/LEVfZHVB7JUON4
 rZKvhiCBp0Dg81EUu9w==
X-Proofpoint-GUID: 5cSK3aLfHBoIz4PiJAh54gVXAJF2vW54
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NCBTYWx0ZWRfX0Popx1ou9vnM
 qalBXEb6qV2yDuXIa6XvZJ2OTeNLXMBEFNTWD3koDrP9CuszfLdHQZxIESoE+fl5EiRvNiMh8Hw
 a/oYcQgNcwd+O5ohUd2oahu/RSZ7Yd4=
X-Proofpoint-ORIG-GUID: 5cSK3aLfHBoIz4PiJAh54gVXAJF2vW54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240074
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A migration stream can set blk_offset beyond the flash storage.
The write-confirm path would then write past the end of it.
Check that the pending write block fits in the storage in
pflash_post_load() and fail the load.

Cc: qemu-stable@nongnu.org
Reported-by: phudd6 & kietvha1 from Viettel Cyber Security
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4388
Fixes: 284a7ee2e290 ("hw/pflash: implement update buffer for block writes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 72c544dee8d2..7975d3578973 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -1028,6 +1028,13 @@ static void postload_update_cb(void *opaque, bool running, RunState state)
 static int pflash_post_load(void *opaque, int version_id)
 {
     PFlashCFI01 *pfl = opaque;
+    uint64_t size = pfl->sector_len * pfl->nb_blocs;
+
+    if (pfl->blk_offset != -1
+        && (pfl->blk_offset >= size
+            || size - pfl->blk_offset < pfl->writeblock_size)) {
+        return -EINVAL;
+    }
 
     /*
      * ROMD mode is not in the VMState; derive it from the migrated
-- 
2.55.0


