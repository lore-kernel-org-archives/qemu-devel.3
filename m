Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46361E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 19:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJdzB-0001QW-Km; Fri, 06 Dec 2024 14:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdye-0001EN-II
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:27:06 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJdyb-0004aB-AV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 14:27:00 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2153e642114so25036105ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733513216; x=1734118016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMwF9SLqPGjM1E/HdTX+ETbtfRkZC2X7sGkmZnV+kC4=;
 b=C2BjJ4cYoNJ26Lx1vlAkdpgcahr8bxJZ6pCguc09rZlRb/5MBwIVkZ1H0jukGkaLVi
 YrtQ1Bw9ncnYb2wAMdxeLMSbbPplWPdrBv3vNMy4jpkn2HZjYWc3METDKpyraDh9ZhKO
 3bh3ZLrDI+0PVkvgWnUcT11c3NyDDWrxoRL8xva6rGAVswN3dsT1CpLklGq7Koo3c9wF
 T6TycYFGJHmEltuKqn3BjFZ2363uO+1z6mc2C8KVmQBRrbTZRuLMUBVE9VxqvkvnQ99y
 JZ8q7c3pcgtQSQ+J+Wib2JgT70avdln6bh3jKIDdimzgaxPKb8MNn5xPES7qir++kyU1
 JhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733513216; x=1734118016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMwF9SLqPGjM1E/HdTX+ETbtfRkZC2X7sGkmZnV+kC4=;
 b=mFPxylmAnMqWW8jaQmOOztlF5afjn54gVqQwHmPaZUAQeIg6yh7jChJavVcAVLG5QK
 21vp1fPFqM1bwTjggslaur6Xl56ItAP9xvIqtAsegLAQ/rdka4QZVHRAp9yhQDsxnS4X
 jHpIqQ6rdT+010ypUXR3sYNkwdPzunYbEWlyA5aVj6oMxaVLqKOC4CoLngsXak7RygBy
 7i+4IrH3rHTZGQOkmayUvyDUaBvqxJbUctHjKA9+3nZzOmKXbcsb0Vz8MXEwDs6XlGuJ
 mWRJSF2EWI+n6C4UG1cQV2aVQkQ6GAyqqcutGM4qM/rCZtKYSVCQ+CK5SNbiRawBiWQp
 JXpA==
X-Gm-Message-State: AOJu0YxtZmIjG97gkXUIkPE+Ug4BizKG7d4IWugUmTYBgJh4ae9cqOG9
 vJwpgcSNJk9pZBvp++JYTYm1qRyzQd0xLzRnKEDjHUHWeDkQ6SmwcNDeLZKRC4Y=
X-Gm-Gg: ASbGnct9Vl9aC0xYi0xFG8pC9Uv/jJaqgI0xek+U14QE8e0bpBtzWXgtJuh+vjkpq9D
 540w0CQQxdpuqWqI9GZtQJXwNkQIz1v4oCKOO2c6qNNwJ08xYEdPdcLVDs3c3oe6opyUVDwin6x
 imalXOjfimLK8gku2XGKV/Q5NqKstXpJASLEpnWKRcG6JGBnOnjirFR0mTVBNjFFHuKmaw6B7iB
 zPp9bO2YeAaupsACiHXkANa4zA1QhyRrpDZuLIXrPYU3slSd92DyPgJ448NmNF54z+dq7VS8i/j
 8WX3GsRTteDcGtKc0fngHA==
X-Google-Smtp-Source: AGHT+IFtQzoablaV/fkyMB1On+zS7wGBLoc+5w1r+VCeAXLS+UwPM3AEv/oBq7mX+gS5VUKktxf/SA==
X-Received: by 2002:a17:902:cecc:b0:215:5bd8:9f92 with SMTP id
 d9443c01a7336-21614d1d048mr54530595ad.5.1733513215661; 
 Fri, 06 Dec 2024 11:26:55 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8f3182dsm32051855ad.234.2024.12.06.11.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 11:26:55 -0800 (PST)
Message-ID: <4eb74dd5-ad1a-44fd-b8b4-39a119df29e4@linaro.org>
Date: Fri, 6 Dec 2024 11:26:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] docs/devel: add git-publish for patch submitting
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 gustavo.romero@linaro.org, Andrew Melnychenko <andrew@daynix.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org
References: <20241205222241.3789437-1-pierrick.bouvier@linaro.org>
 <20241205222241.3789437-3-pierrick.bouvier@linaro.org>
 <Z1LgpKB_J4Df4wcE@redhat.com>
 <CAFEAcA-WadSi-U+Q9MFY_+vhNimJ1HpCcSZE7aVz3PRKuwc+ew@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-WadSi-U+Q9MFY_+vhNimJ1HpCcSZE7aVz3PRKuwc+ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMTIvNi8yNCAwMzo0MywgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gRnJpLCA2IERl
YyAyMDI0IGF0IDExOjMyLCBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQu
Y29tPiB3cm90ZToNCj4+DQo+PiBPbiBUaHUsIERlYyAwNSwgMjAyNCBhdCAwMjoyMjozN1BN
IC0wODAwLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0N
Cj4+PiAgIGRvY3MvZGV2ZWwvc3VibWl0dGluZy1hLXBhdGNoLnJzdCB8IDE5ICsrKysrKysr
KysrKysrKysrKysNCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspDQo+
Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZG9jcy9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2gucnN0
IGIvZG9jcy9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2gucnN0DQo+Pj4gaW5kZXggMDNiMmFj
Mjk4YWEuLmY4YjdmYzU5NTQ0IDEwMDY0NA0KPj4+IC0tLSBhL2RvY3MvZGV2ZWwvc3VibWl0
dGluZy1hLXBhdGNoLnJzdA0KPj4+ICsrKyBiL2RvY3MvZGV2ZWwvc3VibWl0dGluZy1hLXBh
dGNoLnJzdA0KPj4+IEBAIC0yMzUsNiArMjM1LDI1IEBAIHRvIGFub3RoZXIgbGlzdC4pIGBg
Z2l0IHNlbmQtZW1haWxgYCAoYHN0ZXAtYnktc3RlcCBzZXR1cCBndWlkZQ0KPj4+ICAgd29y
a3MgYmVzdCBmb3IgZGVsaXZlcmluZyB0aGUgcGF0Y2ggd2l0aG91dCBtYW5nbGluZyBpdCwg
YnV0DQo+Pj4gICBhdHRhY2htZW50cyBjYW4gYmUgdXNlZCBhcyBhIGxhc3QgcmVzb3J0IG9u
IGEgZmlyc3QtdGltZSBzdWJtaXNzaW9uLg0KPj4+DQo+Pj4gKy4uIF91c2VfZ2l0X3B1Ymxp
c2g6DQo+Pj4gKw0KPj4+ICtVc2UgZ2l0LXB1Ymxpc2gNCj4+PiArfn5+fn5+fn5+fn5+fn5+
DQo+Pj4gKw0KPj4+ICtJZiB5b3UgYWxyZWFkeSBjb25maWd1cmVkIGdpdCBzZW5kLWVtYWls
LCB5b3UgY2FuIHNpbXBseSB1c2UgYGdpdC1wdWJsaXNoDQo+Pj4gKzxodHRwczovL2dpdGh1
Yi5jb20vc3RlZmFuaGEvZ2l0LXB1Ymxpc2g+YF9fIHRvIHNlbmQgc2VyaWVzLg0KPj4+ICsN
Cj4+PiArOjoNCj4+PiArDQo+Pj4gKyAgICAkIGdpdCBjaGVja291dCBtYXN0ZXIgLWIgbXkt
ZmVhdHVyZQ0KPj4+ICsgICAgJCAjIHdvcmsgb24gbmV3IGNvbW1pdHMsIGFkZCB5b3VyICdT
aWduZWQtb2ZmLWJ5JyBsaW5lcyB0byBlYWNoDQo+Pj4gKyAgICAkIGdpdCBwdWJsaXNoDQo+
Pj4gKyAgICAkIC4uLiBtb3JlIHdvcmssIHJlYmFzZSBvbiBtYXN0ZXIsIC4uLg0KPj4+ICsg
ICAgJCBnaXQgcHVibGlzaCAjIHdpbGwgc2VuZCBhIHYyDQo+Pj4gKw0KPj4+ICtFYWNoIHRp
bWUgeW91IHBvc3QgYSBzZXJpZXMsIGdpdC1wdWJsaXNoIHdpbGwgY3JlYXRlIGEgbG9jYWwg
dGFnIHdpdGggdGhlIGZvcm1hdA0KPj4+ICtgYDxicmFuY2huYW1lPi12PHZlcnNpb24+YGAg
dG8gcmVjb3JkIHRoZSBwYXRjaCBzZXJpZXMuDQo+Pg0KPj4gTGV0cyBhbHNvIG1lbnRpb24N
Cj4+DQo+PiAgICAiV2hlbiBzZW5kaW5nIHBhdGNoIGVtYWlscywgJ2dpdCBwdWJsaXNoJyB3
aWxsIGNvbnN1bHQgdGhlIG91dHB1dA0KPj4gICAgIG9mICdzY3JpcHRzL2dldF9tYWludGFp
bmVycy5wbCcgYW5kIGF1dG9tYXRpY2FsbHkgQ0MgYW55b25lIGxpc3RlZA0KPj4gICAgIGFz
IG1haW50YWluZXJzIG9mIHRoZSBhZmZlY3RlZCBjb2RlLiBHZW5lcmFsbHkgeW91IHNob3Vs
ZCBhY2NlcHQgdGhlDQo+PiAgICAgc3VnZ2VzdGVkIENDIGxpc3QsIGJ1dCB0aGVyZSBtYXkg
c29tZXRpbWVzIGJlIHNjZW5hcmlvcyB3aGVyZSBpdCBpcw0KPj4gICAgIGFwcHJvcHJpYXRl
IHRvIGN1dCBpdCBkb3duIChlZyBvbiBjZXJ0YWluIGxhcmdlIHRyZWUtd2lkZSBjbGVhbnVw
cyksDQo+PiAgICAgb3IgYXVnbWVudCBpdCB3aXRoIG90aGVyIGludGVyZXN0ZWQgcGVvcGxl
Ig0KPj4NCj4+IFNlY29uZCwgbGV0cyBzYXkgc29tZXRoaW5nIGFib3V0IHB1bGwgcmVxdWVz
dHMNCj4+DQo+PiAgICAiV2hlbiBhIHN1YnN5c3RlbSBtYWludGFpbmVyIGlzIHJlYWR5IHRv
IHNlbmQgYSBwdWxsIHJlcXVlc3QsIHRoZQ0KPj4gICAgICdnaXQgcHVibGlzaCAtLXB1bGwn
IGNvbW1hbmQgd2lsbCB0cmlnZ2VyaW5nIEdQRyB0YWcgc2lnbmluZywNCj4+ICAgICBwdWJs
aXNoIHRoZSBicmFuY2ggdG8gdGhlIGdpdCByZW1vdGUgbmFtZSBzcGVjaWZpZWQgYnkgdGhl
DQo+PiAgICAgJ3JlbW90ZS5wdXNoRGVmYXVsdCcgY29uZmlnIG9wdGlvbiwgYW5kIHNlbmQg
dGhlIGVtYWlsIHNlcmllcycNCj4gDQo+IFdlIGRvbid0IGRvIHB1bGwgcmVxdWVzdHMgZm9y
IHRoZSBub3JtYWwgImVuZCBkZXZlbG9wZXIgc3VibWl0cw0KPiBhIHBhdGNoIiBwcm9jZXNz
LCBhbmQgZ2l2ZW4gdGhlIHByZXZhbGVuY2Ugb2YgdGhlIGdpdGh1Yi9naXRsYWINCj4gImFs
bCBjb250cmlidXRpb25zIGdvIGluIGFzIHB1bGwgcmVxdWVzdHMiIG1vZGVsLCBJIHRoaW5r
IHRoYXQNCj4gdGFsa2luZyBhYm91dCBwdWxsIHJlcXVlc3RzIGhlcmUgKGV4Y2VwdCB0byBz
YXkgIndlIGRvbid0IGRvIHRoZW0iKQ0KPiB3b3VsZCBiZSBjb25mdXNpbmcuIElmIHdlIHdh
bnQgdG8gZG9jdW1lbnQgaG93IHlvdSBjYW4gdXNlIGdpdCBwdWJsaXNoDQo+IGZvciBwdWxs
IHJlcXVlc3Qgc3VibWlzc2lvbiB3ZSBjYW4gZG8gdGhhdCBpbg0KPiBkb2NzL2RldmVsL3N1
Ym1pdHRpbmctYS1wdWxsLXJlcXVlc3QucnN0Lg0KPiANCg0KVGhpcyBwYWdlIHJlY29tbWVu
ZHMgdXNpbmcgYW4gYWx0ZXJuYXRpdmUgc2NyaXB0IFsxXS4NCg0KSSdsbCBsZXQgeW91IG9y
IERhbmllbCBkZWNpZGUgd2hpY2ggb25lIHNob3VsZCBiZSB1c2VkIChnaXQtcHVibGlzaCB2
cyANCm1ha2UtcHVsbHJlcSkgYW5kIHVwZGF0ZSBhY2NvcmRpbmdseSB0aGUgY29uY2VybmVk
IHBhZ2UuDQoNClsxXSANCmh0dHBzOi8vZ2l0LmxpbmFyby5vcmcvcGVvcGxlL3BldGVyLm1h
eWRlbGwvbWlzYy1zY3JpcHRzLmdpdC90cmVlL21ha2UtcHVsbHJlcQ0KDQo+IHRoYW5rcw0K
PiAtLSBQTU0NCg0K

