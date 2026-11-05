Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19066606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z4KdT/hQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WciO54zP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOwzN-0004gR-Ru; Thu, 05 Nov 2026 07:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyP-0003Zo-IH
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:47 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyN-0005ns-V3
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:53:45 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tHFJ3684586
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gm6S4+bkjG/JKgOirRV4r8Y3XiPR9owHfvgX1WSZKbM=; b=Z4KdT/hQzcV5992s
 uQzf648nf1giI92jVxX+Hi9arkUKAD1708v45GcMnhU6waInwiNsWhCGKagKeCr7
 fQRTK5xAdlx9zicb7oJV7X0XLgYB1OSftI5QpnuAajhb5dEsDOSnyedM2j15LUwv
 19TL2RacsFWPWuaXyASshUJ59C5xhAzypr3bqO+8S47AUYipakpFgVO+zX8XXBja
 n0ttwbmIQJasZ+AWIhatub6UYc/bgml8Lyuexre2DHvOmMmMtabQDA+cRhjJWAv9
 lJCjlpcPQMaLgFa3l11f1BUm/WrJxJfFPwkicGwKl3IlNUOddyBsKgzBwyCzcLUV
 EKbiMA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43j4tg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:53:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so397151785a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883211; x=1794488011; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gm6S4+bkjG/JKgOirRV4r8Y3XiPR9owHfvgX1WSZKbM=;
 b=WciO54zPfKmTmzhSMdEEfJcj5cgud8DwQfCKqkDhKzTOHTuZqxiTA3eNyNClJ3sZ7t
 q2ROFh6Rc/2VFPEgS09/EVcpLMRK73qjo/sFAoqBdfgzlv1Li5Ha5sXcYdEj0H7u4UtN
 rmXQ/t21ICcwnc7TvaxrkqgUplzjHvxOapaZbXJzlYvY7iIAVzBJENPHqoWf+RUSXEuE
 1UJCEMyPqxGD3lc0UMud9rrA/piCeo2F45QdcZRJZJqNOQiC8bvQwoWJVIhJtKsQbb1C
 5OaEQmEYWlkRlKNlWEyRZ1UBRNEPOYqki4EKVfbS7Nr+f+PQ7fzzWD2vy61gn6UMN6t1
 cP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883211; x=1794488011;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gm6S4+bkjG/JKgOirRV4r8Y3XiPR9owHfvgX1WSZKbM=;
 b=B5s2brSNUWVjTTwhEiCXllWC74nzQK7S4F6K1oH84b8O+cMoe/vfYKtAyEuwLBO1so
 aLDi4rLR/2RBHyu5QJtkFsi3DKGvVG01rNYVlOhJx/Hz0s1rjy3pPL6XGjRF804ilURS
 62FVDyvCXxI6/qvjZKMHkv8C4+tWQP2nsnzsUzgf9GBmouRZoNQ6Q9CcHhGCybObMbmR
 FJkK4BQnH+GWoxySpOForJWhopHNVW6K1pndtgr6DE2pGMUaEI0347XTSBqntcFjJSwO
 0FRiwWo6bkiLvh21bunnb89yMCYWcuNev7Q0AoeN3/2LwxTkhR9kj5zk59mDkmL04s5h
 bw1g==
X-Gm-Message-State: APuU4Z9wevASfiwGE3vf9g8FZ+Zxt6VXTWttHi53ztbyf4UohYkZgW6B
 ulJME+P58N0hVAdonHTSNirpfgtQOwxA45XBJi1hdBdQ3OEgsKi76y8bkgPanzoLz7r2O9Ntx70
 7RdshOjoEertK01opoYsDWJ7tHVs9Wzoe39Gq/9CU8c2lYozmwXuNjqmwl0QNO1vMxA==
X-Gm-Gg: AYBFou1hM78/p9OnMfJNomgQiM23PeyqANeyuOJXCOhLvQrc1ofQbWqC7x2DIQRLBDm
 fPApFz4PAwDQw4WmpLznnOVFzYUY2m1MUOt+R7WFBsSS33eNZBxxvk1NP2W7CVTXoTgU4kMttVF
 qzGJEMrCwGXn6lH78fafdTbUFkf4Nlkx8eCPP9f191t7poqg6eNWem1RwSOhGx97EFedp/SKH3E
 bh/GoGbzyAjAem884YO4qBvCMdzZq+pg2h1DnbhvMiJy0aOcvp0Y0lisPZVFA53flCZfdAoMem+
 HHTkhkkYr151S9ZVcJltCOBHAHhCEE9h3Qtc7oEEAENwNHkUYZSVmam5zpK8AwRnvRkOfM7z3PS
 qbkgHZAGIKMzvWj9nf1RDOPnhkjIEtKoRekbdtGm8dz4Jxo+pkGyWcex0MJgVPT/7EUdwkK3lnQ
 2FqTXmR8Hv7PQkCOj2e01JVBFM6sm1Eg==
X-Received: by 2002:a05:620a:1a22:b0:93f:2d10:ea44 with SMTP id
 af79cd13be357-944217ef451mr3142287785a.52.1793883210951; 
 Thu, 05 Nov 2026 04:53:30 -0800 (PST)
X-Received: by 2002:a05:620a:1a22:b0:93f:2d10:ea44 with SMTP id
 af79cd13be357-944217ef451mr3142285085a.52.1793883210406; 
 Thu, 05 Nov 2026 04:53:30 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b5719cd68dsm991882a12.37.2026.11.05.04.53.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:53:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 08/17] hw/vfio/pci: Replace deprecated sprintf() with
 g_strdup_printf()
Date: Thu,  5 Nov 2026 13:51:53 +0100
Message-ID: <20261105125203.40320-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: A2kVRWy61G9hSY5N0QYjVG0kOPkUiP80
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9metyxlBzzWh
 4EbVrLq7U/nUPCifMFbvyZW9p3eLusLGzhZlz88flrgjJckZOGPrOjqFtYsyQCLjfjrDcNyFGvD
 SmwbiJQkim2+qYDTf2icyi80TN+0R8SlKtw3vq/Fs5b5k1/1Jurb9LSsDoqK1sQgjnC6X76nPHe
 QV4GXt2Eu6N2vvz9y6iQnTX5LFVbR02IPskBePovrALsyQnHjQBu1mPztGNN6hjN+zdIQ3CYB3x
 CQB0OhF+TpReF4Ib87kYLRg5kSsk509vr1NU0gdUl46sJ64jNPgctGRL0aLuiLJx/0zALs5Vn6E
 YBv1KDMOSREnFe8IwOyT3ZfeaF939j2W9dyTJy6x2o8Dt3aLvxFrXWjWnNNYh6/5ATkOV3zlbd/
 tmfcDh8KoKxkuu/0zWvKqTEuvKF3PY/InkZKYFL/UUoAVK6rlhFb1NncqztafH+Qiu/QjEcNAJA
 vvgRlIXLWDig8lNBtsA==
X-Proofpoint-GUID: A2kVRWy61G9hSY5N0QYjVG0kOPkUiP80
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec7c4c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=MIjEIQyjxCZpfGQf5MEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXwYrPmwsNZCE/
 qltLK6Rtu2uracHuF9gxSPcbwvcSc8nBttqVLCrG+1C6dtSFwVWVf9y0/5+ksVF5AoYpvROwdW1
 HwtWwZ3wB5nhVM82IfD0aEuEVJ3RUmQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer g_strdup_printf() to format the
host address, silencing -Wdeprecated-declarations produced
by Apple clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/vfio/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0da2e143b88a..eea96240b7c9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2857,10 +2857,9 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
 
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
 {
-    char tmp[36];
-
-    sprintf(tmp, "%04x:%02x:%02x.%1x", addr->domain,
-            addr->bus, addr->slot, addr->function);
+    g_autofree char *tmp = g_strdup_printf("%04x:%02x:%02x.%1x",
+                                           addr->domain, addr->bus, addr->slot,
+                                           addr->function);
 
     return (strcmp(tmp, name) == 0);
 }
-- 
2.55.0


