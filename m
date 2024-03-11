Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FCFC54E66
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbAj-0007ia-GQ; Mon, 11 Mar 2024 04:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rjbAh-0007iF-7P
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:38:11 -0400
Received: from mail.kernel-space.org ([195.201.34.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <angelo@kernel-space.org>)
 id 1rjbAe-0002tg-PB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:38:10 -0400
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 6481bf48;
 Mon, 11 Mar 2024 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=i8
 dRA9itc6/aDFbH24GtW349hts=; b=RUgrS8O0yJgXuUGBeLQ+pOHzlNSqIhBvrg
 9pcxzPE26pZuf8vfBvZoHGrDi1BGGdTP8MH/5U3Z8Kul8mV3uMTMGIzdKRDYL7et
 6e/6OcMoa2/k/MbO7REQdF8SLfoG+lU0ktEe8odr4xyG4mXvAj84ljck8wiayV5l
 efrp95COo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 aaBuLakYk3gt3STuTP8iUpoRvnwcXm6Y7brAWsmy1bBPE3xI1EyU1Z1gYfw6zAr6
 uhQ0NkUbCAfhZRXBRgDeEYsgUfG/WBUfdiLAia5mmixfOE/rdobtuPtQJTO2Yx+h
 h6iWmDe/Gl0tGnV+Z2abYxDMHjitGljKDZEFIGzTD9A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1710146132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Le+LVkyzhPsZHhNdQ5+HsZVkVnuueucLfR2WhfTurE=;
 b=FyZiahe8V1fCzdbshYQXE8mMCV7x4ZtsyYX21O1sHlOGj0FwG93cg5ITI91shZQ7GLGn/b
 /KB0gHsjqsfABG+qobg8qaK90YrYGOz0poplFLj7QS/2ePcPgCoZcnc9vtbrjK1gcJWOg0
 7gv6kWcN80CGpoeMislu2vlbjyW+bek=
Received: from [192.168.0.2] (host-79-51-238-97.retail.telecomitalia.it
 [79.51.238.97])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id a667b7e6
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 11 Mar 2024 08:35:32 +0000 (UTC)
Message-ID: <dabcc90b-0a1d-885f-8d9d-7858d1525844@kernel-space.org>
Date: Mon, 11 Mar 2024 09:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3] hw/m68k/mcf5208: add support for reset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 huth@tuxfamily.org
Cc: qemu-devel@nongnu.org
References: <20240309093459.984565-1-angelo@kernel-space.org>
 <e40b0c9e-3d68-49cf-b7cc-280aa7c3fc3d@linaro.org>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <e40b0c9e-3d68-49cf-b7cc-280aa7c3fc3d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.201.34.187;
 envelope-from=angelo@kernel-space.org; helo=mail.kernel-space.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.099,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

thanks !

On 11/03/24 9:36 AM, Philippe Mathieu-Daudé wrote:
> On 9/3/24 10:34, Angelo Dureghello wrote:
>> Add reset support for mcf5208.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>> ---
>>   hw/m68k/mcf5208.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> Thanks, merged as commit d3c79c3974.

