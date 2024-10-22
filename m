Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FC3CDD0F4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Lg4-0004B3-EB; Tue, 22 Oct 2024 16:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3Lfs-00043q-6R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:40:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3Lfp-0000Wg-V6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:40:15 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c9978a221so69412335ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629612; x=1730234412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qvG9H2rQCuMb8g+05Ev4U0/JOsAKRwDrwfS8a4lVJN4=;
 b=H13d065M0kRGqt6pPdfd13PfeRgAXQfFstfBvSLG5W99BzHQxWX1oe8KXRqWutsoH0
 Ysz8GC6X8Dt5Bcsz7SAgro9DEXUq+n3B23DTCgNg3/9k0DpKvio34tGJHUiPOP7fT03l
 fMAC3xCI1INHJDUpBOWa2ZHl7lw/DsLmRTPSKZEAN/uGJShnWxHYlXG5eyYMPQlLoi60
 W3J6jzb0itcnf6ZJ1Q/yisajV3bUw9WYRK44//wF4M0gIXbmFxn01FdeGYsxCCI0AGzZ
 ydWLiSkn/RHkHB/5BOINsxNnRwuErq7cS1CdgXIfhL1UJruxipXkqdj67o1H/Mcjx4B3
 xCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629612; x=1730234412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvG9H2rQCuMb8g+05Ev4U0/JOsAKRwDrwfS8a4lVJN4=;
 b=jxGRh97NwVFiuG/KKTk24eurY6GFyc95YfW31MUOHcXhoroxhlYdGmhyRzG4echXPy
 IMe2E2aPAlnILRI3HAHeDfJ+4w3fwlfzprCb4ooLa0Ev/iY+Sqd1QJDVTL/jBv9UHpJK
 1d/Exw3TVVHuQH5cVSq3cmZI6dqdrZWlqVA0DjR1UvGyrhcRN1ZOBqTw/2HatviiC0hH
 4QtvtO2st2ewvr5hIEQIQA426oJ2MCXjtw3FmNCcnl3odWxr4HwA0KBCDTSFCwQ9stne
 VserHpb3bxkMLyhnWuwaKtnEy/rqD9VzqmoY4DevEXAqiHZ1eV3OdHJm47roRSKDlTYj
 Slsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/CCKjBDsG5ORWkC/9zScBIuHKI9YBcSQiOrMSztuBnksRUolryw9oBYk9W/6UOxVDj2GXBUzf0XdY@nongnu.org
X-Gm-Message-State: AOJu0YyuoNXKXdrcj9IxEY8FOL1M++yQzrmHzZJmmWGhrphWnGKqj6ve
 DR+EM8AGy5QON4VHXwv9y3Si+wpnqXwu0lvKVmtX4x2YIHOswFL8gTfYr/Ulcas=
X-Google-Smtp-Source: AGHT+IGhsr68xM+2DHDRmM+aLh7jGtiUs902lD0R0BSuVY69oA/h0YUu892mfTNoYvuF23qCg4Pcxg==
X-Received: by 2002:a17:902:ecc5:b0:20c:e6e4:9daf with SMTP id
 d9443c01a7336-20fa9e48be4mr5302095ad.13.1729629612404; 
 Tue, 22 Oct 2024 13:40:12 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0d9a67sm46441425ad.185.2024.10.22.13.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:40:11 -0700 (PDT)
Message-ID: <78c6f080-7722-48dc-a4c7-a7345155f2cf@linaro.org>
Date: Tue, 22 Oct 2024 13:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] MAINTAINERS: mention my plugins/next tree
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-17-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gTWFrZSBpdCBlYXNp
ZXIgdG8gZmluZCB3aGVyZSBwbHVnaW4gcGF0Y2hlcyBhcmUgYmVpbmcgc3RhZ2VkLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBNQUlOVEFJTkVSUyB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRB
SU5FUlMNCj4gaW5kZXggODEzOTZjOWYxNS4uMDJiOGIyZGZkNiAxMDA2NDQNCj4gLS0tIGEv
TUFJTlRBSU5FUlMNCj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTM3MDIsNiArMzcwMiw3
IEBAIEY6IGluY2x1ZGUvdGNnLw0KPiAgIA0KPiAgIFRDRyBQbHVnaW5zDQo+ICAgTTogQWxl
eCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiArVDogZ2l0IGh0dHBzOi8v
Z2l0bGFiLmNvbS9zdHNxdWFkL3FlbXUgcGx1Z2lucy9uZXh0DQo+ICAgUjogQWxleGFuZHJl
IElvb3NzIDxlcmRuYXhlQGNyYW5zLm9yZz4NCj4gICBSOiBNYWhtb3VkIE1hbmRvdXIgPG1h
Lm1hbmRvdXJyQGdtYWlsLmNvbT4NCj4gICBSOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

