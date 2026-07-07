Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29CC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5cw-0002IH-Ap; Tue, 07 Jul 2026 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cQ-0001zt-Od
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5cJ-0000U8-7w
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:13:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9Lc03740882
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nn0ZFvqwGfAjXlB7cNAQsa1JNM0B+5KYgoQ2c8C3Zhs=; b=KDGo2r/xNcbvncIb
 Eq70R20boAiTyuNWlt9agzyrwTBJmQHZDMVf5pEXMwcYHR7rcoGvgyNoPjf0djko
 pNh3EzDIzZ4/3jFmimNd0vZwqAqLLHifG9W2yDa2wgG9bRq7m2mvZ78UX7TnmXkI
 y8sw1USgqqrGH9t8b8FTFcBZc7lJEXVbf8Z5wDI1Hml6fon/butwnPoKRYAFrMe2
 2FfNfTOEhJF7EqRb7Xj3SFNXE5MpN7u5XuzohnqLQcbcDBtlpJ/3hF1AiDHeL9Ug
 5/fjmDEPoITuXuUJnljMdZz7ed7bIfh+/O5mlCfInMq2mUV+DcT0tQF0mMkCnGW7
 ronSiw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a9ks5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:13:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso59699731cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430016; x=1784034816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nn0ZFvqwGfAjXlB7cNAQsa1JNM0B+5KYgoQ2c8C3Zhs=;
 b=S49GtZvfmM8lPp1gLlnZfsKBS29sVZXly8dK3v5xRGb09cPke7jnqUsb3UiQFcXsSM
 UOFjWa9R3ZHJ0d2FkWgfCcSVk20W0QCzD5NVEKihg9tI5JpAx9SEXvYVVn2JX1W0cBBh
 TaKZlSD14BoxWUuAX2F0pIdJNLgblwjmfN3jYmNKGCA4No0QiJTbnYWOXJGQOrauT77a
 uGrEZp+KHzSDWaKd0MgkBuXqEhand+SFy6rnK7PDDf3mQlRihUDGUAYo7jxKoBtGZMMu
 g52gUsmPlP2BEiI9MtCw9U9ZLGBGDyzL6w3jvhwzF8tyBdnAhbMbWitzdQBeBBDOUdJV
 sd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430016; x=1784034816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Nn0ZFvqwGfAjXlB7cNAQsa1JNM0B+5KYgoQ2c8C3Zhs=;
 b=K3glJYy0HPs+9SvOeMOLHCyNWWL3FZthxuJ6J5AMyI39C/4YceRTf1iZMWojNoZ9s6
 tOSojkMl+HH99AnSOhMFeCWsW19TDkU3kKzCjWXvtqwMYRkICmRVt3NbGqpNi1fyf/6v
 flupyA3J0PWZhA1gW7fOtNZH+/DYNRt1ElCJi5hLA4JnBSvDqB1OzsZdbIDqg9CQNzTw
 412K5IskdLsvLt4ngKnyYW85rqdGQXe6Pk4VTMjFOg22hWbqZGVfOBgjLwNNSdJvjrUY
 mi8EaSvqveAJbNhumX4pRUJGZynnNkgylkn+hCMC1dEpn/Qgi2E9ASvUYKQvz/b898av
 nAtA==
X-Gm-Message-State: AOJu0YwOgwKNXnGGjXOrukAtwr5i3agHXR52ioZFn6l69ff3Y28opNFl
 hRYHoMn40qtURZOl12qWg6TYbcw5rVySuczIoIh7v6wLqQ2jRy7aA0wNsZcNnejTedKf1OVIzhY
 OtUx19F0/dEjParkK5TXFcWEIPzrN5W0YvzCujQ/akd916gg0jAB/itesKdM5yGDfpA==
X-Gm-Gg: AfdE7cmoJmSmkNUGqP7AbUqUxLQ4//vC6kx7U2q8OGZX5xqAmohHt0NIMKmK9F+nlMT
 Obkf4457D/nesdas6qhE8K+D6mBIJNY8R9AEByoT3TbqTdxkXBuhOFwAx+6WesMvsuCt7dKxxyK
 oAywsu3n/9/i3UjDGX9NcYdC12JpgCtaNsRa4ZSDnlyPm1Sfi17lqI2H5kdJn8Ujduj0WQfIFBo
 ze9pQIMGJGHvYSyj66r/NdE9uuMn0Hkxu6KthLbiVOkafMhWRHap4pLZCSnrMr2JTEtCdwt4qSS
 o8SI+ZnFTL5Rmv0WWH0+n9Hn/RSBzluItfw7iWtmuXVZ8L4G1QiuCNI9uXr1TybyiHjSLRnGpXI
 Kb9Qi/ayuyBruc2re8rLAPquQhZW1BXLBjSknRoh0kjsWBKlM+f8jucrtTxXI245FjZhp
X-Received: by 2002:a05:622a:4c:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51c7b1217femr22933631cf.79.1783430016403; 
 Tue, 07 Jul 2026 06:13:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4c:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-51c7b1217femr22933001cf.79.1783430015574; 
 Tue, 07 Jul 2026 06:13:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15adb488desm137294166b.63.2026.07.07.06.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:13:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] hw/dma/i8257: Return zeroes for read_memory in verify
 mode
Date: Tue,  7 Jul 2026 15:12:00 +0200
Message-ID: <20260707131223.51505-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DGk9e0vwTCBAOUE4jxD_1yONULxkdYJe
X-Proofpoint-ORIG-GUID: DGk9e0vwTCBAOUE4jxD_1yONULxkdYJe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4NhOUuiHDtq4
 Ql4eJalVXZecG/A5Js+BVUSxsNqhfVZf6kXFhRifC1TAjBrbVMZG+FMQJUzUh/JchEccNjrfRhi
 2gTsfX7vA9myccPucJMjSceV0Ivbccc=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4cfb81 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=JfxaGNaL9TNl3oK2404A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXxVs0wbSK9MYH
 G9cFayS7UFSwb+oHrUBQW8X4KXIgGWzfSlArAsPh0OWe+nfyrF7k6EZl0MW0OMhKXrEfQAoqv8C
 iAtMjQqIJAh/e0kxTTGl26lCE4E0gUYTxD7fYJ5C8+foj536mRkntkkFNxXZWY6Xo8vPb8rgqlt
 Yd2AgaGNw+hHKt76sXN6SxoEGdpYtDbPDAAZm/l1dLPDdpf8LwbayYZVQqzuyjsu9MOwIFgvZPR
 tiNmXsqF5qApv388IMiG9ejTfBj+WzaTyGppftsM08BZLysIKwOWdUcX3/D0gIi1LjWuPYsqrUs
 TDDSqLCUcpsmm8vuRwuf4xueDyrMvNxh4YsldI8CiYTcM5ORcqzmLp9vYwxDbShFcs+qU0aaOWe
 4yqG0FLRHciqwfhIws3AEm+owWu+Ab1u827imhM+qoUl5Bmy9Z7TQwDgv9wznruSD2NPeKSvb3W
 wFxIXHBcM0R7YVG+x1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Peter Maydell <peter.maydell@linaro.org>

The i8257 DMA controller has a "verify" mode, which the datasheet
describes like this:

> DMA verify, which does not actually involve the transfer of data.
> When an 8257 channel is in the DMA verify mode, it will respond the
> same as described for transfer operations, except that no memory or
> I/O read/write control signals will be generated.  When an 8257
> channel is in the DMA verify mode, it will respond the same as
> described for transfer operations, except that no memory or I/O read
> /write control signals will be generated, thus preventing the
> transfer of data.  The 8257, however, will gain control of the system
> bus and will acknowledge the peripheral's DMA request for each DMA
> cycle.  The perihperal can use these acknowledge signals to enable an
> internal access of each byte of a data block in order to execute some
> verification procedure, such as the accumulation of a CRC check word.

In practice, for QEMU's purposes the only real user of this is the
floppy controller, which can be made to perform a "read data from
floppy disk and check the checksum" by telling the fdc to do a read
and the DMA controller to do a verify.  This causes the fdc to do all
the usual read actions including the checksum, but the data is never
written to memory.  However, it is possible for a guest doing
something silly to program the DMA controller to do a verify
operation for a device that wants to read from memory.  Currently we
simply return early from i8257_dma_read_memory() without writing to
the buffer.  None of the callers (the GUS, sb16 and cs4231a sound
cards, plus the fdc) expect this, so they will take the uninitialized
data as if it were from the guest.  This can cause us to leak host
data off the stack into the guest.

Make i8257_dma_read_memory() fill the buffer with zeroes rather
than leaving it untouched for a verify operation.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3487
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260629140128.1900095-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/dma/i8257.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 7d7e5434275..57715498895 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -408,6 +408,19 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
     hwaddr addr = ((r->pageh & 0x7f) << 24) | (r->page << 16) | r->now[ADDR];
 
     if (i8257_is_verify_transfer(r)) {
+        /*
+         * If the device is expecting this verify operation then
+         * it won't care about the nonexistent data. But if it
+         * is expecting a real read (i.e. the guest has misprogrammed
+         * the DMA controller and the device) it's going to try to do
+         * something with the buffer contents. Give it zeroes.
+         * (It's not clear whether this is exactly what happens if
+         * you do this on real hardware. In practice no device QEMU
+         * emulates has a use for verify on a memory-read transfer,
+         * so we don't care beyond avoiding the guest being able to
+         * trigger the caller reading uninitialized data.)
+         */
+        memset(buf, 0, len);
         return len;
     }
 
-- 
2.53.0


