Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDDBCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0a-0007Xq-Ge; Mon, 01 Sep 2025 23:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzs-0006rG-R6
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzr-0004Ue-CD
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rtak015204
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dXjomX+TprzQjbPBy/v1MOm2szPRfiESULT1A89iapw=; b=Jnf4cD9xN8D886Nq
 14NOIOK7ugwzKS2tC6K1nuEKhKKmTpgj04zDqKApZDyy2wF4Je37JQwH5DB+l7U6
 j+TpyJ41Z477HoLWDEnb18tydpJIn+DZItTFVc6mATeyfOJl+K/cUoc5bfYxQWkg
 41aRUdkpLtRWQnPNMz3RfXnMw7gikzu3SCD+BzoR2nudBEE9fh0Ei2ONJgo+neZP
 7yWF/rSONAtve/JKYrmo1RU6yQ51RpkxYQ3riAty/17+GGmryeQoVPayxsBXOqmB
 HHkMea4x94hGNmxDzNtXeoOH9aHPeF7LSo9bwzlRuxhMqwGUlg85mDXM1XHKvcR0
 maRy7Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyxdey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:50 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-329745d6960so2488652a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784869; x=1757389669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dXjomX+TprzQjbPBy/v1MOm2szPRfiESULT1A89iapw=;
 b=b6U/sCwboQW8v5LinyKG99d35tg8uQz0dGXrByIdtcRAxDX4WwtJsooIgFX6hracQj
 TzPq9T4L273lSmzSjypkivqBE3HTnrHv4kUod0f2U9GWWVgaNb2jqOyWdB9Afv9aZEto
 FGpRtuwTrgXXYMxx+F+HZJHH7CZ++pcUMlb1LAqvEXVC6ARpKacXMwQp8VRLkyt5vMza
 kFKre1xonk+S+CoxSUJycNL934l/b4vkKGJG88xd0j+dfGHU/OCL9YeCd8TCfv7xSbw7
 RKlbaS5Hrp1HsNjFnlXhub10znV0Itc+2dKjY92yMfVwe7Ixiyc2BTnkxlZQ98AIFZeU
 i0fQ==
X-Gm-Message-State: AOJu0Yx/Dp2WoGClN5G3NHfW0cRTnNQ32TThHIw/wYul2l+E7Sh7ag7I
 lLLgVMowdKd7xDzefPOa8XIeRH9MRb9LFhcOMYnqSBYkhg0Pj8fLDtgWah48AifjZmStPG0l00h
 XDMWeTzY4J/dfO+/3ORDdB9nHHiPffIKtZv+rde1VCVvI41mTevHRjPJzLWn/EQ7ceEs7
X-Gm-Gg: ASbGnctxyFJBv8Y76supK/bVTzJTDpGoXTU4H6EDrforsxRI+Bna4OIIocbBxBDS+i5
 C6TF7EQ9dRTxdEonhBhGqVkL1OKLUqhuC1/9nw6EsGRrmdsMuEU4PGhqySlKtsOQIumL7YtMlp5
 bHNLjb8bNdeTeGm5BxRTzJLIPhHfMn0zQcVW1Be6f/9QG3TBgkg5KuPlr5ddigXClY5tsFwLkgE
 1HT5bzW+FM0v7NVe7FlHnryzVNp5ifyyvYUnZZyxXfWY7278cQtJ1NZhwNPDA9AhFWrPDYp8ViN
 gz5wQXrFwqDUG/ArFpSMXxSqdRSl7p9GQpjQuNRV0ewZKjNei7z9KnU0izuJOtX+jlXKtepBbbQ
 5vJzUAnlBXo8t
X-Received: by 2002:a17:90b:1848:b0:321:c81b:29cd with SMTP id
 98e67ed59e1d1-32815412269mr11922690a91.1.1756784868776; 
 Mon, 01 Sep 2025 20:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFntPerk5NoL1tMnuKQeJ6nlzl2t8OG46NVw/gnG15iYIZwCtb4yb9g1klD7H0/Ik7CGMJhxw==
X-Received: by 2002:a17:90b:1848:b0:321:c81b:29cd with SMTP id
 98e67ed59e1d1-32815412269mr11922667a91.1.1756784868256; 
 Mon, 01 Sep 2025 20:47:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 22/40] target/hexagon: Make A_PRIV,
 "J2_trap*" insts need_env()
Date: Mon,  1 Sep 2025 20:46:57 -0700
Message-Id: <20250902034715.1947718-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: i6uvaJ2MR7DPYvnv8tFWCYgOqURYRm8A
X-Proofpoint-ORIG-GUID: i6uvaJ2MR7DPYvnv8tFWCYgOqURYRm8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXwMWChjq2d4zi
 CzE+NghIBCbo5EKp/hR14w6/wrWNLbodnG0cA6KqdKR1ko8+7sQAAeHwlhGuiqblOZKFfMuV3H0
 J6VU5o7Cy8j8QCJSpkIfX36Q+KLPKmHuEyUyoGM3zuWKXEX+8WBohREEI9WxTHXqEShZGMaBlQK
 eaBdgXebm60TOgA20GdRI3XEmsLYy3zJ12r7yT/0VG3Rl8CkIup2GqFquUdBL81Gx3WL1h2foII
 FIeuBn0chZxE8/fnp2DfeFTX8wYOZ8PK9eCSlpW0COtqZN6cbp7uZUypmTPpC1Tajc4+GzB58Yn
 x3/2DQo/3tHo4mYc4jEUiw+FAfK77o//edCQTvBECTaWq0JHXHu3CzGonxnScpHOMVoASRH595w
 XAJlr23X
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b668e6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=wrAvr2YEdirxk7wnKeUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Brian Cain <bcain@quicinc.com>

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index fa122b6d76..fe5263e13f 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -251,7 +251,9 @@ def need_env(tag):
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


