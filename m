Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ADCC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 17:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZZBa-0003lK-9s; Thu, 01 Aug 2024 13:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBN-0003Bu-Rc
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZZBI-0003PP-7v
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:01:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so13912035e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722531694; x=1723136494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEpPP/gLyb01FjFU1GaOa/ZCkfr9qXkoXvqgzbcSUN8=;
 b=wo3oGhqkTTiYKYV54rgbGJmT42U+lsGSrAjGfNyHHmE/aS/HHq395xaUPIAdCYuCbh
 wMtkYtn0zCvQrF1/9IaHbrNe109krflQoTIQ2dynS2n53c49UxFq3XlCQSlLoStSAx1a
 hYpsncCD+Qz+PQBJSuA5/Q+IOtjlmKJuifvdAhTQhI4dezK6XhPRX0RtAe7lyVJJ4OBX
 F26pEYXo/+IZBn9rYpt4MA2RHaYI3qKzmQvNfEz7vFXoJC9z9cCNqwBVRE99LuCg29hX
 xYXoBKX3fN2NyewznZfxoN5qYFYFamS0QZL1/UZsBtBI01/aLibbcSrl+znntsu7GuDf
 Mb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722531694; x=1723136494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEpPP/gLyb01FjFU1GaOa/ZCkfr9qXkoXvqgzbcSUN8=;
 b=b0YO0INDEhLRnXPXnf6mbSONMPgkotj/ixmNwcL3rOBDoQhfrYGpsPvS75GgbjdpHf
 H8ZoneSiRhlDLlnWMM5NYv95/I11CIZ7n1oWYWUmUwGAyiFvJH0es6V02GgIPqmIiQHR
 tWlXxpwfpAKpP3JkRYqeDRScFJEM0F1mLxgLnYWxX201LIBadtL+bDBNCCYVpfDCtUyc
 LizIaii2su0r1mRfs6mbOjS0xNNM8SYEAtRx8ifffEj023ly/3YNbJML1c8KMq4gcmgQ
 1SQ8BELnUEyAN/1k0J4Uv3Dka+VoBUOJvTWwtksdHu837b6PAJroeBb5fl1AFRdlEC/c
 5JzA==
X-Gm-Message-State: AOJu0YyUofuSoeXxBFvuD+BncD7w0eQRi42jm0rtXSdMvCwPTQYX6Qoj
 /Wj0F7+SCirE3syin/WyyxEShIfsfpF+7AcQKh9U2im/8+3t5qlAQaTO1FEe1/2TBbEebGaelmg
 h
X-Google-Smtp-Source: AGHT+IHKg+TJ5nRfwIgXOUsOxG5aSPZnkagTGhgTpgX3iMEMHnSOn8W9X1qQUf00sVMkuRCx3ejcOw==
X-Received: by 2002:a05:600c:4f95:b0:426:6981:1bd with SMTP id
 5b1f17b1804b1-428e699a4d9mr6297035e9.5.1722531693250; 
 Thu, 01 Aug 2024 10:01:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e24c2b4csm30385255e9.31.2024.08.01.10.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:01:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH 1/5] docs/specs/rocker.txt: Convert to rST
Date: Thu,  1 Aug 2024 18:01:27 +0100
Message-Id: <20240801170131.3977807-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801170131.3977807-1-peter.maydell@linaro.org>
References: <20240801170131.3977807-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the rocker.txt specification document to rST format.  We make
extensive use of the :: marker to introduce a literal block for all
the tables and ASCII art, rather than trying to convert the tables to
rST table syntax.  This produces a valid rST document without needing
a huge diff.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                           |   2 +-
 docs/specs/index.rst                  |   1 +
 docs/specs/{rocker.txt => rocker.rst} | 181 +++++++++++++-------------
 3 files changed, 93 insertions(+), 91 deletions(-)
 rename docs/specs/{rocker.txt => rocker.rst} (91%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b3c673608..2a183fe960b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2463,7 +2463,7 @@ S: Maintained
 F: hw/net/rocker/
 F: qapi/rocker.json
 F: tests/rocker/
-F: docs/specs/rocker.txt
+F: docs/specs/rocker.rst
 
 e1000x
 M: Dmitry Fleytman <dmitry.fleytman@gmail.com>
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index be899b49c28..6495ed5ed9e 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -35,3 +35,4 @@ guest hardware that is specific to QEMU.
    vmcoreinfo
    vmgenid
    rapl-msr
+   rocker
diff --git a/docs/specs/rocker.txt b/docs/specs/rocker.rst
similarity index 91%
rename from docs/specs/rocker.txt
rename to docs/specs/rocker.rst
index 1857b317030..3a7fc6a7e0e 100644
--- a/docs/specs/rocker.txt
+++ b/docs/specs/rocker.rst
@@ -1,23 +1,23 @@
 Rocker Network Switch Register Programming Guide
-Copyright (c) Scott Feldman <sfeldma@gmail.com>
-Copyright (c) Neil Horman <nhorman@tuxdriver.com>
-Version 0.11, 12/29/2014
+************************************************
 
-LICENSE
-=======
+..
+   Copyright (c) Scott Feldman <sfeldma@gmail.com>
+   Copyright (c) Neil Horman <nhorman@tuxdriver.com>
+   Version 0.11, 12/29/2014
 
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License as published by
-the Free Software Foundation; either version 2 of the License, or
-(at your option) any later version.
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2 of the License, or
+   (at your option) any later version.
 
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-GNU General Public License for more details.
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+   GNU General Public License for more details.
 
-SECTION 1: Introduction
-=======================
+Introduction
+============
 
 Overview
 --------
@@ -29,25 +29,25 @@ software.
 Notations and Conventions
 -------------------------
 
-o In register descriptions, [n:m] indicates a range from bit n to bit m,
-inclusive.
-o Use of leading 0x indicates a hexadecimal number.
-o Use of leading 0b indicates a binary number.
-o The use of RSVD or Reserved indicates that a bit or field is reserved for
-future use.
-o Field width is in bytes, unless otherwise noted.
-o Register are (R) read-only, (R/W) read/write, (W) write-only, or (COR) clear
-on read
-o TLV values in network-byte-order are designated with (N).
+* In register descriptions, [n:m] indicates a range from bit n to bit m,
+  inclusive.
+* Use of leading 0x indicates a hexadecimal number.
+* Use of leading 0b indicates a binary number.
+* The use of RSVD or Reserved indicates that a bit or field is reserved for
+  future use.
+* Field width is in bytes, unless otherwise noted.
+* Register are (R) read-only, (R/W) read/write, (W) write-only, or (COR) clear
+  on read
+* TLV values in network-byte-order are designated with (N).
 
 
-SECTION 2: PCI Configuration Registers
-======================================
+PCI Configuration Registers
+===========================
 
 PCI Configuration Space
 -----------------------
 
-Each switch instance registers as a PCI device with PCI configuration space:
+Each switch instance registers as a PCI device with PCI configuration space::
 
 	offset	width	description		value
 	---------------------------------------------
@@ -74,11 +74,10 @@ Each switch instance registers as a PCI device with PCI configuration space:
 	0x41	1	Retry count
 	0x42	2	Reserved
 
+        * Assigned by sub-system implementation
 
-* Assigned by sub-system implementation
-
-SECTION 3: Memory-Mapped Register Space
-=======================================
+Memory-Mapped Register Space
+============================
 
 There are two memory-mapped BARs.  BAR0 maps device register space and is
 0x2000 in size.  BAR1 maps MSI-X vector and PBA tables and is also 0x2000 in
@@ -89,7 +88,7 @@ byte registers with one 4-byte access, and 8 byte registers with either two
 4-byte accesses or a single 8-byte access.  In the case of two 4-byte accesses,
 access must be lower and then upper 4-bytes, in that order.
 
-BAR0 device register space is organized as follows:
+BAR0 device register space is organized as follows::
 
 	offset		description
 	------------------------------------------------------
@@ -105,7 +104,7 @@ Reads to reserved registers read back as 0.
 
 No fancy stuff like write-combining is enabled on any of the registers.
 
-BAR1 MSI-X register space is organized as follows:
+BAR1 MSI-X register space is organized as follows::
 
 	offset		description
 	------------------------------------------------------
@@ -113,8 +112,8 @@ BAR1 MSI-X register space is organized as follows:
 	0x1000-0x1fff	MSI-X PBA table
 
 
-SECTION 4: Interrupts, DMA, and Endianness
-==========================================
+Interrupts, DMA, and Endianness
+===============================
 
 PCI Interrupts
 --------------
@@ -122,7 +121,7 @@ PCI Interrupts
 The device supports only MSI-X interrupts.  BAR1 memory-mapped region contains
 the MSI-X vector and PBA tables, with support for up to 256 MSI-X vectors.
 
-The vector assignment is:
+The vector assignment is::
 
 	vector		description
 	-----------------------------------------------------
@@ -134,7 +133,7 @@ The vector assignment is:
 			  Tx vector is even
 			  Rx vector is odd
 
-A MSI-X vector table entry is 16 bytes:
+A MSI-X vector table entry is 16 bytes::
 
 	field		offset	width	description
 	-------------------------------------------------------------
@@ -170,7 +169,7 @@ ring, and hardware will set this bit when the descriptor is complete.
 Descriptor ring sizes must be a power of 2 and range from 2 to 64K entries.
 Descriptor rings' base address must be 8-byte aligned.  Descriptors must be
 packed within ring.  Each descriptor in each ring must also be aligned on an 8
-byte boundary.  Each descriptor ring will have these registers:
+byte boundary.  Each descriptor ring will have these registers::
 
 	DMA_DESC_xxx_BASE_ADDR, offset 0x1000 + (x * 32), 64-bit, (R/W)
 	DMA_DESC_xxx_SIZE, offset 0x1008 + (x * 32), 32-bit, (R/W)
@@ -180,7 +179,7 @@ byte boundary.  Each descriptor ring will have these registers:
 	DMA_DESC_xxx_CREDITS, offset 0x1018 + (x * 32), 32-bit, (R/W)
 	DMA_DESC_xxx_RSVD1, offset 0x101c + (x * 32), 32-bit, (R/W)
 
-Where x is descriptor ring index:
+Where x is descriptor ring index::
 
 	index		ring
 	--------------------
@@ -203,14 +202,14 @@ written past TAIL.  To do so would wrap the ring.  An empty ring is when HEAD
 == TAIL.  A full ring is when HEAD is one position behind TAIL.  Both HEAD and
 TAIL increment and modulo wrap at the ring size.
 
-CTRL register bits:
+CTRL register bits::
 
 	bit	name		description
 	------------------------------------------------------------------------
 	[0]	CTRL_RESET	Reset the descriptor ring
 	[1:31]	Reserved
 
-All descriptor types share some common fields:
+All descriptor types share some common fields::
 
 	field			width	description
 	-------------------------------------------------------------------
@@ -234,7 +233,7 @@ filled in by the switch.  Likewise, the switch will ignore unknown fields
 filled in by software.
 
 Descriptor payload buffer is 8-byte aligned and TLVs are 8-byte aligned.  The
-value within a TLV is also 8-byte aligned.  The (packed, 8 byte) TLV header is:
+value within a TLV is also 8-byte aligned.  The (packed, 8 byte) TLV header is::
 
 	field	width	description
 	-----------------------------
@@ -246,7 +245,7 @@ The alignment requirements for descriptors and TLVs are to avoid unaligned
 access exceptions in software.  Note that the payload for each TLV is also
 8 byte aligned.
 
-Figure 1 shows an example descriptor buffer with two TLVs.
+Figure 1 shows an example descriptor buffer with two TLVs::
 
                   <------- 8 bytes ------->
 
@@ -316,11 +315,11 @@ network packet data.  All non-network-packet TLV multi-byte values will be LE.
 TLV values in network-byte-order are designated with (N).
 
 
-SECTION 5: Test Registers
-=========================
+Test Registers
+==============
 
 Rocker has several test registers to support troubleshooting register access,
-interrupt generation, and DMA operations:
+interrupt generation, and DMA operations::
 
 	TEST_REG, offset 0x0010, 32-bit (R/W)
 	TEST_REG64, offset 0x0018, 64-bit (R/W)
@@ -338,7 +337,7 @@ for that vector.
 
 To test basic DMA operations, allocate a DMA-able host buffer and put the
 buffer address into TEST_DMA_ADDR and size into TEST_DMA_SIZE.  Then, write to
-TEST_DMA_CTRL to manipulate the buffer contents.  TEST_DMA_CTRL operations are:
+TEST_DMA_CTRL to manipulate the buffer contents.  TEST_DMA_CTRL operations are::
 
 	operation		value	description
 	-----------------------------------------------------------
@@ -351,14 +350,14 @@ issue exists.  In particular, buffers that start on odd-8-byte boundary and/or
 span multiple PAGE sizes should be tested.
 
 
-SECTION 6: Ports
-================
+Ports
+=====
 
 Physical and Logical Ports
 ------------------------------------
 
 The switch supports up to 62 physical (front-panel) ports.  Register
-PORT_PHYS_COUNT returns the actual number of physical ports available:
+PORT_PHYS_COUNT returns the actual number of physical ports available::
 
 	PORT_PHYS_COUNT, offset 0x0304, 32-bit, (R)
 
@@ -369,7 +368,7 @@ Front-panel ports and logical tunnel ports are mapped into a single 32-bit port
 space.  A special CPU port is assigned port 0.  The front-panel ports are
 mapped to ports 1-62.  A special loopback port is assigned port 63.  Logical
 tunnel ports are assigned ports 0x0001000-0x0001ffff.
-To summarize the port assignments:
+To summarize the port assignments::
 
 	port			mapping
 	-------------------------------------------------------
@@ -391,14 +390,14 @@ set/get the mode for front-panel ports, see port settings, below.
 Port Settings
 -------------
 
-Link status for all front-panel ports is available via PORT_PHYS_LINK_STATUS:
+Link status for all front-panel ports is available via PORT_PHYS_LINK_STATUS::
 
 	PORT_PHYS_LINK_STATUS, offset 0x0310, 64-bit, (R)
 
 	Value is port bitmap.  Bits 0 and 63 always read 0.  Bits 1-62
 	read 1 for link UP and 0 for link DOWN for respective front-panel ports.
 
-Other properties for front-panel ports are available via DMA CMD descriptors:
+Other properties for front-panel ports are available via DMA CMD descriptors::
 
 	Get PORT_SETTINGS descriptor:
 
@@ -438,7 +437,7 @@ Port Enable
 -----------
 
 Front-panel ports are initially disabled, which means port ingress and egress
-packets will be dropped.  To enable or disable a port, use PORT_PHYS_ENABLE:
+packets will be dropped.  To enable or disable a port, use PORT_PHYS_ENABLE::
 
 	PORT_PHYS_ENABLE: offset 0x0318, 64-bit, (R/W)
 
@@ -447,15 +446,15 @@ packets will be dropped.  To enable or disable a port, use PORT_PHYS_ENABLE:
 	Default is 0.
 
 
-SECTION 7: Switch Control
-=========================
+Switch Control
+==============
 
 This section covers switch-wide register settings.
 
 Control
 -------
 
-This register is used for low level control of the switch.
+This register is used for low level control of the switch::
 
 	CONTROL: offset 0x0300, 32-bit, (W)
 
@@ -468,18 +467,18 @@ Switch ID
 ---------
 
 The switch has a SWITCH_ID to be used by software to uniquely identify the
-switch:
+switch::
 
 	SWITCH_ID: offset 0x0320, 64-bit, (R)
 
 	Value is opaque to switch software and no special encoding is implied.
 
 
-SECTION 8: Events
-=================
+Events
+======
 
 Non-I/O asynchronous events from the device are notified to the host using the
-event ring.  The TLV structure for events is:
+event ring.  The TLV structure for events is::
 
 	field		width	description
 	---------------------------------------------------
@@ -491,7 +490,7 @@ event ring.  The TLV structure for events is:
 Link Changed Event
 ------------------
 
-When link status changes on a physical port, this event is generated.
+When link status changes on a physical port, this event is generated::
 
 	field		width	description
 	---------------------------------------------------
@@ -510,6 +509,8 @@ driver should install to the device the MAC/VLAN on the port into the bridge
 table.  Once installed, the MAC/VLAN is known on the port and this event will
 no longer be generated.
 
+::
+
 	field		width	description
 	---------------------------------------------------
 	INFO		<nest>
@@ -518,8 +519,8 @@ no longer be generated.
 	  VLAN		2	VLAN ID
 
 
-SECTION 9: CPU Packet Processing
-================================
+CPU Packet Processing
+=====================
 
 Ingress packets directed to the host CPU for further processing are delivered
 in the DMA RX ring.  Likewise, host CPU originating packets destined to egress
@@ -540,7 +541,7 @@ software that Tx is complete and software resources (e.g. skb) backing packet
 can be released.
 
 Figure 2 shows an example 3-fragment packet queued with one Tx descriptor.  A
-TLV is used for each packet fragment.
+TLV is used for each packet fragment::
 
 	                                           pkt frag 1
 	                                           +–––––––+  +–+
@@ -570,7 +571,7 @@ TLV is used for each packet fragment.
 
 				fig 2.
 
-The TLVs for Tx descriptor buffer are:
+The TLVs for Tx descriptor buffer are::
 
 	field			width	description
 	---------------------------------------------------------------------
@@ -600,7 +601,7 @@ The TLVs for Tx descriptor buffer are:
 	    TX_FRAG_ADDR	8	DMA address of packet fragment
 	    TX_FRAG_LEN		2	Packet fragment length
 
-Possible status return codes in descriptor on completion are:
+Possible status return codes in descriptor on completion are::
 
 	DESC_COMP_ERR	reason
 	--------------------------------------------------------------------
@@ -623,7 +624,7 @@ worst-case packet size.  A single Rx descriptor will contain the entire Rx
 packet data in one RX_FRAG.  Other Rx TLVs describe and hardware offloads
 performed on the packet, such as checksum validation.
 
-The TLVs for Rx descriptor buffer are:
+The TLVs for Rx descriptor buffer are::
 
 	field		width	description
 	---------------------------------------------------
@@ -649,7 +650,7 @@ The TLVs for Rx descriptor buffer are:
 Offload forward RX_FLAG indicates the device has already forwarded the packet
 so the host CPU should not also forward the packet.
 
-Possible status return codes in descriptor on completion are:
+Possible status return codes in descriptor on completion are::
 
 	DESC_COMP_ERR	reason
 	--------------------------------------------------------------------
@@ -660,14 +661,14 @@ Possible status return codes in descriptor on completion are:
 			packet data TLV and other TLVs.
 
 
-SECTION 10: OF-DPA Mode
-======================
+OF-DPA Mode
+===========
 
 OF-DPA mode allows the switch to offload flow packet processing functions to
 hardware.  An OpenFlow controller would communicate with an OpenFlow agent
 installed on the switch.  The OpenFlow agent would (directly or indirectly)
 communicate with the Rocker switch driver, which in turn would program switch
-hardware with flow functionality, as defined in OF-DPA.  The block diagram is:
+hardware with flow functionality, as defined in OF-DPA.  The block diagram is::
 
 		+–––––––––––––––----–––+
 		|        OF            |
@@ -696,14 +697,14 @@ OF-DPA Flow Table Interface
 
 There are commands to add, modify, delete, and get stats of flow table entries.
 The commands are issued using the DMA CMD descriptor ring.  The following
-commands are defined:
+commands are defined::
 
 	CMD_ADD:		add an entry to flow table
 	CMD_MOD:		modify an entry in flow table
 	CMD_DEL:		delete an entry from flow table
 	CMD_GET_STATS:		get stats for flow entry
 
-TLVs for add and modify commands are:
+TLVs for add and modify commands are::
 
 	field			width	description
 	----------------------------------------------------
@@ -723,14 +724,14 @@ TLVs for add and modify commands are:
 
 Additional TLVs based on flow table ID:
 
-Table ID 0: ingress port
+Table ID 0: ingress port::
 
 	field			width	description
 	----------------------------------------------------
 	OF_DPA_IN_PPORT		4	ingress physical port number
 	OF_DPA_GOTO_TBL		2	goto table ID; zero to drop
 
-Table ID 10: vlan
+Table ID 10: vlan::
 
 	field			width	description
 	----------------------------------------------------
@@ -740,7 +741,7 @@ Table ID 10: vlan
 	OF_DPA_GOTO_TBL		2	goto table ID; zero to drop
 	OF_DPA_NEW_VLAN_ID	2 (N)	new vlan ID
 
-Table ID 20: termination mac
+Table ID 20: termination mac::
 
 	field			width	description
 	----------------------------------------------------
@@ -757,7 +758,7 @@ Table ID 20: termination mac
 	OF_DPA_OUT_PPORT	2	if specified, must be
 					controller, set zero otherwise
 
-Table ID 30: unicast routing
+Table ID 30: unicast routing::
 
 	field			width	description
 	----------------------------------------------------
@@ -772,7 +773,7 @@ Table ID 30: unicast routing
 	OF_DPA_GROUP_ID		4	data for GROUP action must
 					be an L3 Unicast group entry
 
-Table ID 40: multicast routing
+Table ID 40: multicast routing::
 
 	field			width	description
 	----------------------------------------------------
@@ -797,7 +798,7 @@ Table ID 40: multicast routing
 	OF_DPA_GROUP_ID		4	data for GROUP action must
 					be an L3 multicast group entry
 
-Table ID 50: bridging
+Table ID 50: bridging::
 
 	field			width	description
 	----------------------------------------------------
@@ -818,7 +819,7 @@ Table ID 50: bridging
 					restricted to CONTROLLER,
 					set to 0 otherwise
 
-Table ID 60: acl policy
+Table ID 60: acl policy::
 
 	field			width	description
 	----------------------------------------------------
@@ -890,7 +891,7 @@ Table ID 60: acl policy
 					dropped (all other instructions
 					ignored)
 
-TLVs for flow delete and get stats command are:
+TLVs for flow delete and get stats command are::
 
 	field			width	description
 	---------------------------------------------------
@@ -898,7 +899,7 @@ TLVs for flow delete and get stats command are:
 	OF_DPA_COOKIE		8	Cookie
 
 On completion of get stats command, the descriptor buffer is written back with
-the following TLVs:
+the following TLVs::
 
 	field			width	description
 	---------------------------------------------------
@@ -906,7 +907,7 @@ the following TLVs:
 	OF_DPA_STAT_RX_PKTS	8	Received packets
 	OF_DPA_STAT_TX_PKTS	8	Transmit packets
 
-Possible status return codes in descriptor on completion are:
+Possible status return codes in descriptor on completion are::
 
 	DESC_COMP_ERR	command			reason
 	--------------------------------------------------------------------
@@ -928,14 +929,14 @@ Group Table Interface
 
 There are commands to add, modify, delete, and get stats of group table
 entries.  The commands are issued using the DMA CMD descriptor ring.  The
-following commands are defined:
+following commands are defined::
 
 	CMD_ADD:		add an entry to group table
 	CMD_MOD:		modify an entry in group table
 	CMD_DEL:		delete an entry from group table
 	CMD_GET_STATS:		get stats for group entry
 
-TLVs for add and modify commands are:
+TLVs for add and modify commands are::
 
 	field			width	description
 	-----------------------------------------------------------
@@ -969,7 +970,7 @@ TLVs for add and modify commands are:
 	  FLOW_SRC_MAC		6	(types 1, 2, 5)
 	  FLOW_DST_MAC		6	(types 1, 2)
 
-TLVs for flow delete and get stats command are:
+TLVs for flow delete and get stats command are::
 
 	field			width	description
 	-----------------------------------------------------------
@@ -977,7 +978,7 @@ TLVs for flow delete and get stats command are:
 	FLOW_GROUP_ID		2	Flow group ID
 
 On completion of get stats command, the descriptor buffer is written back with
-the following TLVs:
+the following TLVs::
 
 	field			width	description
 	---------------------------------------------------
@@ -986,7 +987,7 @@ the following TLVs:
 	FLOW_STAT_REF_COUNT	4	Flow reference count
 	FLOW_STAT_BUCKET_COUNT	4	Flow bucket count
 
-Possible status return codes in descriptor on completion are:
+Possible status return codes in descriptor on completion are::
 
 	DESC_COMP_ERR	command			reason
 	--------------------------------------------------------------------
-- 
2.34.1


