Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D95606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kjTsDtLK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VvC8O4o5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzfj-0002ch-Pb; Tue, 24 Nov 2026 18:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzff-0002OI-M0
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzfd-0005EV-FT
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:11:31 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaa5Y2830185
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OsMtmAmhgSHvdeqb1Zj9L7HzhrgBPTsubL9W00ioJ0o=; b=kjTsDtLKwEhasB5v
 F3Gl27FjBChXO2/21AXdzW3u1Q26eLFjEIuwlRBxGcMmriPShM4naViv3QV6mmzv
 w0nvs32/n5PuidcFSGOSkUZcMGtqDY0nBNYQUL4Empd64/yAVaJjUWwpX223JnP/
 1PS5Y1mmaE4yUAcHlFZE/Z+xb5RW/np4hNgt5CHTQqxuWkBG8vLHdbJrhyJgmhOw
 P09Qy4fkBP4F7ciJx/e/WQBS7jcUNxYjB+34JaoxZzThkZDKol5UIShzW6+CpG+Z
 MhQMc0TlLRwQwSP4xcNMYGny85jwyjuM+YRNxXxG+aJmnRzRWp1zMrNs0c/FRg0B
 IoRBQw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxk9xjq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so996135585a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561858; x=1796166658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OsMtmAmhgSHvdeqb1Zj9L7HzhrgBPTsubL9W00ioJ0o=;
 b=VvC8O4o5v+vLO46H5XETConUwcv+85dGfBTl3R/n/kQFkPn8GVoFP3DUqgVwkU2upn
 A8eeUkGMGJ4TaHZ8m8fYnAiCx26dlUcnXhY67wSSb6ioJyTOU78Wp2hxHGR+p/byzhD0
 Mim7wdkpDjB0XGW4WOan0VtgRjE+NolcuBXboTFOo8NxoPhRImxvU4KT1DL+mGA78c4v
 RDIWTeyejgoGWT/AelBWPRnd88Jtxbf10pm8PP7JhX39ydUNEaitQg0lnXtytuBvlGvA
 tvfx5LasIT07eFPu8XHzBIO6TXmoKP329ukKfZRrLXeSXHPQjc+JPu4htmIXGT/1hKMC
 kSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561858; x=1796166658;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsMtmAmhgSHvdeqb1Zj9L7HzhrgBPTsubL9W00ioJ0o=;
 b=OOmgFljkAyTgCLDLaY33u/SdRUB1AllV+X279uNw2Qov4LRyCmhGBhroBxJ0ESuJlM
 B24n85MHJPuSZfl7afxfkZVKB8QD3Gb6XTyxCRoCr/ZNlMgXJqAVI3tifMPddHxytSMy
 6DlAukL0ZoayES3p9B/g1VxeqobWscTZ7mEt9hYstI8IQzcIgQ29x4jV3Cs34vovPvxU
 u1dixQzAGONJQ+Lwd/hnovae51+M5JuIdS6aYuq18rQ5kTpeiAvmYfp6fy2/vebSizn4
 tUSvpJHah85YNBiXqU3SMBboWETQ/Xww50HA0KXgTSgsZtePlsKTQGoNYHkNx9PwCx8P
 E8jg==
X-Gm-Message-State: APuU4Z8wqIE5XHg76AL3SXP2WrBE521wfgrab6TnG310PvZ85x4mHXi2
 SYX1bmXNv6afB2orkN0fefol58Mh6WRigMIkExfGtoKf2+XFJ8vEhD5Zs2QT+S0QitcIQTP5kwm
 xmGY/55gbQ8QD5qMOOTVbp+fBeLGgR4kyEjpDhwe+EVzvJisYL+VyON4j2OJzD7Sk/CN7
X-Gm-Gg: AZFdTZcQ7z8Vsv95wPL/T/DYcu4dGJOArTJ82594YfZWQZ8l4LXsa4VgjCiDeYv/Tu4
 K6dMWAbucLNPRlVzjlRroiU2xSRb3MheyT0T/H0L93Cb4G8FN9wOZdpohBMvTHccdlKllY9psUt
 GxxcIr9fB8vV4/I55DLb/oqqXRHdaTXUnxyYEnPUe+BUpUsqEVbKYNBYHnTvCCS0FI/lOb5RZbm
 u0eACaBOuRAbZOidRjU/78ixYjT/wYcwJkBZq0AJVUVk/uoexKZsc2VRFmSOoPtxC8BTxvkqzx9
 je/3mmZRWGpF9REb9WnaDlCQ/o3j6V8A0Q2te7eQYDJvF37rfT7v/notbzTQoJ24ixzkwXdDUPI
 naHufd0WdA/hEzP1yKYVvdA4M21BNCiH9g3+0PC2hdAn+102qrm0KjKxy2H8VmySp1rzaSdgLv7
 o+Fwr8kGhLfIYnkg==
X-Received: by 2002:a05:620a:7008:b0:949:5fee:afc6 with SMTP id
 af79cd13be357-949baa07369mr2782139685a.63.1795561857838; 
 Tue, 24 Nov 2026 15:10:57 -0800 (PST)
X-Received: by 2002:a05:620a:7008:b0:949:5fee:afc6 with SMTP id
 af79cd13be357-949baa07369mr2782135585a.63.1795561857409; 
 Tue, 24 Nov 2026 15:10:57 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b33a596f9csm10687667f8f.12.2026.11.24.15.10.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] hw/block/pflash_cfi01: Allow zero-count buffer write
Date: Wed, 25 Nov 2026 00:09:14 +0100
Message-ID: <20261124230917.88704-15-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX/i+2bQuX74GW
 CcYvAHr441qXW1zZ8zCH72LlZdK9rgQbzz4mDvUxe+wo83sb8OYZy0PkdZ/59fL50wYHZu/vOsV
 Y69mWipvRmtwIEdTbKrBI05LbDRW1Cp61VpuurMMdbhrAmVyNtEU96rOSqLAPX+DvfqEmqAd0iN
 NDTBCcCaml8DLzj6REOU2sTECq7CrPkyavwglokZtf6SGQLe+IfFQW84rINmkSOUP66Iqn/0vIB
 Tv1FuPqXC9S9LDAU813nk6rGo6bLlGMCmzP+CVnmwprrgNXy9JBx6HUHv507BMoVLZKX2SKhJo3
 cPnVrC5QBXNzYq/myUa2zUDnBEgVlWy/DhqIdNi9n3s1aDUuxcZHDZcgN0Dxe2d3fIlHoPSFk3W
 VEI/dOEIDlTG8510EQZg3CN9+MbA+MBq9gI6yi1lUu6YUSQHzrMYSyyo2Aeas/4BqJgt4prW2MR
 FODN3cLjhLyGHsphJdg==
X-Proofpoint-GUID: mEwXqvTrHkZYW99xdRnetfcNZGsJhxqx
X-Proofpoint-ORIG-GUID: mEwXqvTrHkZYW99xdRnetfcNZGsJhxqx
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b061982 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=6m_LOCPcDEeECKC5TYsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfXy/AY9rldqoAw
 9RvWDQ+ESWaNb/cbYGh+hyRMU/aR6vBEmDjoGG9S6raM8Ge898gToZIjTm5fc/fRZT2tnmAhs/+
 lnUZLQkw90dIT3kkzgZNhDCHDdRW/Vo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240091
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux's Intel CFI driver emits a zero count for a single buffered
write (one write cycle, at any bank width). The block update buffer
was only started for non-zero counts, so the data was rejected with
a programming error. Enable the block update buffer for any count.

Cc: qemu-stable@nongnu.org
Fixes: 2563be6317fa ("hw/pflash: fix block write start")
Reported-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Suggested-by: Daniel Skinstad Drabitzius <daniel.drabitzius@northern.tech>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4111
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261124185556.81132-3-philmd@oss.qualcomm.com>
---
 hw/block/pflash_cfi01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 78cb221ddab0..72c544dee8d2 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -605,7 +605,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
         switch (pfl->cmd) {
         case 0xe8: /* Block write */
             /* FIXME check @offset, @width */
-            if (pfl->blk_offset == -1 && pfl->counter) {
+            if (pfl->blk_offset == -1) {
                 pflash_blk_write_start(pfl, offset);
             }
             if (!pfl->ro && (pfl->blk_offset != -1)) {
-- 
2.55.0


