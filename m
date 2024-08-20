Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5624FC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 03:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgFp1-00064n-1t; Mon, 19 Aug 2024 23:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sgFoy-00063w-TM
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:46:12 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sgFow-0004A1-Pu
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 23:46:12 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-44febbc323fso26596591cf.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724125564; x=1724730364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:user-agent:from:to:cc:subject:date:message-id:reply-to;
 bh=S8osCCjb18nnG18cabevtmv7iBuBHnnJh/4AVIx9qUM=;
 b=J+Vml/Xhaktxo7wrFw2bvQj9OigpYiXXr1su2R4oBh5qCYFGK2EHlULe1QcA3UMdTP
 2Fnwol7CIKs20GopA/IOq62Xpumi0KYi2pQkuhuDTMa5chKpKQWeGM/6Oscr5hvaH1JA
 O4N1SP7R92gjH7qoG+SARRBER666n0KiHaIKXUtW98haY9/bHHKOSS1b6zVdVyTRsORT
 B4UmEqU0P42fZ+gs7smKfqsiGgdUr//BJU8W57lUCy8B5ulQk7h7Hfj1l8Ruxh4Twvdo
 7xCajSOf77/zLWRw+xoS9nYcMoF4n37T5Ch0O9c3DVgoRDPvlP/NmKnKEyjZJ7RK/Hdj
 goWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724125564; x=1724730364;
 h=cc:to:subject:message-id:date:in-reply-to:references:mime-version
 :from:user-agent:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8osCCjb18nnG18cabevtmv7iBuBHnnJh/4AVIx9qUM=;
 b=aaDJ/S7DCrdwy2pXdyeyZTcfesIVoNoHDJnWHlgXIBufcfMkreul6smpnOITRy5FYz
 iHZSqLOOcLV0GUSUoT4gSdrcmMq9nFgKigZOq6/nz/itgpqTM6WL6LgkzTaoUSbHRl+T
 5Jbv64bjGx6n7FzYj2rwiV6VNDTidK06HQ9WXRHLzPgtoqjIUJ3hd2RplW+SWkr0wRVx
 8GkkcUAICpa4NvbQWp16NYoeoSMS2QDepT2bL1cPYGr035ULke0vs3punMeRWo0tC4gd
 TatTa7l9ew2if+UO1mCGaj6EPqlSKgS8Qd5DzL2DjSdKPZgPDn3/NDrEXAjSx5Lqj+yu
 jZ6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFqwofSZ5Nk8XnQK1F4ZlJsHkO/iACSAvoFWBS4JWiOV8qbvENhcBfcTbPC8HZO74jz3xiSwi/mnV@nongnu.org
X-Gm-Message-State: AOJu0YwGONunYxYHA2D3MAEBXHL8JekiWuj6SmmVJvovlAv16gu6e8MI
 xpon0AC+Bv/kQG/ndGhprC239DUSCwVdCVEsvJbq4aqVWTfuOlgMLRo6pez9MYBbRdAvRRQ+eIE
 w+VOyLAxPPhx40fHowho0gxyB46HkYNAFNGkL3A==
X-Google-Smtp-Source: AGHT+IGMCIIShUaWSFjhbENCl7fImS8xnCcM2PmRRga4k6KQSvs6XT8cwtK5zgsU7oHGhv+5ZT98TH552zfbAkOHpcw=
X-Received: by 2002:ac8:6f09:0:b0:446:5a63:d68f with SMTP id
 d75a77b69052e-454e6b22ac9mr16792271cf.18.1724125563664; Mon, 19 Aug 2024
 20:46:03 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 19 Aug 2024 20:46:03 -0700
User-Agent: Mozilla Thunderbird
From: zhenwei pi <pizhenwei@bytedance.com>
Mime-Version: 1.0
X-Original-From: zhenwei pi <pizhenwei@bytedance.com>
References: <20240812014252.1398754-1-pizhenwei@bytedance.com>
 <6d6d5d2c-3696-45eb-b9ba-fb5a754fefba@linaro.org>
 <a846ac05-85bd-4d6b-a86a-e9e3d4e9bc3f@bytedance.com>
In-Reply-To: <a846ac05-85bd-4d6b-a86a-e9e3d4e9bc3f@bytedance.com>
Date: Mon, 19 Aug 2024 20:46:03 -0700
Message-ID: <CABoGonLLTM--qeT_3F4xN4rq1pEUx0T1V7QEcOeWG_EbE1UNmQ@mail.gmail.com>
Subject: PING: [PATCH] qapi: Document QCryptodevBackendServiceType
To: armbru@redhat.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c55d5d0620154316"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_MUA_MOZILLA=2.309,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000c55d5d0620154316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

This seems to be ignored...

On 8/13/24 09:51, zhenwei pi wrote:
> On 8/12/24 14:14, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/8/24 03:42, zhenwei pi wrote:
>>> QCryptodevBackendServiceType was introduced by
>>> bc304a6442e (cryptodev: Introduce server type in QAPI). However there
>>> is a lack of member description. Thanks to Markus for pointing out
>>> this.
>>>
>>> Signed-off-by: zhenwei pi
>>> ---
>>> qapi/cryptodev.json | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>
>>> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
>>> index 68289f4984..9622c6d92b 100644
>>> --- a/qapi/cryptodev.json
>>> +++ b/qapi/cryptodev.json
>>> @@ -28,6 +28,16 @@
>>> #
>>> # The supported service types of a crypto device.
>>> #
>>> +# @cipher: Symmetric Key Cipher service
>>> +#
>>> +# @hash: Hash service
>>> +#
>>> +# @mac: Message Authentication Codes service
>>> +#
>>> +# @aead: Authenticated Encryption with Associated Data service
>>> +#
>>> +# @akcipher: Asymmetric Key Cipher service
>>
>> Can we drop all trailing "service"s?
>>
>
> I copied these descriptions from virtio-crypto spec. Removing them also
> is fine to me.
>
>>> +#
>>> # Since: 8.0
>>> ##
>>> { 'enum': 'QCryptodevBackendServiceType',
>>
>
> --
> zhenwei pi
>

--=20
zhenwei pi

--000000000000c55d5d0620154316
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi Markus,
<br>
<br>This seems to be ignored...
<br>
<br>On 8/13/24 09:51, zhenwei pi wrote:
<br>&gt; On 8/12/24 14:14, Philippe Mathieu-Daud=C3=A9 wrote:
<br>&gt;&gt; On 12/8/24 03:42, zhenwei pi wrote:
<br>&gt;&gt;&gt; QCryptodevBackendServiceType was introduced by
<br>&gt;&gt;&gt; bc304a6442e (cryptodev: Introduce server type in QAPI). Ho=
wever there
<br>&gt;&gt;&gt; is a lack of member description. Thanks to Markus for poin=
ting out
<br>&gt;&gt;&gt; this.
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; Signed-off-by: zhenwei pi
<br>&gt;&gt;&gt; ---
<br>&gt;&gt;&gt; qapi/cryptodev.json | 10 ++++++++++
<br>&gt;&gt;&gt; 1 file changed, 10 insertions(+)
<br>&gt;&gt;&gt;
<br>&gt;&gt;&gt; diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
<br>&gt;&gt;&gt; index 68289f4984..9622c6d92b 100644
<br>&gt;&gt;&gt; --- a/qapi/cryptodev.json
<br>&gt;&gt;&gt; +++ b/qapi/cryptodev.json
<br>&gt;&gt;&gt; @@ -28,6 +28,16 @@
<br>&gt;&gt;&gt; #
<br>&gt;&gt;&gt; # The supported service types of a crypto device.
<br>&gt;&gt;&gt; #
<br>&gt;&gt;&gt; +# @cipher: Symmetric Key Cipher service
<br>&gt;&gt;&gt; +#
<br>&gt;&gt;&gt; +# @hash: Hash service
<br>&gt;&gt;&gt; +#
<br>&gt;&gt;&gt; +# @mac: Message Authentication Codes service
<br>&gt;&gt;&gt; +#
<br>&gt;&gt;&gt; +# @aead: Authenticated Encryption with Associated Data se=
rvice
<br>&gt;&gt;&gt; +#
<br>&gt;&gt;&gt; +# @akcipher: Asymmetric Key Cipher service
<br>&gt;&gt;
<br>&gt;&gt; Can we drop all trailing &quot;service&quot;s?
<br>&gt;&gt;
<br>&gt;=20
<br>&gt; I copied these descriptions from virtio-crypto spec. Removing them=
 also
<br>&gt; is fine to me.
<br>&gt;=20
<br>&gt;&gt;&gt; +#
<br>&gt;&gt;&gt; # Since: 8.0
<br>&gt;&gt;&gt; ##
<br>&gt;&gt;&gt; { &#39;enum&#39;: &#39;QCryptodevBackendServiceType&#39;,
<br>&gt;&gt;
<br>&gt;=20
<br>&gt; --=20
<br>&gt; zhenwei pi
<br>&gt;=20
<br>
<br>--=20
<br>zhenwei pi</p>

--000000000000c55d5d0620154316--

