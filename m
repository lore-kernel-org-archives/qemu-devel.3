Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CEDC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvy-0000mR-Sz; Fri, 03 Jul 2026 12:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvx-0000aw-08
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvt-00006z-6Y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:08 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInxE476556
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=; b=egl5KS/4kQ2BE3Rp
 7Rzj6NZMrxZNpMWIQ3sBiwZ+R1RFd4ydu5HZvvAGh+5D/tbS1nEgxS6gnDSy8nkc
 lcspHYjL6oJs7JQplWuAzgNWUuLaaKR+uTlLStTQMe961GXQLMjMgUEjQiLqGgTK
 mUWP++Va/3qQ1dma5cEUKn0eeay+y7T67Z9dz/AyJNMGuTQYqIVsYS/gnLvqvpCX
 RQqQD6ZcVQhbldYo/j3aV0CyDfufPIMJ+KSKNWZIFqr5XCExc+K46neXN2KKUUuY
 LlPW0/oSxeMGxJ8hRG1fpfWgjl8eQrLXqH7abfR8ZWhznpEwZSIDP1QmG3x3lwxT
 wAT/CA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybx3v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:53 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso63894885a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096792; x=1783701592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=;
 b=bkq0WCImfSqSNehPKLUniUUWZqrn/PJcCeJe+DDrkd5YUYW+MrTC79bvERtEEnelt6
 sIJukNqSdHLDOCHf59D9sPQqyBQHGJciB6aTgHbbyvsjqtjv9SPaqUEWoTtnHRem3pc+
 kLIG9SlTRYZHULi5K8OoDQylBM5vQ+EPkcFvn4wKhnwZNLTOpVViLS0nQ8YPDbOh39a+
 VERtVdTUd8Wo3ykuh3s5/WoMiJMhG5nSKZUwLzhgcTinmSq9FDYzE9djtHxU782d41G1
 9RvYlu2DRI/G4VnftyEszdNKTU7mH9MGRcT1zG6gZT6GVY+y00arcEYo3jN0csfbmB/K
 SFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096792; x=1783701592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VdLq6Zfki+3ghFdFd7ctb3ThvHqHp9sVmMt32nHNdYM=;
 b=dF2fC9MiP64k8q0ti+AjYSHbco/2U/J9yQqvkbV46bk2j/jj22c4xxLXMcZmP2GbCa
 DtaKmPONYCinZeq4T5EhfD0HzOJMeX/biEAkkNuuRzf5nLcjpRjzley0SWA614raYkPB
 R7kChQKLYNt9N7i4LNh7Cm6zOhSkS/mPpDr+IykjBZ6BN7BbF7AT6B7j1/hYSom3yWSE
 Ka4YrLDFfWQ5PWAewDp2TNFYhdIepOlBPPrTMYNX7+Zmb8/j0E9mxF5hvdCGL0HrEUFw
 eF8N/evXe4Jo6P21WEW0ULXDCsz/lHVfJZxUpepzBp7g07NZ0wplgDnS7tfvwZYeyO6H
 AXUA==
X-Gm-Message-State: AOJu0YxlHL14CYLiuen0wzauZlHDl9dwwC/YHz+OAh5lMBPvv1OoPYIs
 S2K0Fw9rJLCYAoE5EfYhsMf26n4diWUDf69MWW1C2yNiqt2R364M/xSPk4y98cAz3/x7Td1CBzn
 whTYUxZg84qjqWCIt8rd/R37uXn03Wn7SmZerwtjC3dg56JzOYt+vylkKWWISDbkBgA==
X-Gm-Gg: AfdE7cmbXIkBHrsnsMV/JPO9MKqlTERwqjwA2NgIiAK3A/Paula+EN+e2kM009yt5i9
 wetYQUxViLG3984R1fQHrd0yFPDWQ8C215sMwDYMCGndZyIj8tnDBtnlhobdZwisM533oHtBsVj
 jqcKrE7oaWZ0gpoxSeuKeJ6ipDN0cFyYAnYQe0to14+KmDdzEj0F7hR+RKzTeqDMIm+cjwFKU7C
 IjuOULLfAMUfIzDxlLQ26clL3QJeOdLg6YueAfwY2f0eF4x+4DI4Y8Uf5FSA2Q/sR5O+ldMEuU6
 KNNx/YWpDMP4wpy1fnvKBU6wuEqe2pMEPZwKvczbMvkcqVxTxHzaF8KD/Lo/ZcIJQmfw94kYdL7
 gy7ib/Dcm5cZkAvKChcTEjhf5gP2hc6x3PMu4eo1RBn618t2JpKGWNqioiXAl1gWN6a2q
X-Received: by 2002:a05:620a:44c2:b0:915:9a39:1d68 with SMTP id
 af79cd13be357-92e9a35b22dmr27878685a.5.1783096792469; 
 Fri, 03 Jul 2026 09:39:52 -0700 (PDT)
X-Received: by 2002:a05:620a:44c2:b0:915:9a39:1d68 with SMTP id
 af79cd13be357-92e9a35b22dmr27876185a.5.1783096792066; 
 Fri, 03 Jul 2026 09:39:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm633056f8f.3.2026.07.03.09.39.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 15/33] gdbstub: Make default replay_mode value explicit in
 stubs
Date: Fri,  3 Jul 2026 18:37:38 +0200
Message-ID: <20260703163757.55500-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXxOEArcFnJ2NV
 7CZAlvdJL+0BkrkLKCb6DLlBO5q3a58KC5H8FoVNq7I/DPPvxJErwViLmkAsAk5bZG7rJTgSmbf
 yDTXTa5BDjp8P+SnazU1pq34OdIhl3QoIGQ7Xh1Xg2gXu3LxZalSB6BjL6S0ztiBhXgeMp9rucG
 1zTWzdEdk5cnP/XBKB28JhFl2+naggpdfTB8uYB+ng6IQFRo3VTZ6fuUB21A7xx50ALNDgXPWB/
 nSXf6EWI844OUZAw/RyKDegfzo8yLrfs6XF1FjvAOMBL7iE35VV6LmQLhyGAtI9gDpheAN1RSs3
 H4qF3LDzJRfS3n50jIEby7aaGLlXtmWTOrnxw2hLDSAu0AU+JQyq+CIpS1mxQTG/NG2D34YyN7C
 DffRGwpvFwMc08jskvDoEC8HlX2UObwNvBWdOiIV9tr2Kt08kz+5Z4/N3r5mRO94/vax008bpEt
 8Gv9YwmbdP2+Sa+b3gQ==
X-Proofpoint-GUID: pyOntazEjkz1Sq4pOGrVEXkst7CEkx4c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXycrfTLpog2b+
 CXcBlQwtY/HJc68dlKmtA9YGGjIskeJbQ1BMBurz0LLyUvTVgdX8gHbGVOBIBNAPcBThSwwvlKN
 jzaJEEzfBe0jC1RDUoITDIpWu3VaTyk=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47e5d9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pyOntazEjkz1Sq4pOGrVEXkst7CEkx4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
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

Make explicit @replay_mode is stubbed as REPLAY_MODE_NONE.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 stubs/replay-mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/replay-mode.c b/stubs/replay-mode.c
index 439d97e4a87..5bc8f7d6589 100644
--- a/stubs/replay-mode.c
+++ b/stubs/replay-mode.c
@@ -1,4 +1,4 @@
 #include "qemu/osdep.h"
 #include "system/replay.h"
 
-ReplayMode replay_mode;
+ReplayMode replay_mode = REPLAY_MODE_NONE;
-- 
2.53.0


