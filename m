Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3998C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegXm-000355-EB; Tue, 30 Jun 2026 18:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWC-0002Tl-Vu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegWA-0003YX-Iz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:24 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJE2Nw2838807
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xxo4rncdHVOGViF+d02fuLUfZcQgG/AAcgr6n4Dh5Qs=; b=av6QHs47UIiuVOtP
 GEZUlrxV6YgEIah7rjCGb8l7tjoMx5TtIy4suGCX9v8YDQJC4OMab1Ay/aoev4PM
 fmAAP+4uD7yU7oCpaTi01OZlNhBhovIkqvtbMC0WE3PRZXgBlKZudTAHrRIlVP4G
 dzmd0PFsMtI14aB0Q4lS0EACI4UzyYlrCZ/k2nTTyfYw9OVTjI1WDQBIFYkrDm6J
 q07nNJnDpvqHCWnoBJ7tyd0koWc+Ss17gk2zPWEvQ3rY1DSPiKXbOHJ+/I1llfr9
 +E5rHG/GOY2kU61h28XokSW4mVXXWn5ScK6iwUo7mridoTOXw58OPlQhOaxeNP6l
 cwV39g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd1f71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:21 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9692aed16feso4226045241.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856880; x=1783461680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxo4rncdHVOGViF+d02fuLUfZcQgG/AAcgr6n4Dh5Qs=;
 b=BUj/23QXdbk0DQqkSbFC4rGS8gcjTBqP5GnSPSuCnIcYnm3f4uLzDoDY491384VpHJ
 4unxR4jwj0aDm9qoqGBJEer31khQYVwGlFy0PTc2iPX1xBIb4I6OcEvHWvXYri055WoB
 mN7uPjVMDAyS8qOsATCjIWKRWfD/DZ9EUIs+yYiqnpr1ipIucmPGrLFVsC6diu1+UuO0
 mm2vTUS9u7oHA5ZOiLCLdVZ31uTVs4G2CSZKLCiaqYXMDsbrdyeRRp23UL4ZMeHRKiat
 pG/NdEpaneHx19D60Xny4r+nChu75i+g5LrbYT65D+k/0BWwRjtWrC6IvL/Z4pcdeuxM
 ji7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856880; x=1783461680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxo4rncdHVOGViF+d02fuLUfZcQgG/AAcgr6n4Dh5Qs=;
 b=SBpwQtXwvVmJR1QKMRto2fOXwA6beSkS5aKTIKsffGr9vF0tJpHeV5DdA+fGn3i3d9
 +Cb+eylhl2Y1tWd4sF5CIkBZIYeAx7JZ4BlMJDu98uWDL1+TM5Ivfk3GhyCeBSSvzz8h
 8TMPioERo0LEbBXBXJeQgB/YkO3kAo5nRwAq0gEvgNW3KZJ1GO3MMuKHXIzoFzqRCuZh
 jgiWPWTapPnB/vGEFHPz3kvcua9mxsHCOfX9UW2uhBsXqEtSTjFiojUWBCKyNPxmUnHd
 LDPUAtZjTMZ7a2qzeNY+j8QkWwGsLc6SoLviE54uuzapZax+yTQ7LHdNfp08CfS2iy55
 Ns9A==
X-Gm-Message-State: AOJu0YyDFhfiBz1AsqBIOS42iFhqMXnzAaO2E/tNz1ZABSZPgZaKF8V5
 1HRAvMfg9ugidofZObB0IrvoVhRxzzmhmM3/DkkaaJPdxjRAuGVIQJO27k+IssW+SF2ogI6bCHi
 6EjAmHvktlKP8OGsm8AXnyacwINtfTYLasGJu+dGCHK55oGt5UHKU9mF4SpDJGS9b4w==
X-Gm-Gg: AfdE7clOzSF4OMAVPVQAc+4uSw+/ytX1pxXvz6wnu0wvZtMT3D6ovFhCgE0qEpao9ZB
 7+YPsWzS9Snr5MkiGK0COdX9csCbfh/j56e0PHUs/2Ph9vEeLIzJ0v9c3LoOHzhtbVG9nt289oW
 2lYxLO2hG1SBxgC4AMPrILHv4n7b1txYT8EyPWDbQsOdvgXDOMW6319+dUbGfkFrBKkAV8Y4dm6
 1vb/wnY7KCp10UX2S2ihE5/i8rP3AZzZJ4dUC6g4LsobNd1w98grdambxQEwutD9ZSZXn4jvpeH
 twwhu1aGceRQ0iG8wPEtcVfYb1fCycjHi9Np8Dc64L1VZIIovMLFtFUOj+o0aAeDWYCoOARVQIX
 U0USMbhhWaNxE/XtWToKsiMIb2hCEmH5j34Y6OHswTl5C/dLnr3JTkOWW0oKcQjcI56Hk
X-Received: by 2002:a05:6102:c4c:b0:729:cc7c:7de2 with SMTP id
 ada2fe7eead31-73a369f3636mr2630899137.10.1782856879875; 
 Tue, 30 Jun 2026 15:01:19 -0700 (PDT)
X-Received: by 2002:a05:6102:c4c:b0:729:cc7c:7de2 with SMTP id
 ada2fe7eead31-73a369f3636mr2630838137.10.1782856879323; 
 Tue, 30 Jun 2026 15:01:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bfe7427dsm4110515e9.2.2026.06.30.15.01.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 02/33] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
Date: Wed,  1 Jul 2026 00:00:29 +0200
Message-ID: <20260630220100.1289-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfX4aLpOx7K1uv6
 OZnuiEaKuohhnkQlISPUVVGg8efi/kyP+MFNEXLNa1F5NPEg6tsLpBXcP/b11i1qtwkVRNWsRwa
 t5LSFoQF1WVNaab6NJYWZMzGcj4ZlTo=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a443cb1 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yCXKn3YvPAIAJG_6uuMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: BxqWax-2sfbhE1bdxHo3Pt1Ykaq2tgZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXwGlkH5VFX8Xv
 CH/3WhdbriyJ5TgrnboX7YkMbvpb8j3kRSCDupITM+1NaxG5KLwkydPl/SOduRsEbfwjWq/gV7K
 sPgR0Y5rl7r8Ht4AJsJDrsmDTBcNb7tRbjsohoaup9PTznsZygY2ZI/nxQKJONQwz+bBeQS8SGe
 7KOI3YIYWQazXt2xVO8H7B592ctJiyyuGLSV3pxPQPLTjvzIJmgVSuc6aIf3x+IjXHQmu1jFXNT
 PaEZbySKwESVKmnePC7GgP9v+Ijc1oCCW43B5GSsaVMfZwKDelSCKTzKg/OKzQmLc6cgYaShm92
 R68ns9qzJ2xooyGni90W84S7DGIZ+GqJBenhUpmdPwHhkUdIM5sbcZObiWGhaXTl5SQiLUqssyh
 GZgHMzHmWuvKfr/Sfygyr2HgL5Ybqj9x4CT06Mhga/4lsG/4dMcMF4+AvNgXy6dcSuGpLAaa6N3
 uOSKqMypM9Qxp6C5xlA==
X-Proofpoint-GUID: BxqWax-2sfbhE1bdxHo3Pt1Ykaq2tgZK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300214
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Common vCPU cpu_post_load() handler calls tlb_flush() since
commit 9656f324d25 ("Move interrupt_request and user_mode_only
to common cpu state..."), no need to call it twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/i386/machine.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/i386/machine.c b/target/i386/machine.c
index 1f5c517e562..df0e0c178e4 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -401,7 +401,6 @@ static int cpu_post_load(void *opaque, int version_id)
         env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
         cpu_x86_update_dr7(env, dr7);
     }
-    tlb_flush(cs);
     return 0;
 }
 
-- 
2.53.0


