Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6CFCC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH8gQ-000739-GG; Wed, 14 Oct 2026 19:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gM-00071m-Vk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH8gJ-0006SX-U6
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 19:46:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ELrKfR301282
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EeU5WLCuiQm
 3NtUrur8w3AG5zbx1PcX2n6cVRRznHAg=; b=KYdVE3bZG2MG9Kn+9iPZyZm15ri
 jCiOfexUXM5N2/29hlOmck1RlVmNbXxQ7Gi8G4F+6ePdGWGB7m8tiJjPez7nLdoA
 DJmEUZEw6aC3ZZtBtnajO1/qgBfrghuKGdH3VyfYX4hJj2N2YBLXXGtHgK9Pkjh5
 gC1/edO8ehF7DMWOfaRn4rVFvVcqA5d1Nv8zyzVzcRzyxY6huIw4nMq1uxllbeiE
 B0mCnyxvj7xuRAsNy1VH4tZHeFux3kX/PnO2rw19w3r9jjFdnvnN++Ea+AZfyVtx
 OnXFc3nwQ9Jqhxlq9jKyIBWk26WGMTRV4+60Mi9rqURIREjwy+E4nIAXP6Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623y2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 23:46:37 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so13061240eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021596; x=1792626396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EeU5WLCuiQm3NtUrur8w3AG5zbx1PcX2n6cVRRznHAg=;
 b=hkAUcgHk1+68L/csZg8AnkweB/cnbwNMs9gf3ZGA2Kkbt2BuSKSXn40UgXJoQdWf2v
 AKf58/sg5Fq7GKavMymwdasX4Yf5WtYv7jJEVT8UWpXmv1Fucw5Rt0z7aHn7YMNygpA1
 yLQrq1J8oKUSb1IGJP9USQnAQw5p4LZ7ItmjikTocoFgB3Thgp2GLMVhrGilqoduRYsn
 1/piyKCdcFsALoPQwY8kO4wHC7rADIkzipeN+kLlozJFwu117gbm8QsA/us9XIsdNoE6
 djeWSEFbcZ66ONGbMDDBDhyM+PbxgDEWQdsgeXIvs7FD45qXglR+bVdKl1xPzGroY/1l
 XxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021596; x=1792626396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EeU5WLCuiQm3NtUrur8w3AG5zbx1PcX2n6cVRRznHAg=;
 b=wf1KU7wl6v8J8/tiv+2AB7GKiF5cGPLTeiTviRL9WUV8xft9tJuCtUAuKifS8KIb6K
 D+BLmPAzq2cOUsM2ogBfHG6vU0xkUJCWjQJCo6GyTcIWGe2xlM8KpN/BwhjoqVPhpzdg
 NrKdZOgNNI6/olKrdsIEWSzOKqurUKSVs+kO0HHSiB9ieo+wrYMO06aqHJyyMld4bxeU
 FrW4dTKLC0OHhNMrPvk/QxNsLTnwEm/FTzLXu67sbVhRQVn09d2dDW5RS6TvOUjyg40g
 0qumqThHersVDapAHwoBY8Ag0k/58navxULFJSXedjKpRmxyPbz3IcEE7hTNu9C0qaBY
 jgpQ==
X-Gm-Message-State: AFq9FYIjRw/tOmWgsqLa1NKnzs/IBK5LEht8evTXNZMfuYtmPNNxlXti
 sjHR4syJ/nldz+wJh6/IeSrtFEozIGG4lk2VAtVgJOo+IyD4Uv07sT0UYoWcf4RWy5RCZnNKxIt
 lR0B1DP1xfqrcmko+lb5nLvBSe1OesSu9kuKxFm3Llg+JR2rgNLFlhd/2xSbmWwzlzg==
X-Gm-Gg: AYBFou0BR/5Not5xVv771izqsid0SRoxWQc3xwIPRrWtVRN/XNySKJB37rGR3S1LC37
 8jpQfS2YL1rtWmQ+xk1i9XxB3gNFjqyIhaeDd/uDIh5sUiACPElU0yM8BND4Q3q2sd6Wv40B+qC
 qYiekUorC8OE9lCVmn///Sl3xrpzR/uHysorMnTXWbHgrvjT8NiRwWj41FFm458dVzSKQFe9Uqx
 m0d9ErA/RLSS809bel8FtfW9k/uOToIAFsTXgQpZw2SDWJlO3xYIiZ9ToV8Q9Z6bKioVue8a/us
 89st6pHBwreEsleJn0HMXqztNW/MpqOFLTlHizvEFgdckziYMqH24G/7P4Fauq4VSoUmnq8Rykn
 SiOPpYUEvBFRYD9F47PwrBfiCtFeWTGSX6EjlCLGbhcLizdcuCf8c3RRuDo94
X-Received: by 2002:a05:7301:dd89:b0:35d:3370:d8e7 with SMTP id
 5a478bee46e88-35d3370da76mr6490261eec.2.1792021595867; 
 Wed, 14 Oct 2026 16:46:35 -0700 (PDT)
X-Received: by 2002:a05:7301:dd89:b0:35d:3370:d8e7 with SMTP id
 5a478bee46e88-35d3370da76mr6490240eec.2.1792021595373; 
 Wed, 14 Oct 2026 16:46:35 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm42506147eec.31.2026.10.14.16.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:46:34 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 16/19] target/s390x: implement get_note_size dump op
Date: Wed, 14 Oct 2026 23:46:02 +0000
Message-ID: <20261014234605.209084-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014234605.209084-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: w8LuqgRSAsbMGXo5Iz_r9SCwVuike8rR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfXwvUerTkosAT6
 ANeKNW5xgBXL9vl68yrMS3Lcb6GDcpH0pbNI63KEavCQShZ1sT3B9JULOFl5lmVvXR0YDIuAPbN
 yLAHTIJZsQ86wweS9USl/z9bUwSYd7t7EucB938uur0nihnvHmbFzMYs0/YAagXXAD+4fPhAplT
 zXFMAGZcCAij7IrzDQQxz7rXbPp9NjBXoexc92QXaLLEMz/KzB5HAxxoVhKjQRj6PAW+Bxf9qPN
 XheSGmiG4cDXW0eEpXLDwkyKqLxvpSZ8Qj2g2f6g6D0fxVXSyEpVXIRaTHWajMzgM6By1xr/VYK
 IG51Gk6Hc9jb9dfgyx0/x47MnXCyPineeon8ZaQKVTC29KfRZh/hqJmHIGq/HdnxhSd+/YYQCl2
 tX9etStDGr39tbQaYlki4bzfcZqipS9L8OrZaAURcDsZz/6ugqM4//aFbneB8kH8TmA2ZCklavF
 ruddn37h3EGQ/j420ag==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad0145d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=7G4PePfjkBXZ5IZN2skA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NCBTYWx0ZWRfX9FEIk03f2p5U
 3eNgM4/lI+i6emJvVu/H+to2pLZrwVz31GQthOGggEVQZrGEFRuvXZqZs7R+Pcy+WB24phh+0Df
 AUTQoAAfrCX2N6ZJyaSr0nT/PgOqVzE=
X-Proofpoint-GUID: w8LuqgRSAsbMGXo5Iz_r9SCwVuike8rR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140094
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

For now, we keep the global cpu_get_note_size symbol defined.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 716c9606d26..c18483a6754 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -470,11 +470,8 @@ static int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-const DumpCPUOps s390_dump_ops = {
-    .get_dump_info = s390_get_dump_info,
-};
-
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+static ssize_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                                  int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
     size_t elf_note_size = 0;
@@ -500,3 +497,13 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size) * nr_cpus;
 }
+
+const DumpCPUOps s390_dump_ops = {
+    .get_dump_info = s390_get_dump_info,
+    .get_note_size = s390_get_note_size,
+};
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
+}
-- 
2.43.0


