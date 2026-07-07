Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2E7C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eT-0004K6-Pb; Tue, 07 Jul 2026 09:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eD-0003Tm-Er
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eB-0000r6-LO
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8euJ3742025
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eswOgvsvmES6wANwXxIqB9K89YBMpWQmKqAkHprftcg=; b=EeKoBiFvpMll2RGo
 yUEeMoxufBbPV/UvmRTBR5P8KhlXTHyR0Tk53jS27yd/5SjHmpZYGDdV63xQqp12
 5C8u3iwbN2A30RPlmjiMDlKEsdInEkCi5LY81z5TcPg1WjFqpKNS5YQ8mI3Q+BSS
 G+kIiih10uDaJCkjTuHTaUS41yO9VlWt/Nju4UcqwXwpVPPSd+xX0Co8piE19Po5
 nvjB3jNeM+IBPFPBDaYu9PXr9wpEkBiauV3lOAjjTmOgt0v26tYZesMEL1D6KhK+
 Glv/EnsSgHcAxmeoVel3JMHaB6kOQYUkfBhcG+H3S9mfDUKoqe3MAhE5N+YFt/7I
 CPxwRw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0gpx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso48110291cf.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430132; x=1784034932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eswOgvsvmES6wANwXxIqB9K89YBMpWQmKqAkHprftcg=;
 b=Bvwqp59dy9uz111JE3oIJalwx858e4po8ftVbBC80c5vjV3bqLm9KMTAyZ3Gmb+x41
 VMBZfFDcfTyBCXaQ61zDKVfBPSv0VIoez182AQ4N61xeCFNiwz7nOoQI6F6hrnNU5N12
 BNUVqeImL0158BSGMyRzW5MkjGeJS50XR1WlpF6dDuLntY5XgwV8gH222EnIx98kmctp
 nAizFHo95so+Ry1x68FOiw5JFgsjFmvwmGTGS3EZYZQO6DYFmX2BBESHgj+fGRDT6GdV
 VrHXjlmqbpJd2J2S/hAXH+8+9d4SsnZHWbU1vRUX9KxHpzecuy4poqjGyQ3N0mPk+/yL
 iZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430132; x=1784034932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eswOgvsvmES6wANwXxIqB9K89YBMpWQmKqAkHprftcg=;
 b=RgJfVE+vHeq3LMNCOFcX91nz7UAW+T61giMmUI7+5R7v5ytH5zC45QYeRvW/l7EB2i
 ujZp0R4oAL303ZmF9F3G5te9FeZ2eqKQ2dkxpeulmz2jtAknf3elILStQ9NL0ygzK4PH
 muoQDfAXbwfJaHu31jw5fY8BdV9q9cRbj4+5bmWqzCrdZfNDPI26d2uWo3oHq7lTkgvc
 o/ykmjEyECGFOUIJWxQh0kE0seWxESq0TnDjhq2Hcr993lyco3xbA1t7lnjT09Wbnr5T
 n3modgho/wixyE96dvfiOZxfD4gyaUI3BAqdyJVECwA8LCuqY8uOaAotTQ3cPzJ+NXnq
 lyfQ==
X-Gm-Message-State: AOJu0YzNaENiUW0OcReLgi0REAzRfHiiubT3fVueaCbZW3zp2MWDzWGa
 BytCdWoPsPBujBOPgfwG4GAr6ARjWrlujmS8LtcxxUpk5pdi1Ot8ShTyt6ACwh2yggsbkwz6ScB
 pOf/6piXWCqWqn4IQxKADRS63Met9/TuxOhpt/emQ/ejiJgiPMW+ENTN4kbPxmkulBw==
X-Gm-Gg: AfdE7cmJVei2sgFLijKd8Xm4TnEweBPWP79PMRhtf8KFuznUWdpmSgDge1RVYI7diM9
 meI1OirWb0fdt9fMpkAaUNElUir6zgziSmjdWDRlOo0msEB34h6orxtInYF/KCXAMQ/HSSYT/PO
 ftHfPvDDpnvslLJPEaO4Q2oDooAldCoeVpxMyd+Da9gEBj4KXpI1fwqJymAnPGL10VZdSLr3UVx
 rtWLL4S8dYxsK8ZU6pbUgYz7+5yx3IQF8eLxXalc7pjBBTylCTC81oNC16xzifwcFMJ0asCWLkS
 B37qxmI7o/ITopF/n7MR+9m+lOMePfjwFMGwhxvQ2SSDrayXG+xzNI4nkjIJq/ZVbMKjgcFj52F
 d9mDqdaDsA32sQeZnzGIiJO9G4+ASfTIJdCtM/EocpPaVgXnsPHtp2f6SBPVcCLhSl6AG
X-Received: by 2002:ac8:5908:0:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-51c747a371amr55043181cf.20.1783430129469; 
 Tue, 07 Jul 2026 06:15:29 -0700 (PDT)
X-Received: by 2002:ac8:5908:0:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-51c747a371amr55038571cf.20.1783430125415; 
 Tue, 07 Jul 2026 06:15:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15bc428775sm36945266b.6.2026.07.07.06.15.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] hw/block: m25p80: Fix dummy byte handling for Winbond
 flash
Date: Tue,  7 Jul 2026 15:12:15 +0200
Message-ID: <20260707131223.51505-26-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eg8x6eAKLJTYBwiCG5LwA5z3Ym027ZMA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX0+aLt5+/N39E
 XA7SQVzSjRKHi3s5x6lPDvPbY+Is/ioecs8bd1CAQRzILRuXHgREIe/soumxmV5sd24mB3ZVT2o
 d1xiZogci7bAlRgvqwDA3R1G+A/68y4=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4cfbf5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=-fCmXZ3jAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=vuOm1Y_JtsB2s8HU6FEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=NvoCvu5dULWom27q9pnt:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: eg8x6eAKLJTYBwiCG5LwA5z3Ym027ZMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX4j17rbTluP/P
 IwEEEIjhgkPDyjXSUWwpsWe8PfX/fTRBKtntaF3f57QjZfDM83Ds4xjEv08Ioicqtqjuz7vSUEb
 SaztiTctQq0jp0skF9GmXgGF7Ipmn9QMwA5tjwVtreK5rZuADUTJYpYa2n9CmAesnsbSUM3+OAH
 QjHuMzuiIychtlyD2WThfADC1JCxbMi5UoL2okLOYdt6fzD+iqpD9tY+2TlgSbXrQC2C+LCL4sT
 EHOcL+0EVEV5k+4CEeOScxTezyNeGK1BblxXr4gcbJUle/X4IiAbEhSJ/MD8RPc7KcB2mS1xCKZ
 u3IY1Y+Bf3EuTqhr/jg4VVPawIJbKOXuIoBJ/V9PYwNoxx7WJuWQLjbI56jLeYb+qTzdPG/3Cyk
 VLbtxr6ZaVOKC3XNdtJbVTTq5q5pq7QGVsQ8hqexX5hCCNxjZD137aQrfODWIR+PrNv4eCm+tkI
 TTc6pUY5X2nN4w5ZbsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

From: Bin Meng <bin.meng@processmission.com>

The m25p80 model uses s->needed_bytes to track how many bytes a
controller must send after an opcode before the flash model can enter
the data phase. For address-bearing commands this includes the address
bytes. For fast-read commands it also includes the dummy phase.

The tricky part is that flash datasheets describe the dummy phase in
clock cycles, while the QEMU SSI interface advances the flash model one
transferred byte at a time. The dummy clock count therefore has to be
converted to the number of SSI bytes that the controller will actually
emit.

Some controllers have drivers that push these dummy bytes into a FIFO.
Other controllers are programmed with a dummy-cycle count and generate
the clocks themselves. The flash model still has to use the same byte
count that a FIFO-style controller or the Linux spi-mem layer would use,
otherwise the model waits too long and drops the first data bytes.

Let's fix the inconsistency from the flash side first. We start from an
easy one, the Winbond flashes.

Per the Windbond W25Q256JV datasheet [1] instruction set table
(chapter 8.1.2, 8.1.3, 8.1.4, 8.1.5), fix the wrong number of
dummy bytes needed for fast read commands.

[1] https://www.winbond.com/resource-files/w25q256jv%20spi%20revb%2009202016.pdf

Fixes: fe8477052831 ("m25p80: Fix QIOR/DIOR handling for Winbond")
Fixes: 3830c7a460b8 ("m25p80: Fix WINBOND fast read command handling")
Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-2-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4a4cda66024..59ecb32c0a2 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1004,7 +1004,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_WINBOND:
-        s->needed_bytes += 8;
+        s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
@@ -1099,7 +1099,7 @@ static void decode_qio_read_cmd(Flash *s)
     switch (get_man(s)) {
     case MAN_WINBOND:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += 4;
+        s->needed_bytes += 2;
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-- 
2.53.0


