Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E1606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FbhT5lfp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bk3HS8ok
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmoI-0003h8-3u; Tue, 27 Oct 2026 15:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmn8-0002Un-Np
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmn7-0001rX-3m
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHqDm2960506
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PdScQ5nmpybeikNoT8uSfv4tN5EFplQchnr6nyolkIY=; b=FbhT5lfp7Dzd8nGy
 8i/TtDLHuqd9dbcHG4nvVTv3Tkp5k9WQtO17+AFxeDtF36kAAL0VsSqIeqJFg4tZ
 BsUvCoyGhqNhiimvETFeZTDUByEm7Nxsh7mo+pAMQ9KHqhtHp6gLplo34mSvYZbe
 SU9rUbi8A07hD52JhTiWnsYMF4GYj4LnCzeg/ri1Nocz1Tt0JmC5m40KxGMsIlrA
 1xx9bU4iFebIxLfAlsWU8liITcQmPAXcO399D5hONYlaWchtJgqaeG4Plej7TkqH
 9Fn1khy4MSOmvnnX9cGzcs8Uu8QXlF6R6NHsK94pTled0OWM0/qYxS4uggxSvw5Q
 unn81g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670v1p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:24:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9308eafb465so27846885a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129099; x=1793733899; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PdScQ5nmpybeikNoT8uSfv4tN5EFplQchnr6nyolkIY=;
 b=Bk3HS8ok0exTe1I4Jj45Mhi5RXsGH68la4C3o48bmPLZFievwYTTK/kfYSWifMlXH/
 gtSdGNpPDhzbnkn+YZxFukyXgI03xcYsm4rONKMn33uEBsnGJesj31YrA33QJGedXRya
 Y3nYw84mSN2vCw0mvX/JK7eocv57/Gti7FXd2N1pQ9rIqWpGSk+8bfxp//l7tJ+JDP4D
 0k8bw805LAG5BBVFE1bUmZ2XH7/kgODs07YhhbdE30mWmHSb2v8fCt8gdi/bBC+au+jC
 M7cZ3UuAFaFG2YRQu+F+EKh8pbKhuQlgQBDrRE7EPTH8iHN/0obt7Q3eXRSMl5eJzG7m
 zCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129099; x=1793733899;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PdScQ5nmpybeikNoT8uSfv4tN5EFplQchnr6nyolkIY=;
 b=IH759+8OZnD5Je7QT/K9YEe9OoQyRXgEbGihxqq1XFsLoeBqbHQRMgJ9oOhIgWT4zv
 Cv8HHGMpu2ROn7rzxGZ5JrCYhiPJFuaiK+cgPM5Mylsnss3Pp5WVqo8Hnca2D63yP6hV
 BAp6k/XTWbs6E7fwjPhFKSm2kLNdpKHSoTJ/vS9Hkz0oHahE6kcgkedQtJSx88Wofk/w
 bp/5ozfGjEHqUr30TurSek0deCPGCK6Ctq34iSLpsnX5JJSIJF2Zdpv5QqGJDetZJlGj
 w5OnBAO/7Y4ZW3k9i/iRzWiNlNONl/JIhSIEbddhV0lJoJ0b9A6WsNbBFmHPnwKzDhHe
 jJ/w==
X-Gm-Message-State: AFq9FYK714lR2rNv/Uw5mh/iWJOhdTMboPZ4+V0eZGXj22TMCQ4mD0cL
 +PPe+0+ezIEeq8c7/uiIEMziTDrG+Gv42rbym24df1v94Wng2egvz1Jy0FC7CO/vXIXIr/AW/At
 5qd5C/YC+bVH6F5z2HqStjUIn2hsNyzNhElljErY/jL00Ez8xpMrHq+RzXh80Fx7LnQ==
X-Gm-Gg: AYBFou3DZUlZJZRNqs7qdz+pE6QDizwfe8lLwQR55Z0pBqHimgATL+ApTGsq1JYEdC7
 vp0xw6qDkJnvsa+4cwg6rkwsaJsppSqeic4wzLT7/nxsmglaAhreh079SEY3Ho4U9d9b1dT/RTo
 LNQX57g+kc1REnMACNTSfnOrFU+24JKOkx/FmZgNLEwzy2J0OAPWU/b9loJdY2kLhl4IgKzynqI
 sSJdqDjITG/k7ja9ZqNXDokGl3Q50tR5o1rmD5mrNDiQ1wwq22B5H5EROvyKImnjW1IOI84HNHz
 yRwv22sd709JOi3pgHnLJbKpyM7P4RD3dBqpiWG5l9MT2LArXT3mTWG1phLct3bjPnHqE60wTW8
 lUsuTmELbJaDQRT3QwmtfyBvryhodzBtXA+Wivgh1yV34SlXUGi5DcK14
X-Received: by 2002:a05:620a:4556:b0:93e:5cf8:e5aa with SMTP id
 af79cd13be357-940ef9380d4mr1758399685a.61.1793129099377; 
 Tue, 27 Oct 2026 12:24:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4556:b0:93e:5cf8:e5aa with SMTP id
 af79cd13be357-940ef9380d4mr1758395885a.61.1793129098800; 
 Tue, 27 Oct 2026 12:24:58 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a951f7f544sm1781525e9.3.2026.10.27.12.24.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:24:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/59] hw/arm/mcimx6ul-evk: Have 512 MiB of RAM by default
Date: Tue, 27 Oct 2026 20:22:52 +0100
Message-ID: <20261027192341.9197-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sgOMst9mQCvw61T49pE-iV8w4pu2CeSY
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fa8b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=TiZ8CxiaEXEXIp79E_cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX9RZ/EoCazKpn
 iztvkGtx4y5vO6mSt4T7/mM5/mUX030FUvA60U6cpjydbt4Yu9Udj+7wYbFLc9401lv14o4Ab3z
 AhzTqRx22EVpfsMvSjbo0/zTewx8mNs=
X-Proofpoint-GUID: sgOMst9mQCvw61T49pE-iV8w4pu2CeSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3NyBTYWx0ZWRfX7pck7cZLIwRg
 KAQMpSSeOnYhNAD2FCZCez3i5PVFnI+KbNX3u58FYDX6t6WhAEre3o2LhCpRGYeDc+0DwL5aYb+
 39xUyZjVpuNSo9PHas+2LSFmYzxseB+wrLNFfXzNUfQNtG6iUezFI/e/XsCoBMApUuoHWqtfMMc
 JXquHRRIoSOSl4rUT/OzrwQm70CKMBmy2Z0mhMTd/gKCu0k+rKbvBMZTfJijG/TedxGph/MJZhE
 umR0Rnw9d1dWXFX62VOdVEWOyhnZc/5+K/I+j7WonY6ywHlwyDyfgdK9orQRHAZl9EbE7t03tpo
 Td9quPS5pMRosH2W6WxSUEAECiYszT9PpS+YFb2sZ2tMOSwf21kf2QhSDR6xNBBj7bHBwlaTNBV
 /nvQ7r9jH8cfW26QDx4+9YuERdqS5bQE8jyWQ0UrLRqGjh+TlzL1sJd2URnQk5gv1CBYjoZOFoL
 GbwgwXV8gJkqSXE+E8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270077
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Having 512 MiB of RAM matches real hardware. Fix the machine
default to make its use more ergonomic and less error-prone.

To reproduce the old default behavior for e.g. migration purposes,
`-m 128M` needs to be added to the command line.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261006083445.30362-10-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/mcimx6ul-evk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 40071d2c7b96..4964cb934519 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -73,6 +73,7 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->desc = "Freescale i.MX6UL Evaluation Kit (Cortex-A7)";
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
+    mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "mcimx6ul-evk.ram";
     mc->auto_create_sdcard = true;
 }
-- 
2.55.0


