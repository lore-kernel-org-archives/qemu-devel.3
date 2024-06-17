Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3415DC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 23:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJLql-0002lJ-0f; Mon, 17 Jun 2024 19:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sJLqi-0002ks-Dp
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 19:33:21 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sJLqf-0001MU-AX
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 19:33:19 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-371c97913cdso18825785ab.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718667195; x=1719271995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0a1ZYorgcg010ZoIr308vVeErzWc+Km9FWDAGHpFWU=;
 b=TDQBef67U/vpk0s7RrMEA9hvIMaof0HnixeQgCXYZe7IekBB8yB5orhtsdH3bn0Nj4
 eEIhmreCxWQYo2B82QY56IWI4jzKHckYCQ/D4zRRUdqndx9+/bjz9GEHsiU8bcDb2BFh
 1W0sVeOi6iCqmy9j7FY3xfdgHb2JwoIXgI9ygs6/pmC5HCfr9HKHoS+hTqWbLJClycGI
 xrzzU3tjnc1AfOy1SCW0So4OkJamD6gnxDp8g8zot4mZaCaucBEzrdDm6IKevmIrdC5l
 e65p3zRZ9LT9sWH3oHHyt1OHWobvs4wJZF+Cm802lBCydV6WyzHaunPv5O102D5Upnqx
 nvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718667195; x=1719271995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0a1ZYorgcg010ZoIr308vVeErzWc+Km9FWDAGHpFWU=;
 b=D4Ax+9Fq2Kj2NSTtcAlR/72m++/7YySzU8FnQj5evqHoQwrr8XaDlxtjQa3b3/QeOI
 fA9NoVplCkuqyLSduEuALPhLq/SPA5htC5mBlqyjR2O11HNL1iYWo+EHN6h88Ehx69KS
 8Bdsi1VHXOpGJLN6xKTNHpX+uGy0S4zCs33YVH3J0kKX1N6izcdvmAyC7dZV2yIomwHW
 j/Wi07nBQwgW3wh8L7jLTMPzztZwaW4a3LWSFlzGf38UAIZoIzrNi+FiKNnPHh2gp45l
 8P42UIGPYcfhgeT/+mmFATaWIiwiNZaJ7WXlVYQDoQUCve3UxxG7wmm9I8vzLJg4Nd+m
 N8xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQiW3WE7nfLGe/NI5sVcpdGxgNH0xfDXwg4arIf9SfxjQmM0c2xf8bjzDBwy5nEdhZn/yBgtSFOACoAsfGT5zdjM55i4=
X-Gm-Message-State: AOJu0Yw3grEHw5c2I6RJViSfGyPw0jjlN3LryNhjpkNbiUuN41zHCd8l
 5VqjqOqRZ0WxBTGfiaqrOWKCNgjoQx5drfdsMiEH1a85CLTdva3sN9j6NXHwM3Y=
X-Google-Smtp-Source: AGHT+IEGzBEV7dDaYVJFDebNAw0+OW36/NwOAWcZFSa7o1Tyor4n/B1KU4+FlV04zBUIKqk2cOeTog==
X-Received: by 2002:a05:6e02:164e:b0:375:9cb9:9cff with SMTP id
 e9e14a558f8ab-375e0e09510mr142348785ab.7.1718667195510; 
 Mon, 17 Jun 2024 16:33:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6fedf3a34ddsm6131277a12.48.2024.06.17.16.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 16:33:15 -0700 (PDT)
Message-ID: <24ee6724-a7d4-47eb-8f89-939a2699bd6a@linaro.org>
Date: Mon, 17 Jun 2024 16:33:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 rowan.hart@intel.com
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
 <ezjl0.qx0tmsp6d6t@linaro.org>
 <CABgObfbGwKc0RYBcDPzNkE8HOSouFj4D15Oh7TuiKOC+D7raaA@mail.gmail.com>
 <ZmqcFf0xB9m4WkA3@redhat.com>
 <CABgObfb4+FSsadFTVg6Dc1zehQV2Vei2_kSRd5CfxsGBLPN6Eg@mail.gmail.com>
 <Zmq47yQV-sQ0hGMy@redhat.com>
 <CABgObfYaxBxc8GS3=YU=EwNLEihEoD4ikZ595P4m_KTZCAAaBw@mail.gmail.com>
 <f26b0.f15017t08v16@linaro.org>
 <CABgObfaYUCU0Tj-jj66n8AaxOpqXFKcQA-E6G0W6q3MjjwQkiQ@mail.gmail.com>
 <f7vmg.s9przvzs9y9y@linaro.org>
 <CABgObfayPDfcrFJ5ckFFms_raD25ARFEvLNhP1qLmda_rjrLfg@mail.gmail.com>
 <f89qp.6kmlv39qhntz@linaro.org>
 <CABgObfYj3F6aoefBgcHcjkwDqK6kcDGUfPZtRbFzB5abXShfbA@mail.gmail.com>
 <f8v3w.uqub97dfqvvo@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f8v3w.uqub97dfqvvo@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

T24gNi8xNy8yNCAxNDowNCwgTWFub3MgUGl0c2lkaWFuYWtpcyB3cm90ZToNCj4gT24gTW9u
LCAxNyBKdW4gMjAyNCAxNzozMiwgUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+PiBPbiBNb24sIEp1biAxNywgMjAyNCBhdCA0OjA04oCvUE0gTWFub3Mg
UGl0c2lkaWFuYWtpcw0KPj4gPG1hbm9zLnBpdHNpZGlhbmFraXNAbGluYXJvLm9yZz4gd3Jv
dGU6DQo+Pj4gSSByZXNwZWN0ZnVsbHkgZGlzYWdyZWUgYW5kIHJlY29tbWVuZCB0YWtpbmcg
YW5vdGhlciBsb29rIGF0IHRoZSBjb2RlLg0KPj4+DQo+Pj4gVGhlIGRldmljZSBhY3R1YWxs
eSBwZXJmb3JtcyBhbGwgbG9naWMgaW4gbm9uLXVuc2FmZSBtZXRob2RzIGFuZCBpcw0KPj4+
IHR5cGVkIGluc3RlYWQgb2Ygb3BlcmF0aW5nIG9uIHJhdyBpbnRlZ2VycyBhcyBmaWVsZHMv
c3RhdGUuIFRoZSBDIHN0dWZmDQo+Pj4gaXMgdGhlIEZGSSBib3VuZGFyeSBjYWxscyB3aGlj
aCB5b3UgY2Fubm90IGF2b2lkOyB0aGV5IGFyZSB0aGUgc2FtZQ0KPj4+IHRoaW5ncyB5b3Un
ZCB3cmFwIHVuZGVyIHRoZXNlIGJpbmRpbmdzIHdlJ3JlIHRhbGtpbmcgYWJvdXQuDQo+Pg0K
Pj4gSW5kZWVkLCBidXQgdGhlIHdob2xlIHBvaW50IGlzIHRoYXQgdGhlIGJpbmRpbmdzIHdy
YXAgdW5zYWZlIGNvZGUgaW4NCj4+IHN1Y2ggYSB3YXkgdGhhdCB0aGUgc2FmZXR5IGludmFy
aWFudHMgaG9sZC4gTm90IGRvaW5nIHRoaXMsIGVzcGVjaWFsbHkNCj4+IGZvciBhIGRldmlj
ZSB0aGF0IGRvZXMgbm90IGRvIERNQSAoc28gdGhhdCB0aGVyZSBhcmUgdmVyeSBmZXcgd2F5
cw0KPj4gdGhhdCB0aGluZ3MgY2FuIGdvIHdyb25nIGluIHRoZSBmaXJzdCBwbGFjZSksIHJ1
bnMgY291bnRlciB0byB0aGUNCj4+IHdob2xlIHBoaWxvc29waHkgb2YgUnVzdC4NCj4+DQo+
PiBGb3IgZXhhbXBsZSwgeW91IGhhdmU6DQo+Pg0KPj4gICAgIHB1YiBmbiByZWFsaXplKCZt
dXQgc2VsZikgew0KPj4gICAgICAgICB1bnNhZmUgew0KPj4gICAgICAgICAgICAgcWVtdV9j
aHJfZmVfc2V0X2hhbmRsZXJzKA0KPj4gICAgICAgICAgICAgICAgIGFkZHJfb2ZfbXV0IShz
ZWxmLmNoYXJfYmFja2VuZCksDQo+PiAgICAgICAgICAgICAgICAgU29tZShwbDAxMV9jYW5f
cmVjZWl2ZSksDQo+PiAgICAgICAgICAgICAgICAgU29tZShwbDAxMV9yZWNlaXZlKSwNCj4+
ICAgICAgICAgICAgICAgICBTb21lKHBsMDExX2V2ZW50KSwNCj4+ICAgICAgICAgICAgICAg
ICBOb25lLA0KPj4gICAgICAgICAgICAgICAgIGFkZHJfb2ZfbXV0ISgqc2VsZikuY2FzdDo6
PGNfdm9pZD4oKSwNCj4+ICAgICAgICAgICAgICAgICBjb3JlOjpwdHI6Om51bGxfbXV0KCks
DQo+PiAgICAgICAgICAgICAgICAgdHJ1ZSwNCj4+ICAgICAgICAgICAgICk7DQo+PiAgICAg
ICAgIH0NCj4+ICAgICB9DQo+Pg0KPj4gd2hlcmUgeW91IGFyZSBpbXBsaWNpdGx5IHJlbHlp
bmcgb24gdGhlIGZhY3QgdGhhdCBwbDAxMV9jYW5fcmVjZWl2ZSgpLA0KPj4gcGwwMTFfcmVj
ZWl2ZSgpLCBwbDAxMV9ldmVudCgpIGFyZSBuZXZlciBjYWxsZWQgZnJvbSB0aGUNCj4+IE1l
bW9yeVJlZ2lvbk9wcyByZWFkKCkgYW5kIHdyaXRlKCkgY2FsbGJhY2tzLiBPdGhlcndpc2Ug
eW91J2QgaGF2ZSB0d28NCj4+IG11dGFibGUgcmVmZXJlbmNlcyBhdCB0aGUgc2FtZSB0aW1l
LCBvbmUgYXMgYW4gYXJndW1lbnQgdG8gdGhlDQo+PiBjYWxsYmFja3M6DQo+Pg0KPj4gICAg
cHViIGZuIHJlYWQoJm11dCBzZWxmLCBvZmZzZXQ6IGh3YWRkciwgLi4uDQo+Pg0KPj4gYW5k
IG9uZSBmcm9tIGUuZy4gInN0YXRlLmFzX211dCgpLnB1dF9maWZvKCkiIGluIHBsMDExX3Jl
Y2VpdmUoKS4NCj4+DQo+PiBUaGlzIGlzIG5vdCBSdXN0IGNvZGUuIEl0IG1ha2VzIG5vIGF0
dGVtcHQgYXQgZW5mb3JjaW5nIHRoZSB3aG9sZQ0KPj4gInNoYXJlZCBYT1IgbXV0YWJsZSIg
d2hpY2ggaXMgdGhlIGJhc2lzIG9mIFJ1c3QncyByZWZlcmVuY2Ugc2VtYW50aWNzLg0KPj4g
SW4gb3RoZXIgd29yZHMsIHRoaXMgaXMgYXMgc2FmZSBhcyBDIGNvZGUtLS1zdXJlLCBpdCBj
YW4gdXNlIG5pY2UNCj4+IGFic3RyYWN0aW9ucyBmb3IgcmVnaXN0ZXIgYWNjZXNzLCBpdCBo
YXMgInVuc2FmZSIgYWRkZWQgaW4gZnJvbnQgb2YNCj4+IHBvaW50ZXIgZGVyZWZlcmVuY2Vz
LCBidXQgaXQgaXMgbm90IHNhZmUuDQo+Pg0KPj4gQWdhaW4sIEknbSBub3Qgc2F5aW5nIGl0
J3MgYSBiYWQgZmlyc3Qgc3RlcC4gSXQncyAqYXdlc29tZSogaWYgd2UNCj4+IHRyZWF0IGl0
IGFzIHdoYXQgaXQgaXM6IGEgZ3VpZGUgdG93YXJkcyBwcm92aWRpbmcgc2FmZSBiaW5kaW5n
cw0KPj4gYmV0d2VlbiBSdXN0IGFuZCBDICh3aGljaCBvZnRlbiBpbXBsaWVzIHRoZW0gYmVp
bmcgaWRpb21hdGljKS4gQnV0IGlmDQo+PiB3ZSBkb24ndCBhY2NlcHQgdGhpcywgaWYgdGhl
cmUgaXMgbm8gcGxhbiB0byBtYWtlIHRoZSBjb2RlIHNhZmUsIGl0IGlzDQo+PiBhIHBvdGVu
dGlhbCBodWdlIHNvdXJjZSBvZiB0ZWNobmljYWwgZGVidC4NCj4+DQo+Pj4gUUVNVSBjYWxs
cyB0aGUgZGV2aWNlJ3MgRkZJIGNhbGxiYWNrcyB3aXRoIGl0cyBwb2ludGVyIGFuZCBhcmd1
bWVudHMsDQo+Pj4gdGhlIHBvaW50ZXIgZ2V0cyBkZXJlZmVyZW5jZWQgdG8gdGhlIGFjdHVh
bCBSdXN0IHR5cGUgd2hpY2ggcWVtdQ0KPj4+IGd1YXJhbnRlZXMgaXMgdmFsaWQsIHRoZW4g
dGhlIFJ1c3Qgc3RydWN0J3MgbWV0aG9kcyBhcmUgY2FsbGVkIHRvIGhhbmRsZQ0KPj4+IGVh
Y2ggZnVuY3Rpb25hbGl0eS4gVGhlcmUgaXMgbm90aGluZyBhY3R1YWxseSB1bnNhZmUgaGVy
ZSwgYXNzdW1pbmcNCj4+PiBRRU1VJ3MgaW52YXJpYW50cyBhbmQgY29kZSBhcmUgY29ycmVj
dC4NCj4+DQo+PiBUaGUgc2FtZSBjYW4gYmUgc2FpZCBvZiBDIGNvZGUsIGNhbid0IGl0PyBU
aGVyZSBpcyBub3RoaW5nIHVuc2FmZSBpbiBDDQo+PiBjb2RlLCBhc3N1bWluZyB0aGVyZSBh
cmUgbm8gYnVncy4uLg0KPiANCj4gUGFvbG8sIGZpcnN0IHBsZWFzZSB0b25lIGRvd24geW91
ciBjb25kZXNjZW5kaW5nIHRvbmUsIGl0J3MgaW5jcmVkaWJseQ0KPiBvZmZlbnNpdmUuIEkn
bSBob25lc3RseSBjZXJ0YWluIHRoaXMgaXMgbm90IG9uIHB1cnBvc2Ugb3RoZXJ3aXNlIEkn
ZCBub3QNCj4gZW5nYWdlIGF0IGFsbC4NCg0KVGhlIGJlc3QgY29tcGxpbWVudCB5b3UgaGFk
IHdhcyAiSSdtIG5vdCBzYXlpbmcgaXQncyBhIGJhZCBmaXJzdCBzdGVwIiwgDQphbmQgSSB3
b3VsZCBzYXkgdGhpcyBkaWZmZXJlbnRseTogSXQncyBhIGdyZWF0IGZpcnN0IHN0ZXAhDQoN
CldlIHNob3VsZCBoYXZlIGEgZmlyc3QgdmVyc2lvbiB3aGVyZSB3ZSBzdGljayB0byB0aGUg
QyBBUEksIHdpdGggYWxsIHRoZSANClJ1c3QgY29kZSBiZWluZyBhcyBSdXN0eSBhcyBwb3Nz
aWJsZTogYmVuZWZpdCBmcm9tIHR5cGVkIGVudW1zLCBlcnJvciANCmhhbmRsaW5nLCBib3Vu
ZHMgY2hlY2tpbmcgYW5kIG90aGVyIG5pY2UgdGhpbmdzLg0KDQpJdCdzIHVzZWxlc3MgdG8g
aXRlcmF0ZS9kZWJhdGUgZm9yIHR3byB5ZWFycyBvbiB0aGUgbGlzdCBiZWZvcmUgbGFuZGlu
ZyANCnNvbWV0aGluZyB1cHN0cmVhbS4gV2UgY2FuIHN0YXJ0IHdpdGggdGhpcywgaGF2ZSBv
bmUgb3IgdHdvIGRldmljZXMgdGhhdCANCnVzZSB0aGlzIGJ1aWxkIHN5c3RlbSwgYW5kIHRo
ZW4gZm9jdXMgb24gZGVzaWduaW5nIGEgZ29vZCBpbnRlcmZhY2UgZm9yIA0KdGhpcy4NCg0K
PiANCj4gU2Vjb25kbHksIGFyZSB5b3UgaW1wbHlpbmcgdGhhdCB0aGVzZSBjYWxsYmFja3Mg
YXJlIG5vdCBvcGVyYXRlZCB1bmRlcg0KPiB0aGUgQlFMPyBJJ20gbm90IHNlZWluZyB0aGUg
QyBVQVJUIGRldmljZXMgdXNpbmcgbXV0ZXhlcy4gSWYgdGhleSBhcmUNCj4gbm90IHJ1bm5p
bmcgdW5kZXIgdGhlIEJRTCwgdGhlbiBnbGFkbHkgd2UgYWRkIG11dGV4ZXMsIGJpZyBkZWFs
LiBKdXN0DQo+IHNheSB0aGlzIGRpcmVjdGx5IGluc3RlYWQgb2Ygd3JpdGluZyBhbGwgdGhl
c2UgYW1vdW50cyBvZiB0ZXh0LiBJZiBpdCdzDQo+IHRydWUgSSdkIGp1c3QgYWNjZXB0IGl0
IGFuZCBtb3ZlIG9uIHdpdGggYSBuZXcgaXRlcmF0aW9uLiBJc24ndCB0aGF0IHRoZQ0KPiBw
b2ludCBvZiBjb2RlIHJldmlldz8gSXQgaXMgcmVhbGx5IHRoYXQgc2ltcGxlLiBXaHkgbm90
IGRvIHRoaXMgcmlnaHQNCj4gYXdheT8gSSdtIGZyYW5rbHkgcHV6emxlZC4NCj4gDQoNCkFz
IEkgbWVudGlvbmVkIGluIG15IHByZXZpb3VzIGFuc3dlciwgdGhpcyBkZXZpY2UgYWxyZWFk
eSBtYWtlcyBhIGdvb2QgDQpwcm9ncmVzczogaXQgZWxpbWluYXRlcyBhIHdob2xlIGNsYXNz
IG9mIG1lbW9yeSBlcnJvcnMsIGFuZCB0aGUgb25seSANCmlzc3VlIGJyb3VnaHQgYnkgdW5z
YWZlIGNvZGUgaXMgY29uY3VycmVuY3kgaXNzdWVzLiBBbmQgdGhpcyBzaG91bGQgYmUgDQpv
dXIgZm9jdXMgb25jZSB3ZSBnZXQgdGhlIGJ1aWxkIGluZnJhc3RydWN0dXJlIGRvbmUhDQoN
Cj4gRmluYWxseSwgdGhpcyBpcyBSdXN0IGNvZGUuIFlvdSBjYW5ub3QgdHVybiBvZmYgdGhl
IHR5cGUgc3lzdGVtLCB5b3UNCj4gY2Fubm90IHR1cm4gb2ZmIHRoZSBib3Jyb3cgY2hlY2tl
ciwgeW91IGNhbiBvbmx5IGdvIGFyb3VuZCBjcmVhdGluZyBuZXcNCj4gdHlwZXMgYW5kIHJl
ZmVyZW5jZXMgb3V0IG9mIHJhdyBtZW1vcnkgYWRkcmVzc2VzIGFuZCB0ZWxsIHRoZSBjb21w
aWxlcg0KPiAndHJ1c3QgbWUgb24gdGhpcycuIElnbm9yaW5nIHRoYXQgbWlzc2VzIHRoZSBl
bnRpcmUgcG9pbnQgb2YgUnVzdC4gVGhlDQo+IHN0YXRlbWVudCAndGhpcyBpcyBub3QgUnVz
dCBjb2RlIGJ1dCBhcyBnb29kIGFzIEMnIGlzIGRpc2hvbmVzdCBhbmQNCj4gbWlzZ3VpZGVk
LiBDaGVjayBmb3IgZXhhbXBsZSB0aGUgc291cmNlIGNvZGUgb2YgdGhlIG5peCBjcmF0ZSwg
d2hpY2gNCj4gZXhwb3NlcyBsaWJjIGFuZCB2YXJpb3VzIFBPU0lYLypuaXggQVBJcy4gSXMg
aXQgdGhlIHNhbWUgYXMgQyBhbmQgbm90DQo+IFJ1c3QgY29kZT8NCj4gDQo+IElmIHlvdSBo
YXZlIHNwZWNpZmljIHNjZW5hcmlvcyBpbiBtaW5kIHdoZXJlIHN1Y2ggdGhpbmdzIGV4aXN0
IGluIHRoZQ0KPiBjb2RlIGFuZCBlbmQgdXAgZG9pbmcgaW52YWxpZCBiZWhhdmlvciBwbGVh
c2UgYmUga2luZCBhbmQgd3JpdGUgdGhlbQ0KPiBkb3duIGV4cGxpY2l0bHkgYW5kIGRlbW9u
c3RyYXRlIHRoZW0gb24gY29kZSByZXZpZXcuIFRoaXMgYXBwcm9hY2ggb2YNCj4gJ3llcyBi
dXQgbm8nIGlzIG5vdCBjb25zdHJ1Y3RpdmUgYmVjYXVzZSBpdCBpcyBub3QgYWRkcmVzc2lu
ZyBhbnkNCj4gc3BlY2lmaWMgcHJvYmxlbXMgZGlyZWN0bHkuIEluc3RlYWQgaXQgY29tZXMg
b3V0IGFzIHZhZ3VlIGRpc21pc3NpdmUgRlVEDQo+IGFuZCBJJ20gc3VyZSB0aGF0IGlzIG5v
dCB3aGF0IHlvdSBvciBhbnlvbmUgZWxzZSB3YW50cy4NCj4gDQo+IFBsZWFzZSB0YWtlIHNv
bWUgdGltZSB0byB1bmRlcnN0YW5kIG15IFBPViBoZXJlLCBpdCdkIGhlbHAgYm90aCBvZiB1
cw0KPiBpbW1lbnNlbHkuDQo+IA0KPiBTaW5jZXJlbHkgdGhhbmsgeW91IGluIGFkdmFuY2Us
DQo+IE1hbm9zDQo=

