Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF1BFD461C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 04:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvT5M-0001VM-5t; Wed, 25 Feb 2026 23:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5J-0001V5-Qx
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:45 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5I-0008K7-BD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:45 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q4V7KI350081
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CoUNJDmqk3pIPgGMIIlyQ/
 Bb7YIqTjQyH/N3NrLQzrs=; b=c3phNVBuSMjzvBqySoXVYjsc/13oYjoO02yTg2
 uZaf8nxRxXit677CQGRvXlkKvqcDCo4v/1xJRWWn+1AMEsGcOv7nM9BcB3OY+Fy5
 sB6aeZA+jsYgJ2R1yovQAqFftKoHLYRItrqFAII0q0Br7WWPBIjQ+7fxiz+w8VG1
 ZTIbgl1wCmPKbnsc2SkDYvF2Bnua56srdDl5L1B2ozGZjiGSEuNOKq+lwZKG9IIf
 QBXqIS3Yt9VU9ye/uiEdUcaN0B9bjXvnIomSJdpiZ7zBzjwP0qBgY0sO3riO1Vhc
 etkTP/FDITcO85VTVFwzS3di/nFjmvxOd3IZ4Q0MgbAjSYPw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj54p9sqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463a075e177so2822392b6e.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 20:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772080479; x=1772685279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CoUNJDmqk3pIPgGMIIlyQ/Bb7YIqTjQyH/N3NrLQzrs=;
 b=Yx4aZgsF+vHawiC67eOHvgLVtbAGiOQ7dZVst9O+wFoKWQtQ3Yh+Vdq5SMd4fzDF8J
 7P/Imt53ukxIZysuXKgAu4ZWFGQrIhUf+po16D8gi/aH371zK4JHeNH0bfifdlckFszu
 pKZQC2vocd4BYaGDIHntdwTdjiceL/g13zJAbo0sXl4oLia1/5svt/do/lhJlCB49fTv
 6TxYN5uVD2nAG1wYlcGWndrSpvg0d9fZpBOkMaoL7thHOfIAki3lJFI79Ca9hQoX9vp+
 K9TpJZz2Iq15hkvlzgYXn/pJDV6LV8IWFV1qLR2oxU5yus8eLUtP6GAD+7FBUNK1j3uM
 RcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772080479; x=1772685279;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoUNJDmqk3pIPgGMIIlyQ/Bb7YIqTjQyH/N3NrLQzrs=;
 b=NkU51vugxFMVlwIo4PbGQk/rpyEocto7PtQ/kIw/dTbOmXZodWeZ3U0zsC+B6S1Kqb
 4l8Rr4ZFNWhp/Y3UVb21kY0M0gI9ZOuzdl5Q8cz8udumSTlNNbxIj3449aewXbY1X5RR
 BXs/cnwQ6tQ6mJTQ9hG3G4oVzdxAZpcBP6Z+LwSYLpk7ABITpXw9k9HunUCkfkvh6E1O
 iwkzsTh/LikXfHkFgbG02EufxEvPudhIUP2KkNHMWlk1554Ansc+d/RRbP+MhsnIyBDr
 x0WoUNIQszDSZXs+uevfqBhg7RoXQl/rm596kkgYxfb/DxDkaYdGxbXGZQshpWebajer
 kaMA==
X-Gm-Message-State: AOJu0YxZnREjLN57vnCzxQG9qcPB7bv4YWPnMnZQ4HWTAMzX5EjBUGAF
 UDmzsXSY2NufN4bE9IihW4RaEwhDhl3LM3SqgyGIjntXegGUC5YOXM8Og82tMsSHdZSWkfzATEN
 9PJ2fd7Qh13U533KbHWspxuXCSPPZgZA9yyyX7lEo/WkxNTsxOvVxvBMSqa2UJGJZhQ==
X-Gm-Gg: ATEYQzwGaawYv2q4rxhKjgvN1zmrSlNjB4At7dOnJKCIti36XiWkKZURsjoBbjbIQxU
 v1n1OyFtT7QdGir2XW4iGvpfDoEFOFKjL+z2VHCeuRnVHjVCfBSwCpGMTN3Ixje7oPaleVLwYO5
 eDkvcGlPOC3FwlmxlXdSQVIq//tMYJqZe5Smh2qMJkeYpmk4uxuJvmQZDIBRaM6f35Xxk7jW6jv
 sYoYgTMtuW/r31sk+t7dwsM/He6jOu3SNvPBFKqZmsHvNhWzZeu1dOV2O41uZ59ediTc9qD8KSC
 cBD5YeutN3JeOlxi+ymDt73m3sQqNSHTM0LJcFiqpbMBSETGL9QJV4nVhLwh26pSweDeD+XxmPV
 h41LyvuJHodVPDv697gh7Su6IvSSlXFpBR0S+6e67PyPzTudKeh+dcDkNuJ3Bn3u6PyS0tg==
X-Received: by 2002:a05:6808:23c1:b0:45c:925b:5848 with SMTP id
 5614622812f47-4649f01f8eemr2188102b6e.45.1772080479294; 
 Wed, 25 Feb 2026 20:34:39 -0800 (PST)
X-Received: by 2002:a05:6808:23c1:b0:45c:925b:5848 with SMTP id
 5614622812f47-4649f01f8eemr2188091b6e.45.1772080478911; 
 Wed, 25 Feb 2026 20:34:38 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1f6333sm10394328b6e.19.2026.02.25.20.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 20:34:38 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Alexey Karyakin <akaryaki@qti.qualcomm.com>
Subject: [PATCH 1/3] target/hexagon: fix J2_jumptnew/pt predicate check to use
 LSB
Date: Wed, 25 Feb 2026 20:34:34 -0800
Message-Id: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzNiBTYWx0ZWRfX5ZHtMJUscROe
 wFDqXZDkWcuySRuEWEdCdCKVSidO7ML2avBHoQ881VNa4VL6JYCwLb1o+d82kjlPnaNAr6dPy+q
 hWF0W9t9NDEazfptzrhvbTej2uFUHFTDg1C+WT/AxQvk+9h0g9IghX11WMlM5wrS4xuz4BUgSNy
 zt/lnUFtWuM+aFiIHAjHEMtYFgKhnGNM4xkkATzwKl/G1WkVwkHsgcSjd6zthxgrU/3lLrp55Ho
 U6fzrYHAUsNcAFOZ3zzXBijPlrD/kcdqZ/27Ket/ojgqZVHPs2ATlUHSYg1KFax2vOiE2UnOg2C
 p7A3xDpiL670r9ZhsByvjDUSEsgMebgxanqEgXGDup6VdeZ+zLHrTuKBIXTf1WppRbG+omQHbg6
 CrABR4dIVOnLkRVI2diGCwyrsB27N8o6h451V6NGVq6WfFUAUl5G0HTKezB4AIPxVtGD2Fk9MeQ
 wijMpMcD9DOZBcgjDkA==
X-Proofpoint-GUID: tKpo2XCLF554kqXO2gdyJaUwlMslIApL
X-Authority-Analysis: v=2.4 cv=I5Bohdgg c=1 sm=1 tr=0 ts=699fcd5f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ivnBtVQm4APjhFw-y08A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: tKpo2XCLF554kqXO2gdyJaUwlMslIApL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
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

J2_jumptnew and J2_jumptnewpt passed the raw predicate value to
gen_cond_jump(), checking if the full 8-bit value was non-zero.
Refer to PRM Section 6.1.2 "predicate-consuming instructions examine
only the least-significant bit".

This inconsistency caused if (p0.new) jumps and if (p0.new) loads
within the same packet to disagree when the predicate had values
other than the ones generated by predicate-generating instructions
(e.g. 0x80 or 0xAA where bit 0 is clear but the value is
non-zero): the jump would be taken while the loads were skipped.

Fix by routing both macros through fGEN_TCG_cond_jumpt(fLSBNEW(PuN)),
matching the pattern used by every other predicated jump.

Discovered-by: Alexey Karyakin <akaryaki@qti.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 7b96dab918..45ccd51888 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -951,9 +951,9 @@
 #define fGEN_TCG_J2_jumpfpt(SHORTCODE) \
     fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
 #define fGEN_TCG_J2_jumptnew(SHORTCODE) \
-    gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)
+    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
 #define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \
-    gen_cond_jump(ctx, TCG_COND_EQ, PuN, riV)
+    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
 #define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \
     fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
 #define fGEN_TCG_J2_jumpfnew(SHORTCODE) \
-- 
2.34.1


