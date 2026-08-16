Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B99C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8f-0001ya-J1; Sun, 16 Aug 2026 10:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8e-0001y3-6l
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8c-0000gC-GF
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:47:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlbU92761832
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F1o0vnS4K1J5CTBWre/XReXN3J0PT4Fz7RBqYUYDRoQ=; b=X5O9OS2JazrusWVU
 nyW9De2enRhZcWJJviZQvy++fcRLaO+IAX8+AmKgeda/kVgtku7oVoGt04ppnpX+
 IEcx589jpPdD33B5PAjiDlNy5TNb7+vU1nqq3n4kvTAxYlmYQW6+mmD/iAO2k+Uc
 w1VuOjMAj3lcSl58ueAr0MRZNB33a0KvG9kjvjDdsuURFNRShAh7FZU85GGMsmkI
 dYusrngAFhreFosfwRlujvrDbyUJ6vawHjMbVz0H60QDVknx3SiJwljYCOWtLFys
 K2F7pxxrkpdrnPJciD4Z8myowXezELIYZV6yY1gHMKuFIJRk3bnePTjlE+oNeoA3
 4X8hbQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2h9gkh0n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:47:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso25628836d6.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891620; x=1787496420; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F1o0vnS4K1J5CTBWre/XReXN3J0PT4Fz7RBqYUYDRoQ=;
 b=aawyFptfFatiCyc1ceHiDR2XQTCh0pcwk3eiJw62W5KgPNGyY2pf0oiZE4Hz2NUHYL
 qMmgyt3lm3GYP5MYgQCh3jvjIYNQWn+gJPFu4ldn2eTCJhYiA52NI6MfU2ox7Ay+pCr9
 xjtqDg//VccIu1cEeXw+d9ktIwqGGywSh15kndWqD+28efXax1Vh0BwfmadT1tVw7KVT
 KC7Mw9V3MTHf7hZcSwgwfio4ZwLhAynIsgyLNnzdDpd8wX1kdIpTs/Ne7imLaykfL/Oe
 HqAjM3r6SPec8qkVPUewvHAuqdLeGpd5RsY4giVNIfEfT0SgDA69nrIkDLt3IGrntoyv
 0htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891620; x=1787496420;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F1o0vnS4K1J5CTBWre/XReXN3J0PT4Fz7RBqYUYDRoQ=;
 b=fuMbHephU5DYtKf9nWo5xfKsi+o0LEn+iLJSXSCN29fnHWXy7XgLJWhjEAuDJUZQUC
 ADxr2Nx6br6OclGmiD7ucHv5x0Ww8ipHG+ImHn6xBzsAkzRXebWpEgVJif8Gp2FSQk9z
 EjRYupuKvysu1UZ5YHaP5RKu4wKVCyZaq7KCIyPZoG0JQCjkBnzXV1xW9lC0jyMLR5NN
 TEtHIPKzyJmmcqtbevocJH2/2dH0a9YjO4rI/k+jWeoVf591syPBvJlknBAq+uN911i4
 YQK5qhSVUDga8U3swLJHgqGUOna9f5bIRJL7TfVtQYJjIX5OEyUMXrebpZhtxCWUq/W5
 tiSQ==
X-Gm-Message-State: AOJu0Yw2p9ooyF31r226olcEPGTdI3z3YtMiuD5kwHK3B2Y3wMnzrBuw
 wD6bu1/ZjUlowgdWaltK/a2CTbBzXVjnhKR1dJwzqeckbc1Nbtox1lY5Bgeqoqg1/TshX+/P5cs
 01CVzkOjf7ANbuBPe5f4igmEx40W9OahveiO8PUtmcrGv0IBXs9cIMsFstpggd8lqKw==
X-Gm-Gg: AR+sD12yrujVhQxAt6Hbf46sStMdDhcIFo96ywkevI8B3C+cVjlE2hrRvKG4lJOGnRG
 5TIKZlH8yinodpl9xmA16dj4/6fjbBHbBX4APH4Oqszi60E2/1CuseA8OlBxCDR5zd+Xn0/t/vo
 G+0UHcbL39s8i9SS1ccgNrgnX3KBeaEYY8bcyRIRGkJyj7WlRV1jWvoquCFUk9Jj1WK5nKcZvxl
 NXQTFN0m0tKQRttfKjddIwT7ACjiby0fDRosSMbp3y56c0hRJb5NPdTkwPHZJnXJtoA4RU9lajj
 tAVJlUZ4ot/RNbIY37uIcxjX3ktWE9d+7dAqO+t5da8Aj16o0kt4CGL+yyBcHIJOmIF9QWvkE4W
 QM9beAyrkmKeuDLpdZOfyWDmcv5ERb9Cd19CRVch5Iw==
X-Received: by 2002:a05:620a:170f:b0:92e:603f:1f20 with SMTP id
 af79cd13be357-936d2145adamr1574470185a.2.1786891619892; 
 Sun, 16 Aug 2026 07:46:59 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:92e:603f:1f20 with SMTP id
 af79cd13be357-936d2145adamr1574468485a.2.1786891619463; 
 Sun, 16 Aug 2026 07:46:59 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e18fsm45234755e9.8.2026.08.16.07.46.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/56] hw/nvram: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:07 +0200
Message-ID: <20260816144556.69009-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uvJvuTtzaZ2T3K4G_TpG5QGrFFArVrZ8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX1TOvPFg+tMbx
 2puscaK/Y0oClEWX6/vh1eblRc4+8nW4ycDTpcecTCNiJYwf0mXAcgpdz8DMVt85twS5GpoSp55
 ki0EA73pBVnrNa8iEAhNAjAXc2FD1EI=
X-Proofpoint-GUID: uvJvuTtzaZ2T3K4G_TpG5QGrFFArVrZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX+cr1UuaqLzOX
 rmZ4kLCOPcqZqM40dnp8Qr/YcdAElS0G0jYSsaI8PS1/a45ye50zx6P1O1jzk0faJA+8uqyuhPY
 2t50s3/gLVT/5o5+2glUfADqvNniQDl3dzCVkgXOV79tUX+61Gn+HY3OqYhM48/2VNX0Dx/V0D5
 4giKz8ClleMaEdlUGYUdmnBcVALxdKZom/+ayR3AQF3B0Msq0EyBx3JK2nZD7p+/LZhaOuJ9x/q
 X1UaKb6+IJZOC3dYqcr7N07Cc0HzEVwgeoM58coip5VANmiR/u3Cf/GW392JlMUwE9w0hhPkJKL
 OMQRFCDPv9ivkvIXPfsJOVLrtdMP74YS9nWZos0RHuJWhCRSyy4/wlJ/DCKn1MJ6OlVWkHxCD2Q
 3obYCrjZx//RxEgkPtRoLiS8/jvdmdTktsZMUcOG3qjEWK3zP4e1Z/+Y8I8/+BNRgok5YG0KXO4
 uD/8W0wH1gjJP7Q4grQ==
X-Authority-Analysis: v=2.4 cv=XM4AjwhE c=1 sm=1 tr=0 ts=6a81cd64 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=uRxLgUfnyXHAhkBXUOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-7-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/nvram/xlnx-bbram.c | 2 +-
 hw/nvram/xlnx-efuse.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index edfb592a5ec..e336874bdef 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -468,7 +468,7 @@ static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
     qdev_prop_drive.set(obj, v, name, opaque, errp);
 
     /* Fill initial data if backend is attached after realized */
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         bbram_bdrv_read(XLNX_BBRAM(obj), errp);
     }
 }
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 1a9650ba128..03c9fbc0d07 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -233,7 +233,7 @@ static void efuse_prop_set_drive(Object *obj, Visitor *v, const char *name,
     qdev_prop_drive.set(obj, v, name, opaque, errp);
 
     /* Fill initial data if backend is attached after realized */
-    if (dev->realized) {
+    if (qdev_is_realized(dev)) {
         efuse_bdrv_read(XLNX_EFUSE(obj), errp);
     }
 }
-- 
2.53.0


