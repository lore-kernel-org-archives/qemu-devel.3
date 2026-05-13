Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3FBCD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBNt-0002Og-Up; Wed, 13 May 2026 11:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBNr-0002Nq-OA; Wed, 13 May 2026 11:20:28 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1wNBNp-00010P-6r; Wed, 13 May 2026 11:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778685625; x=1810221625;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F06aqssfQNgWk4KEuYiauJnyx38IQyysW28Q4MJE49s=;
 b=SnSA5hA67dBBuAIHPnwupYE7GB+lycAE8bj6ZO8d9qncYErKxlqVVE0j
 4I41m2XbNGsMFVRwprm1ekhug3tH0s9ihOOXSNthrGJKCudLx77I9RroK
 ObZlpHfF1BgiBn95Ml9uO9NE37Uw5kDp62J1fat3Iz0f9iyo5J2OmmjEC
 VcjeagJ49SCCEcXt+BNkWW7mZXoviY+xWvmvwoIRuk3MkpX0vglZcYpX3
 TKtveq2Yiq7aNnvh36hEw5z5u/9ZKlTY+oJwvEjBq1mc1a7W0JzxEmko0
 rRSbSpevAOZiDHSMb9Gs8gc6hc4kIs/ftGxYHiFTkATVdG9VOMLiE6B/t g==;
X-CSE-ConnectionGUID: UU+iOTx1QRaS/TQHsfXYUA==
X-CSE-MsgGUID: EXG0wpHzQ7uMnxkFZRnrwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="82183963"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="82183963"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2026 08:20:22 -0700
X-CSE-ConnectionGUID: yKH5gmaeSiKuUJcWGjLbuA==
X-CSE-MsgGUID: GPkMWGadRrOFduphxkTzzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; d="scan'208";a="238210663"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 13 May 2026 08:20:20 -0700
Date: Wed, 13 May 2026 23:48:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, philmd@linaro.org, rad@semihalf.com,
 leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
Subject: Re: [PATCH v2 06/21] tests: acpi: x86/q35: update expected WDAT blob
Message-ID: <agSdNF7GFYgJK0vt@intel.com>
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-7-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303092532.2410177-7-imammedo@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 03, 2026 at 10:25:17AM +0100, Igor Mammedov wrote:
> Date: Tue,  3 Mar 2026 10:25:17 +0100
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: [PATCH v2 06/21] tests: acpi: x86/q35: update expected WDAT blob
> 
> replace blank table with a new one:
> 
>   +[000h 0000   4]                    Signature : "WDAT"    [Watchdog Action Table]
>   +[004h 0004   4]                 Table Length : 00000134
>   +[008h 0008   1]                     Revision : 01
>   +[009h 0009   1]                     Checksum : 31
>   +[00Ah 0010   6]                       Oem ID : "BOCHS "
>   +[010h 0016   8]                 Oem Table ID : "BXPC    "
>   +[018h 0024   4]                 Oem Revision : 00000001
>   +[01Ch 0028   4]              Asl Compiler ID : "BXPC"
>   +[020h 0032   4]        Asl Compiler Revision : 00000001
>   +
>   +[024h 0036   4]                Header Length : 00000020
>   +[028h 0040   2]                  PCI Segment : 00FF
>   +[02Ah 0042   1]                      PCI Bus : FF
>   +[02Bh 0043   1]                   PCI Device : FF
>   +[02Ch 0044   1]                 PCI Function : FF
>   +[02Dh 0045   3]                     Reserved : 000000
>   +[030h 0048   4]                 Timer Period : 00000258
>   +[034h 0052   4]                    Max Count : 000003FF
>   +[038h 0056   4]                    Min Count : 00000004
>   +[03Ch 0060   1]        Flags (decoded below) : 81
>   +                                     Enabled : 1
>   +                         Stopped When Asleep : 1
>   +[03Dh 0061   3]                     Reserved : 000000
>   +[040h 0064   4]         Watchdog Entry Count : 0000000A
>   +
>   +[044h 0068   1]              Watchdog Action : 01
>   +[045h 0069   1]                  Instruction : 02
>   +[046h 0070   2]                     Reserved : 0000
>   +
>   +[048h 0072  12]              Register Region : [Generic Address Structure]
>   +[048h 0072   1]                     Space ID : 01 [SystemIO]
>   +[049h 0073   1]                    Bit Width : 10
>   +[04Ah 0074   1]                   Bit Offset : 00
>   +[04Bh 0075   1]         Encoded Access Width : 02 [Word Access:16]
>   +[04Ch 0076   8]                      Address : 0000000000000660
>   +
>   +[054h 0084   4]                        Value : 00000001
>   +[058h 0088   4]                Register Mask : 000001FF
>   +
>   +[05Ch 0092   1]              Watchdog Action : 08
>   +[05Dh 0093   1]                  Instruction : 00
>   +[05Eh 0094   2]                     Reserved : 0000
>   +
>   +[060h 0096  12]              Register Region : [Generic Address Structure]
>   +[060h 0096   1]                     Space ID : 01 [SystemIO]
>   +[061h 0097   1]                    Bit Width : 10
>   +[062h 0098   1]                   Bit Offset : 00
>   +[063h 0099   1]         Encoded Access Width : 02 [Word Access:16]
>   +[064h 0100   8]                      Address : 0000000000000668
>   +
>   +[06Ch 0108   4]                        Value : 00000000
>   +[070h 0112   4]                Register Mask : 00000800
>   +
>   +[074h 0116   1]              Watchdog Action : 09
>   +[075h 0117   1]                  Instruction : 82
>   +[076h 0118   2]                     Reserved : 0000
>   +
>   +[078h 0120  12]              Register Region : [Generic Address Structure]
>   +[078h 0120   1]                     Space ID : 01 [SystemIO]
>   +[079h 0121   1]                    Bit Width : 10
>   +[07Ah 0122   1]                   Bit Offset : 00
>   +[07Bh 0123   1]         Encoded Access Width : 02 [Word Access:16]
>   +[07Ch 0124   8]                      Address : 0000000000000668
>   +
>   +[084h 0132   4]                        Value : 00000000
>   +[088h 0136   4]                Register Mask : 00000800
>   +
>   +[08Ch 0140   1]              Watchdog Action : 0A
>   +[08Dh 0141   1]                  Instruction : 00
>   +[08Eh 0142   2]                     Reserved : 0000
>   +
>   +[090h 0144  12]              Register Region : [Generic Address Structure]
>   +[090h 0144   1]                     Space ID : 01 [SystemIO]
>   +[091h 0145   1]                    Bit Width : 10
>   +[092h 0146   1]                   Bit Offset : 00
>   +[093h 0147   1]         Encoded Access Width : 02 [Word Access:16]
>   +[094h 0148   8]                      Address : 0000000000000668
>   +
>   +[09Ch 0156   4]                        Value : 00000800
>   +[0A0h 0160   4]                Register Mask : 00000800
>   +
>   +[0A4h 0164   1]              Watchdog Action : 0B
>   +[0A5h 0165   1]                  Instruction : 82
>   +[0A6h 0166   2]                     Reserved : 0000
>   +
>   +[0A8h 0168  12]              Register Region : [Generic Address Structure]
>   +[0A8h 0168   1]                     Space ID : 01 [SystemIO]
>   +[0A9h 0169   1]                    Bit Width : 10
>   +[0AAh 0170   1]                   Bit Offset : 00
>   +[0ABh 0171   1]         Encoded Access Width : 02 [Word Access:16]
>   +[0ACh 0172   8]                      Address : 0000000000000668
>   +
>   +[0B4h 0180   4]                        Value : 00000800
>   +[0B8h 0184   4]                Register Mask : 00000800
>   +
>   +[0BCh 0188   1]              Watchdog Action : 06
>   +[0BDh 0189   1]                  Instruction : 03
>   +[0BEh 0190   2]                     Reserved : 0000
>   +
>   +[0C0h 0192  12]              Register Region : [Generic Address Structure]
>   +[0C0h 0192   1]                     Space ID : 01 [SystemIO]
>   +[0C1h 0193   1]                    Bit Width : 10
>   +[0C2h 0194   1]                   Bit Offset : 00
>   +[0C3h 0195   1]         Encoded Access Width : 02 [Word Access:16]
>   +[0C4h 0196   8]                      Address : 0000000000000672
>   +
>   +[0CCh 0204   4]                        Value : 00000000
>   +[0D0h 0208   4]                Register Mask : 000003FF
>   +
>   +[0D4h 0212   1]              Watchdog Action : 05
>   +[0D5h 0213   1]                  Instruction : 01
>   +[0D6h 0214   2]                     Reserved : 0000
>   +
>   +[0D8h 0216  12]              Register Region : [Generic Address Structure]
>   +[0D8h 0216   1]                     Space ID : 01 [SystemIO]
>   +[0D9h 0217   1]                    Bit Width : 10
>   +[0DAh 0218   1]                   Bit Offset : 00
>   +[0DBh 0219   1]         Encoded Access Width : 02 [Word Access:16]
>   +[0DCh 0220   8]                      Address : 0000000000000672
>   +
>   +[0E4h 0228   4]                        Value : 00000000
>   +[0E8h 0232   4]                Register Mask : 000003FF
>   +
>   +[0ECh 0236   1]              Watchdog Action : 20
>   +[0EDh 0237   1]                  Instruction : 00
>   +[0EEh 0238   2]                     Reserved : 0000
>   +
>   +[0F0h 0240  12]              Register Region : [Generic Address Structure]
>   +[0F0h 0240   1]                     Space ID : 01 [SystemIO]
>   +[0F1h 0241   1]                    Bit Width : 10
>   +[0F2h 0242   1]                   Bit Offset : 00
>   +[0F3h 0243   1]         Encoded Access Width : 02 [Word Access:16]
>   +[0F4h 0244   8]                      Address : 0000000000000666
>   +
>   +[0FCh 0252   4]                        Value : 00000002
>   +[100h 0256   4]                Register Mask : 00000002
>   +
>   +[104h 0260   1]              Watchdog Action : 21
>   +[105h 0261   1]                  Instruction : 82
>   +[106h 0262   2]                     Reserved : 0000
>   +
>   +[108h 0264  12]              Register Region : [Generic Address Structure]
>   +[108h 0264   1]                     Space ID : 01 [SystemIO]
>   +[109h 0265   1]                    Bit Width : 10
>   +[10Ah 0266   1]                   Bit Offset : 00
>   +[10Bh 0267   1]         Encoded Access Width : 02 [Word Access:16]
>   +[10Ch 0268   8]                      Address : 0000000000000666
>   +
>   +[114h 0276   4]                        Value : 00000002
>   +[118h 0280   4]                Register Mask : 00000002
>   +
>   +[11Ch 0284   1]              Watchdog Action : 21
>   +[11Dh 0285   1]                  Instruction : 82
>   +[11Eh 0286   2]                     Reserved : 0000
>   +
>   +[120h 0288  12]              Register Region : [Generic Address Structure]
>   +[120h 0288   1]                     Space ID : 01 [SystemIO]
>   +[121h 0289   1]                    Bit Width : 10
>   +[122h 0290   1]                   Bit Offset : 00
>   +[123h 0291   1]         Encoded Access Width : 02 [Word Access:16]
>   +[124h 0292   8]                      Address : 0000000000000666
>   +
>   +[12Ch 0300   4]                        Value : 00000004
>   +[130h 0304   4]                Register Mask : 00000004
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  tests/data/acpi/x86/q35/WDAT.wdat           | Bin 0 -> 308 bytes
>  2 files changed, 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


