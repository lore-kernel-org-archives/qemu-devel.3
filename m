Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7191CEFD08
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdE2C-0005aL-9J; Tue, 06 Jan 2026 15:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdE2B-0005a8-Cu
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:52:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vdE29-0006I6-5E
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:52:07 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 606IVeGh1462299
 for <qemu-devel@nongnu.org>; Tue, 6 Jan 2026 20:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=tW6E527H9gCcSV7p6lhDR3jvyfmsoah/VJw
 O7DQjv9Y=; b=ApIDLx5cLiEUbFZR/pKvntDkHmi31Q/xq7Qhl/oOBKiXKS15Ira
 vQkoPdLoZf9h4SDGpETIPsr/JqmhUMA95ho1uUIjn/np35pglcNMRLu1qq5YZ1vB
 UDecmTxsgcizY9uK84w5IMv7nAZ99kMSgcVn2kYbvpE79dU/07oJO83Euy+9gJXy
 PXTlrV2024S/WnD0FmNwEd/9qN96D3SeC60nrUV/M8D8SrTtH3/03M7Z502CuMuf
 gDVo5gzi/vag/rIM4HUb2twbiAfdHLsgSsHF0sWBEcMSFuxyXMxt++IdGEtiiqrZ
 fKnqmr2HrRBft376VUi9CDKXpkATuJWQXgg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh0vm1rva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 20:52:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b0588c6719so65469eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767732719; x=1768337519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tW6E527H9gCcSV7p6lhDR3jvyfmsoah/VJwO7DQjv9Y=;
 b=NUBBpm4A3h6oZlUuWLDhYdzAaYvNo++yvyj0OEDEAJhpXoBRelQNEfBl+PdSiygm+I
 sACqE1jboVxduyomowzZxN1g8JJ7z79iEMNoMLNL/qqjllliBrHg/aKY1EpWUHaqiWCx
 8dVI518EjmMxDxJHn2CcUeXtXezGWfgnvIHsPAkScVYtgQ643Ch1tMk5XNVnISOf5e9r
 MiouPwkwiY47CvE/YCjptUgSWAp/GGk1i6NEn+Xn4yJA+X96npODLH49jjC9dqCiIVJb
 Prb4gBJkDZFb3EmZojpCSEvWNnOyggSNxbSblSAUD0nkQT4BgUnlrU1iQAbtIxO+vWg2
 buNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767732719; x=1768337519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW6E527H9gCcSV7p6lhDR3jvyfmsoah/VJwO7DQjv9Y=;
 b=bpjg45vihcSZUbDpBcU/wD2LyVqq37az8V5KY8FKvYBm+Sg70i4+svadZJ/DqcRBDX
 33SkyL6Mk/BiF37mVJzD1hWoUjQdq6h2fsRegVZ6NrHRqtcEOCEpiU2RwvrS9FoE0hD+
 BtWXsLfVbU4QEDE4I4a4cQDiwnBYRYNe1natlU/8qJMmep0C/YJTnZIxPb4XcN802L3Z
 3Ut2LpjcovTwEsLcrtnpbMMBavREBLxKNA8Zz3kJNvIh2Qx8BM7yUbxNqO0L2DEyRZrY
 HA1HtnAbgmW1NtVe3POiT8CUD8NApCyHgDKmtmk6PrMUs1G62kelQLLPTWgkgQaEFQUB
 gnDA==
X-Gm-Message-State: AOJu0Ywg8iXxnc1PuPRQQfGHq6K6cGd0CxRq3cQcKSGiIp2NdKrd6Dwe
 ggWFweriJHrQHkj/0akqqSbprHN8an9k33dcBvJ7znhCE1jOJrE3Z8uygBShOdCMN+1781Klpsc
 2hnyJVh9WhcJ545DSEdLEYGkmfuW9MFFdGnBehuVE063EjBgNnZwsGNSH+gKkjHG+UQ==
X-Gm-Gg: AY/fxX6FG+Q1pXadNjVtbAgfxMEGQafXrjF798OAVpfxXfb4y/HQTVFAoUYwDGfkKbY
 ws9eKI/iob9vmF/sUfaJyF5cbuAPRr31StIJ1SLsTTwrU5sbhJjh8FRqGYEVR9IbEOfP6b/RnVX
 K1kbGCKgfkywTBB39Uz9g8Ti+IzeshrBPVtJC+5v6R5BgXIkYs2J0zbCsGoBe9FrsZxvoL5Na4L
 4F9Tmnuqgh/MvyPlovGFiYxFv7ZBn5AuHGjlSqn8Y4BYSslSkV3MrrHIlwHKZ1ebmk42Ng0PSyC
 EsePdXGn22FczNxXgB4JObqzl/kiyrLSLkdtzyuMe62yW0W4ciNKkL8tLHuw8prm3pcl37P/kV7
 xsXz4pxnNtFdXFCtFuZvr6Xa3DcgQObnvlQNTqkXTg0G7ZvaJCvPZKhckj8xKdWRwdqkecKE97/
 k9AOixXkTOxxwEiOQP
X-Received: by 2002:a05:7300:2303:b0:2ae:5022:fe7c with SMTP id
 5a478bee46e88-2b16fd7d297mr3104152eec.1.1767732719427; 
 Tue, 06 Jan 2026 12:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkA2kI9SH8ozi0AzfnlDntM8TuNGh6cFflnkTpB7YFY4FRu3dMF/WSFDyo8smT4nFyJZ8dww==
X-Received: by 2002:a05:7300:2303:b0:2ae:5022:fe7c with SMTP id
 5a478bee46e88-2b16fd7d297mr3104125eec.1.1767732718851; 
 Tue, 06 Jan 2026 12:51:58 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 (200-162-225-127.static-corp.ajato.com.br. [200.162.225.127])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17052dbc7sm5015443eec.0.2026.01.06.12.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:51:58 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Thomas Perrot <thomas.perrot@bootlin.com>,
 Anup Patel <anup.patel@oss.qualcomm.com>
Subject: [PATCH] target/riscv/cpu.c: enable PMP by default for profile CPUs
Date: Tue,  6 Jan 2026 17:51:52 -0300
Message-ID: <20260106205152.3654975-1-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Pa3yRyhd c=1 sm=1 tr=0 ts=695d75f0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ewOVoc8TSmC0cCmMeNMfEg==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=vUWGTd5KPtm7CJsda8kA:9
 a=mH4BKZv_3NcA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 3Hf-I19AegBBY2fEBA-lSCMeqt9x5joj
X-Proofpoint-ORIG-GUID: 3Hf-I19AegBBY2fEBA-lSCMeqt9x5joj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3OSBTYWx0ZWRfXxIqvJzXm3BoR
 cTcRubvSKTLXGH2nm2bTRwZqdN/gc2KzVN+Tv5KbTsRlmWtKK1TqzH0WKvQzv9krCg4CFOUFa6X
 yxuXq1zes6HymqE2fQc/BcctsKlPazjLSSZAZwaPhEUy95oYJE+TEC/GYD03ocJAIl8czFJMWog
 1+Cd5i1xTfOahjhBsLauwC6pXIvBMkuDXbI7Bw0HhqxdJM3PP6rBq4Ox6D67nS2pVJavJB9qYK7
 BTit1q03pqThlECI4aHAMRR2kVZbTI+GuHB4Evdov3v51krXXRVBwTecUcXUYDNH9FrzefHdQsI
 SY5YxbrVC5gbgdcYn1mVks1kuETtBkh/w55ctLmT158/feNcdPHCJoyj9C9de3/OJR/z95ixSgu
 PFT3SIIMEi6hz3Oo32mo9qtc8N7DF5nIliwS2qDvH3Z+kBo1UXv4+SXeftaolhvtoF8coY4dqcO
 H2parUCKgvUaX0THUpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The new OpenSBI v1.8 release is not happy about PMP being disabled in
the profile CPUs [1], showing a:

init_coldboot: hart isolation configure failed (error -3)

error when booting. It seems benign given that it doesn't affect
anything else during boot, but still a rather unpleasant message.

We do not have RISC-V profiles that mandates PMP to be enabled. That
said, most of our other CPUs enables PMP by default. Setting it to 'on'
for profile CPUs allows for a more standard experience between CPUs. And
it's not like enabling PMP will bring any additional extensions to the
CPU either, meaning that we can still claim a certain level of design
purity for our profile CPUs.

[1] https://lists.infradead.org/pipermail/opensbi/2026-January/009307.html

Reported-by: Thomas Perrot <thomas.perrot@bootlin.com>
Reported-by: Anup Patel <anup.patel@oss.qualcomm.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ffd98e8eed..a26e547a38 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2955,7 +2955,8 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 
 #define DEFINE_PROFILE_CPU(type_name, parent_type_name, profile_)    \
     DEFINE_RISCV_CPU(type_name, parent_type_name,             \
-        .profile = &(profile_))
+        .profile = &(profile_), \
+        .cfg.pmp = true)
 
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
-- 
2.51.1


