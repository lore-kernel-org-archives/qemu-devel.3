Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADCCC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5fL-0005pw-0a; Tue, 07 Jul 2026 09:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ep-0005Oc-2p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5en-0000wg-Fo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8tsA3542181
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 787xbwmxIrsTjBorrP2DHOOzLOAbnrwll2cTYRStneE=; b=RocC0Vr3NSxFBkl+
 303BgACoeOkQQoYCjk1Fvqod7YMQ869RIXrWQoOZbbBzZ0cUi0VDj/wejUr48DWv
 cttcSRGuPb8xC0ZsuvMAEj+Z8hlLQyRYPY0cqkgH9VI4ca8EkVimUPNnALQzOx2j
 DdnyZeQPP07x2S3ZKF8KTNezFd0Y+6ltYyLoZM48bB0uZysP3p0unot9JbHII6nJ
 n7lNbfVO3xSjaQEeErKXP+GgSx9jN25WhKB+jtGgGrE7aCHgxMmKlIWQ1g+C71XE
 B0eHISYeZKT1uFDCeWwSAOJE3vQqjvZLYMPPVMaShUC9zXJ8EXpaMQo6FPxiFc/Z
 +KqamA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su723uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:16:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c075c1e25so32083651cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430171; x=1784034971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=787xbwmxIrsTjBorrP2DHOOzLOAbnrwll2cTYRStneE=;
 b=M8o7N/7RBJM+H00xKDT1zFfEDhj1xm9MZvrX8NVIvS5nHvJ+/FiQsPQLctBVRtUBPr
 8gQ/SR2yl4ZfovYNZ8547LyDQsQFMGWYXGPIXIHbV95zhwA5CkB24jl4a85mwx10WFl1
 QLc8/FVBuJzByKVdnuV1ls+mgC9SMZt7FmKjeG8UX3bbvxoGAig0k0V/xHvT/s1wRwNb
 icODMlO85ZhTRUFymzhbxQseTUaMZC7eutfFFzTnID/3rlI9nnHVp9LrE0tcU3GS7e0s
 5Mu98QafXxtehs+3DUckRZIaXpiZ69MfB7JHp/674mrOzuvju00j4Qlmp64I4GpluyG7
 boAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430171; x=1784034971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=787xbwmxIrsTjBorrP2DHOOzLOAbnrwll2cTYRStneE=;
 b=XRO7rpjy7MvtteFl0aSMDLYVvEf6ilO/RmQ/aSeZaDLSdUaJz8EEqsOjsGYs38aKph
 MKSpH7RyYjVN50uNwg1gEtaGQQmw6+suVJLTHrbdWgzFSi8J1jYEcFQNnuKpqz0k2H2z
 zovKlL4ME4F8iowfG6W+x1xc+ejQPqy3q4gkzCTXnM4rHEdYD3fog37BZl3K93cpM6P0
 uTwv01Ib9FPABVmIBAzdTZotHrVz+m5I7ZzzI30l+rqAqu7gTR7gvehKjO7mvH8dXnjs
 kEOt2d8avSEKKWq7RMnEekVpddHpJRIkP/hzUO1BklE0VLwebPhhJqwPRJ9xE+NpUy4i
 ZkCA==
X-Gm-Message-State: AOJu0YwpeUSQB1o0MtOS2nFVblYm91dja4J7y6+LL2wSjys77QceVNcW
 GmP8Zn9jxxlMsGSLtDZnWgFn2hs9eQ5S3xZIxc+GuA5DWEQ63N2p82/+3/SLR8uT9tSiiLxkw1J
 M7sIQv26whVhtJDP+bpFTantGFbEFw92CQZwD2vKPEp22OGTW5Ti3dSuO+tP5m7jQww==
X-Gm-Gg: AfdE7cl2ARy79xRNQTr8NeoYeY7bL9/AA6PRrClhP5Ier8EwMWarcw5fkeuv4zIgn6d
 Qg3nPGc/SXdyyIbWgYzDUwctW/TViVa4aIU+StboOwo+y02tKoYqg9ResAs9EidehOKlKP1VIBb
 M6YC4KVFF2uyN1ldtr6KNu635JTFESV/A3PXKA97BSsstoaTetYpQ7J1h4OuwoAGkK88ZDUr+0l
 R0uAKJJg28QdugBBjFUg3VycdZ0jXHCbm0mI/4UO4nloivnXN4sdD00UrVuRfWwpl6vQwCoYtm3
 7QCp2BqMRhVLSM53ButQOXSSMxNrPGiVdzREBRZb2oqU17JHL/oVfyNbcXOyo8naW5lC55eirES
 73Z/aTG9uZVW3Kxp0RT8l1glp53NkyKq+kMqHVI5xyWM7Misue6K0Rf+/byUaqlLB02d9
X-Received: by 2002:ac8:7f8a:0:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-51c7b114397mr24363371cf.73.1783430170806; 
 Tue, 07 Jul 2026 06:16:10 -0700 (PDT)
X-Received: by 2002:ac8:7f8a:0:b0:51c:7b11:41ad with SMTP id
 d75a77b69052e-51c7b114397mr24362831cf.73.1783430170262; 
 Tue, 07 Jul 2026 06:16:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cd89b1sm5893354a12.1.2026.07.07.06.16.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:16:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/32] Revert "aspeed/smc: Fix number of dummy cycles for
 FAST_READ_4 command"
Date: Tue,  7 Jul 2026 15:12:21 +0200
Message-ID: <20260707131223.51505-32-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX8/T6S/nWYLzJ
 Y+zigDRX2dNubKvFTZa5W+e4PVsKu60DTAI1YqtgBCrddy+wxpeVtX9iYMofqm8WdoDg07xq0YE
 kZs0p0BKQ5TXfXoZv/7mvutQdLQgFvii53FSvltTbbxkf3tGl3t3ghst83nguSjAfPzkj3hjNA0
 11oUMSGbzv7ZiTBdiEoIPGEQ4mhY2S5XLZgmLF7ES1LUAKSrno71E9X7JYssNgQAfzY+d5hNcZE
 e0/Dgbq9DIkKNS4Bnpy27wHTKp0qiHf0JA5i512AhFpINFI+jaFAlSxg08Q8ZwiunuO3hN4Leeb
 P6UV/RZh+CTZ3b2Eq5amySgbf+3keJQBR8N/jXODKVtQIdgK0LkMb+wqCy5mFeMH4xJXYynv9OC
 SB1N6ylLMx7CzDWTuJZzac1JqneVXibL5VXf21vuAnnh4J2cibxIMe+geUvTkpe7MCnzVMhGMce
 gnn72AoK4HVIZTB3TzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX84gN+Xj7Rjdy
 idShg2m+EhT5L8Ter+fzymzvtXIUScUmIbNnxi6Q/W+CE6P8psY+1BgerYt0M3QtZslgDPbj7wd
 MTf83TpPr2I/mlEqMoo08ONK2JlWf2E=
X-Proofpoint-GUID: 72h0Ih5Z1ZpEiN3_XtVJcu7fByb-pEVh
X-Proofpoint-ORIG-GUID: 72h0Ih5Z1ZpEiN3_XtVJcu7fByb-pEVh
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4cfc1b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=AC2j13NsY0pKHRBsdcAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Bin Meng <bin.meng@processmission.com>

This reverts commit 7faf6f1790dddf9f3acf6ddd95f7bbc1b4a755d0.

The incorrect implementation of dummy cycles in m25p80 model is now
corrected. Revert this commit.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-9-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/ssi/aspeed_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 3f957d153f8..58e5087b570 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -568,11 +568,11 @@ static int aspeed_smc_num_dummies(uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
-    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
+    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.53.0


