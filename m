Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49906606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TyrwqkBE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JyY5uFo6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx2X-00010i-Gj; Thu, 05 Nov 2026 07:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwzX-00056g-QC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:59 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwzU-0005wh-S1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:55 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tkft3532147
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 54Wj8Ze5ODDpotjXvWsGMuJa2158rPlapy7ZWwi5knQ=; b=TyrwqkBE25IQ9hhX
 yUN6zte3DGG5lyLeeyOJ8EF+38xYdMfYSVdJB22NAjlHxHnu92Yn4brQXgxwo+y+
 Yvdi1k4zz9U6q5f58iWrSUrdOb7AB8ON2suIHNZcsdgeti4HCBKou78z/P0TLFDJ
 cSWzA3JndGiCW3SGnS1IoWoEZiDkqBprs2zLNjfzgeDoPEnb2oQRObAeVBZD9pKS
 337Rholj3kcQWiy6H7yyp/tNMWW60tayMOfBP1p8Jg9tBJCStlIDAsIEwLKYYm5I
 p0YkCN9Qp0lEj2uDCsQGVvVBt9tXK2mm7snZz96KQ2e2xCsSykRjRRnGiWO6dx0e
 JpjPGw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksq9q7f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:54:41 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91e987a4099so14350986d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883281; x=1794488081; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=54Wj8Ze5ODDpotjXvWsGMuJa2158rPlapy7ZWwi5knQ=;
 b=JyY5uFo6pKJs5lrCCCO85ApEK8gO7epVirTgtce+3ybhO3qeZbUmX75s5j2whbHVda
 7EoXQ3jrsOZswQIbDay1bqo872X6Phmm/wEAzFhvRBbrbIX9mPGyJ5IKoHwZvj849ffH
 AvLJqU/X/z24YwSjZHykOUcnMzma2HipC0p4CVmt5tlwQAZ5ZszhlxBNvfe5KPElGlOf
 v2B2ZhWtvnF+saLeoZ51IYUYkf2+MN5A2rYNyCeFyZ2eniNuX3fMq0JHZ94G6uBNQwK6
 /0DWnry9CN0ELsVpHM5bj0NtJeZRhwZC9ahw+AcuJGPKxnQBPZJDdA4004hwtHGg6RmY
 OeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883281; x=1794488081;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=54Wj8Ze5ODDpotjXvWsGMuJa2158rPlapy7ZWwi5knQ=;
 b=ZxgVhGG3BG93FLEa2EkT9mcFKL0jFXalgp/soq4CoX9Dxc88l7fie6B7x623PXhDiY
 RF6pGFwF7c3F6+N6I8XOb22tR4au8VdgxHEEjqaLdXMlKcLqiLkUW8JzNfuucNcJ5LE1
 6nxBfl8qTqvKQRAzX8QpQ06wNzCn7LzbrIkrwyTyh35KNZaDnZyPZsTYX915lWd+d7se
 1UYy2lVJ7ShLoc+zjE751NZ6DJnig2j4oXSwNKij4KWZumZlvYMjatMSzjl/8CNfS97n
 KFL9eWhS9ktU0Pf3G4Ejwe1rHuE4/lovr4DAkmqEhxFp6GbSMI1qQFUIHnVWp4CejfmT
 vyDg==
X-Gm-Message-State: APuU4Z8HrKDjv0neAH1C4nesgjpB4IPy9zKwrDWWq5wknc3fdmVmbJ+J
 JPBTihWdJoznQirYtA53tj8AbaFqPNjsgFd7Ich0o7H8Fp8xEp8Zl+l+5UVOrIzQhmiRjQpHuw3
 Nt5pQky7O6CWH4QZIjbDXm27oVhS6OOsDVzQQVF8E8RBuvc9d4Y+iapmUDpYY+3W3KQ==
X-Gm-Gg: AYBFou3W1kd4mCn78Ya0qunaTzjYbUaiFxWaq0/ZA1zHhhCUi/EA5Xlg132QZ/USleh
 UzC+X/keh93uIvPSUJPYgIEwGF0QVEmsIIwq80qSlzMmtYRyS0HaXLGG7FlBG3iJrvhWWRoowaG
 ULDQ/RvhjNDGMTokWyp6pO4fgwKYkvDEiKfxDhiEXsw241dEmfvbIpS9pd1Q4P9ieXBTGYdK0E/
 dmicew6kqDebhm0m0tIlt2N+eemsp46VlXg8FOvTlPtz3qpTQIWr8EKQPb6z8GMp/bB1EM8bJaz
 jeDICWwGRsg39CerRKn3hyW7wQ7I6ZdzlBxZ9Ntnc9eXWliGqo9wkNEH4bqjcM5/OsW2Tchz+OM
 uxR6h4q+m6Udz4mODc+S5jGVWylEgLzjdtp3IOqZNjPOKpF4p4GYZyS/DMSsSZWADnu2LUTvOmH
 F/7oVg7EpcCEg9TIiiQPDGFQ/3NkJoiA==
X-Received: by 2002:a05:620a:8809:b0:93f:34c9:924d with SMTP id
 af79cd13be357-94421695deamr2916896985a.35.1793883281106; 
 Thu, 05 Nov 2026 04:54:41 -0800 (PST)
X-Received: by 2002:a05:620a:8809:b0:93f:34c9:924d with SMTP id
 af79cd13be357-94421695deamr2916894085a.35.1793883280618; 
 Thu, 05 Nov 2026 04:54:40 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0e4a49fasm166564966b.82.2026.11.05.04.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:54:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 16/17] libdecnumber: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:52:01 +0100
Message-ID: <20261105125203.40320-17-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfXx5VyDCRjD9pc
 qKRpcKgIbNWV08KprukwRDWn6VEzwJQPo/oGsHadb6+RFDVKKkvnFfl/iByAPVayqAygm/3LdDb
 oDZij+mJaCKKgvtxHBwkVwISEPxiierDbsyS+t3Iv8xQBiaWiXmkjLU46MoGiPR0a32Gu0GUcQN
 Yha+wqby9co+xKPeHMb3FUIKIjmRF3C5RpXgRn98quQBK3M3a8tFgn4rxMnLUd81RLHx9s3Tav6
 1+/xtyfPCJJNmZTE3EdeduF5AjPsqcQR7CHwCKc87YfFW4SnPtdEW6n3wOaLc7E82XNmzEjFixn
 6i9Lwtt/BohQg0PtxKE58nHsn/z8nl87bvrTgd+tus+ABcfXfX4iC7opJnDKtZG+L9Xw/GEBqLi
 Z/7AUvQPi+fzi7/vLt4i51Wi/RZzcngRNnP6GGC/puZufemtHwWzVo43VzHnPYEar9N8slbBO51
 0j1lkthS3wiVMQx70Yw==
X-Proofpoint-ORIG-GUID: 4fhhRZ4RvOSKq3VHnB5Yf4huLZJq3sG9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX5ewO6gRk0l/i
 fI0N9xB7fMMtzjoZoNTHhY1yPbNoLdwwbkuQzmTPpp5tDSrJ5qpu3lWtk9OFn2bqiQ4fTrlu4Mf
 vtCRAw+6klzTr4o3pTVFifPpNRiMhT0=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aec7c91 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=kSs1XlKta5HeGRuTdXcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 4fhhRZ4RvOSKq3VHnB5Yf4huLZJq3sG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050051
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format hexadecimal
debug, silencing -Wdeprecated-declarations produced by Apple
clang 17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 libdecnumber/dpd/decimal128.c | 4 ++--
 libdecnumber/dpd/decimal32.c  | 4 ++--
 libdecnumber/dpd/decimal64.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libdecnumber/dpd/decimal128.c b/libdecnumber/dpd/decimal128.c
index 1064fb25e01d..e4ff39c90bd2 100644
--- a/libdecnumber/dpd/decimal128.c
+++ b/libdecnumber/dpd/decimal128.c
@@ -543,7 +543,7 @@ void decimal128Show(const decimal128 *d128) {
 
   if (DECLITEND) {
     for (i=0; i<DECIMAL128_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d128->bytes[15-i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d128->bytes[15-i]);
       }
     printf(" D128> %s [S:%d Cb:%02x Ec:%02x] LittleEndian\n", buf,
 	   d128->bytes[15]>>7, (d128->bytes[15]>>2)&0x1f,
@@ -552,7 +552,7 @@ void decimal128Show(const decimal128 *d128) {
     }
    else {
     for (i=0; i<DECIMAL128_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d128->bytes[i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d128->bytes[i]);
       }
     printf(" D128> %s [S:%d Cb:%02x Ec:%02x] BigEndian\n", buf,
 	   decimal128Sign(d128), decimal128Comb(d128),
diff --git a/libdecnumber/dpd/decimal32.c b/libdecnumber/dpd/decimal32.c
index 34ff0fe95991..bc16361c82de 100644
--- a/libdecnumber/dpd/decimal32.c
+++ b/libdecnumber/dpd/decimal32.c
@@ -470,7 +470,7 @@ void decimal32Show(const decimal32 *d32) {
 
   if (DECLITEND) {
     for (i=0; i<DECIMAL32_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d32->bytes[3-i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d32->bytes[3-i]);
       }
     printf(" D32> %s [S:%d Cb:%02x Ec:%02x] LittleEndian\n", buf,
 	   d32->bytes[3]>>7, (d32->bytes[3]>>2)&0x1f,
@@ -478,7 +478,7 @@ void decimal32Show(const decimal32 *d32) {
     }
    else {
     for (i=0; i<DECIMAL32_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d32->bytes[i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d32->bytes[i]);
       }
     printf(" D32> %s [S:%d Cb:%02x Ec:%02x] BigEndian\n", buf,
 	   decimal32Sign(d32), decimal32Comb(d32), decimal32ExpCon(d32));
diff --git a/libdecnumber/dpd/decimal64.c b/libdecnumber/dpd/decimal64.c
index 11e0674fa7c8..18438c1de1c3 100644
--- a/libdecnumber/dpd/decimal64.c
+++ b/libdecnumber/dpd/decimal64.c
@@ -530,7 +530,7 @@ void decimal64Show(const decimal64 *d64) {
 
   if (DECLITEND) {
     for (i=0; i<DECIMAL64_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d64->bytes[7-i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d64->bytes[7-i]);
       }
     printf(" D64> %s [S:%d Cb:%02x Ec:%02x] LittleEndian\n", buf,
 	   d64->bytes[7]>>7, (d64->bytes[7]>>2)&0x1f,
@@ -538,7 +538,7 @@ void decimal64Show(const decimal64 *d64) {
     }
    else { /* big-endian */
     for (i=0; i<DECIMAL64_Bytes; i++, j+=2) {
-      sprintf(&buf[j], "%02x", d64->bytes[i]);
+      snprintf(&buf[j], sizeof(buf) - j, "%02x", d64->bytes[i]);
       }
     printf(" D64> %s [S:%d Cb:%02x Ec:%02x] BigEndian\n", buf,
 	   decimal64Sign(d64), decimal64Comb(d64), decimal64ExpCon(d64));
-- 
2.55.0


