Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C361BCCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 18:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHmRs-00077h-9T; Fri, 16 Oct 2026 14:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRo-00076h-QX
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHmRn-0000Vt-Em
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 14:14:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG3hYQ3260540
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3rpLie2Mjuk
 Y1Tpl/r904roTdNOCC2W62sgxcxf2fd4=; b=M4oI6EFiczT1y1Jo46aty3Q0WXR
 130oLKr9IFjTDvraO02Pjku0yAP6CRFQMaqYNTm2yviqNku19G/nAREw3zU/Du9c
 n+jKGDbbIu7OeeuC4mMgmp0I1CXY+ilOaeExOkF0adM1P1pvtjbYTFXU+8DGKxIo
 pJ8g6Hw7tisRXTMh31Yxps5ekxQ1m6ost8NjAs9ZuoUx+rBm+l+uIFtrMfNNu0ja
 Eqloui3QmKNdXKNhlTnnblmZpOeC4bD0dnHqtajYFWR6i4XxIa6L5ZkL3NQ3xh9T
 UX2Y1Fl6LhU6m79IxQ1ysk9H6QKdq7ATGM2zZFdnBsL0nf6jEalkQ9nqwYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450gcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 18:14:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a46f0f158dso312161a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792174465; x=1792779265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3rpLie2MjukY1Tpl/r904roTdNOCC2W62sgxcxf2fd4=;
 b=HdGp/R3Lji9IHfh7IqAn5TwR8uDUAYnpFccqiHWhM6rSo9FJpSBvK2aWKMRmLRY7vF
 8cANz5qv1w+GgskTqVBg+RMb0/BJoKsR+ArzUktrOiwcDJNYTAyp5Ujeq8LybhY4ZXYX
 q59nbRO5G7h9y0fSRcJLVGeXEQ3kXjnwyIMvGitDYDlvdeQWN4KWHiOEoI+eSixLSCFO
 id+yc90bwDl3Znod+Hqf3Q8PxIkpCzBaqCMMhKMwcqXMG37OkJGytxS18naJDe0FIuuu
 KUskzlR1Yo8NtkzVa3zUi0zWbb6/cy/BOxobQUxrNdGuEJFWdFcfrM6qquHoikrWITOs
 fv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792174465; x=1792779265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3rpLie2MjukY1Tpl/r904roTdNOCC2W62sgxcxf2fd4=;
 b=vknSyomQMiAlX+fdmWDV8Wyw4WWmBN3ArOYhvfxSLsIChdcmJTAldIxvBM6bnihjIw
 FCQqQo+P8Wr1IH9iUAGKaWnhaFi9+NnacxzzqD0Po5snOb0zKdRb86Zp3YCpP3DRl0HD
 vIz69cr/A+D6LuvtGE9j+7PsPxmcAZWiGoe8VgeRzR3jPfsh3kUfJkKz7gqjeKrDv8jQ
 Ry7bkILZ4hZdf2kCQvnMa1OF/kJpXsx8Jc4jA8lQH/0aTJwoBvnnj9Who6M+zTju9gGi
 gQ5eFtrLt1UmyYGM2sh56R3KB/scWvPfb7l8vWCu2Orw8WDbnx/h+wS+7gnU3GCLrNlm
 0hvA==
X-Gm-Message-State: AFq9FYKR/gFPc9Cgy59+Njeb3IsHMxm85K2Q2dCIfmLhYlJU48s6uJ6Y
 nCEkKlmkgAKsylBhvXFHCTGnS6IMEvNetvFOwZ+QElw5C9Jf43lkl9VEkz1pyio8oaoBwK9h/BE
 f2J6a6DWiOCh5rfl7L3O7x0kG61MaNcZCuTm8X1g6Sw7ol+wk9SYbXE9NvB7WufzYzQ==
X-Gm-Gg: AYBFou0LkV+qcM0K2nosVkUFxLejhYTpW6ayVUmVm1k4wC7VjU0qwGpZO3GRXOYh/3h
 LYq8NBQiNtDgXmAYIIgDlFIYdZ65gO5YsuX6Ibil8MRlHvAQbYoGHQfSeOxnbUkPnLxmAuv7sdZ
 d2IoMN5NANm0JJ8kD7QNWjnhhAk3MJe9NNxBIfLojHyY+35GkMp99E4Bk+F3TijqwasuQy8LhEJ
 MtNg0YccaC2kgQaDmR9VdUBT2QkEsTUIgeQrQ+Lc0AbUR/8wyzqYJ6JSMNVCjCMqC0SDpRUdBWD
 TjusO2b0GkhlC+h3MHm9p1TaUxUH+GPMgz2cXdZr5re+QYzS4dmjzObfLLhkrBLjL2sSY7109zu
 OpBBM2OK8H8pEmcXpBC9yyPqBVhfHaF5d/SGYc2TVxEhoSHPzSWzZaGait2R86FU=
X-Received: by 2002:a17:90b:5643:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3acef51e0d9mr332661a91.33.1792174465196; 
 Fri, 16 Oct 2026 11:14:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5643:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3acef51e0d9mr332639a91.33.1792174464146; 
 Fri, 16 Oct 2026 11:14:24 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48e8646sm4895282a91.10.2026.10.16.11.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 11:14:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 05/23] hw/core/sysemu-cpu-ops: add get_dump_info
Date: Fri, 16 Oct 2026 11:13:52 -0700
Message-ID: <20261016181410.191743-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E1jKAQ2cJP9usjieLAc98TEhk70ofRpI
X-Proofpoint-GUID: E1jKAQ2cJP9usjieLAc98TEhk70ofRpI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX32UwITa6q9q/
 r+niSGZTEqV1kIAVveG8FUU362zkfkpZjEXAD2jgAHWHY0+KP+QCZGq67vdsZhK3GhZVIE1m/iP
 0b895WVWYwsqzM48KtzaKlJKPF3wlnKHymPq9IpI33mj80RqVgaSMKtqdK+KwU4pSqcH5gliKBb
 XI4ObQnpxhH3PZH9lg5L/DGUqj19zsJ3M0dEjPv5T2PIdTDkDRBRBRU+pMmwPxH9CsMjx2mo+L7
 6Seb+u74adum0KfsZP0HRTmsDu2F3ccu8MspZ7nxon5+GbU4LsIku6rJwmtM1MoJp25P5gOB7xS
 dGBLqq9AyFbm9OHWwcu1580jWPQisx/kKBCEuZBh3h5spJOMgqk2FqMa8kfTQycMxMo5zHzWVHL
 ROvuPfvBHIHllP+zrzVLHDhdkTzdWf6+yJRxEdiI/+Ecpxj/0VQwYIw77VCb7NhNuaR3Q9Qfkfc
 Ocj2C6JhsxJlUyXAwIQ==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad26982 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=MPCGK63B0krzei8L5x4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3MiBTYWx0ZWRfX2rmymp1xUX5O
 lp4XHx4l1bESYXjUNdUjxKZzYPi+84r9fqe3JEvIYvN7lx3IzEtTBioUoXW6R8Et8FIMfd0vcwI
 NxddfDDIL5HQI1RlDkZOtglhlUyNvVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160072
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

This allows a specific cpu to declare its implementation of
get_dump_info, needed by dump.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d..2c7d0b94767 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -94,6 +94,12 @@ typedef struct SysemuCPUOps {
      */
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
+    /**
+     * @get_dump_info: fills @info with the endianness, class and architecture.
+     * Returns 0 on success, or -1 if the guest memory can't be dumped.
+     */
+    int (*get_dump_info)(const CPUState *cpu, ArchDumpInfo *info,
+                         const GuestPhysBlockList *guest_phys_blocks);
     /**
      * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
-- 
2.47.3


