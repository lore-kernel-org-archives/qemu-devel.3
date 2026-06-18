Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D3CD98F3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBul-0005ob-8D; Thu, 18 Jun 2026 08:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBuk-0005iz-19
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBui-000188-Eu
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:32:09 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAs2CL1334113
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZdyaSBbvLPmSp7HfiXGcFIEbJtGLxY0IAt+PrsSrPc8=; b=m+1tfprVZk7CUV/o
 qY9FUKBJOrUlLhuYwsU71B5BNBFAVs6ttdLd2VZBF7HgIBt+kIJfCB33omPVRBb/
 429yzs5kIvj/6Xif5Ehg0hIA7BQ1T2dQsnMSfiInHawOdIDI6OssfndNil0MrFW+
 jx4zP82YSCiqyjP2RhcglAm7kUTk6ZRePHt8hrzaIOdNyiawy/5uNOzesmXro4qD
 FMw7hhl+xBQxGSGlk1Gm8RQxAjyrryAzjIazhUTtOhI65oqjotJ2KKLqPCnLtZcz
 49p6B51CpqrXTtB+NYU7yFFBPLXO4sLNu6xUIcB+SRq0JLB1XTli4k9t8YZ9dFKk
 eS1/jg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev1wc345t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:32:07 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-486db2bf46eso1116237b6e.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785927; x=1782390727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZdyaSBbvLPmSp7HfiXGcFIEbJtGLxY0IAt+PrsSrPc8=;
 b=eCj9ILwFhTC78s6to4WuTpJUPYK3s9NRh8tOXLoRCnciTPXIcSO/GgjrudIS/9XuE3
 TV+wpQiMY8DRrE9VQ0vpldaDDdZuZWU3TcOENtE/ACybBr4QuSMaoq6/UxdJK7V+SGY2
 YbTnQqAKhz9mUexKTIgwLDt5uazx383vTnXKVRCntSAyCD7QPiM/vGfa3uktLE5nPxfr
 wr5khYaUnCNtPXExXuCod7bunu1Q9JSs4vtfTVfdOk5PL4p/7PO5QlwL4iDpqxrI3YR6
 19FG1MAiyHtzFWZvTw4KcUgkPo5tnCYI9e5RUwNzLcbay7ZVReO4a2fnNoQTmThqJ2J+
 Adcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785927; x=1782390727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZdyaSBbvLPmSp7HfiXGcFIEbJtGLxY0IAt+PrsSrPc8=;
 b=N67fFJuMO+NH+UTGdugTg4cftJ6utjtuQ8OEa/1T+Ey17gButn1uw4qInG0PEpyfnc
 W6mMxCbq6+4zYbWOkCql94xyO1CDs042qyGnsyAqjmzfHS8E2gbyxrXNHVRaT/T+/pNT
 2SDRbUMy3u3F8+Rnx8I7DBJT07SyDVtGFQFAQoQOMM/c/k0/4skiS2KqK9pi8QroPb3D
 KepTfX3d1b0xRpoIYEiqNtk4f8c3HrIvx5YzQMiv1C5z3RlfOUTeVeiAxKd++B5PyHbS
 w0KRcSAln4R3HJlEYWquVPgJsuwwsl7SF1HhR5tdHZaz6P6z6ICdCeZcEzSAng/QvvZL
 6z8w==
X-Gm-Message-State: AOJu0YzQ3oYvVkuBu82+d5IJFY9iNSA5oidUh9rvaRYInwBRgEZLS6k5
 QP6ESZNrbdg2LukKtDW9ZmZM4imKQoSG3N3+ZmOW0y69YpQKMYcvLTv0ba/706+xOhfpyyb80Rf
 p9Dh1uAAMBzch0TIhiBD69s28mr9j5Mg9QqONPbuwXDHWd8+neIY9aErNH43rxYmoVw==
X-Gm-Gg: Acq92OFiV1mfgXLucWOHX6fZb0AXc3JTVvMO/Pg5jW5GWWEitTAC+KUKx9aMWxpuKQ1
 vdg8vcfa3ck7UvyPOXmXEe+m4/MOAXdabGRusxz7Lw5+yf3C21jn0gky9DwIaREqLN8pMu5Mg3k
 AJOMjiN1M0Evxp64v8AYR9iWTvCSLsBYjPHlH7100jUdKVlxS43fAhFwEassgMhyK1lu4Gpm54H
 yLx6hr9h8u+mpRTUBpZ2n70qcjJe3iS3psT83rsTPzZMCxlebt80jjIuLLkVuJ6lOn6mkQHjHmN
 i7xBbQCIhD+3t4Wr3EbZ5K/pBCO+mFcQ5vQWVD5g+NyEmPYjzaTjAUKXNXtLTg3jE3C+KxkADRJ
 Mnf5n3nL5nFo8LoG+gpXRrRAswU4COmiGS8XMO4hilEQ76uSK0V42CSC54wHFP/WG9CIG
X-Received: by 2002:a05:6808:3090:b0:467:70c:a7d1 with SMTP id
 5614622812f47-489572425ecmr2779972b6e.27.1781785926662; 
 Thu, 18 Jun 2026 05:32:06 -0700 (PDT)
X-Received: by 2002:a05:6808:3090:b0:467:70c:a7d1 with SMTP id
 5614622812f47-489572425ecmr2779923b6e.27.1781785926187; 
 Thu, 18 Jun 2026 05:32:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm57329937f8f.25.2026.06.18.05.32.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:32:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] meson: build macOS signed binary as part of the default
 target
Date: Thu, 18 Jun 2026 14:28:07 +0200
Message-ID: <20260618122825.90331-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMt1jVla c=1 sm=1 tr=0 ts=6a33e547 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VabnemYjAAAA:8 a=EUspDBNiAAAA:8 a=RsRC25QF-oLqKUPmZ_sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 4OUTs7R9wJ3JQ3nH1E6GTeQcWVs86SBW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX03hMGsGxNnGO
 CBtwWyVciFwtliuAPIlubD8uAtuBj1G8uUmS5FpAiUXKs0peW6pQt8XPyWcNoH4p8lzAWmktTxH
 jezy8ZjMDDIzbCrL5mw+3FLt5Gxe8i8=
X-Proofpoint-ORIG-GUID: 4OUTs7R9wJ3JQ3nH1E6GTeQcWVs86SBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX5QwvdjmKgUYe
 7J+7kzEI6s4a/pAJyC/MuPAhq4J7oN0WScry+BpLy75jUJ5ALnetGJQi8UZIush+hhRw7OdwePy
 N06cZKHmb0veCoUunnETK6/CW1s1+fQhCJ0vwqBvUDnxdImMF+CMLGosJwVG62dK39OWBiNw3oh
 A3c5/BAfQOpIMZIGpR5p7YN+y2kfFPCvUWoleoDnb4cGzTjzSa9379VqMoVLekOFYY+EzaAvHEe
 6Xwy7uQtiaGRd0zvJuFlDwxuCH8sPetlVVHwVRRYNWUB20LA7KwAFmljpKF58dp0hpIHu37MYgP
 OePz4jqo4Al30cIHP7x3z8pBp+iqmxyELb3rwWITdqOooLjWizXv/HViy6zY10W4+PIldgXdyaX
 3z/7adL2suT+qwdFHpjHuzVZBGnTVJyXeavS0UzeMU9nrmfx1NuBKXEBsanYmS9vK4KmCMqx5E0
 I2AlFG0MdBu9lFUdDWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
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

From: Emmanuel Blot <eblot@meta.com>

Signed-off-by: Emmanuel Blot <eblot@meta.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260609-macos-default-signed-bin-v1-1-e013ccb5ccb7@meta.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index 19e123423b5..e026851309e 100644
--- a/meson.build
+++ b/meson.build
@@ -4453,6 +4453,7 @@ foreach target : target_dirs
       emulators += {exe['name'] : custom_target(exe['name'],
                    input: build_input,
                    output: exe['name'],
+                   build_by_default: true,
                    command: [entitlement, '@OUTPUT@', '@INPUT@'])
       }
 
-- 
2.53.0


