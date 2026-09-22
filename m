Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408EEC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x93gn-0003aJ-ES; Tue, 22 Sep 2026 12:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93gj-0003YH-T0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:49:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x93gi-0002DO-77
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 12:49:49 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEjKQW318032
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bAjPGKjObvrHSu8DXVRbAWjcrM6pRucHJzyibk07IRk=; b=LVB/4KqkPFulLrhe
 LssceO+TXm/ved14iDPcs5hb0GA2W4pS+a5HNm95dRjGTJrqWS7FQ7Yw8M1iWIOX
 Dgy36zMixj79zpuC3r7RiecXQpuJpf1pitdbZ0js89v4gc/ur05WUFxZ2L5gyb4e
 hsvQw/CyYDGcHNxxRBBsDuHlNkbjlSZvH/CYsGlkOxPFPwQAdyBl4JJCDUXJnRZW
 LVF7+zQ4S86eXkh9St1X/NfDsrO9yLXUgpP0ktYbPmLQAR15F6BkUBTneGY/2E9S
 Lff5GbuVTNXjyJKqwQ/Ca+dBRC9m1eLa8cgsWKB0edi5mgSp1pCe9L/0S8yQOi9l
 ixmxGw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqj7ct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 16:49:47 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7915a83539fso709137.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790095787; x=1790700587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bAjPGKjObvrHSu8DXVRbAWjcrM6pRucHJzyibk07IRk=;
 b=ebIy20IN8zKKCd7jnARM7CLquMDBR8lykS9gC4zVMu5JJ739R/I9gwHp/NZvljsKdY
 sHbTgiGMMdd9OkkZREW1m7RoKk4l3b1AWxoYiM8MKW6y0elR7h1eFKEZE8H7Xb93MR3X
 +tzcs0Ybjl6ex+HUWZm4wezVs5RUKhRNrQhTUwVwMCC9e7za46OD7bVwwWfvub0iXUEX
 ij55RF/iDsPktZiQSLh3ZPfj+EZU6NHC2eqBcNOViIEJmi7rsbFm9LXLmqCyTt2XYbv3
 5KXwKalbH85KzFx1blGXo5Fh2ylDK32TZnTYTFAs/gTupJIcpfJaTKAaqDN0T/M4rJdP
 5scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790095787; x=1790700587;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bAjPGKjObvrHSu8DXVRbAWjcrM6pRucHJzyibk07IRk=;
 b=jTkZ60dFfBmLEOPUgpr9buptO7f74xzdLpKte6rqjRIuu514oCJ1cCc1bMWhVinWwh
 aHx5ZHzQc3fSkxx19V5i+BYoz0hG0JGlogr+nz43S3fq28OSbfNo80dKvUrejmpmhP3I
 HQVukin+qQIqxM698l5eJ6Zh3+/MiK35UIAfun3Q60ebaWArspxqzZk2EXoFnxTJ9WuJ
 S/ajGxYN2JwQuxYDGKnQ3A9gDDW4RWkRUazdu9PAmdsvDt9pSaIo37IgIY2r+Me07VBA
 Gv7ZZuPuh1Y/20wywmnEQpFG5VVAwie1hqMnEDm7yNNtWNexRyc3hfffnXKi4/1MPv7G
 J0vg==
X-Gm-Message-State: AFuF++mRV/w3UJRQXFBAJgCX2+wlYtmSCTDouzAHkI6dto6IhumP/Bmw
 fvbYjcqlaCPWJnZtsS5DNQhHz23yKXJ4tY1yYDgzpTb9H26f6bySrl46bn5R9VWtxx5AkeGfn7O
 u9VP0fPjiAjid38gbxN+BTh26yuRiBDqZeV0/0bN9sWSinPmojkHq7UtIUGM72jtEfw==
X-Gm-Gg: AYBFou2eUm6EThu4gWC6mn+8JqK/XKmYdtnCP5stG5FzgnxZkg4c73EFj0cWTvVhnqR
 vXA49er99xHyebsuqdE6leadSMSLm3RHOykusL46SQiRlQ5zbd491RK4Ik0JNNhcezrbpWAnbND
 gaz6teW+h5Pc4ohl3AIpvQY/Bon/DjmcLpxJn2RYDLebHJJyE4BPb+aIi8D0XDyGP1p5YLV6P58
 dQQ3XOV/ZgqsqsNM/SsfTRP3GKFYOtmAk6UPesgrnFz2i1X1KZh6rt9yAsu2jWBL4nsLolZ21OR
 rXd6Oqp+JgHtM6mVfNtvsoTS3BkVMG6ytTqI+tBUHqZJQ6NaXWAEA032vp5cuQxwKA0A0iT6Mz7
 /8IR8f/Dazdt5JqHTmVq9k75q6yiBzKZYp3tw/q8m
X-Received: by 2002:a05:6102:2922:b0:7a3:4e75:d1f0 with SMTP id
 ada2fe7eead31-7a55d38b2b7mr9259945137.23.1790095786637; 
 Tue, 22 Sep 2026 09:49:46 -0700 (PDT)
X-Received: by 2002:a05:6102:2922:b0:7a3:4e75:d1f0 with SMTP id
 ada2fe7eead31-7a55d38b2b7mr9259874137.23.1790095786038; 
 Tue, 22 Sep 2026 09:49:46 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaada7b6sm42135825e9.2.2026.09.22.09.49.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Sep 2026 09:49:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 01/17] system: Document has_work() synchronization
 requirements
Date: Tue, 22 Sep 2026 18:49:19 +0200
Message-ID: <20260922164936.15189-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922164936.15189-1-philmd@oss.qualcomm.com>
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX/zcN6CMdht30
 6V51lSEzjKON12dwkOizf+P/wUeR/NcC46Ze+2Ozc1adfgw+Ehjh9i0FDEH+9Qe5iUfH+bDquX2
 2a6LolbHjF8PcrtPnzKzSB+qE8s+STNNtWIvsXKqJgrBSmfNzFimpW2QKwu/tABbZLzWY61CAg+
 2SrUMu3JcOVYOBy9U1sKad8sxyRyrbBWmiffAGGEjbywdemYHPR4VECGNba+lpo8jMxWrv8fx9c
 xjxAd2zK0OMjqs9KOoHcOWIv9DxKzan7/++SoT0qT1X84ysNEGH5vXyfyA2TClcEWpyeBHawlkL
 pV5z/g1g4l+oqM/A0xTYlIAFhLoN+6MUzUeYm4Mo1o3uvvmljIx/r0WJ3LsMTkFashAj8conu27
 bt5K7+J3yj6ldYBU/kNPypgvoWR5HYFLINBrZefanMrponEWKGmbykNpIYXXKTAqXphzfLpBX52
 9dhntHFOb5YQNJOSETw==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2b1ab cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=XUsUnerbLd2lX0N3J0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: C7PHXEZm0lf8U9TGmfx_fADLeZ-XuMZg
X-Proofpoint-GUID: C7PHXEZm0lf8U9TGmfx_fADLeZ-XuMZg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI0NiBTYWx0ZWRfX+ZchzXAj+taH
 vN7vpXO4WokAZhpU1Frk9RN9WIJeI0uf8UVN2FstPY1b5rFgC5ELw+7ya2w8tNdpXcofUiTOteh
 k/k1XvxqOtO6wE1yeAyEZLJBL+ZVrZg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220246
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

Document that has_work() may be called with or without the BQL.

Require implementations to remain idempotent and avoid consuming
work, and to synchronize state shared with other threads without
acquiring the BQL unconditionally.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index e56eea18b78..d125540262d 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -19,8 +19,10 @@ typedef struct SysemuCPUOps {
     /**
      * @has_work: Callback for checking if there is work to do.
      *
-     * This function should be idempotent (i.e. not change state) as
-     * it will likely be queried multiple times before a CPU resumes.
+     * This callback may be called with or without the BQL.  It must be
+     * idempotent, must not consume work, and must not assume that the BQL
+     * is held or acquire it unconditionally.  State shared with other
+     * threads must use appropriate synchronization.
      */
     bool (*has_work)(CPUState *cpu); /* MANDATORY NON-NULL */
     /**
-- 
2.53.0


