Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF80C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrJ5-00073L-LP; Tue, 11 Aug 2026 14:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJ4-0006zZ-0D
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrJ2-0002S1-G3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:34:33 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGOeEm1170783
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=; b=Bs/fYvUYJ4ogkZtE
 wkqQrJJOcv5GO7HBEKrp3uVlGoEJmSmTfrnXawG5qvg2EnlmUVnG9w02PGM9pIH7
 E2tYKKqNVlIS5S5fam1glsvs/fM85wPw5rjYQIVgzcrzgS0YQEf0FRlvCEjuWkIM
 bzYJA35x/HHMHneRFGUASfhf3Bq8RcF+YizVVYWcTen3qQnUZ1wr+83lJe8vgFTc
 EqpiKd7CdWAMk/cV1T+UQbRioOiC6sA0FCTDLTRKFTBK6MIb5NFUcXFuzgX5Lev4
 +Btx/JjCYBNp4QcPzCinCDcfC/euDCAZvP3x0IzpkGjt1ZsK92xWwTYwErmucEPF
 pZt3og==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g01nc23en-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:34:29 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ef8249f871so1362366d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473268; x=1787078068; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=;
 b=GVH5A87E7PNFHYXUJOYuk43rWTsv6CvcTwebEuoRmk7FeRvDDCsG7VcL40y7G8D8mc
 KelL9gprO0g+Aww4HF4FN+VIY+ulP+7/Vo6ncsyn5packpKqjS0IYOlzD2cMPGtNha4s
 FcYpM4VckvqMQxE8forNzrqts/YBQMEi3EOBkusG9yZ8Ycy60q8zEGZM4R0nu7OQcifM
 xJw8XozaDqLpE1/H/NHK1mUCCWgtMTqQBH5NPqmID0JY4g15rvjD9gPfXRMuODh7flmv
 AvvfKWsenw493hyi8mwVkvfu89NtoQ9gAzk/EoIPwmGjlqWw5t4KlXeT/97USmqAxMyp
 ua2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473268; x=1787078068;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yx5DrvqoVG7WzFuC4QcI2wBJN4WlDhAJMkg2Y1RviQU=;
 b=fMiGxgoooysiRRaliC6sEq9TKhQn+PE9oHnaTu49SA2j/LNlIi8mT/NMy3B53SFdK0
 1cJGWS3TxUERQkd7oFNk3E74TP/ubj+GkDpCZzUkOgj03VmJz6dOBfSuy2mH+Z9SnPtF
 qtwpc1ND5gshJmFIxLv01bXd7u8gXJqdDHAH87DLu7WKnpB3+yV0lo95yiB1keoDR0xt
 zaC3Z1wPiIfSOdY9Sh7QyK9rbRY2fHhrZRYkt0xPxAWVDuFQYo3glOPImKweIMEg3X7o
 ZO9gsAoDBNRILIxyGoVZEbWix34CxfiAuLSD6FO3spurBkm4ohDYDV3kQVYRzGN0MHqb
 e0PQ==
X-Gm-Message-State: AOJu0Yx98HYD8S24hAN0jCAphgD+ina79IdjqzXiZv2JnTKwRJtcQL3q
 JqHtoeV1Pi6yt29Jrw1+hVT+KfMFxZUicBLYG4uPcFfZrbaUoKwWiJUuv4cKlvkHQFX/NNgE+3F
 afexRVlorAOK4z5ctq6osXY5o5IEXlmVESH+pXncuUDBJcwOIO8dOI5pLJvQukwai1g==
X-Gm-Gg: AR+sD11SQFCy3clAF/u8ZVE0ACewm/3t3Q9ojAk6aCSMIyapax9KFB3M1EdTsH4bGQw
 3igeMjFPWmp/gfS5fJER8l/cfhurwEQh2/yjNzJf/gozBHmen5P4pMpchQ381DHb3KgRoDdjPU+
 q4lgwy+5kCJw0VGFiwklN4mbRRvLtKAiQLY5/V1NER4za5iJgChhkckIad/eJo60fBYL6MbRcVE
 WspFE9F4kpb50aArTUFNL4pijjLvsM6g7xfWW8c5P9TDfv9CGX1Xc+oWEREGkXJUVcpiaLanaDH
 62xg84FWMoRy152Y3m+pnSSyuMUrfnvQG14iHYSdU+FA2jE9bbIZ5Ml9OfABrurw+jzjBzEpuYI
 9IdmVj2x04X77HlSKEPZx795/jblBkLa9ePQ0TliJzQ==
X-Received: by 2002:a05:622a:2611:b0:527:69dd:5413 with SMTP id
 d75a77b69052e-52d584ac3d2mr48841581cf.5.1786473268433; 
 Tue, 11 Aug 2026 11:34:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:527:69dd:5413 with SMTP id
 d75a77b69052e-52d584ac3d2mr48841211cf.5.1786473267917; 
 Tue, 11 Aug 2026 11:34:27 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aac6e85sm10692135e9.14.2026.08.11.11.34.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 11:34:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/8] hw/cpu: Include missing 'qemu/accel.h' header
Date: Tue, 11 Aug 2026 20:34:04 +0200
Message-ID: <20260811183410.22428-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811183410.22428-1-philmd@oss.qualcomm.com>
References: <20260811183410.22428-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX4MR3/wRlUOvq
 0SqAEpiji5v/MtWIUcCEgwBZGB0iLdD8piBJSdq5GCRaWLQ+rv1WyEuHqgDGslfVbnr1uEkkG/J
 4cnQ7+7RWHEgN29HIVvZfqpLSLy4aJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX5/M0kfwRuadb
 S0g1mi5Pr/lPwNhqsg06DDuNP/UN/btChHsnVQRyPfP2qMZkgs1rHiZh9ycwJ879t+up219kx7q
 4f+j9UHx6sKxgG1k1mIGu05xsW1sMfFgY7ybTU0cNuIOSmVH/F3IN0kNZnn0SyD19Qr30gUthhd
 rzVNdsSJReH1XnPJsdIhkYxP2WIlPp910o33PgrnANH/FFBi6ik0oqJytufTBnofZVcT3OCc7zX
 dFohIdY+hAkIqKraH76nffivWQgAOQSA/+i+nc9bGKrKmur3Exp09d74WSJzkdHzN737i+bInh2
 OTR6ieJ4d3xdom26MXLUvWu6ttfBQWAsjaDTG0G0FVh9ZU5y2KNQM+yMdguGdOUzel8bJbyEkJt
 dlV0kmagzxM9/mR8Cj0HRR0p+MhfafRE85QD2QZRqjvHdBSTJz9rlNl2NoQxYwEV5ffR8s4t5Z6
 a12gMmDUwUmtZBZbeVA==
X-Authority-Analysis: v=2.4 cv=RY6gzVtv c=1 sm=1 tr=0 ts=6a7b6b35 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=z_YzvCJ9eykze7sI9H8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nDYNmZeslsLqg8grYkipDMjcNRbTzfPe
X-Proofpoint-GUID: nDYNmZeslsLqg8grYkipDMjcNRbTzfPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

cpu_common_realize() calls accel_cpu_common_realize(),
itself declared in "qemu/accel.h". Include the latter,
otherwise we get when refactoring unrelated headers:

  hw/core/cpu-common.c:233:10: error: implicit declaration of function ‘accel_cpu_common_realize’
    233 |     if (!accel_cpu_common_realize(cpu, errp)) {
        |          ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/core/cpu-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index e314f916f84..8c9ff25e04a 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -23,6 +23,7 @@
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "system/hw_accel.h"
+#include "qemu/accel.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/lockcnt.h"
-- 
2.53.0


