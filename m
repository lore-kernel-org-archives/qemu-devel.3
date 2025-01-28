Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D2BC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 04:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tccmN-0002dc-Ad; Mon, 27 Jan 2025 23:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tccmM-0002dT-6J
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 23:00:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tccmK-0000AL-Ig
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 23:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738036842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sefzHNL7eMLIoBEg2+TnujJ6dTEto0DcBtKtC1J/jtA=;
 b=aFufpwtXwjttPnvy49ZeWZ/HtQV92IeSPS/ZtdsQcC1n85+nvdspgHafJQaIYRZtTci0A2
 kxhftUg98zWmlE4ZxlqR3UM6P2yWgcZqUpEolwOXpxql9tlVL500/TufLDVyUdI6UqBL2e
 rWN/IIATcqt58A+dFtCsNqHR0keExiU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-w7Uy56oiOVWPtsbzKDYCZg-1; Mon, 27 Jan 2025 23:00:40 -0500
X-MC-Unique: w7Uy56oiOVWPtsbzKDYCZg-1
X-Mimecast-MFC-AGG-ID: w7Uy56oiOVWPtsbzKDYCZg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so280666466b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 20:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738036839; x=1738641639;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sefzHNL7eMLIoBEg2+TnujJ6dTEto0DcBtKtC1J/jtA=;
 b=HL33PX5RHETVlUiE9cdDZOQCsBzN8AmkMRpGhBfiM0ouCduQRfoKZCSzYkJkR6HsFW
 kpAVqDxEbfSPfvxNPCqTAqo6FNGvspwCzJRz8TK1DPOCLGVZ9QhtEkpsdHQEltncs3mk
 Ztu2rgllN1W8sMbs0+giVUOcaeWD9nm695oAqC83ll9H6+LZL4FdgiBFZrEFtBW3FdKM
 nfz242TrMscMDYXJk78zhPJ/5nRu2heoYGzEAvQl8t1kUpVqH+katiSi9u0ZRCPSgu8l
 T/gvsWZeKBhogQyJKjmpTsTYgcql8X054qRFpfXTd8RNsXCS/lTQMDzs4dvVMCYHq6ve
 3XVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1RieOHWQROIWMQWZEEzcUU+QfVSG8EfMfGhLgCJIJfSjvSX7sbwzJ4QmktjA28o9x6afoo2yTJzO4@nongnu.org
X-Gm-Message-State: AOJu0YyFPotzzjupgQSTCUA7nBxFV888vLK8fvDVI5jo3glIbIPDiCpe
 qbgg34KC6Dwem7BzFljPeYzf4+3HJLnnjyTNKoKa9n9IFsXwYANX2MvFGnCFAOouICN0w1P5ENt
 vZQNKjcGX+f3ro0IjUPJiB8XzvE95hsz7zKudSnDIKe6tjxxOxZNt
X-Gm-Gg: ASbGncuFABOXhmXuPekN5zW5LW6CHBdHPeb1TRSBqvgT1NViMzNeGXvJAMEeSs+zKzg
 Jps0IicF0fhSXKSSWktvGPcsJBgjbiY2aIHccfDk9OcSoJiZyiVzDdflt8Ohp8yuEjULUTfuNH6
 BXvuRpBK04Wgl/5p4RNbNfvd5c1h0hM2mdmo3O7ere8pF6Uql8IgPh3+bRPDt/QWnKTp8rSz+5t
 UvegF7Xd4XYyfue4tXcTd8YLrlAITjOpmgA/No1yd3YaH+W1optlzBHb9mV8RcweuIZU4AYv9CW
 Q+tqYkeWSxc9N5c9Vsj2fw5agDt26d2M3ZvB
X-Received: by 2002:a17:906:6a26:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-ab38b4aa1aemr3610615666b.47.1738036839132; 
 Mon, 27 Jan 2025 20:00:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+24ZunFtKMHlBiTbDrL9IEaeXfI3mTt4mIg6tsWBheKOms5imL6r6zWelN4apEAFdXf1dNg==
X-Received: by 2002:a17:906:6a26:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-ab38b4aa1aemr3610612866b.47.1738036838703; 
 Mon, 27 Jan 2025 20:00:38 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6984afd15sm400276266b.126.2025.01.27.20.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 20:00:37 -0800 (PST)
Message-ID: <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
Date: Tue, 28 Jan 2025 05:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, philmd@linaro.org, mark.cave-ayland@ilande.co.uk,
 alex.bennee@linaro.org, Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250128004254.33442-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 28/01/2025 01.42, Richard Henderson wrote:
> Time for our biennial attempt to kill ancient hosts.
> 
> I've been re-working the tcg code generator a bit over the holidays.
> One place that screams for a bit of cleanup is with 64-bit guest
> addresses on 32-bit hosts.  Of course the best "cleanup" is to not
> have to handle such silliness at all.
> 
> Two years after Thomas' last attempt,
> 
>    https://lore.kernel.org/qemu-devel/20230130114428.1297295-1-thuth@redhat.com/
> 
> which resulted only in deprecation of i686 host for system emulation.
> By itself, this just isn't enough for large-scale cleanups.
> 
> I'll note that we've separately deprecated mips32, set to expire
> with the end of Debian bookworm, set to enter LTS in June 2026.
> 
> I'll note that there is *already* no Debian support for ppc32,
> and that I am currently unable to cross-compile that host at all.

IIRC the biggest pushback that I got two years ago was with regards to 
32-bit arm: The recommended version of Raspberry Pi OS is still 32-bit:

  https://lore.kernel.org/qemu-devel/F852C238-77B8-4E24-9494-8D060EB78F9F@livius.net/

And looking at https://www.raspberrypi.com/software/operating-systems/ this 
still seems to be the case...

So I guess the main question is now: Would it be ok to kill support for 
32-bit Raspberry Pi OS nowadays?

> Showing my hand a bit, I am willing to limit deprecation to
> 64-bit guests on 32-bit hosts.  But I'd prefer to go the whole hog:
> unconditional support for TCG_TYPE_I64 would remove a *lot* of
> 32-bit fallback code.

Sound like a good alternative to me!

  Thomas


