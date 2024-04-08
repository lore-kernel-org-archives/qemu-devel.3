Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF66C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 11:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtnde-0003CO-JO; Mon, 08 Apr 2024 07:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rtnda-0003CF-Mx
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:58:10 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rtndY-0002JF-7u
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 07:58:10 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a51d05c50b2so142073966b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712577483; x=1713182283; darn=nongnu.org;
 h=content-transfer-encoding:organization:subject:cc:content-language
 :from:to:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vMbT0kcmgiqM5RcncIEUHlVztzn60aCaRofW6pVPH04=;
 b=kwM44sB7zAbBA9WpqKo068qWzmPFb2dQBXu4NUh/XKzhRjZzaa/s1x4QaSYCcb3nOo
 cHwVckkag88hIvlL9/VpPRyN5bz4UGaEm3fRStsaY1LS0mQTjVTQL8B33FyGZof9sloX
 rojBw7fsc3PzLx/J/EYA/xEideA/LW8DhNv+/6uxvzSqA5N7nURpxrx3wUHab8TZyOF1
 NyJffTYP8IRs7Sn3LjRzX+hH5/AuX4l3kTI5t5aeDwgTYvcXjKerEvqLsWJ4S+6zYwwh
 GIY3KQCyzo8jJtA2fKZ4Y08vxtFIseLAeQLDqNVPtZmRpqr06ca48FgzStl/6x2DzksA
 /f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712577483; x=1713182283;
 h=content-transfer-encoding:organization:subject:cc:content-language
 :from:to:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vMbT0kcmgiqM5RcncIEUHlVztzn60aCaRofW6pVPH04=;
 b=eyeXVZB2XGnXHV0ib8HtJ/wGQuhu5Gc3HIvVOxEzMToYG5qoAKyJ2yEciC58GdPpA5
 xkHK4FvGSzyzvl0f9hmVK1DBJA0D3yRCpyJ0lgkCNFgPqyueMdbdc1WzdL2hTR1h5n3Z
 nxsuhrgroGf2VcWKgUZKQNAQsifMlgCWnwRQ+SvzxSd9GGLJ4Yf3JARnovJd/tI1uJiN
 bLxJm2CsvcFPzPuDhOGkDr8+V/AtDZSMpDps9+/56Pgjz0onvstHzVSTfGjcFDn5mS7R
 XnuGnysZdYE8L5NMU+GRNEm3rc63XZexu2RF0UKNy9v99PUMqpNJlOdG904TYBnPiuer
 81iQ==
X-Gm-Message-State: AOJu0YwkuVuwiS8SxnzMgaWoRy7MatRepkpQjUIlx78tslgMoIHlBQH1
 NoQ1+5W4SMAU4Xnk3q3XS+ipHXjYRb6Fb+R2r65op5+rrBvh783+fX4Tpryqb41NHwlfFzGfhDg
 xRC4dvw==
X-Google-Smtp-Source: AGHT+IGAtZEuATnJIZ32Ml9zTs6Hh6g7ijaDCejaecsJWLb0jDI0bXnKBbbexk9Ztm8Lz9fPrAk7ug==
X-Received: by 2002:a17:907:1b24:b0:a51:b463:6b41 with SMTP id
 mp36-20020a1709071b2400b00a51b4636b41mr5701408ejc.61.1712577482547; 
 Mon, 08 Apr 2024 04:58:02 -0700 (PDT)
Received: from [192.168.200.139] (83.11.9.119.ipv4.supernova.orange.pl.
 [83.11.9.119]) by smtp.gmail.com with ESMTPSA id
 qs28-20020a170906459c00b00a51bed388a4sm2858713ejc.139.2024.04.08.04.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 04:58:02 -0700 (PDT)
Message-ID: <8b9b96e1-faaa-4866-aeb9-c439d5f83139@linaro.org>
Date: Mon, 8 Apr 2024 13:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Ard Biesheuvel <ardb+tianocore@kernel.org>,
 Xiong Yining <xiongyining1480@phytium.com.cn>,
 Chen Baozi <chenbaozi@phytium.com.cn>
Subject: How to use pxb-pcie in correct way?
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x632.google.com
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

For quite a while I am experimenting with PCI Express setup on SBSA-Ref 
system. And finally decided to write.

We want to play with NUMA setup and "pxb-pcie" can be assigned to NUMA 
node other than cpu0 one. But adding it makes other cards dissapear...

When I boot sbsa-ref I have plain PCIe setup:

(qemu) info pci
   Bus  0, device   0, function 0:
     Host bridge: PCI device 1b36:0008
       PCI subsystem 1af4:1100
       id ""
   Bus  0, device   1, function 0:
     Ethernet controller: PCI device 8086:10d3
       PCI subsystem 8086:0000
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id ""
   Bus  0, device   2, function 0:
     Display controller: PCI device 1234:1111
       PCI subsystem 1af4:1100
       BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
       BAR2: 32 bit memory at 0x81084000 [0x81084fff].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
       id ""

Adding extra PCIe card works fine - both just "igb" and "igb" with 
"pcie-root-port".

But adding "pcie-root-port" + "igb" and then "pxb-pcie" makes "igb" 
dissapear:

../code/qemu/build/qemu-system-aarch64
-monitor telnet::45454,server,nowait
-serial stdio
-device pcie-root-port,id=ULyWl,slot=0,chassis=0
-device igb,bus=ULyWl
-device pxb-pcie,bus_nr=1

(qemu) info pci
   Bus  0, device   0, function 0:
     Host bridge: PCI device 1b36:0008
       PCI subsystem 1af4:1100
       id ""
   Bus  0, device   1, function 0:
     Ethernet controller: PCI device 8086:10d3
       PCI subsystem 8086:0000
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id ""
   Bus  0, device   2, function 0:
     Display controller: PCI device 1234:1111
       PCI subsystem 1af4:1100
       BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
       BAR2: 32 bit memory at 0x81085000 [0x81085fff].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
       id ""
   Bus  0, device   3, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 0.
       secondary bus 1.
       subordinate bus 1.
       IO range [0xf000, 0x0fff]
       memory range [0xfff00000, 0x000fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81084000 [0x81084fff].
       id "ULyWl"
   Bus  0, device   4, function 0:
     Host bridge: PCI device 1b36:000b
       PCI subsystem 1af4:1100
       id ""


If I add "igb" directly (without root port) then it appears correctly:

(qemu) info pci
   Bus  0, device   0, function 0:
     Host bridge: PCI device 1b36:0008
       PCI subsystem 1af4:1100
       id ""
   Bus  0, device   1, function 0:
     Ethernet controller: PCI device 8086:10d3
       PCI subsystem 8086:0000
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id ""
   Bus  0, device   2, function 0:
     Display controller: PCI device 1234:1111
       PCI subsystem 1af4:1100
       BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
       BAR2: 32 bit memory at 0x810c4000 [0x810c4fff].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
       id ""
   Bus  0, device   3, function 0:
     Ethernet controller: PCI device 8086:10c9
       PCI subsystem 1af4:1100
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
       id ""
   Bus  0, device   4, function 0:
     Host bridge: PCI device 1b36:000b
       PCI subsystem 1af4:1100
       id ""


When I add "pcie-root-port" with "igb" followed by "pcie-root-port" and 
"pxb-pcie" then no IGB again:


-device pcie-root-port,id=RjKXs,slot=0,chassis=0
-device igb,bus=RjKXs
-device pcie-root-port,chassis=7
-device pxb-pcie,bus_nr=1


(qemu) info pci
   Bus  0, device   0, function 0:
     Host bridge: PCI device 1b36:0008
       PCI subsystem 1af4:1100
       id ""
   Bus  0, device   1, function 0:
     Ethernet controller: PCI device 8086:10d3
       PCI subsystem 8086:0000
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id ""
   Bus  0, device   2, function 0:
     Display controller: PCI device 1234:1111
       PCI subsystem 1af4:1100
       BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
       BAR2: 32 bit memory at 0x81086000 [0x81086fff].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
       id ""
   Bus  0, device   3, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 0.
       secondary bus 1.
       subordinate bus 1.
       IO range [0xf000, 0x0fff]
       memory range [0xfff00000, 0x000fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81085000 [0x81085fff].
       id "RjKXs"
   Bus  0, device   4, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 0.
       secondary bus 2.
       subordinate bus 2.
       IO range [0xf000, 0x0fff]
       memory range [0xfff00000, 0x000fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81084000 [0x81084fff].
       id ""
   Bus  0, device   5, function 0:
     Host bridge: PCI device 1b36:000b
       PCI subsystem 1af4:1100
       id ""


Same (no "igb") with more complex structure behind "pxb-pcie" bridge:

../code/qemu/build/qemu-system-aarch64 
 

-monitor telnet::45454,server,nowait 
 

-serial stdio 
 

-device pcie-root-port,id=PrZUz,slot=0,chassis=0 
 

-device igb,bus=PrZUz 
 

-device pcie-root-port,chassis=7 
 

-device pxb-pcie,id=pxb1,bus_nr=1 
 

-device pcie-pci-bridge,id=pci,bus=pxb1 
 

-device es1370,bus=pci,addr=9,id=es1370 
 

-device e1000,bus=pci,addr=10,id=e1000 
 

-device pcie-root-port,id=root_port_for_ahci,bus=pxb1,chassis=10,slot=0 
 

-device ahci,bus=root_port_for_ahci,id=ahci 
 


   Bus  1, device   0, function 0:
     PCI bridge: PCI device 1b36:000e
       IRQ 255, pin A
       BUS 1.
       secondary bus 2.
       subordinate bus 2.
       IO range [0x1000, 0x1fff]
       memory range [0x81100000, 0x811fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 64 bit memory at 0x81200000 [0x812000ff].
       id "pci"
   Bus  2, device   9, function 0:
     Audio controller: PCI device 1274:5000
       PCI subsystem 4942:4c4c
       IRQ 255, pin A
       BAR0: I/O at 0xffffffffffffffff [0x00fe].
       id "es1370"
   Bus  2, device  16, function 0:
     Ethernet controller: PCI device 8086:100e
       PCI subsystem 1af4:1100
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: I/O at 0xffffffffffffffff [0x003e].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id "e1000"
   Bus  1, device   1, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 1.
       secondary bus 3.
       subordinate bus 3.
       IO range [0x0000, 0x0fff]
       memory range [0x81000000, 0x810fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81201000 [0x81201fff].
       id "root_port_for_ahci"
   Bus  3, device   0, function 0:
     SATA controller: PCI device 8086:2922
       PCI subsystem 1af4:1100
       IRQ 255, pin A
       BAR4: I/O at 0xffffffffffffffff [0x001e].
       BAR5: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
       id "ahci"
   Bus  0, device   0, function 0:
     Host bridge: PCI device 1b36:0008
       PCI subsystem 1af4:1100
       id ""
   Bus  0, device   1, function 0:
     Ethernet controller: PCI device 8086:10d3
       PCI subsystem 8086:0000
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR2: I/O at 0xffffffffffffffff [0x001e].
       BAR3: 32 bit memory at 0xffffffffffffffff [0x00003ffe].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id ""
   Bus  0, device   2, function 0:
     Display controller: PCI device 1234:1111
       PCI subsystem 1af4:1100
       BAR0: 32 bit prefetchable memory at 0x80000000 [0x80ffffff].
       BAR2: 32 bit memory at 0x81386000 [0x81386fff].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x00007ffe].
       id ""
   Bus  0, device   3, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 0.
       secondary bus 1.
       subordinate bus 3.
       IO range [0x0000, 0x1fff]
       memory range [0x81000000, 0x812fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81385000 [0x81385fff].
       id "PrZUz"
   Bus  1, device   0, function 0:
     PCI bridge: PCI device 1b36:000e
       IRQ 255, pin A
       BUS 1.
       secondary bus 2.
       subordinate bus 2.
       IO range [0x1000, 0x1fff]
       memory range [0x81100000, 0x811fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 64 bit memory at 0x81200000 [0x812000ff].
       id "pci"
   Bus  2, device   9, function 0:
     Audio controller: PCI device 1274:5000
       PCI subsystem 4942:4c4c
       IRQ 255, pin A
       BAR0: I/O at 0xffffffffffffffff [0x00fe].
       id "es1370"
   Bus  2, device  16, function 0:
     Ethernet controller: PCI device 8086:100e
       PCI subsystem 1af4:1100
       IRQ 255, pin A
       BAR0: 32 bit memory at 0xffffffffffffffff [0x0001fffe].
       BAR1: I/O at 0xffffffffffffffff [0x003e].
       BAR6: 32 bit memory at 0xffffffffffffffff [0x0003fffe].
       id "e1000"
   Bus  1, device   1, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 1.
       secondary bus 3.
       subordinate bus 3.
       IO range [0x0000, 0x0fff]
       memory range [0x81000000, 0x810fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81201000 [0x81201fff].
       id "root_port_for_ahci"
   Bus  3, device   0, function 0:
     SATA controller: PCI device 8086:2922
       PCI subsystem 1af4:1100
       IRQ 255, pin A
       BAR4: I/O at 0xffffffffffffffff [0x001e].
       BAR5: 32 bit memory at 0xffffffffffffffff [0x00000ffe].
       id "ahci"
   Bus  0, device   4, function 0:
     PCI bridge: PCI device 1b36:000c
       IRQ 255, pin A
       BUS 0.
       secondary bus 4.
       subordinate bus 4.
       IO range [0xf000, 0x0fff]
       memory range [0xfff00000, 0x000fffff]
       prefetchable memory range [0xfffffffffff00000, 0x000fffff]
       BAR0: 32 bit memory at 0x81384000 [0x81384fff].
       id ""
   Bus  0, device   5, function 0:
     Host bridge: PCI device 1b36:000b
       PCI subsystem 1af4:1100
       id "pxb1"

What happens with missing card? It does not have to be "igb" - "ac97" 
gets lost too.

And only first added one dissapears. If I add two cards (with root-port 
entries) before "pxb-pcie" then second one is present.

