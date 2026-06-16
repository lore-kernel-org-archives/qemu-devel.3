Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E95CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYlG-0006Au-Jh; Tue, 16 Jun 2026 14:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkr-0004ug-VC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZYkq-0000VH-01
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:43:21 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GIOplD172527
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K1HLDWkn+5ASuxJ/N8JVlpoKPwTz5uJ5EAhZ394Q2ms=; b=jJP8YHpD6JvwNbUU
 nr0r7xO4tF3Yr5r7s2FDz5fkXGbtyDllKBECbqhq7GGWw+bMX5yCwcDoLWvghBRu
 tFFK9h17OEZT3mTir6+po6RmVE/awgnEbs+ZaI64lY46dy0u6zbq26kZoFxM5Tci
 WMis0NVipD8uO+qwTsfRuLSPPvLwO9TdnnHNxkA+w9ENOqWmbUf9C+P8Z4sSHQZm
 qkERFkwSiSgxI/kZkuf8BGNmc4oGGeKj2gRBUMHeCI/DWsKwXd+LKdaCOcbrTRsp
 yFVu4fMA8uB+PkddON8bIDI5ro6ixqBGqTNhf5L7eSUU/emQ/OV65hbD9q32VY1h
 hk25sg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu09kbhy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 18:43:07 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8423efbfb61so3500167b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781635386; x=1782240186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1HLDWkn+5ASuxJ/N8JVlpoKPwTz5uJ5EAhZ394Q2ms=;
 b=X32JLrSczqrm/8iwjhfxnxbAK61Ffpn5m8H28MP0duCoHYt3ppkBmXF+uaYssKeSiD
 WMbP5ab9W4VN3ccgRzmnv5kCS9DbabswiK74wbB4X3C7EIDoFGauwXVhkn4ORxi+izZR
 zPA9yCwMNJsBUs0QVKRpt6jSa+HCNQsJnAxurxrA8F4FDQ4/oV1AdNXgiqcVmgk7cwIf
 sHL8FEvCVJDpkiypPq9ILk9voiqhvv7GORn9zd0sgWxqJc0h6cXtkjjzNECyxORMJvR7
 C3v/aJDhMfK+Mh2rHrUpHE61C7YcsqOsC1qehNfVLy0BwypkUC4lT2H1ppqlbl38xJqx
 V1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635386; x=1782240186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K1HLDWkn+5ASuxJ/N8JVlpoKPwTz5uJ5EAhZ394Q2ms=;
 b=dmR6O5K/7bTIBRnvaUt0VxCVeLnZyndkkjbcMK9TjhqWx0nGB9Mb6HjCkGXyNM/Ne4
 hWoAHT5ihRWi/gYwXNFDeU7YSxdXyfGC62/b/d33H75I0vGTU7wv9Gm5TQ4B+8YWHOzD
 CHgor59SjJ5P/hbZQgxQVAeRE6Mp2iKvAZ1L3L7arlFciaAtHwxYsWKAEw61jwA/P+Lt
 lwbPPre3wfQPwnGJoYuS7IwgMwCIg5TAk8NEsZFBI/TJ2LMwsR55w4szOO//s1Uxsciw
 EWfcfd8oJZLNdU9ndnXI5+5cyVaoEi8GR86Qdc3mxpn8+iaAB460OASnBYdYJt7c1Jiz
 96/g==
X-Gm-Message-State: AOJu0YwYL9T1xjspFpKiWjjzbnzqnawv0JS3UwZ+/tWe2aMArzpDmmYM
 yK7bcy+u0d871WxfFFpxQERwgmWPxfdzIZcXHtIwCiXycvP/mtWVo9znBxEJHSoThKZJHbXzx4U
 xXlvCQLOa5yu/6OuKsyzkDsE1tqzpUEOICT7Tza+IlnPqiQxp0HG533/Wfoqi6nspWd0q
X-Gm-Gg: Acq92OGmAKy3p3qxbMxasm/ir1kxX8ylNxmgTsbM4w6OSafet8zeBvvKxvRybCxTcDn
 pYkvVFyx9IEN4ivIivUXck6DIkFNHAcLlGh0iGSClrlCvN8foevl+bdmYVtXNX99Z/HQstIEp4x
 d3hUEWUKtXJSn9xO+ULNE97iZYr26InZ8niHA/AJQkLIQC/xuooRtgo49cZcX5UkfSBCRZ1fsRv
 r0auy5hp+IyA/RxWo5sR5wHBxBaZBu/erclDwOnlSDZwqH5nMct1Y2XzCg0un8Z0FWsn+xxLEN6
 iXB+lVAmGdy3V/ier9KLJvGoQzAoINQdlZMcGfmdE3p46PmsIDbm0IGVjKAM8/nT6d0t2U7F3LZ
 kIIAnktYSs2dHzVL6K9d3a0GbGhH1XmL0EK6r12uoUU4qRw6k/V9O9QQ3T2cC7LVc6dJM1SB3Ah
 zYkWUT+hw=
X-Received: by 2002:a05:6a00:1995:b0:82f:48e:241c with SMTP id
 d2e1a72fcca58-8452455005amr330188b3a.23.1781635386210; 
 Tue, 16 Jun 2026 11:43:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:1995:b0:82f:48e:241c with SMTP id
 d2e1a72fcca58-8452455005amr330160b3a.23.1781635385730; 
 Tue, 16 Jun 2026 11:43:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434b048496sm14602946b3a.54.2026.06.16.11.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 25/26] scripts/checkpatch: remove check on forbidden space
 before '[' in C++
Date: Tue, 16 Jun 2026 11:42:29 -0700
Message-ID: <20260616184230.303038-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260616184230.303038-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX6QjpOi8Shufx
 1wa2MJKv9wsYKEUded20TJcnUHfzqb2qFxYDv0ugA0r//01B5bj7wtlme3Y02Sj98l++srdqYTh
 iQonWA4QWReqMRt7jBoTZJEhTkr9F38=
X-Proofpoint-GUID: T5pbu0ID3tVsYednZPruVIh2E-f-EZR2
X-Authority-Analysis: v=2.4 cv=DoZmPm/+ c=1 sm=1 tr=0 ts=6a31993b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=S56xvJB5AAAA:8 a=w4RrlNedZYh1fdpaRdcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-ORIG-GUID: T5pbu0ID3tVsYednZPruVIh2E-f-EZR2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE5MSBTYWx0ZWRfX5J1IKW4plSnO
 r7k9eBnvPNt6zaeoc9o66Ky/kc/gWwvS4e1KoQt5oD0LJA5r3NkDo1ouggUF3jLyML/8P3ThEAW
 FS8jHkUTxGwn7nOl3LO2EShpopq4aIKMCs/MQ5zaP9ObRRa7lqdiCxqYk8p/SU6wjETyTFDqrRg
 RYJpcD2stuXCXhiVlumAo7vml2Zl+ewyMpIEqsNnSaejLI8jmDFFhkcK/mayHuHN2Uc4O8IH/qd
 59JySuAnJ3Z+Hd2yiTlnRIApeC30BOYM4LNMvaskwjiPijsK/al7gN82e9YlQfDrW1NcMuaFYor
 xnTMmDrhFaiWydly4NSOhD7E8uzy8Fp7GSfVJxCUW+xJv3gaskElMKBARNxEDnxm5B5xu9EoHC7
 2NzlGwtEkNohEkVe2pO4hK3cyPJRkoMKgbacKFd4W6+N2ih2qkdOTyYs7iYDFkl+yAm6jalhICG
 ooqLrVwkMAuHFuuykOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160191
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

Lambdas are very confusing for checkpatch, so just relax this check.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Link: https://lore.kernel.org/qemu-devel/20260615193526.2883349-26-pierrick.bouvier@oss.qualcomm.com
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
2.47.3


