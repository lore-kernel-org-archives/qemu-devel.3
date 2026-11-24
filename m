Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCE606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J5WmQYbY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HYVf0SYr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzep-0000tc-To; Tue, 24 Nov 2026 18:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeQ-0000NF-PS
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzeO-00053L-Sk
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:10:14 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMb6TG2288818
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fIIlKYL+ju9W+rXqb62zKap4x+6/YWsihoZ5/f16lag=; b=J5WmQYbYV/kTI/k4
 09KJlpaB+HW4mNTLFZFzOhn0UERiMzOQNAQ8eENHa7jVtXGC4aOb2zoJhy82XkOK
 hmckeZpiMQuDpYCs90qskFyxkAUd6+BXsq2J+YYXa3Y+sEKu62h69SJ6aD8Bm3jz
 YpQlXsHMGMs3jJc1W73yJeFaWnI/OAG3ORB122POuh2gqsBXgw6WACxbP2+8n4WX
 8zSUEtmvhaL/WMvSEonIN3Li8tF2jzosN1GGKjiHV+Gy97+wDLo3vm1l7veoplsv
 I63syTIhVg5vDSDazFN6QHKBGITL2J0q2sGnkWKELfpMpsLs3l/M2oqjlI8Wmc+x
 tABR2Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5egs9cnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:10:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495a1f5e47so808399885a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795561809; x=1796166609; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fIIlKYL+ju9W+rXqb62zKap4x+6/YWsihoZ5/f16lag=;
 b=HYVf0SYr7dUDoruVkNcgE4l636T1DhmmvM1d3Xcu7sNLpYYWOb6oQUSd+/4Mj6OnGo
 RxQD8/ifT3yVKdEe2CO5ePcNEXs4nNkxr9dvOUCi2CQBJbPPDd9HqIij3QIt2dzCXagD
 9u4A/01jLEK1bV5PsfyJBZq7xu85BEmrfFFpievFz3d2RMM989ASimo2hrRI3znL1hj+
 cxI0FGknZnQF36m9A3HjOd9cAf5Yuiu7FIHO2pLv5VPlzzghxDwFB7Uy9h2S3F6UesVm
 2JoXa27QOoFoH/OvJmmn87skG2GkB7X0PIWQq7i6Y1XgsgUvW67KHzCscomtQq2dcr0f
 I0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561809; x=1796166609;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fIIlKYL+ju9W+rXqb62zKap4x+6/YWsihoZ5/f16lag=;
 b=s0woUY8NWOSYzQRmaxB6ntF5I9HYhz4GcG2jJtfYopbIzqctcZamYSguUqzYqAU+QK
 D/W4YRcFGjxfuYbrh6P2No//uKEHIfy5mRwJIZLiQqxZ2Oaiqp0LH2EqsftqvWDO2nGc
 IsvIydeCzzwUutInBhkmlvlMIlVIxsX/Eeh0ibCjjHFauAr4upr3wTAvZiJJ8sKuhyh3
 7urkhQGIBnMpBlx1jQbTjpI62/nuQUm1+PJQy7wg9F1Q2BdHzO5Rx0s7aFH0G+dMPLOy
 QENJnOEg96BavGSDG1o8pGjdySWcCssOM6JbYrU61zTRVDDsLMIInCV4OytXM6RGstfN
 Yhaw==
X-Gm-Message-State: APuU4Z/UdE9V9WZrRGJuUqP0My5mXuMLFByEt3jtoYUeFgIDV5npHwjW
 3R87s0Xlp/eKqfMftA/f/5+v23rkvpG40P+mptFkRraEM2w+ThqUJuK6rOSSJbGxT42mgq/A0wm
 VAYteie9VAhF51CqKsLAquRaomJwlAyEMjo9S6bSd436uD1rI8Z+gEcgU/geVWOtZXcG8
X-Gm-Gg: AZFdTZfcBVYRpLliMZ9l6pRffj4lHiF2i7Id12bV5awZ6DmTEfmj8dsVMnNzelmHhYk
 TC8uLMP9qg3R+wUvHdHLHvqxABeuxLGgYomxV7bAsLKoYk7Rn2FR5FK3j3OgTuhiampRFunklE8
 8K6opOJhwGONyKkqSgdG/SD50eGyq+avcqM5rslCw4JiyENK7ePl17idcxNcSgrW013dM4wa3NJ
 XVUJncLgKckjHPJWwrPpfSpeUPKdIQ9LX129ET+GM9pm7C7dGn0/afXQDg3scdynK5DMgpj0Cnf
 ACIlUFEsRsijKhtohNO5WWY7qvKdH6UrGQQc0wfO5aPPxdBzctv14yf8yzl1JKNUOc04sg5sAlK
 gelT83c+XzFkieg7iZE7xSXFOei/ONNjTelKb3pZ9T/tqPvy9z6WpCuDnJl0+6EE96Vi6E+mMuq
 hBvix7P5WtWkic2Q==
X-Received: by 2002:a05:620a:f04:b0:949:3ba5:15d1 with SMTP id
 af79cd13be357-949ba8239b2mr2820045685a.4.1795561809177; 
 Tue, 24 Nov 2026 15:10:09 -0800 (PST)
X-Received: by 2002:a05:620a:f04:b0:949:3ba5:15d1 with SMTP id
 af79cd13be357-949ba8239b2mr2820042385a.4.1795561808685; 
 Tue, 24 Nov 2026 15:10:08 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm31281053f8f.16.2026.11.24.15.10.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:10:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] hw/dma/i8257: Read the mask from the RWAMB port
Date: Wed, 25 Nov 2026 00:09:07 +0100
Message-ID: <20261124230917.88704-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX81uq/8lxSXld
 v1vA4TemkYgfGRgULUtD+ntimiy0R5C+9Sqw66W+r85V3IOTMEQ4x7Q1u32GK4R4uti3LsJrX4X
 o8N8pTth9N7OhS15iE1bw/tZlDuCHfxrKJRCJZW3XKpWU+sp/wB7tF5jrp3XRRgl4eq4XQ2aKQN
 SJdRIXsTkJqCVGHuywWOGHH+kNHru9Vp7sb/buunboQk9zV9tvQ9nbwXT4o7/f6j/cgV+MUQ8rV
 mh7oYAc7HVpvYmBCC1WKH7xJmJiqCgvg6OqYNjRXlWmwrpJnx/cjp5izi+nu8jOfbKAyiQQ81nL
 aVr89rUmFKpyKJYDzdP4Bu6stWbAfpGhRlUOB8E2DVTP5wO4VPcwMs3xOeCEF2F4SQSWEhSQhma
 ljeM0tKzuStOFQAFlMe2FMM5GQ0J84WkjVYGWk4s/laMAM34AS2xw7RV16K5a+oNaFzIamyhck5
 RR+NEDEaOA3T8aUrDEA==
X-Proofpoint-GUID: YcUmgu4YIT2fk3bz5FgGA3uIpVlSpWjY
X-Proofpoint-ORIG-GUID: YcUmgu4YIT2fk3bz5FgGA3uIpVlSpWjY
X-Authority-Analysis: v=2.4 cv=Zt54uN7G c=1 sm=1 tr=0 ts=6b061951 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pcZqCyVeAAAA:8 a=XsIHFW3MbSe0Gcz3ytYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MSBTYWx0ZWRfX2KZsvc89Npru
 E5jHCHeVOZbjuWupbYs8BMOutBtZWET1oQRhayOldOaPgW/ZTrnb32/JwYXYZFfqgapIXD5iR/L
 XdaI5aRPBSokBYEWKRJeFZc4UjTr6+Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240091
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

The 82C37-compatible register layout, as documented in the PIIX3
datasheet, has the write-only request register at I/O 0x09 and
the read/write-all-mask register at 0x0F.
Move the mask read to the latter.

Fixes: 9eb153f18f69 ("dma clean up - added missing read accesses")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20261119220838.52034-2-philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 577154988952..f44632de3db0 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -281,7 +281,7 @@ static uint64_t i8257_read_cont(void *opaque, hwaddr nport, unsigned size)
         val = d->status;
         d->status &= 0xf0;
         break;
-    case 0x01:                  /* mask */
+    case 0x07:                  /* read all mask bits (RWAMB) */
         val = d->mask;
         break;
     default:
-- 
2.55.0


