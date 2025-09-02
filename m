Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EE5CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utHzn-0006nf-W8; Mon, 01 Sep 2025 23:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzj-0006ie-DW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utHzh-0004Sh-RX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:47:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rk4x020472
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mAJtXMwUtsS5y291JTNbgRaDyq5wKQuBRnzexP66Fwk=; b=QmzW3yx2HJrOg3Wg
 VRfDbUy6UtnZrxBXTsxvIDmBVbyH+k5I32YbRIkIvE9+BOeJgQi0zzUQWtDYxDeF
 rvFWmlZUCYN2aa0pRPCuQuPkKd88NY2Vf5Coio4dU3bZcoCb1rRnOXq4JJr7N2U0
 Bjt7/sugIfnJ8DI3WdW9ejdzeC4rNUBoBd9GEZ8TzLOsJ7tvd76INv0wpVJviKM9
 1993v/KnG/o6yzPQ8ja6W84qc5CEXDisEXFaiL/Otp73tOISYiPw/BASaOVOdoE9
 RqYDCJhDxPHVjOD6GZW7UKfqk+m0rYNe0GHMCagtLaT4VLpfwcMFv1es3A7QiQDJ
 CZGquA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rxf1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-248f7745075so72304985ad.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784859; x=1757389659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAJtXMwUtsS5y291JTNbgRaDyq5wKQuBRnzexP66Fwk=;
 b=piHbaTplCEYLYhrsEEdpLnM1ZnTfbrAO4pMUvVXd7um2D+iWCaqA1NYwISetrvySGc
 9GW7BmNtWLr+ssoIS7FKisZ7iaI48GpMSrRFaJMpQ9WkfWCRW294nOhjFxbWOFFyetcC
 Rhr0tnnXcWmWK7bjWKcRXkjgs7LtHPAep4SQlSFnJzhM5vcu7jXIdg7sP7v+8B2edTGF
 Sl+S4tLHkBIzN28XEo+/WPgkxfpoVzRZDRBl6IkS0qY4FODtYDg4rHs0FfOgyvrdqVvX
 NgqAaQSqwcnPMY3S5h+CpKpKhsLtAQtFAW1VmaCDdYzNyBNWL0FDOvC62eFc2CrvkzHW
 5Lhg==
X-Gm-Message-State: AOJu0YzowerMZKEq/VqaPg9deBfQWBuug/LnhlX/cnVrtCHuoiVIj3Rs
 /cIVkJpq+7hMw2n3dEy+ZMEneZSl45JSfBKy8wKeJe4hUHSFgXHPreDz/n323aqIPnfcUhX6CJm
 Gzb/biQKeUqi0qXIM8WW3oMdA2Jx4q+M6fMOnJIJbsLJTPW9p5IK15mZBRU5u9NLJNil6
X-Gm-Gg: ASbGncvBefBbgBapToLLtvJEJlGwLM9P8anlMZA1k6jH2npG7L8IU/vTnXibwZyMef4
 9hOUczWa3eBlcl7K14aL3AVMoYMuF0VBelEGf1z8z0i8uEHo7HLjaZ81oIwT432ZKK3pL7QZ3+g
 u7WI2H+EdyKV3RaeXVaAZX+W747EoisumhJmFeuLa3fpurIUSKaGDTD3iNej4yb2+hZiw9gtFfQ
 luaAFXHy6l+UhY6xKJfY3h9Ng24KI5l2QjwLzWlL49cO5EeNV08xmqwDNJadAa+U+MZh/f3hbPA
 JA2fchESRnEGODXFbRYBFXrKq6VP3pWnF5flQckr2ap292lVrlCPCWP1KuhfutKqGBCD45ovTPd
 V8jkdbC2T4SBw
X-Received: by 2002:a17:902:f78f:b0:24b:153f:7722 with SMTP id
 d9443c01a7336-24b153f792amr11968165ad.43.1756784859419; 
 Mon, 01 Sep 2025 20:47:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+fd+2AlHSe11wti96KJIbM8oCI6sg1lalh0/OtMo8K1sRNVbZwDHA2rpuSHq3RBLidAFptQ==
X-Received: by 2002:a17:902:f78f:b0:24b:153f:7722 with SMTP id
 d9443c01a7336-24b153f792amr11967805ad.43.1756784858925; 
 Mon, 01 Sep 2025 20:47:38 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:38 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 14/40] target/hexagon: Add TCG values for sreg, greg
Date: Mon,  1 Sep 2025 20:46:49 -0700
Message-Id: <20250902034715.1947718-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX0RpdCy63DJ7y
 c3ntqzwy/7dVPlqVecTwQGDQyLzjTtszCeSAEiPz2ULxHEn1enW6GzK7dJDur5BtKNebAoAunKI
 cRdTSMZEo9kf78zjVsJsqTAnPnQiDhzcAHR2qyZwD+Sih28ibOzTeETLW0vafGgCLX9szWq+EXJ
 bOR0rWkJKHYj4cTLfuPRW9B/kGRKZUfrNVpvhKIeCATBqVlV5HXAWF1VjZf8Zjz7JSzfFykmjXI
 FOi2LCs/ZjwIkVLiv3+gc6RvxKGdkCcglTnvMQEGs2SnlEKZUFu4Kwm8n+QZmKbyDD8Mu5kZ4DQ
 eYqrOFsLNM/DAJmgr+AkWKKR4yMw5Me3z6yuyCoI4+dRywWpeuxbRRe/vHO+0YLML/lJ5nr1aAE
 Qe9FELIE
X-Proofpoint-GUID: AW6xImXAGNSD6CW1DrbI95mgepbqcYCQ
X-Proofpoint-ORIG-GUID: AW6xImXAGNSD6CW1DrbI95mgepbqcYCQ
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b668dc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=cx3kwmWHRlzPn0WqSTwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019
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

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/translate.h | 5 +++++
 target/hexagon/translate.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 2bd125297a..4c1868369a 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -280,6 +280,11 @@ extern TCGv_i64 hex_llsc_val_i64;
 extern TCGv hex_vstore_addr[VSTORES_MAX];
 extern TCGv hex_vstore_size[VSTORES_MAX];
 extern TCGv hex_vstore_pending[VSTORES_MAX];
+#ifndef CONFIG_USER_ONLY
+extern TCGv hex_greg[NUM_GREGS];
+extern TCGv hex_t_sreg[NUM_SREGS];
+#endif
+
 
 void hex_gen_exception_end_tb(DisasContext *ctx, int excp);
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index c87f07ab69..d788aa227c 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -62,6 +62,8 @@ TCGv hex_vstore_size[VSTORES_MAX];
 TCGv hex_vstore_pending[VSTORES_MAX];
 
 #ifndef CONFIG_USER_ONLY
+TCGv hex_greg[NUM_GREGS];
+TCGv hex_t_sreg[NUM_SREGS];
 TCGv hex_cause_code;
 #endif
 
-- 
2.34.1


