Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED20DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6Tx-0006Pc-Hs; Mon, 19 Feb 2024 11:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc6Tu-0006PN-94
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:27:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc6Tn-0000ko-Gc
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708360014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pfkdY7A0R2qEVWg70pUKTIfg/jH9xUEZWj74zXS6luM=;
 b=MYgquFJkkCFs/OnxxnszT/9l/YtWRONHFSWa+AzWDGiBQrPgPUuuQi9Mb6pC66ss7Rcyts
 y/6O01fuie8mh9P+CwQPOjKu/nei0R26VvS5tDk8jzAiTGazFkoi8CtmcD0JZYYUFlh4bR
 +0SIfK670He6p8nbW/YvN2KwsiAtBkQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-Q2izFwusPXOTWzySk01ucg-1; Mon, 19 Feb 2024 11:26:48 -0500
X-MC-Unique: Q2izFwusPXOTWzySk01ucg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3c045f4a135so5595506b6e.3
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360008; x=1708964808;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pfkdY7A0R2qEVWg70pUKTIfg/jH9xUEZWj74zXS6luM=;
 b=PWnvPnhHTQuCCvO0s5QuQjm+l/vnMV74065zTOfi3WpdtcIpH/ImxP+lX563t5niUB
 CFmvDRpIxj/y3MmHM+TYFhtmkJePBrAoSxWekbRrzAjRhrk9yI3LjbQbhl8A80ogYnxa
 zmGVxWDBOzBrMxMLN4gT2RwTe43ncCqcZoYILTjAEO8JVATOnWUeDOE4njP12DIKOf09
 zpYXCNQSOQXHJPzZn1D160jRC2z/ppDAoIIpQy7vVqZlcuRS3Vsh/OIMZ29ccw7De1P5
 jzE834May9WzjKJ/HUt/BIVBtotRKrGpF8NeiAGQcM4OObihIEHXsoycKafWd8o8aphs
 a+Ig==
X-Gm-Message-State: AOJu0Yy6v86qNYiJgnTbwJcUG4YeNcnQJpBgyj/2RPfWV5n3Ncp2eVVR
 1s2VY+GVMpYCknWTLHd2QrZgD2DSh/IAGQd+86gVs1WSz86Mel2yN73icaJSrVtgS1UHayi2kF9
 tncrd+wwh1hhGtTT0CWo2mnOrId5LZjGkX21tpgvqrCqKlQN954Vb
X-Received: by 2002:aca:d0f:0:b0:3c0:4ac4:d7f1 with SMTP id
 15-20020aca0d0f000000b003c04ac4d7f1mr10633827oin.35.1708360008041; 
 Mon, 19 Feb 2024 08:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt6ppMNIikDsZYpdz0wA3BFGKb78kM1fVn3qIHNTMG9VhucdLp4QNV8cA9D8e7Z3E7AjF5ng==
X-Received: by 2002:aca:d0f:0:b0:3c0:4ac4:d7f1 with SMTP id
 15-20020aca0d0f000000b003c04ac4d7f1mr10633812oin.35.1708360007703; 
 Mon, 19 Feb 2024 08:26:47 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 mc7-20020a056214554700b0068caf901c9bsm3394878qvb.17.2024.02.19.08.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 08:26:47 -0800 (PST)
Message-ID: <0a084faf-3685-4134-aecc-5edf13111d89@redhat.com>
Date: Mon, 19 Feb 2024 17:26:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dropping 32-bit Windows host support
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
References: <CAFEAcA_BB5-eieVGuqqXn3aS-Vmc7OcTFmv5e=i5HgNw3Kp2FQ@mail.gmail.com>
 <ZdN5cbaqnJMTK5ts@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZdN5cbaqnJMTK5ts@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 19/02/2024 16.53, Daniel P. Berrangé wrote:
> On Mon, Feb 19, 2024 at 03:37:31PM +0000, Peter Maydell wrote:
>> Our msys2 32-bit Windows host CI job has been failing recently
>> because upstream MSYS2 are starting to phase out 32-bit windows
>> host support and are steadily removing i686 versions of packages.
>> The latest is dtc:
>> https://gitlab.com/qemu-project/qemu/-/issues/2177
>>
>> The writing is clearly on the wall for their 32-bit support, judging
>> from the "2023-12-13 - Starting to drop some 32-bit Packages" news
>> item at https://www.msys2.org/news/ and associated discussion at
>> https://github.com/msys2/MINGW-packages/discussions/19326 .
>>
>> QEMU on a 32-bit host is not likely to be a great experience, and I
>> suspect we don't have many users using 32-bit Windows who couldn't
>> use the 64-bit version instead. Our Download page points users at
>> MSYS2's packages, and they have already dropped the 32-bit QEMU
>> package build. Stefan Weil's binaries page, which is the other thing
>> we link to from Download, has no 32-bit version newer than 7.2.0.
>> So anybody using 32-bit Windows QEMU must be building it themselves.
>> Plus, we've already deprecated system emulation on 32-bit x86 hosts,
>> so the only remaining "supported" config is with the NVMM or WHPX
>> accelerators.
> 
> The other data point is that Win11 is 64-bit only, and IIUC,
> Win10 was 64-bit only for new OEM installs too, only upgrades
> or end user installs could choose 32-bit.

Yes, and considering that there will likely be a Windows 12 at one point in 
time, we'll drop support for Win10 and thus 32-bit support anyway.

>> I suggest that we should:
>>
>>   * remove the msys2-32bit CI job entirely (we will still have at least
>>     compile-time coverage via the cross-win32-system job)
>>   * document that the 32-bit Windows support is deprecated in
>>     docs/about/build-platforms.rst and deprecated.rst
>>   * update our Download page to remove mention of 32-bit Windows
>>
>> Any objections?
> 
> I think that's sane.

Sounds good to me, too.

Note that we already have an entry for "System emulation on 32-bit x86 
hosts" in the deprecation list ... so IMHO we could also justify to drop the 
32-bit Windows support immediately, since that's a subset of that entry.

  Thomas



