Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE03C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol4l-00039p-Cs; Mon, 25 Mar 2024 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rol4h-00037n-V4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rol4g-0005vP-F0
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Jfe36kNM8Vq2tmHmf9OJjHoqMLDHla/r0bgoDkyeBDE=;
 b=VGjKebU2w0MwLT5hoqGITrwF7NJV3eFv3jodISF5YM2ZNqTzB3M9VQzjwSmE4C3oUInBPQ
 KxDwh4LHT0VxSuAHdJsHPT6NgsxLg1YoxTUiMGeiVltj9nPdRfSpyUZbQpBEaxFpFBZjcS
 1ED6bG6ppuQRaQvIWMv4bVYgiExcdX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-y90nOnRaOiOvmd8Rf_26qw-1; Mon, 25 Mar 2024 10:13:15 -0400
X-MC-Unique: y90nOnRaOiOvmd8Rf_26qw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-41488775a3eso5513395e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711375994; x=1711980794;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jfe36kNM8Vq2tmHmf9OJjHoqMLDHla/r0bgoDkyeBDE=;
 b=f9w70H6agyP9v6m8cz4eu0F9VHYI5zfrbczxCU5Ju0ocjFkDAfEaT6eXABmRbaYgTR
 52VTMz4ODRpHMa8dkOMTOSrIZTXmEepH0SmP/0FDgw8ij04be/F+DmSAPNyS3D3nTTcM
 2Ew8DOai2u4tsHDDlBVt6znttbVk7ShNMF0V+UjvA95vOEPeLW0HT64l5cazDNfEE8yK
 DCeF59Ua7ql3DT4mHu+lEpko/5xNEXpMTFRitb55HYtWVAulqkz+to8SpddH3l4YmuL3
 nHffcTPNzowgVA4O75tHBw5luDyu4xi2UmZwSjwSIR8lejbttO/JdM8mKrsY6ewd14HX
 Varw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpTmR+Jhm/7Fx1URuVdW0xn3dcCvrFOfiehThFZMKZagu1lgtq+O3nT/SK1MIOfmyPLhhY2NIwMGep6apcjNWtyFaXGFQ=
X-Gm-Message-State: AOJu0YwkYDN6Nnm9T1/0fbJpZWUrFTr1BaVI28wDmMJth5bSPuKi9k+Z
 kOPaEjly/Y/te7g1VBqk9/rUV5rIPET4LjG14zQhmktyXkkW2NYLSs5rcBxP1z5sq8MN3gsJRBd
 zJAWFkyznfNa1xZAi5voXOakXtGTlPutKro3wxhbQgaYvqChAiMYT
X-Received: by 2002:a05:600c:4ed3:b0:414:6981:cc5e with SMTP id
 g19-20020a05600c4ed300b004146981cc5emr4436180wmq.36.1711375994023; 
 Mon, 25 Mar 2024 07:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKs/xV+pv38xtTpjPRSH2UGuv+4o+57VeN6EI/Wn8zz2ohE80lvFkSSdtltJxSaQzsJL25vg==
X-Received: by 2002:a05:600c:4ed3:b0:414:6981:cc5e with SMTP id
 g19-20020a05600c4ed300b004146981cc5emr4436155wmq.36.1711375993626; 
 Mon, 25 Mar 2024 07:13:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c738:b400:6a82:1eac:2b5:8fca?
 (p200300cbc738b4006a821eac02b58fca.dip0.t-ipconnect.de.
 [2003:cb:c738:b400:6a82:1eac:2b5:8fca])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c468500b00414854cd257sm6460486wmo.20.2024.03.25.07.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 07:13:13 -0700 (PDT)
Message-ID: <f72122ed-1611-445a-a281-1d52587c7eae@redhat.com>
Date: Mon, 25 Mar 2024 15:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Let's close member documentation gaps
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <87il1aodow.fsf@pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87il1aodow.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25.03.24 10:36, Markus Armbruster wrote:
> If you're cc'ed, I have a bit of doc work for you.  Search for your
> name to find it.
> 
> The QAPI generator forces you to document your stuff.  Except for
> commands, events, enum and object types listed in pragma
> documentation-exceptions, the generator silently defaults missing
> documentation to "Not documented".  Right now, we're using this loophole
> some 500 times.
> 

What would be the right step to make sure I am resolving these "hidden" 
issues, and that the QAPI generator would be happy with my changes?

-- 
Cheers,

David / dhildenb


