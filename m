Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2C606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GlaiNeT8;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HdmJVtDj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT641-00044O-DL; Mon, 16 Nov 2026 18:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63y-0003u8-AE
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:38 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xT63w-0003M6-Kk
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:24:38 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCH472710725
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mVj/Wqtn89FDvGWo4l8VwYxJfqbIKtj6nORKSBOEO6k=; b=GlaiNeT8CJQUGM0V
 bBqPxjtNvPjGoTLTQ9sRvPihA16P9irXS4I4I5JJ6CMOySIMpX3C8fH9yDGKSveF
 T9tv0t3wuHAm2RC/w+eMK9TKXuyleNNJoqbZqFM0FZrV+rLd7cX5IJypio5q8vML
 ljAdzqQJM2D3MHQYtdFF2XG1sLai4NrgssgVLxYeG1dy/GBpyvfQAM57LKOGlkXO
 IYKSRnBPM0EAe7+SAbe2ODJG14qPgfGPypjcpzY/g3SUR0q1clrJReFtOXMO13ee
 qou4exQJyeCqWjmw720307Jm1oDduzWDV5jyuaKOhVAyvzBMMDbdecVXpw26CgXl
 G3VFXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htgcr2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 23:24:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so1215305285a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 15:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794871474; x=1795476274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVj/Wqtn89FDvGWo4l8VwYxJfqbIKtj6nORKSBOEO6k=;
 b=HdmJVtDjcTeU832BHR0Pv096HIqZoaF3HZpR73+fRji9fcrheTnGnKFUURR/vE/clK
 TatemVDuRSRhP0EGgy+EH6CyLsCHGdhv94A0PEAFdfvMPx+9jXerlz2UTGrBfh3W8r+h
 W7ThwLWvSr9dYeWjXuxnUHvcjG3xd8bKwujAXhVhJFiH8eBQ0cfwoBiPLhhyKWV8C0y6
 kjs/NtK7+r0YcxXuFtA4L8dS8xXwyFSSJnkj2AyLdVQ7GApIeFNb0ZQGe6KNtlAt3iO+
 igtKE3o1+3M1E21bP336LZetfvD9OfZmCNP4vUj5zlgcIVAodyE7anmeyUgD2GcXda9D
 bBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794871474; x=1795476274;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mVj/Wqtn89FDvGWo4l8VwYxJfqbIKtj6nORKSBOEO6k=;
 b=2Wu2QGQy31/ArRG9R7gkJWp4Gl+497MA6K13HfzRxGPWmJXtzGfGIGqCHAUkYW94km
 +9d8GTlW4sih62Gqpt1sUI/NEV68BGByjF08gzrTq65NuHkPC8lMvOcJC5MJ2/RjrwMk
 SJS9Np5xNQ894Xp+w9B141aDR6x5S76jG2n/49L/Y1QpS5EvmYET1r1/Y7PmLArV/gdg
 4S9qk6dpZJXoQQUf213ASIvQ7DPNoFDkZMzvFilN5Y2o4GbpTDqq6ojBgFZurh0VfRhl
 tBFes0Fhb220mKI/q8Jgya6HLt/DgqoMKOmEkd0DO/CbPTnLjbV0CjRu6WeBtp2WIFeD
 bUAA==
X-Gm-Message-State: APuU4Z+r2SMyNt8ohFra0fROz3ynzyOdlArDdjcyUz/GCO8hB64hIP0b
 vdx8LHuKH1f+CnvN3guZ7/uccDOTzGp8sJLlXp/zv0rYjCsweySEb1DwnA1WFDuWGxPWZo7YwK3
 vYmLOIZVoSaPmu06dlqvdDnEjB30+0svju6biKzqWXvoQA9zuM8nFNfE0RiIPKQcbZA==
X-Gm-Gg: AYBFou2UZCtmHsEc5cUcJMevQx6bEC0Qrl+Kh2BPyUB6VL6LiwzRb2JWPl59UAyBLYB
 VZLHf2OcIlq4BURMcBnVZJzxDYcsFaWYTGwTEAyuqnMkOTF4RFk06Y+3etkIDveGe4UP/QncY6+
 1bAOzhyDHHTldGEH/z9BDrJHB8SV/BukeJaLD/vaTWD/b1bv0i80Cm+XerTk+ts+76sSNd3JsHR
 8MJ8yevxllFEXIKu0+s13l408lzLA/Qvrp9r47oMT3QJRPBpSSeBJPpe1IepzUQcCHK1JC92WUa
 Hjv3jkh9y/XtMcJE6s7MUWVun1436f+zqwOvNpigRVjcLzhVynBq0UI9u6DLfJrx64GYGpgIvnQ
 sro8G1MxmunF1nGWaoORCVFdn2xzVbxpGQv+W/e07vvD2amFXWB4Fny/c02hyFXD9GgtL4uAdgE
 JhuhyronDKLnyXHA==
X-Received: by 2002:a05:620a:31a3:b0:93e:9171:b83 with SMTP id
 af79cd13be357-9494bbccd56mr2034384885a.43.1794871474128; 
 Mon, 16 Nov 2026 15:24:34 -0800 (PST)
X-Received: by 2002:a05:620a:31a3:b0:93e:9171:b83 with SMTP id
 af79cd13be357-9494bbccd56mr2034380085a.43.1794871473464; 
 Mon, 16 Nov 2026 15:24:33 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3d39b8a37sm706105f8f.46.2026.11.16.15.24.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 15:24:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/22] meson.build: fix getifaddrs() detection on illumos
Date: Tue, 17 Nov 2026 00:23:20 +0100
Message-ID: <20261116232335.31593-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116232335.31593-1-philmd@oss.qualcomm.com>
References: <20261116232335.31593-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX8bFSjEoWhiZF
 ipBTpHCtOHbDpd2x95gHyDH8d9ImXmoyjsG0Fp2Up31QAdAkGM+apK1CLOXh0kiDcKRgMbY4r7b
 FGY990G8z01ZvxKp+JU6wcxFIhwtU2A=
X-Proofpoint-ORIG-GUID: Xf9uTg4NIYar8ZhQ-BXKfN6EXwBt_Rww
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX/254zQc1zz29
 Zpa1xcCKtfbBcW3Umt2WDUCmErlOGRgW49lm4fmrzxJlWFjycpYKCDcKzRTZkuMZDiqFTRVKM2w
 DNikCIm9/qiT0gA8Zk/tauLcVFfookSNmke7JHiWp89jqtSyNEy5qFBkEzVaPnUUDVaG8axUhKp
 PNo1ZsvXdH/n7UjiEfYV7iaJQNuc1CymOImM/LF76doM+VpKQSavmD2YJof595GyYg2LnAtfZtO
 gRzTgrPuvg18r1MyHCUMIw7LCNJbbLwDdYA8EUl+5Zu8xzqOjztwCWalxlU8Sa9H4wKD8WL08+u
 nY/6bNfEB8K64LFZ4YZVGsjPJd5CLFALoFfPOYDJk1Pz6dCdBLzPWZiN7YQm8QXfYdJiwHXol6X
 xV4XdsD7M4vwhz2qH11k+PHdb+osjU5B4i2A/6VI1DPafgZuiuMX5Gjj8CI0GefQAzfTksARGeK
 Edvw24/SSw+vALrllXQ==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb90b3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qr6bbEsyog5ABPNOyvkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: Xf9uTg4NIYar8ZhQ-BXKfN6EXwBt_Rww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Currently, getifaddrs() fails to get detected on illumos
because it requires linking with libsocket which meson
is not doing.

Fix by adding socket to getifaddrs dependencies. This
unlocks 'guest-network-get-interfaces' implementation
for illumos.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Message-ID: <20261015173250.65942-3-bogorodskiy@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7bcb581c181..58286a3f8a71 100644
--- a/meson.build
+++ b/meson.build
@@ -2643,7 +2643,7 @@ config_host_data.set('CONFIG_TIMERFD', cc.has_function('timerfd_create'))
 config_host_data.set('CONFIG_GETLOADAVG', cc.has_function('getloadavg'))
 config_host_data.set('CONFIG_ARPA_INET_64', cc.has_function('htonll'))
 config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
-config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
+config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs', dependencies: socket))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
-- 
2.55.0


