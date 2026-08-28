Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3A9C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bf-00020R-Vo; Fri, 28 Aug 2026 19:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bJ-0000wo-Cs
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bF-0006Bs-AG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:07 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTRbe014762
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aL5RhYdURMM
 Ygn1YbJPqYea7+tKkaMUklWj7jK2ghaU=; b=E3T8naIjPXCGwlYT5eR29JPz6Pz
 LfOdfR4qNpMM0fvtX2q+FBtbf42zJnCjx4vjnO+9yf9U0lDee1YsYbmldlj3EzbE
 0v/DaugG/5JLgIsWlnbkUO1OUVO9nMGShafGVSePYocmE5AGrjO3Gv7JFeMKvECq
 lO+GL91Vya3ZmgupFN+EyicE5tH1+GPwkt1cFemcuZ5+0mfcaIjA/TNwPuAcFoib
 HR8AMc9vQF8UGIBGEyZU0NZNsbo/ZA52fsM+yKIz+jrKa5aLT0WbTu2Tmo0Ng6mo
 eMoD81TuNWkVO5ERK1pU7JMqWaeudTBAc8yxhoYK7WB6zOw66Cew8s/NszA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbgvfgfc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso3999275ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958183; x=1788562983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aL5RhYdURMMYgn1YbJPqYea7+tKkaMUklWj7jK2ghaU=;
 b=WCO3EHzFi59ns1+BAqSrOmmdy2NTAxtSwoTAhy6+a9qER4CjuPp4n4TVxWnWZKwE9w
 c1RjJJOTLmHi+m/+C3o+Ni3qYWaQukitWgpREU0dYoSD/Y5lzueRbNx4PqWy+9kRnpzt
 +mf7ovq1H7ayEUkKqegcMpVoLFLSE5K4ziCEVd/4kk6T10oj17bvA3hee7qSwkPoxirR
 H/OfDzoFO6sO6tGyCX9x5A026YsQuaadPmxPcO6t+rjfh8ZSX39P/8XszLg1BC/hNUs8
 r3ItxfiCA5OfgDbjd6epBa6G5rzHInz14OAO8SBg6SLU9jb/RBUTljr2nvopgrgYcmRt
 9TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958183; x=1788562983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aL5RhYdURMMYgn1YbJPqYea7+tKkaMUklWj7jK2ghaU=;
 b=kC1ZwRaWxB2OMSgs7iWt8wdDvJ+oy/9dJleuzfR1Wm22PRe+tGkcRSbMlpt0ywZUgC
 lLLdyiD0lzNViDWN8tpMEossUdtbCmhY4G42Uj5wtXqmre4K/nbrfDubwPNpx3WiZQn8
 EjE1OIOly3winDKDxCE40yquCSFtyC9c8okF/QFVo6w3kKDiurKFIKJ9WhKF6I/yO5k5
 iWJxRO61i5JbaFITBf+YQ8Z8tEglbV5DMn0IQabWSvUm2wzlI1sWQ8VkOVeMIgs/rsBX
 NGFHI09qJ0toVg75/4H5OTSiLl+4fn/Az9Ze25C3cG+yd8cGbQ71d7rgcCwrca/B4t5d
 y2pg==
X-Gm-Message-State: AFuF++mR4wm3zEFRmLxk8nwoiUSUFhhkORiVUwnTq0zauocvYjlV9lEK
 zGvDHWtOWKOx1gF0aTaCs+wF8M48OfMiopBR66WWsJP2LkbHeH52/2fRcTs43WLhtpE54cjPT3L
 J+JxIJdWuAD0M9kf/5zWJQOUC+x87yXIjn7nKYr0Xr12pVGaeOUcfStT3d84jZ+/Ufw==
X-Gm-Gg: AYBFou3ju1Sf90rxeK2Vf2IEXB/Kr0YjwY8qPnmh2WRm7w5bBzjWF0KJ5qMeYsyvjQ7
 9LvrFgIJ6pYSusv0bGs/9ljAmXzOTdoYrN5/8c06BIDlvr9XM45eCyBIvZ8mAUDK2EqPdutH2qV
 v2keZNlmSwF4BgyQVELOzrCqcFJ0qlDQvVm2HV09cLMey4J/esDnP/8O+4DmTWxd9Ita5p3QoM2
 2ua4iTf6uozKtJhJzn8lxVwNnFDmgVjcO7DnDSsXC9qUhSy1ia6zwPscnuAHIagHi6FUbYL3iGM
 Ar4iskA5BadnDuj52bFTEFwG+qao6db6YuF4aEzCM+NL3aSmrvEgfOhU8ap3TdX+7tyxs/rBeOC
 07O6zW4U+Q5OEohWtPfuefymLesugJlIi3icfTLK/qWrgAP55ATM4GNg5J2o=
X-Received: by 2002:a17:902:d48d:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2d8d4d2dce2mr23339025ad.22.1787958183495; 
 Fri, 28 Aug 2026 16:03:03 -0700 (PDT)
X-Received: by 2002:a17:902:d48d:b0:2d8:d4d2:d13a with SMTP id
 d9443c01a7336-2d8d4d2dce2mr23338565ad.22.1787958183045; 
 Fri, 28 Aug 2026 16:03:03 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 43/47] target/microblaze/cpu: filter microblaze cpu
Date: Fri, 28 Aug 2026 22:58:57 +0000
Message-ID: <20260828225901.367438-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX12f61HfLzBJ7
 gkZqvbWy/CBWletvITEQqtFQ09wwStlBWf/6ezM7MtuA52YwT2nHHrzX993uVeL6WkEvC/INSba
 NgLjgK2rCg/vRDXqqoz89HIy5+XyP5j4Qt9zQCPgWhuJseWzwxSfc3JA102xDI8uwmC5jS0rS2g
 CR4zfjwyI00OcxzWDB5I1NDpKJDwM6WsSBQ9ElkIE+9PQXuG8utldWAN23lwSlmY+v0ltEmqZL2
 v4TvFX1hw8ZhVLv9DrCXuf1X1iFXhJvgLwlPhP3sORCCYIKmUMo5g/fcQYyfbd4NodmX2KWMgum
 CszdWjeE+HFiwM1VSIy8l4HdPB+bTMSnUB2yuzlntiMg7LAmZsTaDPqFEVrkAdUTMQ+QYACYA+5
 foUJIJeCunTFbxRWtXL0rLKcfC6uJ35pLwQNVHSNuenaCuBU5yRWzqgamnd1aPGC/3SK8AF7pVH
 RVYuNUz4KNvyx8GPn2A==
X-Proofpoint-ORIG-GUID: vfHsqjRNs-KSgYipNHlTQ_Yl5A96GUPU
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=6a9213a8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=r6yfPn4tIeM-FYsiuHsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5RN7US2GBUnx
 e1pUqkPEmVTIo5y24pjtddluK1AHS+QoO/m9wEGBxWG80FG4YQTkFQnkgz8K/tkI5hkmhCcM6fl
 5Uur7YcYYnREkaKMZcWaIpIUpY4PoTs=
X-Proofpoint-GUID: vfHsqjRNs-KSgYipNHlTQ_Yl5A96GUPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

This ensures this cpu is not visible for other targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/microblaze/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 389a5124b12..4038325efbe 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -494,6 +494,7 @@ static const TypeInfo mb_cpu_type_info = {
     .instance_init = mb_cpu_initfn,
     .class_size = sizeof(MicroBlazeCPUClass),
     .class_init = mb_cpu_class_init,
+    .is_available = target_microblaze,
 };
 
 static void mb_cpu_register_types(void)
-- 
2.43.0


