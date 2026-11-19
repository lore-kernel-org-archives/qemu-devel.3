Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481560A260E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a36EZ/zt;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iw4wcIzV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAJd-0003QU-3I; Thu, 19 Nov 2026 17:09:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJW-0003Mi-63
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:09:06 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUAJU-0006ln-NY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:09:05 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJU3dV1113054
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ltHiwHgjiggOUQEJEu8RCiVw5s3vOXJQB4loMqc0Nbk=; b=a36EZ/zttZ7796QW
 +lHl2ryfLfju1kVcRnXOGmPJELZyfHLo9aGAJTr0VzsBwtBBCH1W8Q72YHI/qz9D
 rlP5bSl9z6ydzAyIuuFpc7ca2rRlXDHf9KzzJJbkvCLhSJXCmlIGJndmcPmNbMXa
 vqXG6FB0vyxTsfVcSiJXtOdOGWFGItkmn4cZI0BByHq09eIYlWcw5DQ1/ntGj/nf
 WGlxPDJAtFHlMgG+Tpi1jyyO++n8C9nB1cqLsmPr6b9e9rjCsTSsSTvXH5eqEuOU
 zsLOV3yM1ehJXg2ccfA06PRgGArw6Wh7I5MSbQPX9AkenCI4CwkjFoYFl3pVQ4ZA
 xHRc5g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au0pcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:09:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94960131befso50800085a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 14:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795126143; x=1795730943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ltHiwHgjiggOUQEJEu8RCiVw5s3vOXJQB4loMqc0Nbk=;
 b=Iw4wcIzV2AeNogLMnwZ9ANJX/6PRTqKEAt2qEuisWNdRj/byvku2Yyj28t6sScBUZu
 VfJsRkSqBqgGYdQi3Oy1aJ8VzfG+iOjoII2c/wsCx/j1kVxVQ8sUYj1XHJPAAO2pqnnV
 V78vBjXnqLt7p9tUVDbU0iQWdv1AxOE6+eaiUCSJH4Yh+8LMoAmjLLshYIC5W8x0yPTs
 3vBkkShTE8/s9ma26oNDFLZ9YRGyCqt+T5S4Ms/luzBah5THc3FqMXNFQIaCVAGYbnI0
 V2FDbQHqcQQy4IfTk6T4JMfb5TdLFWT/I1mYeXFicLoR3vwq+todUcS7/dLsEDAMm7eY
 wiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126143; x=1795730943;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ltHiwHgjiggOUQEJEu8RCiVw5s3vOXJQB4loMqc0Nbk=;
 b=cNO2M2ZjUFM1+uO3tEND0QlDZU00DbaVJVowmLXlfUpMDcWdSlIJ8pCLIZdrCdrmfy
 hPjiCDspATSTjvA0We0rkluDORZyzFfdO8tyEMgIP+dyWf3tolupv25Pc15rBr4ocIp5
 oFzxBRKLUxDcjFZ/ypBIcdEFFaVOezfEY3YTSrIrsNX1v9ay5DmGMPotcjRqPIuw19Wp
 Tp9hDugoZOMXdXFA81jw/P3Y6l0D+HaXb2MAu65wJgA0ihqm2RtExxT1q6a/lmlK1wUS
 cXGYY1lrfgUrIk2JW0DLWXWMeEmiqSzV1WiMYxkbo2Qrvyyk9c3Oh4z59Ujdcu3ZKDsw
 6SEg==
X-Gm-Message-State: APuU4Z/0495igCzahvX4D8lJextCmpz7sxmCgOKU16VUNLwb/sRL6v2X
 u2SUCz+HextELn0smjPYKNz0A7tnMT1SOOIdJEDO3c5KStCsyzgEXRJZIDX004Br9ilvyFZnj2L
 c5lYjzW6XJso5HluT71UKH18vF/xRJxnFd7WsbBavA4s7N2uEwcdHOmAPJZbxIOrMP+R6
X-Gm-Gg: AYBFou09WNu8JUPD6qdYhqOHp/5I2a6fvPUw0HSnmGmHByR5+1CZVyykh+C8a6lIC8x
 XBHb73IjcdfWUvinmSAusmSyvrP22jY9+lqhfnUHWS3h5+mcQkJM8rZgJOM6YRt5w+oXVVyoe8P
 FwvpG1kjQURcQtTZIjd9PE+cd0X780pTPXStufvaMA8yAswlx6RO3Ikdfe6bNr8sbzjh7YZMQT+
 3i1qFC9yO2K0phfOmX1SvI8KmQSB5Cs6bN86AysT8V21bVqrTjA68tA9zixXkRW0mF4X4Q7bAzS
 ZuhZ2uZz2CdNLgstoDXMcuiEmUcrZzMqUWrnS/CRjPjY2HJ4JbsQih18XhKojP/zjhJ/j44PqG/
 FTobthI7gAiPFopDUQQ2U7r8zZdHdbKc9xvw7PjXhQcSZsz3Q27g7r8U61iKt9zRj06aCGfWRyq
 ASohiGw9kf6R0yDA==
X-Received: by 2002:a05:620a:6011:b0:949:733e:ddd8 with SMTP id
 af79cd13be357-949ba9ef1c1mr160140985a.54.1795126143052; 
 Thu, 19 Nov 2026 14:09:03 -0800 (PST)
X-Received: by 2002:a05:620a:6011:b0:949:733e:ddd8 with SMTP id
 af79cd13be357-949ba9ef1c1mr160137385a.54.1795126142610; 
 Thu, 19 Nov 2026 14:09:02 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f6b6a6sm18273895e9.5.2026.11.19.14.09.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 14:09:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 3/3] hw/dma/i8257: Honor the command register group-disable bit
Date: Thu, 19 Nov 2026 23:08:37 +0100
Message-ID: <20261119220838.52034-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119220838.52034-1-philmd@oss.qualcomm.com>
References: <20261119220838.52034-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX4i4c40l/G9Fv
 EBtCBIo9OeaA3W6fsoSMxAE3ccuzzYcW77/Ilu95tij3BEjpzSP3ckbaUp3aA3sQq4FOeP2LGg+
 8l23MPViafTD2O22w4VdVm0F/DeAx92cV+GgZkQyWpa/fw7/Zx6AprNfTOz/su9uiqcU6jxRByY
 ggiE5zji/gOzxHp8YM7ubpNciecvfZpz7Ljp1wZAiU+h1hVQE3DQ+gkpcBhulNDQLXTOEm29JWv
 8Afm46zOn/Ka2Tou4yZVP28BVuPslWdE2BhQbzMuDfCl6w7+WFSrt7Y3W9Rw0a3LttiVX+1uGUN
 38/EY9cPbkHUnJ0ShfvmDZqIXWoyQ/zIznRt/X92okW2u5Tly5rrowdMg6diPSy8M0xAm5S9eEQ
 XAKM+bYWOTnyipgk3j8IcZBQITuQdVwCff09AAmrCBhjWxiPBe15qhCpb3BwLIFmxA79w88u22z
 oxBK0EJAdpm0rXYcPrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OSBTYWx0ZWRfX0Lqdrq6cO/pS
 a1MXVvWhGYWyM7ZaPbOPt0jJAkQ17HGotIAM541OO9mxNIOtqbuT59mtZYVoHxENDvJuIZgRyei
 bLWw/jwVfiqYQWTD5tcyFz9iMMxC8Fg=
X-Proofpoint-ORIG-GUID: qlqLD3jsEKKj1o2amQMVgvr9NpA4eOVA
X-Proofpoint-GUID: qlqLD3jsEKKj1o2amQMVgvr9NpA4eOVA
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6aff737f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=BZKEOktK5fCU6sL8zLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190089
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

Command bit 2 of the 82C37-compatible DMA controller disables
the channel group (PIIX3 datasheet, section 2.5.1.1). The model
accepted but ignored it.
Gate servicing on that bit and re-run the engine after a command
write so re-enabling resumes pending requests.

Fixes: 27503323968 ("Soundblaster 16 support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index ade8609ff438..42143ca57dd6 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -195,6 +195,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
             return;
         }
         d->command = data;
+        /* A pending request may be serviced once the group is enabled. */
+        i8257_dma_run(d);
         break;
 
     case 0x01:
@@ -355,6 +357,11 @@ static void i8257_dma_run(void *opaque)
     int ichan;
     int rearm = 0;
 
+    /* PIIX3 DCOM bit 2 disables the channel group. */
+    if (d->command & CMD_BLOCK_CONTROLLER) {
+        return;
+    }
+
     if (d->running) {
         rearm = 1;
         goto out;
-- 
2.55.0


