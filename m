Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBA0C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLJu-0002lf-JV; Thu, 16 Jul 2026 08:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJt-0002lP-Hl
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wkLJs-000768-1P
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 08:36:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GBiSoe2824231
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=p41eQAD03Mo
 g206u+s1DnOIZYXGjLnr4ZfV6a5KwsaQ=; b=LVJjYPHJ9/zFzc86ccFvfnkKAiY
 0NB9SmvWNkJa+SyM57bXybDu01/1YN/ZjAPka8CYJe+gnmYNpJuipOi3BSwGr8rT
 ovlHLcsVhPG992Ipxpvhsl4Xf8U+ff8XJXJGi8aleAw8mF549iIOQlXlIWItzhdb
 h2xX/rPC90EHx6X61o4QbkKKlXq1eUKXdZ9d2ppMOgOE0eo69Aw3Jnv/hB5qfXDS
 uO9q8mdZ1v47oNeXRJgR9DM+yfg16AzoQLJ743GH/iwdXY7Cp7XsC5gAsmVo58lA
 XoLhOLWs5w9+/qfOQtTi4cq/yhhEnLmuROiJ4AmvEkXtw/7lfKE6Xh+E14Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetcf1bng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:36:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so1194284985a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784205361; x=1784810161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p41eQAD03Mog206u+s1DnOIZYXGjLnr4ZfV6a5KwsaQ=;
 b=G9X1oEAqr0HeKaSQ2WhlnGa4UJXoOm86FyKhqoUE2b/GxCtnWQ+XejmRECIE4D5vgR
 RoGUlnqLA1NKTFkx7gMFYpShY1tCjKaUwUJj4GlwKFiWgFVlfGXHu1oUyRwx5qcLmezQ
 N6Km2/e7NQK/BWGCJ58wtiHIHTrX+UMsBq3l7/HhlqYUFgu3/qNftGx2ZCXsSvbAIM6x
 J+p0Z5uVOF6xPxj1twpccyCh9xrtNCwnnRnvRjxXTEsMQYnxNxwIfQeVeYgsRrGNBSwg
 U8tz3/fbRuHAptCTDeAq/q/uPoQlrKjTBsWE0fln7IZQbhmjcKoXIj3AYUmYs9+adYYv
 dbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784205361; x=1784810161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=p41eQAD03Mog206u+s1DnOIZYXGjLnr4ZfV6a5KwsaQ=;
 b=ioEslQwMs/mjeOH8gBxf3d3hty+XdZxvV7CIx9wK4TkGGBLrH9MRbvq7gjPZLSimpN
 gMPbjpAEi+FvgwlFqFT+ZPMW914GSSJ05JU3gMMf1RwU7RDim62sGD5z3WRZDXHr7f1v
 qk014oWb5KfwE6bE/vghSaQZkqOmOAveaTpir45aAQijw688fWCHgAwnkKC9or4ERD4K
 TipSIiDtXKk+Zl3cAaycfmERnb9dIHUObtx+TZCN5nSh4o4XVxMfSCOHT1+kkz/N+h4G
 +Eeop+zwqV3Tg8O5N4szW3UMgYv8rNqL3+3pe9nFGQI9ZniW1biKA4f5NN03FgI4wDzz
 S23g==
X-Gm-Message-State: AOJu0YyMA0nX8WTkgc9yEeGJHajQA7rEvWP93DzTP3QLV9gGUwqyLSWw
 Teg8VULiaxLd+cl8l5iOwX2cfibFkKseH2xFDgrNZ8I8kHnHG9Dfs+QLuS5lvXnWF1n5n4e3JDJ
 ULW6AMwYakYMoMVf0KLkOke5SEPllI9Yi6xZm02/iP21Yz1tKMh08o24jjUH35pdoGw==
X-Gm-Gg: AfdE7ck7zekKQo3JWsIGOR07fMP+glh+qlomuAJFdIkIWWwf+n3Imj8wdljnK+K6GZn
 d+fiZVEs0+GuXJXrU7xNx9yzzE9EnAAoIvgPil23aq+l/0IInLtosM7HoHcoVilyP03FwPobzv6
 gDAZW552Y+apdK1zHM+ew5whkQlCQJrWrzUnPWkWuFf0luya2RGQArekqOhFLa2qHvF97L0YtHY
 onr3B3EIKR2oY5PlYB4/19m+D1sYMLTBYTSH1tFAX/C4NjhZ83w9HeTCA+O+K4jm54a9bcweaN/
 /rGkLb4C7UGk9o7Dp0S7hrq1p7X63yqQVY+MQiMiFnK29X7H+BZAVis+JqBvKMK5m43DpsixalX
 G9m4/GDb/lIpo2unQReaQA9qAnVLvN49oa0c=
X-Received: by 2002:a05:620a:470e:b0:92e:cac7:9706 with SMTP id
 af79cd13be357-9309636ebd5mr786544885a.52.1784205361077; 
 Thu, 16 Jul 2026 05:36:01 -0700 (PDT)
X-Received: by 2002:a05:620a:470e:b0:92e:cac7:9706 with SMTP id
 af79cd13be357-9309636ebd5mr786541085a.52.1784205360666; 
 Thu, 16 Jul 2026 05:36:00 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-902de1fdb3bsm191609316d6.23.2026.07.16.05.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 05:36:00 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 npiggin@gmail.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH for-11.1 07/17] target/riscv/debug: Fix icount privilege
 matching icount_enabled() test
Date: Thu, 16 Jul 2026 09:35:24 -0300
Message-ID: <20260716123535.3709148-8-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
References: <20260716123535.3709148-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4rZeTTBs3ueryfjUDK9WG4LwrD0ndeQo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX2OdjhKCPqZV5
 GJTsd/sMx8fZHSOim/iPAUISwrlFCd9TvswiKsOsFaI8F0gdDcwiWdlSCrs/KTR0bi5FR8pCPYJ
 Rfn8rZMTzoLO+aZNllGN9EJppmg3gFBeYeia4bcf/SnwNq7STk6QAuCJwXYfXmTC9UfYkmlDgzK
 71prkF1g7kfoFfqMGcA1N1x3fItfnKVu2H3YVbOUuz38aEkV/buUNsnVsOA9an+gQ7L7KUQKIEw
 LUrEalugtqPwKe5NPcURCQT6N7H3z+QrzrJ2QLindN9Rq+qXkT2Q1Lw/YjDu9ObsLhyiIXvxTmW
 vC351uZ8F69NVQcWGygljjDOLqd5qz7PZyKSFPYwyeU+Y6NIOPooGePX9G1KtVTCpJ/6aSc7hoT
 RbiLqphgcIRb6OOV53SJVokVt6LgdwhAcoSNdQ+TF99tnRdM0Fqf7zCqHVyKYsH6Kw2QqaDb9wU
 l+Vy0vHRHVWmZ71da6g==
X-Authority-Analysis: v=2.4 cv=f8R4wuyM c=1 sm=1 tr=0 ts=6a58d032 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3jnf9fXNQdWrf285FekA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 4rZeTTBs3ueryfjUDK9WG4LwrD0ndeQo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOSBTYWx0ZWRfX4Y63svIVr/n6
 sFyC3Zqm/eONb7/+NCptG8IGT8Ys0dxCCk8v2KWuTzqWiBA65Zlj+FNYa9uNCKWZNJa0l3XdntQ
 k6vw/mIFhmpdSFxLyTpYjG95NPX11s0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

itrigger_enabled should be set if the privilege does match. The test is
inverted.

Fixes: 2c9d747121 ("target/riscv: Add itrigger support when icount is not enabled")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 6aba7e9e12..3edbb591ca 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -681,7 +681,7 @@ bool riscv_itrigger_enabled(CPURISCVState *env)
         if (get_trigger_type(env, i) != TRIGGER_TYPE_INST_CNT) {
             continue;
         }
-        if (check_itrigger_priv(env, i)) {
+        if (!check_itrigger_priv(env, i)) {
             continue;
         }
         count = itrigger_get_count(env, i);
-- 
2.43.0


