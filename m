Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B1EE7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXDuo-0004zM-MG; Mon, 13 Jan 2025 01:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXDuj-0004z3-Kf
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:27:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tXDug-0001Tt-9Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736749616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3xdCKSGMtKuYtcu8MK6yE6innDLTZCjuI0s8djG8elM=;
 b=YH0SiRNjOT2JzNJRlElXqj0nfN3E1DGpJAZiBX6IRzrXZ2RcvoOxV7L+i+WU4+EQKx/EKr
 g+gDRgvfBJtleKqmG2BAC9FxDEvfHws1M6rfioeIHJdNGZzeMn5mCVWHRZBbabjNc0ZSQ8
 EXGvMu2F9R5ZaMl7INJaq6fZIrL3e/4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Vq4n9Pc5MW2fTaUeEeu0_g-1; Mon, 13 Jan 2025 01:26:50 -0500
X-MC-Unique: Vq4n9Pc5MW2fTaUeEeu0_g-1
X-Mimecast-MFC-AGG-ID: Vq4n9Pc5MW2fTaUeEeu0_g
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa67fcbb549so494628166b.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 22:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736749609; x=1737354409;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xdCKSGMtKuYtcu8MK6yE6innDLTZCjuI0s8djG8elM=;
 b=XzWaT5osDuvoEVg6h6uIxbxN+xXPKwT/4SHkcfvbu265/MX7HExx8Odcemo2yUbijm
 PTMO8au1guuxRfZ7bCJBp6vpvvA2Y7dr/e2yuKlOEdUG3cP2N3HLhbRrZNa8vR4oxnLC
 gMbF3VUxtRp3Aq+cPH9RYnr04D4EnTImMBVCeEDHTrW33IN89zKNIbSo3djqQeLdQP8g
 PfVksOs00MFNq8FCOh0TLMkHrUdOaKmeMGd2l3KF0zDGjjq/e0FCPwwbZ26VDtsSTVkA
 2SznJs9bVRXUAmOPrjKGW/PTf8YHfx8SpYTN88tlTrhMEmUAUkXpnql38Khx3hk6At9l
 loZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVi00AFYiP+cSjdaio9VQ2Nib47IINoYE9ZW3UjQzXEGwuy7UnKUXDrmoBO1lZ+LAXcRUwo1wLqO5jq@nongnu.org
X-Gm-Message-State: AOJu0YyuAkvEnDAlxqlTY4LMQy3QYAWMguH7WsSNWT0l63OP3cE+2t9N
 GlwacEyMnG0TG/u9jubOrJDeQoESFfti17G+JGCI8z9w2wcRah6Rl8UbPdB2zyt7Zz3sNXlKNFy
 cFrib/zfzSq2IATC7PmfSfzh/k0tsiKITVw0h/jbDcBWdwaDJQro0
X-Gm-Gg: ASbGncu4uXZdl6ZnyJzdzM0ET9jbb0a40KXv4UrEWdESw3cfcoR+KkcF072FRsSeRnS
 Ax+DbvEcrvea8c/bQ6W01eNQogCubFkjSnSk+E8nWWJ0/ESClAN+uneRPfjewJhB8Omv08TgEQA
 y1JZk+Zsy66HI0b7LA4TRNqtgD1uUQ2ZT1FxhpKoP8zyYqxZra5/+DqbsFPS7Uz1V4CTS27C57X
 Zqa7epKVCShLhDrMssJAJhru+r4Hs0p+Kk5un+7fO2xBZVDGxvCcjbdnAfSG13JURxdzpPYqzBk
 sw1qAQpuZA==
X-Received: by 2002:a17:907:7da7:b0:aae:85a9:e2d with SMTP id
 a640c23a62f3a-ab2ab6bfa39mr1856451266b.45.1736749609057; 
 Sun, 12 Jan 2025 22:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHIpE/2uv+imdDful7mer7tNE+HXGlwcutpIEiU0eos/spyZSMSEmOW+Q1lv1ZSMZHgOfUHg==
X-Received: by 2002:a17:907:7da7:b0:aae:85a9:e2d with SMTP id
 a640c23a62f3a-ab2ab6bfa39mr1856449266b.45.1736749608644; 
 Sun, 12 Jan 2025 22:26:48 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-16.web.vodafone.de. [109.42.48.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905f067sm461806066b.14.2025.01.12.22.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jan 2025 22:26:48 -0800 (PST)
Message-ID: <876fe41d-df26-4a13-a465-feeee0004746@redhat.com>
Date: Mon, 13 Jan 2025 07:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
 <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.798,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/01/2025 16.47, Philippe Mathieu-Daudé wrote:
> On 10/1/25 21:37, Pierrick Bouvier wrote:
>> On 1/10/25 12:33, Pierrick Bouvier wrote:
>>> For now, it was only possible to build plugins using GCC on Windows. 
>>> However,
>>> windows-aarch64 only supports Clang.
>>> This biggest roadblock was to get rid of gcc_struct attribute, which is not
>>> supported by Clang. After investigation, we proved it was safe to drop it.
>>>
>>> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and 
>>> aarch64
>>> hosts.
>>>
>>> v1 contained warning fixes and various bits that have been upstreamed 
>>> already.
>>> The only bits left in this series are the gcc_struct removal, and fixing the
>>> plugins build with clang.
>>>
>>> This series is for 10.0, as we decided to not include the gcc_struct 
>>> removal is
>>> 9.2 release.
>>>
>>> All patches are now reviewed, so this series can be pulled. I'll report 
>>> that to
>>> MSYS2 too, so we can enable clang environments for QEMU.
>>>
>>> v1: https://patchew.org/QEMU/20241031040426.772604-1- 
>>> pierrick.bouvier@linaro.org/
>>>
>>> v2:
>>> - drop attribute gcc_struct instead of using -mno-ms-bitfields option
>>> - add a section about bitfields in documentation
>>>
>>> v3:
>>> - explain why gcc_struct attribute matters in packed structs in commit 
>>> message
>>> - reword the bitfields documentation with suggestions given
>>>
>>> v4:
>>> - edit for bitfields doc requested by Philippe
>>>
>>> Pierrick Bouvier (3):
>>>    win32: remove usage of attribute gcc_struct
>>>    docs/devel/style: add a section about bitfield, and disallow them for
>>>      packed structures
>>>    plugins: enable linking with clang/lld
>>>
>>>   docs/devel/style.rst                      | 20 +++++++++++++++++++
>>>   meson.build                               |  6 +++---
>>>   include/qemu/compiler.h                   |  7 +------
>>>   scripts/cocci-macro-file.h                |  6 +-----
>>>   subprojects/libvhost-user/libvhost-user.h |  6 +-----
>>>   contrib/plugins/meson.build               |  2 +-
>>>   plugins/meson.build                       | 24 +++++++++++++++++++----
>>>   tests/tcg/plugins/meson.build             |  3 +--
>>>   8 files changed, 48 insertions(+), 26 deletions(-)
>>>
>>
>> It would be nice if a maintainer could pull this, so we can get this 
>> merged upstream.
> 
> That'd be Thomas or Alex I suppose.

This touches plugins, so I think it should go through Alex' tree?

  Thomas



