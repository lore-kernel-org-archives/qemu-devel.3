Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50634C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3US-0004kk-2j; Thu, 23 Jul 2026 20:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UN-0004i5-4q
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UL-00066d-HB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeV2J1237280
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WlFiMYFEE09
 F5aggqhN9tmxQdu2D107CVwPhrwas+90=; b=eYlhw6TJHehEK5LFadXnCFd7gES
 jjKYcgdicb/fgRglbFQW2vpTyGXCsk1W27FRwJybMedEKAM9Da2BOBEbG3ckP87c
 Oi9ffgkzhimFDlc5CZ7yKThkXuv+kEJmG1lPrl6H5TzNWtHxDoKRlNUfHJzuZaRG
 BCSmkBlnAQiLvG0lwE4eMZ5XAG/FkATdUgNvDMHha3IVCulz/gtw4dTldwC7Z/rS
 6/Tz/btvjgrJA62RjjvuDrBcN28n1r14xBjAMutxwApiJYD41WqdWDfftBsM28Sf
 HwczLGEzB+SCkTYjjO8UA6ayjb/VNRVoxe/ypsgOOXW/wnNXnW5dJTp1X7Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqkq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so977912a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851803; x=1785456603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WlFiMYFEE09F5aggqhN9tmxQdu2D107CVwPhrwas+90=;
 b=fMMtrCFIeb1rGqNxjKqaP+noaX5+7kEkGNdnlnisPV+UHuht8aknPgr17WBD5hRmGs
 1xoEqc67o6Z1GH3wtnPudLzPQhpRi/QQS3nqkGpxJtaD1XM847bW7bjuH4oZ9XyaC7bZ
 ZAnXy7/7T3Pglvob+bXWGJmIFBtvRqO7TbZ9We4SZ25GVup6j0BnP5QCH5f08PuC4+qm
 7eaZiIZXyhbJ5hv5mZvj88ZyLRlLliYv5dFPrYIggJvz2syHuCoI2ygTzOrnhrVrfF5Q
 5Ug8HSsk/0M2ipaOEBEv7Ol1sxHwZRIA2e/jH9Tb6jp3ZHN3iN4JfHnmXiQYMvI7tu/9
 fj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851803; x=1785456603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WlFiMYFEE09F5aggqhN9tmxQdu2D107CVwPhrwas+90=;
 b=ZQlIsE5c7Svux/rU3kwiSEAtWLzzVXXFp5VaR9MwupDvPCPF4+T9xfTAxHF/1vOx9z
 Ggi+OxzQYtC8jbUPFOwaSjGMv1ZNORrkZL7l+MuHQCZqJKhGyRl5TY3+P2WQpPBl78YK
 YNYisdrSaEdAAeu1ywDIQvNNo8I3Ue3B58LfRKHCY6Ak29tIkFSPrYJbhuv9ZRbK6bqz
 GX72Qw/L31IXJAyxrkIb/ogFYBIQ5HW3MYVPFrOU1IlNYiKvboozkjbdTBY5vSCMknhc
 2zFtKDfdOJa+pIyCqcVgAjE1E8a1n1iP2J8+f0FTR9BAtsYAzKcVeIBJZBfBaHHzI427
 EihA==
X-Gm-Message-State: AOJu0Yzbjniz0KvmT5aaoonGWLYbJ2q8zCRfkKEpcAHtQo6BS1JB42LE
 JreJ8sBs+dWF9QqSUAay2f8c+qFswXhUXbe+CjpK+UuAv2it+/iy+Vu3mqE5rge6e33ovkQI94M
 5t7Prrv5kxnijiwKwGAzCCWbQq26iNjTw7Hc7Brc8h+pE50+BB4t98PO/ZT2Y7Vuj5Q==
X-Gm-Gg: AR+sD13UrRMKwzfqhnrSpK528NeeNmjjZlJehYRJxRVPfb7+Rs0vUakJ7I3VNt7aFSs
 2sVcpjQFccgyaWmjTujwIVJHQKJMMNZTY0UkVQOyLm7d5KrxBvFK4BlMvM950WQkyuy3wp6VBZI
 zgLS+D+nieWkhnC0C6/lgq+3rF3fTD/mipp+5/MYOAPp7UVdkGN6bC3ckVmYV+I8FcvYhUscH5M
 CIonXi6Ek5C2MPIAbVArVMiLEDZ2+PQSNKYzKnBTRgTOUVixRu6LaYJKPfgn9txd9I13aW88i9l
 4aT7J08bvLOtsLiATHp7FXyWq+3Itmgm14MwX5/vZOQm6BTnQbhX811UfdHylskxWIXWGh1rbE2
 OyHDjK3kHuLGaZntdaWt219rbTOIkP1FWyKJOCePIZNVkz4d1dA7CjoS2XLy08YEZpug1u1U=
X-Received: by 2002:a05:6a21:46c9:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3c44b01323bmr5720146637.21.1784851803524; 
 Thu, 23 Jul 2026 17:10:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:46c9:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3c44b01323bmr5720115637.21.1784851803119; 
 Thu, 23 Jul 2026 17:10:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 06/27] hw/remote/machine: remove unsupported arm target
Date: Fri, 24 Jul 2026 00:09:26 +0000
Message-ID: <20260724000948.234657-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX2qdP9fEt36N/
 edoHZhmnccuFRdWCT3/PBvNuq/4kuj2VTubdflclbEIiWXKyLZh6uHe5uzdks5g2d8xE9eHl2Jx
 bExH/Ye1gIgenDc8NL8+/fophb3sxmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwGaD7j3uN8if
 c76zGsdaAbDZFtDukA+aN9V0BxHA/rqIH/vqdLM+pLE19rntv8FV5Nl2d7/f61EGgVWkgpazP77
 k2/GLDLpaHKnTSCKDSgzO7VTvm+xNbXCOLa+k+DF9TIYys3L/8gEv/I+14NMnoC1oUl6YI8HbLD
 3JDQ6GE1y+lAnQQ2gPJyWHjdvICOFGN59kGy9jpc9HiapqVI7wgRRcKHeUNIaZBtk/I5e5VlGc9
 9bjoA+NhXVYYnFvwpIgEUaDKi+1IADJnPy1cstMEBCADwj4h8xpb2V7qFkCCN19pT3+J+ejs9VN
 9AmWbs0ktlkVsAOcFHUSPQGmlFnTDc0cyrPvqkq0KzSunD93d6gbmlKia02Ya2Ysnvzd24STB1m
 FaDkF/Lh+d1QP0JhDVK1/T8xJujc/G84SK8EI+3AiqfX8p/yOUTlJG+EXAEYBdYXAY44v3Ycpvn
 +qzuua7/p9ZOY8RAaqQ==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad5c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=ybQNsqCpf-b0oqEQsKEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: LX3QFSxEKMgMeGLy8kyy7EhNpH9NW7nW
X-Proofpoint-ORIG-GUID: LX3QFSxEKMgMeGLy8kyy7EhNpH9NW7nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

With recent target machine changes, this machine was made available for
AArch32. However, it depends on CONFIG_KVM (see Kconfig), and since we
don't support 32 bit anymore, we don't support it. See main
meson.build and 'kvm_targets' for more details.

Fixes: 4e8ac6857faab2 "hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and AArch32"
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/remote/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index df08f640199..88d38b75d52 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -150,7 +150,6 @@ static const TypeInfo remote_machine = {
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_TARGET_AARCH64_MACHINE },
-        { TYPE_TARGET_ARM_MACHINE },
         { }
     }
 };
-- 
2.43.0


