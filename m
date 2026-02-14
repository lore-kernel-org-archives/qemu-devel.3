Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE17EF99E1
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 04:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr7Sr-0001Dr-DJ; Fri, 13 Feb 2026 23:41:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vr7Sn-0001DX-Fu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 23:41:03 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vr7Sk-0004Xb-CJ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 23:41:01 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61E4eTtg023341
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Feb 2026 13:40:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=iQMvEKsXplBrARIXIGqTu0kjFmZI1DSnfWMueijmUNc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1771044049; v=1;
 b=icESafWlCgpRGdoEq0D99autX/aVOF3Tiac6jKCv+sMGr4n8M2zvHQSDjZ+ZjAlt
 spuz+byq4dHCAlkd+wZB6jDEOt0RkjPbU0piU+4fU+ozCCw40RtFcX34dA37Fbky
 imPjrOsNuip9OuucFEmXDpImse4lryBqp2+RThMu+A1dAZTmaBS+IGysrHZTQjCJ
 bkS5N3BLuDb8VA0ohr7CCsqsCRjsU7ktHXZfpq1ci909ljq/C3AX+RFkQJfHs4JC
 cy3eEjEnXwJjUbbT8Fa9WKvI3MWnuWbcpPpOkrJnpj7oBilfO6qqTdBS4T4hf7J/
 uj43Pg/ZzBgZcwOQ7lVwiQ==
Message-ID: <2faae75d-31ac-4013-a7a2-05b0131bb9fd@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 14 Feb 2026 13:40:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] net: mark eth_header, udp_header, tcp_header as
 QEMU_PACKED
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260212140917.1443253-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/02/12 23:09, Peter Maydell wrote:
> The packet header structs eth_header, udp_header and tcp_header
> defined in eth.h are not actually guaranteed to be aligned --
> typically the network device models will work with headers in a
> byte-array packet data buffer. We attempt to deal with this in some
> places such as net_checksum_calculate() by using lduw_be_p() and so on
> to access the fields, but this is not sufficient to be correct,
> because even accessing a byte member within a misaligned struct is
> undefined behaviour.
> 
> Back in 2024 in commit f8b94b4c520 ("net: mark struct ip_header as
> QEMU_PACKED") we fixed this for ip_header, but if you run a
> check-functional on a sanitizers-enabled build you will run
> into errors like this in the sifive_u_mmc functional test:
> 
> ../../net/checksum.c:78:47: runtime error: member access within misaligned addre
> ss 0x561f52f35011 for type 'struct eth_header', which requires 2 byte alignment
>      0x561f52f35011: note: pointer points here
>       00 00 00  00 33 33 00 00 00 16 52  54 00 12 34 56 86 dd 60  00 00 00 00 24
> 00 01 00  00 00 00 00 00
>                    ^
>          #0 0x561f20608459 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:78:47
>          #1 0x561f20117bfa in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
>          #2 0x561f20115c61 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13
> 
> As with the previous ip_header fix, before we can mark the structs as
> QEMU_PACKED we need to adjust some code which takes the address of a
> packed-struct field, because gcc will refuse to compile that. The
> rocker device does this with eth_header::h_proto.
> 
> I chose to keep the three "mark this struct as QEMU_PACKED" changes as
> separate patches just in case they cause issues I didn't catch with my
> compilation tests; that way it will be easier to diagnose/revert.
> 
> The problem with eth_header came up at the beginning of last year
> in relation to the npcm7xx_emc device; none of this is particularly
> specific to any one network device, it's just that we happen to only
> be exercising the network in a way that triggers it with the sifive
> test case.
> https://lore.kernel.org/qemu-devel/CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com/
> 
> It would not surprise me to find that some other structs in this
> header also ought to be marked as packed, but I prefer only to
> tackle them when we have a sanitizer repro case so we can
> confirm the fixes.
> 
> thanks
> -- PMM
> 
> Peter Maydell (5):
>    hw/net/rocker: Don't keep pointer to h_proto as uint16_t* in
>      OfDpaFlowPktFields
>    hw/net/rocker: Don't assume h_proto is aligned in eth_strip_vlan_ex()
>    net: mark struct eth_header as QEMU_PACKED
>    net: mark struct udp_header as QEMU_PACKED
>    net: mark struct tcp_header as QEMU_PACKED
> 
>   hw/net/rocker/rocker_of_dpa.c | 19 ++++++++++++-------
>   include/net/eth.h             |  6 +++---
>   net/eth.c                     |  6 +++---
>   3 files changed, 18 insertions(+), 13 deletions(-)
> 

For the whole series:
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

