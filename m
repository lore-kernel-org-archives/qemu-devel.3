Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346A4C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7kX-0007HK-JH; Tue, 07 Jul 2026 11:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7kW-0007Gx-1q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:30:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7kR-0000nY-On
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:30:15 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTMAO011731
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KwRdKpXWrykN1rEQl4l6jd
 aLuwr32Ouz/id6MjT1Q38=; b=kDaFrktd5qKbEwf5ZLYtt4fOEEA68sWYFOuc3s
 LiD+fyCpZTsPjPTL8hGiyrK3FtXTYWY7Ds3RzDX/j72FI8Y3+nJUfQKiSVTeJcH4
 EV8sm42ILY0asmBvy9t3LErnDgPDjElJCA6KL6g5MGCDG4FUy/NQe/l8sT/hsd/3
 qY43mwXJhv6srOPa+a8BqtiKSH0X2n2k25TUKTA5lbtTTvUr/+buACRmzV2NHpmx
 C6hHMsIi1ViQXFu8PYFv7xcNVTMWowbFvOUqNArb1kswTjxEgRe732yTHTdquuc8
 A6D2TXlQa8aUiQyZrMblFs0JaWfo/3uZ8oIRVd7ASvRRFTPQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdja58r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:30:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so40843471cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783438208; x=1784043008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KwRdKpXWrykN1rEQl4l6jdaLuwr32Ouz/id6MjT1Q38=;
 b=kUdAHen8kIeSdNv/vdVRirsnZiionOm3Gyk/YD1T2UfIVS8Q7Mdj3cE3y6J0d472o/
 tBu2byic2WcmI4J2L4pbiyEr6b2kPQZbm2sxqb47YzV/bl17B+X0I/E7DaRVmnxRiufo
 pNVyygFMTnEQnuZY57PIXD1AgS3AdjB1wpjK+wdCKGeHSB6CLubDVcuVf7k7W+CVrLH0
 UxqHrnouv02HolWc8Ogq71NbYLw+aT0XjiIoZwgqhiA470QVQfq6bI0hWwxxZNd7sTir
 nEZUBx/VD2mZKG6rVfUsV31RdPLBZFmH32VaL8dVS6Zrctnz6lZ1AoIvF9tIjyObMoyH
 UUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783438208; x=1784043008;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KwRdKpXWrykN1rEQl4l6jdaLuwr32Ouz/id6MjT1Q38=;
 b=QO6uqrwe2xfmIjBRI4K9PtX/2A6EHavrrh7RS1lR+syOhDLgpznfdQB5yNUMVQvw8x
 JML5/ZtLleI1EuZ03iET6GHSPyoXNj/KXsqN0hwFB5yElD1NV5Kdg/T/RqjaHDKkUDwN
 7W6kEYP2YpM2FxCGIrWf/EAQT+bu/S53+xgA9r2EeaEsyTzfAxRz3+oOtNcpbLtMqALr
 i58HBY+USRJfnCkgYpUKSzTwvdaItut+TAiItztBtGdz+bL0Q2Z079W+6PbrCH27DutS
 0xwsiQmL7aSMNMW1/J5PNXlsVsDy7KHAcy/LWUGwwyMFNoWSWXv+DNJrItTxHGRR464I
 Ibaw==
X-Gm-Message-State: AOJu0YxJn8NM664+IgDnRSmL9AXFKoAhX6yAEl3xS5i3nJSMJ2KTIx9h
 uOA8qifPBwcL3os1FtIDkr9S5k2jNfd1CSfl0fhzZWQ7oQCIv71pMkR/IGz/+KNL3BNh/Iu+/uN
 FUmO+32TuMEPs58WB4a0sUU5xFKs4tm9fWHEbn0fVo9rWCD0+NdzZIvfRrx4pBBzPBA==
X-Gm-Gg: AfdE7ckIJYzN/N7B1MDW3ygGndEUaKDKI5CvXP1Maa5Smv2MY27epXkZvOXcwG/C846
 sClyPOpJkSSbQps14CTfUwO5dZd5IygEKIIGqwYj4O1uLc0ioxbIbhP8IJbwR6a9PbYXTkHilaM
 QIafd4MwBqoA+OeBSoaQOe9wgOdDV+PKYBy4dablwK3v+Q1syCqAbFkdyY3zjvY1dqzSIN2vT+r
 0BjrEA+KMLb6y1oNl95tZt6u+sQOongbDFsegHmtioV6ksokH4zkIgA6ZGByyuBeV0s3kUBCSm0
 28AYFiqdCgtgFqr+guKymdfk+gM8WWXl0dhTFA/S9e3LV3kgCtWFFnkgZh6uw2+XVy5LuS0YM+p
 v8nqJcl+6Vwr0s96vmXLlIDAkg9oEDui5X+asdUy3i4V68oF635J8cF8Bb/Egt3XDmqzG
X-Received: by 2002:a05:622a:120c:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-51c748534b4mr58280761cf.40.1783438207410; 
 Tue, 07 Jul 2026 08:30:07 -0700 (PDT)
X-Received: by 2002:a05:622a:120c:b0:517:6b31:8058 with SMTP id
 d75a77b69052e-51c748534b4mr58280001cf.40.1783438206732; 
 Tue, 07 Jul 2026 08:30:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae44sm33542160f8f.23.2026.07.07.08.30.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:30:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marco Liebel <quic_mliebel@quicinc.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Sid Manning <sidneym@quicinc.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] contrib/gitdm: Update Qualcomm entries
Date: Tue,  7 Jul 2026 17:30:03 +0200
Message-ID: <20260707153003.58914-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4d1b80 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=Qm8iP6mkAAAA:8 a=20KFwNOVAAAA:8 a=h0uksLzaAAAA:8
 a=ZBl20LCrlLBNJFnrnc8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22 a=3SzYsRL22XtqO3ZTpi69:22
 a=kDhhxE42lZnxL3pOKqYK:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-GUID: 4EHe6C2sQKaWExNlcPuroW-h1VXcMnFD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE1MSBTYWx0ZWRfX63/aTaqafIiC
 WLYdJJtyyA8G+mQ7V241wF9dViJ+yZKEboCTrggW0TLrzvamt6PBI2MlMgI9WofkPdiZNbHRUis
 3iWUmPmUYHOV2d8+BfhCb7AIH7IfE9Pbxy74quTXtckE7GtOR/HQpCO5ucbGkrp6kt4/O0DMBFc
 8cVfdk2InF/olFWhekqj9jK/+LidK44brVcGlbDwZwl0BhDJwCU7vdQdtQdGFdH7rluSPhdFSwe
 BHAbxQr0BH/RrWrXbvJDeCrRTTCfdidKEvz+/APTZ5+MMxT2f2tk4163KKfz5YS+3hUtUAebfwD
 d8EvfuRcgCAwhTZIt2OM0qUpqVPOCrusr8SVuR0tf+GbH/dRjnjgyfdqk1L1+RuEmb043Y10jwS
 QJkPUiiZKPazMIe2FaoSBW/rPqb22qRxPzLJ4AIXqKDMjfTT9n8pJHEhXGBTA1JDaF0f6iNReRE
 zc8CQG4+8Q80KM5JfAA==
X-Proofpoint-ORIG-GUID: 4EHe6C2sQKaWExNlcPuroW-h1VXcMnFD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE1MSBTYWx0ZWRfX3iKz4kodc+S+
 iV/eNxzaJhlEcmgjIOhp7iGe96fBgtU6tVU/E5CdXEqJiqRdiculXGH6DTholkVaLU9AZTeoAyk
 DXhPWpz3rpIEoGsp+AIGwq68dAItwrI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add an entry for Qualcomm Technologies, Inc.,
include previous quicinc.com contributions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Cc: Marco Liebel <quic_mliebel@quicinc.com>
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: Sid Manning <sidneym@quicinc.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 contrib/gitdm/domain-map | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index c07dffc51bd..aef20c4949c 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -40,7 +40,8 @@ nuviainc.com    NUVIA
 nvidia.com      NVIDIA
 oracle.com      Oracle
 proxmox.com     Proxmox
-quicinc.com     Qualcomm Innovation Center
+oss.qualcomm.com Qualcomm Technologies, Inc.
+quicinc.com     Qualcomm Technologies, Inc.
 redhat.com      Red Hat
 rev.ng          rev.ng Labs
 rivosinc.com    Rivos Inc
-- 
2.53.0


