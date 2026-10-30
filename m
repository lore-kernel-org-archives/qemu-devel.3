Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C6606A331
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ULp4gasc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XFU7Jy5A
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqj1-0001Vy-Ct; Fri, 30 Oct 2026 13:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqiw-0001T8-U2
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMqiu-0007Oo-UR
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:49:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3LH377953
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=WJi9EW5RBi7PFJY8FtS30b
 V1Ovbu8HwS1CKa4PsFk2g=; b=ULp4gascTQ4Np5pQBPbD1zQYcyqvyokGG0a8Zz
 j1r1C0kJ5bUBgOpiad6ElyfoXIZreDHQd0Cw4BtPlWyR4LJ5+HoDjioSqp2OSXJd
 IIaf+oAYVKn+yCjH2vSP1QPczAdTqfiDaqqIkR+kY1aC2ncvu8tQqqwTCzhg8ZqV
 aG4Oxw8s1MaPSMtRhVnO9TGz7Ra8mHKbmwOhUBESJxm1eiYcJE8/Q0DLyM0Z0ld6
 qAWP7FevZXyDi8YIw9nga7zKPIOP785nVf7HdMEFr2giIexHjYL3p6Ffpj2XFghl
 rMNHvtB5EXWJ9bzVoNtxug3IbWrlTc38nRwev2OsXeFB/nLw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7549b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:49:02 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988c7363ee1so834233241.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382541; x=1793987341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WJi9EW5RBi7PFJY8FtS30bV1Ovbu8HwS1CKa4PsFk2g=;
 b=XFU7Jy5ASb3C11apDM7+l0ZcmjPxx1eAtFvT4s+Hd2+Wd+w/4JijRuR9kn/gIbQ46i
 /aeaA3KlkSs4X/I3Spl0FUXWB+Zs092egC5sD17xvTICrIu+OANGTx7TRdbXGs5hOo1G
 85MO/APtYNomlcNyKpH+ThY8d/Nj8A4vhhZv2Ly6jTNaQUAtWULebP48HLPDx+TGDu3e
 u8GtEvNsDTHOOssG77YAh1NELcaS/vtXF1bw3YkcMsJMhxJnb2HiXPdE6TO5Lw0GnSHt
 iI08UQ2kSIwlzZQkjWiJGW/BfkNoYWDTjNd+3vdvtz4f08xoBlUXo+3Zi9/J71ztFh/1
 PaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382541; x=1793987341;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WJi9EW5RBi7PFJY8FtS30bV1Ovbu8HwS1CKa4PsFk2g=;
 b=WTbcesm/m3SxbrBRyY+PBUpH0FNVzezZYh6bICgZoyGAxUzWjfMwe1J1+wdngG1fU2
 u6fB++XxX1vVoTzXYxWN+EdBlFPUfUNCevstZcH0SsDgnR/JvEz7HntC+nn0PcBErmd+
 z7SkyeILmQdEzVQa5VzNtoXpT7w9DZfd68zBC+4Ql81IbqyYnt45YkC+wuX3+8ys+g0m
 Dkqjpq5+k6dYo1WzveDXMN+XjD/YViq/1p+kwaVUBpJEw4xiNIxKokEVRhj8X7NH4TRK
 ymyAZ/tOCafx9kEZBobd+8TsCsinxK5L3wkm6mQSNOq12XUwoov8AOBRo665nTb5AKev
 1VoQ==
X-Gm-Message-State: AFq9FYIxyu6Btfam9440Mpuihgyu4hw508ryDzLz96gSMNC37tWb/Ifb
 8jCsJMQmOzqv3TNmvFf3EZYEg4MOvrM6RyxiaKxt1NGD/VOk99j7XvXFj/qej3EDgBWyoHeXbt+
 q1bbGQBUUEcVmnRKFkWa1+DCMxZo9kO86GqWH+W/AVwAuTOeIMvVk+7gEdw30cUQSgOFj
X-Gm-Gg: AYBFou0LwB1hPUMjUfilzE5d0fxo44tTJQtDr6IHQrN85nTDnF90WyRWUqmCR1qkywU
 BP0IueKcChUZ4k9+1MxM0G3wJlRhoXQa1QxfzTsJUxetTvoPzet43/WtwnnIUiQmEM1Cc7sS4E2
 XHcBAdmg3zDwrU+S4qwQqdiqpxVvynEaEbOVMpi1xJkoj5/EQV0iq0GNH9iedE83CvRWGQQm6Ws
 AatpCR8HvQWEjCm3E4FMCvJ7AYptfprD8WYjERW0rA3BvUUmjKmVUuITs82dF/CbVNTymUNxiSd
 lOGuz3fgQ6WL7klJcevry/Ji7IE28voFyrjago+YuxplJzHWc6upRNgVUui/3cZ7ZruQmcRHgV9
 abcqQUtdUyrxn+n9yaxerv2tQx48kfHcmEsbpgBcXhwCOfiXEJMLllM9WTp3DW+trw56ZC25h0r
 QKoa3dgRTf6Q/ONWRBAO0CpLaFXM28Rw==
X-Received: by 2002:a05:6102:fa0:b0:7c3:9982:67d7 with SMTP id
 ada2fe7eead31-7d072670942mr1752831137.16.1793382541227; 
 Fri, 30 Oct 2026 10:49:01 -0700 (PDT)
X-Received: by 2002:a05:6102:fa0:b0:7c3:9982:67d7 with SMTP id
 ada2fe7eead31-7d072670942mr1752818137.16.1793382540771; 
 Fri, 30 Oct 2026 10:49:00 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm4613783f8f.39.2026.10.30.10.48.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 30 Oct 2026 10:48:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 0/4] tests/tcg/mips64: Test Octeon POP instruction and
 report with TAP
Date: Fri, 30 Oct 2026 18:48:51 +0100
Message-ID: <20261030174856.98759-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3HNWA_vZwEpFq17HpDpoejEMRyP5QapU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX0ztRRjGgDLX5
 ZFeNYTd0VWSLys6qVdAgyPP5IvzZJw1vBKeoaAol5YsjGllCUCkkSCdPmM/4H5GrWf+U3Bb9SiX
 CrIG3ScZNvR3AD4EoKuQ4Z7XEJgfXUIFgoURA9fMMG0/XRdjMtDxQH0XZZOp39kaCsPQ3upRxRx
 p/lXrcvb/XgU3sVvwzBOyJbGxYnP8VVScMU3odvTmkVCiVIEWjeNHl5+pLPGeuaKbyrxHSewOrf
 5y5XstwdVtBktSzTm1f6YUeRniauokudsJPKeb+5/HvFfNmFDlL2rY6EJkC7d03he2YmzC1ldlp
 vUIQYeUirQXdhGzLTFJG4GwOYKd4KwmrhABthun38RDiks+8qJxLXj23POIMxlXcRlGAdZhEdik
 oyHuVQs6O50yThA0jICZuxXKtMMJ1XKcAmfD5CNNSjsbdTl52qHRfefCLDopaHnrCR96U9LanUw
 lq0NbUqxpJd/98WQvLg==
X-Proofpoint-ORIG-GUID: 3HNWA_vZwEpFq17HpDpoejEMRyP5QapU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX6zLB/lCbxvMa
 OmIhFG2uafRsLHhshwcdpS3YnxwHgItvbI52M5dST9KrLXK2mD0wnaaO7GaJ5iZbzoHiaO5hbKC
 hQqI/Buhy0eUTPiRv+ci+YTJD3+DE60=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4d88e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=BYY_hMU7sNuQm5lfKlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Missing review: 3

v3:
- add tap_initialized bool, check we didn't miss tap_start()
  call when finalizing in tap_done().

v2:
- add generic tests/tcg/include/tap.h for reuse (rth)
- cover it in MAINTAINERS

Leverage support of TAP protocol by meson in the Octeon
tests, simply replacing assert() by a handy CHECK() macro.
We were only testing the 64-bit DPOP, add the 32-bit variant.

Based-on: <20261029151317.19170-1-philmd@oss.qualcomm.com>

Philippe Mathieu-Daudé (4):
  tests/tcg: Add minimal TAP helper header
  tests/tcg: Allow tests to report results with TAP
  tests/tcg/mips64: Report Octeon test results with TAP
  tests/tcg/mips64: Test the Octeon POP instruction

 MAINTAINERS                     |  1 +
 tests/tcg/include/tap.h         | 92 +++++++++++++++++++++++++++++++++
 tests/tcg/mips64/octeon-insns.c | 83 +++++++++++++++++------------
 tests/tcg/meson.build           |  9 +++-
 tests/tcg/mips64/meson.build    |  1 +
 5 files changed, 152 insertions(+), 34 deletions(-)
 create mode 100644 tests/tcg/include/tap.h

-- 
2.55.0


