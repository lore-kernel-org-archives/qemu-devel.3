Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F76C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUqW-0003z1-AE; Sun, 05 Jul 2026 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqU-0003wU-NK
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUqT-0008La-Ai
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:57:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665HiRSJ2348296
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=; b=gec8EEm7XluLoRZk
 JgCIzS80IiWP2Nf9FrHXtdGS56NME0wHiHrCk3lgdmRG78ld0vgaPWrR9T7vsknw
 1mCIrvTni2HgR/tlnQI+Psy77ySi0rRvg854YsRFFqOhok/FOKgY56m9b42fFkd+
 MbguQVXupt6005A0sHoROqCcZm0Kl0P1FkDi7odmiDqmSg23DhdnreyAmkVaCdjP
 rF8uGBwSemUmFAGzwRxnC1UeatIwQw12vy0puvi/+M7pfirS+0n8H4TYDQDg8Toc
 zCNGlm5ukStH9oWpPxVgljfFx2Mlqd0tqwh6smtgg0ND5X2mlTGnwQSVAbwco/UD
 B9w3GA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6s64kmjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:57:48 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e56b2b350so502375485a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288668; x=1783893468; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=;
 b=OXD7dbTMIka8f67HZkRopkC32R23vLzkubImcan/8u7nEQKyc6yxk5PF3KiDvLghl2
 XByfx5znFZJ3m7n8bB7rbGpfGjkdNi+0HKT1Xc8xQbpXnLQ/x08SOxs0GhRlIvV14NYa
 5HK334J8ozn60J9PP/D6IIHqFe7A036SEq5S3t7/8ogT4Pr2oc0CCWdTdTGSFdd2c02g
 JFf3AdTu9vg5emlVfFve7YLhxgrWp4YNZyE/+JI8eHD8kQtTxUgl5JZwd0aHsHKBcFOS
 cfkVhBzOPmZZYjjXX24Jdu/WIpfuKCRxmd2k2AdDoyVY8N1+WQNG6GeHIn8OScReEePO
 sQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288668; x=1783893468;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=baUNmRqXOkPRQ+AyufyGcZ9igaejjEE6RFXBGnD67zY=;
 b=V2YEX9fRVLXpAxAAasgSAnsS+vGfYvX6fsKd1NK4fERGb1uG0dtLg3q+tjrVfUN7MS
 udKr+rBF56g1i/nY5GRDVFfkxWIUj6XH70DsBCKvhu2SXxX060zCI+5MlxMs7WxQeVKh
 F6m5ifvU38GKb4Jngje2qHvSN0J5oxnrVgzNfZXq+RulFHXxx2baNmIz4yePZAWvpcTq
 GEE899XPeXc5db8Ek+i9GFIgNj89DyFwTz7v+uAfngmDk1ojd/6ksCAqkEskCdOH9zf5
 qhMHl1zeWwnarH4ItFNYzItGnF3q3W+7seE0hRuxue86BbAL+Jc49ZeiMj8t+5ehXbrP
 lzPg==
X-Gm-Message-State: AOJu0YzQXRGk5pJAdVtfxhTxm/PptDIPsNQ8MHPbsBS3nGk/pB+ab2dp
 6/zZQNP6/uOnQO0E+3Y2aAcP2iUymtc3hBTyuGAAo5EGQx7NM2rPdOSDgEf6N3PG52vm5125zK2
 i7wI73NBXMDl3sxZSpe+Tzt3ycHoO+p7TjxvWc3nfGR8EW6mn7Tji4WS3sop8K1o2Hw==
X-Gm-Gg: AfdE7clVlZMA2Oy87FnNavRpLFNcjKjVp2pc9LiSOh8vRjW5gvEdSBA5YU0Z8AvoUZN
 weTsJ1zJ7PrtWblax0gYXLNcBDpUdZb5nemEBZUODkcrUwXZSkMhV1v5HODJeIQOXFVTG9+9LeM
 zB5/WRRiPwk6C5Cef5FCyTWDoq3TNCraqz7Z48Ziyp7ffW2L02iRqp17O71+O0hzjOw8Z5qrND+
 J/oMQd5IfrXz0Mw1H+EuLpe+BzO/c7RzvhLMqYsix0EFbTymPkul5sZTpO/PQlwJ9ohMIMEZcDA
 pZsboieQvF+44J/C+9axWgJmBmBze/u8WIV2oetcVXEjAn92hwMI8qIO+xSFD3r306wtffBpJHu
 Xu5k/ofaCakZ21zMGqE/Fa2c6XbzlorpibglTVNb6uIoOCIsocmJW6A==
X-Received: by 2002:a05:620a:1a19:b0:92e:4474:8fe0 with SMTP id
 af79cd13be357-92e9a364226mr1202775485a.29.1783288667645; 
 Sun, 05 Jul 2026 14:57:47 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:92e:4474:8fe0 with SMTP id
 af79cd13be357-92e9a364226mr1202774285a.29.1783288667240; 
 Sun, 05 Jul 2026 14:57:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm17941176f8f.19.2026.07.05.14.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 14:57:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 02/32] target/i386: Remove duplicate tlb_flush() call in
 cpu_post_load()
Date: Sun,  5 Jul 2026 23:56:58 +0200
Message-ID: <20260705215729.62196-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX73j+E8mEe6pF
 cmUzdVU5BN4XhhNp9myJkD8M6+WzunlKM/di74HQrBFc2MiPsEFMEirtTeGivchBFhqjIGiI9p1
 dkbTy8f16JYsAMQo8FpV4qun4uPL4xbGFXoZA0Zyv0KH8dSHP1cQcvohLQRUNdhylt0eu8HwT0X
 pHLiQasrLHyqB0rCh/bLQxz+OdTDzw4FXwFmcgr30+kPNPLp88tQTUOpfGVMvM3lRx8TfOtII8f
 5jF8EIxUvoJapQv+GdcBSraNE5aQ4Y1Tee5mxAq2Y/d5P0LIZE2IYRsQ2r2nA289aks5pbpBOiL
 w7BOBLvNcnNmBL4kTPRg2nEBymeRYnIlv48kONIcMaA5jlxSoEWKX98JtftvxWOmOhRbG5uSesp
 SiUdzLTOthAxAnEoRP90vr7B4BPnJBOcEo14T2+bn6myftCTT1uMxmBJvJDqpVpxlfzLTFGJwXj
 bNuqhkuIhCC9nCdN+jQ==
X-Authority-Analysis: v=2.4 cv=VvITxe2n c=1 sm=1 tr=0 ts=6a4ad35c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=Cu_OB6cER5A0ZMY7a4UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: F3MKtUfo_6d-edFJOhk0Jrdwo5fTuXX8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNyBTYWx0ZWRfX/PAukS2FPSvQ
 iw8k9eysLme4sfgExlj4lAOTIrzU9exRo8bYYZt/XbwiWmcX7sGb1lq1lsIgeeX/LH+7AZPGPzb
 AZpRpFo6DM++M9Ni3K1vCTZ8Ssqd0Kk=
X-Proofpoint-GUID: F3MKtUfo_6d-edFJOhk0Jrdwo5fTuXX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607050237
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Common vCPU cpu_common_post_load() handler calls tlb_flush() since
commit 9656f324d25 ("Move interrupt_request and user_mode_only to
common cpu state..."), no need to call it twice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
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


