Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E4AC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24xC-0004fi-8A; Thu, 03 Sep 2026 06:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24xB-0004fB-9w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24x9-0007bu-Md
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:45:57 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHBWK162783
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EUW4H00dK0LyYVxqdRdDg345+N9pW5llaDu9ahskXFM=; b=R7CnIrTorFDJv6Nm
 5ZEuvg4JvUZciAQtkvE0wyLadjexrAHGUyMFu2bvYc1Kk1Ems+N7HoiIVtuZCAob
 PZsM9661s2U1RurpixbxcrIYcQDr4MzCP0Rdufjg2vZvSnVO90qHR71H2CbkGM0p
 adERgF0eIUX+UN8dHl42qbLYYLWiOBwFbJviCzEPrxqK8l1b9ZZWE4cKcRKXGz+z
 zbdeyX4stzxxkACFRnnzpjbuyN8cdQQwDsjYLXQvPdHi3WWeIbLwLTnxKiEhdsxs
 wqlFnrNwaGVdUxuWfK8WNs9ap1+A+rM1HSJRdOMHxz4TlXsCFFIGChWozbYhfjn5
 ci43NA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx052a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:45:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93771aa0379so599054385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432354; x=1789037154; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EUW4H00dK0LyYVxqdRdDg345+N9pW5llaDu9ahskXFM=;
 b=HCDqgyvq40ltkS/a8WuQRZCiG84hmTxyEymYW1IrYVPuWSNDDlVWfkMNJz+yOdlzbF
 2G7h1o17GUeWN5/N5hhhS5XtZ7/FD33RVMdG/geZUlDu5pwZlJGhUiVSboTo6LtSAVy1
 yiQW6fStff/kBTryG5I8UXBw2qWSNwTe9Ubv1u4FsYD/s8sna7wabBfH0UA5Dec/nFtx
 Uph0xSw9aGDN5MZXViK8WcN5aPcB4dbV61GdVBFCXGT+ztuDSmp7E+5sRYK3dIVi6Jxd
 kZQjoBL5cpHoKbe0ymAqLWzcBHjFdZHmZVmFzGTJhmVoyEkKBpygAkcx4+r7obXISok6
 4I7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432354; x=1789037154;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EUW4H00dK0LyYVxqdRdDg345+N9pW5llaDu9ahskXFM=;
 b=jk7DB9xWi5ZClLEUlUkxy3zGcE9MLFpPxDor4PJtrZbXk/vA7bdXwHg0TCrv0ugJg4
 yG2KtmxaMiuSxL9lYEil2i3d8BMiv9ja8SEWtgQs4Hm8n9bAJ52kfMyEZkEvVLCP5Gi7
 G9OhDcnO4GibAvT3xFFVYV9BskmnW7o2M03F0+XqTkyXAUH85LVvRpJt/okmKSULDza9
 N2VJ+NRRqWCNjM5QLkteXFzVstk2gKudlGGoCC6Fav3E6Kdm0DmU/iGAEQ5ws9N+kzH6
 cffuNTj14/aBjWae1QNr6HNVbhvY4hTDSdsHSodWQ75PS4EPR1iqX+eFNGIHY7dlbiQx
 sgLw==
X-Gm-Message-State: AFuF++nbui/JbxSr0E+U9Lbdp79bwg33wGKJdp3eEx2Utqt3yfJAnFGi
 lPN7QvBjZ3JkuEWkvvZ5C8Lo1f6EStLr/82wWVbE+808s5EeSuBPcIoD0EmoRXRaxPafRiP56wh
 ljvGoPO0W9tsctJq7K9JDYThit6jsXWzR2M4zx1+GgPFMavBQDdnF2Ld7P5S7ILLoKw==
X-Gm-Gg: AYBFou3VJEFL7tXyDoRCo+GgvvhLOUVvpTjbOLmL+OZEKjzA3gFKL0leXQwMScRbhxY
 6b4YQ8hRlPPo4kGDuc3N8slLdRXahS+AYgYoN9FZOkM5yb2mcaPS8umWcQ1kT9kbBsg8rxAfETb
 6xtgC82mjouuXK0PEabM0nPLxp+CisP2aDlKq6iUKPUB9aOCfgUrUSQhLKPhuznbzNIAkW+a03u
 YVWIWxRnDYDApDR/Sjs95SH8v6vvI5Zb8r/aUNjJMMcqUiiz7Wpd3TySyNzH/RsuP0MTc4cNsy5
 t8BYm40IU9vA2yo/QNvOK+CJc0H2GY7dd40fAWN7HtIlsT+MU4P5NyMlqu8tGWx5wIDWOaUYnxY
 ZoFYhR6uxGjRXXtV1F1YJmS93F9Cd3/KlKJYoVwXa
X-Received: by 2002:a05:620a:90d2:20b0:936:df48:d507 with SMTP id
 af79cd13be357-93960e05a05mr1039310685a.18.1788432353970; 
 Thu, 03 Sep 2026 03:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:90d2:20b0:936:df48:d507 with SMTP id
 af79cd13be357-93960e05a05mr1039306785a.18.1788432353502; 
 Thu, 03 Sep 2026 03:45:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ed2edfsm12633265f8f.23.2026.09.03.03.45.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:45:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/51] MAINTAINERS: Stop reviewing meson-related patches
Date: Thu,  3 Sep 2026 12:39:34 +0200
Message-ID: <20260903103936.62355-51-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gwdVYf5S8SkansMsSd0XJlFr82QHilg_
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a994fe2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=DDkSHnejo0K-hebZM0MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: gwdVYf5S8SkansMsSd0XJlFr82QHilg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX/zOQkUhQmBf2
 Cg17pJtQNuqKINztA3XFNp93KLhOdvGC121Ltxszz2Gsbmmlv7n+1FypjY97Mq7UwlclfO0q+ln
 b7Nw4eZbQsra/63h9SWymqvZ0eBdf27EAxyKHoBucI3co7AA3w82bYzqJH0NvQatPkrSiUKeIwa
 1AB95wGiJcZGB/mzg+rG4nc2x/TOWF9QewOmoaj4CUfM1Y+iRFv3dzrjXnF9SXiG0s9NcGkXgcz
 mbbzDlxupeiOPgpyjR9b/lDu8Y3QqliqHNzFtcSovjxadu298KGWjbWE65VzsI8TMMG8/OIfpn6
 Ce/fVBtWQ6dTfRkX3ptjZjQ19zeoMOSIvAxH2aUBXuDRws7+GY6P3cC7V+dz68aA1U9JdzNG2vz
 7VyPdQ+eRufl5dSymDvdQsbhtqSR8/rfSpSdj0JsRarS/W6OOXuao9O/jUvVxQF4r3cfihkK8Co
 mAAck02iLkE6LbJ20Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfXx86gJt6rosmq
 ueujAsHzekQy7UnBPbDsCahuDBPJ1GfsLjoc64ZvKgp10LV11589OqlMKTUN3uTg6Nd0wi9ypUQ
 Z4ct4bT0si9S2Yld8zaPX2j1S/e+rVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Philippe Mathieu-Daudé <philmd@mailo.com>

With retrospective to commit 48fad83ff49 ("MAINTAINERS: add
entries for the key build bits") I think I only wanted to be
listed in the "Top Level Makefile and configure", not the
meson one (I'm not following meson changes closely enough).

Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260902155105.32165-1-philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3f91ff1cab..2cff90141f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4676,7 +4676,6 @@ Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
-- 
2.53.0


