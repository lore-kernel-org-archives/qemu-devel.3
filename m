Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13F9C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWH6x-00015w-57; Tue, 23 Jul 2024 11:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWH6w-00015S-8E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWH6q-0000dJ-RT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721747243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R2pjt0ukUH5wE5Eg1bxbcD+hIZ7OR2ellmYfjdkDxMU=;
 b=f7bEaNwiv5Qjbpxudagyiv4HPZrVxOwPlhrzAaxbGAYiLFq3eoOrzUbX9OanrS8cwWM7VW
 tVsMuX/7j8JGFRiidqfzKJ5HXSNYWUD1u30VbYwOlCoUEiaZfC40pqUVikMiY7KbAqvzhh
 Ax8u1BEAubyq2rZ1AQzllio6bYAMzFY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-kDaD_gqQMzuA1qhyH7DOKg-1; Tue, 23 Jul 2024 11:07:21 -0400
X-MC-Unique: kDaD_gqQMzuA1qhyH7DOKg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4265464ddc9so25398245e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747240; x=1722352040;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2pjt0ukUH5wE5Eg1bxbcD+hIZ7OR2ellmYfjdkDxMU=;
 b=KpmGYkpawZkz3mgczcY/qySH1SQWPmeIn8GIPwQT1X+svC4mbG893UW+6lAlT3ct5L
 7Lqjh7VazWRmCaoGjnLepRjVa0Hw5tpVs5uQAgweUeYfv5FinL3wz1fewaOCw7PfgSTI
 fYs7CLsTEytheJtGkIeHdXOtSEz/CkiSxrmXsTE+LAveplHcQ4M0QT1UfqnD66JqGPQg
 FTC2WczFJbJlZkpFvf0wwomx16KKcpJJzyGD7cSgkdLR6t29rTT/nDia/s27SKfz4sQq
 QO6wKx35Z07WPmD+7yQHEmPCifEKxA1jtbPRHoUUjM2Lt0WcexYjqi0zKuhr9ty8xhXP
 h+AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx4sHP6Ivy3grIU0MWnVlLVvkVEkfLNR1laVYKRrvcjoWn/ShetNfzacFdOINvrPxGhvBN2FvuIegcEFQlkuLgURJmk/0=
X-Gm-Message-State: AOJu0Yze0mPQcOM28YBeaY+cH9F74Lb/Y3XiHVGwZEm7YsE6cqvoXlO/
 FQ+eEmoEi7PM4i1MtmBpzGcc07paY9IPNryLvV1k0CGfP55pweenp+HIxfM0ndu4ZpzkQa+SljE
 RfAoUJdq/TrXFcEoh8Ot4aMA4P3zxZEPCBVxkr/F4bzBx/Gi5t4ea
X-Received: by 2002:a05:600c:4451:b0:426:65b0:3035 with SMTP id
 5b1f17b1804b1-427ef3b6278mr17538875e9.15.1721747238993; 
 Tue, 23 Jul 2024 08:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGl8uc92Q4vd1owYV+bPWgUstaXYeyRjA5r9q0grfBIC2/PrHP5+VV/BNzPORH2oe9GeZBRA==
X-Received: by 2002:a05:600c:4451:b0:426:65b0:3035 with SMTP id
 5b1f17b1804b1-427ef3b6278mr17538275e9.15.1721747237965; 
 Tue, 23 Jul 2024 08:07:17 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-427d2a95099sm201758875e9.48.2024.07.23.08.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 08:07:17 -0700 (PDT)
Message-ID: <bc27a983-f0b7-4803-96f7-060a4a331348@redhat.com>
Date: Tue, 23 Jul 2024 17:07:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/8] Add Rust support, implement ARM PL011
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
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/22/24 13:43, Manos Pitsidianakis wrote:
> Changes from v4->v5:
> - Added CI patch from Alex Benee
> - Removed all cargo use, use meson rust support
> - Added Kconfig logic

The following requests from the v4 review have also been evaluated (good!):

✅ module structure should resemble the C part of the tree

✅ only generate bindings.rs.inc once

✅ a couple lints are too broad and should be enabled per-file. (though 
there are still some issues with duplication of lints, I consider this 
mostly done)

✅ please check if -Wl,--whole-archive can be replaced with link_whole 
(as discussed on IRC, unfortunately it cannot)


The hot point here is how to handle dependencies.  I appreciate that you 
found a way to avoid repeated building of dependent crates, and to 
integrate with Kconfig, but at the same time this is a huge change which 
in my opinion is premature.

For example if we can (sooner or later) use the automatic Cargo 
subprojects, we do not need any vendoring and we can use cargo in the 
meanwhile (we can drop --cargo and CARGO at any point, just like we 
dropped --meson and --sphinx-build in QEMU 8.1).

On the other hand, committing to using meson's "raw" (meson.build-level) 
rust support and vendoring everything is premature in my opinion is very 
different for people who are already comfortable with Cargo, so it makes 
it harder to add new dependencies.  In fact, because the huge patch 8 
did not reach the mailing list, it's really hard to understand what's 
going on, what had to be done by hand and what is done automatically by 
meson.

In my opinion we should start with cargo workspaces as the 
known-imperfect (but good enough) solution, so that it could be evolved 
later.  It is important that any change that deviates from common Rust 
conventions is documented, and v4 provided a nice basis to build upon, 
with documentation coming as things settle.  This is why I explicitly 
didn't include Kconfig in the TODO list in my review of v4.

>   .../vendor/arbitrary-int/.cargo-checksum.json |    1 +

In any case, vendoring should not be done inside hw/char/pl011.

Also, of the code changes (as opposed to the build system changes) that 
I had asked for in the review of v4, almost none of them have been 
applied.  I'm copying them here for future reference:

❌ TODO comments when the code is doing potential undefined behavior

❌ a trait to store the CStr corresponding to the structs

❌ a trait to generate all-zero structs without having to type "unsafe { 
MaybeUninit::zeroed().assume_init() }"

❌ I'd like to use ctor instead of non-portable linker magic, and the
cstr crate instead of CStr statics or c""

If you have a tree that I can look at, to understand more of patch 8, 
please send a pointer.  However, honestly I am not comfortable with the 
build system integration as done in this patch.

My suggestion is to do one of the following, or both:

- start from this version; try using Cargo subproject support in 1.5.0 
and see if it works, so that vendoring can be dropped.  We can require 
Meson 1.5.0 to work on Rust support.  In this case it's okay not to do 
any further code changes (the four that were marked ❌ above).

- go back to the build system integration of v4, and do *only* the 
changes that were requested during review (in this case, all of them 
except link_whole, with you checked it does not work).

If you try using Cargo subproject support, please provide the running 
time for configure and make, for both "v4" and "v5+subproject".  When I 
tried it, the processing of the subprojects was very slow.

Paolo

>   .../pl011/vendor/arbitrary-int/CHANGELOG.md   |   47 +
>   .../pl011/vendor/arbitrary-int/Cargo.toml     |   54 +
>   .../pl011/vendor/arbitrary-int/LICENSE.txt    |   21 +
>   .../char/pl011/vendor/arbitrary-int/README.md |   72 +
>   .../pl011/vendor/arbitrary-int/meson.build    |   14 +
>   .../pl011/vendor/arbitrary-int/src/lib.rs     | 1489 +++++
>   .../pl011/vendor/arbitrary-int/tests/tests.rs | 1913 ++++++
>   .../vendor/bilge-impl/.cargo-checksum.json    |    1 +
>   .../char/pl011/vendor/bilge-impl/Cargo.toml   |   54 +
>   .../hw/char/pl011/vendor/bilge-impl/README.md |  327 ++
>   .../char/pl011/vendor/bilge-impl/meson.build  |   24 +
>   .../pl011/vendor/bilge-impl/src/bitsize.rs    |  187 +
>   .../vendor/bilge-impl/src/bitsize/split.rs    |  185 +
>   .../vendor/bilge-impl/src/bitsize_internal.rs |  235 +
>   .../src/bitsize_internal/struct_gen.rs        |  402 ++
>   .../pl011/vendor/bilge-impl/src/debug_bits.rs |   55 +
>   .../vendor/bilge-impl/src/default_bits.rs     |   92 +
>   .../pl011/vendor/bilge-impl/src/fmt_bits.rs   |  112 +
>   .../pl011/vendor/bilge-impl/src/from_bits.rs  |  222 +
>   .../char/pl011/vendor/bilge-impl/src/lib.rs   |   79 +
>   .../pl011/vendor/bilge-impl/src/shared.rs     |  196 +
>   .../src/shared/discriminant_assigner.rs       |   56 +
>   .../vendor/bilge-impl/src/shared/fallback.rs  |   92 +
>   .../vendor/bilge-impl/src/shared/util.rs      |   91 +
>   .../vendor/bilge-impl/src/try_from_bits.rs    |  143 +
>   .../pl011/vendor/bilge/.cargo-checksum.json   |    1 +
>   rust/hw/char/pl011/vendor/bilge/Cargo.toml    |   69 +
>   .../hw/char/pl011/vendor/bilge/LICENSE-APACHE |  176 +
>   rust/hw/char/pl011/vendor/bilge/LICENSE-MIT   |   17 +
>   rust/hw/char/pl011/vendor/bilge/README.md     |  327 ++
>   rust/hw/char/pl011/vendor/bilge/meson.build   |   17 +
>   rust/hw/char/pl011/vendor/bilge/src/lib.rs    |   80 +
>   .../pl011/vendor/either/.cargo-checksum.json  |    1 +
>   rust/hw/char/pl011/vendor/either/Cargo.toml   |   54 +
>   .../char/pl011/vendor/either/LICENSE-APACHE   |  201 +
>   rust/hw/char/pl011/vendor/either/LICENSE-MIT  |   25 +
>   .../pl011/vendor/either/README-crates.io.md   |   10 +
>   rust/hw/char/pl011/vendor/either/meson.build  |   16 +
>   .../pl011/vendor/either/src/into_either.rs    |   64 +
>   .../char/pl011/vendor/either/src/iterator.rs  |  315 +
>   rust/hw/char/pl011/vendor/either/src/lib.rs   | 1519 +++++
>   .../pl011/vendor/either/src/serde_untagged.rs |   69 +
>   .../either/src/serde_untagged_optional.rs     |   74 +
>   .../vendor/itertools/.cargo-checksum.json     |    1 +
>   .../char/pl011/vendor/itertools/CHANGELOG.md  |  409 ++
>   .../hw/char/pl011/vendor/itertools/Cargo.lock |  681 +++
>   .../hw/char/pl011/vendor/itertools/Cargo.toml |  101 +
>   .../pl011/vendor/itertools/LICENSE-APACHE     |  201 +
>   .../char/pl011/vendor/itertools/LICENSE-MIT   |   25 +
>   rust/hw/char/pl011/vendor/itertools/README.md |   44 +
>   .../pl011/vendor/itertools/benches/bench1.rs  |  877 +++
>   .../vendor/itertools/benches/combinations.rs  |  125 +
>   .../benches/combinations_with_replacement.rs  |   40 +
>   .../vendor/itertools/benches/extra/mod.rs     |    2 +
>   .../itertools/benches/extra/zipslices.rs      |  188 +
>   .../itertools/benches/fold_specialization.rs  |   73 +
>   .../vendor/itertools/benches/powerset.rs      |   44 +
>   .../vendor/itertools/benches/tree_fold1.rs    |  144 +
>   .../itertools/benches/tuple_combinations.rs   |  113 +
>   .../pl011/vendor/itertools/benches/tuples.rs  |  213 +
>   .../pl011/vendor/itertools/examples/iris.data |  150 +
>   .../pl011/vendor/itertools/examples/iris.rs   |  137 +
>   .../char/pl011/vendor/itertools/meson.build   |   18 +
>   .../vendor/itertools/src/adaptors/coalesce.rs |  235 +
>   .../vendor/itertools/src/adaptors/map.rs      |  124 +
>   .../vendor/itertools/src/adaptors/mod.rs      | 1151 ++++
>   .../itertools/src/adaptors/multi_product.rs   |  230 +
>   .../vendor/itertools/src/combinations.rs      |  128 +
>   .../src/combinations_with_replacement.rs      |  109 +
>   .../pl011/vendor/itertools/src/concat_impl.rs |   23 +
>   .../vendor/itertools/src/cons_tuples_impl.rs  |   64 +
>   .../char/pl011/vendor/itertools/src/diff.rs   |   61 +
>   .../vendor/itertools/src/duplicates_impl.rs   |  216 +
>   .../vendor/itertools/src/either_or_both.rs    |  495 ++
>   .../vendor/itertools/src/exactly_one_err.rs   |  110 +
>   .../pl011/vendor/itertools/src/extrema_set.rs |   48 +
>   .../pl011/vendor/itertools/src/flatten_ok.rs  |  165 +
>   .../char/pl011/vendor/itertools/src/format.rs |  168 +
>   .../char/pl011/vendor/itertools/src/free.rs   |  286 +
>   .../pl011/vendor/itertools/src/group_map.rs   |   32 +
>   .../pl011/vendor/itertools/src/groupbylazy.rs |  579 ++
>   .../vendor/itertools/src/grouping_map.rs      |  535 ++
>   .../pl011/vendor/itertools/src/impl_macros.rs |   29 +
>   .../pl011/vendor/itertools/src/intersperse.rs |  118 +
>   .../pl011/vendor/itertools/src/k_smallest.rs  |   20 +
>   .../pl011/vendor/itertools/src/kmerge_impl.rs |  227 +
>   .../pl011/vendor/itertools/src/lazy_buffer.rs |   63 +
>   .../hw/char/pl011/vendor/itertools/src/lib.rs | 3967 +++++++++++++
>   .../pl011/vendor/itertools/src/merge_join.rs  |  220 +
>   .../char/pl011/vendor/itertools/src/minmax.rs |  115 +
>   .../vendor/itertools/src/multipeek_impl.rs    |  101 +
>   .../pl011/vendor/itertools/src/pad_tail.rs    |   96 +
>   .../pl011/vendor/itertools/src/peek_nth.rs    |  102 +
>   .../itertools/src/peeking_take_while.rs       |  177 +
>   .../vendor/itertools/src/permutations.rs      |  277 +
>   .../pl011/vendor/itertools/src/powerset.rs    |   90 +
>   .../itertools/src/process_results_impl.rs     |   68 +
>   .../vendor/itertools/src/put_back_n_impl.rs   |   61 +
>   .../pl011/vendor/itertools/src/rciter_impl.rs |   99 +
>   .../pl011/vendor/itertools/src/repeatn.rs     |   59 +
>   .../pl011/vendor/itertools/src/size_hint.rs   |  119 +
>   .../pl011/vendor/itertools/src/sources.rs     |  183 +
>   .../itertools/src/take_while_inclusive.rs     |   68 +
>   .../hw/char/pl011/vendor/itertools/src/tee.rs |   78 +
>   .../pl011/vendor/itertools/src/tuple_impl.rs  |  331 ++
>   .../pl011/vendor/itertools/src/unique_impl.rs |  179 +
>   .../pl011/vendor/itertools/src/unziptuple.rs  |   80 +
>   .../vendor/itertools/src/with_position.rs     |   88 +
>   .../pl011/vendor/itertools/src/zip_eq_impl.rs |   60 +
>   .../pl011/vendor/itertools/src/zip_longest.rs |   83 +
>   .../pl011/vendor/itertools/src/ziptuple.rs    |  138 +
>   .../itertools/tests/adaptors_no_collect.rs    |   46 +
>   .../vendor/itertools/tests/flatten_ok.rs      |   76 +
>   .../vendor/itertools/tests/macros_hygiene.rs  |   13 +
>   .../vendor/itertools/tests/merge_join.rs      |  108 +
>   .../itertools/tests/peeking_take_while.rs     |   69 +
>   .../pl011/vendor/itertools/tests/quick.rs     | 1849 ++++++
>   .../vendor/itertools/tests/specializations.rs |  153 +
>   .../pl011/vendor/itertools/tests/test_core.rs |  317 +
>   .../pl011/vendor/itertools/tests/test_std.rs  | 1184 ++++
>   .../pl011/vendor/itertools/tests/tuples.rs    |   86 +
>   .../char/pl011/vendor/itertools/tests/zip.rs  |   77 +
>   rust/hw/char/pl011/vendor/meson.build         |   18 +
>   .../.cargo-checksum.json                      |    1 +
>   .../vendor/proc-macro-error-attr/Cargo.toml   |   33 +
>   .../proc-macro-error-attr/LICENSE-APACHE      |  201 +
>   .../vendor/proc-macro-error-attr/LICENSE-MIT  |   21 +
>   .../vendor/proc-macro-error-attr/build.rs     |    5 +
>   .../vendor/proc-macro-error-attr/meson.build  |   20 +
>   .../vendor/proc-macro-error-attr/src/lib.rs   |  121 +
>   .../vendor/proc-macro-error-attr/src/parse.rs |   89 +
>   .../proc-macro-error-attr/src/settings.rs     |   72 +
>   .../proc-macro-error/.cargo-checksum.json     |    1 +
>   .../vendor/proc-macro-error/CHANGELOG.md      |  162 +
>   .../pl011/vendor/proc-macro-error/Cargo.toml  |   56 +
>   .../vendor/proc-macro-error/LICENSE-APACHE    |  201 +
>   .../pl011/vendor/proc-macro-error/LICENSE-MIT |   21 +
>   .../pl011/vendor/proc-macro-error/README.md   |  258 +
>   .../pl011/vendor/proc-macro-error/build.rs    |   11 +
>   .../pl011/vendor/proc-macro-error/meson.build |   22 +
>   .../vendor/proc-macro-error/src/diagnostic.rs |  349 ++
>   .../vendor/proc-macro-error/src/dummy.rs      |  150 +
>   .../proc-macro-error/src/imp/delegate.rs      |   69 +
>   .../proc-macro-error/src/imp/fallback.rs      |   30 +
>   .../pl011/vendor/proc-macro-error/src/lib.rs  |  560 ++
>   .../vendor/proc-macro-error/src/macros.rs     |  288 +
>   .../vendor/proc-macro-error/src/sealed.rs     |    3 +
>   .../proc-macro-error/tests/macro-errors.rs    |    8 +
>   .../pl011/vendor/proc-macro-error/tests/ok.rs |   10 +
>   .../proc-macro-error/tests/runtime-errors.rs  |   13 +
>   .../vendor/proc-macro-error/tests/ui/abort.rs |   11 +
>   .../proc-macro-error/tests/ui/abort.stderr    |   48 +
>   .../proc-macro-error/tests/ui/append_dummy.rs |   13 +
>   .../tests/ui/append_dummy.stderr              |    5 +
>   .../tests/ui/children_messages.rs             |    6 +
>   .../tests/ui/children_messages.stderr         |   23 +
>   .../vendor/proc-macro-error/tests/ui/dummy.rs |   13 +
>   .../proc-macro-error/tests/ui/dummy.stderr    |    5 +
>   .../vendor/proc-macro-error/tests/ui/emit.rs  |    7 +
>   .../proc-macro-error/tests/ui/emit.stderr     |   48 +
>   .../tests/ui/explicit_span_range.rs           |    6 +
>   .../tests/ui/explicit_span_range.stderr       |    5 +
>   .../proc-macro-error/tests/ui/misuse.rs       |   11 +
>   .../proc-macro-error/tests/ui/misuse.stderr   |   13 +
>   .../tests/ui/multiple_tokens.rs               |    6 +
>   .../tests/ui/multiple_tokens.stderr           |    5 +
>   .../tests/ui/not_proc_macro.rs                |    4 +
>   .../tests/ui/not_proc_macro.stderr            |   10 +
>   .../proc-macro-error/tests/ui/option_ext.rs   |    6 +
>   .../tests/ui/option_ext.stderr                |    7 +
>   .../tests/ui/proc_macro_hack.rs               |   10 +
>   .../tests/ui/proc_macro_hack.stderr           |   26 +
>   .../proc-macro-error/tests/ui/result_ext.rs   |    7 +
>   .../tests/ui/result_ext.stderr                |   11 +
>   .../tests/ui/to_tokens_span.rs                |    6 +
>   .../tests/ui/to_tokens_span.stderr            |   11 +
>   .../tests/ui/unknown_setting.rs               |    4 +
>   .../tests/ui/unknown_setting.stderr           |    5 +
>   .../tests/ui/unrelated_panic.rs               |    6 +
>   .../tests/ui/unrelated_panic.stderr           |    7 +
>   .../vendor/proc-macro2/.cargo-checksum.json   |    1 +
>   .../char/pl011/vendor/proc-macro2/Cargo.toml  |  104 +
>   .../pl011/vendor/proc-macro2/LICENSE-APACHE   |  176 +
>   .../char/pl011/vendor/proc-macro2/LICENSE-MIT |   23 +
>   .../char/pl011/vendor/proc-macro2/README.md   |   94 +
>   .../hw/char/pl011/vendor/proc-macro2/build.rs |  227 +
>   .../pl011/vendor/proc-macro2/build/probe.rs   |   25 +
>   .../char/pl011/vendor/proc-macro2/meson.build |   19 +
>   .../vendor/proc-macro2/rust-toolchain.toml    |    2 +
>   .../pl011/vendor/proc-macro2/src/detection.rs |   75 +
>   .../pl011/vendor/proc-macro2/src/extra.rs     |  151 +
>   .../pl011/vendor/proc-macro2/src/fallback.rs  | 1226 ++++
>   .../char/pl011/vendor/proc-macro2/src/lib.rs  | 1369 +++++
>   .../pl011/vendor/proc-macro2/src/location.rs  |   29 +
>   .../pl011/vendor/proc-macro2/src/marker.rs    |   17 +
>   .../pl011/vendor/proc-macro2/src/parse.rs     |  996 ++++
>   .../pl011/vendor/proc-macro2/src/rcvec.rs     |  145 +
>   .../pl011/vendor/proc-macro2/src/wrapper.rs   |  993 ++++
>   .../vendor/proc-macro2/tests/comments.rs      |  105 +
>   .../vendor/proc-macro2/tests/features.rs      |    8 +
>   .../pl011/vendor/proc-macro2/tests/marker.rs  |  100 +
>   .../pl011/vendor/proc-macro2/tests/test.rs    |  905 +++
>   .../vendor/proc-macro2/tests/test_fmt.rs      |   28 +
>   .../vendor/proc-macro2/tests/test_size.rs     |   73 +
>   .../pl011/vendor/quote/.cargo-checksum.json   |    1 +
>   rust/hw/char/pl011/vendor/quote/Cargo.toml    |   50 +
>   .../hw/char/pl011/vendor/quote/LICENSE-APACHE |  176 +
>   rust/hw/char/pl011/vendor/quote/LICENSE-MIT   |   23 +
>   rust/hw/char/pl011/vendor/quote/README.md     |  272 +
>   rust/hw/char/pl011/vendor/quote/meson.build   |   17 +
>   .../pl011/vendor/quote/rust-toolchain.toml    |    2 +
>   rust/hw/char/pl011/vendor/quote/src/ext.rs    |  110 +
>   rust/hw/char/pl011/vendor/quote/src/format.rs |  168 +
>   .../pl011/vendor/quote/src/ident_fragment.rs  |   88 +
>   rust/hw/char/pl011/vendor/quote/src/lib.rs    | 1464 +++++
>   .../hw/char/pl011/vendor/quote/src/runtime.rs |  530 ++
>   .../hw/char/pl011/vendor/quote/src/spanned.rs |   50 +
>   .../char/pl011/vendor/quote/src/to_tokens.rs  |  209 +
>   .../pl011/vendor/quote/tests/compiletest.rs   |    7 +
>   rust/hw/char/pl011/vendor/quote/tests/test.rs |  549 ++
>   .../ui/does-not-have-iter-interpolated-dup.rs |    9 +
>   ...does-not-have-iter-interpolated-dup.stderr |   11 +
>   .../ui/does-not-have-iter-interpolated.rs     |    9 +
>   .../ui/does-not-have-iter-interpolated.stderr |   11 +
>   .../tests/ui/does-not-have-iter-separated.rs  |    5 +
>   .../ui/does-not-have-iter-separated.stderr    |   10 +
>   .../quote/tests/ui/does-not-have-iter.rs      |    5 +
>   .../quote/tests/ui/does-not-have-iter.stderr  |   10 +
>   .../vendor/quote/tests/ui/not-quotable.rs     |    7 +
>   .../vendor/quote/tests/ui/not-quotable.stderr |   20 +
>   .../vendor/quote/tests/ui/not-repeatable.rs   |    8 +
>   .../quote/tests/ui/not-repeatable.stderr      |   34 +
>   .../vendor/quote/tests/ui/wrong-type-span.rs  |    7 +
>   .../quote/tests/ui/wrong-type-span.stderr     |   10 +
>   .../pl011/vendor/syn/.cargo-checksum.json     |    1 +
>   rust/hw/char/pl011/vendor/syn/Cargo.toml      |  260 +
>   rust/hw/char/pl011/vendor/syn/LICENSE-APACHE  |  176 +
>   rust/hw/char/pl011/vendor/syn/LICENSE-MIT     |   23 +
>   rust/hw/char/pl011/vendor/syn/README.md       |  284 +
>   rust/hw/char/pl011/vendor/syn/benches/file.rs |   57 +
>   rust/hw/char/pl011/vendor/syn/benches/rust.rs |  182 +
>   rust/hw/char/pl011/vendor/syn/meson.build     |   24 +
>   rust/hw/char/pl011/vendor/syn/src/attr.rs     |  793 +++
>   rust/hw/char/pl011/vendor/syn/src/bigint.rs   |   66 +
>   rust/hw/char/pl011/vendor/syn/src/buffer.rs   |  434 ++
>   rust/hw/char/pl011/vendor/syn/src/classify.rs |  377 ++
>   .../pl011/vendor/syn/src/custom_keyword.rs    |  260 +
>   .../vendor/syn/src/custom_punctuation.rs      |  304 +
>   rust/hw/char/pl011/vendor/syn/src/data.rs     |  423 ++
>   rust/hw/char/pl011/vendor/syn/src/derive.rs   |  259 +
>   .../char/pl011/vendor/syn/src/discouraged.rs  |  225 +
>   rust/hw/char/pl011/vendor/syn/src/drops.rs    |   58 +
>   rust/hw/char/pl011/vendor/syn/src/error.rs    |  467 ++
>   rust/hw/char/pl011/vendor/syn/src/export.rs   |   73 +
>   rust/hw/char/pl011/vendor/syn/src/expr.rs     | 3960 +++++++++++++
>   rust/hw/char/pl011/vendor/syn/src/ext.rs      |  136 +
>   rust/hw/char/pl011/vendor/syn/src/file.rs     |  130 +
>   rust/hw/char/pl011/vendor/syn/src/fixup.rs    |  218 +
>   .../hw/char/pl011/vendor/syn/src/gen/clone.rs | 2209 +++++++
>   .../hw/char/pl011/vendor/syn/src/gen/debug.rs | 3160 ++++++++++
>   rust/hw/char/pl011/vendor/syn/src/gen/eq.rs   | 2242 +++++++
>   rust/hw/char/pl011/vendor/syn/src/gen/fold.rs | 3779 ++++++++++++
>   rust/hw/char/pl011/vendor/syn/src/gen/hash.rs | 2807 +++++++++
>   .../hw/char/pl011/vendor/syn/src/gen/visit.rs | 3858 ++++++++++++
>   .../pl011/vendor/syn/src/gen/visit_mut.rs     | 3855 ++++++++++++
>   rust/hw/char/pl011/vendor/syn/src/generics.rs | 1286 ++++
>   rust/hw/char/pl011/vendor/syn/src/group.rs    |  291 +
>   rust/hw/char/pl011/vendor/syn/src/ident.rs    |  108 +
>   rust/hw/char/pl011/vendor/syn/src/item.rs     | 3441 +++++++++++
>   rust/hw/char/pl011/vendor/syn/src/lib.rs      | 1019 ++++
>   rust/hw/char/pl011/vendor/syn/src/lifetime.rs |  156 +
>   rust/hw/char/pl011/vendor/syn/src/lit.rs      | 1830 ++++++
>   .../hw/char/pl011/vendor/syn/src/lookahead.rs |  169 +
>   rust/hw/char/pl011/vendor/syn/src/mac.rs      |  223 +
>   rust/hw/char/pl011/vendor/syn/src/macros.rs   |  166 +
>   rust/hw/char/pl011/vendor/syn/src/meta.rs     |  427 ++
>   rust/hw/char/pl011/vendor/syn/src/op.rs       |  219 +
>   rust/hw/char/pl011/vendor/syn/src/parse.rs    | 1397 +++++
>   .../pl011/vendor/syn/src/parse_macro_input.rs |  128 +
>   .../char/pl011/vendor/syn/src/parse_quote.rs  |  210 +
>   rust/hw/char/pl011/vendor/syn/src/pat.rs      |  953 +++
>   rust/hw/char/pl011/vendor/syn/src/path.rs     |  886 +++
>   .../char/pl011/vendor/syn/src/precedence.rs   |  163 +
>   rust/hw/char/pl011/vendor/syn/src/print.rs    |   16 +
>   .../char/pl011/vendor/syn/src/punctuated.rs   | 1132 ++++
>   .../char/pl011/vendor/syn/src/restriction.rs  |  176 +
>   rust/hw/char/pl011/vendor/syn/src/sealed.rs   |    4 +
>   rust/hw/char/pl011/vendor/syn/src/span.rs     |   63 +
>   rust/hw/char/pl011/vendor/syn/src/spanned.rs  |  118 +
>   rust/hw/char/pl011/vendor/syn/src/stmt.rs     |  481 ++
>   rust/hw/char/pl011/vendor/syn/src/thread.rs   |   60 +
>   rust/hw/char/pl011/vendor/syn/src/token.rs    | 1138 ++++
>   rust/hw/char/pl011/vendor/syn/src/tt.rs       |  107 +
>   rust/hw/char/pl011/vendor/syn/src/ty.rs       | 1216 ++++
>   rust/hw/char/pl011/vendor/syn/src/verbatim.rs |   33 +
>   .../char/pl011/vendor/syn/src/whitespace.rs   |   65 +
>   .../char/pl011/vendor/syn/tests/common/eq.rs  |  900 +++
>   .../char/pl011/vendor/syn/tests/common/mod.rs |   28 +
>   .../pl011/vendor/syn/tests/common/parse.rs    |   49 +
>   .../char/pl011/vendor/syn/tests/debug/gen.rs  | 5163 +++++++++++++++++
>   .../char/pl011/vendor/syn/tests/debug/mod.rs  |  147 +
>   .../char/pl011/vendor/syn/tests/macros/mod.rs |   93 +
>   .../char/pl011/vendor/syn/tests/regression.rs |    5 +
>   .../vendor/syn/tests/regression/issue1108.rs  |    5 +
>   .../vendor/syn/tests/regression/issue1235.rs  |   32 +
>   .../char/pl011/vendor/syn/tests/repo/mod.rs   |  461 ++
>   .../pl011/vendor/syn/tests/repo/progress.rs   |   37 +
>   .../pl011/vendor/syn/tests/test_asyncness.rs  |   43 +
>   .../pl011/vendor/syn/tests/test_attribute.rs  |  225 +
>   .../vendor/syn/tests/test_derive_input.rs     |  781 +++
>   .../char/pl011/vendor/syn/tests/test_expr.rs  |  692 +++
>   .../pl011/vendor/syn/tests/test_generics.rs   |  282 +
>   .../pl011/vendor/syn/tests/test_grouping.rs   |   53 +
>   .../char/pl011/vendor/syn/tests/test_ident.rs |   87 +
>   .../char/pl011/vendor/syn/tests/test_item.rs  |  332 ++
>   .../pl011/vendor/syn/tests/test_iterators.rs  |   70 +
>   .../char/pl011/vendor/syn/tests/test_lit.rs   |  331 ++
>   .../char/pl011/vendor/syn/tests/test_meta.rs  |  154 +
>   .../vendor/syn/tests/test_parse_buffer.rs     |  103 +
>   .../vendor/syn/tests/test_parse_quote.rs      |  166 +
>   .../vendor/syn/tests/test_parse_stream.rs     |  187 +
>   .../char/pl011/vendor/syn/tests/test_pat.rs   |  152 +
>   .../char/pl011/vendor/syn/tests/test_path.rs  |  130 +
>   .../pl011/vendor/syn/tests/test_precedence.rs |  537 ++
>   .../pl011/vendor/syn/tests/test_receiver.rs   |  321 +
>   .../pl011/vendor/syn/tests/test_round_trip.rs |  253 +
>   .../pl011/vendor/syn/tests/test_shebang.rs    |   67 +
>   .../char/pl011/vendor/syn/tests/test_size.rs  |   36 +
>   .../char/pl011/vendor/syn/tests/test_stmt.rs  |  322 +
>   .../vendor/syn/tests/test_token_trees.rs      |   32 +
>   .../hw/char/pl011/vendor/syn/tests/test_ty.rs |  397 ++
>   .../pl011/vendor/syn/tests/test_visibility.rs |  185 +
>   .../char/pl011/vendor/syn/tests/zzz_stable.rs |   33 +
>   .../vendor/unicode-ident/.cargo-checksum.json |    1 +
>   .../pl011/vendor/unicode-ident/Cargo.toml     |   63 +
>   .../pl011/vendor/unicode-ident/LICENSE-APACHE |  176 +
>   .../pl011/vendor/unicode-ident/LICENSE-MIT    |   23 +
>   .../vendor/unicode-ident/LICENSE-UNICODE      |   46 +
>   .../char/pl011/vendor/unicode-ident/README.md |  283 +
>   .../pl011/vendor/unicode-ident/benches/xid.rs |  124 +
>   .../pl011/vendor/unicode-ident/meson.build    |   14 +
>   .../pl011/vendor/unicode-ident/src/lib.rs     |  269 +
>   .../pl011/vendor/unicode-ident/src/tables.rs  |  651 +++
>   .../vendor/unicode-ident/tests/compare.rs     |   67 +
>   .../vendor/unicode-ident/tests/fst/mod.rs     |   11 +
>   .../unicode-ident/tests/fst/xid_continue.fst  |  Bin 0 -> 73249 bytes
>   .../unicode-ident/tests/fst/xid_start.fst     |  Bin 0 -> 65487 bytes
>   .../vendor/unicode-ident/tests/roaring/mod.rs |   21 +
>   .../vendor/unicode-ident/tests/static_size.rs |   95 +
>   .../vendor/unicode-ident/tests/tables/mod.rs  |    7 +
>   .../unicode-ident/tests/tables/tables.rs      |  347 ++
>   .../vendor/unicode-ident/tests/trie/mod.rs    |    7 +
>   .../vendor/unicode-ident/tests/trie/trie.rs   |  445 ++
>   .../vendor/version_check/.cargo-checksum.json |    1 +
>   .../pl011/vendor/version_check/Cargo.toml     |   24 +
>   .../pl011/vendor/version_check/LICENSE-APACHE |  201 +
>   .../pl011/vendor/version_check/LICENSE-MIT    |   19 +
>   .../char/pl011/vendor/version_check/README.md |   80 +
>   .../pl011/vendor/version_check/meson.build    |   14 +
>   .../pl011/vendor/version_check/src/channel.rs |  193 +
>   .../pl011/vendor/version_check/src/date.rs    |  203 +
>   .../pl011/vendor/version_check/src/lib.rs     |  493 ++
>   .../pl011/vendor/version_check/src/version.rs |  316 +
>   rust/hw/meson.build                           |    1 +
>   rust/meson.build                              |   15 +
>   rust/qemu-api/.gitignore                      |    2 +
>   rust/qemu-api/Cargo.lock                      |    7 +
>   rust/qemu-api/Cargo.toml                      |   23 +
>   rust/qemu-api/README.md                       |   17 +
>   rust/qemu-api/build.rs                        |   13 +
>   rust/qemu-api/meson.build                     |   19 +
>   rust/qemu-api/rustfmt.toml                    |    1 +
>   rust/qemu-api/src/bindings.rs                 |    7 +
>   rust/qemu-api/src/definitions.rs              |  107 +
>   rust/qemu-api/src/device_class.rs             |  128 +
>   rust/qemu-api/src/lib.rs                      |  100 +
>   rust/qemu-api/src/tests.rs                    |   48 +
>   rust/rustfmt.toml                             |    7 +
>   .../ci/setup/ubuntu/ubuntu-2204-aarch64.yaml  |    3 +
>   .../ci/setup/ubuntu/ubuntu-2204-s390x.yaml    |    3 +
>   scripts/meson-buildoptions.sh                 |    3 +
>   scripts/rustc_args.py                         |   84 +
>   tests/docker/dockerfiles/alpine.docker        |    3 +
>   tests/docker/dockerfiles/centos9.docker       |    3 +
>   .../dockerfiles/debian-amd64-cross.docker     |    4 +
>   .../dockerfiles/debian-arm64-cross.docker     |    4 +
>   .../dockerfiles/debian-armel-cross.docker     |    4 +
>   .../dockerfiles/debian-armhf-cross.docker     |    4 +
>   .../dockerfiles/debian-i686-cross.docker      |    4 +
>   .../dockerfiles/debian-mips64el-cross.docker  |    4 +
>   .../dockerfiles/debian-mipsel-cross.docker    |    4 +
>   .../dockerfiles/debian-ppc64el-cross.docker   |    4 +
>   .../dockerfiles/debian-s390x-cross.docker     |    4 +
>   tests/docker/dockerfiles/debian.docker        |    3 +
>   .../dockerfiles/fedora-win64-cross.docker     |    3 +
>   tests/docker/dockerfiles/fedora.docker        |    3 +
>   tests/docker/dockerfiles/opensuse-leap.docker |    2 +
>   tests/docker/dockerfiles/ubuntu2204.docker    |    3 +
>   tests/lcitool/libvirt-ci                      |    2 +-
>   tests/lcitool/projects/qemu.yml               |    3 +
>   tests/vm/generated/freebsd.json               |    2 +
>   432 files changed, 111104 insertions(+), 16 deletions(-)
>   create mode 100644 rust/hw/char/pl011/vendor/either/README.rst
>   create mode 100644 rust/wrapper.h
>   create mode 100644 rust/.gitignore
>   create mode 100644 rust/Kconfig
>   create mode 100644 rust/hw/Kconfig
>   create mode 100644 rust/hw/char/Kconfig
>   create mode 100644 rust/hw/char/meson.build
>   create mode 100644 rust/hw/char/pl011/.gitignore
>   create mode 100644 rust/hw/char/pl011/Cargo.lock
>   create mode 100644 rust/hw/char/pl011/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/README.md
>   create mode 100644 rust/hw/char/pl011/meson.build
>   create mode 120000 rust/hw/char/pl011/rustfmt.toml
>   create mode 100644 rust/hw/char/pl011/src/definitions.rs
>   create mode 100644 rust/hw/char/pl011/src/device.rs
>   create mode 100644 rust/hw/char/pl011/src/device_class.rs
>   create mode 100644 rust/hw/char/pl011/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/CHANGELOG.md
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/LICENSE.txt
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/tests/tests.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize/split.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize_internal.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize_internal/struct_gen.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/debug_bits.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/default_bits.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/fmt_bits.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/from_bits.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/discriminant_assigner.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/fallback.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/util.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/try_from_bits.rs
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/bilge/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/either/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/either/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/either/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/either/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/either/README-crates.io.md
>   create mode 100644 rust/hw/char/pl011/vendor/either/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/either/src/into_either.rs
>   create mode 100644 rust/hw/char/pl011/vendor/either/src/iterator.rs
>   create mode 100644 rust/hw/char/pl011/vendor/either/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/either/src/serde_untagged.rs
>   create mode 100644 rust/hw/char/pl011/vendor/either/src/serde_untagged_optional.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/CHANGELOG.md
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/Cargo.lock
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/bench1.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/combinations.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/combinations_with_replacement.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/extra/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/extra/zipslices.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/fold_specialization.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/powerset.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tree_fold1.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tuple_combinations.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tuples.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/examples/iris.data
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/examples/iris.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/coalesce.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/map.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/multi_product.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/combinations.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/combinations_with_replacement.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/concat_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/cons_tuples_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/diff.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/duplicates_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/either_or_both.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/exactly_one_err.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/extrema_set.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/flatten_ok.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/format.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/free.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/group_map.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/groupbylazy.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/grouping_map.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/impl_macros.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/intersperse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/k_smallest.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/kmerge_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/lazy_buffer.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/merge_join.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/minmax.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/multipeek_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/pad_tail.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/peek_nth.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/peeking_take_while.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/permutations.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/powerset.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/process_results_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/put_back_n_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/rciter_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/repeatn.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/size_hint.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/sources.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/take_while_inclusive.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/tee.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/tuple_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/unique_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/unziptuple.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/with_position.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/zip_eq_impl.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/zip_longest.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/src/ziptuple.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/adaptors_no_collect.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/flatten_ok.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/macros_hygiene.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/merge_join.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/peeking_take_while.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/quick.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/specializations.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/test_core.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/test_std.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/tuples.rs
>   create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/zip.rs
>   create mode 100644 rust/hw/char/pl011/vendor/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/build.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/parse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/settings.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/CHANGELOG.md
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/build.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/diagnostic.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/dummy.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/imp/delegate.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/imp/fallback.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/macros.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/sealed.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/macro-errors.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ok.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/runtime-errors.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/abort.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/abort.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/append_dummy.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/append_dummy.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/children_messages.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/children_messages.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/dummy.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/dummy.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/emit.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/emit.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/explicit_span_range.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/explicit_span_range.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/misuse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/misuse.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/multiple_tokens.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/multiple_tokens.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/not_proc_macro.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/not_proc_macro.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/option_ext.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/option_ext.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/proc_macro_hack.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/proc_macro_hack.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/result_ext.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/result_ext.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/to_tokens_span.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/to_tokens_span.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unknown_setting.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unknown_setting.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unrelated_panic.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unrelated_panic.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/build.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/build/probe.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/rust-toolchain.toml
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/detection.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/extra.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/fallback.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/location.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/marker.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/parse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/rcvec.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/wrapper.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/comments.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/features.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/marker.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test_fmt.rs
>   create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test_size.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/quote/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/quote/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/quote/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/quote/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/quote/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/quote/rust-toolchain.toml
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/ext.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/format.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/ident_fragment.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/runtime.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/spanned.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/src/to_tokens.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/compiletest.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/test.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated-dup.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated-dup.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-separated.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-separated.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-quotable.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-quotable.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-repeatable.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-repeatable.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/wrong-type-span.rs
>   create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/wrong-type-span.stderr
>   create mode 100644 rust/hw/char/pl011/vendor/syn/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/syn/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/syn/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/syn/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/syn/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/syn/benches/file.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/benches/rust.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/attr.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/bigint.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/buffer.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/classify.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/custom_keyword.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/custom_punctuation.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/data.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/derive.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/discouraged.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/drops.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/error.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/export.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/expr.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/ext.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/file.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/fixup.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/clone.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/debug.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/eq.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/fold.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/hash.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/visit.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/visit_mut.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/generics.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/group.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/ident.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/item.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/lifetime.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/lit.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/lookahead.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/mac.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/macros.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/meta.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/op.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse_macro_input.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse_quote.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/pat.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/path.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/precedence.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/print.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/punctuated.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/restriction.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/sealed.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/span.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/spanned.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/stmt.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/thread.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/token.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/tt.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/ty.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/verbatim.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/src/whitespace.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/eq.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/parse.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/debug/gen.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/debug/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/macros/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression/issue1108.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression/issue1235.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/repo/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/repo/progress.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_asyncness.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_attribute.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_derive_input.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_expr.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_generics.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_grouping.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_ident.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_item.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_iterators.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_lit.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_meta.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_buffer.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_quote.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_stream.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_pat.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_path.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_precedence.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_receiver.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_round_trip.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_shebang.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_size.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_stmt.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_token_trees.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_ty.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_visibility.rs
>   create mode 100644 rust/hw/char/pl011/vendor/syn/tests/zzz_stable.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-UNICODE
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/benches/xid.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/src/tables.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/compare.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/xid_continue.fst
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/xid_start.fst
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/roaring/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/static_size.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/tables/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/tables/tables.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/trie/mod.rs
>   create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/trie/trie.rs
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/.cargo-checksum.json
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/Cargo.toml
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/LICENSE-APACHE
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/LICENSE-MIT
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/README.md
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/meson.build
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/src/channel.rs
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/src/date.rs
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/src/lib.rs
>   create mode 100644 rust/hw/char/pl011/vendor/version_check/src/version.rs
>   create mode 100644 rust/hw/meson.build
>   create mode 100644 rust/meson.build
>   create mode 100644 rust/qemu-api/.gitignore
>   create mode 100644 rust/qemu-api/Cargo.lock
>   create mode 100644 rust/qemu-api/Cargo.toml
>   create mode 100644 rust/qemu-api/README.md
>   create mode 100644 rust/qemu-api/build.rs
>   create mode 100644 rust/qemu-api/meson.build
>   create mode 120000 rust/qemu-api/rustfmt.toml
>   create mode 100644 rust/qemu-api/src/bindings.rs
>   create mode 100644 rust/qemu-api/src/definitions.rs
>   create mode 100644 rust/qemu-api/src/device_class.rs
>   create mode 100644 rust/qemu-api/src/lib.rs
>   create mode 100644 rust/qemu-api/src/tests.rs
>   create mode 100644 rust/rustfmt.toml
>   create mode 100644 scripts/rustc_args.py
> 
> 
> base-commit: a7ddb48bd1363c8bcdf42776d320289c42191f01


