Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6B9C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 20:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHV2x-0000tT-6p; Wed, 12 Jun 2024 16:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHV2w-0000tL-KN
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 16:58:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHV2u-0004hI-O2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 16:58:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f0d6255bdso402114f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718225895; x=1718830695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WFKyQ4UH1rXPvCtH1PvIRp+UYNgJts/yyx6D90jpBH8=;
 b=JNxIVw6D8YxfO1nwzfEy4nnip1xfKs5NnJpENfGCSam++j5sSzKUDtMZ8O0jXOHu7u
 QYXpN8+lubuhzepQMGgBMImhS2b3Pc4pE7QNsyMW4KCYl5df9zDJzs3N10hB/lhgJUzd
 Zvu91msG8a1B1n0qJT6puaBHCKZ8M+fPlfXccCHgl899ZkdlPYTpLV+9E5fXzQjJ4lO8
 oVFjuWca+mKnSyrHPrIFh4NFbiJkwpS9p4sBH0UJBmM3+sGXBQ6r+d1XmkqNp97hsq7h
 hdkKc3XhhHA1Sg6smj6+kBqMeoVON7/97hX0bmcpb4l2rrsHJI/5U2V334fd9D+5V7fD
 4zpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718225895; x=1718830695;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WFKyQ4UH1rXPvCtH1PvIRp+UYNgJts/yyx6D90jpBH8=;
 b=hcbw9f9PO6oRLSu0jHDpY2MYiBU5N7SV3eKXA+BVJ9ymz0Y6YyL0Yh/Waw321wBQJh
 48FnVlv+Hep+d+7IjhGfMHHyHCUiVCWlcPJU6tiW3nN4LGcGU5ooQZN58xq4JLAWQcNn
 VJC2e2OahzyS+TNKuUvgiVrnLmvl0Z4745WYaMzqhF2RkeKeY4SPyvvtoyk5JoXCndJP
 22DIAhdfem4IH6B7D58QcVG4IoiGdwtJr7pidQF6N6cXVZ9Sz7ReZ2BfmZKyusbT4sBH
 DmcKpgkdn/xZnEjL7Kfh5OJWpZXV1WGy2aY2gcK1Jd7guWCQz+kVuqZQr+lnOAJr64qu
 su6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKmlOGR6Vm2D19WYA/83v0OJnnGNMbaNnSirdhNXGHkfWOomKNyNgWVxu1AMxCvrw72j2BuuceSnbnyDAv5Q+T1AoxxSQ=
X-Gm-Message-State: AOJu0YylS3xVrPWBvWThEJ+rmiuF1N59/o3tYmeZLXnfgVV8wOZpnEhI
 3uuSz51d2DLy2vVlEc/DS2UYt9UzuiZxhKg/D9FRsO3zjMOgwxATwnX+CO2V0bs=
X-Google-Smtp-Source: AGHT+IGJ8AB4gCRcEyYeKQxZXnmXQB2Z/02qV/wlLEHy1YwNdk2jqlaLd4CBiobU+rsHlY39dHstXg==
X-Received: by 2002:adf:e741:0:b0:35f:2065:187 with SMTP id
 ffacd0b85a97d-35fdf7ba4c8mr2098782f8f.19.1718225894890; 
 Wed, 12 Jun 2024 13:58:14 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1e92dde6sm10822916f8f.41.2024.06.12.13.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 13:58:14 -0700 (PDT)
Date: Wed, 12 Jun 2024 23:57:19 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn=?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org> <ZmnHoajecti472mi@redhat.com>
In-Reply-To: <ZmnHoajecti472mi@redhat.com>
Message-ID: <ezjl0.qx0tmsp6d6t@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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

On Wed, 12 Jun 2024 19:06, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>On Wed, Jun 12, 2024 at 05:14:56PM +0300, Manos Pitsidianakis wrote:
>> On Wed, 12 Jun 2024 15:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > I think this is extremely useful to show where we could go in the task
>> > of creating more idiomatic bindings.
>> > 
>> > On Tue, Jun 11, 2024 at 12:34 PM Manos Pitsidianakis
>> > <manos.pitsidianakis@linaro.org> wrote:
>> > > +pub const PL011_ARM_INFO: TypeInfo = TypeInfo {
>> > > +    name: TYPE_PL011.as_ptr(),
>> > > +    parent: TYPE_SYS_BUS_DEVICE.as_ptr(),
>> > > +    instance_size: core::mem::size_of::<PL011State>(),
>> > > +    instance_align: core::mem::align_of::<PL011State>(),
>> > > +    instance_init: Some(pl011_init),
>> > > +    instance_post_init: None,
>> > > +    instance_finalize: None,
>> > > +    abstract_: false,
>> > > +    class_size: 0,
>> > > +    class_init: Some(pl011_class_init),
>> > > +    class_base_init: None,
>> > > +    class_data: core::ptr::null_mut(),
>> > > +    interfaces: core::ptr::null_mut(),
>> > > +};
>> > 
>> > QOM is certainly a major part of what we need to do for idiomatic
>> > bindings. This series includes both using QOM objects (chardev) and
>> > defining them.
>> > 
>> > For using QOM objects, there is only one strategy that we need to
>> > implement for both Chardev and DeviceState/SysBusDevice which is nice.
>> > We can probably take inspiration from glib-rs, see for example
>> > - https://docs.rs/glib/latest/glib/object/trait.Cast.html
>> > - https://docs.rs/glib/latest/glib/object/trait.ObjectType.html
>> > - https://docs.rs/glib/latest/glib/object/struct.ObjectRef.html
>> 
>> 
>> There was consensus in the community call that we won't be writing Rust APIs
>> for internal C QEMU interfaces; or at least, that's not the goal
>
>I think that is over-stating things. This was only mentioned in passing
>and my feeling was that we didn't have that detailed of a discussion
>because at this stage such a discussion is a bit like putting the cart
>before the horse.
>
>While the initial focus might be to just consume a Rust API that is a
>1:1 mapping of the C API, I expect that over time we'll end up writing
>various higher level Rust wrappers around the C API. If we didn't do that,
>then in effect we'd be making ourselves write psuedo-C code in Rust,
>undermining many of the benefits we could get.
>

In any case, it is out of scope for this RFC. Introducing wrappers would 
be a gradual process.

Thanks,
Manos

