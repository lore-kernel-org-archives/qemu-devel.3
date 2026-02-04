Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E339CE9D3E2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 14:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vndfg-0002LI-Mk; Wed, 04 Feb 2026 09:15:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vndfe-0002KP-Is
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vndfd-0001g9-3z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 09:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770214552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5MWKkIucLF6x9E02TxtvEEFofm8o9t6lD9Azor25BLI=;
 b=Um6ik5gVSvQLak4zX6fNhS3YeGr/0Neb1JeVHqFZq+lIUe61h+2/BNNuZokxFnSmt69MON
 S2PGnDNECdXPz3HFYlxA5dthQgHlE8ERs2nNBwtwysmqzJZcL8PvEoHRy/pJSirOtomYkw
 jrmlOgYWpZ/rOppqaba1SEmKipq+l9c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-dl7VhSYOPVmrOI7Bd3NbgQ-1; Wed, 04 Feb 2026 09:15:49 -0500
X-MC-Unique: dl7VhSYOPVmrOI7Bd3NbgQ-1
X-Mimecast-MFC-AGG-ID: dl7VhSYOPVmrOI7Bd3NbgQ_1770214548
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4359849d324so5015788f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770214548; x=1770819348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5MWKkIucLF6x9E02TxtvEEFofm8o9t6lD9Azor25BLI=;
 b=P3FLGtFqYAwTNUXxxgzVi8DtLm0uoLMkh+tLX/ADtc6ry/enwwIj7nvoRwTFHgL/lH
 7iK6kF056J/r38bshxFPk/sA37yMTBPLpRPuVs3r0FxxMqLfPDy7lcreyd+K8aC0i7IL
 o+bKfJXarcAVdRN67Ah5LCZIg83i8WNNEG2MP9hBZlUfBUgAHt9aUSMB+E/CPRCcuewJ
 zznwjpFpAEQIdWGogOnaDpC2wdh8o5DteV0jOBUVqLuWO8HI5qJfR6j3RSErF1dkRHLT
 mQeuLbVZxIkdxBgF64Mwb2D59px27JfPp4h8O3/ZbifU0h9fOoJYwJVN0038dwAOuIKP
 un+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770214548; x=1770819348;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MWKkIucLF6x9E02TxtvEEFofm8o9t6lD9Azor25BLI=;
 b=EX3iF1mFwlC02Fb/Hk/nelr98glvR3sdz4vNGSJv/5asv9z1SEDPLM5tPabpcDTD0w
 dhyeeh9KYUdZ8rD2jfz9vEeB90nh2DWq24xWVZyVSPOWvY71ogKnF32gVIVkDWKfzIFe
 xgug1YFxmxoZuUfUmVXO92JVIzVRXw9oUORB+WVx4YZOBgtPnF2L9QfP1kL3DPrYUfvN
 htR/KvYbJTfOkzJfe8PLkI964JaQ5atO65EOzi2viQqN6qKrHGCY/FQZRaPOuuP/Bd25
 z8Kmy3sooOE+neXDWImutz+WZ5dl8mXOEnm7UAzUvpopOEOSCVn9mY8+mcPcBGHWNEkM
 YOeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUauulg4BulzDHtEOrXxBs8XAwog5FJ5FP57yJ+wG84FmX/pVo9R855ZYM4kXLcsn8vY8DHrwueGAv3@nongnu.org
X-Gm-Message-State: AOJu0YwUHv1c6f8U5xWSrb1qASubPQrJG0e6tiTdQASpkQdflVsh0u44
 gk4wFzBPvYOeV4cCbXW2sJk+b6RZEsVvQ9h8JUbX/tKP5lW5DbjSgZTHoT7S02e480zC0Iuwdju
 hPYvUqNABPjcKVaEDM7JN2uj6Ds2ZGMEdYmargUNAIDTJ31umhe2kuJKa
X-Gm-Gg: AZuq6aKI/2E0RMA41qAZic0IjPP9ZUUS26zhjWXh2Witb27ntdU111fMMiSEgLstmYG
 YBCeQNVRBLOiaLZAqp7TDHeWCxWoq8RoKJSpsBNEde4PBURvHp2h6dJwP2Qsg+K7CVPtVzu8XjU
 OenWuENw/Z7jLalqm/oNBGLYmoEYBTbueh6bqedSrp4DbWtnQWUWdb9jt0TRKssBEMNC//9tIZe
 kbgDVFEtVFHyeEgmp6yx2LyRCpdnoK9KIYLsw9e7+D2vqDPNi9t3g/EXlPDzYr6+XpiH4nLVb+B
 vxapmG8Be6Mk92ge/VwH66UkAWPLWCLT4920Mp2LQElk0UZJA4g/UDyKOtIhdVde3YRadzPgoPt
 kpKqIFyakbJKYV9seo+yoSSZC4oy3+mZCSdw=
X-Received: by 2002:a05:6000:400b:b0:432:a9db:f9a2 with SMTP id
 ffacd0b85a97d-43618053ca8mr4404995f8f.41.1770214548073; 
 Wed, 04 Feb 2026 06:15:48 -0800 (PST)
X-Received: by 2002:a05:6000:400b:b0:432:a9db:f9a2 with SMTP id
 ffacd0b85a97d-43618053ca8mr4404955f8f.41.1770214547541; 
 Wed, 04 Feb 2026 06:15:47 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f66sm6423465f8f.25.2026.02.04.06.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 06:15:47 -0800 (PST)
Message-ID: <67f49a61-1273-4004-8858-b2b4f78c254e@redhat.com>
Date: Wed, 4 Feb 2026 15:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] tests: remove "make check-venv" target
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260203203512.672552-1-jsnow@redhat.com>
 <20260203203512.672552-14-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260203203512.672552-14-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 03/02/2026 21.35, John Snow wrote:
> With the qemu.qmp and qemu.machine dependencies now installed by default
> at configure time and additional dependencies required by functional
> testing installed on demand, there is no longer any reason to have an
> explicit target.
> 
> FIXME: This forces image regeneration for vm tests whenever Make
> determines that the image needs to be rebuilt; which is a regression
> over the previous behavior.

Maybe elaborate on that (and then replace the "FIXME:" with a "Note:") - in 
which cases does Make think that the image needs to be regenerated? 
Hopefully not on every invocation?

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/Makefile.include    | 22 ++--------------------
>   tests/vm/Makefile.include | 24 +++++++-----------------
>   2 files changed, 9 insertions(+), 37 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


