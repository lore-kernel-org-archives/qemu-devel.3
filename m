Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA518C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5d3-0002O6-Ox; Tue, 07 Jul 2026 09:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cD-0001s3-Sk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5c9-0000Tp-G8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C938D3590171
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gYmLYpnLJ8bTPzxsve9zuFM59HP6rO4WsoP9ARRYxJs=; b=LrwlzUAkGVsXTVYy
 cT1VkWIDxZ+aAtNux0/UmQ3MvszZBTSynQN2H4x2mT9t3G0QgGwYvTd1HGxRcWPB
 2o60pv5+ROuWlYte3T2k5Ye3YWqrbBDAA2LHAk4cJtfc3BV0ogUmf7eVeL9deiOx
 wK/hizKWW9XrVj1hL4c/xNKDOqd91gfh/RBX2l1Fup/gPyN5JGaWEV0/SRkD9JOA
 KRYae9ViGgI5VvNWsDDXuc4+s1VtVgowpKUOmCO6vsGypkCIJCxCr6t5HEiA3HUa
 pVeock8PREFFWkUpQ1mmJaGXRs9iX7xRQiUgO6tuyI6JsUOrul3RGtNTkNtaQ7tR
 oRneFA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9beu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso6811451cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430003; x=1784034803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gYmLYpnLJ8bTPzxsve9zuFM59HP6rO4WsoP9ARRYxJs=;
 b=dSqziMZ7U6hIqmUiXswk7Q2jiuNaFq1PAjkwbdCYAPCrE+5r2G1x+0PO3BNvHp0esG
 SW3j/qKVP583IcyaoKss5EKvyLA2SpPkp2RM5Td2Co6d2EV5OO6HNkk9zGn/QIb1MRgf
 62C/hkHD4Lf8EGOreon2jRGXI250n/kTeDtI2GWHDJsA5nbs3Ip5PaBJXJdXlcyK92ae
 DYY37gU/KDx6s3BwA2xusyNEezugvSBVEhKVHEKh7beSsp8e4MhMB2KjEoWoX5vHE7+h
 KP45/+IXY4u6ew4JV6yquiwr6L3sNk24ditM3IzDuLlLlRq9fCZuljAUJb2Ed++7cMml
 VbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430003; x=1784034803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gYmLYpnLJ8bTPzxsve9zuFM59HP6rO4WsoP9ARRYxJs=;
 b=rURUlBDocMF7iryvCNe+I8+sBRdpyQPrg3QUIy3EJ2Qfig3dhDM22te6GAOVSpmSZ/
 hEpr+YLLtLVJeCxdW1SjcpTPK14OPGRro3z6ALw3xEFjxBqL/+LFLh6NcITh4/SIDuh7
 8/IdXNpAmYYRf4XfQjuBG1KFn8Cf/ZFgw/xTpGtRF7qi/VHhjWEa4QChpQJQ6RePA5Vx
 htJ52VQSLcfUC5wAJpe6cJ7kfbfbFsMNBXzhUAUk92gJRl8RLn4lZRylyYpTIgN+pDBK
 Y0+YkotgA+17zCC0sHqh6mTLaqM81+svyJx0GESOyPhwnmEihiJY8Qh3jOyxKYwvO9er
 w/lw==
X-Gm-Message-State: AOJu0YycjmUJ3pEldxUMENwcVXInweGhGUQe6Xak8AwZPAHaBS1mniOl
 I9kXls8+B2Sy69TNSZZtCRVLJD/HFGsVKHcRNKAt5H7ZFcqnwZyxEYSvLnlgRPuf+HPPFNCK9ja
 HvEqX5nlUulU0fUAHT0a5jAGlGupZFArpTc7ILnn/WIwE/KnzleZd4OR7OFsDEL/hBw==
X-Gm-Gg: AfdE7ckAMo2tiE2e2VldHeIfaFyQPykxWfyY16Wsv3pcVI6RpjKLs/StlwPYS7eQdvg
 fHhdfBs4Zd8fSfl5j+luDCwXXVQRsrPn9BEjBd6RXp7FLCeXBOm9UES7E4skPTWTNBkpfX0VWbb
 ISdZMUP/XBn0K7elmrTdJy3+01J5zKQOgXztNyKYbNtuLMPdJrIFmcAfC4Him1eyPfqgrCJKlmA
 HAbQIo+vjW/3dQpDj8/+EOzdJWlWClMXsrx1GqCWeDFnKtXKMG6wK0Beb43vhv/shMOfNJSY3xx
 GEJcc8pYKwVkFkTIwsr4AzQDVKqf4EmlxQFM9SE+3fRPhJvlhjyM3bptADK0KZLb+xsKI6GL8hN
 yOEGnklcKIJgGo42updBSTfu3mFl+hIkNuSQ52LU81eD4TEg9zL8R8jMlJ/yLneBD4j/F
X-Received: by 2002:ac8:59d5:0:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51c7a8a012emr24677531cf.40.1783430001943; 
 Tue, 07 Jul 2026 06:13:21 -0700 (PDT)
X-Received: by 2002:ac8:59d5:0:b0:51c:11c2:dc17 with SMTP id
 d75a77b69052e-51c7a8a012emr24677191cf.40.1783430001506; 
 Tue, 07 Jul 2026 06:13:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4ad4sm5825739a12.12.2026.07.07.06.13.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/32] ebpf: fix swapped toeplitz/indirection args in set_data
 trace
Date: Tue,  7 Jul 2026 15:11:58 +0200
Message-ID: <20260707131223.51505-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX35/EUhfR8LKC
 pTu76SCBJJ3dBEHHUPly1nVOx7CBwhcbLCBBCl+h4nitVGxxCSWwpx2o/3Kw8dpFAYzFDQlLvt2
 /8MiDorIi81OInjfJVgrj35WQtgbt/Y=
X-Proofpoint-GUID: xE-Q7-NwCmPMtCyU_PHiGHtIFXEC4noO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXzCBTidWNIWA2
 QPcLzxrfUIUBJYPg7RtWdmYtvcRUc3LfzKV2abmzsXOHYbky0zVJlg9GQowVmv7oy6wzVFkqZS5
 JsMBzWfBCXs50QWkR2+dGvlmTE/6Yjb0mPlkU/Pf63T/MEw9WMeOesPq/4z0SuMyBqrmcUY25kx
 XFjSgQP6ieGLTRsqYAU5vQs+oOKaWx056OzdslWyD+JrmlvjovFzwxAD69MU9gP1e1MGBJVBowy
 8c4niFzEhgOnkAshfrGMJB6Zgc2PufDDibr3D35P0Euj1NostqhpdXd5sByQ94x6YZFFLrYc0/G
 o+P3Yy3/KlTxVRaFleFmwyhiIB7tE4waj04t2pej6H9Z8G2G3kG+lvz63eHHMTlFHnV7CI/xhzG
 Cn8aITFDQ0c+pAcJolMVI1O5QasKeZthrpxKvFfgdVH7TY8k6x2wMcZNrdbz0hcE6tcY+5rqyxK
 paNPzIszd9M40Gh2j/w==
X-Proofpoint-ORIG-GUID: xE-Q7-NwCmPMtCyU_PHiGHtIFXEC4noO
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4cfb73 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=uInvVBOazbrfTO1tiRAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: yujun <yujun@kylinos.cn>

trace_ebpf_rss_set_data() passes its third and fourth arguments to
the toeplitz-ptr and indirection-ptr fields defined in trace-events.
ebpf_rss_set_all() passed indirections_table and toeplitz_key in the
opposite order, so tracing mislabeled the two pointers.

Match the argument order already used by trace_ebpf_rss_mmap().

Fixes: f5cae19d10 ("ebpf: improve trace event coverage to all key operations")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260629090116.266561-1-yujun@kylinos.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 ebpf/ebpf_rss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
index 926392b3c58..6650d0daef0 100644
--- a/ebpf/ebpf_rss.c
+++ b/ebpf/ebpf_rss.c
@@ -270,7 +270,7 @@ bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
 
     ebpf_rss_set_toepliz_key(ctx, toeplitz_key);
 
-    trace_ebpf_rss_set_data(ctx, config, indirections_table, toeplitz_key);
+    trace_ebpf_rss_set_data(ctx, config, toeplitz_key, indirections_table);
 
     return true;
 }
-- 
2.53.0


