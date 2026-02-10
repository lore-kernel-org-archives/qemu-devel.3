Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD7EA8118
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoB1-0004ub-Qz; Tue, 10 Feb 2026 08:53:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vpl9G-0005sD-CQ
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:39:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1vpl9E-00079S-CV
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 05:39:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso54415505e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 02:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1770719950; x=1771324750; darn=nongnu.org;
 h=subject:autocrypt:from:to:content-language:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j4u4jx+TBCNuJcACushS/Gzb1AaQ+JEszJ2IhWidFhs=;
 b=gq614ze6TSxNHgc35x3EfflVbcsRBDnX6Flo7hFCcoYr57vTVJt+LFo8+daZ8Q7yoc
 unQMtYKq778ie+eXm9UVyspq6qO8JehUh/hNsjTA02n2QyGHbFDLqonUIMFTtxu54iZR
 BKmJ87Hatd+iUzijUjmPgKYy/TEK1WiZrwIamzm17tLi//q0tlyI7ThCcS/qRHwtyoSZ
 QrLrkOR75OiFYJ5JjeD2s4makfbA9hSU0bQt65qA7saMnbTfothgfdwblAUJ2RoAAlBy
 AlC1o3yvz96I39b5h6yULcu60/bk1iEewsV8jZl2uu29PwKU00xA3Zg2ajUk1E09o1QC
 KnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770719950; x=1771324750;
 h=subject:autocrypt:from:to:content-language:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4u4jx+TBCNuJcACushS/Gzb1AaQ+JEszJ2IhWidFhs=;
 b=mGGk2PHxU+ez6X2Q0cBFiNn+tPyWq4JkSfuyo+RAKDF71yyopbBBRX63rC4BkUh4Fj
 KIpOm5U9dpzb1FJNMuhmbf+0zRiUsFyLbziOcvqEjfs50JHIaWnjix8NYio3P71qLOxs
 LqK3qbcnvKV3o4qS+uPA6bwjozT3Vp+JCtezoJpt+eNrlWhKEBbKOBoTjlLa6Zcl7KFQ
 IDCaY7SoV4X4uYKllUIqCEazsd9F4+Z9/SkiaTsuIXYezspm77L4ichqpbrrvGCIQ0FW
 Hc7UwQC7WkU1EJI9v6+WVwp4JCstcN5a3xyiA/PKMAkVXykHPw8UU5QMM87c9BKbhFpp
 ifmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNyQbhza+K/600z5YWb27hhMfygt6op7bIiZoO3ZF2fKklBFz2TXGCDHVJIw6HlmK5yMiMj8r5GAAE@nongnu.org
X-Gm-Message-State: AOJu0Yy2nhO6xQSsHhZiLNVfH7Fzaiw1HsXB4FHO7iFKkM5F1sgZczmS
 yT12hcvyzgX5n6rSFu7l1kK7JPo2xgZjhg+Uarw17ktVCQjlgoOvIyGDhImq4bs2zeo=
X-Gm-Gg: AZuq6aK2Wae/Cv1SgALn1QZrU7YaRwFG7XZEx8K2H8u+3+xZVth0Qg8HLNeEqxNE+9Q
 Ngpc122uPFlknvbQZhgdjfbvhnsRJmUWVGYSxDgc+S1t3cEPO494Agmq4xlgGQ0fZ4geklxQO7L
 ZzVRiBrpAu5aIQnFDXXTL3OZwSS3wlgbp0LRX7M7iPe0ZUkq2vVb3x3Ip6HFE38ClOKekt8X02y
 3brRAs4Sz7ajCDA4BGF2M3tcvcIekfparQdPt+bsD9TixvaZv3OUCgS+FnSUnb3O7l1ZswsOBg/
 BcQX5iAqJdRLweu1NZx7oGTbBoiPlgN1tiVC+P2p/veSmA84BDOUsbIqORjva4EkhT/QHUB1tl6
 K6Ot3qVCqE/f3GfpTe6Cll3/2o8v2gMqYcfPgg30zzZKjpf03KR129SzqsOEq74e5Rf92GXHdRK
 EudYZnZXIPQoTG7QLQHwqz481RAe7+vzxM
X-Received: by 2002:a05:600c:548f:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483505451c0mr24046785e9.13.1770719949675; 
 Tue, 10 Feb 2026 02:39:09 -0800 (PST)
Received: from [192.168.102.59] ([217.155.172.86])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm54013345e9.7.2026.02.10.02.39.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 02:39:09 -0800 (PST)
Message-ID: <dc38df7f-698e-44d2-ae21-e2b3e2fe76cc@lowrisc.org>
Date: Tue, 10 Feb 2026 10:39:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
Subject: Upstreaming OpenTitan Earlgrey into QEMU
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0RM2EJ8G19BsykyYrzrcIxHY"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Feb 2026 08:53:13 -0500
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
--------------0RM2EJ8G19BsykyYrzrcIxHY
Content-Type: multipart/mixed; boundary="------------IjScvtdc0rTPVO9oBPQo01gG";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: alistair23@gmail.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Message-ID: <dc38df7f-698e-44d2-ae21-e2b3e2fe76cc@lowrisc.org>
Subject: Upstreaming OpenTitan Earlgrey into QEMU

--------------IjScvtdc0rTPVO9oBPQo01gG
Content-Type: multipart/mixed; boundary="------------zXPznCaUH6D8x5ozRkIC8zf2"

--------------zXPznCaUH6D8x5ozRkIC8zf2
Content-Type: multipart/alternative;
 boundary="------------0BbJZ9Wb1q4005lIlyMpZsb0"

--------------0BbJZ9Wb1q4005lIlyMpZsb0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

RGVhciBRRU1VIHJpc2MtdiBtYWludGFpbmVycywNCg0KDQpXZSAobG93UklTQykgd291bGQg
bGlrZSB0byBjb250cmlidXRlIE9wZW5UaXRhbiBjaGFuZ2VzIHRvIFFFTVUgZnJvbSBvdXIg
DQpmb3JrIGludG8gdGhlIHVwc3RyZWFtIHByb2plY3QuIFRoZXNlIGNoYW5nZXMgaW50cm9k
dWNlIGEgbmV3ZXIgDQpPcGVuVGl0YW4gRWFybCBHcmV5IG1hY2hpbmUgdGhhdCB3b3VsZCBi
ZSB1cCB0byBkYXRlIHdpdGggdGhlIE9wZW5UaXRhbiANCjEuMCByZWxlYXNlLg0KDQoNCldl
IHdvdWxkIGxpa2Ugc29tZSBhZHZpY2Ugb24gdGhlIHByYWN0aWNhbGl0aWVzIG9mIGRvaW5n
IHRoaXMsIGFuZCBhbnkgDQp3YXlzIHRoYXQgd2UgY2FuIG1ha2UgaXQgZWFzaWVyIGZvciB1
cHN0cmVhbSB0byByZXZpZXcuDQoNCg0KVGhlcmUgYXJlIGEgbG90IG9mIGNvbW1pdHMgcmVx
dWlyZWQgdG8gaW50cm9kdWNlIHRoZSBuZXcgbWFjaGluZS4gDQpDdXJyZW50bHkgdGhlcmUg
YXJlIGFib3V0IDE4MDAsIGJ1dCB0aGF0IG51bWJlciB3aWxsIHJlZHVjZSBhcyBJIHJlbW92
ZSANCnNvbWUgdGhpbmdzIHdlIGRvbid0IGFjdHVhbGx5IG5lZWQsIGFuZCBwZXJoYXBzIGFs
c28gc3F1YXNoIHNvbWUgcnVucyBvZiANCnNtYWxsL3RyaXZpYWwgY29tbWl0cyBpbnRvIG1v
cmUgcmVhc29uYWJseSBzaXplZCBjb21taXRzLiBJIHN0aWxsIGV4cGVjdCANCmEgc3Vic3Rh
bnRpYWwgbnVtYmVyIG9mIGNvbW1pdHMsIGJ1dCBJJ20gaGFwcHkgdG8gc3F1YXNoIHRoZW0g
YXMgbXVjaCBhcyANCnVwc3RyZWFtIHJldmlld2VycyB3b3VsZCBwcmVmZXIuIEknZCBsaWtl
IHRvIGtub3cgaG93IHlvdSdkIGxpa2UgdXMgdG8gDQphcHByb2FjaCB1cHN0cmVhbWluZyB0
aGVzZSBjaGFuZ2VzLg0KDQoNCkFsaXN0YWlyLCB5b3UgYWR2aXNlZCB1cyBwcmV2aW91c2x5
IHRoYXQgd2Ugc2hvdWxkIGFkZCB0ZXN0IGNhc2VzIGZvciANCnRoZSBuZXcgY29kZS4gSSBh
bSBpbiBmYXZvdXIgb2YgYWxsIHRoZSBuZXcgY29kZSBiZWluZyB0ZXN0ZWQsIGhvd2V2ZXI6
DQoNCg0KT3VyIHRlc3QgcHJvZ3JhbXMgZXhwZWN0IGxvdHMgb2YgcGVyaXBoZXJhbHMgdGhh
dCBhcmUgYWRkZWQgaW4gbGF0ZXIgDQpjb21taXRzIGluIG91ciBicmFuY2guDQoNCg0KV2Ug
d2lsbCBhbHdheXMgYmUgYWJsZSB0byBydW4gdGhlIHRlc3RzIG9uIG91ciBmb3JrIGF0IGFu
eSB0aW1lIGR1cmluZyANCnRoZSB1cHN0cmVhbWluZyBwcm9jZXNzLCBhbmQgb25seSBzb21l
IG9mIHRoZXNlIHRlc3RzIGFyZSBpbiBhIGZvcm0gdGhhdCANCmNhbiBiZSB1cHN0cmVhbWVk
IHdpdGhvdXQgc2lnbmlmaWNhbnQgY2hhbmdlcy4gVGhlc2Ugd2lsbCBvbmx5IHdvcmsgb24g
DQp0aGUgdXBzdHJlYW0gdmVyc2lvbiBvbmNlIG1vc3Qgb2Ygb3VyIGNoYW5nZXMgYXJlIHVw
c3RyZWFtLiBXaGF0J3MgdGhlIA0KY3VycmVudCBiZXN0IHByYWN0aWNlIGZvciB0ZXN0aW5n
IHRoZXNlIGRldmljZXMgaW4gUUVNVT8NCg0KDQpUaGFua3MhDQoNCkxleCBCYWlsZXkgKGxv
d1JJU0MpDQoNCg0K
--------------0BbJZ9Wb1q4005lIlyMpZsb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"
      id=3D"docs-internal-guid-a117c138-7fff-6c87-6d48-f060380a0701"><spa=
n
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">Dear QEMU risc-v maintainers,</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">We (lowRISC) would like to contribute OpenTitan changes to QEMU from o=
ur fork into the upstream project. These changes introduce a newer OpenTi=
tan Earl Grey machine that would be up to date with the OpenTitan 1.0 rel=
ease.</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">We would like some advice on the practicalities of doing this, and any=
 ways that we can make it easier for upstream to review.</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">There are a lot of commits required to introduce the new machine. Curr=
ently there are about 1800, but that number will reduce as I remove some =
things we don't actually need, and perhaps also squash some runs of small=
/trivial commits into more reasonably sized commits. I still expect a sub=
stantial number of commits, but I'm happy to squash them as much as upstr=
eam reviewers would prefer. I'd like to know how you'd like us to approac=
h upstreaming these changes.</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">Alistair, you advised us previously that we should add test cases for =
the new code. I am in favour of all the new code being tested, however:</=
span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">Our test programs expect lots of peripherals that are added in later c=
ommits in our branch.</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">We will always be able to run the tests on our fork at any time during=
 the upstreaming process, and only some of these tests are in a form that=
 can be upstreamed without significant changes. These will only work on t=
he upstream version once most of our changes are upstream. What's the cur=
rent best practice for testing these devices in QEMU?</span></p>
    <br>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">Thanks!</span></p>
    <p dir=3D"ltr"
      style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt;"><span
style=3D"font-size: 11pt; font-family: Arial, sans-serif; background-colo=
r: transparent; font-weight: 400; font-style: normal; font-variant: norma=
l; text-decoration: none; vertical-align: baseline; white-space: pre-wrap=
;">Lex Bailey (lowRISC)</span></p>
    <p><br>
    </p>
  </body>
</html>

--------------0BbJZ9Wb1q4005lIlyMpZsb0--

--------------zXPznCaUH6D8x5ozRkIC8zf2
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

--------------zXPznCaUH6D8x5ozRkIC8zf2--

--------------IjScvtdc0rTPVO9oBPQo01gG--

--------------0RM2EJ8G19BsykyYrzrcIxHY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmmLCswFAwAAAAAACgkQfLsg1AtVWCw1
lwwAoKTw5Zix3OvBzC1D/v899DfJAtSx2XwXIYfr45z3V7F6UsGhqBN12bTWM95PG0joTpe+LqBb
Glus+1rzRCzVEFWJhFsK/ixN9bthkbZUm2zg8aXnEch1Uiw62KBcvxJc1pW6SFHpXqW6sMBVlSz5
wDWU16buAR7C6HUVw9dzi6caLN9//CoKa93qsjA/gk4g4WH6lukZ7ZIeHmoQtzyR9qMsc41DW2LW
LmUv0SbuM0cuKKQyMEZoBTmeOphgkSQ5Z392Eq2ac8HQCcoJ/6aQOl3BEy/znLJ0onx/MMPwMxTf
B5EBJYhD3G8tnvrEvNaTbCEfvq2rEZNm+iCsWPXcwHmBKeqqMsezz14qmwcyd/c5Jq6zN8dIbAlF
0s3TQGGneK3oGIMGhay6Ka2PMu+lcM2YaDErAUtwkBtrhXKXn8q30on5ziSKSnr9vs2PHIpOOmw+
NKHKmNZrALhw4V2Yv7/WSye8JoOTUOgM8J1UBgi5DBRqudZcebf9fVtP63IZ
=uRQ1
-----END PGP SIGNATURE-----

--------------0RM2EJ8G19BsykyYrzrcIxHY--

