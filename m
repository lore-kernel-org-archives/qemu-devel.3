Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD7B10FCADE
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 20:44:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w80dD-0007Ks-5x; Wed, 01 Apr 2026 14:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w80Wl-0006fF-GH
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 14:42:55 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w80Wc-0006E9-2G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 14:42:48 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 6e40b459faa592323d58d50816f467308e417ab86562d1b75e6766351bb00b32 with SMTP id
 69cd67232c50a55f4d29df26; Wed, 01 Apr 2026 18:42:43 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1775068963;
 bh=f7xuOx7CCQh3ck5/QHaWvdRr8rR5CKidnpha9YC5A10=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=E4OAo32ZSZS1JZQA8OcTLZTaP7A88JMkrBNAWtGI1eWBsgD3ajBSO2MaM1duyRQif
 724PFPCkY+7J270QTRmP+ftt3lSScMOS5okwBb9YmYz/1FBwqPrAUWbl015hOWPkue
 hX+4BQo+YSELkpcmw+QkpeSPLXk8VgfYfDhvHncsseRdHnQ+OOUSxeGFGogtsKGQZN
 meLJjTJ5wk/MBofZaWZJ2iBQVSFqYccKUckeLJ8kEeja72RfIzGMSWaXX+PvcL54cl
 Ua/CpvCxqv1M8E70CrfV0J36OWwmkbBxK2ztUqrpcTS5wXHJ2d0KghuwspHBWrrAH2
 KDCI0Y7wiv6YQ==
Message-ID: <7dfd3d44-f59a-4e28-a5f9-1250c76a5e0b@yodel.dev>
Date: Wed, 1 Apr 2026 13:42:41 -0500
MIME-Version: 1.0
Subject: Re: [RFC NOTFORMERGE 4/4] pc-bios/palcode-clipper: Replace qemu_alarm
 with Cchip register
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260401170454.32045-1-yodel.eldar@yodel.dev>
 <20260401170454.32045-5-yodel.eldar@yodel.dev>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260401170454.32045-5-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 01/04/2026 12:04, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> This commit removes the qemu_alarm function call in favor
> of a QEMU-specific, non-standard Cchip MMIO register at
> offset 0x7c0 to facilitate the move of the timer alarm from
> the CPU to the Typhoon chipset in QEMU.
> 
> Prior to this commit, modifying/stopping the timer required
> calling a QEMU TCG helper function (helper_set_alarm) via
> mtpr of qemu_alarm in PALcode; now, writing the absolute
> alarm expiration value in nanoseconds to Cchip+0x7c0 replaces
> that functionality.
> 
> Likewise, reads of Cchip+0x7c0 return the alarm expiration
> value, as mfpr of qemu_alarm did in Cserve_Get_Alarm().
> 
> Also, CallPal_Ndelay() now stores the delay value in the MMIO
> register, instead of moving to the qemu_alarm processor
> register and triggering helper_set_alarm() in QEMU.
> 
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
> 
> Notes:
>      This binary diff patch is not intended for direct merging;
>      the previous patch needs this change in palcode-clipper to
>      function. The source diff in the notes below are the
>      changes made to the qemu-palcode repo [1] that resulted in
>      the binary provided here for convenience.
>      
>      Richard:
>      If it's alright with you, I'll submit the diff below as a
>      PR to your qemu-palcode repo so that the resultant binary can
>      be squashed with the preceding QEMU patch that requires it.
>      Suppose the patches are approved, does that work for you?
>      
>      As mentioned in the cover letter, I intend to fold this RFC
>      series into the "QOMify Clipper and Typhoon" [2] series as
>      part of its v2 re-spin, so any comments/suggestions on this
>      and the patch before it would be much appreciated. WDYT
>      about replacing the synthetic processor register that
>      triggers the helper_set_alarm() TCG helper with an MMIO
>      register in the Control chip of the Typhoon?
>      
>      Instead of creating a register for each CPU, I went with
>      a single banked register at Cchip+0x7c0, because we get
>      the CPU index for free with the MemTxAttrs patch.
>      Would we rather go with ALRM{0,1,2,3} instead?
>      
>      [1] https://github.com/rth7680/qemu-palcode.git
>      [2] <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
>      
Here's the fork containing the commit:

https://github.com/yodel/qemu-palcode/tree/timer-alarm

Thanks,
Yodel

