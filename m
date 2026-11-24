Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92F606A339
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VIWE06sm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMnKp4pF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzvJ-0000rE-CA; Tue, 24 Nov 2026 18:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvH-0000pi-5i
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzvF-0007d3-Id
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:27:38 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMagfD1654188
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6QbvimuWnh7CdkV50margCDlMw9i/Sjwkf91/0I9H00=; b=VIWE06smL8V4E7kz
 UsQTqOan0LyuvCxJegfRpjVcfmNzZ1YqSJKsAhuvjAfKwWPWzUxywI7wWABoAJsI
 bILUqi/sTPcZ2NeACsK79zzbyEaRbzoKrZNnmz2kCWyoVWNEOkF7RynIt5ySFSrq
 4ap85DQF6d/De3YmDovJqogLX2Ku/3JmBepkD+QSf7OBbtNBxCBkQaDkaZoTVS9p
 K+6eTru+kcAtARGF4UvSVL4ArtJUGTO7doIDvgABs+B/xyzPTYhQ9CQN7Bz0EIT3
 hCnqU2lvoiK4nrcB9rt/h2Lbh/fx7Ml/yy3XFZfemsquAm19L4TTFdgmDMYPg+qH
 FX1zOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd9a6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:27:35 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94960131befso760150385a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562854; x=1796167654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6QbvimuWnh7CdkV50margCDlMw9i/Sjwkf91/0I9H00=;
 b=XMnKp4pFFQg4Q7bVbma/clrZtLGa8mEcUzuu2CHXalKU5rrYPNNdj80dmL7a2O0nv5
 VFJZxDMELnkyjW5haCi1EhH/q72wggRL1xESKGLHhuTPzFuYY6UWxF52k5fmehrlZWK3
 5RJbFrhXN0orpSZ6fOH1j/Uz/VoZ99JFzZRR6cfuVOuzLdaTtPsviObbKD9JK7xUOgDm
 wphX3rmz9VIj6702wK4QqXtJPVbEyISemicDpuKbvaP2+7WlAjGjL9d4BWaAwzQoXKQx
 Ktz5UjvCFbZ8jGOmSCIvvh5j2Iu3qL/KJ9qObUqe79W81qmqVmYDrxJ0mkOELP/t0mVc
 U48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562854; x=1796167654;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6QbvimuWnh7CdkV50margCDlMw9i/Sjwkf91/0I9H00=;
 b=h5ieBDbAwQKxat30M+agfSgXa6/1nQr7CIFE5JqQY3xcIS1Zfpq5KeXZ2/R0Vkpcih
 gskbFAGr09joS1Teb+vpgprDO7M35OhuBelpPJ8ciEglM3i1cbo2zZ4rk7vZZsoXpN5V
 wi5mypIP5xXmnLYjtdz+PRqAcUF5nReMoUZs6yMl9OqIAS0WFDkPW+gjESERz6+rhUMy
 sW+XsImuxGZirwfMyZASE8+DnzKTJJyR5dXjuzX9uuKluV5vBPSqJ5f0VPRB5n5qSRuj
 VGLbbqsSh/tfEQEVTrCvRQBmvigGVS27n5oeKpHFBJMLE5PTyfhbCOcnFuHdXh6hiIgl
 pubg==
X-Gm-Message-State: APuU4Z9DlEojV2afQzAI0BXTOYtrXk+JSjKe8sBNvxx8xOy8NP7ABtJP
 ZUjzQiulAD5N3prD8zwJYdklt54RNpHoHArN7oQRp2sHAEgtIo2vLUdUqReZw0ovxJZMHoUqQVw
 VYVilDjprPm8ygNq90xQwoA8IZ5j1BNO7AuUWkAHArXOcOfZZi5A7xJGVngHH2jvGWn9T
X-Gm-Gg: AZFdTZcYNoYi/94F5DTdLjJ+IEItqyYuI20YIYBBB9otPHixb77PACb1b4estsf+jqg
 xDDFmzuJ4d1RLUTk6iMfQzCeio6Voq2naWA1ZzrwpmLL06sdRnFRuGrzopxos4wrJfNiEBbB1g9
 UWWb/s7/R52Neo8eVrZlwsGl/Zjo4l7HnQlliDbeRt6z7OkomhMK8IIWR0YQP4YhBJ1oOB70YQ0
 /f8P7MMAqseHDAz7rajvSuAtNuNrRlL00jC4iKnI6Opcmnfn02ckoKBqt+deAPbRLWQY3aMsNvS
 FR6KsZmGCjK+ZAFsOQ4bLpdDlLhjVCr1udV9R94Ef6A3/XiprTriM8qbQr5rPfBvfIheNh9MSbm
 cB2sxpTWMuqPbo8w4AEzns97aKbho+PhgMQUmMJRnP/19Hb4Vh5kO0WCtAJLeWaSPTEKzVcsbVY
 faPKNVl/ZfYN5bnA==
X-Received: by 2002:a05:620a:28c6:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-949ba7e22a4mr3069401485a.12.1795562854127; 
 Tue, 24 Nov 2026 15:27:34 -0800 (PST)
X-Received: by 2002:a05:620a:28c6:b0:93e:8614:bbe7 with SMTP id
 af79cd13be357-949ba7e22a4mr3069396985a.12.1795562853586; 
 Tue, 24 Nov 2026 15:27:33 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm459246745e9.6.2026.11.24.15.27.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:27:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] accel/tcg: Check current CPU in icount interrupt handler
Date: Wed, 25 Nov 2026 00:27:05 +0100
Message-ID: <20261124232722.90234-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX5oS5bmkhDfIm
 AWf3Nt9oo5VostdNGGCBfH6sV09nIl1VpZgjW6H33nQ3VcP97/KMlC5voJY1r/WVXrETAnXpdEM
 DOwjtvrF9CkmQeW7dz24Pm8I91DrMJE=
X-Proofpoint-ORIG-GUID: tV4MWHDk9wEH54DX51Zh6Wr6x2xUQMmx
X-Proofpoint-GUID: tV4MWHDk9wEH54DX51Zh6Wr6x2xUQMmx
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b061d67 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX4hRejhcO+DHG
 zH1iwX0eXowNozSVFYhnmGWAxPpqBEcIOCW3Sqk7FbZGM8HFXr/fKk5u9jToN3ecDIU4ODBXa5W
 N4VyN9EqiZrW63hK3av2XBenX/QF4ddILvHmbc+hRoDeyj5ZIeQ1cYbsc/zJAxEJuttslZCy+Wk
 Zd6B+pJ2AHEhvRw/O0/3UyW3GAexVVRLB85pRJUJZpFxwvHREH5hNnkziZLDUQ67OzSAWL3KBEU
 kFxUdSX6o6FgbufozVp9+TcWt1B1Fznc98+EFAj0l4ore7ktbOs4dOQ26gEEr2vbmgu6r99f+VK
 087Q6ruRVi7hXaYopfgWp1zjGGFxVxSUkPqKWqGkqApfEnsTp2rnNaOUqH2runJMu7FRZ5bQAzl
 UQ0d5dvrqyTDOKib97x8hZl0mUBk54b0fT5OFqtnezJRxQM2M+6CVuQIFXa/fdbwXv8+xMDl7Hx
 omhw4TBQazYIqdyzUQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
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

Under round-robin TCG, all vCPUs share one host thread,
so qemu_cpu_is_self() is true for every vCPU. The icount
interrupt sanity check can therefore abort when an interrupt
targets a different vCPU sharing the current thread.
Compare current_cpu with the target CPU instead.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261119225514.4080-3-philmd@oss.qualcomm.com>
---
 accel/tcg/tcg-accel-ops-icount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index d0f7b410fab3..0313a4d128c5 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -152,7 +152,7 @@ void icount_handle_interrupt(CPUState *cpu, int mask)
     int old_mask = cpu->interrupt_request;
 
     tcg_handle_interrupt(cpu, mask);
-    if (qemu_cpu_is_self(cpu) &&
+    if (current_cpu == cpu &&
         !cpu->neg.can_do_io
         && (mask & ~old_mask) != 0) {
         cpu_abort(cpu, "Raised interrupt while not in I/O function");
-- 
2.55.0


