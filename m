Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE19C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4b3s-0006G0-Qi; Thu, 10 Sep 2026 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4b3q-0006Fl-Td
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:27:14 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x4b3p-0005D0-0x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 05:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789032430; x=1789637230; i=deller@gmx.de;
 bh=bgzDKTdPmbdPOecBxNJ9cvq3RmhOK2iL+gttYMlpTis=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=GcdQpeMI4cEKCXMKX71t1Ompl/oKbeBMQMQy7B2ugNlBoJPICZm/BpkZpwDmHl0k
 O90NtFDPaAGaj62T/D/Ao7t7ZgMiR6QaOu5yO8xPagK6ehKhgs4hQnOzMgybPngq9
 pe/59ydFGyYzfxQvRzyJCIw4j+ow2FtaD4Q/IcvqlfFdIFQj1b339FaKcr5XPaKYX
 nDcWZW7McDiAmG0G725r8JJJ3dp0+bIEDjvrte1X2iyP72shDcFN7UfARF/jNB5eA
 wLMNYHrtVcSO+CpCGDUopWBiaH1Kuhe52ogJjR9J4DfW5pei5s1O5FZSQ/bjjmV3W
 E3k3sa3pDi4wHX5/tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ81-1xJ2q32azl-00TNdb; Thu, 10
 Sep 2026 11:27:10 +0200
Message-ID: <3b033f3a-9364-4288-8b45-c7769a259969@gmx.de>
Date: Thu, 10 Sep 2026 11:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] linux-user/hexagon: Add HWCAP support
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: marco.liebel@oss.qualcomm.com, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260910004139.606486-1-brian.cain@oss.qualcomm.com>
 <20260910004139.606486-2-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260910004139.606486-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6tkW06O8DM9X5dQFcLtbXTVDreaYNvap5Xi3NdfTrEyZC9c/y2y
 rVXUX9g6vSfKHBKGYsuuPN67dOXmGTgLLm93LPEfjhH1CwiAPgVD2IA+1E/y0xFOwmB8De+
 URNxu/hW+Sd2dkUDh3YAYjAEce7bf/XwnLwVTGUMZZ+ArzEgB2AchFtpt89pTIeo/fCuUOw
 VCZERo7pv/bizlG0Y0m6A==
UI-OutboundReport: notjunk:1;M01:P0:wN/4tvmjyqY=;0RBAMVf62YY4BtOkv9tdm8Stb2f
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/10/26 02:41, Brian Cain wrote:
> Link: https://lore.kernel.org/linux-hexagon/20260910003346.596593-1-brian.cain@oss.qualcomm.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   linux-user/hexagon/target_elf.h | 30 ++++++++++++++++
>   linux-user/hexagon/elfload.c    | 61 +++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)

Reviewed-by: Helge Deller <deller@gmx.de>

added to my upcoming linux-user pull request.

Thanks!
Helge

