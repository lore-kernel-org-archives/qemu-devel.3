Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B35C52D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semWY-0006jU-W7; Thu, 15 Aug 2024 22:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1semWW-0006iG-Hn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:17:04 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1semWU-00043v-Jm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:17:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fd9e6189d5so14198085ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 19:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723774620; x=1724379420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xSM7y89u9gnK0onDD2Zkn7lzkD9e9q84nHP+DTM2axE=;
 b=LU5eCJOkB1Cras7Jb/xzUER7zxfRmh9mdVrqVa31XWWtIln+2UajidNXoWRwpHzA4x
 I9i5qHec4KMEFSsQaUmbgf48/gs8mNAS2ohCFQDYWE2fUVJ3nztya3vXzPdWwaWbtzKk
 KWF1hEzoWUQXE5KkEGk1SM0PceXi2U+yuTyZZ+uYJ59y6+Ief9GVC7OZ6dOIR8yxy1v6
 roFfQ6UyRRQEr6LOkvLVPzEfThcT18/SF13r/OxSCfDcuVov3mq5rX+oxjVF1+vpAvQ7
 7KuSHnEz5aExO6D/LRWtqfKpZiM1qYmltEfvA9YT6rQ7TdN16kabs6vK78IVu3VSn5FT
 OLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723774620; x=1724379420;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSM7y89u9gnK0onDD2Zkn7lzkD9e9q84nHP+DTM2axE=;
 b=AfR5SdXqmoZJH9zL0pxClcOG/WmzlbF+PeET81OFOSQ/MEeBU7HWSNS0AwkS4UIO2U
 hGSpPjc0/sAv3sB1tMgUSQCnei7wbNHTwULs7fmlnoAvBvMOz3wHQDZRnLHtd82i4RLK
 T9qI1d/awzj17pJB073ilBrMGJFLylJNRHAQAfuhn/ghK5u5n647vDddWdwc5aGDdIsS
 zAtUNlzKkMytoG1H54cT7bZn7XYVRaFRGV6zdgbMnE76WjEqO3tJI3++eFRI+zK90Bn4
 Vnf5ZjBoOQLJZloHdolilR2FW3ibSCLgnG9LqxlOtE0FQ8X3tbkH51vEKHBk85K9cj1R
 ImPQ==
X-Gm-Message-State: AOJu0YyBVnvq7yTmT144vShn9sl4IOgQZg6u3FxRtU5dPeHXJfoSfdz0
 x1C0E6b/A8sgXyFY67e+flMDALYf0w+l/vJLSldTPeQMdrkVgDVZEbq86g3adVQ=
X-Google-Smtp-Source: AGHT+IGja9NweuHMmM7+KLPvwoXyqK0X5PuYqKO9zDuRs58eykZP3RRBrYkzbvyOOu6bxwjVl92wBA==
X-Received: by 2002:a17:903:32d1:b0:1fc:57b7:995c with SMTP id
 d9443c01a7336-20203e47f2fmr17718015ad.7.1723774620044; 
 Thu, 15 Aug 2024 19:17:00 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a84esm16289575ad.189.2024.08.15.19.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:16:59 -0700 (PDT)
Message-ID: <638964b2-6a90-44a9-809b-865d832c14fe@linaro.org>
Date: Thu, 15 Aug 2024 19:16:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
 <10d3fd64-bb03-487b-afd2-28e0f5e014c6@linaro.org>
Content-Language: en-US
In-Reply-To: <10d3fd64-bb03-487b-afd2-28e0f5e014c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gOC8xNS8yNCAxMDozOCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gOC8xNS8y
NCAwNDo0NiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gVGhvbWFzIEh1dGggPHRodXRoQHJl
ZGhhdC5jb20+IHdyaXRlczoNCj4+DQo+Pj4gT24gMTUvMDgvMjAyNCAwMS4zNiwgUGllcnJp
Y2sgQm91dmllciB3cm90ZToNCj4+Pj4gRm91bmQgb24gZGViaWFuIHN0YWJsZSAoaTM4Niku
DQo+Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5jOiBJbiBmdW5jdGlvbiAndmNwdV90
Yl90cmFucyc6DQo+Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5jOjQ3NzozMDogZXJy
b3I6IGNhc3QgZnJvbSBwb2ludGVyIHRvIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1X
ZXJyb3I9cG9pbnRlci10by1pbnQtY2FzdF0NCj4+Pj4gICAgICA0NzcgfCAgICAgICAgICAg
ICBlZmZlY3RpdmVfYWRkciA9ICh1aW50NjRfdCkgcWVtdV9wbHVnaW5faW5zbl9oYWRkcihp
bnNuKTsNCj4+Pj4gICAgICAgICAgfA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAg
ICAgY29udHJpYi9wbHVnaW5zL2NhY2hlLmMgfCA2ICsrKy0tLQ0KPj4+PiAgICAgMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4gZGlmZiAt
LWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5jIGIvY29udHJpYi9wbHVnaW5zL2NhY2hl
LmMNCj4+Pj4gaW5kZXggNTEyZWY2Nzc2YjcuLjgyZWQ3MzRkNmQ0IDEwMDY0NA0KPj4+PiAt
LS0gYS9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0KPj4+PiArKysgYi9jb250cmliL3BsdWdp
bnMvY2FjaGUuYw0KPj4+PiBAQCAtNDcxLDEyICs0NzEsMTIgQEAgc3RhdGljIHZvaWQgdmNw
dV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlkLCBzdHJ1Y3QgcWVtdV9wbHVnaW5fdGIg
KnRiKQ0KPj4+PiAgICAgICAgIG5faW5zbnMgPSBxZW11X3BsdWdpbl90Yl9uX2luc25zKHRi
KTsNCj4+Pj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgbl9pbnNuczsgaSsrKSB7DQo+Pj4+
ICAgICAgICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9pbnNuICppbnNuID0gcWVtdV9wbHVn
aW5fdGJfZ2V0X2luc24odGIsIGkpOw0KPj4+PiAtICAgICAgICB1aW50NjRfdCBlZmZlY3Rp
dmVfYWRkcjsNCj4+Pj4gKyAgICAgICAgdWludHB0cl90IGVmZmVjdGl2ZV9hZGRyOw0KPj4+
PiAgICAgICAgICAgICAgIGlmIChzeXMpIHsNCj4+Pj4gLSAgICAgICAgICAgIGVmZmVjdGl2
ZV9hZGRyID0gKHVpbnQ2NF90KSBxZW11X3BsdWdpbl9pbnNuX2hhZGRyKGluc24pOw0KPj4+
PiArICAgICAgICAgICAgZWZmZWN0aXZlX2FkZHIgPSAodWludHB0cl90KSBxZW11X3BsdWdp
bl9pbnNuX2hhZGRyKGluc24pOw0KPj4+PiAgICAgICAgICAgICB9IGVsc2Ugew0KPj4+PiAt
ICAgICAgICAgICAgZWZmZWN0aXZlX2FkZHIgPSAodWludDY0X3QpIHFlbXVfcGx1Z2luX2lu
c25fdmFkZHIoaW5zbik7DQo+Pj4+ICsgICAgICAgICAgICBlZmZlY3RpdmVfYWRkciA9ICh1
aW50cHRyX3QpDQo+Pj4+IHFlbXVfcGx1Z2luX2luc25fdmFkZHIoaW5zbik7DQo+Pj4+ICAg
ICAgICAgICAgIH0NCj4+Pg0KPj4+IElzIHRoaXMgdGhlIHJpZ2h0IGZpeD8gSSBhc3N1bWUg
ZWZmZWN0aXZlX2FkZHIgc3RvcmVzIGFuIGFkZHJlc3Mgb2YNCj4+PiB0aGUgZ3Vlc3QsIHNv
IGlmIHRoZSBndWVzdCBpcyA2NC1iaXQgYW5kIHRoZSBob3N0IGlzIDMyLWJpdCwgeW91IG5v
dw0KPj4+IGxvc2UgdGhlIHVwcGVyIGJpdHMgb2YgdGhlIGFkZHJlc3MuLi4/DQo+Pg0KPj4g
SSB0aGluayB0aGUgcHJvYmxlbSBpcyBoaWdoZXIgdXAsIGl0IHdhcyBhIG1pc3Rha2UgdG8g
aGF2ZToNCj4+DQo+PiAgICAgdm9pZCAqcWVtdV9wbHVnaW5faW5zbl9oYWRkcihjb25zdCBz
dHJ1Y3QgcWVtdV9wbHVnaW5faW5zbiAqaW5zbik7DQo+Pg0KPj4gcmV0dXJuICp2b2lkLCBh
dCBsZWFzdCB2YWRkciByZXR1cm5zIGFuIGV4cGxpY2l0IDY0IGJpdCB2YWx1ZSB3aGljaCBj
YW4NCj4+IGhvbGQgZXZlcnl0aGluZyAoYXQgYSBzbGlnaHQgZXhwZW5zZSB0byAzMmJpdCBl
bXVsYXRpb24gaG9zdHMsIGJ1dA0KPj4gc2VyaW91c2x5IHN0b3AgZG9pbmcgdGhhdCB3ZSd2
ZSBiZWVuIGluIHRoZSA2NGJpdCB3b3JsZCBmb3Igc29tZSB0aW1lDQo+PiBub3cpLg0KPj4N
Cj4gDQo+IEl0J3MgYW4gb3BlbiBxdWVzdGlvbiBJIGhhZC4gV2hlbiBleGVjdXRpbmcgNjQg
Yml0cyBiaW5hcmllcyBvbiBhIDMyDQo+IGJpdHMgaG9zdCwgYXJlIHdlIGVtdWxhdGluZyB0
aGUgZnVsbCA2NCBiaXRzIGFkZHJlc3Mgc3BhY2UsIG9yIGRvIHdlDQo+IHJlc3RyaWN0IHRv
IDMyIGJpdHM/IEZvciB1c2VyIG1vZGUsIEkgZG9uJ3Qgc2VlIGhvdyBpdCBjb3VsZCBiZSBw
b3NzaWJsZQ0KPiB0byBoYXZlIGFkZHJlc3Mgc3BhY2UgYmV5b25kIHRoZSAzMiBiaXRzIHJh
bmdlLCBidXQgc3lzdGVtIG1vZGUgaXMNCj4gcHJvYmFibHkgZGlmZmVyZW50Lg0KPg0KDQpB
ZnRlciB0cnlpbmcgdG8gYm9vdCBhbiB4NjQgc3lzdGVtIG9uIDMyIGJpdHMgaG9zdCwgSSBj
YW4gY29uZmlybSB0aGUgDQphZGRyZXNzIHJldHVybmVkIGJ5IHFlbXVfcGx1Z2luX3RiX3Zh
ZGRyIGlzIGVmZmVjdGl2ZWx5IG9uIDY0IGJpdHMgDQoodXNpbmcgdXBwZXIgMzIgYml0cyku
DQoNClRodXMsIEknbGwgcmVzcGluIHRoaXMgc2VyaWVzIHdpdGggYSBjb3JyZWN0IGZpeCBp
bnN0ZWFkIG9mIHRoZSBiYWQgDQpjYXN0cyBJIHVzZWQuDQoNCj4gVGhlIHJlYWwgcHJvcGVy
IGZpeCBpcyB0byBub3QgZW5jb2RlIGRpcmVjdGx5IHZhbHVlIHVuZGVyIHVkYXRhIGZvcg0K
PiBjYWxsYmFja3MsIGJ1dCBhbGxvY2F0ZSB0aGlzIGFuZCBwYXNzIGEgcG9pbnRlciBpbnN0
ZWFkLg0KPiANCj4+Pg0KPj4+IFRoZSBjYXN0aW5nIGZvciBxZW11X3BsdWdpbl9pbnNuX3Zh
ZGRyIGlzIG5vdCByZXF1aXJlZCBhdCBhbGwgc2luY2UgaXQNCj4+PiBhbHJlYWR5IHJldHVy
bnMgYW4gdWludDY0X3QsIHNvIHlvdSBjYW4gcmVtb2UgdGhhdCBvbmUuIEZvciB0aGUgaGFk
ZHINCj4+PiBwYXJ0LCBtYXliZSBkbyBhIGRvdWJsZS1jYXN0Og0KPj4+DQo+Pj4gICAgIGVm
ZmVjdGl2ZV9hZGRyID0gKHVpbnQ2NF90KSh1aW50cHRyX3QpcWVtdV9wbHVnaW5faW5zbl9o
YWRkcihpbnNuKQ0KPj4+DQo+Pj4gPw0KPj4+DQo+Pj4gICAgVGhvbWFzDQo+Pg0K

