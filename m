Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C422E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 12:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVrPv-0007tu-El; Thu, 09 Jan 2025 07:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVrPn-0007sL-4F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVrPf-0006Pv-L5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 07:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736424801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=95jH6vHVWwQhzjGzsxp2UEhTwqVMJr7Wv8BTRN7e3fA=;
 b=g82AjQsLcc3MNs6haLiwyR4l/ecMLqGHtEzLlF5sdf16RNbQOlVpjLvh0ayC3qxC60xpPF
 ybXxnXzx70eYIGS397VVVxeXZUMPoKTgZqMe5P8clkATiPJ446mdkYaJxiniZIlcVG+5iT
 e+Pw2FWS0VbQnOWma+7WuXEr78yxhIE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-Ix9xtcgoODaCJHKU0h4_Ng-1; Thu, 09 Jan 2025 07:13:20 -0500
X-MC-Unique: Ix9xtcgoODaCJHKU0h4_Ng-1
X-Mimecast-MFC-AGG-ID: Ix9xtcgoODaCJHKU0h4_Ng
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3ff30b566so738831a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 04:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736424799; x=1737029599;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=95jH6vHVWwQhzjGzsxp2UEhTwqVMJr7Wv8BTRN7e3fA=;
 b=vlED07fcqTCZeIe4CpWNAdNSAsMSjcZQRU4EYqT+7cnlCsdTpKNLiozr8Qm0pN301B
 gHGY08siSjTMhqpV4z+wzo/Hf4gJSM8bBaUuikmxDjak7yNMPxwT/qQMF3k8CbVaQPnf
 zg0tbTvlgCimDfr/dbqNPxE5aVdGCi9miXXtLL5l9KWLDt03oZq4REO5wfq+gaoJJEE1
 l690q6qiCrhckTHy4k+oa53usSHMEA39Grn6XS9OI7brmexTuHnOaT50PqpKEC42l47v
 FkNedCYLB7pI60IF/N2xn772QPq0AnGE+jF86EtRWgX0KMZfepHp4eGomVSH3qKE0RKV
 kdeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcLS0EGOgFUCgnm2h3nQLOxK8CLzdvyBZi4DWoVha2fC4SliQBddKUorekM22kbhjhr5q8dH//hMLY@nongnu.org
X-Gm-Message-State: AOJu0YyCgKVIw7i90mVS1tra21egz4/KKyd7wr7AxmnakcqmzRY1Wpjo
 arRwLjMEaF4+t7QrOhaSKgM3OiCV6e4PV9IcxW/1hDCVM/jeduCj4qkq00uP8W/SIUgGJ5DKaME
 5ldpEh55Uw5JNrHnP74NVyRZ8RDTdWg4PKKPw30Lwk+mXU4krURBF
X-Gm-Gg: ASbGnctaRMVIOtOEMkM0tFTAvorIFfhpAWMLhdJCDJ+DK5NJ2+CX7EvsN1rQq2VOtQ5
 C+C8BQdNg4Ff/rHfJ1IhiQoBkLFWVbyzoKrO0J8cJ39KxaY/lnr7JH4aJa3VFhtCcGZJBfvZmSl
 dCjJ5WU0G9F7UmSRAWtlg4a2W5RDPOu5bsFFBccHuog8pi0JbZwOAtkTOfBFdz0soGSBYGG5/BB
 2dqPclWb5pRFkJfvY5YLL5Mu0l9b60hPVbVOxeIduyTLZjBB5z4hhjMNdMf
X-Received: by 2002:a05:6402:3585:b0:5cf:e66f:678d with SMTP id
 4fb4d7f45d1cf-5d972e6f913mr5652931a12.28.1736424798769; 
 Thu, 09 Jan 2025 04:13:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9rhwhUAjzLXa6pmibkSNUzwF7xZ3fheV8aTbYk0X/WzOQNG4OgUFHzQn/00A/cKdGHYBvdQ==
X-Received: by 2002:a05:6402:3585:b0:5cf:e66f:678d with SMTP id
 4fb4d7f45d1cf-5d972e6f913mr5652903a12.28.1736424798385; 
 Thu, 09 Jan 2025 04:13:18 -0800 (PST)
Received: from [192.168.10.27] ([151.62.105.73])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046d7d5sm528421a12.66.2025.01.09.04.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 04:13:17 -0800 (PST)
Message-ID: <82cc1e4a-7035-457e-a020-9a5e12f9a30c@redhat.com>
Date: Thu, 9 Jan 2025 13:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 30/32] pc-bios: ensure keymaps dependencies set vnc
 tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Maydell
 <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
 <20250108121054.1126164-31-alex.bennee@linaro.org>
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
In-Reply-To: <20250108121054.1126164-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/8/25 13:10, Alex Bennée wrote:
> I was seeing failures on vnc-display-test on FreeBSD:
> 
>    make vm-build-freebsd V=1 TARGET_LIST=aarch64-softmmu BUILD_TARGET=check-qtest QEMU_LOCAL=1 DEBUG=1
> 
> Leads to:
> 
>    qemu-system-aarch64: -vnc none: could not read keymap file: 'en-us'
>    Broken pipe
>    ../src/tests/qtest/libqtest.c:196: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> 
> which was as far as I could tell because we don't populate the
> $BLD/pc-bios/keymaps (although something attempts to symlink
> qemu-bundle/usr/local/share/qemu/keymaps/ to that dir).

That something being scripts/symlink-install-tree.py.

This is where QEMU looks for the keymaps and your patch ensures that it 
is populated before running the test.  Please add the above info to the 
commit message just for accuracy; otherwise:

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   pc-bios/keymaps/meson.build | 17 ++++++++---------
>   tests/qtest/meson.build     |  2 +-
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
> index 0bd8ce0077..a79a09b276 100644
> --- a/pc-bios/keymaps/meson.build
> +++ b/pc-bios/keymaps/meson.build
> @@ -39,19 +39,18 @@ else
>     native_qemu_keymap = qemu_keymap
>   endif
>   
> +keymap_targets = []
>   if native_qemu_keymap.found()
> -  t = []
>     foreach km, args: keymaps
>       # generate with qemu-kvm
> -    t += custom_target(km,
> -                       build_by_default: true,
> -                       output: km,
> -                       command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
> -                       install: have_system,
> -                       install_dir: qemu_datadir / 'keymaps')
> +    keymap_targets += custom_target(km,
> +                                    build_by_default: true,
> +                                    output: km,
> +                                    command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
> +                                    install: have_system,
> +                                    install_dir: qemu_datadir / 'keymaps')
>     endforeach
> -
> -  alias_target('update-keymaps', t)
> +  alias_target('update-keymaps', keymap_targets)
>   else
>     install_data(keymaps.keys(), install_dir: qemu_datadir / 'keymaps')
>   endif
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index c5a70021c5..f75c1057a4 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -383,7 +383,7 @@ qtests = {
>   if vnc.found()
>     gvnc = dependency('gvnc-1.0', method: 'pkg-config', required: false)
>     if gvnc.found()
> -    qtests += {'vnc-display-test': [gvnc]}
> +    qtests += {'vnc-display-test': [gvnc, keymap_targets]}
>       qtests_generic += [ 'vnc-display-test' ]
>     endif
>   endif


