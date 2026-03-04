Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7D6EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm4q-0003jK-Am; Wed, 04 Mar 2026 08:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vxm4l-0003iR-VK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:15:44 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vxm4k-0007Za-CI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:15:43 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so56635575e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1772630141; x=1773234941; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xs3DGBo+o6J3j4N5y/Zjqd0HnTdtohJpN3boYZiLcjQ=;
 b=HazcgtEl5+m4Lv+2BuZVPHa0XWm4VXVzgrrz0/58CTkedE8IC1ona51s27rtOkrMXz
 JpuwUz5AFI8C/g2E6omRDbmCEWMvLdG/9hZZKBHq4vRuEk5hQESNi8UqcfiMA5Qn02zu
 ggSWXbU9qdyz89V7p0dacIDeGvnlD+c+LwW8C+mLnh/li5VZ09zmgSpRl27+bwwkbpqa
 t2eZKYakOj1yDunQj41nHnWixt7wnnj1kgSef13xby26RxkHZGWHAoOwbd71HseL3XZB
 LD3frlfhBOWWmUfMbrrMo5ZJgJQ508DScZzdIgqxkBvc1OjkH9Lj+If4/m2iqntoGCwz
 EDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630141; x=1773234941;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xs3DGBo+o6J3j4N5y/Zjqd0HnTdtohJpN3boYZiLcjQ=;
 b=scT2GY1U4PRjflnbIFp2aOq5w8vGCl9wOPXD3N5GBln39ReyP0uMZpoZVRRhBrY/Vy
 r5kr0XwJvsxB7okq0ceAEUG4rm4bTgzjKNFSkTkwJpy0aItmV0RNUi/9u9OjmdoyhOXu
 eX2dQB4EKs9CApaynaoIGwHJoPjvNXTkeqP2RpjjiIVb3Fk2N9HuAoCO8PbPdPsjq/+1
 sFmh5jyAmnd5zQd6tROb+16Q0yZtfOzGzSvZ5Hxmt/V6nECC4L6XmelYt7TeUqlU3z/J
 YrvYTYkAq4tg1AQbXOi9Ve3UziJNQYnoJMcfaomGyERUvvQL+7wOFkJMdNRwWbd6559o
 bRcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqulVuhtMptjCBpzJO3qKqdy+ew0SfrzQBmLdwMWnC/blXaitKGcVzjJZhebLtJCBDZG+VKDx+XMCQ@nongnu.org
X-Gm-Message-State: AOJu0YzN7GKTkHC5038NziTPWJAo+ZbdTvvIXvPbp+F2RTf3+5llOEcf
 4zHaTZkf6Os4uZENR3a5bFSz3deRjQ+K3S2fQtUjjHf4bd/lXPquOmyz3bNSsqOkr+4=
X-Gm-Gg: ATEYQzzTQMWz1vyPNTNQeVTy026zSoBC2/HkH7i4fZf67I7n7sig2i0Ob+mSIfU/9Vf
 zei6IHNeoCzQbnKSultTixbDE/h9NmHG8DS+Mows00LuHe9GomrfntYmfTGNIr+vwxb2gHosQI0
 GrckCP5g/OUbIt/rwmk+o9b4zTl72eRSHdITbQO9KSkw52/hKIQ31XGf+D4enETJJYzxx5Lid4A
 m8AQK5T1Y4MtaZ/zk5xBpuM45fS0hNCgAAJrKqZ3i+m5pVXj8dgr9VRg0IYl5tiKylx0Ipvtr44
 JFdA+1SZ/yak3yTgU/g+vgXrEC1TbGzSu86nSF2XuFdVxHqEoc2WZ50xcC0Go+qO+VQFOb2ByAs
 p/OZw5gnNO3ZtSYhdbbGTwdPPBz5nN6xC+83FgcyzDEghT2455MCy2/ocZBPh1QmMvOhXR7xHjj
 69B6+jxoWfe/SyhSRIrCb8dwAXpE3/dwkevA==
X-Received: by 2002:a05:600c:4e05:b0:483:612d:7a9a with SMTP id
 5b1f17b1804b1-485197d632emr34867075e9.0.1772630140655; 
 Wed, 04 Mar 2026 05:15:40 -0800 (PST)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851a8e2413sm13651335e9.10.2026.03.04.05.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 05:15:40 -0800 (PST)
Message-ID: <30b74e76-b0f7-48cd-af60-96c684023d7e@lowrisc.org>
Date: Wed, 4 Mar 2026 13:15:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one
 peripheral for it (alert handler)
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "amitkh@google.com" <amitkh@google.com>,
 "qemu-maintainers@lowrisc.org" <qemu-maintainers@lowrisc.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dave@treblig.org" <dave@treblig.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <177159976712.8279.7732381632410882915-0@git.sr.ht>
 <36bd4a3d40459f183e6768313c790434e0240f4d.camel@wdc.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
In-Reply-To: <36bd4a3d40459f183e6768313c790434e0240f4d.camel@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Wx42ICOmw04E0ag2eH9LY7U9"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Wx42ICOmw04E0ag2eH9LY7U9
Content-Type: multipart/mixed; boundary="------------Fy3ne71WL3jxxyvcBCficDh0";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "amitkh@google.com" <amitkh@google.com>,
 "qemu-maintainers@lowrisc.org" <qemu-maintainers@lowrisc.org>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "dave@treblig.org" <dave@treblig.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
Message-ID: <30b74e76-b0f7-48cd-af60-96c684023d7e@lowrisc.org>
Subject: Re: [PATCH qemu 00/11] Introduce ot-earlgrey machine, and one
 peripheral for it (alert handler)
References: <177159976712.8279.7732381632410882915-0@git.sr.ht>
 <36bd4a3d40459f183e6768313c790434e0240f4d.camel@wdc.com>
In-Reply-To: <36bd4a3d40459f183e6768313c790434e0240f4d.camel@wdc.com>

--------------Fy3ne71WL3jxxyvcBCficDh0
Content-Type: multipart/mixed; boundary="------------6lJiMI3m7mHTKVt5GfVRi9sH"

--------------6lJiMI3m7mHTKVt5GfVRi9sH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMDIvMjAyNiAwMDoxOSwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gSSB0aGlu
ayB3ZSBzaG91bGQganVzdCB1c2UgdGhlIGV4aXN0aW5nIE9wZW5UaXRhbiBtYWNoaW5lIGlu
c3RlYWQgb2YNCj4gYWRkaW5nIGEgbmV3IG9uZQ0KDQpKdXN0IGEgcXVpY2sgbWVzc2FnZSB0
byBzYXkgdGhhdCBJIGFtIHdvcmtpbmcgb24gdGhpcywgYnV0IGl0J3MgdGFraW5nIA0Kc29t
ZSB0aW1lLCBhbmQgbWlnaHQgY2hhbmdlIHdoYXQgb3JkZXIgSSB3YW50IHRvIHVwc3RyZWFt
IHRoZXNlIGNoYW5nZXMgaW4uDQoNCkkgbGlrZWx5IG5lZWQgdG8gYWJhbmRvbiB0aGlzIHBh
dGNoIHNldCBhbmQgc2VuZCBhbiBhbG1vc3QtZW50aXJlbHkgbmV3IA0Kc2V0IGxhdGVyLg0K
DQpUaGFua3MhDQoNCkxleC4NCg0K
--------------6lJiMI3m7mHTKVt5GfVRi9sH
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsDNBGlk2ScBDAC1hE3kA783wihbPYaF+9u8OHqzVVq75fboAha+9EUZ7cx55XJb
OTkmUR1emuyerVG0RdCXa95J2isEfq4Rl+j7pvAR2MhRp8uDZlOInV0+1uW4xa/I
nfiZ/r5rM4WUtySt1ok/0Ix9BV7rUP1jzLkSe3u1kDlFdZnkt4iIjWpQbzsNy7/K
G604ZXs6BsrOkDU20YB4TCeCg0JOHSQdzg155LH/fJWzyNQHmJnSZk8Slp/7OJLC
FZfDJT5XtxAAhYxwkkNAxDMNM+P2waFujhinWwejkAl8wo6yoGxz4lANM0StvUJ0
8+V/w5YfLjDGBTzclN9UTr+nuOhJ8uMOeM4mQARop+vMdKve90jeqrLr078pwmtr
IquzG9XFbpBrDqa4M+wiZtdwyEWTkcV5Sxef3Crm49V4a2Qn7gaCXCb8XU7g1UOa
eXDvFxA2tB/6Vv3ox0lquWVh3Wg8HWWbuk1u/vaihC+c8eR7Ok4mUQP4dM5G3M4C
J9+aL0nUbgX79NUAEQEAAc0jTGV4IEJhaWxleSA8bGV4LmJhaWxleUBsb3dyaXNj
Lm9yZz7CwQcEEwEIADEWIQSrqBHVGPsUIhGgMJV8uyDUC1VYLAUCaWTZJwIbAwQL
CQgHBRUICQoLBRYCAwEAAAoJEHy7INQLVVgs1RsL+wSZyKki5agYN3lBkozL29EG
AI0NKzkJgA2xn8PnC9XNvy3sNzJ8Z84f7k33cY4maR17oa+SQ9+lkK0+L2BNm2hG
7nqaQJ0EmOePzwldxhUBGYbVQiUnb316RTUM/iCooFTrcNKhBKFSVdgWTkeQAPK/
rg8AZH2PqSEH+8pcRE/0mW0u3TjO2wutp3WLYIJ4JqU529uw4lTCQ4l+hpcXLI2Y
JtDiVCYIwEZ3ExtUJD3RC5yccHAj5s+wY8TtPwVnfvKBzgbmeB5l05zHQQpf17bj
Cus/0zbmeN3EpZMpnETUlbCMLzx8U5ySlAQIQxubQeiRqOvtJLUsuWA3pm0IiVS9
PLZiaVNqhDYuxXM6jwFX1nRGqOktfd8IlPvEBaMfNf/Vi9mqQU26Y7aNXkF49Nxe
j0dhsuQhBCRXBAlSt0/N7xu7CFfFj+R+5izKGYnIsgI1dyubwASgcEVzOUfRbMls
Z+pT8kktdnUaM382sNiM4lNIHBDsjP5hecu961xepM7AzQRpZNkoAQwAv1unf9+A
eYoPGctWdDBhFdEDFNGga4NhrS+a4L86GFj4AyQjfS1CmP0Nvo6iyB+FAXQCpDEZ
L/EM81OtBBXDvhfw1nx+2KkGcRD9+APEOZqvgE44qgITwpA2ZbRhoAq2USmmYhsS
qb1X/rQr8MHtp3FxKJESFIpObo6oFkRttmM/UE07foX6pugT5blkIfDzM3Biiv/5
umBOtFB6xaNxYBI6PQ8gJOs6JBFE8NlUmSQstrVfm+QnUtMjnfQnUVoPqINCDk/H
UR2Y86c050PXDEwNnxEhdhE3i3Np08Her900BhpRPys3b6rnPXw8BsoIiLbTFABO
NC9mpEhOK7ELVYro4qYZYCue+GSbv7gjhchYyJXS9BlEjFYGkLbWCAunRo1ztywq
vNtENDlv8woJHRQd5Pw2FFoBRF8Y48IV7rpSCi7GkQ1NuhvayQ/P42lddqKhPaca
aOsHjBazjFqWeSGwVTDsKMwwVfqNbur0WKUpjtO9HTdBPWF0leP6uMK/ABEBAAHC
wPYEGAEIACAWIQSrqBHVGPsUIhGgMJV8uyDUC1VYLAUCaWTZKAIbDAAKCRB8uyDU
C1VYLJHiC/9VswW/tu9vnMP+3p1w3Kd3nCaSj6/KCfQU+sskLT+kafH/hSISBhvC
hns6jUO6cLGTikqrqdqkvsdDKnUVyym9DtE+uh7gmHgQus+3ePRFyr85Oaurvb3A
+FIsF9tKW8JX/V0pUMDiwVa6mcBf94NvgtU+zi5jgl57qgA5S/bm76ws9PBUpjN7
NWTqAJajMtGHIl049hm31HTacYVaD84mP+LKxiqXGqcIy2qvjFdNOiKwupnluERe
ZfQ+ppWRZ/rW41x5Tg7UF/CkC/F8CB9sFocGWl6qWZjB6SOioFZ5E6vNgfUsMqlq
C5uefUb7+Hsi0/avR7gA47EnJLQw6MRii+0RxyvPa3jstm20967pqFlBAldKPXQB
f4to5KEBRzTiGXLQJRfPTbq4krpqyIyzRAZONxiLQbU7XW5yUdkaDRI52M/txz3O
aykHK+f7rKw0/491S2jNzrLe00hWmNeoFnGq4+QpqNO58uAPyRLOcr+m9f2ktpDv
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------6lJiMI3m7mHTKVt5GfVRi9sH--

--------------Fy3ne71WL3jxxyvcBCficDh0--

--------------Wx42ICOmw04E0ag2eH9LY7U9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmmoMHoFAwAAAAAACgkQfLsg1AtVWCyq
aQwAq7aNnMs6hH6U2O4BX6jWu3E1neK0t8yVABp94ZafvFPiF3K5/OxFnpW2r8DeReneqfTs9Bgq
gwVr5utioxGx4dcZ026b9rub92+9ULwLzrNYULUIc3vHG/IAlSc2Mfp4a8eGPhkC4RFKu7zVqBZH
wdZvdB0dDRWHnmCx5cNlfHh82So7A7LT2ApNEzjrUx5gZepuWGTQRrRPpXQQ9yZy8mFrQl063/cL
wQGYUtLCBMpiA7g0ZD5VOK96tWqna+aXrwnXG+mP7Kio/60juiCtd5eOWqul07/e9uOR+6HEmkkE
HlBWYMbfXtGLZYxq+CuHw7CGIkZvnV2pPmucD5AAmSdzZ2loV9rFdETUxIxx4q/EPKWx8/xzXIMS
/yTvd+b13Ex8XdKFcZB+Ol93ct6hQW8W74vKe8LDQx9GGkC5k8QnBYfsrDvcRUOjsqwdJ6eXYWXr
zKTB0fZIhKBUumuqZ6mB0HbCTFnHOn6JoVmoaoWJ5vujGtUUvuKG9u7TNYoM
=Slsy
-----END PGP SIGNATURE-----

--------------Wx42ICOmw04E0ag2eH9LY7U9--

