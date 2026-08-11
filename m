Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ED5C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk9U-00012d-Mm; Tue, 11 Aug 2026 06:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk92-0000b0-Py
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtk91-0000Nr-Cv
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:55:44 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BAM5tD267664
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o9npvER9sQENMrIsjztsN/dYiR+wtNfB61hxFSrTizI=; b=jO1q21axpwLaNcGM
 P2treDKkd0TuLKpLOmmsTZTdAepQf4cvyaP1jk6oLE3VS6hFMODtjM+weNqiqu8r
 nBgDjMPCm5M9O9F2R8wKPoNnhmGomSgdpT6I7OLyiXaSNxxuUXpE5Crd4EEizUa+
 Fx8m0C1S0QRXjMEoBwwV0526nBO56CeKCS85RR4kN7NofU4E77HsFBV+AyTZ8PbN
 tXtM6U9B+fLUzJjvLWLhMyZdBjEQR0nXKmJQu63WogWDr8TimwsNbYJEuzWOAKc2
 vV1SV6x7PzJ52ZhteLotZ2p5CXYA8rK8wx5Uq91QbPohX66PHxTfY6m4PT4LnaUZ
 5DVO8Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv3pmv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:55:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a23afcbso35053311cf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786445723; x=1787050523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o9npvER9sQENMrIsjztsN/dYiR+wtNfB61hxFSrTizI=;
 b=jKqjyXGeVv6T0kGtZoiRTgQDgfIsblMcc/frwXOW1NRs/ufVrFXjsqgttCscjqimmC
 sjlKzGOA8ZldetyBrKQwzPxrUUDABE8KcwrDYNpr/9Pn1M+2BP8vlzwJu7l5KhW/jCvj
 SYL5bwrmZQk+tv7x7otNhpCrsSFTZDW262EdwhIeun2D7KfaDFOXLc+EcSc0wFj3/3Zg
 TXAyTT2UMwlEFj8ldYF/ThmxswyxDc6cNgUMPIBIvjvjpkHmrCxHSer8N6e0o8lVvkHq
 w//VYrHiwcmyb7/o0OtrYf1nXqQCAjwHzGrpO7SAWe/jQo9zN17QNUgEM65x7Rr5UuYx
 E58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445723; x=1787050523;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o9npvER9sQENMrIsjztsN/dYiR+wtNfB61hxFSrTizI=;
 b=FvnTmXBnJVq+htcdCuWSiOJWpmlgaccD9ILRUY3//JTihBahqmNGiXzeId1dBNAdQJ
 PBl3G5FyExhO9ZepSLNPMLCZZnteLULHT4ESltcXwxl4scIr7L5eTdPltkAIpiOYUjxj
 fhp7eNw1N/itdOnsEGffoiXMiXz029pxOM68Ixe9gDlymJpyRJP7hw923mkUvRYBPMc3
 DqJtsb2e1taY0H/AkGTLSFDfhHIHWn6E01xsJYqET3Hi4SBEQ05ZHU2ifkdWCmAfEZyx
 nCGMJruIZY787J69ed0fkna2oeZL+6MAm5bV8X0SOJjHvQiZ+/NO0B13BxmZs5Twwp8Y
 KZ7A==
X-Gm-Message-State: AOJu0YxHujIMfgz+WiRf1PbPjMPLjdIbLlYyCEcPRKURVIeSznhZv9P+
 2g5saHi1poqDrl9Imwe6oimwGE5TRpQNx7xNIGMWhDr79heUrx3ytiLTmz3yx75Y7sF8fKDVXnJ
 ov6rymxh+u3UI2xZ0FXYpNc5fZL06fEoVKmH200wDDA9johMFMjY8ZlGKYstyb5vEFQ==
X-Gm-Gg: AR+sD105OlT5lfTk1uoPECcHDBDBJUHFvlym3rkhxib7R3+LohFc6u5gJBrP1zMAtlD
 nHaSxW/3CSSqdJcQQxSXWiUEBVfs66DftNRUhcT1XcuqF5y71F1qKTBjvWDIx85AwfRwzaxp5Ka
 XcZTpCdnpNogTjPxWJ/AgMutBq2t179sdgFszinLutCYaGd6nyRUliN6AJewIk2Kp0e7wDtu+53
 OkC9EJurg0wLbROWWtpRtOxr5XlLt1B+hO3Bi+SyjaehLOm7qZWBQT7iccWCmt9PNQfcLY3DMd2
 8C20O94MKnDGJzSL4EQ3Cdq+m8OqGnu7MYYCDN17vnceX3od6I9CG93YntTGRYqoSwlJoQPtqxP
 G9XwmPUU7MUEPUA4oCK7T3X+E3PaTt3PstNfJ4vvjL//On/s=
X-Received: by 2002:ac8:5f48:0:b0:51c:17cd:1fe8 with SMTP id
 d75a77b69052e-52d5867246amr13607251cf.33.1786445723295; 
 Tue, 11 Aug 2026 03:55:23 -0700 (PDT)
X-Received: by 2002:ac8:5f48:0:b0:51c:17cd:1fe8 with SMTP id
 d75a77b69052e-52d5867246amr13607051cf.33.1786445722878; 
 Tue, 11 Aug 2026 03:55:22 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977dfab57sm29761765e9.1.2026.08.11.03.55.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 03:55:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <minyard@acm.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 7/7] hw/nmi: Deliver NMI only once
Date: Tue, 11 Aug 2026 12:54:25 +0200
Message-ID: <20260811105425.7429-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811105425.7429-1-philmd@oss.qualcomm.com>
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfX5Bogi4V9vskx
 ilmO7oUUKFLNLHJwtTZFqX+QQezB6azPvX3Io9hqTvm+rtqM+MDYSDtKIHb0TBXRIGNFmvIyBRZ
 tGqeX3k7Qd2ufXUq2vQ0OpesrbRvhDr3NS2gERHyBZ3iGhqtlI9U0Q3eToN+y9xll/HxaMgbvLV
 v8ViGxmE6cUDGeIYukLMm7ywIP/iC2gEqyfkBUix1t3FzJm8w2K1GtH5wp2nNwd8QVLh3LXkO6D
 ERUnfKFIiVYamY1trgsDe7J/Mk2jWcAeCeiQO6/7PzBMKSZRuVGDM/ePWr+vKEWnbju8eA/ZXoS
 tTT+MNGQhweSdPEiv+lESqoA19AHy2+UuZM7ZPoFUjtgo4RNkhE80iLaOCOlp3S5j7RJYr3GB03
 aMcaBmR8YJ+WctrKAYzBPUnnTwLp/CoCxWPWMSlPu3Whta/mdpyiduIgWk5iX+FuuMRcjB0Sb3u
 md5fQi19SsnCQHZyVtA==
X-Proofpoint-ORIG-GUID: SZd5Ryx9E8I7J115kQ8hkTr6XFIDAWIm
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7aff9b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=vYvZ14fGrqJeX4HkdWMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SZd5Ryx9E8I7J115kQ8hkTr6XFIDAWIm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA5MCBTYWx0ZWRfXwpSAAoFjjkWI
 +kx7xLKfzY2e7M0Qp9OXDcX47itIUYeM0KZJISMRPFCnYx7laJMEfHuyeM/NoyP121Q0iHlmNsl
 qfXaT8jtSXD7lNUZceYf2Lv7YSQELbo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110090
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

Use the first handler available to deliver NMI only once.
If anothers handlers are available, no need to keep delivering.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/nmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/nmi.c b/hw/core/nmi.c
index 8eea75ad530..4fe5ee75bfc 100644
--- a/hw/core/nmi.c
+++ b/hw/core/nmi.c
@@ -31,6 +31,8 @@ static int do_nmi(Object *o, void *opaque)
     if (n) {
         *handled = true;
         NMI_GET_CLASS(n)->deliver_nmi(n);
+        /* We only need to deliver NMI once */
+        return 1;
     }
 
     return 0;
-- 
2.53.0


