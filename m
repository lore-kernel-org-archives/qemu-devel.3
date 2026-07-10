Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34EDC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ6H-0007KJ-U2; Fri, 10 Jul 2026 17:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6B-0006XF-VI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ6A-00054l-At
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3gDk1846455
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=; b=CNXlMMuI39VuCV0/
 ml4gnA+MrnwHT93j56v5BoX9JqIDf42WtuHsWT+QgHW4nO+g7eLl38Cu+2myRqlD
 lE5Om6Cxi9llshTuct2W6+Wj2tCD/+K9GBGwBpYu10RoKcU6rDTY8hS2fTgbfnjA
 WlLZaIVurhCBP/YUJw0FBNuYdJAvWFzaZpDNq1CPqLbB7DoeAklXHa0jO01/qHTa
 aHz9WNKKBWhZ9aAGOwceqUwTywa4CvgHVvUDy3L49365v28Bq9af98UWHEmAKxzF
 DrVVX87ieP52KmdP+07u7feVIw5KgvAINUxKKI27LKsoCdczrVF0B2nEs9a3C+Lg
 EweV8Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rjrt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:49:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ad1558f4so2723641a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720158; x=1784324958; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=RcaGmlyO0cPXiXkorijYMKWSx4p/d3SFMchi/WhDFPGU+YnHiCH/xYWZvQwFw8ko+7
 Mfn6CRJjJs2P94VJRMXuoAj5IYN4cKw9Fo6+cqgzbd21jDMkn0ag6X7wpIf+Nh+Fv9T/
 N3N52FJ3OKc8mo8P1no6Ht+uomWHoxNAYpsu4rCKS27YQtXNJ9bYH4gAYmV0Y1bgpYuy
 aDQ5nTyZiFn63j3Y6VODGwqFf5EhyGm837yP7a9DSbAa2P1eCSL0gXP8fl3raFESnACD
 WRHkrPtlO7z0isEFcA7thByTWg1kK7SGr9RcyYYjtG3M2m0tDujtcOdGTYjV4cgozwvC
 6hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720158; x=1784324958;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yO0XRw45VmZF22dubUKp99vq+Uw1GFaCoUGTKFHYlY8=;
 b=jogwM3YQxsBGDhZg3qv8oNuq4TDmv6BjL/Ic8T1qOdzEwj+5PgzlkyM3ZPNkSsgm7M
 Alb5WoGrRFucsQ0b3GERTQ2+3HBslZSG1IIrIfXDrBtipcrYixi5PduNtH9zcisQImAA
 Bzs8VDLDS4Bu4gAhM8Thr5jWXGP96OI7OYHInly3DhTvwwU+F7pgceS9N465mXGOPdts
 LWl90tXtZ/XJmy5FTzS1AloKmwIC17Ivcrxgkz712/XNeRVBMAV1OoL8y+xn2/cb7sFD
 JCKMrVCXh60uoc4VP1v3eWzPjHxOn716WVCurlkrWjId9on2HG6tlVGrscBb8v0u9p38
 xGFQ==
X-Gm-Message-State: AOJu0YwZa8NVwPXdwJoTvQKKTm+u6NcfPBTvWtBu/c/rU/xqovtk22IA
 meDEx3IO8iP4Ib1G4SpvQqp74jcUE/1FuZA4UPucHw/VHHbYGrnokFLbYjPGFnos3xdsI6dKwCS
 GDBrh/+Wv6F6+4hl8Se4C+ky8kSqpmG73tuhQW9fcByaldnshzDwzkjWaGl5p1pNYhg==
X-Gm-Gg: AfdE7cknIgk/E4YR1nJxYUIgjIiodg2P+/OpZJL8Nv5YW2KfvKApJx2D8u0hnlDa/+U
 RPEwSVJIQFNU1b044yxtaIuN2/LBCkxV1J2ROQySUOjNLfKN7eb0GqFTc26dbt6OhZPJYmuvvhN
 gjhKCLbpu8CTElTetq80EuZdngfImMOQMebrn9dUo+vlDSlAIRCYSzOioYbShiTP2xNeKzI2EQa
 phCc0CpVdVnXdpEhpYPN9pRN4KjsXRmvC+fMVSvLC4odePmJrUe2nTX/Ce3s1bBGhlzSR70UbwZ
 OvZQFsTGxnSqGcbZgOx/lPC6A7sp3XBtmu+V7N08an3GzaOdwHAG+4jbU8VoIjBlMwZt6q569oD
 oD6rbtI4Gu2iXWn4ywfdxTfTL48Wbbo5dCt9aTzVBb9G/QrJeAi/VBvwI7Anbd/CrJsvKG+Ih2X
 CChK0C/w==
X-Received: by 2002:a05:6a20:9190:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3c10fd60400mr805543637.0.1783720158236; 
 Fri, 10 Jul 2026 14:49:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:9190:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3c10fd60400mr805517637.0.1783720157824; 
 Fri, 10 Jul 2026 14:49:17 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:49:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 67/98] tests/tcg/or1k/test_addic.c: remove unused variables
Date: Fri, 10 Jul 2026 14:43:11 -0700
Message-ID: <20260710214343.2065491-68-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X97NfK-Fq7rFbDbW0q1BSWznr50PEuCC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXzCPPdO4BnaYI
 YTtFhau+pJI5At2lMDP7YdXkGMlI99UfoX3b4T29609ktRa5UV0ofY8edb9SE6XZHrLsJZYBtOX
 5SsmD0Uw+Cuc+cBGfm9zJnL1b/08VBCeUtn5iJCrSmPzcFIiAFbgN7NYTqW++iWbcfZj+lwXinJ
 Ol4cwCatVCOFcplS5YVMu5i49k+y6YYCev2UkXcllASr/5leLLDU6NqGe8I7dO8gIdrsZl2uhB5
 l5ZhdlHzMrsHLoJI9PmlwFrWS2BwTJ2w7lHhqVQWwY9AK7cS+KhghGqbMTmU0o9DNMM62MnhTBB
 DbaA405K5RV5rfZA/5DgyVSqLQd90KM7xBGxx0Wjteu7CrkLYsZAMQyk+42tisTgLKAQyekNdki
 5OmGh6kHSuO5uqQFDZFciR7J8g4GDWvZ1BWJSnauBC4E/CjB97rkIVbDBNETCzPckqPFty0hRFs
 9hnkpurqA+/xRBIgWnA==
X-Proofpoint-GUID: X97NfK-Fq7rFbDbW0q1BSWznr50PEuCC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8deaSEaVT45n
 MWWHrMeds2DxgK01x5ISvj7pVOJan0IfcfG/o2T3ozT18tNK4yYmNWveAW8pRwktMZKDZEcJjMJ
 hqUzxPgppE8rw0xV5PE+bBW4doK7GCw=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5168df cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_addic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/or1k/test_addic.c b/tests/tcg/or1k/test_addic.c
index 857aaa13302..27939c64ff1 100644
--- a/tests/tcg/or1k/test_addic.c
+++ b/tests/tcg/or1k/test_addic.c
@@ -2,7 +2,7 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a;
     int result;
 
     a = 1;
-- 
2.47.3


