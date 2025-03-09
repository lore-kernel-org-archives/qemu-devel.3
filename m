Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A64C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trLoa-0008Lz-MQ; Sun, 09 Mar 2025 14:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trLoT-0008KY-ID
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:55:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trLoR-0003GN-QK
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 14:55:49 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22548a28d0cso28631495ad.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741546545; x=1742151345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4gU4h4sxcrlsUKGAX1YrS3hwxdA8CQEkt2CJElxmWaE=;
 b=umhLYbrqMWrYvnWUnU9NQoSQPvm5m+ShrjLkTWJQdgQXg3pnzF+2AyCsAmACM8k3lK
 FSLOLhTzYG13Z6OYcdOUA/TIEuu2AeZiQjgBLPAKzbtjZNIaaXHIqTpKnNm7/mzjBuXw
 RK0zvBOm7y2wbrBpkE8324dbMqziwv1dr4LvHHsF5XtdWL7m9wkjo/1pjEER4BbypIkG
 JDZtqOo8ZrZVF+2h2U6FqBidE9VGnsknMn9CM3Q48Sc/5xrLKVs/g35VlNjD5VkGJ8z8
 e4AMxKmLhRLYSred6SAzXqV7M2q5cBvZX3TaJVeiZs3nXRQBj+nkd/yw3fnkOWjj2swh
 qPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741546545; x=1742151345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4gU4h4sxcrlsUKGAX1YrS3hwxdA8CQEkt2CJElxmWaE=;
 b=cL4Xr6mQTtBAqCQuF5p+4//dNB/4ndJKD3oXDf3+6XxVlQABGiDghGMUOqUatYKBio
 TdJPocx8m/ulP3G8k84lxOw6qx95dlr2mSpokZUydNY8bYBu9bJcsdeB7ar668QJRi7n
 vUFpfr1uGYbfhQ95zPfN/DU8tKN/+YjAlPipyVhGXL12nxDv09i8YKNwQEhBSUmSOycT
 1ylgyMZZPOZCDCLkG1+I+hbJ9Hz9lWRgbS22za08Co4DO6T13dXT6V1cn1jWkFUeoC1s
 AFeH2C9lnxZEWJKYmnBgGFikOhCkb8KpTTG++fnjEbth9WMdSKt0DMVyQP9mLG3ff+oX
 DgvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW+tsnr+b9j9rHQMK+BNVaEbA6NWkEy0olpcWeJZXfxvAOgh08Zq6f13fE/GxyDE4ViUTpQ8Rv2qM0@nongnu.org
X-Gm-Message-State: AOJu0Yx8VTZFaClXvDbnq3uMMsTN5Md1l1JNqxVpXXG7JzHiZgHtb/Xl
 efPQWUkM8zs9SebbFLrdUGuTsioWEQJhJT2RGR+83sI/2g9yQcqT0KkP82wV6Co=
X-Gm-Gg: ASbGncvafwOTAm7mtBZYFxhabjfCtszYNxDT0btyqFC0TxBy+b2oh1X8Gslj9JPzPnS
 e21UAESBvzHAfw70TFtaoo1+Tisa/p91QK00jgl2aopWeP+nH3iMgMHJHK58HFnYd6mTRwbDw6E
 PPoqW1L9Y5I4F/pK5z/bdJPugE5PdrcL5Z1S6+r7lhhEQKOc4P2PwMsX2gESG09JoRwxmAIgPAg
 j4ABjgiZliQIgiUakHSUBfqQgnieNL3k/ofSeUz06+YFQyRHbTsPC65Rye5KjcbWpyDUA5etGgf
 dyGK/NJrCCDvlVwOT7B3KcxmWvNdsIFGkJlfOUO8+vHyXDXyu2qfgAah9Q==
X-Google-Smtp-Source: AGHT+IFuL76FqajmwOwPA/lhZq1uLDKviZaMHpKL2JQchDhkvmUXqbkX8QrlCr25XZ1XI1w/UYn5IQ==
X-Received: by 2002:a05:6300:6713:b0:1f3:29a9:6197 with SMTP id
 adf61e73a8af0-1f544aef521mr19743222637.18.1741546545470; 
 Sun, 09 Mar 2025 11:55:45 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2812887b3sm5259148a12.71.2025.03.09.11.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 11:55:45 -0700 (PDT)
Message-ID: <fda186da-2e31-42d6-8dd6-0ea3141a73e6@linaro.org>
Date: Sun, 9 Mar 2025 11:55:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Zl20rAjHLJlZkwxE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNi8zLzI0IDA1OjE4LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPiBPbiBGcmks
IE1heSAzMSwgMjAyNCBhdCAwNjo0Nzo0NUFNICswMjAwLCBUaG9tYXMgSHV0aCB3cm90ZToN
Cj4+IE9uIDMwLzA1LzIwMjQgMDkuNDUsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3Rl
Og0KPj4+IFdlIGFyZSB0cnlpbmcgdG8gdW5pZnkgYWxsIHFlbXUtc3lzdGVtLUZPTyB0byBh
IHNpbmdsZSBiaW5hcnkuDQo+Pj4gSW4gb3JkZXIgdG8gZG8gdGhhdCB3ZSBuZWVkIHRvIHJl
bW92ZSBRQVBJIHRhcmdldCBzcGVjaWZpYyBjb2RlLg0KPj4+DQo+Pj4gQGR1bXAtc2tleXMg
aXMgb25seSBhdmFpbGFibGUgb24gcWVtdS1zeXN0ZW0tczM5MHguIFRoaXMgc2VyaWVzDQo+
Pj4gcmVuYW1lIGl0IGFzIEBkdW1wLXMzOTAtc2tleSwgbWFraW5nIGl0IGF2YWlsYWJsZSBv
biBvdGhlcg0KPj4+IGJpbmFyaWVzLiBXZSB0YWtlIGNhcmUgb2YgYmFja3dhcmQgY29tcGF0
aWJpbGl0eSB2aWEgZGVwcmVjYXRpb24uDQo+Pj4NCj4+PiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSAoNCk6DQo+Pj4gICAgIGh3L3MzOTB4OiBJbnRyb2R1Y2UgdGhlIEBkdW1wLXMzOTAt
c2tleXMgUU1QIGNvbW1hbmQNCj4+PiAgICAgaHcvczM5MHg6IEludHJvZHVjZSB0aGUgJ2R1
bXBfczM5MF9za2V5cycgSE1QIGNvbW1hbmQNCj4+PiAgICAgaHcvczM5MHg6IERlcHJlY2F0
ZSB0aGUgSE1QICdkdW1wX3NrZXlzJyBjb21tYW5kDQo+Pj4gICAgIGh3L3MzOTB4OiBEZXBy
ZWNhdGUgdGhlIFFNUCBAZHVtcC1za2V5cyBjb21tYW5kDQo+Pg0KPj4gV2h5IGRvIHdlIGhh
dmUgdG8gcmVuYW1lIHRoZSBjb21tYW5kPyBKdXN0IGZvciB0aGUgc2FrZSBvZiBpdD8gSSB0
aGluaw0KPj4gcmVuYW1pbmcgSE1QIGNvbW1hbmRzIGlzIG1heWJlIG9rLCBidXQgYnJlYWtp
bmcgdGhlIEFQSSBpbiBRTVAgaXMgc29tZXRoaW5nDQo+PiB5b3Ugc2hvdWxkIGNvbnNpZGVy
IHR3aWNlLg0KPiANCj4gVGhhdCB3YXMgZ29pbmcgdG8gYmUgbXkgcXVlc3Rpb24gdG9vLiBT
ZWVtcyBsaWtlIGl0cyBwb3NzaWJsZSB0byBzaW1wbHkNCj4gc3R1YiBvdXQgdGhlIGV4aXN0
aW5nIGNvbW1hbmQgZm9yIG90aGVyIHRhcmdldHMuDQo+IA0KPiBUaGUgcmVuYW1pbmcgaXMg
anVzdCB3aW5kb3cgZHJlc3NpbmcuDQo+IA0KDQpXb3JraW5nIG9uIHNpbmdsZS1iaW5hcnkg
dG9waWMgbWVhbnMgc3BlY2lmaWNpdGllcyBmcm9tIGV2ZXJ5IHFlbXUgDQpiaW5hcnkvYXJj
aGl0ZWN0dXJlIGhhcyB0byBiZSBtZXJnZWQgdG9nZXRoZXIuIERlc3BpdGUgYXBwZWFyaW5n
IGhhcyBhIA0KYmFkIHRoaW5nIG5vdywgaXQncyBkZWZpbml0ZWx5IGEgc3RlcCBmb3J3YXJk
IGZvciBRRU1VLCBhbmQgd2lsbCBhbGxvdyANCnRvIGVuYWJsZSBuZXcgdXNhZ2VzLg0KDQpU
aGUgaGFyZCB3YXkgaXMgdG8gdHJpZ2dlciBhIGRlZXAgcmVmYWN0b3JpbmcsIGludm9sdmlu
ZyBsZW5ndGh5IA0KY29udmVyc2F0aW9ucyB3aGVyZSBjb21wcm9taXNlcyBoYXZlIHRvIGJl
IGZvdW5kICgibGV0J3MgaW1wbGVtZW50IHRoaXMgDQpmb3IgYWxsIGFyY2giKS4gVGhlIHBy
YWdtYXRpYyB3YXkgaXMgdG8gZWxpbWluYXRlIG9idmlvdXMgc3R1ZmYuDQoNClRoaXMgY29t
bWFuZCBpcyBzcGVjaWZpYyB0byBhbiBhcmNoLCBzbyByZW5hbWluZyBpcyBhIGdvb2QgYW5k
IG9idmlvdXMgDQpzdHJhdGVneS4gRm9yIHRoZSBiYWNrd2FyZCBjb21wYXRpYmxlIGFueGlv
dXMgZGV2ZWxvcGVyLCBhbm90aGVyIA0Kc3RyYXRlZ3kgd291bGQgYmUgdG8gc2ltcGx5IGRl
Y2xhcmUgdGhpcyBjb21tYW5kIGlmIHRoZSBydW5uaW5nIHRhcmdldCANCmlzIHMzOTB4LiBC
dXQgdGhlbiwgeW91IGNyZWF0ZSBhIHByZWNlZGVudCB0byBkbyBzb21ldGhpbmcgdGhhdCBz
aG91bGQgDQpub3QgaGF2ZSBleGlzdGVkIGluIHRoZSBmaXJzdCBwbGFjZS4NCg0KKzEgZm9y
IHRoZSByZW5hbWluZywgYW5kIGhvcGUgdGhhdCB1c2VycyBvZiB0aGlzIGNvbW1hbmQgYXJl
IGFibGUgdG8gDQpjaGFuZ2UgYSBsaW5lIGluIHRoZWlyIHNjcmlwdCB0byBhZGFwdCB0byB0
aGUgbmV3IGNvbW1hbmQuDQoNCj4+DQo+PiBBbmQgZXZlbiBpZiB3ZSBkZWNpZGUgdG8gcmVu
YW1lIC4uLiBtYXliZSB3ZSBzaG91bGQgZGlzY3VzcyB3aGV0aGVyIGl0IG1ha2VzDQo+PiBz
ZW5zZSB0byBjb21lIHVwIHdpdGggYSBnZW5lcmljIGNvbW1hbmQgaW5zdGVhZDogQXMgZmFy
IGFzIEkga25vdywgQVJNIGFsc28NCj4+IGhhcyBzb21ldGhpbmcgc2ltaWxhciwgY2FsbGVk
IE1URS4gTWF5YmUgd2UgYWxzbyB3YW50IHRvIGR1bXAgTVRFIGtleXMgb25lDQo+PiBkYXk/
IFNvIHRoZSBuZXcgY29tbWFuZCBzaG91bGQgbWF5YmUgYmUgY2FsbGVkICJkdW1wLW1lbW9y
eS1rZXlzIiBpbnN0ZWFkPw0KPj4gT3Igc2hvdWxkIGl0IG1heWJlIHJhdGhlciBiZSBhbiBv
cHRpb24gdG8gdGhlIGV4aXN0aW5nICJkdW1wLWd1ZXN0LW1lbW9yeSINCj4+IGNvbW1hbmQg
aW5zdGVhZD8NCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQoNCg==

