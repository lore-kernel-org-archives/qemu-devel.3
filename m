Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A99C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry4-0002N4-Gg; Mon, 06 Jul 2026 18:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxq-00025I-39
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxn-00071h-P3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:57 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEOE91613950
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4YuAUxaTEmt
 Y8P14HB/moqtg8YkdKc7IpSVCJdJaPGQ=; b=HgKJpgfU25Ijy4R5D4IGc7e3kaV
 JP9wVlbr1ND3XnGeHaG+VlYwcV3BB1LiTyKr9MmCvMyXseb3aoyPnGezvjPSrMdc
 vnW1s4PHmW4PKP/b+gnVbeIJjTchpDrAYX7ogiTmQaa80Q+0putnmpDfX5qO5D5g
 BFnF/HOONM9fGJ+rbKT7cguxi19ZlXstcK9CZHvODg61f+NarkLd4m5WzVLjDCyq
 dUI0D0K7vWCZpndsz2Fl4T5P9YCpSXb6WjqVe2OKNn53HEBwZFbG6J0yBAwzGRB6
 CQg4FvHZ2J1aSmmDF0q22M7DmP8cEZjHuf55WfQaX2iTFEGxcZrCTni5xIA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h53ka1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so5029818a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377534; x=1783982334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4YuAUxaTEmtY8P14HB/moqtg8YkdKc7IpSVCJdJaPGQ=;
 b=FdD1NkdkyhOQJg0tIwoB8lzBwFVBTwzw9ngWQ/WM8+aIb1JFyGUelWwLdMRE+JpmDE
 AkqG3GDgtjO9fO5leZ6FIDpPrEu2IXFs+ykoggJJVP2evZYzA21I+DjpPYIg/fjAxcDo
 0dQijAdlI21umaSGlgC5rM0fACKrauxQ6OBjAdt/vgTQtPeCXIA79oJrqFks5nSs/GGg
 1ykOd1aK7xO32NwJu7SypbfD1Q/uZQbN0GdoBUhWToHDTTuZpmEkS0ubcp3t4bLqXO++
 ISBeR7JTWwK6iYMvgE53oLOIu5aGK8tOigXlVWxGV4RWl2O/JFFixUQ7NaXEa0gjo5tr
 DnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377534; x=1783982334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4YuAUxaTEmtY8P14HB/moqtg8YkdKc7IpSVCJdJaPGQ=;
 b=hR6uPXNHmJw6WdetPozElOCJ8pDITa+By0tgJypj4BPJRjWdmSE5PMVu3KH1ftk2Az
 WxhKis52ADZU7UpmRg3letiuUOV6orx6RBms2WK+JRc9MONEm+/P4z3KL35TGceyColH
 LnxC4lg8eV3/6RjUBTy4SnARukURWPIEZ8U+M2RT+nPrNVxoqPBkHdFIhWG3+YHwnpJn
 ELGYtOWxpiBXcqxATbrxNYXt5nDenmuuyXSnEc2fJssXJCmm7Dzw/lvs+mCHOWm84nZr
 542Tw6yvskalvYhGVPjN2EAiNqzfrCwxtUDTpdsHD8Cpf0c92HkFcQBdVTXSrlUNihyv
 YDww==
X-Gm-Message-State: AOJu0YxjrO4hTHr4QCnd57v9dhhiNK3VXQPgE0gAN4omxvAbHt/56uWg
 vt3Gj1/LH0WRxlnwqnA57e1TdgTzfENnYOkajnZmD8XqdVJhVyos2a/Yb9wpS5giFd0o5vLC9+Z
 vlDGzHIJdi0hWLkFCTn/IXbRHtKniNZyLirE/t96d2Iko3Fkwa0hQMprQNDAaFpqHkw==
X-Gm-Gg: AfdE7cnqnA8qlEeyXRbn6ItnDihxrjEYavUqOX2bYU4HsOw4pcPhy32r2MFG2Vf/DNq
 NBuRByWof/ZP4vmgJ2ON/hLzYe9BxULWOkRd6f/CC3Lm5Jmq+OMjgOeVerDzRwnyd6ptAyDx8j7
 sGQK4gNxh/4CyH6tnUU1NvrCsnI1OzgafDFq0YpycyYBwPiwiQC88ZBZ9V1KvAq2nJz/SNdF3La
 mZsTROOXlvqMRe5ysGsOTtws+diRntfhcNfxFgm2uroPXEPTFm3Gp+EC49oFbFRK6Ce7an8d14u
 QBkHdqCfwDhOwxUnZhnrrmYymWmEMfPaqYpWrR8OVEMWG922UmwD46CKTSx+JKW6juUen67m8iF
 QETjlI3Igtf9hsM0n2SW2If80eK5qNcASdtaGRggiJItW0UJUpk30LeEIzA7EL7Z2Zv2C08IY9x
 bNW62Dvg==
X-Received: by 2002:a05:6a20:9151:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c08ed07f2cmr2948626637.21.1783377533921; 
 Mon, 06 Jul 2026 15:38:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:9151:b0:3bc:5284:5445 with SMTP id
 adf61e73a8af0-3c08ed07f2cmr2948603637.21.1783377533522; 
 Mon, 06 Jul 2026 15:38:53 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 64/91] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Mon,  6 Jul 2026 15:33:16 -0700
Message-ID: <20260706223343.988769-65-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cnwX9NmE5tasIwWSBsrLjzJAJSEAWH8n
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX8ehXlQtOuIg5
 xw+0k/na/2daAcW3kzUcc/mGc5XsKR+JCF9ogJasis/bFZg1QQpuhfkNPXZzUp6ErGHUAsRYDIe
 m6nbiKPI1qTeRvxwZj4PYEtYN+goFh0=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c2e7e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Fbn9wURAhCV4_gqr_ywA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX0DSqEcIPK5c9
 YiK3E646eaesF631xH/DfsDe4IIw8N2zidv57E+/OInA7FJ4KEkCyuW0HldWhSyt2MNLBcz0HgH
 VNOxS1AO7jvC33ZXQr+zWSKg8QBHrRuuFkCFwlereahXa5d5dE+Ysr1X9A+ekwlI3+jH86FIQg6
 mXrKeyCldTFzC6C40NWvnZVUUufQGI/l8CG3DT9ny8A2qfZJtnkSGldeJ3AQMvByUIJqmMqUFZt
 jmTY1iqlUx0RaRR4ZssBA6vjZG55TceLJlE757FFu3aY425KRxgVcRvPizDNSKuJFE19aIzcWJO
 5RcJlp0bkZDnD2TlNpBkwFzc1X8yyBSnDV9NrVt8YCtpad5CFYv4cdGdptR0hmbtXYLrvADa7QL
 22vnsmfwoZYKSRgYaXq9D0gnefaFoRE0QplnfijkVQnde6ud2/IB03hQkfmS997ijE/UxBrLaSs
 2xH8sK3eam37IyPF7rg==
X-Proofpoint-ORIG-GUID: cnwX9NmE5tasIwWSBsrLjzJAJSEAWH8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060228
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/or1k/test_muli.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.47.3


