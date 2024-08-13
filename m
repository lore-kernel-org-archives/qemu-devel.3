Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C171C52D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 01:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdgh0-0004Ar-E5; Mon, 12 Aug 2024 21:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdggy-00046g-UW
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:51:20 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sdggw-00014s-EQ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 21:51:20 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-45019dccc3aso28200231cf.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 18:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1723513875; x=1724118675; darn=nongnu.org;
 h=cc:to:subject:message-id:date:user-agent:references:in-reply-to
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8mMqsMoZH9NzLMZJnfaPYtyvD/jQTZjKVOPlbXNhR+k=;
 b=lJxBWxdMxE+8MSHB6h0j2fkDEoL0JsZu8z8TooRInptQRIBJPZT6CbBVg8K+ejtuN2
 m8/Yx4WTq22+Oot36P2xGBWAnaGa5ESuqVM492zPS31nRKnOc5bw2qtTGUuqxR8dv9hg
 +e3Jb77yyflevKYkcFelUFneA3qsrRgNhnOCVEJSJ7oMK7ujAiu9my9Er9mRn7WmBcZ5
 iP5JWx5se1HZrTKxZUMMuMSOwHs+qMc+vRqitrf0uOXSHGowXQrQfQM37K6LokBZHdCK
 DaTc/532X/7Q5iD8KZwbG64wd0tisszvOGde46fYujaEePxUkmWnm4VbrOFRVY1lM+Tk
 osyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723513875; x=1724118675;
 h=cc:to:subject:message-id:date:user-agent:references:in-reply-to
 :from:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mMqsMoZH9NzLMZJnfaPYtyvD/jQTZjKVOPlbXNhR+k=;
 b=HSigEVRb0rLuFLkUoE6rlyzyRG535ZQ+lflxn7UlN2cGrkd4+6bCNavoYf4012vlD8
 uOlllDsEsjbsq3ykKP/k86d8ork7rNqj15UNmzXzRaH+q49Kooi6HBowA0w2FRxaueI7
 CzIbFEEqwZgIoJgnL6e1yDN7G2HmLbwByZrl7TQ0gYtGUvSrud7HHKglZaW+bbAClCAz
 FiwifBlhgdajLJRM2cUqfOmkobGVKBEy9L68x393aqDVj2VcR8B2tChU+P+06bUHAZS8
 FBaroXLv0qmo9/5psi+mPiwK/NbsaB8v0wABBrAAKVcuKHG4hkud+lK2NzrjQ8hkJk1A
 wqlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/xQjDgDR66R33kM++mqhxetJxAErCpvQFn4digSP5xCrdd3dxBYKYUJO9e4qG/ctdmbx6Dzkp5ManQTFJc6GP5RrH9oQ=
X-Gm-Message-State: AOJu0YwOaVL//CQcmDbVjV7jMw9TCH/HaJePmejQCW5VVFshrkl+7G+z
 3jxC5TiBY3xhHv2KpuNBYZENcqHVoqe+/ngZ3ISckHALXfRA0R/P2N0ywwZUKoyMZYJ5BWxPOhd
 o85M0yhOybNBgaXHaJUvaTVI1w1H4B3yoSHasJQ==
X-Google-Smtp-Source: AGHT+IEuc+VUVgmqfGSuTvZA6zdVB7wtDNWlIy7S/0TKjZtv46mRCFb85oHnmI21p68GWRhCeATXlYk7ejtoRrbvxAU=
X-Received: by 2002:a05:622a:5a06:b0:44f:e797:2f76 with SMTP id
 d75a77b69052e-453499f0858mr24217831cf.39.1723513874752; Mon, 12 Aug 2024
 18:51:14 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 12 Aug 2024 18:51:14 -0700
X-Original-From: zhenwei pi <pizhenwei@bytedance.com>
Mime-Version: 1.0
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <6d6d5d2c-3696-45eb-b9ba-fb5a754fefba@linaro.org>
References: <20240812014252.1398754-1-pizhenwei@bytedance.com>
 <6d6d5d2c-3696-45eb-b9ba-fb5a754fefba@linaro.org>
User-Agent: Mozilla Thunderbird
Date: Mon, 12 Aug 2024 18:51:14 -0700
Message-ID: <CABoGonL2AbuTH_CJEeM3s0qUXPYJKFqGxDXj4xm20_Nq6adUPg@mail.gmail.com>
Subject: Re: Re: [PATCH] qapi: Document QCryptodevBackendServiceType
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 armbru@redhat.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com
Content-Type: multipart/alternative; boundary="000000000000453a8c061f86d863"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=pizhenwei@bytedance.com; helo=mail-qt1-x82b.google.com
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

--000000000000453a8c061f86d863
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 8/12/24 14:14, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/8/24 03:42, zhenwei pi wrote:
>> QCryptodevBackendServiceType was introduced by
>> bc304a6442e (cryptodev: Introduce server type in QAPI). However there
>> is a lack of member description. Thanks to Markus for pointing out
>> this.
>>
>> Signed-off-by: zhenwei pi
>> ---
>> qapi/cryptodev.json | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
>> index 68289f4984..9622c6d92b 100644
>> --- a/qapi/cryptodev.json
>> +++ b/qapi/cryptodev.json
>> @@ -28,6 +28,16 @@
>> #
>> # The supported service types of a crypto device.
>> #
>> +# @cipher: Symmetric Key Cipher service
>> +#
>> +# @hash: Hash service
>> +#
>> +# @mac: Message Authentication Codes service
>> +#
>> +# @aead: Authenticated Encryption with Associated Data service
>> +#
>> +# @akcipher: Asymmetric Key Cipher service
>
> Can we drop all trailing "service"s?
>

I copied these descriptions from virtio-crypto spec. Removing them also
is fine to me.

>> +#
>> # Since: 8.0
>> ##
>> { 'enum': 'QCryptodevBackendServiceType',
>

--=20
zhenwei pi

--000000000000453a8c061f86d863
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>On 8/12/24 14:14, Philippe Mathieu-Daud=C3=A9 wrote:
<br>&gt; On 12/8/24 03:42, zhenwei pi wrote:
<br>&gt;&gt; QCryptodevBackendServiceType was introduced by
<br>&gt;&gt; bc304a6442e (cryptodev: Introduce server type in QAPI). Howeve=
r there
<br>&gt;&gt; is a lack of member description. Thanks to Markus for pointing=
 out
<br>&gt;&gt; this.
<br>&gt;&gt;
<br>&gt;&gt; Signed-off-by: zhenwei pi=20
<br>&gt;&gt; ---
<br>&gt;&gt;   qapi/cryptodev.json | 10 ++++++++++
<br>&gt;&gt;   1 file changed, 10 insertions(+)
<br>&gt;&gt;
<br>&gt;&gt; diff --git a/qapi/cryptodev.json b/qapi/cryptodev.json
<br>&gt;&gt; index 68289f4984..9622c6d92b 100644
<br>&gt;&gt; --- a/qapi/cryptodev.json
<br>&gt;&gt; +++ b/qapi/cryptodev.json
<br>&gt;&gt; @@ -28,6 +28,16 @@
<br>&gt;&gt;   #
<br>&gt;&gt;   # The supported service types of a crypto device.
<br>&gt;&gt;   #
<br>&gt;&gt; +# @cipher: Symmetric Key Cipher service
<br>&gt;&gt; +#
<br>&gt;&gt; +# @hash: Hash service
<br>&gt;&gt; +#
<br>&gt;&gt; +# @mac: Message Authentication Codes service
<br>&gt;&gt; +#
<br>&gt;&gt; +# @aead: Authenticated Encryption with Associated Data servic=
e
<br>&gt;&gt; +#
<br>&gt;&gt; +# @akcipher: Asymmetric Key Cipher service
<br>&gt;=20
<br>&gt; Can we drop all trailing &quot;service&quot;s?
<br>&gt;=20
<br>
<br>I copied these descriptions from virtio-crypto spec. Removing them also
<br>is fine to me.
<br>
<br>&gt;&gt; +#
<br>&gt;&gt;   # Since: 8.0
<br>&gt;&gt;   ##
<br>&gt;&gt;   { &#39;enum&#39;: &#39;QCryptodevBackendServiceType&#39;,
<br>&gt;=20
<br>
<br>--=20
<br>zhenwei pi</p>

--000000000000453a8c061f86d863--

