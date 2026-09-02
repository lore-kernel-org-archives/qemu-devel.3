Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37295C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1nF5-0006RF-CD; Wed, 02 Sep 2026 11:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nF4-0006Qz-3c
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:51:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nF2-0006K4-HL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:51:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FZFC42670667
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 15:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=n7m5wTcbZIZd2Krx4drBCQ
 X58JBS6d5wNVv/EZqZ2w4=; b=PgsgeCJmnvvaFqw1bBFwJ8d+vVKjKIIav76FXl
 PZgL/mRWt4rGclfxy0aMpnX/8mrancqWsuIBvOfGlG1AJ16tJp7Xa17CvzPJIqj1
 FT8vFv8YZDppseSvASPayBrhfeki2TcJy6XmHLaBgl7qMsyekNOX1CTI/01BLKnK
 QZ2rLoZSoyj7hKnLNhUqPXa9SZxrvxtByQnzcNX8ttlp63KNqBQNCh9NXB4M1M7i
 4U30zXXMJBNvjqs4Cp9qUYvHxdnn66aEvstweKXWumEY1JlDku0NzBr+nu35A3h5
 IiG2ig0V3xWy4biCFVMiJDuahSWjibq0m3QwPwWKxCZdUa0A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gebsx2s4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 15:51:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso51702285a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788364269; x=1788969069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=n7m5wTcbZIZd2Krx4drBCQX58JBS6d5wNVv/EZqZ2w4=;
 b=g5iLkBsicAr2cFX3eZELgDUgVQ1355jLJJsievHo2FYhIDIPlkpImpp72JRk1RfsFF
 sgCg4Q2LpgGk9l8dzddgpZLm9Yy6lXTIl0qYwZ3bkoBY7k9J7RS7yRuuLZj+KwS7BfaY
 lbRlO0/WmiM993KtdINFfJlOWnbJG5IsN04gvzEtlR82uKRqHEN0r+nSC+Yh29NksWYi
 5NdrQ23DyXrn02V6fa/9ijMh6jDWwXSlzecH3vtqfe8t5fYO7ipkzll283LrfM5foqm/
 nPP/JlsDBAiVOxAbJNmLQkLllOuFu30HCJ2brNqjd589PwJsU1YEgf7fYhD2yJemArEp
 1tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788364269; x=1788969069;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n7m5wTcbZIZd2Krx4drBCQX58JBS6d5wNVv/EZqZ2w4=;
 b=VaygfP8PnmrxqdxhuIECevOCIsAYRoIGavTmpnk7rtzObqQRl9Nvqmcnc2zDthH58T
 F81TKbI4+QPRjigLOwMCUjdEcixYcDtPHDVqeD35N5dK9vhNQH+DmUVXpjzjNs3w57ZF
 jK7Uqxp3OtQrO4LyjtdgC5TAR5W4QMF+CjhH9OEcJKP0q1SWKfhK8i8Cg+QYNBB2ZvrP
 8nQVgsWjteZTNZq6rWyrKEWF3OtkBNbceNki8DHlVrMyi4pQ96eOiR/lPWkO6Ayq9a5S
 gVCjg/J83Gvt//UOlH4FKgUya2yejlgnYUQfLMaHQ41qA8u+fz+iv4Wr0ToixsxPU06I
 XHSQ==
X-Gm-Message-State: AFuF++ntDp5M035pJcS2ZQuvrCyqJQ7UcV427k3W73KnGCXiKg1mfW8+
 jXuCc+6ZDEAwaMooNc2fO7n+qB+N/17qPELyMPwAPV73MAatBc8A5uLEyDdv2bU5re4N4MHyrgL
 h49Zw0J7CUSv/TAZ0kqtjTdSVZsxFgL8b4OG+XGoQX7kL7tAsBNtblFbheGQihhn5Gg==
X-Gm-Gg: AR+sD11eoX7RZZNNcX/vr10pAGBkSorxe+xYlTGem3Bla9VpV5HyMGBHXChRyQYUKZH
 POy/Zs2mMG5ZkV9UNC9QQD2YadC0tOmir+PglU9G6suu+L+uvTeYph34/C5+F+KJfyHKAfmT2so
 jbZnzBlKUpTHG7R/FsHXsN5MJxGzYiUeF1VdpzcsoRvls5NaDLF0bZSXb9ukr49BOPKBA0c3zfd
 8bGjM3HvE33CBItj/VSBgaPkIh4w/uS4PCs0z3l1He6kLQhELOL0IApZAkeLs/yvwN+V1h1fgDK
 S2E0ldsiP16Lct7KrVquEo9Ab5WpCmUqBiSNGi21ZLwMcbcRc3ZrI4FXhJ11OkgrxzCK6BVy6lJ
 U9fTyjrDyU5cVGbjg+tnxQpNwceTz25DcmP9SdjKn
X-Received: by 2002:a05:620a:6302:20b0:939:d06:e746 with SMTP id
 af79cd13be357-93960f18eedmr609319585a.26.1788364268879; 
 Wed, 02 Sep 2026 08:51:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6302:20b0:939:d06:e746 with SMTP id
 af79cd13be357-93960f18eedmr609314085a.26.1788364268352; 
 Wed, 02 Sep 2026 08:51:08 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dea34sm924675e9.10.2026.09.02.08.51.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Sep 2026 08:51:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] MAINTAINERS: Stop reviewing meson-related patches
Date: Wed,  2 Sep 2026 17:51:05 +0200
Message-ID: <20260902155105.32165-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1Kh0xUvz0DMmxzsIFqusM7zzPfg2V9MC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzOSBTYWx0ZWRfX66ZXt+MbsJ28
 KdQaoLsuOfjCNMPEygqhj7JKaVcu5WO6Z4bs5FQWgM7+2X9MJOXcd0ohHtGX7nEIPPTsYlZjrBv
 bwdQLFCpdBP6Bz5Ny5Y5Qri1/IG1I0/+Q5EgsgsxhcHEC08dEkD6IJmXAEJUpCzb76nmIDGHeG4
 hMZ6eteL3vwYwTxaBXgfBWDeJugbuo1sN/U8vkgGtn7PejLHeT9lOb3YaH/hdAtEHSPzfYAP+4l
 IBGzpuuHkmLrNTn2NoAFjexOBZRWeph16O1QTmtoUhyvRsR7UsPzYHsku0IqX+6BrM2CBvHNNVJ
 bWxQi5KtLkFUaJXHdivOQhKl13bjyXCLKw3N5i+8VSMcunRwxVJGMvtrOMokCC1aOMI65i/pggG
 rG9SfT8ObPpq7tHnFGNZX+vqXPpQ9CFmWmO/NsaYEgCQRAOJKILGl53yVCa14JgPUW3+kADvc5N
 uHJ8FMskknl+JDBT1vQ==
X-Proofpoint-GUID: 1Kh0xUvz0DMmxzsIFqusM7zzPfg2V9MC
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a9845ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=5Q3RQdOrhNiy0GOB1IAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzOSBTYWx0ZWRfXx7eeTviWDex5
 +Nsil0yoOUGfx8Xhwr5GKWJiTVyhUvHNG79m69IoHtALmT7xbFkSoSJl9Pn1t4eUbMHO6JTqhAW
 snVurRFJW0AeqcN9aDE969A//b+1c6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020139
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@mailo.com>

With retrospective to commit 48fad83ff49 ("MAINTAINERS: add
entries for the key build bits") I think I only wanted to be
listed in the "Top Level Makefile and configure", not the
meson one (I'm not following meson changes closely enough).

Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1830cdad15..015256a535b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4674,7 +4674,6 @@ Meson
 M: Paolo Bonzini <pbonzini@redhat.com>
 R: Marc-André Lureau <marcandre.lureau@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
-R: Philippe Mathieu-Daudé <philmd@mailo.com>
 R: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: meson.build
-- 
2.53.0


