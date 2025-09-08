Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B608CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbXP-00013f-9v; Mon, 08 Sep 2025 09:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvbXF-00012p-S8
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:03:53 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arpit1.kumar@samsung.com>)
 id 1uvbX0-0007J5-Gi
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:03:53 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250908130317epoutp03ce24b2965283162db0477bae650f2651~jUFMulkCI1094810948epoutp03X
 for <qemu-devel@nongnu.org>; Mon,  8 Sep 2025 13:03:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250908130317epoutp03ce24b2965283162db0477bae650f2651~jUFMulkCI1094810948epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1757336597;
 bh=LN4sH3UwtU8HIQkrEetlva5pwUT35yq63hIpFGzCTV0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=D90R3n1CBgsk4Uvv13gBkZdI3W8MGUujqT+wVd7a8/1OE8a2p82cg7S1Tafs0E7uj
 lighSfX0gtPk7dMnGAdx57SvqPCBZtB2Q7n6auIk2cJhjkPcjDfdiXQbuc8l3t4OE0
 v1XVqoNkv3lMHP5aYwZDxG35pDTqmxpov04g5apU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20250908130316epcas5p25fd6caaa932fdd13a4133e376d1bc338~jUFLhYoNP1212412124epcas5p2E;
 Mon,  8 Sep 2025 13:03:16 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4cL6ZW3l7lz2SSKY; Mon,  8 Sep
 2025 13:03:15 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20250908130314epcas5p35e0086154cafff6515126e01f7981d3b~jUFJ61k3a2761427614epcas5p3A;
 Mon,  8 Sep 2025 13:03:14 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20250908130313epsmtip1d1c2bbfc880dc95c15605b896d1d6252~jUFIfPFrE1029310293epsmtip13;
 Mon,  8 Sep 2025 13:03:13 +0000 (GMT)
Date: Mon, 8 Sep 2025 18:33:03 +0530
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: qemu-devel@nongnu.org, gost.dev@samsung.com, linux-cxl@vger.kernel.org,
 dave@stgolabs.net, Jonathan.Cameron@huawei.com, vishak.g@samsung.com,
 krish.reddy@samsung.com, a.manzanares@samsung.com, alok.rathore@samsung.com,
 cpgs@samsung.com
Subject: Re: [PATCH v3 2/2] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250908130303.hxqdq5yldwpguojo@test-PowerEdge-R740xd>
MIME-Version: 1.0
In-Reply-To: <2d731c30-bf0c-49c6-b519-4b558d794b08@oracle.com>
X-CMS-MailID: 20250908130314epcas5p35e0086154cafff6515126e01f7981d3b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <CGME20250904131944epcas5p351c0e073a975b1347c4a61aa0dd511f3@epcas5p3.samsung.com>
 <20250904131904.725758-3-arpit1.kumar@samsung.com>
 <2d731c30-bf0c-49c6-b519-4b558d794b08@oracle.com>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=arpit1.kumar@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 05/09/25 02:18PM, ALOK TIWARI wrote:
>
>>@@ -4791,6 +4907,28 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>>      cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
>>      cci->d = d;
>>      cci->intf = intf;
>>+    CXLUpstreamPort *pp;
>>+    int pn = 0;
>>      cxl_init_cci(cci, payload_max);
>>      cxl_set_phy_port_info(cci);
>>+    /* physical port control */
>>+    pp = CXL_USP(cci->d);
>>+    for (int byte_index = 0; byte_index < (CXL_MAX_PHY_PORTS / BITS_PER_BYTE);
>>+         byte_index++) {
>>+        unsigned char byte = pp->pports.active_port_bitmask[byte_index];
>>+
>>+        for (int bit_index = 0; bit_index < 8; bit_index++, pn++) {
>>+            if (((byte) & (1 << bit_index)) != 0) {
>>+                qemu_mutex_init(&pp->pports.perst[pn].lock);
>>+                pp->pports.perst[pn].issued_assert_perst = false;
>>+                /*
>>+                 * Assert PERST involves physical port to be in
>>+                 * hold reset phase for minimum 100ms. No other
>>+                 * physcial port control requests are entertained
>
>typo physcial -> physical
>
Thanks for pointing out!
>>+                 * until Deassert PERST command.
>>+                 */
>>+                pp->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
>>+            }
>>+        }
>>+    }
>>  }
>>diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
>>index 9fc720ec10..033d9bf11a 100644
>>--- a/include/hw/cxl/cxl_device.h
>>+++ b/include/hw/cxl/cxl_device.h
>>@@ -130,6 +130,7 @@
>>                    (1 << 16))
>>  #define CXL_MAX_PHY_PORTS 256
>>+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
>>  /* physical port control info - CXL r3.2 table 7-19 */
>>  #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
>>@@ -196,6 +197,14 @@ typedef struct CXLPhyPortInfo {
>>      uint8_t supported_ld_count;
>>  } QEMU_PACKED CXLPhyPortInfo;
>>+/* Assert - Deassert PERST */
>>+typedef struct CXLPhyPortPerst {
>>+    bool issued_assert_perst;
>>+    QemuMutex lock; /* protecting assert-deassert reset request */
>>+    uint64_t asrt_time;
>>+    QemuThread asrt_thread; /* thread for 100ms delay */
>>+} CXLPhyPortPerst;
>>+
>>  /* CXL r3.1 Table 8-34: Command Return Codes */
>>  typedef enum {
>>      CXL_MBOX_SUCCESS = 0x0,
>>diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
>>index 5c918c53a9..5c31023590 100644
>>--- a/include/hw/cxl/cxl_mailbox.h
>>+++ b/include/hw/cxl/cxl_mailbox.h
>>@@ -88,6 +88,7 @@ enum {
>>      PHYSICAL_SWITCH = 0x51,
>>          #define IDENTIFY_SWITCH_DEVICE      0x0
>>          #define GET_PHYSICAL_PORT_STATE     0x1
>>+        #define PHYSICAL_PORT_CONTROL       0X2
>
>use 0X2 -> 0x2
>
Thanks for pointing out the typo's, will update the same in v4.
>>      TUNNEL = 0x53,
>>          #define MANAGEMENT_COMMAND     0x0
>>      MHD = 0x55,
>>diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
>>index 3b7e72bfe0..4b9da87d77 100644
>>--- a/include/hw/pci-bridge/cxl_upstream_port.h
>>+++ b/include/hw/pci-bridge/cxl_upstream_port.h
>>@@ -30,6 +30,7 @@ typedef struct CXLUpstreamPort {
>>          uint8_t num_ports;
>>          uint8_t active_port_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
>>          CXLPhyPortInfo pport_info[CXL_MAX_PHY_PORTS];
>>+        CXLPhyPortPerst perst[CXL_MAX_PHY_PORTS];
>>      } pports;
>>  } CXLUpstreamPort;
>>-- 2.34.1
>>
>
>Thanks,
>Alok
>

------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_
Content-Type: text/plain; charset="utf-8"


------AO5Z5CA5q82FpJQJAbIGDvoW6m12ppu.cCYhbwpEEtg295OJ=_f81a4_--

