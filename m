Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E4C606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AyEIxCmD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LYIvbwxH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV41-0004jk-3N; Sat, 24 Oct 2026 02:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3h-0004ce-8c
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3f-0004aY-Ee
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:49 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2qLQf983458
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=do+Hv3jpHJJ
 ISlUcs2jc4MgbcDcdHrvUEbrfQ74H1i4=; b=AyEIxCmDHMkoCoI8du3ygwZc0Eo
 9XU09TP0VCtTPhSJmzvYw7z0BWT2U4epv0HCalXbsAOhMXrOl8FqEJaCBk5xUztm
 YHI5sPb20+NabxPUUpKSbpcLOHXOQoDVSLjJwuxoMZPkn1/3cJdqiIQwRYGDPt+k
 6+S43nqsfuMJQanHF05SZAHfHHQPzuJ4WVNZSmHGzHwlNlLlW8oCe06/dBb92O8u
 j+df0ALc1qxhsPVrn6iqLDZrIltnO5yHOnVfm2xCospLwTEByFT/qz5atRmKc4/U
 3kVzGbqP7pjedloP3Cqzc0YvjbgIHt1AD+qkONHPCwSRhs1wLUVem0jpGUw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xgc4f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3addd73e66bso610458a91.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822605; x=1793427405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=do+Hv3jpHJJISlUcs2jc4MgbcDcdHrvUEbrfQ74H1i4=;
 b=LYIvbwxHGFiXWxiNe7BCQuZ2o002+9RZ5G70/hvs7R00AHvmXB3nJH2SPmx//yf/05
 1kKl5xsvfBrb9EhkdtE+nxZTpxraiqds9MI2c8k2SjA00Cax7l4vFY2f5405l4nK8LAm
 MoJ6kVZNFcTvY0Q/8A3C+3U4BPf/c8RfYRGwsTNBzAlVOlh14oHrbvpUDT0xrmpr9Bvi
 TgrxcJqBUdKF1OrO2rmTAvce+4PeXKbwoxBI7ybNd1IeAV86Vt852/5JQMbjYXlF6Np3
 xiJa3kA6T0cdXj6P0N49mNV8b8repTVszQVQk/To47E+2AQm9ReSwAD8bTsSpn8dMY9z
 9p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822605; x=1793427405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=do+Hv3jpHJJISlUcs2jc4MgbcDcdHrvUEbrfQ74H1i4=;
 b=T3dd0C4Sa2QvGsUYdFcPEQtcd/BvN0ywqCeSCbY0maX2hPZeOZrLeuB4cROVqrlqPm
 AJO/Mo/eOMO8xBkq26eVqS0jCuiNHwz9Kt+8vm6t9GNjBqelB8bkRPBOL+GaHFqDJNaB
 dYmyhXkEPNNz3APyh3yExMcnpWuxMfLNCm5D6rZvUMbSj2j7t1EXGyP5MZwHWvxw2fCf
 2E8TJ6jDqvAILQa29vW2JF4/bjZY22GVifPwGK79+E4eVNRn+pZEWhhapriCWn/QUi9+
 n6P63FA11ighnjLKXGcumwlnACG6wc9SSl0n81/uUxM+CIFHh8R4C/RRWaMeub6ynAyJ
 fHyQ==
X-Gm-Message-State: AFq9FYI4ZOxbrKen2Odo7B7e4ddkJ/z2zluttgozgwsbi8nbJY0cYe5J
 D8lIpnHdy2ijZt07XNs2S8DTGbdaImThmohrFVhlum9oA4VcVNGSnigtrzjiFh5y0B1I+DmvfDi
 M5gNldmRXFk/tRrDhQ7K98r9+9WJ5jkdA5GIAgKyJU3VFBT/huktP7+0LJDLQngNbwg==
X-Gm-Gg: AYBFou2xmUUdjl2CCfZ5N9gZkE/hJIhAeWO2iNZdRYbF6GY/EpT6hRY5ZF6girFO83Z
 lpMxZfhKAVvRx6IOdOhuBd1goHBz0JnzBz7wgngrsM6mqj2Iig0XdrdNBzQhL0IMlVuUGU2rmo4
 AA5CkBGCsFjWr5WiBex0RvqF2CqkyPam8yBGwdOrEYCHxRH6hTeDW7FaD+9JU+GC0w3gWqlS+Jv
 0Pp5jUs2u4C+qF7OGeEfN5AcQspTX79f8b2RoqAwPMCMKzWYK6pDgnMsG6ndZTs4LM3fTR9/u87
 Z1WXIlv/f4+bH4d/27stH3tvTFt7O6ikss1QfBHn4ZvgE+BQTD9aKszMWegUAberd8xdnH96nGQ
 IXVCObr1sb0il6RDMAn2/gOxxEEzpqEuhMNjYuAbxaYqr+OPcF/G7KmtpSerzAXs=
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id
 98e67ed59e1d1-3adeb197eafmr1073445a91.64.1792822605432; 
 Fri, 23 Oct 2026 23:16:45 -0700 (PDT)
X-Received: by 2002:a17:90b:4b05:b0:3ac:86a0:5764 with SMTP id
 98e67ed59e1d1-3adeb197eafmr1073419a91.64.1792822604965; 
 Fri, 23 Oct 2026 23:16:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 5/9] target/riscv: rename virt_acpi_setup to
 riscv_virt_acpi_setup
Date: Sat, 24 Oct 2026 06:16:11 +0000
Message-ID: <20261024061616.27381-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QF-nZyXTzT6R_hPuK_FGMujZYqLfVRWj
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6adc4d4e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=c0-CPzg3BUJMhFZVEvIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfXyODXIYsvm6D8
 pi3WzAi9LJV1wQ/wKbKcr4Yeut1VDhX4Sfo+zIGNQyBAeT9itr7iHO4AAjb2PZt7AzgRCHq4dOP
 gyVq8lfwo0iUAHuMdIHtN0m0lfXDFfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX4XSLvUBPXwx8
 DZMSOo+Rq6w68FWBINQU4BjsCZuKU4428Lzuo/BPgI5MAa16Xznlhu2tvCBLeEVM619Sguqwx+4
 mVmGPLDllSd4DPVkTstWlWQRnTVokyPABPvLhZvCjyWE5UUGI0q8yrKMe8AFtg7dyPzdBQ+Eq6x
 oiZoh/uiIh8XUX1mEIkMtMKZ/L9xMK2qp3u1vThcC8kE3PLHjUBRVvPn23mbCCtQrKojB3prKia
 7/G53ja3yhjlWEyUb5VVmsYAfFMhZBKcx9FN4z+xQgAUrL4opsj6xQgWe8YW0BrFFW/gQomqBeQ
 wFpUFdjPi8p7n5Dwpgf0n5vohodir6Wa3bjxodcjxQTIxU2S7f8PohQSCdxiHrlI3A/u+fxYkBA
 mvAl7OabzeA5Y8iaHIUV+aReeaENbMEsW9beMkyYwZvkPnziKWguo21/m+eG+YxOfx2FniQcJG4
 dAQpjqVDWhtBu3ccNMg==
X-Proofpoint-ORIG-GUID: QF-nZyXTzT6R_hPuK_FGMujZYqLfVRWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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

This removes conflict with same function from target/arm.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt-acpi-build.c | 2 +-
 hw/riscv/virt.c            | 2 +-
 include/hw/riscv/virt.h    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 0475dcb5c60..4565359e908 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -1021,7 +1021,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     },
 };
 
-void virt_acpi_setup(RISCVVirtState *s)
+void riscv_virt_acpi_setup(RISCVVirtState *s)
 {
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 2c6f983f83f..de1c92463ad 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -712,7 +712,7 @@ static void virt_machine_done(Notifier *notifier, void *data)
     virt_build_smbios(s);
 
     if (virt_is_acpi_enabled(s)) {
-        virt_acpi_setup(s);
+        riscv_virt_acpi_setup(s);
     }
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 16d86edfcfc..6e4fbf4b647 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -122,7 +122,7 @@ enum {
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)
 
 bool virt_is_iommu_sys_enabled(RISCVVirtState *s);
-void virt_acpi_setup(RISCVVirtState *vms);
+void riscv_virt_acpi_setup(RISCVVirtState *vms);
 
 /*
  * The virt machine physical address space used by some of the devices
-- 
2.43.0


