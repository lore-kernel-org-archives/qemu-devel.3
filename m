Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1E606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lNfcJ1T4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ANdkArEA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwT-0001v5-CT; Tue, 24 Nov 2026 18:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvl-0001BO-En
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvj-0007es-8i
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:08 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaibg2558059
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yTzd7U1HJfrjS20130PWcfZ767uaT1PsJnJYGm4elvw=; b=lNfcJ1T4AgLYMfSc
 nUbYkYqKqmLnlAygRXiTMw2b9gICsczfBTuTkYMM7MH5uyJkOdCEY9YBX0BbFASJ
 ZuJD1lfaXeAUZsmqsJWZOIxUp35vUzowltNjDydJJ61uUZYDA1EWn8zHWYI8Yi/Z
 B5VEoA3lTlgwRBVZ1TXnp5hTm7gQ8zGcqIPccESTb4l7hLYcXLqedhFUnJfdX025
 KDeSmze04bmOtLpwn6rutmU7Oi0Tk0IMF0nKV111e//XGF7YGuNqQybAbxJkgTfQ
 RTqaj80lX+jH6CUPDxJe72jruXaoevy2/E3d6p+nW6CuSeiphDR6ZLGF61RyLtKP
 D+dIQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnghr0x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94961511b61so854556685a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562884; x=1796167684; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yTzd7U1HJfrjS20130PWcfZ767uaT1PsJnJYGm4elvw=;
 b=ANdkArEA1y6EkZQng7b4l7ZM+KO0gq+VnLaxNcQNWOayGWtXMtJYrDdy1wIZ1Hd31a
 cr06t9WRMfZIISRWz6P7R4mnLAUxBTJXNtbM4kAVVx+Lwo9ccFnBx/o9a2GW9OaiqMdR
 AekkBujSztaD74cPapRlaRpSLa6c95nWFcX0ZJ0eXVlLMwi4XThj5sPTOoVgyJ/xM7A7
 fcfdt/pqhcyqUcQXinF3pU64tGVg02GbcQYggaq2RJFrIQrHnsHTLbe/PMwNrh/igp9u
 5KdBgwgVXwIQrKk8PxoZQEBG/ydtptZ2V3S+0saKw/RQrpu4CLaBCFpOu2n95Aq3oX57
 111Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562884; x=1796167684;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yTzd7U1HJfrjS20130PWcfZ767uaT1PsJnJYGm4elvw=;
 b=SoGkTKNSKd4Sn4nlDtJGDhzXQGyuluDdZn67YOXXcDHN5PVfnnZ3V3wPDCEaxjRn/a
 6znCzy85orwZbT/cuSU+MpBUMxC3MOQwB+ruGPoxo+aCvG4gRwf0iTRAJQXyvvVwszbS
 B2a+plnQBlEQI367nkYQP5UdpJ2i5QDCiM2Hgz7l+SSB7IptsurUjZmPcYYllhAJC1Qe
 h3Q4U6z5Siz1r5MkeXKM++7SWR9aDFOBLj4jCYp/zBQlg615pqVz2Qz4qAmMfn7pPfsw
 wLJwMiM1REQMujhlaMLYd6wvtd5GS0wK6koOtSQz9L6anpsKddzgf4z2ZYTBfxKg1Gpc
 wjYg==
X-Gm-Message-State: APuU4Z/L2NHQHzleSYYBSgnuZ8HK9vnJ/nxjxpE6I5URR0do0DmgRAN0
 fO1+p+7Dxu+8FXeo3RIedVhyTcOh+kZ3hzGiIxzS1VMp+AkKo0wbo/SulbkhW8v/3mphk2Axsaw
 27i4/f7xQ5CoGVm7tHQ5ViDiaYS6xScvNHAvHsE+hKTXcjcCr8HuWJVQTc73+JoIIKZS+
X-Gm-Gg: AZFdTZfYcTlxhgW6ch4MORax6olroWhydnC9SjWWGABizwLuhbdzAn1KjNltCmjIUKi
 zjXqhlPzz/+PiGAJRz/AmXhTCMzrhSWkvGd4fer5++Lkn1DqS/K/bKoI9opbEE3/dcXoyfpKEYH
 TmGdZ9pdBB8QklYA4UIEBMPhmT06gaWgIcMYPsGHA0+UUaBdK374YlwAamCKxSy0EMHL0xsIhhP
 jxQVSLXn3k71x9S9gsQg4tMpzgqljEoInPaR9WQnN34h83hmTfiaxnnEyRiG/g8T0QILCEW7Ias
 zhG13z8ji3NzMJW1DxiBsdwe/JUGC2QUuGvOC3kmDEkoC1XWtDFoSU9kcbYOiF5KprkdLj9Zoff
 Mw7KjC4Db1x8eREqtFs4mNG+I8lHWysJE1zN8GXHgGTXBUF+GiGL/8VKoefAPupYHgJ9W3iKFcl
 PwmjIlguyrQb7OwQ==
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr2776433885a.32.1795562883663; 
 Tue, 24 Nov 2026 15:28:03 -0800 (PST)
X-Received: by 2002:a05:620a:45a3:b0:93f:568d:ebbc with SMTP id
 af79cd13be357-949ba98e6dfmr2776431485a.32.1795562883238; 
 Tue, 24 Nov 2026 15:28:03 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm31990699f8f.29.2026.11.24.15.28.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] target/ppc: Test CF_NO_GOTO_PTR in cflags,
 not in TB flags
Date: Wed, 25 Nov 2026 00:27:09 +0100
Message-ID: <20261124232722.90234-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX9avFCSJRn1JP
 Yw7WppzRDMe4H+ZXNC9/hlT43wnxCbCEridbImSmzs+YL3hMhuSOcpSD2vLGbNbc3oPX7ckFqI6
 UAk3irSIVAE41QRH642vUuaoQYaSES4=
X-Proofpoint-ORIG-GUID: wDtVXCyYxX6mX4yuYgObiv4g-W3UYQk8
X-Proofpoint-GUID: wDtVXCyYxX6mX4yuYgObiv4g-W3UYQk8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX4Vh6YzkjA1Ek
 DwVa69JosnSkY+hgar8JahGHpQKJp9aNISp1f11NegekGOlH8bMnq8MKbuIdSbmhpup9xofBfvm
 D0/hRxS/MXPhew67S3WxWBy590EUYJaDOUdtmNGeJhVhNxFnbmg1BlebQNmHMe4hZkQ3EnpabhZ
 jP7j8WJqvI4i4QyfLzR6Q85EtB8NbkMXc+enYFJJFvybh3ImnJqwBI9tMNNmaTEF9ekZkkTRXv/
 LXI5sIqQb3/HdXuf9JHgUa0F+JqdL6jKcaWarRvdzeNpq6FEZWYaGKEuAaRXIc66Q0C6r8nqSOK
 BJayOzBnZzjmAAODs1v/I+kEGbrNQojmTPCxuV69VTC+vMe9ib5B1QMSaT39c2FweiPd+m760J3
 fhvEfzTbB2OZJ7DYNwWeqHmZSv34fIhnQor9hIn907+O1riLfYDmfQefA0Bhk0FWGqjXx4O7XrF
 3QpidFaTukrP4+U7a8A==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b061d84 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=KOFfYGMdUDr6h6J8HrYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CF_NO_GOTO_PTR is a TB cflags bit, but it was tested against
tb->flags, where bit 10 is HFLAGS_SE. Use tb_cflags().

Cc: qemu-stable@nongnu.org
Reported-by: Matt Turner <mattst88@gmail.com>
Fixes: 46d396bde988 ("target/ppc: enable PMU instruction count")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261117080843.8314-1-philmd@oss.qualcomm.com>
---
 target/ppc/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 467b8f3d4ec2..dccae25bb4ec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2645,7 +2645,7 @@ static void gen_lookup_and_goto_ptr(DisasContext *ctx)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
@@ -5160,7 +5160,7 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
          * tcg_gen_lookup_and_goto_ptr will exit the TB if
          * CF_NO_GOTO_PTR is set. Count insns now.
          */
-        if (ctx->base.tb->flags & CF_NO_GOTO_PTR) {
+        if (tb_cflags(ctx->base.tb) & CF_NO_GOTO_PTR) {
             pmu_count_insns(ctx);
         }
 
-- 
2.55.0


