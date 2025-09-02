Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37A6CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1y-0005jS-IW; Mon, 01 Sep 2025 23:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1s-0005Af-G3
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1p-0004hJ-Gu
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:56 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822XJPU031628
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UM5LYPMkA0OC0J1ZEBpgnBrYVBgf9BIWiBbgIW52EXo=; b=p5JiNk7UXPhAweud
 e1yjuMMF6TirExZfjkBZXuk8CGP65d+mFnRK4JeCHSV4E8yZ4zO0A49YYZ62G+3R
 PmLD2Z0tW7/CQdF+YTPXOQdRJ4yxkNnu1AESK57uKarcnGF6deNzQAZGkuZQtrSK
 0hBNyB9OfeZFVmoxQh+nDmJ+VLhDT8Hnlgj2S6nZtJHdWaHfyvVwxAlfv4O37kgy
 OP7eSW78uYnkNcPRmhQOX0n50NCQeFL1iESRucO5lt11xkgIR6HD2j23piWktz1I
 cOpHEySOf/5CGdhcPdAGYsOGIEMv0pgCxsppddW0gZ3ZumwrxV0W/wt4/9w59hs4
 4nqY5Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48wqvw855f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329e3db861eso234213a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784979; x=1757389779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UM5LYPMkA0OC0J1ZEBpgnBrYVBgf9BIWiBbgIW52EXo=;
 b=Seni+XlmFQ3rlfoyvq+mv6pI2uDdEo/V55VIG4E/9wRY39A2NoawcsXdD73rCj7Nmt
 UXQDiCfpbPEGkc6sh2CRddHV3SSkfSDK+/IOP02fwedAoWeWTjSuerTy5XNlpIBF/rDK
 RDiaz4NQCJvLJV5T1ZUhb2U1h5xWsItwkpTWwGZJBalZ3KUCW1oa3EW5rlrOBmJywinn
 nc0SqrmLT0vJuMrCBZa+riq3mSg7jbw4ECQpkmC9PstUdAaObBZXu8wzrcmT1DBGQ+im
 pot59+PvILUtXuDTjKKeoBFzcYODg9KdnfCR2LUWJLlqEiwdhKPzINbrg12kP0jfDBSa
 qiFg==
X-Gm-Message-State: AOJu0Yzdh3hkiIEpstBxK6CZI8VIVq8B8Lf+p13y2mVh6k8erauRl5Iy
 BBvVLDLgpK0iAmvBUtGsXdQ5ZgaDMgdQBXexOTkTSDSG/rJpkiNkTUkDRgAnThOojHRHaJQrXPE
 Nz4jpmdDcwmzjLJqKj7jylqjqSgTSQGkcqM8wy9evy5yiLghh9XhySOz+BBgZuNj7Dxb0
X-Gm-Gg: ASbGncvo0CmiSOsy/l4Jq8yWuJZv+EEMEsgs57WV/dM7UmaL5SHcHAJXxywe/ddQ70C
 kRqtsfFnYQFpBtV5BIyQnOpx9KNCXF+EPqvhrTmNYphWXvuGeRkRRt8/kHt+/J4Cwqicc9xw5zc
 /pYmw11QvpFCVht8XTbzZ/G8SR4rW4tjNmoZhm4B3jKvj2KmdrGd2vkaEtMG7yqUY7rCtA9QAMD
 S3Q4Nx3zH0rP5Pmuj468NGGKvwJmWrBP0/qNC7lFnVWRiHOUx9k8EHjN3fmPK0m6Q5nwt8kT1f7
 TR8OfdC8IoShHTB47BF7RyjeulQyTaZLJWUZINchavWdyzU33JIZ5bDZH4XNZ+44RQqo3WOjbLh
 4T2J+qA/g1/fF
X-Received: by 2002:a17:90b:1d09:b0:323:7e80:8817 with SMTP id
 98e67ed59e1d1-328156e3582mr13995100a91.36.1756784979419; 
 Mon, 01 Sep 2025 20:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxPzkbr0SYW/6LdbKj2c4yVH3TDM5+btsri38teqH6Z96p416dJ4Na8MS/AjcdrmqNXPMjTQ==
X-Received: by 2002:a17:90b:1d09:b0:323:7e80:8817 with SMTP id
 98e67ed59e1d1-328156e3582mr13995076a91.36.1756784978959; 
 Mon, 01 Sep 2025 20:49:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v2 39/39] target/hexagon: Add pcycle setting functionality
Date: Mon,  1 Sep 2025 20:48:47 -0700
Message-Id: <20250902034847.1948010-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDAyNCBTYWx0ZWRfXx/upH3dwu6Q3
 DkcG419YlmIgrsm0YY97KbVwG62p+9rG+HLOsEocaKMGa0+Wt2CeJXOA8B2dIyI8+dU6PeduUjG
 fFJg1EvTP22hfWeWj29Q77feC5YShu0uxnR/de2m8mNL+YW2JWcDCuomgpNviyJFTZATj7LZJGu
 sJ2+ZzfHERyCpGCArY7QKMLmOdVIO+9KMd/XAIYNeOv3e/plyyEhVhb+/InwV1jQqh3WOQxq7G/
 nXBEMMSQ0azG2iue9uIYTl07m6VvBcalCHczxg/YTMftL0ICy1b4KsC2knQnm8xIOrciE82E0Qc
 UHfVYOgG52mx9tSdM9XX+vcTsnDvcx12usDEJFJvpn2BZsl1opOsSjlWf8kz7OzVNHdCn/Yc9bt
 zw9SNyJq
X-Authority-Analysis: v=2.4 cv=WKh/XmsR c=1 sm=1 tr=0 ts=68b66954 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=Kc8miizCJkRJjwKmxNEA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QqpQaltNKNGPyrEBF-o7M08P7fNER6y4
X-Proofpoint-ORIG-GUID: QqpQaltNKNGPyrEBF-o7M08P7fNER6y4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020024
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/cpu_helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/cpu_helper.c b/target/hexagon/cpu_helper.c
index 5d0ba23d02..447421cdd0 100644
--- a/target/hexagon/cpu_helper.c
+++ b/target/hexagon/cpu_helper.c
@@ -120,13 +120,18 @@ uint32_t hexagon_get_sys_pcycle_count_low(CPUHexagonState *env)
 void hexagon_set_sys_pcycle_count_high(CPUHexagonState *env,
         uint32_t cycles_hi)
 {
-    g_assert_not_reached();
+    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
+    uint64_t cycles =
+        ((uint64_t)cycles_hi << 32) | extract64(cur_cycles, 0, 32);
+    hexagon_set_sys_pcycle_count(env, cycles);
 }
 
 void hexagon_set_sys_pcycle_count_low(CPUHexagonState *env,
         uint32_t cycles_lo)
 {
-    g_assert_not_reached();
+    uint64_t cur_cycles = hexagon_get_sys_pcycle_count(env);
+    uint64_t cycles = extract64(cur_cycles, 32, 32) | cycles_lo;
+    hexagon_set_sys_pcycle_count(env, cycles);
 }
 
 void hexagon_set_sys_pcycle_count(CPUHexagonState *env, uint64_t cycles)
-- 
2.34.1


