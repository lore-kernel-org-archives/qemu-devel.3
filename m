Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5885EC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8n0-0004sp-OY; Wed, 12 Aug 2026 09:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8ks-0003fh-Gl
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu8km-0006SO-Jt
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 09:12:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CB4YFo3619709
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=; b=mzaC/IKqwgbyDWsJ
 ikJYJO0e/v465gCCZoaewlQL201pTeWKSDgCT+5kMxePEIj73ehWZlgZf7wBcIHA
 7zzzSTNQIMamVuVXyAjTbZg9/nEz8bB6YXsnQkcb1fKjuDVXMV0i3wofxk5gKAUS
 z+c5RT6LSqq/AnTDNXqdi9tEq7vzAd2+csrBdjNS4nrGEgSR2TcxwZ7RIwSopFV3
 DSDAPZ65y/Nx749OJiYWVt0/c5f3WU+8Ilc1DXM3Xglz08hqni+0VWZCP0AK5W/G
 2Ouq6ZVSsYZHUitgYdMKSlea/0lkTa4rPh+YdOxs+0NUj7BnDU5FtxJP47KjfFvA
 nEtfoA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj2sy62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:12:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d30035dso8782031cf.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786540339; x=1787145139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=;
 b=W2wKrVVHne8Wb0D5LaHj9beZomk0Bf3U3qCkEH56GyVRGNZ3nimvdg1jhSF/vJd5sk
 cUZgMZpsl8HRGzv8CvZJ+XOMpVKxnnsCmgBcv/wpLwQ/L0LQCtFn9AKt4w0IOs66zW0/
 shihm2ugrWKUCj4Z6FEKM0jN2mFY0z44vKzs2c4XDdqaRWq3ADZfxsvbT/Ii9C1grXKE
 9WpyZXJoAB5CZuK7coecPW/ojdtZJym0sYJZQ2NuqviOKo8CjF5ZKriLtE/WQCO9jw4b
 zvN7Xq1DpzJ8Z1xtrbiY6SmWm3l3LHLkcTnk3o/57Qp6lapOZC6f4VklfCCbdLQKsgav
 Qqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540339; x=1787145139;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pte7PXi9rfPSck3gExkYCTKXjVhMybGFWn5OGeUoYwo=;
 b=mbD0KKE9EFVfNS7WgWb3tpDSvvtlR08CHoaArcS6BxNCpJ0kBAtaygVvP06q1dzUAV
 zWC2VgIhtqenA5VvUMg4EW/u8UPy0J0jX15usEVIjrjkioKslmauhPB0NBjtyNR0f6MH
 8Pm2cSVEyrK4cJWeDb4S/xv695Km7gRzwNZYJLD3S5FPdaEJqphtxR9N/qSeeYJbtrjS
 TqVZqCkmLJ0YReB7SUyn8i0xYY/VN83hA/dxBAEoq2q6t3HjbhBIIcsGiU2cuGyq7+1t
 9slimzn40Da4ZO8mAhRF0DvwMs7qUCJVWEVAn6KGFQXiOChrTfNxpOBFsQBcoubj2kwK
 03Xg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqx3dcxcIv1551u1wRfibo6HH9TLp4O6Lku3si75yOE1mQKf4z3GxFD0JjaHF7gCE54BKGmlcbSmQH3@nongnu.org
X-Gm-Message-State: AOJu0Yz/jHVxOkSrdmFzDB1l3svuJ3k+KQgkXfW+6K+/Jaivehv9+Qcx
 mC5NLUBfJb1rSmWvFsCdC1WwFDGyBUtwoSO6GxAvVmeCbZai0NZjhMGyuskrIhwSRXt1ZdWSFrE
 hYM8l9Pp3b6RrRaPZGyLoPe7KoumizldETK+MNSdH48EtUdBnGfCssTGELA==
X-Gm-Gg: AR+sD11bVnCTuAVtiXHA3j+Re0v8Eys1Uz1g6DJCJhJcbAfwkJD1cMU0Et9FZmBbza7
 l4xeLejBEYSSon9zZaRrI6fF5hqYM+QCH4AmNLN2j/43bq/77c71a6GqCer57XKvuub4pbxfcLL
 reaQWaQowVIiQ1sonD2CZpGn35+SPp99J5jY0RVIIuBnNHkEWrzkyzh5M6OQZlwy5sXlKAoN+Bc
 sude3Bq6YinAMEkvmAkQxSkHQum3eiGf1xne4nwHUVn5tmec61aUsnHZ97fICQKGzugxl1taqyV
 1cH8sj4XnVTmbe7ZxvAUXWp+FtcA9dx9S+H7mfPALIADKD0ordx3hslHHSSodKxo4Us5HO0Pq+U
 jET7z8+9s/1DRZdauW8DlyzYa1RawWiiypyltLdUUHA==
X-Received: by 2002:a05:622a:903:b0:51c:1532:ae84 with SMTP id
 d75a77b69052e-52d646ba976mr37951431cf.6.1786540338971; 
 Wed, 12 Aug 2026 06:12:18 -0700 (PDT)
X-Received: by 2002:a05:622a:903:b0:51c:1532:ae84 with SMTP id
 d75a77b69052e-52d646ba976mr37950521cf.6.1786540338441; 
 Wed, 12 Aug 2026 06:12:18 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d4e675sm7727843f8f.23.2026.08.12.06.12.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 06:12:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 04/16] qapi/qmp-registry: Remove unnecessary
 'monitor/monitor.h' header
Date: Wed, 12 Aug 2026 15:11:35 +0200
Message-ID: <20260812131147.83188-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812131147.83188-1-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a8EAM0SF c=1 sm=1 tr=0 ts=6a7c7133 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=pyR_pgRpKyPxIfy4wdgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: lLUBpkXDgzXI_QJuHSKeEmMUCOInBLbf
X-Proofpoint-GUID: lLUBpkXDgzXI_QJuHSKeEmMUCOInBLbf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfXxHEHsth/TgjI
 bkIsGBQfHA0fR8kE2VMkbGmWitgNhjEbeWddnZP4JI69IKwH+Ycs0baRoo650qV362pNSyMnlim
 4wttzpVVE33994ka4frsFVe9IKGO4iw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwNyBTYWx0ZWRfX9p7Y0pcTMnTD
 mAQMbX7M6VJAW7QPKyiEDyf8NVSmXp0WNSh8LlUIvWJN6g2EBXtpgHZ56WdaZi+RI4XSVeY5UAR
 1Qnqnx8IFpxrBAIEAYpg69i2X/YEM1abbKBZjH5/+oOjV2PmTTAcyLDvVG2rR+gDpBQVQBjqcCd
 v7JePgfx/JSBgF5K31Qy0htve9hUdAaiJBlZXCqKo4/4FTEdJuURnehkKESuvm8QznZiqWzRH12
 BVNFPcMALiuxnHw65AY1lokqyZ9bP/q/C8rUbl3l2T1GcBy2PQSFRl8aVV9JmUl2ii/6icnnAzG
 Aqvteg2c5HiJSm99nx4QUZIXuNwXGh6KuMmaqeP6S5uGfGejncPzwb2u2e8dcAliu3lyKk3BVd6
 zjOjvXnC5mu1UDVlB5xIusnqJctGR2qiQLyyLUsli0LASZ2Gap/5g+uyNb4sp9qePxoXx3shbSq
 3YJ27yRVwfCUtt8UoRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120107
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qapi/qmp-registry.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/qapi/qmp-registry.h b/include/qapi/qmp-registry.h
index e0ee1ad3ac6..6146306a3a1 100644
--- a/include/qapi/qmp-registry.h
+++ b/include/qapi/qmp-registry.h
@@ -14,7 +14,6 @@
 #ifndef QAPI_QMP_DISPATCH_H
 #define QAPI_QMP_DISPATCH_H
 
-#include "monitor/monitor.h"
 #include "qemu/queue.h"
 
 typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
-- 
2.53.0


