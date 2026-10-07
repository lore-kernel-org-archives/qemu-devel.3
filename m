Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D82FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEO9k-0004gs-2J; Wed, 07 Oct 2026 05:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xENyV-0007w0-Vm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:30:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xENyS-0005Hp-MU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:30:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jeA53298341
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=peOisZFBpZ32NfgNzRqCOq
 BYF37h9kgf8/mExHACSj8=; b=Z3Hky59E4w3XAFutILqPUIF5ibcW7JUYKIcct3
 eTG9ugLUXYOqV8YKPkZ4MTs3/BCT+QrOHdt7UqsKmNz5Vsj9dwAVvrxU05A2F8zQ
 4LCt9W+nRCb3eP0LMpgcKagGMEBLgSxWkOHKZfcOiFC+LGUFZW1V/vlDfvuIkyTe
 ku/BNxGtrvgqTlfXtYTHxiPF2wKXG5XdonX5+D3jLWwlE6EkR74inbtfEHTFwNcc
 0tBrlmkb3605A8hrFKJpL988jlSoFzzMrgYL0F4/BHD968oIOWOq3VWqy6XnrECH
 b3T71LcaFpq289YdWqH9V5dD+6JlpPJqBPijRZFKPsPLAxPQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5hdcrf60-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:30:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939c30aa9a0so446641385a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791365406; x=1791970206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=peOisZFBpZ32NfgNzRqCOqBYF37h9kgf8/mExHACSj8=;
 b=afJsEUvFwzOYQRd73AtNf1/DeOLk26WrjvfgpftUYiajsAz3sb6zI9SlPg7VLUWVDQ
 EcEMB6bcJ27O0jv5eX4A9ebimyGkkSD+U9JDYn8TwKsae37VS0MOJSmIf+57/uNVIjNI
 7NwQuQq9eBK34QxuOI4GKf0zT/2TjyqtX2iuRfiKXyG57nZvvY+ni1bNqTaKSYrV3jOZ
 BqQuecjSxW/aoMojV9P3dW3lin3GmLIwbbuyavRcPJkzPFGXzkJIp9f3plRhw0TINdM7
 KWRE233LxnKS8qU6LrYql3AyDRDpE1xu9ItGLxcqw+YJW9t7N2xzKVtIYj6blA2aeA9M
 pEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791365406; x=1791970206;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=peOisZFBpZ32NfgNzRqCOqBYF37h9kgf8/mExHACSj8=;
 b=FOw7xnFNrAWJe/rj/MGIprAk6eiPKNcyuJGutjF0ffrQkc/N64kewMBS+3aHNVavNY
 ozWkVTlyFd3e9qZ4BXkwjNFOoP5t5+276DP40ddXpZ0ekNXU4vq1dzQjVHIDqqPIls/o
 x77TnTxI2Bz9nPRbnIrXERe0l5PXLRqOKnT9BFcurDRPRKW37wxY5kYlHRwOu1JDfQ1R
 1Nditf6VHCw+pq+Tu6+e0RjiKozeWN2yq5opBPVffLHCKXhyMgkSvYgshQjMxXyNNtZn
 q03jv68WgeNr02jj0lkvGzQHaki1b8eM3UAErp+6QpwO3tJLg9+poSKBQPhwPdfNkSnT
 WCBg==
X-Gm-Message-State: AFuF++mGiLphxxmgJ5TYBP9YgoFOatTyIhcwY7xI0529WJuI9Rm/+21A
 gbjfVeI6N8ZXHxDxHWqFcsX2N+1mc8dS0aPJZf3ddJZoZWXAQhn4YFF5xFY7vKIcGVX504B7CV0
 baeI/pmWpusqSSIRArZI1fgN96+cnMifctR/Ny1CBku94J1l/rpXdTM4at/QAS3Jp9GK2
X-Gm-Gg: AYBFou04/ZFSQn4Sw+ayXrVEXXKVTj74DRMcgOvbg/qlq5Ggw1sNpxRAcI+hi06UKUF
 9lKyzhzAa7VM85Ix0RRfz6IAWlbJmuObJnDXWJE86kITaQeQxK3y4rbNX2gfLBfZb8JmebPB5JC
 Oz+G7R+fM6/1n2/Urx6vDBEt3pFKuZw700vQj5luIUdS9+zu9uw1PZFfyJtVllN5skOl1YCgWOr
 f5uK257XSXhNPMd7n9wpJhiG1w4hfatLP8hs9UQxjfL0/E96SD2L/D/y9dPP9nQXnptd4pZsyJ5
 O9GROhrRvnzgzPKgkveoWkOOxITRLXShgp6ggsCtawNEGE32/Tw51p5UYFW5Up4N8BRB6nhwDTC
 Z9i+q0fcnKvGHgv0w45Imlg6JOoCzn5CoA/CAe8hL
X-Received: by 2002:a05:620a:460f:b0:93c:ca09:aa34 with SMTP id
 af79cd13be357-93e9b7c2ac4mr328637085a.46.1791365405788; 
 Wed, 07 Oct 2026 02:30:05 -0700 (PDT)
X-Received: by 2002:a05:620a:460f:b0:93c:ca09:aa34 with SMTP id
 af79cd13be357-93e9b7c2ac4mr328632385a.46.1791365404997; 
 Wed, 07 Oct 2026 02:30:04 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a180310c9fsm37495675e9.4.2026.10.07.02.30.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:30:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty logging
Date: Wed,  7 Oct 2026 11:30:01 +0200
Message-ID: <20261007093001.74476-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: hTJzi_Q4hkHjh6zzr-YD1tKAR5XWPt_F
X-Authority-Analysis: v=2.4 cv=aKFlOr9m c=1 sm=1 tr=0 ts=6ac6111e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=4iX3uDW9G_cJQgqnWakA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNyBTYWx0ZWRfX/6Ezir8tXh4A
 Pa+JJybyYyG5doghJGcilGEUAOlHM9SMEmqHlODgNq6OyFYpQLaxqUY1J0xtG+QoglOBl1Pc0mr
 CfWILKopuljX5ATGC03fFlE+ch6cxtI=
X-Proofpoint-ORIG-GUID: hTJzi_Q4hkHjh6zzr-YD1tKAR5XWPt_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNyBTYWx0ZWRfXyMsUtTKpafkr
 XerF9SXXEnwp337VpySDb5nYm8oJngb/EIYFc/AMPvUvOHdimkIYfArZZRNV9tWPB41w4Usn6hd
 NG6jLH/DBiSb7EFe866Mp3UmhJCkbDcGr3HfwR3H1YdNEgBrAtaBUfjI7FpxylmT6InRQvCuIDK
 pOTqEdAQniLdLBo3YOv5PqiUNMr29kk6VVQkOQ1YJ57d4yFVCsdiLRW5jEJVppNpuM6MNXPuV8I
 hDHmwtYctUzCUettnzOD8b+bgnfbwGyLOIDAun3LPoEeG9OshF+YTHR3+0SzuW+o/dKDCdMYq9d
 UUB4PC+9G7zDii1QvW2q5YVBha9YeDAzHcBemtrtyfKFPoPkBD3gFQTZhtBlqKD7M6hk3cIWrhs
 VL4ms3kaFkF3sohh+RR0nxFU66wZiwPOpwHwXkbMMrl/76kB7wsEKStGehAOsbxBCAMbOXlxzUe
 Zvrpg1fBnKq1GpTrV6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070037
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Mark Burton <mburton@qti.qualcomm.com>

Dirty-page logging handles a RAM write fault by marking the page dirty,
restoring write permission, and retrying the guest instruction.

The handler also retried when the resolved RAM region had no dirty-log
client.  This path neither restores permission nor advances the PC, so
the instruction can repeatedly exit to QEMU.

Retry only after marking the page dirty and restoring write permission.
Otherwise, use the existing emulation path to complete the access and
advance the guest PC.

Cc: qemu-stable@nongnu.org
Fixes: 58bc47fd1c ("target/arm/hvf: Implement dirty page tracking")
Signed-off-by: Mark Burton <mburton@qti.qualcomm.com>
[PMD: Reworded description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/arm/hvf/hvf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b00a7e1a845..b6a2dba71bb 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2427,10 +2427,10 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 if (memory_region_get_dirty_log_mask(mr)) {
                     memory_region_set_dirty(mr, xlat, page_size);
                     hvf_unprotect_dirty_range(ipa_page, page_size);
-                }
 
-                /* Retry with page writes enabled. */
-                break;
+                    /* Retry with page writes enabled. */
+                    break;
+                }
             }
         }
 
-- 
2.55.0


