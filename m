Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40951C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 06:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbwMS-0000q6-6I; Thu, 08 Aug 2024 02:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbwMO-0000pO-UF
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 02:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sbwMN-0000uL-46
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 02:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723097449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4HJg3KsGWQAgYNVgP37UYISnzB3CbQrJ7VsQRa9nUu8=;
 b=gc6tHSrh6ELPxke4UxyRkN5eNtoXvSXDR5JvSutQmKpTYp87tsPYFr2K3iJIi/udadu2t2
 K7niXT8YjMlyqKWAIfSb8ky97recNRix8md3nnjhOr0b39mfm+ZzNCZpwIpQlFMN2PjXHR
 eG+JiWoI+/t380sAK637kYJHT86vv6Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-HqkwpMNXOkaTJRVrKs__8A-1; Thu, 08 Aug 2024 02:10:45 -0400
X-MC-Unique: HqkwpMNXOkaTJRVrKs__8A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7ab50e6735so27063366b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 23:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723097444; x=1723702244;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4HJg3KsGWQAgYNVgP37UYISnzB3CbQrJ7VsQRa9nUu8=;
 b=mfCrFGdH7nIks7ScE7rddeMVue+I/4NzRKSqhABfwEX1MiGevP8baJT98vvWlRzG2n
 jOgXwZ/4y24Eh9tXVIiwlQnlGK9i3wQs3uqs8qdBjWTmPLxj1WdMwX/kuAU6qk8RR6XR
 3vLOVi95qxVpzVF+72jQWqt4xj58Dwlen0x6F2H7v1m7ahX/qBTBkufksnE669EVigyO
 QQ41m/9uJMKyqGMjNkcFNFC3CvdOHjNu7TInPeAWIEyJmABOZx93jb3+593MUlcQkrP+
 FElifEdU1jVphDb1iKFHTAXuef6ED6j12j7fiNP6gnfbr079M9ajoP6jXQYvhJWWn83G
 P++Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfSIrsf9Sdpr1DTlB9ihykiK2GT46YGXLr9KkCJX4Tv3kLan+Vbm+EpKKhVv+IXPNDRvZv+nkBCKzOeR/Cyz6kBEjEVMU=
X-Gm-Message-State: AOJu0Yz/J28AafjpPf3dHHxGTSVhSNLye6k889RFczt+qc29ZVrI/ppy
 bN2xDSOTtroqky7nKBIRm1o/+THsfRxmUs2if5p3WF4laDEO1JZFGVhHEzNurWr/+OniiQ9BcTf
 vUD2AeQ8VSA8/yB8LxnroilhrQXNKNJy4/mX8NIyAqMqikKlOLHIp
X-Received: by 2002:a17:906:cad8:b0:a7a:9f0f:ab2c with SMTP id
 a640c23a62f3a-a8090d874f4mr53166466b.29.1723097444042; 
 Wed, 07 Aug 2024 23:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3berCzG2mlCeMQTnnTZu8SxS51JuDQPdeZoETf1W+a69o4zbsPYGKIXrOzqg8OzxnLgplBQ==
X-Received: by 2002:a17:906:cad8:b0:a7a:9f0f:ab2c with SMTP id
 a640c23a62f3a-a8090d874f4mr53164666b.29.1723097443517; 
 Wed, 07 Aug 2024 23:10:43 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4294fsm702078066b.103.2024.08.07.23.10.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 23:10:42 -0700 (PDT)
Message-ID: <f989d834-706a-4708-be81-f6447237425e@redhat.com>
Date: Thu, 8 Aug 2024 08:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 0/5] rust-pl011-rfc-v6
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/4/24 23:04, Manos Pitsidianakis wrote:
> Changes
> =======
> 
> - Setting MSRV to 1.77.0:
>    * cstr crate MSRV is 1.64, which is more recent than Debian bookworm
>      (1.63.0) <https://github.com/upsuper/cstr/blob/master/Cargo.toml>
> 
>    * pl011's dependencies (mostly proc-macro2) don't support 1.63.0

proc-macro2 is listed as supporting 1.56.0, and in general I don't see 
particularly high MSRVs for any of your dependencies.

cstr needs to use version 0.2.10 in order to work with Rust 1.63.0.

As discussed on IRC, there are obvious advantages and disadvantages to 
using meson.  The main disadvantage is the extra work when bumping the 
version of the dependencies or when adding a new one.  The advantage is 
more uniformity and less moving parts.  Overall, I think it's doable to 
use it.  Dependencies will mostly be added in the early days of QEMU, 
and won't be updated too often due to our MSRV constraints.

The automatic Cargo.toml support in Meson is promising, but it doesn't 
work right now when cross compiling build-time dependencies (which have 
to use "native: true" or Meson rightly warns about mixing build-machine 
and host-machine binaries).  So right now we'd have to write meson.build 
by hand for those.

My suggestion is however to name our manually-managed subprojects with 
the same convention that is used by "method = cargo" in Meson 1.5.0+, 
i.e. name-APIVER-rs:

	arbitrary-int-1-rs.wrap
	bilge-0.2-rs.wrap
	bilge-impl-0.2-rs.wrap
	either-1-rs.wrap
	itertools-0.11-rs.wrap
	proc-macro2-1-rs.wrap
	proc-macro-error-1-rs.wrap
	proc-macro-error-attr-1-rs.wrap
	quote-1-rs.wrap
	syn-2-rs.wrap
	unicode-ident-1-rs.wrap

and to access dependencies using meson.override_dependency() and 
dependency(), instead of get_variable().  This at least reduces future 
churn.

As to the individual patches:

- for patch 1, roughly the same changes I had made for cargo can be done 
for rustc, so that the cross file contains the right --target option. 
I'll reply to the individual patch.

- for patch 2, the only issue is that you are specifying 
--no-include-path-detection and that breaks for me on Fedora.  I have 
not finished testing but it seems that it's enough to remove that line.

- for patches 4 and 5, I have minimal comments on the meson.build.  For 
patch 5, however, I have already done the above renaming as part of 
getting cross compilation to work.  We can synchronize on IRC on the 
best way of getting the changes to you.

Paolo


