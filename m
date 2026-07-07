Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C10BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh2YV-00039n-6O; Tue, 07 Jul 2026 05:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2YU-00039c-AK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:57:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh2YS-0005Af-RK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:57:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Dm8q3182188
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 09:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=29NYH4s3H3xxrVeswvjauZ
 ELPVLzh0IBiewGbfb9S5c=; b=JgSWrMB3z9YtUjZCFGrkm7appEYOOk2RD/+ma5
 b0qUhAs7P3Ib6WuSUGEP54IegOjJ9ULQ/7JoIMzJCkFhrl5QH39RJ36nU1hLtSt3
 38hf6XzuDMXLE6M3Hzbd255E40xi9ZIomZk9etfs2tzR6jmYCAaf47Cz6wmjia73
 EmWj/C3KgWTjd317UluG1Zwt24im5EBIiG9sKWeyjS5KvneNZCjfOYiKb+2Hllns
 BgkgSFCRhPrIX8ciu7ZPBdB6AjA6hNacZDdTNT68SxBwA0vtg+4lPXXRpe0XZYXV
 sQblGCnJbih8zYWsby+6CyzSFOKDJ4u43KvgnAaG8tsi4mVg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t8vk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:57:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c01ff996dso54362971cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783418246; x=1784023046; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=29NYH4s3H3xxrVeswvjauZELPVLzh0IBiewGbfb9S5c=;
 b=EWlGohldhWa07hnBJ5cx/U03GpmRsnI+AUk2RTKUjQW+NEAfBJxeowHZyzvwwlw7IT
 R2yCT66I56vUPLaGgzutPuEk+hdnG4Mn7dCoNnJOTjzWkfvN1m9eXgSUaAAMWVLJCYth
 iwu3B4CJ7egMcaAym9eY8twLfmNRg7wdrBAHrCV4MB5xYocNrNKsIQ07TnM48viOy/Rx
 e2YLSLFfFM/ZNg5nyRxtOBAbOSUJKjAG1mGMPOnRX4JQmbZammXSP5BQ9J4eJaVYiE2w
 SBqHP7w4mTN6PNB73fQLKNs+TUT2pluTKzBYvNkvYp663jTbYeR8qIigtWob0JMVKXB6
 ogxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783418246; x=1784023046;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=29NYH4s3H3xxrVeswvjauZELPVLzh0IBiewGbfb9S5c=;
 b=BMqMBxN4PYTvdkJRqW0QTIX5Ww4XMJkgkbKT+HTVhtMRKLAc6j0eWvSuhgUXo1bD3d
 OrG8Q5yjtBi/0rYkRzBiZ04s/apceu/mmMBYnSpIN+1+5WBS7HHoTSHW9qq4kLUywQkP
 EMYCf++y1wt7hjviW8m8EadI/nGucgyT+jyi3E3AaSDpCyl0dVUXBntbUOtLanqsC/O9
 MvWsRmzaaHBeMYsun3NeFmyWeTW5HudfoqlX4vh0gKsT4ywOuWmWs/kHANbC1mkX5ktT
 rDwoDcBhZaPqKkN+ds/Wbx3FN8IGQp/YqSFLIPmBaebOeDTmsImaGVrf4Kn/hau3aD0S
 q3Qg==
X-Gm-Message-State: AOJu0YyJFrgK0PHtHJc/8nTHWohw+0548ngM0+Z1FwBBzjiDJUYu8r3v
 J/OYaJb58lB2rOWuSCd/b71U9fPiMDuCbZDIZk+UJ19Kr1XD90AfVpLAIwsvMqtZdsyolosOk1Z
 XyTaCGBINYh0kBxtStpguUouktKjNtg14FD5Pzy/CfLw1mYu6wdcyPWChVyCAVCSWwA==
X-Gm-Gg: AfdE7cmKECX2UBwPPZ8qJjaSnimeJCGVOxysI+exgellrXg+6gAjgW/c4G+JjhS8+vH
 hIHARPYJoqI/UVWuFf4kRLKXKvyAjP/ZUHXIbrd40aNY9yhRUy+FBoCgbW9UMYPqIoN6k/abwVz
 tPHgqDGe/fDXdZSia0RVxpFxxY9naEn9OjYNWCJqqoaeWjg1Lk0ARvdsTaTlJ6Fw46YFNMfok7h
 CPTt0WkioOjY0ZH2jfzUfxJiMBsHomi+4SGPvNSLFKdm2iAuAnCLjesuvsCJ/4kna3pCkdqc/8e
 ppBZOWjAX8J6zh9hnZMsaXoX4qfDCrEsK1SwwplVWOEn7qdbsx1pkI3LtFOYLq/bb37MR9t8nlv
 s/cg1KNOnLvQKHDHSdnMXvhFr4n2f+f5pCzrG2JLPZ0gvbNbzKi8aGkA8XWaMJsBDlrki
X-Received: by 2002:ac8:570d:0:b0:51c:11aa:1b9 with SMTP id
 d75a77b69052e-51c74852690mr50663181cf.36.1783418246398; 
 Tue, 07 Jul 2026 02:57:26 -0700 (PDT)
X-Received: by 2002:ac8:570d:0:b0:51c:11aa:1b9 with SMTP id
 d75a77b69052e-51c74852690mr50662981cf.36.1783418245944; 
 Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm31259222f8f.29.2026.07.07.02.57.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 02:57:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH] qemu-options: Do not list -enable-kvm on MIPS binaries
Date: Tue,  7 Jul 2026 11:57:23 +0200
Message-ID: <20260707095723.36591-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yjiUYwbHIQvaB_WMDmXFrMZFKYBVMrVy
X-Proofpoint-ORIG-GUID: yjiUYwbHIQvaB_WMDmXFrMZFKYBVMrVy
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4ccd87 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xy2jnZp3kN_kOukCXuYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX7zXszPKiwaCp
 su4nqWngBJrfekklUk282MX5g8QGB6wa2CCBQYJMvL+S/xvII8YAGK4OBmHMQqpCcluNGtMUJZb
 aN+9JIJV9jQ3TXuJ1VmQREi3dvt/Wh1JBZ/ZsWwKmxXYC3rwfsphkC/tL91J27RMhEa1s6SgOn3
 6SxN9sPoE1BaVh7gh8kpvlRyafDGIIYZCeZSlosNcXRR+6IQbiowZloTwEiuy+2heIUa2I6/Cag
 3Nma7q2n50xEyB+b8MmYHGuCOPsRXO4oISpgd/5Jlu8DbijupHpT0eY7Q4fEQuANU0uEdhbR+8D
 ioYO8vjNVcgVmQ4fpS19PN39YLZgFO9Td1HRzdOogDjeHmT7S0v/e33/ru9qDrQLOClFq6GdgbI
 HXC/kdDsqILUMjJhMroFDFVM0clgiKI5bFQr05lkME9EeHSiCo4UCOVDqmWfFg88augI8lSh25q
 7LqU/riPfGDsR3up40w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NSBTYWx0ZWRfX018ig7ipY9Hd
 r8/3Yh1cV4Yu+P6FF9ABZ4dI3Q2dQsjc7NMvdtxTb4KL7U/8HEiYr4bDthlUxnwtbBm+FKIFbbs
 kFhCfptKePKizbcizH2IO/KhFxfag44=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070095
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

When removing KVM support in commit 630decdfccd we forgot
to remove MIPS of the '-enable-kvm' option help. Do it now.

Fixes: 630decdfccd ("buildsys: Remove MIPS KVM")
Inspired-by: Miao Wang <shankerwangmiao@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e44b47de681..ccb71743ee3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5163,7 +5163,7 @@ ERST
 
 DEF("enable-kvm", 0, QEMU_OPTION_enable_kvm, \
     "-enable-kvm     enable KVM full virtualization support\n",
-    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_MIPS | QEMU_ARCH_PPC |
+    QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_PPC |
     QEMU_ARCH_RISCV | QEMU_ARCH_S390X)
 SRST
 ``-enable-kvm``
-- 
2.53.0


