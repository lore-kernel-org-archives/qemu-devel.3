Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1211F417EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbv2-0001O3-Ax; Mon, 09 Mar 2026 10:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuq-0000yI-N8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vzbuo-0005H2-PC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:49:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 629A6h9I2195267
 for <qemu-devel@nongnu.org>; Mon, 9 Mar 2026 14:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jXncDzIpL7BHLhBBLfh8X+wcCJY2MGqK0a3S6KiKLrI=; b=YkP9p2cZWRi5KSYD
 WR4yiEhYDSMmUD5XE2+Pk5TmSliIV8os8j0Pl5ZDigBsgp4TOnX8SHpmypkn8Fg3
 tI1QDZAVA8gxVyO09MpEb2SRsCG02bw/RNBmStV/Wi6dGy8se7DMzWAS7h4yWuEK
 zGsP5iue78cdk6xVS5gl4YTveb2+N5J/EbaOZbXZ5qGVZRZus9DhnsiUMGLdU/h3
 JaLP9ctg8Qga1cXz73XaCaYq/xaZ9i4t26zmRPfkQlQAlWKh2cRUFMXw0MUpBAf3
 Yiu7NGyr8c7JgwXIDDs5d/8mxrzdo9PLFlcMi5e/d6kjhd8fxDEoL9xuV6+11Kht
 Mjfrzw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csv5u8vkn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 14:48:50 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be1bc0905bso6078494eec.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773067730; x=1773672530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXncDzIpL7BHLhBBLfh8X+wcCJY2MGqK0a3S6KiKLrI=;
 b=OQtCe4yQUb1+XVldsX1TS8JJBsS6mbbLzaWaJkfrlIQfkUfRzautJMq7wjYVFgWyRC
 D0QynDACEG2D4YW8qEevx9393ycVeYwN4Orw0d0wizWWhWC6k7KFDFOrWiSVhszzXLxA
 br0hqdw7B47vm5EehMI7jmNwowj1E/CXH8ja8m+58e9CaPCNG6AYYCE0xPtCDJnBo7Hj
 PBB/xseEz9NSpnKpuL5lqE+ABB41qomsby+vAFDllwCT+dGzNyP4Cn+Sg5MqVRUPiYdk
 itRrxW3T7NWtH9gQ7RS1Tg+/hqX7pc6Ui7Kz+zqJExGX8jI6y+bkTLQK97TzlXotje2e
 hifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067730; x=1773672530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jXncDzIpL7BHLhBBLfh8X+wcCJY2MGqK0a3S6KiKLrI=;
 b=bMUOglmgHVXI6qjwGZbUbWc9wYe1NvSb3WPrZxxZmp3s0pB0xOdBGnK0Z/muP93a2k
 hrQ4r2RSB+UCFHyicT5LeXSXLRTLmlZz/BUxjofs/RwGZntZtcN3M4sAZmCuFEyjjNSJ
 4eFzsKGZSpL4fPCyMzNYnNqkm+wNjYAy/IbBzmopyXYLXnjqNOriJP7md1CId7C3MoqT
 7QPVPObXq+iE51hPVeTXOTa2nzLvUDsVwdizcDLzydOeqq5SI3oJl5oAl5FfrEO8cKAi
 m8KuewY/qKIEteCh+G265jKUJtlv3QBvAuVwido/zp6uVU8kgedSyF4cED3PNWLYAiiX
 kkCw==
X-Gm-Message-State: AOJu0YzB9p4HnLWbKr6PbLivgolk7lxOTpzB/nawWISqIKf0lWeB3FCY
 xmdMNGbr+MFV2bwxU716qadoDTbFi4mSCFO8kRF9ydugQBaTHdECo1p0kGzIPOaWKE0Il9GwFW0
 NEdVPU+P+kb3AZHuefJZsZZ2MXDR8zmA9BxPxddfXCW7nhdK3Gx1s184kvcmHP0uQOA==
X-Gm-Gg: ATEYQzxivoCQowCpRbYuANhF5VXQoOTTliwi6vvTSBG/GzdQFj12/XjISCtJzJLekEV
 suQYJqkdjU2oLVxs1Ps2MBwPV2dv0H3JhiRgpU0UysGYL/2sMV0D6WSGzPW7VFMKk8nyNjuWvOo
 UBAAWH89kv2QsjQ9wLNNBRcl1bOrBw1Mq6Kf4tvd17fp+CCC+NlCDZVuBFsYcQGDkf4JU9O+Y9J
 Bb3EsnHdC283a9qvmsN79qzN+OtX9Z/34aXQeK9AEODVIrcMoFycFwgzBYaDz7FvCJePmrnXBCo
 bTl98wF5axFRdHzLw97TpYEiX3cu8tAqgMf7alaqHehUE5WxpDGH87QtfKgjh3dAL0ZUa+nyQOR
 fnNenEc7iIyOx5S2h8pFHOU6Tc1MsQc2cLtQnxEAj0ujDAw2ERAEQnUnscBu/w/tUfM+3Cw==
X-Received: by 2002:a05:7300:fd03:b0:2ba:9835:1113 with SMTP id
 5a478bee46e88-2be4e090029mr4474598eec.36.1773067729410; 
 Mon, 09 Mar 2026 07:48:49 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2ba:9835:1113 with SMTP id
 5a478bee46e88-2be4e090029mr4474578eec.36.1773067728876; 
 Mon, 09 Mar 2026 07:48:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f82b78esm9322776eec.12.2026.03.09.07.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 07:48:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 20/35] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Mon,  9 Mar 2026 07:48:07 -0700
Message-Id: <20260309144822.877695-21-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
References: <20260309144822.877695-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QuQDlqZlWC2WDEj6w_a7SdIqtyL4qU93
X-Proofpoint-ORIG-GUID: QuQDlqZlWC2WDEj6w_a7SdIqtyL4qU93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzMyBTYWx0ZWRfX2s6K9JOqQuJd
 7TL1JOhe5XYN2z0OFzOlWXCI48wkVNQQDxe5AaEqART3ZwAP4u+7mCyXAgXb5G4CcKjcGBWFDQM
 RhnwZkgO3tAOkiFCxfOBG4KVBYvow6ery2L8j9jFZ6syf9YEW48H/nfyK4if0AX/Ir3g/BELKTR
 u9HBEHGDgS/D27n0ykDTnvm2t90BK4WSHTbpzOZOkDHP68ZbH0wZVHhFttqHd5fWFeVAICpfJwH
 3CmG8TERwso7fsKfIsI+yS1g/fI74Wkdt1k+JO1H4AyB/3+G0lWbhvzxXLXGmKnLEOn/mPV5wY5
 SfXjm4t68TaYM3z+HuKwgTMWV3542lDzeaBWRqD22lmLXv1enJfSISkCOU21o8hv/z/Tac/e2VC
 bmqk6xRwCpzgfSwFqcTUmkk+XZ3VkuLVS+0ZV9gRiIlVunhCxMPZrTKNwVuL20gioLVZDZz8njY
 uK6C7XvV4Yg1DL9n+GA==
X-Authority-Analysis: v=2.4 cv=Xr/3+FF9 c=1 sm=1 tr=0 ts=69aeddd2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=3Ncpk96OCEhYCSOrUwYA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index 85745ef48c2..b9a5b9e2a29 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -250,7 +250,9 @@ def need_env(tag):
             "A_LOAD" in attribdict[tag] or
             "A_CVI_GATHER" in attribdict[tag] or
             "A_CVI_SCATTER" in attribdict[tag] or
-            "A_IMPLICIT_WRITES_USR" in attribdict[tag])
+            "A_IMPLICIT_WRITES_USR" in attribdict[tag] or
+            "A_PRIV" in attribdict[tag] or
+            "J2_trap" in tag)
 
 
 def need_slot(tag):
-- 
2.34.1


