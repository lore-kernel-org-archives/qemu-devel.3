Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8820CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1m-0004dO-Dv; Mon, 01 Sep 2025 23:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1c-0003W6-Dq
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1a-0004eZ-Gp
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:40 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rmng029940
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ooZLOtH0gZeA55y7LZQUilIWEwM2EaDEw66LpHs4vGE=; b=gUDAtATc0GkswXGn
 IU8aB112uCDG/Hgwzrdufc4YCPE7pdWST9ZKCFJtbmlb6p2JDaBefPrvThMRIzDH
 7gXiY/GW18RVAxT3wSYJF6W931Qgl+Em+UBwhS70i2132vWGetZaOKwlII92H95k
 8zBMkgp7aZBCDPJDxRINqebogjQgo6GmBBqGbNDbkI7l6fcIC6FMZzUVpigrdiEd
 vdWGhhzkoHjps/ASGq3b/guIJ6/v5Ofdi2LdsawCc7wh2tlqYLa/8ntZMdLWbT7r
 LA1RZplr1NaJhBgX1P1gfPsSMkNuMKUQEy8Cl3QASufReVuIUus60eAF2aKOI3Xt
 XLvMWg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush2xan7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-324e4c3af5fso5183607a91.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784965; x=1757389765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ooZLOtH0gZeA55y7LZQUilIWEwM2EaDEw66LpHs4vGE=;
 b=o6QyLTwDTAMdOa3LAm25J3DYSTjtn/oP9zShBCNJxOC8J6Af5RsZUckhMpdgfq5DZC
 2v63B6v4gCZNyt6/e4mmZjVp5a3+aUlrnKbCa5wZBRgmd8DsqpoWdQW09iK1hNYJ60DR
 Tah21AlfW72iwXTx5qEdg+79EAU5+rG5LZwjJUKw819n/6ghkQKr1Xhytj+tstJ8Khv+
 Q+sKpy3o61rfoDBP33txB+qrdGbj4xY+OgdcomdON2nXamz57p5emfBIVWtA87TJKOPn
 /MrDYfG/oHSUXdFm4oOsfAnG1jN8jTkwtNJapJsubKuKBaBtbdWc5EAmTrkqrPMJnnoC
 HFTQ==
X-Gm-Message-State: AOJu0YxNog4MQkYSe3wL+piLKA3PY+dRPj2jqTGXGhWOwlmuAuvE2x9W
 ErjhlCyocJ1Xz63vyB63Nhf2Jc1amOvu9SlCvZO3VH0iOg9JZAMgFx0diLDoQZBgtm8OhJ2oYCq
 5R6fyTvTIPFJptruzjvE103TBD5iw8vQFV5hgGA1s5f8w2NAELfHmxsXOI73neM1nJv1j
X-Gm-Gg: ASbGncvjGa72wUx3S/2lbppWxPrL5sftcBQe916E465f4fmgu83Wj4Dp23kY0wXIDxS
 byh7aDDYDsFipDfmB0ohiyNkzfIb5ZPej3FRhh5E3UxXFwetoDodX6VI5ffkuy0IpKDIznLTOSX
 NoBrEFKTF+c52I6G3xrIKSF8ZiI44EL4WFdbAkUc3QShDWBm+lsL/VNxRn7PCHvMutUsaq2QAAB
 o2SVGcqBuwXCod0V5PC7zQ9jgU2rY3LmLjZIzOhZJ8JCaeXwMFO5DD5gqzTuIdQURwm3WCzD+vq
 ESOiYqRy166OW7XC0vrXBWGiD2MiuskLx6e8GUOTyfoW4qk2MXchiS+VAoMmLJG49soZ9D+n1bg
 2J+4wlOvRmT33
X-Received: by 2002:a17:90b:3d07:b0:327:6da5:d94c with SMTP id
 98e67ed59e1d1-32815437c67mr14265872a91.9.1756784964956; 
 Mon, 01 Sep 2025 20:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUrYCwkBydEfE/jF977qUr2w1ksBA2efwIF5PRjbi+Ws6aVnekm7K0NtvjWyqnLKiE3Wz4Hg==
X-Received: by 2002:a17:90b:3d07:b0:327:6da5:d94c with SMTP id
 98e67ed59e1d1-32815437c67mr14265841a91.9.1756784964489; 
 Mon, 01 Sep 2025 20:49:24 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:24 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 27/39] target/hexagon: Implement hexagon_find_last_irq()
Date: Mon,  1 Sep 2025 20:48:35 -0700
Message-Id: <20250902034847.1948010-28-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4kbjnU3Es0tK
 IG2tbGmXHcUNNH+xDeNOUH74czHC2a3XRZ4Js4i0WMaSqUNGKB69fxIQBbdyTjmMLSAezgJIUag
 +QApQde1IrboGIUTTiWyTjR2goY+UU+WHT1KgIgwwF9L+y9TiPoU1C1zKkfAbm40MMv53mSjy/m
 qD00XB0G/1XMVSo3Y+QLvV8+SP6tWp+5fH5Hi/+4TCqQ6wDC9C+fwm/C3wXrrWySkj+4inISbEw
 VcwFelM6FRp3TqgbbMpT/gFYIPTR4e7SSlMSslVxn4tJvYnXRWjT3+y7zbZoqQQeb48+FVF1GSl
 SwBW0jZ7EBqmmd5cdR3VWt+u50WWmdlM+0tah0Ga1ljf7+htibhwPiw7D9AxXjj5DrOeoVbsalG
 U4rXa08C
X-Proofpoint-ORIG-GUID: NKWY3_YyiR8Di9exIkSB43gPbFOruCDH
X-Proofpoint-GUID: NKWY3_YyiR8Di9exIkSB43gPbFOruCDH
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b66946 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=lnlm9rIWFyOPqHsVLmcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032
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

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 37a5b45e75..5196226f02 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1643,7 +1643,13 @@ static void modify_syscfg(CPUHexagonState *env, uint32_t val)
 
 static uint32_t hexagon_find_last_irq(CPUHexagonState *env, uint32_t vid)
 {
-    g_assert_not_reached();
+    int offset = (vid ==  HEX_SREG_VID) ? L2VIC_VID_0 : L2VIC_VID_1;
+    CPUState *cs = env_cpu(env);
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    const hwaddr pend_mem = cpu->l2vic_base_addr + offset;
+    uint32_t irq;
+    cpu_physical_memory_read(pend_mem, &irq, sizeof(irq));
+    return irq;
 }
 
 static void hexagon_read_timer(CPUHexagonState *env, uint32_t *low,
-- 
2.34.1


