Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704DFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgwh-00045f-Ud; Fri, 03 Jul 2026 12:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwg-0003zo-2x
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgwS-0000zR-MM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:40:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJ49d363357
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=; b=fVxJANe1j6+71nbf
 ovt6sr3VkvYZZ82SBp3vqUyk7MbzSH9C/YFrFWbao7OYWtxrCWPwX/zBR6SfCNkJ
 B8C43+FjuXYt/UPFx6sCWxHpy3t1E+/C6aL7usBWafjTLoUxgDCJDwqG9O7QGv2m
 y5kL/QTExufLJr7nXCwrSTpPQ006W7sVSsmMmny/1ek9aVIq0HqKxGd5qNbTt4SG
 jYMSStspbz2ixwpSgLWqibw+eQ5Avaz/fGhJ2UgWnjvdKOU4JGljNfXPNhWtL8WN
 +Xo5POSHHpZvqJT+QJMjxKV5fvVWpg/1ihHFN958zWxvYM9EVTSLd9LR3ppvajtw
 2tad/A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682bt65c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:40:38 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e934385db1so9129036d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096838; x=1783701638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=;
 b=XfgvkEU74ZbOKgx0WyX3aksmJ5DsoOK6SWzCUPD5CK1qbyhT6gmFGf+ku0QEZGOuh8
 IYyXpwXxReNr49pqMCHvcP6AtCSa6RW/dxoAGeH2tEnNHXMIKeaZGA8dix3jr6UAoKqU
 6hbz02VBrSjQrTQ0+AFWlOTSy55QQOf1TFHgzwAFqLeFik8aMSQe13NXEtzOMWjS0KzN
 wSeCkEe1qjXfBzu/Z6gOaeSQhhs6C0nwvJHfeAMEviG7aJq78cDl5qBB7Ok4lB7mGiec
 WWK/Ly44CBXuGAljSawvd6xjGeZKma1MXupz0nJCz2we8XNthfQh3liW99HlYYK8374P
 Y5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096838; x=1783701638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yi0iSVj4LIkP2DPM2Oyar3HIg3gxuDuywavv3adUmn4=;
 b=oppdfRGTtI/8KkK/SnqohNcH8L7+ri6cvAUvgD6xp5PlMRqomhbIa0np4IkANrwrsY
 ZBvOi3vWD5LkEzrGt21lsdSnQqwE5Wp6JD2WT01w0qeOzLMXKfiEs44pwf22cyyt5oaY
 vbKicM7qcOlMnozWtQnrq+ELtxlfGbFc7gC2VBUmBDBdUzYS++zMMV8Uf89JaXu7jpHa
 PYAnoAEsEaPa0bRan3pkB26coxSVYmDTWCGX8A8xlEwIG3G6HKGxaQEvIvWmKTuOkDCz
 jSQahoh0f93YavdKLipGRcqvbpHy0BZoEsNN0FxKdwbbjgF63kT0obn8QBRyCgUMHDTZ
 h/0Q==
X-Gm-Message-State: AOJu0YxPJibyeF+mqm2CInHZnhjkZvbeJu8qNv1rZB+laXvxe6WvBZDo
 jcdBfw0974eWJoAfxstDyQwyiyBG3UWE33RjnKycLi9Aok0oFhzQtfkjRSkE35JMtpZcWGxFny9
 yGz0kR/2vTfO9UPYDLrASVnYDXu+ScpB0qf75Rk73KnmHTda728QKQAm5jIpddckLQw==
X-Gm-Gg: AfdE7cl6XrDm3vksVkIrzTUe0BNfjuKeFMdjrOTNgn3XqLFygC9nPvqFrF97SCrbG2F
 prwaMjRN+WZnjo5aw16kFTAn4jger/9UW0M7IIZj2E+NgtHvLbS5n3Ar8jFcfaAko04ejK5ezpJ
 /xPqJvdtbPQXaymvszKCcyxf5tQeTeJEvaf0J5aKVSFJJntC79/aoOvEW6k78CvPVJfehVjebew
 mpqpf4KQTKL/3B2RGCFj/xoO4u9Dyst2MRY+d+/SO0Z/TO1ZsF/4F4Ewb9gWW29Vhb/NbBWSTpZ
 yMxOO3oipRsa4SwE/0ZVcjX1smYgA740tbgUh0vAmQsHtIHc+v4EBqoSFwUaCCrEbNELt8nPz4Q
 XkvFBjE/Ov3INrlSQJHokGpmCQPAozBWfn3cYG4Zarz9Oz9ESXPq0/+eQFCisSrbuFhQA
X-Received: by 2002:a05:620a:6088:b0:92e:745c:6c49 with SMTP id
 af79cd13be357-92e9a313e9cmr31850885a.15.1783096837576; 
 Fri, 03 Jul 2026 09:40:37 -0700 (PDT)
X-Received: by 2002:a05:620a:6088:b0:92e:745c:6c49 with SMTP id
 af79cd13be357-92e9a313e9cmr31845285a.15.1783096836955; 
 Fri, 03 Jul 2026 09:40:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm610491f8f.25.2026.07.03.09.40.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:40:36 -0700 (PDT)
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
Subject: [PATCH v2 21/33] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
Date: Fri,  3 Jul 2026 18:37:44 +0200
Message-ID: <20260703163757.55500-22-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzwK1+H2zqT81
 M2OrnVRDU7XfdT9w43hZMSfvoB0QHeV8vSaniOl12EbhqfVblFsSnpmwXoowJ5DRW1w8dWZFagI
 byNboGBL/SQJTGDu8GqQaFFlhnubr/x3rfl/RdjMJKAHVnJhWtE1Cv5fAAEzH61Y0Uh3u2XaYeD
 F713SQypi4XcXEDf0tGMGAFWFS3zSsuVvBl4svHiQkodMYISxK9MidkXSZ5ugsssW/TFbZAxnbU
 ZoPZ800CQ2Qg4PMMbrwJMNwn3q3pkSbpOyfykZ8+D1ObyU5VHqZaSfXieO3AlQa2si1E7+cKQXP
 ecWHFCBMoJytdVeLOq2BDJTwoGzBtUWJy4tXmS8t4qN359Qb6Om8oUNI0616iF3OHeI7LxWATuV
 PQzN1ELzvu/Suvccq/OqPRiSWBY6ukAJ7IrRNRMrel+uGm4CNSDUTdJGuW42hvZAarzSUeMw46+
 QjqATo9PLyn/MFOFZCA==
X-Proofpoint-ORIG-GUID: CQiEdn8YgNA5MquTSveC4bHIlOlMgCUn
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a47e606 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=Ucb4Co1tYGy3ov5cU_AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX80Ht2DPcRs6p
 fsjLRdWhfHs1niKT+/w5jtAd2OSVWI5fBbd6doKhhJqnybIGdqda1Pblye48YiuyYAbXctlv1xA
 eUq57hGoMKtKW9CTsZxpXsCscb0quBc=
X-Proofpoint-GUID: CQiEdn8YgNA5MquTSveC4bHIlOlMgCUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 26d34c72d9a..c54acc770e3 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     }
 }
 
-static inline void tcg_remove_all_breakpoints(CPUState *cpu)
+static void tcg_remove_all_breakpoints(CPUState *cpu)
 {
     cpu_breakpoint_remove_all(cpu, BP_GDB);
     cpu_watchpoint_remove_all(cpu, BP_GDB);
-- 
2.53.0


