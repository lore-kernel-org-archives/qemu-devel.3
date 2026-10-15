Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009FACCA465
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT4n-0005EV-CJ; Thu, 15 Oct 2026 17:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4F-0005AV-CC
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4E-0002QR-1R
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:32:51 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3gLM3902249
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yqurs164a/V
 ICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=; b=D79vZw7sFGYkMSiN8eWEO+XdsuF
 MM0tcLKr4PLRiCobK+WMUAlA8FcksebuEv4IrbDvNRRnPoXExtqf91nIOdKP0APK
 WCwihuo9Tswrp4ZlkgWhz/zg/j+3XrPiQaLXV+koKdWyFfcQnm/yNVnH8eJrnI5G
 VttL13O7mwnnqFZ3HOGN8zHSQpUZuMdLyHzrZ2xwF+GMl52B93q0jtmGhBInMTds
 MU9xPyfklXIizsy+bPYe2SQbN3Lg6O9TrqaVuY/6lPwjfKex+44+ijBQ5L++FvEJ
 clXCA2zWEvoZhBf85kx7gAzsRqwIEhrnOmhU2Cur8bUMgWzmPa/71sAFMYA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3serq1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:48 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1770937a91.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099968; x=1792704768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yqurs164a/VICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=;
 b=Sa64t0w33PJErZpGlhzKudWOWol6uhW4ZyVAo/FlWUuBVXpQOPoqtORzPVQ5Vs1Vqo
 aUWduCovT0zQi7dHb5lb0j5UgaEJajzA3DxGhphIFe8w/ILs3KNlUExoA2D5EykNv+UT
 iIxH1h5j2uCtTIQxVditzpkTuBf2nIl3r7CmyN5HoVonxaedvBCftwCshKShpXfsgoQu
 Bfa31KWwNlL3yEJ9svn4TcRh3rqBh3wvSCYjl6Ha4axOnVayL0z2eN1uDU+0xMkFW+tZ
 JhNk+9DKvCHh12LrSrrcPWf2KxB8gJa0gH+XwdncU69ywmAzM1YL9PIQq4SEGd00URBQ
 jKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099968; x=1792704768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yqurs164a/VICU18oUl++n/3uzNKRUotuD5Uh5jVvYc=;
 b=fcHujgLE+GUjFDfd/Mx1t1OPIEy8c8LH+di2g6GhKNiMbSsP7qS8jt0OLb/96vjYJQ
 +dx+orinzBpPPQDvOt0Bd/edkvDRPXO3LwAGJqVy//GXXUwwOmghcyo/JME2HBlCgR2a
 TMpsN5zPvFb/MpCWbPzmFrddrqkIt69OgGxBP8EmzDpqMhORgo8BpewkP/qSY7JDyIbs
 ZNra8ODUV+8dOBrl5ZY3jCM4VMnr2MHyMaS7+iAEjR1klGIbTUu8hWuTAOGz0XOf9KNU
 kWdZcyrKT8kakNNYsX+Vq1aAPq+QHB3pViU5Pj53tvAs++GRahNcBkOps/+ppLyeQ5NJ
 zc/w==
X-Gm-Message-State: AFq9FYLqKGNOC3sQ/ljddz8DFpbk3DT9sgoDvyZnDwq9S7zz2PnS+Wru
 T3JKfIc1IyUzjxoW4nqzSBlX6WLf+s9Cwz6KKpJeto32+/Df1k71oReo+McoRDJbcli3gS1PnPe
 d9CKJvdrAXwy3WiQ6/y+0yQ3Kf4TFgPA6WBEHZx/piHLfPB8qW5xNPcYMRMbYc+OUSw==
X-Gm-Gg: AYBFou3xpObgXqmEMAabazEMdjvX/hHR+eeLU8TI0cLW/Wyl947KZ9PMX6Z8X/1m7mh
 DWQYJXoasJ9WAlTYUXH8wEVTmIjcv658h0uTnxF/TT6/FPPcPk7Zfhku6cKSIpL6uz54QFWr34s
 AVh1/XGtizZZHxkbnkV0ZdDy6OLqKK6kDnLbx4pHgnw8C3dUE53WHcBR0dnI409T/94qAFR0mVp
 upvQAAW9zuVJ4Fb544+ua3zOY7uhnxz+gaLDnB8o3gOGOjQAKBmf2KOS1Tai5wxT1pLgAtO/ucs
 0CAL+SlpNu1tTFwffLLx4WvyQELookKTIP1XZBfKMKVSofgGESjnId0WjR7FOUKTtv3IZeToP7B
 Cvys+QOoqm8zOASnBNdCfrHGHR6duOIAS3VDtzB/lAsua0zUGpm0UatCz1fKaWOM=
X-Received: by 2002:a17:90b:4a4d:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-3ac979b5a2amr3727063a91.18.1792099967841; 
 Thu, 15 Oct 2026 14:32:47 -0700 (PDT)
X-Received: by 2002:a17:90b:4a4d:b0:398:c3ca:1ebc with SMTP id
 98e67ed59e1d1-3ac979b5a2amr3727043a91.18.1792099967365; 
 Thu, 15 Oct 2026 14:32:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 04/19] target/ppc/cpu: constify cpu parameter for
 ppc_interrupts_little_endian
Date: Thu, 15 Oct 2026 21:32:21 +0000
Message-ID: <20261015213236.157767-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UCO3mJEl7Penmg6Z59BTjx7NUGJBI_Li
X-Proofpoint-GUID: UCO3mJEl7Penmg6Z59BTjx7NUGJBI_Li
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfXyYTFtnRtVdA8
 D71nxPuLUM3A6SDvPZsn0GnAHGcyIdRc5+LrM/3+KkxYANA4iGOpvt9vW9cJV/5xnPWWM+BdATA
 tdU0who7yWGZbA54yv9NvyRpmjISI0M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX0odH1SFQmOK6
 euZLztbT4XyHfJnod2DWiRcGrUcySgo/xsqG6XcdS0XanGrSffUXc2NW1j3a0URew7wCd7NGlFL
 nBnSfjDkqg+Iwt+3vQAiHbeaht7lYYQiFJASQeamgccamYif9++VyFcoNz5SrXI/SxuTT2+PsK5
 9ot0SHne1Pw6NM2YXPs0i6V+klghW9BrVCtTNPLPGBk/CWc7CffYv0cWbezEngp5cmGXmBRMwDP
 /AOrl7SoYtMo25OAZjbpqTYVfI4zVWie7jLEDThZKYeyxHW396y5iYl4VvA5NuTChL8WoNkSVBA
 JFtK2pbWMOzI9u558TXWzLqTTQEGMIfmBsv0S5GguLXDTSAtdTTr3Sz2d9L2/6KztAwuoiKMvAV
 HbBowT28jS4k323oQuVf2krWfVX2Tijzd4leNu+SqCEofyybTAzQclvFEJwg5JFMYWn0Dm0Y0HX
 /OZznsQdrgD8ubEA9rQ==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad14680 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3tol9ANpHmc3mX4GjWoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/ppc/cpu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 3fb51bbeb82..fbffc9b3005 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -3048,10 +3048,10 @@ static inline bool ppc_has_spr(PowerPCCPU *cpu, int spr)
 
 #if !defined(CONFIG_USER_ONLY)
 /* Sort out endianness of interrupt. Depends on the CPU, HV mode, etc. */
-static inline bool ppc_interrupts_little_endian(PowerPCCPU *cpu, bool hv)
+static inline bool ppc_interrupts_little_endian(const PowerPCCPU *cpu, bool hv)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    CPUPPCState *env = &cpu->env;
+    const PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    const CPUPPCState *env = &cpu->env;
     bool ile;
 
     if (hv && env->has_hv_mode) {
-- 
2.43.0


