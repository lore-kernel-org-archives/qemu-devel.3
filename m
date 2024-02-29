Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFF1C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgKD-00080a-Tw; Thu, 29 Feb 2024 08:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfgKA-0007n5-E5
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfgK8-0003sf-Rk
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709212783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssIXCiserhh12U3YQRkgkmm7nsk0ru8FAkooW4NhTbY=;
 b=CnyaOgLqsTAdvahUaKK2gtzDFKki3Wdpa3xwir6PfkbzfM7GjLyZ83Gaf20ZzdZh0nWnPH
 5XK/eM2WkYv2bOG/v8vbEBUUZjyuKaKk0CtXcweUjhU6H+UTsWuBVkrq2/Vsz152I8xKv3
 3BfM58wKZ4cooKLZy2ruTgshsBqZ3+g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-_qgQN6I8P7qGkGr5V_332Q-1; Thu, 29 Feb 2024 08:19:42 -0500
X-MC-Unique: _qgQN6I8P7qGkGr5V_332Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-68facaf1c37so9224746d6.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709212782; x=1709817582;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ssIXCiserhh12U3YQRkgkmm7nsk0ru8FAkooW4NhTbY=;
 b=hibGHs1SQ+j7eLlv2uygimHXa9haZFP8dzrvE0a8KhAcoW8rTP/HacLLa7R9fCg0Oj
 vuezNbae1Xz6+CyTyxuobjULVU6L4omP0xkZ9Ns6Q+zAn5zRggzszDrGt8PgPtR7qGAO
 FLnWIcWdZ2RZjKrdn1rrYgGggIihIeQkbhhmSX6fEBTM7a9wXjTeBVY4C9HYWOS2+UZT
 rLU7upNlidFSmknorLmaQWQvOQcj85MblhP+crRDPB0Qq573Gtksv1yZNH7f5j7jr9Bg
 hMULSAq/z/uPd3Jf9ZDaMy5al+mTU0h9sBIJD1oO5GWRqC7dxtb0lAo3D63Nud3ZWk0Z
 FsZw==
X-Gm-Message-State: AOJu0YwbHePDvFugif/xilwh6hZew72vGiyWTItzyf8h9fpHUgihwsGL
 966BHmO1VN1aXcZuAcntt8gYoJg7gXV4A80rbpImJeUQczrWDEUhwJxO8kQQWRK9xoKrNFHfAQi
 lc1hlTSX5A5mRw4MzpEC8Vv0bPW42Lwrrrh4TOxhSZL4JlgvVve+H
X-Received: by 2002:a0c:cd8d:0:b0:68f:da2d:c1db with SMTP id
 v13-20020a0ccd8d000000b0068fda2dc1dbmr2341155qvm.34.1709212781729; 
 Thu, 29 Feb 2024 05:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6Ys9LmA59qWSnCw8Rfys3eerVaRPGbh8RaRswmPw4QwHRye2UPDemV91IF5p7H+2B4dxHLQ==
X-Received: by 2002:a0c:cd8d:0:b0:68f:da2d:c1db with SMTP id
 v13-20020a0ccd8d000000b0068fda2dc1dbmr2341134qvm.34.1709212781373; 
 Thu, 29 Feb 2024 05:19:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 op8-20020a056214458800b0068fc5887c9fsm721330qvb.97.2024.02.29.05.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 05:19:41 -0800 (PST)
Message-ID: <c463493e-10a5-463a-afe8-af8ee4165a5b@redhat.com>
Date: Thu, 29 Feb 2024 14:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] migration: Add documentation for SaveVMHandlers
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-4-clg@redhat.com> <ZeADuRyAj0OBprh0@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZeADuRyAj0OBprh0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/24 05:10, Peter Xu wrote:
> On Tue, Feb 27, 2024 at 07:03:27PM +0100, Cédric Le Goater wrote:
>> The SaveVMHandlers structure is still in use for complex subsystems
>> and devices. Document the handlers since we are going to modify a few
>> later.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Still a few nitpick comments below.

I have applied your suggestions for the next spin.

Thanks,

C.


