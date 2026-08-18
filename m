Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1F6C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTn-0004Xi-IB; Tue, 18 Aug 2026 15:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTg-0003yb-7l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTd-0007SR-Fe
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IIaied1940701
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=; b=VC4Ejx6z0s6AhY5J
 si2pAq9+cnZrGPNxRw7qPIWOmkJIgyXRFwGcScfj7bZXnw/Cz+52G+KW/aEt7+6D
 2c0H3AVg2J8hACVgJFOchLwbma7CcW1BUvnRgb2glzbuebFvvUr5UaqwZis+OKla
 1YhcyHwXcghH+ZdeVZA+sRPsxyKg5ll8kbDNCqddqF01W/DsqHwEe7teuOnk7NH5
 uLTjUzpsZRdOaWEjsl/qcOPPOsNua/inpzCL89+v5TWRmgF/bUpvftnGNZBQSPuf
 mxQcQxUnyW1rrn8JUALR+BnSoqo1LB5rOzvFNobN+r96a4xICIycm4cNHLilx0CF
 lXM7Ag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4vtu063q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so271376a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081279; x=1787686079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=;
 b=Odvg+KB/RuH9lSL3jN9OMmppN5W1c9PVUcMJyPay1SxBz2rAP2Mpoi4Ipy5d6IpSlq
 ilQXNFON5Vf4e1JvaUUoGmyeGyEMgMKXO7Kc0sRMF+nnaA/Gmfm1cLupbzPHCv6KTBcb
 Qag2tNzhjO7pDMhr4XJGVQJKoUf/JmznfFcyM9sZdhOMNSXjqn/4cDvqSQMDdgfeumxX
 YzSkDiLK/SYlFOSA3USjOPtjRkbo8/xoI00eZa8uWaLbnWk1nEkRkqGWe5qMg7pPI0AX
 LGymqsusnfW+Gkum7U24dr0XLlp/WPAtCPk1xKsbVr9srsqK8KMne4sE+izPDUoissN7
 mZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081279; x=1787686079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fr7MXuQrc1i4cL+zV+WsxBIJSHsVIBvUZ5NQFGRvg7w=;
 b=aafaP34I2CK73snCzWPOFMhxndYQdjHicchURnazH38zB+JkF0JIk3gzJzNW7j4yRt
 Mvubl+BQgT67oGwIf/9I7EZyrae5cewDIawUk283PTN7qz+dvtFywfBvml9GtZaNbuWi
 Nj4WEBnSlRLofy58TldKO+pSCwKTJLqle/AtX6tb+2iyFckXowwC57/MnjF6YFvSWP9A
 mWck7N9HiNNAKwBbviN+sHq+AizHc205XYK2fFSltYl8x3jO1HyA3im0uYBe4c2kvYjW
 aAcMBH38hf8qr1GXxpXDE2VBJb8Lm1iXFY1EUVxeNG9P9QI5E8RjUj2F4iDYIiJ7mSqV
 32VQ==
X-Gm-Message-State: AOJu0YzxBGyrqP4WyJa8TqgrfKxWmEdTDe4cyXnEr/IwYLIXwzYwrlWR
 gJv2VTUXFbchYKnAp5mb9QxMy7f/0NMwDxxtMwy2eFqVce0ah2o53+355JW5TQseQkIaGK+CJwU
 8qEeMO4HUqOdjc/vYa3jSMqCgpaYozC+ICwuG2sZX94cRFegTtpgn7oqGQcKs5eB3vQ==
X-Gm-Gg: AR+sD125iilVCttg3CoLTXlizIYv3/eJ6s1cKyqsrlMdNe/yfgpOzwpyHGmkT352XbP
 gIwymvHgVdCYZRp+gmo6+zMGco1Pf1gvLQYeOCi8V8VQIG8jfCAE/cKM3uhNKxgk+7P9bKAMI5V
 YYSa8FK10m0fByBWey5En4FGBoDC/khQTJKRVsCn4Lrau49l4q7264d8VEwis9X0PzEHr3zNbn4
 GZtdNmHi1snG03wRZg4IBrBWaRXhJi3e1jQNTLnAZ04KcJJHXq2POaaMEgAq6mOWD5tr9gWs4rE
 fzBo/cGmwsWdkEidV+x4yArV53VvKrJWu3lxiuv5kp7aF/dDCcM5kqw1M1ExUeQS0+Dgx6TcKFo
 BinYPUkDR+nHwHfmuQagFfgderLWseUsfJnGY2hxFYgDP3yeq8+lvGBnUwto=
X-Received: by 2002:a17:90b:3910:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3957b8be8c9mr20944a91.16.1787081279469; 
 Tue, 18 Aug 2026 12:27:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3910:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3957b8be8c9mr20872a91.16.1787081278976; 
 Tue, 18 Aug 2026 12:27:58 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v7 051/104] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Tue, 18 Aug 2026 19:22:15 +0000
Message-ID: <20260818192309.22169-52-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: h2Z8e0UrdIBnhXqfX8YyTHj8zp-Wqkw8
X-Proofpoint-GUID: h2Z8e0UrdIBnhXqfX8YyTHj8zp-Wqkw8
X-Authority-Analysis: v=2.4 cv=FeYHAp+6 c=1 sm=1 tr=0 ts=6a84b240 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=rodC9k6DH4pmb89SaOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX7/SN3nV9AtGV
 NmM2eKRTMRA1cLYwCXVc5Zt4ps+SqEri/zz6p4lz/ftV0e5kerIrQj04r1WZ55vIwT+OAByNryJ
 H9e4XBZOr7uSMhciwli/l7LVwCQgFTcnA6rvzSaoAJxZB3+UO3nExeIUMcD54eMfXk72c5CDRzU
 6hIZSk2aQ9Xh0xK5pc1iHSYtnzLIdmabGBMJlxk1wItnN2fpj5PRryz60zcCKII1jD+fASZq2Ss
 psVB7hF1g5j8SKCeR0RxkCr1iNH0sR3do5a2ui6orR+vqo6Th1Yl2mk5YuZido44dYisjY6TArF
 BHm8XgTKd6qOm/W+kCrj9vBJ6WPg9hmB+qIHhwbgMCfU8YDeyOlOPGn/YKluikeOxMCxccPnZMb
 7lYY9gj7b3hkNZqLz/mFWtFq6NLN0ZF0C5+OsplnrwoQdCZs+98KznWZeWF3o3KGUvFvLvVCXAF
 9b6SQG+qtWSRGE2Ps+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3N+jjAgixNtV
 v1Yt8coighS+gqi3h8vm9duDU7wAXynA3nPp/HiSbiy1pHdtWUBvm5YAYsXlrzAwvZrPowJm+aq
 zGse31Qw0nC+qc3NkuwjCvINe22hDM8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Due to missing endian.h header, BYTE_ORDER, LITTLE_ENDIAN and BIG_ENDIAN
were undefined. Thus, for following code, the first branch was always
taken:
 #if BYTE_ORDER == LITTLE_ENDIAN
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
 #elif BYTE_ORDER == BIG_ENDIAN
 ...

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/sha1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..0fcbc3ed605 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -21,6 +21,7 @@ A million repetitions of "a"
 
 #define SHA1HANDSOFF
 
+#include <endian.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
-- 
2.43.0


