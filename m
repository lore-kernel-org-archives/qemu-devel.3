Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E8CC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNH-0007d5-0L; Sun, 27 Sep 2026 03:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjNA-0007Qu-Ao
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjN8-0006W7-Lu
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMiqZT783927
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K/wnIvYnAqnLa1FrO9t5ONeMwdI4mXlHg3asUe7i180=; b=PF5k0LumnXQVJq3W
 QyHNGJCqxaqjB4isvM+LS4KuITdRfl5tm8I1okvWx4Vc0ahCnlguzrL0Rom8igQH
 ZZRheAgdNObIEQ9ZorCWBazNMbuzoVEBUfTJpN5aJ1b30dlXtcoR15urD12z79LA
 /rBg95YZEtEii/MhSwffMryBZ+FR+BjQBbHzm2bNtFphKTUBsIQ2inhoMmbe/oPH
 7VrnGuvSmGmkRxg7PKaPy19JpSJRnhRFpEuKort+B4fYGET/JO0FStGnXDiAECZg
 lhy+cqunpF8sSMgdfpsNOIFjMYQzIUasjd/pPYsgl6To7j//dzSbFPNnNdp7d+fu
 8klQMw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cgjmrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390a2c895bso636500785a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494346; x=1791099146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/wnIvYnAqnLa1FrO9t5ONeMwdI4mXlHg3asUe7i180=;
 b=Ck7yakIBaPTy7sqod2cskYyAi1ob1gv2PMNMIs4Mrwqoxdk0JaG+iY3eqRictTEEg7
 Jick7mmNtqdHZeWzLUuIhGNivWWSPu8ZAxe4caeBMUoZi+j2wVEV1LnzYf1FO45dl21y
 sgM6/pMSEwx/hKClqKhS0ZqSV8QkMLwutqx8nmhGu98uXnocheW/8GO7qFGi9dYxLAVW
 xnGLC09dNjdzbg9pl+GKDZVI2JQ9kU30MVOYn/gKzQMyFz+bESCA0UvJjEVs1kS478jS
 +hclVbvf16QGYgQpR7MixvU2CI3IbPxeomQOP2hkO0Nj5jQNycjzjSBEcUXnXWf0r2BT
 tg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494346; x=1791099146;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/wnIvYnAqnLa1FrO9t5ONeMwdI4mXlHg3asUe7i180=;
 b=YbYGoFH4gm+ZGrPKeF8wWdYDzjc86DlsQ37/g1WJ6B/4B0PhVXfTiDz4NKAcj1n+GP
 alxfLIRmRJf+9JLmG11bCG/xN/zTqbREQ49tMEc2Ji4iiOj8oRJc+L3TEugyPacJ10Oh
 HethwP6JULuSBCS3hhPt6K/KxRMFtakZEDegYoQxHTyWumkZMPixySCMl7Z7kby2a59g
 gmocUF+LC7BG7BNsSS0Jkiwby8MscyjZp/vIKHuf2LGPY9Z2RAA0QUG3OBNPhKy8Ub1G
 o0AToNJ3X8D4Cz91IFz8/VLBPT4HQQYi3mLWUTTeU9kAXX1ixsu7NcE7YjopFK/l7sGw
 EDyw==
X-Gm-Message-State: AFuF++nswSL4g5Yy5RxGz8gjoyXaPQhACSPVtMuJ009Ty0Fr7T3Jy3QU
 i9KA3Knc1S/avd3Vcs06Rv9owE3vDKfCxkqabSWo3UwHba/QAYWk0WXhUE0HmmxDT/R2BdgY3yj
 W5iVqqpqi0HaGgrYV+L2SFpvkYq4IXrctEvo8/5JeJSy4IODyNMOSEbucOuao1K+Bmw==
X-Gm-Gg: AYBFou2yoNAE6LqzRdL492JKo+EJwUmIkL2eSuSsxeMOSIKrr7z4nP1lgh3+IbfP3GC
 Z4rkdY1mwQYHcq1wBdYAe7YhTdbS7RfJoIPl5Y3G6S80UJsWHSQwYYYG6N6HFil1QmrtgQsDjwa
 7xUbDPzTkFNJVwcsBor7/V+qXCGiUlRlorZH/jjm6MbbXL47PEEtBdjT0MYBwlHUQhUeuZw4KG5
 KY2HtmdEeFoz/x4Z3gvKk5N+XNgarkwYfzHGZouS+lnK1atXn0E3i+EwplEqa1tnn538W0KU4a5
 2r+27P3NgGqY9rKmelASdDSB3mOplM1Z+jQU1WtkfrXaaa55zNtHh0WdOjQMdTBvXc+IGh4IYqK
 WOWEuXCStgL5Q1cSVWtuqpYIYaLuFbOwyVWXjVG+z
X-Received: by 2002:a05:620a:25d2:b0:93c:2ac6:37d1 with SMTP id
 af79cd13be357-93c43e4807cmr1380691585a.49.1790494345926; 
 Sun, 27 Sep 2026 00:32:25 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:93c:2ac6:37d1 with SMTP id
 af79cd13be357-93c43e4807cmr1380689385a.49.1790494345330; 
 Sun, 27 Sep 2026 00:32:25 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f3e68sm36666575e9.9.2026.09.27.00.32.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/misc/bcm2835_cprman: correct register index in test for
 mux update
Date: Sun, 27 Sep 2026 09:31:37 +0200
Message-ID: <20260927073140.41422-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX5OePA86SDMJV
 W8WRallaWBZJUmItLUv6WN71T/10tFofmEGF1QkGMmQHOZaunaupl+37Jn283f33vjDImwVmGfH
 6UNbDOtkUeyQS/j1/I8UZV0rfhZ+BP+ho8JpRmrOC40URGX8qxOcGhUGCT7vtxa8U6YGlJrvTqa
 EiAbyhkg+PI99KQ77/a1MXn0MkFWU+gZFha0wvowwB88tMCojgYEm1L8rYgKC8rISf57FwHNCwG
 9r8j7xY25JPAAhwdNQH+dLv+CGLKYaGU7Cf2Mw9Vsqq2kSaywYBgJKriWO+sipZNuUGycgw/nGd
 Z7nxAUCPPnCGX3myXqtcni9Ad+dkh8iWRRPfzeKbF9fnAKpsXTmEBZb/ZPW1f68diqhUsNTsYvs
 cokFVZrQIXCVw+6/xI+3jyVovhJzSvQNfmN4wvLHudz2DK72mUbbDfOGlh3Z0T4E0mX1J3P/ffH
 XUso2c8MJi8MFPzGlcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX63yEKBIsYQKI
 Emfs0M+bk3NKN6y8cnBh7ERo+tZJ+EvEXLPM4XdOKkAwiv6Lw1Ldd+H3yVJPJOdHVg6Bp/I872o
 KAJkxVjb8I5IkZ39J481chXOdvz0L+I=
X-Proofpoint-GUID: jgj8Do1L1jO7wmNi2KqJqd9bGA4Hjruq
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab8c68a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=-ISfGIX_AAAA:8 a=EUspDBNiAAAA:8 a=gTzq3umuov047XrckY4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=6K80JWTZPwV2TOQbRzu6:22
X-Proofpoint-ORIG-GUID: jgj8Do1L1jO7wmNi2KqJqd9bGA4Hjruq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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

From: Jonathan Gilbert <logic@deltaq.org>

After each register write handled by cprman_write, function update_mux
checks each of the clocks to see whether the supplied register index
applies to it, calling clock_mux_update if so. Each clock has two
registers, so it needs to check the base cm_offset for CM_CTL and then
the next slot for CM_DIV. But, it was checking for cm_offset plus 4, as
though it were a byte offset when it's a logical index.

Signed-off-by: Jonathan Gilbert <logic@deltaq.org>
Fixes: 7281362484a ("hw/misc/bcm2835_cprman: clock mux skeleton  implementation")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260925100726.1546566-1-logic@deltaq.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/bcm2835_cprman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
index 8220f7a6b4b..f9a77ff9bb0 100644
--- a/hw/misc/bcm2835_cprman.c
+++ b/hw/misc/bcm2835_cprman.c
@@ -508,7 +508,7 @@ static inline void update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
 
     for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
         if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx) ||
-            (CLOCK_MUX_INIT_INFO[i].cm_offset + 4 == idx)) {
+            (CLOCK_MUX_INIT_INFO[i].cm_offset + 1 == idx)) {
             /* matches CM_CTL or CM_DIV mux register */
             clock_mux_update(&s->clock_muxes[i]);
             return;
-- 
2.53.0


