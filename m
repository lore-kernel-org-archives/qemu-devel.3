Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C1C61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVr-0004Hd-0I; Thu, 27 Aug 2026 18:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVp-0004DP-EP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVm-0000Em-Pa
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMEUK236501
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=; b=Ve3Fht6WChx1RsFB
 jqrG6XmF8M4adUuIuJZXLyMX2OXmJyXyZx0k9RL2VUntPLkviwumRQ0rsNRl/Q47
 nG5hQ+BeGMSkKvDJbFeVxq7KcORvedstNUy14wKjGUhnnU2U61+bSipdRc5CRZSR
 3hRCeFd097ubSXnNyfIq/pbcKQ+UIcrcZGn+9GBF1X1aVkDn1meJlTlfMckKYAmq
 MQ+2v0K/aAVA9hsrsKKv2AUiTAk80XoG1sPufL3dgNCwnT4s2kUWFAXzBQwJgwLr
 btEuc1pS6D+4fgFhXPyxcB1nVvNE5axIn90bWd2jULVNWrbq6zgEWHgQjax2BEyC
 PBwBvA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgujb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6fb956002so2304365ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869423; x=1788474223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=;
 b=JX9waOfAhwOYeWUpQnwdaRePCo/QlalR8fi9KWOr804k8OUeiFCWKVyac48E6TW/AR
 sI7uD8mmqvtXozu6VKmeQ+9wSKwMHLRqJFK4sIUax3nm6eYEcMSj9Rm1Ewa9B8LEt44T
 w+aIljWRtHvUlINskWphEpajSrBtSRlMlhaXkVXgcDCg6ZZpi22P9DhikrvtrHgG6K1c
 wMRsif+RLjfGYXdPPrfn8wl0JkJz2Auofe+dHxrT+sDyEhzN5jQFrbGmGOaIH50mWzRb
 THta7ovZtmoMnq2nRBMIsgC156ysQF5GcY9A2Pug7V24u4LP6lc0HjYRYor6og13e0bF
 6kjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869423; x=1788474223;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XtQt2ieJFZWb1xoB0jrT2WpOM+4E9cDdpjQLfHZUUSE=;
 b=QFboKlrQ5r0GS4sEtsuDrHwrOnVJfHPwn2StwRO6q+dPhodDBiKx1C0cSZUNKfmkkG
 qhqNHysx/XKt/kKtlwQxqH9gs3HSda+ZVkiJUXQa4xxp7MpP0ign0JkRU9+CQ1lSZhbX
 jqQ3tXRMm5NTFgsmHrYYDb3cNubv1sp9qnAljpOXejjz9og8rocQHxrQCHSMOIGcqXB1
 Scc/sVhEE/E4nLU7vMSm9u/uuXIn6q1F3Z9t3faMYb/E0jcs9EbSHsRcjq0uzfhFnKoF
 wSjCE65i5iJQ33sSjqEgXjZgGoJmpfW/hOmJlpOk693/lFVtuG1qwETWocLNFIpptsTg
 PtJA==
X-Gm-Message-State: AFuF++lLlcrp+Pq+vnONhkqyLgA9rolRxI5AxKwFu4EG/bkPP2ckyZ//
 v1mse0JNMs++RmgYsuHplhqaMQqHe1a88eob+c+Jc8yhJLQUnhGqS7A5nWbHo1r47AnAKQeLd6T
 HrANDLWZp+4d8aH/XIREKQcjgKXTLTbhCEYs8V3lfNF0s2ONQu/Lcxnumwghh2MiXRQ==
X-Gm-Gg: AR+sD133yxNwn5FK6NQ0SMhOHVVsi/o3k6bZjByIh93WH08qOAxOLtYmM6+UdFe4tFN
 u5dFc8cpXYwZkiqQcFB6BcIeTBnL7i5yX0lwRfjT4C1eGnrbKMXlws2X3ISzxE+tbkGc1UUZ3TE
 wO6dOMCwnSq7WJ8I42ettpNBk8dJb8p2Xv4uzqxgZbXjzGGL8usdJucEOQMoUK2m4E8d7GNWbLU
 0htQ66WHdRRwcgiVqN6fUdNlj1AFXEH1KAknHONoSShObtXzU/iSGu3dWAM+CNcywHc+0gZE92Z
 uJ+o/r6Do+0E8m1aA2VKgAOqHmLSZD8WgHU1eLLHGAPiCv5nn9w9MRr6/yDgNk3wgspbUUgoehO
 Lr45fq2Pjgo3X5RqmppppnByN+m5weLaN+7x4efX/BOb2IOTRcc106tIgB3E=
X-Received: by 2002:a17:903:f8e:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d74dc53880mr42724565ad.6.1787869422660; 
 Thu, 27 Aug 2026 15:23:42 -0700 (PDT)
X-Received: by 2002:a17:903:f8e:b0:2d6:5beb:8692 with SMTP id
 d9443c01a7336-2d74dc53880mr42723945ad.6.1787869422153; 
 Thu, 27 Aug 2026 15:23:42 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 093/105] tests/tcg/xtensa/crt.S: align .text section
Date: Thu, 27 Aug 2026 22:14:54 +0000
Message-ID: <20260827221506.91574-94-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3-YiGor3qHuFMmriliJdndxTlVxbK6ZR
X-Proofpoint-ORIG-GUID: 3-YiGor3qHuFMmriliJdndxTlVxbK6ZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXzYJUiTP4simE
 onx+XtLdC854T2Uh1tDHXkMCljE45idRHvW8wPzF2lnuLTgneCaNSevhpNIqg4obdGl+L4GmSeg
 MXMkPr2VGZHNThHgSTNG/EP2ed4CeR0HUAvXNYkKrJz6SUNNkO/m66RGxVRHpgnOD55SxHiOGMT
 AnG0HG4iwsWOCuY8LJfrNdEkOyblHFQ0P4wfI65B4taGwzyVQ2l2//T3bxfPQIBnAII9Z6XWHFI
 c03oXRwREQ0fVTYXseHPoJq+6w/6+vkreLaXWGyV//JPLmu8FxQpMV7wtDtf6JZw4O7Q1c9BIkM
 wlQadwVAWXFVkf33kTPdVblS0Jmw0IMqQGngirUQ7wWEWKNWyrdmputdVVtUK72SvYJof43GlGu
 vRqe96fBuTIVwh1km4bxeuhg1IQsE8YKQheRW6EPe2KZSfyCnn9rWyl2a4lUWjgb90hRnPwjFfg
 0xi773yZOwM91ilDLxw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b8ef cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=5InQkvVgWux2XAX5AMsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXySwty1t1541o
 64RpXeUImhJ0WGuN4Y3zlAJTulUZDHwkOrMRUM17PQKTKo9b/yZevsCmBzH+EoVmUuXQe7RBZEc
 mC4eJftwA299rAHAx5Xd0pIS6kvytFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Needed, else we get this error:
dangerous relocation: l32r: misaligned literal target: .text

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/xtensa/crt.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
index 909872cd385..de8fd8c1cd7 100644
--- a/tests/tcg/xtensa/crt.S
+++ b/tests/tcg/xtensa/crt.S
@@ -6,6 +6,7 @@
     jx      a2
 
 .text
+.align 4
 .global _start
 _start:
 #if XCHAL_HAVE_WINDOWED
-- 
2.43.0


