Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B7FC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 08:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siV20-0005Az-Oz; Mon, 26 Aug 2024 04:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siV1z-00059w-QN
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siV1q-0004Vf-QA
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724660686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o+w+b2d9CA/vhwYML+RLtQHAREc1vKYbCym3rMOA0Rk=;
 b=GQRV6whhh0wEX7ZUivA3AcjjWP7itt6ioFB1VpkHfzLhkRZFfOTs6s5oWaDm3ppvwDnOys
 TYfKlkuLBNfSD3VZhEc3Gyew6YWdA7oQyAw9ztANdkzMLrI6mhwctvtpxjNXwzavEDP8Zr
 kmP2HyR0qqGgbfzaTw5QRYYtTiOwHpk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-7IcHXqIiMvSKMb6zGRPvEA-1; Mon, 26 Aug 2024 04:24:44 -0400
X-MC-Unique: 7IcHXqIiMvSKMb6zGRPvEA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e0353b731b8so6800740276.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 01:24:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724660684; x=1725265484;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+w+b2d9CA/vhwYML+RLtQHAREc1vKYbCym3rMOA0Rk=;
 b=wflvYRgYM45KbNyP7Os42MZpxa4XqAA+Grny60IWWBGIzIrd6uFe/KU6zCMhM7lnyE
 iQmbxFDAytMdSrE8ip3SllgOK3EeynmigxQt9F/vg716pfw7T1XYydsgb5GUSg4P+K+n
 QuSEQXa7nmXfw4kgOx9FOiqVnPTPZxt72hiUQwuCY08hZLL8Cx1nYv92Cm4EUGpdUL1C
 eKmrOtGfG8oz4sCXcRe4b1k0JeLuHT0heK/BmKhgTeu1IOs1rabzt5uw88PmLB0gsBoU
 zqyUvUJNRYOpRNp695f9AplBaaMbtt4HvTqynU3awbk7xJ1nbyWERiJXO5ABFzfZwW6P
 n9Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5kbgkrulyedXAYozduVj7fsVY0S5WD0NFK0/rhDtik3ACZI0WHo8QegdIoXPtBWEJC7piE2MMDuN2@nongnu.org
X-Gm-Message-State: AOJu0YwWmtAM5q+hkyyZW8MouMshgKwjDUqtrNWjLlvVpDCUDz0taEwB
 6KIfHsQkpfPzsVc6mSUisLlxeGiYdi+ydSlXzLnjAt4COVIgJyX+ODXDlop7tTuOlVHrRVRyhqc
 nEuSrWpaZoxAIYK6U9K+6UzuSRumbCF8Uc1XJ3PFNwZMPtO/7PEH0
X-Received: by 2002:a05:6902:2191:b0:e0b:a4b6:670f with SMTP id
 3f1490d57ef6-e17a86804a4mr9181316276.51.1724660683903; 
 Mon, 26 Aug 2024 01:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIXtzvIiEHz9KxeSGxWn5El7K9t6O11XbNCzNoKWbZz9cU7ZrErUvu8mjumTcgfDR5Qqk6yA==
X-Received: by 2002:a05:6902:2191:b0:e0b:a4b6:670f with SMTP id
 3f1490d57ef6-e17a86804a4mr9181294276.51.1724660683472; 
 Mon, 26 Aug 2024 01:24:43 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-41.web.vodafone.de.
 [109.43.177.41]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0f04fcsm41498351cf.46.2024.08.26.01.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 01:24:43 -0700 (PDT)
Message-ID: <c6c08785-3bd6-42a0-9fe8-ecd52974ecde@redhat.com>
Date: Mon, 26 Aug 2024 10:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn_=C3=A9_e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
 <itc2k.22cnsecjnvt9@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <itc2k.22cnsecjnvt9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 26/08/2024 08.41, Manos Pitsidianakis wrote:
> On Mon, 26 Aug 2024 08:31, Junjie Mao <junjie.mao@intel.com> wrote:
>>> +unsafe impl GlobalAlloc for QemuAllocator {
>>> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>>> +        if layout.align() == 0 {
>>> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
>>> +        } else {
>>> +            g_aligned_alloc0(
>>
>> One more thing: g_aligned_alloc0() was introduced in glib 2.72 [1] but the 
>> current glib version check in meson is >= 2.66.0.
>>
>> Glib 2.72 still supports Win 7+, so no increase to _WIN32_WINNT is needed 
>> for this version bumping.
>>
>> [1] https://docs.gtk.org/glib/func.aligned_alloc0.html
>> [2] 
>> https://gitlab.gnome.org/GNOME/glib/-/blob/2.72.0/meson.build?ref_type=tags#L509
> 
> Hm. Was there no way to have aligned allocations before 2.72? We can emit a 
> cfg from meson if glib is <2.72 and handle it differently.

Can't you simply use our qemu_memalign() function instead?

  Thomas



