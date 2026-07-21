Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FED1C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:42:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7uQ-0006un-8v; Tue, 21 Jul 2026 06:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uO-0006mo-6o
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uM-0003IX-At
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:41:07 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARNdA945886
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9OEdg4Y/czGP7sdFRIVKRI2DQ40/n6xNagJwYMwJZaQ=; b=WqIhEIPE3VzjITgl
 hM5mBGdexaqtHmqo1vcwgc1vqQDn4NWGLAJb0YgnjSZluuDucBeyZkpdcEjh0BLQ
 n5tBRPF/hGn0CD988a2/Avfee0S5x/O4qiKXV9H6En+bKolGVZKcORL65/Wf2nEC
 b4ikqEhK+j3vsD7bMbYyT7yQ2Qf7oMnGEF/YyBpYqlFdWpMTMbZGOqtdsgE+gFDw
 edr0r89Kln1ftXcm0DepG01MMr156xizhDlHatGSwaYaDp7e5ZOsbUmP7MCqKspi
 9mtYayE3pLbglphz9H7dhawGksU3Z8lS6ewtn1jIF1+brCMBsdd1YlAaRmE2zMOU
 +ph09g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es1shf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:41:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so268544871cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630464; x=1785235264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9OEdg4Y/czGP7sdFRIVKRI2DQ40/n6xNagJwYMwJZaQ=;
 b=W1fntK+4Gh/Qki+EKgmBtFjQNKxciD4x9+JzCTbc0bXHOe7pjvzBuBB/vtti7IfU9g
 HgCFFk+yXamEYM/m8FF8FKxZ9a+vAmgrGWKdPLzLx+qv2LQFkHIz82INKInVHFBF/9eJ
 qi4e0vnw6S3TrlLZhHr9/LOUHmf7hVhjTSXKqCZy5oDV2z2AI42jzsjinM1Vj0kqE9Rk
 4lVRyHsgm3vaL7NCQP2p0NlFf5pwcR8dhOHFXKkc1C9QVYtHtFFaKKKlms9dYOo7ciB7
 Ae5YBTtPmFsgiyNpbgZESdxJ5kuL5fcgt8Ukn13hlpfBIsl0w5iA02ICxw3WrE70O+yg
 6pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630464; x=1785235264;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9OEdg4Y/czGP7sdFRIVKRI2DQ40/n6xNagJwYMwJZaQ=;
 b=KHUhp1rlq2i4WJr2CfwE0+qMyC0wPhAz7EkiLoIQJSnC6ZWDnyG5yV/WaSvdU16TUP
 GXEAdPA5bo6FsN02VVRFni64jwhXIPaB5Wz7x8RErMR4dHCc+WajT1Ns+CdRf2qDHrNg
 +7GuTePXudCfCC3OfNn2K4GbK+Zoh7UyV9FnNt5pEkgbNZ8BhJazK79l4DotiQoqj2VR
 2NdU2JEwonuzG+z82R+zAdrmKAK5xa9KRyk1U48iaYUj7bIJ6u+bW43pFTi1tPw3WBMx
 ZrNGljJiApLbIlQVTuJij6zswC1mHoSLGUHdZu2QDNHnkQ9PlTchWCWv8YLGnngcfSG2
 5+vA==
X-Gm-Message-State: AOJu0YwCTSBeI/tO9GYWEAgKCmdRJiHwn0M4XQ68mKCqzayXGMh9SPPc
 BEoKPuZG3mEqiaPjZBPN/us21ULFHQAHtC7xHPJgfzndbEdhaCF0egeTQAIbVbmA8bueMDPxtiI
 xdOAma1r1JXWN/7vkJrBu82S4BQjP8Fq0be3uswvdhM1GRdNn73hlK+pQEoghY4/eiA==
X-Gm-Gg: AfdE7cnc7HrJf5VRtxQBc0OttLpaEiUfzRHdp4CRhZS85juWN8z6vqxr24QH8axjVB4
 h0NWH5y9/MJiS/hzy5EdQlt+An3o3P416bfJLm4jUIKt0AeAXMD51BWLKRvdHr2u9lv9k1+x++W
 MTqXIE6hIt/15KqgGSq3jGI1vvupdn3IPjab300YCWfmxJZCF3B/ecCM4Q4MpaqsHgMckMUWkpq
 Le5Gv9lqZrzJnQPTSi9SuomXf5SoaBAZw9NPMSim1E8waE6jjxtXDy6Pvz4FaePIt4aTlPRFmqI
 ipJtSsEHV8zSUgJLaIyc1+3wRfFJexOHtMMrpPqeG4MwONrmZVKhefj9QYdjC18ZZ2gbWddURFH
 ZGNsWez3MuVkZ7G6PU1qnkKUf0Une4sj+pwr5DURdRd6M0hkfNaICwhHEog==
X-Received: by 2002:ac8:7c43:0:b0:51b:f0ab:2b1b with SMTP id
 d75a77b69052e-5213e876ed7mr169973101cf.49.1784630463771; 
 Tue, 21 Jul 2026 03:41:03 -0700 (PDT)
X-Received: by 2002:ac8:7c43:0:b0:51b:f0ab:2b1b with SMTP id
 d75a77b69052e-5213e876ed7mr169972891cf.49.1784630463078; 
 Tue, 21 Jul 2026 03:41:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2314sm1970930f8f.23.2026.07.21.03.41.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:41:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/audio/intel-hda: restrict all DMA engine paths to
 memories
Date: Tue, 21 Jul 2026 12:40:03 +0200
Message-ID: <20260721104004.84934-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f4cc0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=wJWD-ArndqrXDSP5iLEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 1f1GCh_Zgbsud3xWAlZ3wc1uZ4Q7Hlu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX0ieT0R9Zc+An
 +jzuC6w/fHzq/+Ja09r7juvJXEVJZU9BdouCMIaZ8xhUtzX0E+caL1UHkM53ExPd6xJV7PHkFNL
 Ya+u3Vpc1cCRwY/ejMb9LYtEXl9PhurnVPMNHApFovKwCOeDtIDFRHt/zJgXEBGaNBjjrAQOInS
 S7cKbnlwObHtVIcl3XojgXTYhm4fLWbg9a2EatTqn/U6seQ2SA64yGTSIKCbJNbEGI0/iNNq2Je
 XED8jGvEAIcoCQCpZj7LWgPCdvw5U1FcYtYLLfLGL6II3UUMcbLLDdgAsziz7RENhLOH3BQ60FO
 3tAqPrad9jr9+VsDhS6YhT1HOjrtwYtgOZp+IV5ljE9vwRb7gAyJn1d7Yazhjyp5G6eT5a0HHTV
 sx6+rPyRF+wqoVPNxaFl9f34Q7X2LOBXX0X1ld5vjAKDzubdDN8KR+Yu2CA8Ju1VL4Th5WM5FKD
 hJCsNqJ9KwfrOXOLgOg==
X-Proofpoint-ORIG-GUID: 1f1GCh_Zgbsud3xWAlZ3wc1uZ4Q7Hlu7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX7FB/zto++Mo9
 GH3vIej/DK+RJeLnVW+79SSdIzFnxAUel1zJnRURdf2BtwzfXkGVYqr8KmH33JqzwF6Xxj2BbcZ
 27ET9KrxP42e91vOjoP546iWPOn/fJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210112
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

From: Haotian Jiang <jianghaotian.sunday@gmail.com>

CVE-2021-3611 (commit 79fa99831d) restricted the DMA engine to memories
by setting attrs.memory=true, but only applied this to intel_hda_response.
Three other DMA engine access points still use MEMTXATTRS_UNSPECIFIED,
allowing a malicious guest to trigger DMA-to-self-MMIO reentry:

  - intel_hda_xfer (line 398): called from the audio timer callback
    (hda_codec_xfer -> bus->xfer), so the MemReentrancyGuard does not
    fire (engaged_in_io is false outside MMIO dispatch). A guest that
    points a BDL entry at the HDA controller's own MMIO BAR can write
    audio samples to device registers, triggering whandler side effects
    such as starting/stopping streams or injecting codec commands via
    CORBWP.
  - intel_hda_parse_bdl (line 478): uses pci_dma_read which hardcodes
    MEMTXATTRS_UNSPECIFIED. A guest-controlled BDL base address can
    point at controller MMIO, allowing the DMA engine to read device
    registers as BDL descriptors.
  - intel_hda_corb_run (line 333): ldl_le_pci_dma reads the CORB ring
    with MEMTXATTRS_UNSPECIFIED, allowing the DMA engine to read
    controller MMIO as CORB entries.

Fix all three by passing {.memory = true} explicitly, matching the
fix already applied to intel_hda_response. For intel_hda_parse_bdl,
replace pci_dma_read with pci_dma_rw to pass the controlled attrs.

Fixes: 79fa99831d ("hw/audio/intel-hda: Restrict DMA engine to memories (not MMIO devices)")
Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotian.sunday@gmail.com>
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721060941.2989396-1-jianghaotian.sunday@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/audio/intel-hda.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index d7c2c3c2fd4..3d361a4976c 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -305,6 +305,7 @@ static int intel_hda_send_command(IntelHDAState *d, uint32_t verb)
 
 static void intel_hda_corb_run(IntelHDAState *d)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint32_t rp, verb;
 
@@ -330,7 +331,7 @@ static void intel_hda_corb_run(IntelHDAState *d)
 
         rp = (d->corb_rp + 1) & 0xff;
         addr = intel_hda_addr(d->corb_lbase, d->corb_ubase);
-        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, MEMTXATTRS_UNSPECIFIED);
+        ldl_le_pci_dma(&d->pci, addr + 4 * rp, &verb, attrs);
         d->corb_rp = rp;
 
         dprint(d, 2, "%s: [rp 0x%x] verb 0x%08x\n", __func__, rp, verb);
@@ -395,7 +396,7 @@ static void intel_hda_response(HDACodecDevice *dev, bool solicited, uint32_t res
 static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
                            uint8_t *buf, uint32_t len)
 {
-    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
+    const MemTxAttrs attrs = { .memory = true };
     HDACodecBus *bus = HDA_BUS(dev->qdev.parent_bus);
     IntelHDAState *d = container_of(bus, IntelHDAState, codecs);
     hwaddr addr;
@@ -466,6 +467,7 @@ static bool intel_hda_xfer(HDACodecDevice *dev, uint32_t stnr, bool output,
 
 static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
 {
+    const MemTxAttrs attrs = { .memory = true };
     hwaddr addr;
     uint8_t buf[16];
     uint32_t i;
@@ -475,7 +477,8 @@ static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
     g_free(st->bpl);
     st->bpl = g_new(bpl, st->bentries);
     for (i = 0; i < st->bentries; i++, addr += 16) {
-        pci_dma_read(&d->pci, addr, buf, 16);
+        pci_dma_rw(&d->pci, addr, buf, 16,
+                   DMA_DIRECTION_TO_DEVICE, attrs);
         st->bpl[i].addr  = le64_to_cpu(*(uint64_t *)buf);
         st->bpl[i].len   = le32_to_cpu(*(uint32_t *)(buf + 8));
         st->bpl[i].flags = le32_to_cpu(*(uint32_t *)(buf + 12));
-- 
2.53.0


