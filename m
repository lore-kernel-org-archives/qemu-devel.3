Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8FECD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD7U-0003bq-Qz; Mon, 15 Jun 2026 15:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6Q-0002X3-Mh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6M-0001XC-2O
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:36:08 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxUQR781976
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ogVV5mBQw0eQZRNBwQ5N9Exl0iTbfq2hhNJ26ebuz3o=; b=TInlZtYkqaG0S1/c
 IFRrjyzHjzH232Ew/2huhEj7LI1JocCnpsU+adraU9cKtdTMrFEHbeMKPDUmbpEX
 ndQb2WsUwy9qyhu497X65Cp0vOrJxI3bR16MiG6Rj+Nf3PvHFhX1x1PT1Ht5ccut
 XG4bKunxmiTF4AvKIKECcjYa0yisJ5cpzXRMXLH+sp3TyeWSYvlsZQCmi+8EDHNc
 ni44Ju40mItCIq8TvxdiyUoFstCc+oeN/bpTBi/vArS8C/ATxWcYWkn+TOAwfdDI
 nmgJfkjoiflnhgEv2irqkozNyzzEe/N47LSjPPy5I7it3HeTiwlzC3nSntQJ383x
 OtKiyA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtntg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:36:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-138156c0492so15301567c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552164; x=1782156964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogVV5mBQw0eQZRNBwQ5N9Exl0iTbfq2hhNJ26ebuz3o=;
 b=fdpGAryOGCwMeD/z0i1k1Al4LavB8PpavDIEu1TNCaCKLirnjhMlgfbsV1ZO6n6iNL
 v4kGVA0soQr38ZJCFsoOFW0mGx/YmM2E+uavXmrxe4ZZiPySBML1+Bdi3NMpuX0eRh7P
 j5frm/s5+RaUtdDbU64E9ISm+H+TmdOnwFuRSdhnl0pjBTei+aayd/9wjxc33GMbqbnR
 jbz4fcEg0ylJv8ba8CdzugMfcKtzZemjA1wUrbHZAsvxEmfAVpdEAg1WhGxnuJy031hz
 lfqCEdhdMsLqeqlHYxrEYVd3B+vAMPvDqOBVwrZqdeLSxF7WtUYGkm4/QBPxzQORRZZb
 I+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552164; x=1782156964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ogVV5mBQw0eQZRNBwQ5N9Exl0iTbfq2hhNJ26ebuz3o=;
 b=OfDdjiBhu0cwQy4ex115Q0xjGZcJ7XpZqLV5TdT/6NqCGSsu+6Gk1mm5cN4oFp7n7E
 7D4QfgHqFvWGWS7UK8JcW8T9lRmA8qZFEOtv6WNeMFdTylG/e0xitq5dBYsk2hKIea6A
 WcbXa03ih3G82VXHDnQ70cxfnUCpt72R1c9twztb26XI2x+71nY3jB937d95dR36E/JG
 iCNwiyQC3UYGqvdjsuc2tuAAJgnxwTXKNqDBKScFxVsZW+STCzfrAPZVBf0MpsKlrTbN
 AjVsrJMcrRWTXCjNL+lAlKENfCZEKe3MVXz1j4dtLr/Mn6UwxI4KVC38/H65fhBPF/3K
 G8yQ==
X-Gm-Message-State: AOJu0YyXK477bab1VYbdW6hOA4q4GkOqhxx/5gOAe3AW1fzF6tYyaopi
 MK5WGvWp0a8hCP1TgBJhslI0OUv1gWjptHjiJMTJSRsTHGlXO9s3RW9uZ8VqfezEPBkjg7scB/l
 Bj39eiEhAuvsOFwkEuGItSbp1a+Q/QABpCuuTbuJMJlxx/fVcXWrnrfY9YZIoNjHleivh
X-Gm-Gg: Acq92OGlm9v7NfXdZ9WA5J04YWkH9h3NCwptBkPFrisYBFkrJJkAYa3z2AFAa9yIi/Z
 nk/9PuRS4gna5TkePO1lnf9+pqJXSnmDhdi8rh+1RnLVPeM663Qgo7Lw9Qel+BAKfsZAJZFsTsL
 mFdtdSv34gK/8ZI+HEEORq4zJz8YLxGzQdAFP+AOCA+vJRn6qCTEZ7Ek7kVAgdXG6OY595wCsfn
 vB/b6BglKYiRXDAnUqzAoc1B8BqCqJ7VWKKCQ25JYuiyhVVrejk3u3ziOWOVj9+o6jCNGXWvVdP
 ZLPhQADw66YereW7qPa75rgh0qt3jFXDXZYhLa9UE/vQiRZeL/IDaLmRiG+ZHq+AXoP8v0c9yzN
 4z0awn4X3UPnmm7RsgjiInJlU+H/wcdZ5COqZXXIWfABmeN3dU7RVtD6vokXJ09djCwoiXbpqmT
 XCl2KuRA==
X-Received: by 2002:a05:7022:1009:b0:138:37a4:fcc0 with SMTP id
 a92af1059eb24-1384bb36077mr7055304c88.12.1781552163519; 
 Mon, 15 Jun 2026 12:36:03 -0700 (PDT)
X-Received: by 2002:a05:7022:1009:b0:138:37a4:fcc0 with SMTP id
 a92af1059eb24-1384bb36077mr7055287c88.12.1781552162918; 
 Mon, 15 Jun 2026 12:36:02 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:36:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 25/26] scripts/checkpatch: remove check on forbidden space
 before '[' in C++
Date: Mon, 15 Jun 2026 12:35:24 -0700
Message-ID: <20260615193526.2883349-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX2ohNVcymzP5o
 uCkljtV4aeGKF45k2w/VfcbiShrV9X07n6csxMZaniR26R8iBNdmrQuWCVXhe9O3uRzr0wi8lOD
 SncginfHKyUlIO4MCbb/OP+SvDKtqoStDLBKAflB3IDTO2t04RhjYwlsxVB3+f4fhza5YDyqi3B
 lEvGie+QspDsRet6pySVof44dViOFb+Tr7byHIQkOYnKTWG74MeOdlq+SQuqZBeQevGx4cIZIrH
 CoH5VrW0WjtGtRDmvuJ3/HUUV3osRsrqj7xrX6LNyadvXpaGUuBCnuKLnl2wASRJEX/BxVF1g8G
 gmtoavAlwosDuNqWeS6RAuvfibFF1ivtCECtHKy26FAmXDiYdQCqJIiUTgJWJwIcLMLWko3pdz2
 8PAdeSIFe/m6E80s87svJ4BIBgjpI1ASHx++xGtQsnxvSX7nZswrOViWvw6pFdUBBIXpzcdkZq5
 4309iEYtkqz6hMD/sUA==
X-Proofpoint-ORIG-GUID: 9Yma6TrV74rwcYB2rql-rewcUXDoOfdY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX+KmmR+KjUsKP
 DE38GGaxaP/sf95wncpdFt6zCVUvl2b/XmYtoJ1WX1BvGg+RZZWRTpvO9SdHUw7GPSk+Hcejj0r
 QR7PTStH/xNqB141P1/vtESsbfExCZg=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a305424 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8
 a=gfEeCLqIiXdy1k8fzu0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-GUID: 9Yma6TrV74rwcYB2rql-rewcUXDoOfdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
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

Lambdas are very confusing for checkpatch, so just relax this check.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 538e059e265..03f35e75012 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2423,7 +2423,8 @@ sub process {
 #  3. inside a curly brace -- = { [0...10] = 5 }
 #  4. after a comma -- [1] = 5, [2] = 6
 #  5. in a macro definition -- #define abc(x) [x] = y
-		while ($line =~ /(.*?\s)\[/g) {
+		my $cpp = $realfile =~ /(\.cpp)$/;
+		while (!$cpp && $line =~ /(.*?\s)\[/g) {
 			my ($where, $prefix) = ($-[1], $1);
 			if ($prefix !~ /$Type\s+$/ &&
 			    ($where != 0 || $prefix !~ /^.\s+$/) &&
-- 
2.43.0


