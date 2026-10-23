Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4ImsL/x;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BqZJI+nu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGII-0001Xv-5j; Fri, 23 Oct 2026 10:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGI3-0001Vg-6D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGHz-0008Oq-NA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792765829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67X0q3AU0UCM8sg9sc3pgPDwhGqBRoZoJt24G9+/Pc4=;
 b=B4ImsL/xuE8YB5Z///7ow0CUUMoaqoKKBMcMq3kdMZFWSuhLebM4WomINuJqc/fof91LEl
 xsZp6bSSD9A8kLYWUDSo2b20IpT7l22uPAi4j2jqIqIbRPVwGU8GJiCWKWA12J3E2J/DK0
 LYhh9vw83fSCjz3jou4NcKjwNl0P7gQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PIwLZFUqO7y-7S_T8etIeA-1; Fri, 23 Oct 2026 10:30:27 -0400
X-MC-Unique: PIwLZFUqO7y-7S_T8etIeA-1
X-Mimecast-MFC-AGG-ID: PIwLZFUqO7y-7S_T8etIeA_1792765826
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b00febba3so841047f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792765826; x=1793370626; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=67X0q3AU0UCM8sg9sc3pgPDwhGqBRoZoJt24G9+/Pc4=;
 b=BqZJI+nuJefHiph/4A3aanTKG3azhWcqhIVt+kNB2Ro5ZDoDT6eZkdCuNaPn115jB1
 qCnb+MiYc9Ncq442BZKuAnFMUhh/pw64rmBLUAx63XVlZABI+ioXmLJ647D4uNT86CeX
 WVnJKu973s/BLEEn2FLD4Mka06Yo/Cn3QRSpsncK9R+d7BeH4FdqaCmCt6G39th6dD7J
 prNueFQrMrziNEyMtZ3nRhwn2E+H2fRHGFeQQdohuVmTY58stufxhokHFg6w3V+mq5fo
 0xwXsRPfd4jAk0JRm4xB6W36CfuP7G1shJuUxU0OpXLgOjCCuimYKlrPDuHCfAtrFRTx
 LcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792765826; x=1793370626;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=67X0q3AU0UCM8sg9sc3pgPDwhGqBRoZoJt24G9+/Pc4=;
 b=k86fHDbxnqHA4HN2+G57cZRFRkXuL0Qz+D/DyFm0O7sIWuxb1PUQEiFD7WO7AKxRMr
 eBofjVqWiBoOSpLP0qRYZ6VCRgd2QmKymnnLbUBX4BoFQ0YI8RfIi8P3yAhJmedygYdE
 EqOTRs0NyRAOwBHcH9MuP6F6v2OD99LwejttCsEtECDfHU2HjwU2mFcmWFZoGLAdt2/x
 fLjW0B/b941isCAL9l2MZUJfBxMzRh4dYRCXd0tRSiz3QDqk+OBNJjTzL+o6tkq3TCmt
 zZSF9V0Jv3ZLdFI6+eq+C4rYm1Poig3SkxbK37VIkMYfJAbOewBy6gzJaldeNcBDnj4+
 DVjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyk9ST/Wu375lG4unQ78AVyjOgxn6EptQZVSCUo33sGfGD5bXlH0t7UItStMTGkTqoC2eZquOVlTlp@nongnu.org
X-Gm-Message-State: AFq9FYInMFRpHxWkGF9TJxSPaCNtEh7HFfe/pYjXrsOE/nDQbwSvMYq0
 k0vTTTbGlL3mvdXCmLoYuEYOwjrx1UYZyLLB969Ttrhd8Bbx5DtNOr9JrHLzaKufE5C49xJ9XBJ
 1ObSKkHhbOyawYkPg0SeEJJP1NqjMFs5B0C5QX4dDuUghUzfU2eWdVTxN
X-Gm-Gg: AYBFou1+x3nMJ8YWASjdd4Q8Z7URsj6wNVFV2fZ4td41SCuTJJ6yAKrzLNwTjdApkkK
 dJeRmE21juxC00xeTkdsU+0ckC5cz0UACC2QqNLr0kpWKhqPfi40lEHYEYobOfJf1TADAgIRaWi
 YMm3tg7jWZQCdCP88Kp/wGvs7sZk8dXFHy01LgHov9gca8VLmxXsvLaK+wAXOgH88fDv4Cd9bI2
 WEM+mLf/x6UYOejngtVy2AIIrL2KBnqLI5bUTHPSvgQRa2nDbteGNHcYQfig5pZBRV7Fq11P8/f
 5nKsOVUtTNxp3ASFxE5kbcVTzx/GWBUWUtvEnLKf1E5+t/gXBh5wUDHHvqTtJyp02+ntHAlPLYO
 BZ9spReKzuUiBwM74WL7KCMLacIZx64q0og==
X-Received: by 2002:a5d:64cf:0:b0:48d:f14a:9173 with SMTP id
 ffacd0b85a97d-48e38546c42mr4195358f8f.8.1792765825806; 
 Fri, 23 Oct 2026 07:30:25 -0700 (PDT)
X-Received: by 2002:a5d:64cf:0:b0:48d:f14a:9173 with SMTP id
 ffacd0b85a97d-48e38546c42mr4195271f8f.8.1792765825167; 
 Fri, 23 Oct 2026 07:30:25 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d408f15sm154719f8f.33.2026.10.23.07.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 07:30:24 -0700 (PDT)
Message-ID: <4b4bd465-6e37-4db6-9680-ef346beb1244@redhat.com>
Date: Fri, 23 Oct 2026 16:30:22 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] qapi/block: Add IoAccountingOperation enum
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-3-hreitz@redhat.com> <87y0bssyie.fsf@pond.sub.org>
 <a29d0076-15ad-49d8-b1a4-0991a07bcaa4@redhat.com>
 <87v76tgdg3.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87v76tgdg3.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23.10.26 08:04, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 20.10.26 07:59, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> This enum gives more information than IoOperationType (which is used for
>>>> the rerror/werror distinction) to identify operation types for block
>>>> accounting.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    qapi/block.json | 20 ++++++++++++++++++++
>>>>    1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>> index 0a88d405a26..8f4a71733c1 100644
>>>> --- a/qapi/block.json
>>>> +++ b/qapi/block.json
>>>> @@ -629,3 +629,23 @@
>>>>                'command': 'str' },
>>>>      'features': [ 'unstable' ],
>>>>      'allow-preconfig': true }
>>>> +
>>>> +##
>>>> +# @IoAccountingOperation:
>>>> +#
>>>> +# I/O operation types as they are tracked by block accounting.
>>> Can we have a link to suitable docs on block accounting?
>> Which do you have in mind?
> Hey, I asked first!

:)

> Two ideas to find candidates:
>
> 1. How is IoAccountingOperation going to be used?
>
>     I can see events BLOCK_IO_DELAY and BLOCK_IO_DONE.  Documentation
>     there calls it "disk operation" in the event description and "I/O
>     operation" in the argument description.  Not a peep about
>     "accounting".  Might "tracked by block accounting" be about
>     implementation?  Or asked differently: why would the user care about
>     block accounting here?

Good question, the user presumably indeed won’t care. It is only going 
to be used for those two events, so maybe it makes most sense to merge 
those three patches (`IoAccountingOperation`, `BLOCK_IO_DELAY`, 
`BLOCK_IO_DONE`), so I can immediately refer to those events instead of 
accounting.

(The internal reasoning is that I don’t want this to deviate from the 
existing accounting too much, so that maybe the accounting code can 
later be switched to use the same request boundaries as this series 
introduces, and then switch its enum over to this QAPI variant. But 
absolutely not relevant to users, correct.)

> 2. Assuming "block accounting" is actually relevant for the user: what
>     are the QMP interfaces related to it?

The best is probably the `BlockDeviceStats` keys for the different 
latency histograms, which could be a map of this new enum to histograms 
instead… But given the above, probably best to just drop this.

Hanna

>> Also, I’m not sure whether these are suitable, because they are the operation types used by block accounting, but for now, accounting cookies (block/accounting.c) use their own non-QAPI enum (enum BlockAcctType).
> [...]


