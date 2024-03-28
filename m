Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7AFC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpn73-0000ek-KG; Thu, 28 Mar 2024 06:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rpn6x-0000cI-BY
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:35:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rpn6v-0001wR-Ns
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 06:35:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41549a9dcbaso1069335e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711622149; x=1712226949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3RKwBF/ZCp7i0RmQC5aXJcyqSvE78LXmX4RJoz3XCiY=;
 b=tBl/yOPl5I40wwiCv5G3L7TuLb0IuAA+h9e0v+UPMYN7stzDfEhpXh93vvRewfVf0I
 4yTC7tAWmYpE+3NIKmOlN2/IIBkZL5NUaHIOE06HMbJ7L+ozC7J+dR1ttsF1guQ0VK7x
 DJAKhqWHIUwctYuLjk//7LFRsHo3dw9EWurRa2gxAIAWxfN9YSNGUhJ8PCUGhPOkhD8l
 2aKe/M3JGIIv29kGc27UUEdmnvPMJdHZYaakK1tRPEvBY3M1Fv4JkYNP+bxxtQn2BU7A
 kTPlE+WZVMdEY+66uG9UQsbsGUZA0tBMAp8B7MMOBPbdfXseXA1mDg7Re2gKaPgc0YYh
 c7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711622149; x=1712226949;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3RKwBF/ZCp7i0RmQC5aXJcyqSvE78LXmX4RJoz3XCiY=;
 b=Gfu5avKb1KoZq/wWiGhgU4sJrMEaYhSpDiLWj91nR0CVYa15YneBIl16vqvMpMpcbv
 wwWJfQ0b5+YSUGxjoKzyw2UeIpQMYWUngmzytOPAjZL1MQZpAsDQMdQwBx0clVQaudJl
 hNNagBDxuezvzS1JkUIJSp06wbu2Lgev3uGc0WhAYV69IYTEebM9Rm2IVbkaW5Uc75zK
 UecLT2tZLj0Bc4Zla2iYeOt/kQiepxqLNxKZZW4q5ioP7dFrpPMQcq2Hv/5zTkmNocUE
 AbmyHMiB5mCuInnDQrZQxg95LlZFTlmwuQQQG43orl1JkTYWMyOVORGZQgzo1xZBc5VN
 tO8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhVbHbCZnu3Bi5NtsgRRcLVCYmU+A1hE4Vydio5zQx/s49TSy7lbzV6b0dtBC7CpYnlzITaIEtZoflN1EGAF2gw9Q0X60=
X-Gm-Message-State: AOJu0YwNS1H5Vu4nDBmQcU+vVZDXkJKDmRwM4t/iVVw1x4MjBbPeG9hJ
 RueuVHbD4vtITheK/1Q1rnErhekWzbHMb+dtADSXvCQEixLKqefHMKOSdIog3HU=
X-Google-Smtp-Source: AGHT+IHa6OquSJbafJgmF9o5MpiNEFJcqOdnm4+ABszU1lqEmP1AjT2AHYsT6YKYaNVrJA7eLhzDsg==
X-Received: by 2002:a7b:cd87:0:b0:414:e0af:9b9f with SMTP id
 y7-20020a7bcd87000000b00414e0af9b9fmr1816185wmj.30.1711622149121; 
 Thu, 28 Mar 2024 03:35:49 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c458c00b004146e58cc35sm5034659wmo.46.2024.03.28.03.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 03:35:48 -0700 (PDT)
Message-ID: <644090cd-4af3-4ed3-9e6c-9240e146a9c5@linaro.org>
Date: Thu, 28 Mar 2024 14:35:37 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] plugins: fix -Werror=maybe-uninitialized
 false-positive
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-15-marcandre.lureau@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240328102052.3499331-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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

T24gMy8yOC8yNCAxNDoyMCwgbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tIHdyb3RlOg0K
PiBGcm9tOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNv
bT4NCj4gDQo+IC4uL3BsdWdpbnMvbG9hZGVyLmM6NDA1OjE1OiBlcnJvcjog4oCYY3R44oCZ
IG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXpl
ZF0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBwbHVnaW5zL2xvYWRlci5jIHwgMiAr
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3BsdWdpbnMvbG9hZGVyLmMgYi9wbHVnaW5zL2xvYWRlci5j
DQo+IGluZGV4IDk3NjhiNzhlYjYuLjUxM2E0MjljNTcgMTAwNjQ0DQo+IC0tLSBhL3BsdWdp
bnMvbG9hZGVyLmMNCj4gKysrIGIvcGx1Z2lucy9sb2FkZXIuYw0KPiBAQCAtMzkwLDcgKzM5
MCw3IEBAIHZvaWQgcGx1Z2luX3Jlc2V0X3VuaW5zdGFsbChxZW11X3BsdWdpbl9pZF90IGlk
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHJlc2V0KQ0KPiAgIHsN
Cj4gICAgICAgc3RydWN0IHFlbXVfcGx1Z2luX3Jlc2V0X2RhdGEgKmRhdGE7DQo+IC0gICAg
c3RydWN0IHFlbXVfcGx1Z2luX2N0eCAqY3R4Ow0KPiArICAgIHN0cnVjdCBxZW11X3BsdWdp
bl9jdHggKmN0eCA9IE5VTEw7DQo+ICAgDQo+ICAgICAgIFdJVEhfUUVNVV9MT0NLX0dVQVJE
KCZwbHVnaW4ubG9jaykgew0KPiAgICAgICAgICAgY3R4ID0gcGx1Z2luX2lkX3RvX2N0eF9s
b2NrZWQoaWQpOw0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0K

