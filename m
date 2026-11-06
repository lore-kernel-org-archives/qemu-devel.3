Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F1606A334
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N4othtlg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IcP+Qzx8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIZZ-0001L5-TO; Fri, 06 Nov 2026 06:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIZY-0001KO-4p
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:57:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIZW-0004Rq-CE
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793966249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8GETxAz+9jkOtbiI5TXDf7d5fA/hl3i2zL5KXSCLGaw=;
 b=N4othtlglGmEDWDrBUL/uu5NkxJ0E59fToNe9fiKigAbmeU0/yJqbjWpOM3nOyfa9AFWq3
 ziCbFrsm2x7PQXzedkkuSXJ41yDdM+5Yngqr0Q530RkWb1SmSMM6d8wB4zZi4lS/xcsAyc
 CVZ7Dzgt6Ldlx1e9TJLoQc1xo3FgCPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-krVekQ2FM7Wc20ejMjEPPw-1; Fri, 06 Nov 2026 06:57:28 -0500
X-MC-Unique: krVekQ2FM7Wc20ejMjEPPw-1
X-Mimecast-MFC-AGG-ID: krVekQ2FM7Wc20ejMjEPPw_1793966247
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a214a5f8a1so6504395e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793966247; x=1794571047; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8GETxAz+9jkOtbiI5TXDf7d5fA/hl3i2zL5KXSCLGaw=;
 b=IcP+Qzx8ZI9Co/cJkyCOiwaOJvuMruskRMal6hi4jTe0jdT9IMOIPFVmba/PdlPE0N
 0iEQBxWz+5AGena2FDGt/t0sxApqN183XIVg92R9QXVVhnmUJ6fqBa7Gm/dPNwVUs0NW
 R9Ufkpvlj3mtoQWmQvkA5GmF4KVgZgJLlnUJ3ZVaaEWTtVlfIx5UrDjX085vjo6N+opu
 OYE/ItXrdakaUg9Nl+bT4z8K+dDfiUcyGpvOV6jVD0KnS1zmKQ0zz2aRh51VMXiC8f4h
 I1F0xB4rGRcRNGJdpCPY1poHG2z1q5vqeNLWpJYwkFgTqfRqubsHa+5iRnPRFWvgFgyd
 i0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793966247; x=1794571047;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8GETxAz+9jkOtbiI5TXDf7d5fA/hl3i2zL5KXSCLGaw=;
 b=jiKStEJtdhksGSfazovCTzX1pZ8iGfHidb6YVZWuuxGsp57ojeDHWKk1u2sEYc8Mxj
 E6vWS86olV/QHOyLfTofHEE+2GAKfkeZIZO1rvtcWAYduri1rSwoaMfhKqBlNaobjh6E
 FFkUjKqfjKnR2L5zChLq0dQvbuAyZxLCcIuo3Bhyt47L/AoTqiR0O71gHdWrEfPqr2U5
 B7ocOFf0rp9rXCHrU8FOmtqp9e8r6G5rZBo4w557eTd9a53EJ1PHcxE3RzRXmyx4urUS
 rToJu60EUF4HZCorvXvykN8FIXDUCwHalHiXiDGdA/Hmfg66gDAHRERsd6/DAkqke452
 ElcA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx3Nj35P+EyIQVq3ysdcVfCGAPD8u6tlRCEXL0gRY8Lc7vhYiTsH0pWKDkxWirJaI/Q7wT/CJno0hE6@nongnu.org
X-Gm-Message-State: APuU4Z+UAeIKkUIlCGt/zY+zzQM+zo1SaMtzdQv3sBZAH6D9gs7Ie5ma
 l6WymM/I/cyVfaGDdZnJn4XmdLlL4NIDT1rCwP6AV2Vh/x91zl4mwxx2FawbM/9WCEOIRfKttVE
 rrEiuuQwOQyAjElxtVy1lt/n2BgMziWk7ERw9frVPxc+YAirORNb1HCuu
X-Gm-Gg: AYBFou2hC59tkd4TUGEqd1esjTWg9sg3YB+SLzTLp8nzwYT5sPnguFNzuBX2CLAE4OC
 9bAfwTLZtVQmI0Q0nx0IGjlEN+9gzdaQ0jZJ1/qK2LrHlzJd4Zr3u/2nK8HmtcoeWZV5rX13+Uz
 v0M1aZq/nVnEZDktiUkzV1M/LQBmKdvbB2tKzTCU7gIZ/Hgrdtbokl7aEORRvMEySAdRizOU+Cp
 Ohyv7sWhRkqqw1sDe6Qt5zpV1PiIcigoilZVXbF3F96bJJCltjvdaDZClFR2sDnWuTDIxYbyABQ
 kgWrurNFK1WeFbh+Y2Kj4pB7iY3D/2v0sxelYDAivoxv2LlR6ahkW3AvCpagn5sb1DqJH+9EMdz
 frTtdc6pu2V36ySGO8S/5Umw6iZx8PomTv4dpMRp5jjEwQtav27dHJ+lquIGhMx+WRcGSqKZ1lj
 dfhtKkSJTarw==
X-Received: by 2002:a05:600c:524c:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4b6dfba8635mr36152415e9.22.1793966247092; 
 Fri, 06 Nov 2026 03:57:27 -0800 (PST)
X-Received: by 2002:a05:600c:524c:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4b6dfba8635mr36151905e9.22.1793966246607; 
 Fri, 06 Nov 2026 03:57:26 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b6e168f35bsm56669295e9.4.2026.11.06.03.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 03:57:25 -0800 (PST)
Message-ID: <e51176ac-eb55-435c-8ce8-3588e8fc8c20@redhat.com>
Date: Fri, 6 Nov 2026 12:57:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/28] hw/net: mark e1000, e1000e, IGB, rtl8139 & sPAPR
 VLAN as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-8-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> Historically most NICs are only interesting for non-virtualization
> use cases and have not been written with malicious guests in mind.
> 
> As a general rule either virtio-net or xen-net should be used in
> all virtualized guests requiring a security boundary.
> 
> There are a handful of exceptions resulting from historical usage
> in the x86 world, to support virtualized guests lacking virtio
> support.
> 
> Thus the rtl8139, e1000, e1000e & IGB NICs are declared to provide
> a security boundary.
> 
> The PPC sPAPR Virtual LAN device is also marked secure.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/net/e1000.c      | 1 +
>   hw/net/e1000e.c     | 1 +
>   hw/net/igb.c        | 1 +
>   hw/net/rtl8139.c    | 1 +
>   hw/net/spapr_llan.c | 1 +
>   5 files changed, 5 insertions(+)
I'd maybe drop rtl8139 from the list, AFAIK most old operating systems 
should support e1000 just fine?

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


