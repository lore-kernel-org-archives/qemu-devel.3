Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B95C44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5eM-0003rj-K7; Tue, 07 Jul 2026 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eF-0003Ud-C1
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eC-0000rD-Mj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:15:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8qeA3768479
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S+bzvuOO2qbkmSzBIUSwsnHbHzbsOJU99k/35OuaDlg=; b=mlj+2/IvNB1wPDU5
 LvqKYdoybWPVphJ6yjRIddJ9E9F4Gw5qPAgevURNPkkM5u0xjPdKWLnaqco2gJdm
 cXvqP917hMREdflbjxnHjbBHq2unk+UU0EYvRXVU6hC1ZhF5ndXbVpgQM9d0h2Pz
 nqHsi6jWjdHuvkqQgYaDXtwiLuODKQ8C08oQG1hE7UwTNvGdA/bl2o/t/uzGSzOj
 0t4JkEuFMaNPoZqa51whFPr60e67jbw6yiNtnxOTIu2sZe3VLJDMPDNS3Rx3HPQQ
 aUkBBpSQu2gNegUI9q+ts+vnYnJWaedaRAYo92iYLokIPCbilK4oduh5F/tQrZ7A
 JLwGhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8qj7ak8b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso43365841cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430135; x=1784034935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S+bzvuOO2qbkmSzBIUSwsnHbHzbsOJU99k/35OuaDlg=;
 b=j+qfnzX1okIJMDMJ4fdQEVt5Y2jvz6x2IKUOmxKDHt5vXgb+lortDa5/2+0o5IfQFw
 +rYrO2jUL313jQdzvu/XqLZRxmy2KVSH8UwBtpEsihcM6VIzT8oWw6oFmE4248GbXgqz
 vhR8zzHAlHVgTZ1iWLKBxyvs39CzLbXhyqqWm6LNj7RcEAKeiRDI19vSMnuQPni6CpIT
 kWxtWuqRvhgghRAIYbKhVNhBtFZ6EGav+v4eAOhC+E/Ro3N/Htgoto8qTz4WHROyCvFT
 PhCxoKejLJcahl2qYmMYh9CgQpZ1hIZdgh7umaMWybzxpMctS9CLaqNij6K5N2KctgT5
 NahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430135; x=1784034935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S+bzvuOO2qbkmSzBIUSwsnHbHzbsOJU99k/35OuaDlg=;
 b=QE6IEHiF94i9Eaw5BCt8AuUdzoItgVgfPfQpMWYtVpZRZPpIHLCbBetk2dD05VVKbE
 UprQk9bBKeXUrJTz4/QxFYoaR6YE1NQ2JW5gAxa6iIhtBZReagVzhiaWdDtydNVBIiqG
 G7Fhk1Qe+iGEl3ieoeXaojTC27TGJCc6LBTGej7D/9IyjykZK7kyNhvx3XQgqa/fAwUh
 EVFduMxu215/uS2C8vciTKLKCwj23uvZ6w+LiWSAQ8kM0+RwGAMjDWB8mX7slBpXJu6Z
 +GXnJ/x4haSqNSL8ClAxFuJpHRR4RdM+hY/i8qaXuBIyPf79S5kuydgTlh4JDY9nJ8ZP
 G9WQ==
X-Gm-Message-State: AOJu0YzraTTFPr7kvTgkaseITIcCzISPwd9oP8trRa58HNp9/Fd6Tw8N
 gpeZSf+eFr61I4bvzAuH9Ih7RinMTmxViUcx9Rp0vFxLe8i3Vv0FGFbw07p+eIzV9Z2x/ytgl+C
 ePOG9kmI+2neQlGAHjIXK52EcVhHYA2LfQjP9HVSRYRauexOcmhAy4xflHuUkTu0zpA==
X-Gm-Gg: AfdE7cmgnohLTnIQuXb+dTQbVVKls1tegB4btTHbxpoEuqwN0dBemAS2CqfODoguVdC
 vIwL1pCJVEh1SqgxvFWKNdukAXhsh0n4boq1hGIe1Iqw0Bf7aozWuwDoWBCVTOaQX607tcXNTrs
 05n/YP9XyOXUnSd8+Y25DotLh/+DzFwDMx3h9vKXGiQCzSwvv8HFLaiedqT1sgL09xDPzBHUht+
 UVHsBkGPrmaW0ElzpdqfGn24bZUlBYa+Yq4d7Pb8ZhT14JoFKN6Poll+onqcAs+2I/54hekBL2h
 /F/nDSfo4zBAtarJhzW2n6zpU7Mo68wIWuuA4io7Bb0IJN0BbZMada4Y9bgTBIErlphK9C22xGa
 W+/pldbEMcK9Pm7k345iRkcFIAUKndSWtRQKuqdG+DSPQHjwGRxDhuAy/YQ5fIgR7XtmP
X-Received: by 2002:ac8:5cd0:0:b0:51c:1ec5:d00 with SMTP id
 d75a77b69052e-51c748becccmr56230301cf.44.1783430134244; 
 Tue, 07 Jul 2026 06:15:34 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:51c:1ec5:d00 with SMTP id
 d75a77b69052e-51c748becccmr56228571cf.44.1783430133251; 
 Tue, 07 Jul 2026 06:15:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ad9bcd7dsm136266566b.30.2026.07.07.06.15.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] hw/block: m25p80: Fix dummy byte handling for
 Numonyx/Micron flash
Date: Tue,  7 Jul 2026 15:12:16 +0200
Message-ID: <20260707131223.51505-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Hq0vsa23Mcg64zJ3nU9hS26I7bEXBTxB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXy8DH+DVbHtte
 /PkXVGCXKfHHL1IvGLVbrVy09xgHASHqf1zNuHEpV/AsQ1E1zv8bSL9IctUGQnpwUSpbmb0Ktxz
 xY5QeLDyY8hjbMd5M5Nkb7x7/Kikr7UKGFtQQ5fgmQJfa/y+MbPrjwAkHrp03MCIOKHd5b4L7Hq
 rx+JVfQAH0oA3z/6Ll2FDRM0Cmw9Oa2fBt+29PY5lpDOUgdZyEyzqvpUbkQkcOKt6RDXXiFY2ju
 QG5dKuAXK9hJhaQPWj0z1ZQCGJP6NPTlVUrzlD2/sWulV5t3bUD1erYyrdpuyQacg1Ygsj3cxw+
 Bii/xkGFtkSOr+iDX6KnTFSWzvzyQVkV3ZrE2s986yoqGEhoHh10SWfPtBytglSvIFlVFFpdFi7
 T2teGIdluQA845HX5v5L9jLk8dxWQBsb59WrqOz4H2MsnNd29ssxX9qGXegAjXKlDtGIgbbirRN
 NT1bujYofHprFTf48BA==
X-Authority-Analysis: v=2.4 cv=PIM/P/qC c=1 sm=1 tr=0 ts=6a4cfbf7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=_tVgneDzAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=j_5u0sDhxC92FegueaQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=7z910WYokG1E8T7esZJN:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXzf7qV+AShgBu
 xLrtRAG11QOAqg0lwl0I08UxeAJ/IvhOHNYWXbqOnnvvF3SlntCUzjriVETOvfmE99IB/HVB+71
 +UOMWs8lgCSegb+uNRpRW4yuBWMfPlc=
X-Proofpoint-GUID: Hq0vsa23Mcg64zJ3nU9hS26I7bEXBTxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
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

From: Bin Meng <bin.meng@processmission.com>

Numonyx/Micron flashes [1] do not use one fixed dummy-phase width for all
fast-read commands. The volatile configuration register stores a number
of dummy clock cycles, and QEMU must convert that value to the number of
SSI bytes consumed by the flash model.

Keep the existing default: 10 dummy clocks in Quad I/O mode and 8 dummy
clocks otherwise. In Quad I/O and Dual I/O protocol modes, all command
phases are transferred on 4 or 2 lines, so the dummy clock count still
needs to be scaled by that bus width.

Standard SPI, also called extended SPI in the Micron datasheet, is more
subtle. Quad Output Fast Read (6Bh) and Dual Output Fast Read (3Bh) keep
the opcode and address phases on DQ0; their dummy phase is just a clock
gap before data is returned on four or two output lines. Do not scale the
dummy count for those output-only commands. Only Quad I/O Fast Read
(EBh) and Dual I/O Fast Read (BBh) transfer the address and dummy phases
on the 4-bit or 2-bit bus, so keep scaling those commands.

[1] https://docs.rs-online.com/cad7/0900766b8121bd3c.pdf

Fixes: 23af26856606 ("hw/block/m25p80: Fix Numonyx fast read dummy cycle count")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-3-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/block/m25p80.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 59ecb32c0a2..83d1ce1f956 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -971,28 +971,57 @@ static uint8_t numonyx_mode(Flash *s)
     }
 }
 
-static uint8_t numonyx_extract_cfg_num_dummies(Flash *s)
+static uint8_t numonyx_extract_cfg_dummy_bytes(Flash *s)
 {
-    uint8_t num_dummies;
+    uint8_t dummy_bits;
     uint8_t mode;
-    assert(get_man(s) == MAN_NUMONYX);
 
     mode = numonyx_mode(s);
-    num_dummies = extract32(s->volatile_cfg, 4, 4);
+    dummy_bits = extract32(s->volatile_cfg, 4, 4);
 
-    if (num_dummies == 0x0 || num_dummies == 0xf) {
+    /*
+     * The default nubmer of dummy cycles is only related to the SPI
+     * protocol mode. For QSPI it is 10, otherwise it is 8.
+     */
+    if (dummy_bits == 0x0 || dummy_bits == 0xf) {
+        dummy_bits = (mode == MODE_QIO) ? 10 : 8;
+    }
+
+    /*
+     * Convert the number of dummy cycles to bytes.
+     *
+     * In the Dual I/O and Quad I/O protocols, all command phases use 2 or 4
+     * lines. In standard/extended SPI mode the phase width depends on the
+     * command sequence: output-only fast reads keep the dummy clocks on the
+     * single address line, while input/output fast reads use the same 2-line
+     * or 4-line phase as the address.
+     */
+
+    if (mode == MODE_QIO) {
+        dummy_bits *= 4;
+    } else if (mode == MODE_DIO) {
+        dummy_bits *= 2;
+    } else {
         switch (s->cmd_in_progress) {
         case QIOR:
         case QIOR4:
-            num_dummies = 10;
+            dummy_bits *= 4;
             break;
-        default:
-            num_dummies = (mode == MODE_QIO) ? 10 : 8;
+        case DIOR:
+        case DIOR4:
+            dummy_bits *= 2;
             break;
-        }
+         }
     }
 
-    return num_dummies;
+    /*
+     * Assert that the dummy bit count is byte-aligned
+     * as SSI core can only consume whole dummy bytes.
+     */
+    assert(dummy_bits % 8 == 0);
+
+    /* return the number of dummy bytes */
+    return dummy_bits / 8;
 }
 
 static void decode_fast_read_cmd(Flash *s)
@@ -1007,7 +1036,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         if (extract32(s->volatile_cfg, 6, 2) == 1) {
@@ -1059,7 +1088,7 @@ static void decode_dio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
@@ -1109,7 +1138,7 @@ static void decode_qio_read_cmd(Flash *s)
                                     );
         break;
     case MAN_NUMONYX:
-        s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
+        s->needed_bytes += numonyx_extract_cfg_dummy_bytes(s);
         break;
     case MAN_MACRONIX:
         switch (extract32(s->volatile_cfg, 6, 2)) {
-- 
2.53.0


