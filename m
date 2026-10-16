Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33F7CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRq-00077Y-Fk; Fri, 16 Oct 2026 14:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRm-00075u-I6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRl-0000V3-26
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GI5NBX4097587
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=155pBYhgx+W
 wsUegV+Bz5EVgyz9dIb4XZ8v4z+i7FV4=; b=E6zblaK/350D89/Tr7Gy8l+brjC
 +kAu5NAHT542v0iRlx5ZKNORhKDN+HoZXOAXZJYrNbYOlBFnvZYb7AZDpfe5Wroi
 N1g3xALQOT77HiCW1X53YcedH2NuCLDkiSPobYmVlV+DB89pDfmQt0RTRptwUt5q
 +DFuFWcPL4JQWP5lW7qDFwQaUPFLsGwbNTmBoSLI7PtDvKtbxYSYrYz0uB4LOSrN
 4myoqwvpogCrrSqQmbl1UtMIyT+GK+H6PposFsTsyNq1JrHe49jFBSQpUBY9JCm0
 +IMNHDm0IPLVwdh06sXhTds+hgXdkCQ2c7bofqJKXhV/2c6EDEfkZlFgAdw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbrw7013x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a47617a0b3so272228a91.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174462; x=1792779262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=155pBYhgx+WwsUegV+Bz5EVgyz9dIb4XZ8v4z+i7FV4=;
 b=Yn6Wz44UtWqK2fMGpkJCE95K1bJpqFK42oOQuXRvjvjZgLqD2UN1VMt36s2WxmNzII
 K4EC3AseY3/94JamInNR52VIitiBYmJAyyVyRqdSomTWAeUvgi7pK7Rp8k/TBYVqXElZ
 9+Gz+CquKYwRe7AeDQHls90pTlQ+Fl0+v6Cm+TyGvbFs4GgW2Mci+AAt75PFauvMXLBP
 /yeDWbWnKO8e+l3B923iyMP3XgFO0pwEu//MWjDP7air37H7ikbDnvDyQI0wyDhcqdDu
 2+yt79JI08GdIvvd1x/TOnvqTGQojpO55hGhUpLxVulT548Jok5HIKrrqF9qyoySr+kj
 b32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174462; x=1792779262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=155pBYhgx+WwsUegV+Bz5EVgyz9dIb4XZ8v4z+i7FV4=;
 b=CNvGQR7CTh+rDAPhmoHs2hgrwFJeVDV6Fz6V5H4jC7os6WTdNqcFIejEMMUiIXxvDj
 xVP/sNrtyy9FpIOdc82zCPrwhkOYD1bF5YUr4kBhPjy7JbZDz6X9ZyIobDcjaxd+soK1
 cHGI4xkfz5vGPIWind5kLyQMzYCQt0z8ATbR9qNnmJygGxaH1CEaY85bowELWWnjTlGd
 wc76dcTrV1NKPITRu26JG1XmZm+7so9rR8AHIkUllP+KL+rXMkRcqNzna8mg2fXlHhlg
 N/GmCNjaHHeofdvJeTiOkt8rCiMjADCxhRQELhzMkTiIojQwjC2iJfyFUrpiWqwQzQqJ
 PFfw==
X-Gm-Message-State: AFq9FYJ+YN3wxJnoAbpcQex1WOhoYYLQKOl8+ltPsydTWwQ0ppfGsCiO
 fkncuRM6cqBEjEvBxHokJUmeVFzpvOCxJSktLvPwtatzbHUfHLqhY7nrA8zs5lkeD1XWWZjqSB4
 JP8u00YEXvFIMTkCkHGGgR+gwoMrcMtYbJ+IjbEgp/X7/AtcR3jKH+DBjebd8LlCbTg==
X-Gm-Gg: AYBFou1/DqN1So4QMfnZX6pMlEVjVpz5/icqPC0TohKL5i072JNcri0xsOnABSzt1bs
 AbqAwu3HOiTU0HkDUn8ZENWp6uaKPsnFVlHfF1opojsnY5UiDUlNwiQrjWctvvQ5tGH9+XtmX3j
 nxcvUdPixAnfGL3py80EyJCSpiny/cLY9K+yl32pLAgC+lXtqhxOfHJNgWtuUbmcUn+612rAyi9
 y9hcBbz4ZDevQ2AP+QPhmE+rAS3xI4A9Pw136zXvH2U0/4vVhy6HHrLca+xgbWPeOzLx4XFPzJH
 UcIAUxDVhtNMjxof9vQmII/o/OG06chAN2LLlsK9ZAz4TsgGcTC9c49Z5Pz/Nt4CZiR234bIYwI
 gxyM5T+Pe8HTZEQNAVo8MEXZJvCgzOW5uJOv37Ssil6RXHPKz//gb0hT1pzwTaps=
X-Received: by 2002:a17:90b:39ad:b0:3ac:a7ee:678c with SMTP id
 98e67ed59e1d1-3acee2796fdmr486296a91.2.1792174462453; 
 Fri, 16 Oct 2026 11:14:22 -0700 (PDT)
X-Received: by 2002:a17:90b:39ad:b0:3ac:a7ee:678c with SMTP id
 98e67ed59e1d1-3acee2796fdmr486282a91.2.1792174461953; 
 Fri, 16 Oct 2026 11:14:21 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 04/23] include/qemu/typedefs: add GuestPhysBlockList
Date: Fri, 16 Oct 2026 11:13:51 -0700
Message-ID: <20261016181410.191743-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2e3KaBw6zko2
 XxOxfz1TDovbzPz8fMfzAvNPV35E3DPJrrh3Nt3jYdV2P9Ckc7m6h1jcmK5B+GTUGLbLq5yVgGC
 OX4KL36o4CThkGQL50nAcaw8kAzKwRw=
X-Proofpoint-ORIG-GUID: JHPKMjR1JWT93mrCPny7vvJr2eFVA6gk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX1A2ruMDpgV3D
 ZYDTtCVyIZfmD55w7gIyhn47UhMfUQ7CM6hfPPxHkR5buk/oxNcItwN/F6jacpgt6OyLMiQBCkx
 nso5A/WgjLEu+SQQA0mpXzdv0aLtJUdx/84o+bDCISCppRDRCDavTgEzCn2hEMpjzn3oiXj+mfw
 6YGOpCFszo4kOVmiLS5WzjoQj/ebs9UI53W9O7ExLim1fg3H2wL6eR1aBXAnybI1/Qb5nMNGnv5
 BrSd3eYRYJ8csB3UnUJPckTC2Y6ObOgYYvsgupt3pYeZddCYZACPaZW99x1snJq4GKaf/e71rXv
 2kOOdHrmMte6bb+MJBrrEm12Nn1ydC2AofcGgIh/zZAOMH4MidFX8GIcBRc9wwcET7TvcDNqEuh
 TJ9aC8pQgz/Ga7JSN267svX0wz+AUi/BJaTX0QkmMd5faUomlNE4hLVVg/v4OI97JHeGP2pY7NN
 qk2Ak2ve4hV9i27AE9Q==
X-Proofpoint-GUID: JHPKMjR1JWT93mrCPny7vvJr2eFVA6gk
X-Authority-Analysis: v=2.4 cv=XKKl2ghE c=1 sm=1 tr=0 ts=6ad2697f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=LFRp8AMknflIiveWUBsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This allows to use a forward declaration instead of including
system/memory_mapping.h.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/typedefs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 8fa7f752dac..488d2556670 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -53,6 +53,7 @@ typedef struct Error Error;
 typedef struct EventNotifier EventNotifier;
 typedef struct FlatView FlatView;
 typedef struct FWCfgState FWCfgState;
+typedef struct GuestPhysBlockList GuestPhysBlockList;
 typedef struct HostMemoryBackend HostMemoryBackend;
 typedef struct I2CBus I2CBus;
 typedef struct I2SCodec I2SCodec;
-- 
2.47.3


