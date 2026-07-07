Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BE8C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7VF-0007k8-N3; Tue, 07 Jul 2026 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7V9-0007X8-49
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7V7-00079D-85
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8gHa3616596
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YaVBpW4nth6ZKFQO0XdoICi12tkKpStf8TrTCVBmPeM=; b=Hier4udav5jgYxFw
 05vd46RDaCp3KwQZLgrQIFpKTRokDmjozeDmBv/qVYDIBdS0pia7KyOqgpwZ82qf
 jKoQlpri1/0g4LnhdLhTLWjQFQxCQO//a45dM2qLLuDWwLspUeHUwfTKp1YWXp+U
 HedQ7BW862LqXN6tlM3r58Ys6VCRNVJQSOZLsi2Gu+i7GAgjvz9XDSmrUg1cQLa/
 WZwsgp20gdZlhiDZMZ+pV0hZnYdL3sWDOTt91qUSpNNqe387EpSHEoRs6wAjySqz
 a+rlZXrbcSMRggoYd7QIdIfjFYLwdGv5hiqFcXwsE5C2foDtOFz5B+J0+T3MHbSw
 09Qxeg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1xbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:14:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e61b38eddso789659785a.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783437258; x=1784042058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YaVBpW4nth6ZKFQO0XdoICi12tkKpStf8TrTCVBmPeM=;
 b=aqywgIG3KPWgnbYrjG5nZh15GNXAgxp+hLJ2EKytFlQmYOPZRyzaBP+8FfAoIV1Kdv
 kUiNvGXghGdPaxQGckq39KQsREEWsmHVswtLw4fRi2zPf404l5X263jGkO2sR/JsVkev
 IxewxatKZX/ZPdMZbqmJAVvAt8vwLPJihp+RxiMnwKQTnPVLynMtMyYo39efw8y3oL/c
 7wFeCP0041AYmmzGUdIldTNrYcn6kC6wIEIIgqyrMDTPn21S9riJFMHdJjFbRLP6OLtj
 D2bYbcp1kvN70I3vXR9hGQPJ69rcPOemh+xI9skgJtPYN5XO/7Py5klSfizAWOrJieKl
 p9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437258; x=1784042058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YaVBpW4nth6ZKFQO0XdoICi12tkKpStf8TrTCVBmPeM=;
 b=smYQmE6AEcdLDJ8v6mYLip3kJ+CnsrrTMRpdZig8CWuJNzTL8c47BN1kc3OnOY7H1u
 r5mw4GPo/+ksHlcMdKUJ+PWJjUycyuTgCMRF22F5/cKJmaQ1UtTlHvG/OjE/KOZ1a+F6
 Poz+2p8AMbL/WU3o29dOqBWpb+M6Vzdv97bG/gpNSQwn7Ui3tnSwZWffG4bKNwj+dLFB
 s8MJTnSa5iLRrsAqM1PGci4h8vihjwsCb1Ob3WPueqVPxukAbwDefjKHJ/BuELrXDjL8
 VBMu27sXLPsBkwZ9qz1jhsdGj+fdfknd973bin+KwQtc3+wkpivWPMPDgJVZeGZsv76c
 9lXw==
X-Gm-Message-State: AOJu0YyKL/1Af4t/y0UWmYCCE+GGDL14TpigFmtbTz6+Jgh0tULdCZQr
 kXOYI1Pyb1SuIMuWvCzB2fLHmFWo0qTzUOQRbWGDl+TD99r29vsXvFusCVPXYBAFKbEMTw0u437
 bibbDsUQ443oKhryg2xfOdbGc4GaVKnYOd4AfrTvWe0R+mKFwB7so3Ow/DnnVMCPHeA==
X-Gm-Gg: AfdE7cmyXxBeOsS6K4ouA8EKbxnhM3Qfi/koZGSZF94Hz6SvPq1o2XxWORxlky/WxdN
 2gYqDtJ3YK0NhvojphdKqts2yzfLO9NDydXYHQgxStZtQ/9sA8LYBI7OIt10Zz84MbNWLSsfw0v
 7vp5P2xdpdbgwl7jN9Ag1CpbvOaADuyid3lQpWAcJN/lYy/1kAdHmiOQTXeZ5J/YpHNboeDosmb
 mdtEZ8CRAYGhk3KB6x4Bm+3h43PpK2m5X0P8tIXb8EuVT1YNT36urvzkz7VlOQ1QBC/mP4YmWuB
 lh5L11IQnWM/5Ncs0jdC3L+il2hX4hczaCuUxj4TXnwSVkCT3Wt3dQdBUC2sWtYSHAf+Hq4q6BW
 WcGYObNSzK903360DvG07L5lRxlvDpGNwPjd4a3nYNNFgsayeG36KmDnxkLbl/AkO7THK
X-Received: by 2002:ac8:59c8:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-51c747ae893mr56918011cf.1.1783437257852; 
 Tue, 07 Jul 2026 08:14:17 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-51c747ae893mr56917711cf.1.1783437257361; 
 Tue, 07 Jul 2026 08:14:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm33275376f8f.19.2026.07.07.08.14.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:14:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 30/36] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
Date: Tue,  7 Jul 2026 17:13:50 +0200
Message-ID: <20260707151351.57769-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707151351.57769-1-philmd@oss.qualcomm.com>
References: <20260707151351.57769-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX6xdL+WvOGF8M
 QeDOUi88PpZX05lll+Hnwtp1jloWnSseaaVqnH1R+VDKzRdRpW3Qd1hDBkfiklH8+FBDmVpss8c
 E111m4d+sCjqZJz2eHEKTj8v9CqruXE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX503gJFxrN2hD
 8NCrZuxZsbgrkJBQR7hg2dm+hZDq+vKrCWQgRJQF7yVvXwwXdOrFep/+vscAEfT8qXJsjP03M1M
 zD8+270uS0CXj5FRsWZPIF2N5+Put2+EMh5I7X5fKirEmKywCMJESb5YqtUEBHkyxDNpcQqLEs6
 dnjLd/ppnXM69TCcysARyfhMpiyoiOen3clHfuNP4z+ZzVVJF9AqVNP3W3H5pvFLcfCZYfqEePd
 0dNP1OAGlLYKuS9C2nL94jZQGZvRJFfwCr/mFPI55+BKR/n3FFLr+BHN7ejZ8aJRybOJKEy8N25
 X3YGIz/g22LjOuobTMUL3C6/96jgc+6Qg6B7SgVBd4ANhT19nT9U2GGIzJiu8AGahTt5pzgWhZz
 dz7mLWojghLjQ3REu2Kl3Ka9vwztzGRXPuw67YUmNk+UWZUiuYqlNqKK/95+uC3K+jEqvs/xydO
 pS61r/98evbskgBPmoQ==
X-Proofpoint-GUID: Oq8PoCrBnqn-iPFd5xrbqFKrYqdCOwaK
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d17ca cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bUQKSiCPAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=EIhqxKd5E3p1TB9jvekA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: Oq8PoCrBnqn-iPFd5xrbqFKrYqdCOwaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070148
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

Spansion flashes expose the number of dummy clock cycles through CR2V
register [1]. The value is a cycle count, not a byte count, so the
m25p80 model has to convert it to the number of whole SSI transfer
bytes consumed while collecting read command data.

Add a helper that multiplies the CR2V dummy cycle count by the phase
width and rounds up non-byte-aligned counts, matching the byte-oriented
SSI model. The default eight-cycle configuration keeps the same byte
counts as before.

[1] https://www.infineon.com/assets/row/public/documents/10/49/infineon-s25fs128s-s25fs256s-1-datasheet-en.pdf

Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-5-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/m25p80.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index d7a9d793737..545e0b57285 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1057,6 +1057,23 @@ static uint8_t macronix_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
     return dummy_bits / 8;
 }
 
+static uint8_t spansion_extract_cfg_dummy_bytes(Flash *s, uint8_t bus_width)
+{
+    uint8_t dummy_bits;
+
+    dummy_bits = extract32(s->spansion_cr2v, SPANSION_DUMMY_CLK_POS,
+                            SPANSION_DUMMY_CLK_LEN);
+    dummy_bits *= bus_width;
+
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    return dummy_bits / 8;
+}
+
 static void decode_fast_read_cmd(Flash *s)
 {
     s->needed_bytes = get_addr_length(s);
@@ -1075,10 +1092,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += macronix_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_SPANSION:
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 1);
         break;
     case MAN_ISSI:
         /*
@@ -1111,10 +1125,7 @@ static void decode_dio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 2);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
@@ -1151,10 +1162,7 @@ static void decode_qio_read_cmd(Flash *s)
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += extract32(s->spansion_cr2v,
-                                    SPANSION_DUMMY_CLK_POS,
-                                    SPANSION_DUMMY_CLK_LEN
-                                    );
+        s->needed_bytes += spansion_extract_cfg_dummy_bytes(s, 4);
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
-- 
2.53.0


