Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A5C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 21:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIZwF-0006YD-G6; Fri, 23 May 2025 17:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uIZwC-0006Y1-QN
 for qemu-devel@nongnu.org; Fri, 23 May 2025 17:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uIZwA-0004sr-Ki
 for qemu-devel@nongnu.org; Fri, 23 May 2025 17:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748035696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wYTZ8zDa4uffjfzVQv/9fyb8fWL417T8ICDraF9wJAs=;
 b=K8edXezho0BK+xrR/ZUhaUQLJzzBTlFw2LWhPCKCf3vSEEZNL3mAGrKz8/xYAUEwfDTGtp
 DOAHWN+pGM7c4zh+pZ2wGyV1SvvpxqiUrUpGWxBOu6WuK6CkjCWA5DgpEDRwGCrBM4DXev
 0Is6cC0Q3cYNKcNDdMmiM6RUsetLRhs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-WV_oPs7KMGOScxnMegB76g-1; Fri, 23 May 2025 17:28:14 -0400
X-MC-Unique: WV_oPs7KMGOScxnMegB76g-1
X-Mimecast-MFC-AGG-ID: WV_oPs7KMGOScxnMegB76g_1748035694
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so928065e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 14:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748035693; x=1748640493;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wYTZ8zDa4uffjfzVQv/9fyb8fWL417T8ICDraF9wJAs=;
 b=KNikn++FGAp9dIeBcgq/q1vlrNHZqOO3VyJCI5Ziz9Or8L1xZRy24SDB75iXcbJ/3a
 NK+Ba576TXLObCSEVtrC7otbtcwuTg+pk27FA0R9QK72X3/zUFBsL5fwiorDjE7r3rAa
 CGpqaFJGUGayp0Pic94lNYBhxzIDpDWt7IKLAHPr6lerlMwXHhWVnvEfrzEGZQRXjIeo
 IgtlMg5XUpzemO5/WGmGGQ4kD9tMyUJ2hgMZtKHesXA4hLqL7l6mVGF6SYG9+gK9Znxn
 W3apAa5f0z6ymOphUBZtf1Skmn7fhct9nTCSmMLed4DMVzqYlMbJeOxLFUvIx5iPz5IH
 PRig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ4DNFlQhFVMCGBs/LAr3q2xcUzVKDupcjwmQD9Lf/RQXBldDYeNedB4RvzNnINFMPN7LfoSGmsB/t@nongnu.org
X-Gm-Message-State: AOJu0YwZz5ad1mz4Ncu69pt1IoXB//VA7tijy1LxEtNS1Val+W70YTdf
 14PvXywW88KH1N/Olmer+IrtF59VYRJwKuGHwTYQJvcyoB29qF0gpLJ16jB4y1P0KCg3VgWNnwB
 XrH/poGCBfd4PsQ1qHjtcFi1HsfWhzWzuuKRE9N1K0VxCx7lS75OR0+O4
X-Gm-Gg: ASbGnctGNwK/Kqcl2MXfNfnFJuoELULmHLLNy8R6kjGs0cNOd5vByh2Nqg/l3wLzD5x
 EPEGbdzPpHLdmm9flCH/m4YSSaR6HfvIut8X0i00eNoNY2k3fd3y87YLtuGnHXy0L+LJJkX7THy
 zQEaCP4AMrmVIKYjNnH5Nd6+cTHheiu738R0fhgsO1oEyB19Y8nPQsqmuJ9vsieGx6zRoFlqYwP
 V/xniM2PkRhfFX+LMTq79jAdlirgx+Og4Uhacyl2dqBNDUKDTHFQukuUZ0EyrQTU+Eb5rRsyuwc
 KT8s8zIcLt6zfQ==
X-Received: by 2002:a05:6000:2908:b0:3a3:5c7c:18a7 with SMTP id
 ffacd0b85a97d-3a4cb4ad7famr650011f8f.52.1748035693599; 
 Fri, 23 May 2025 14:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9zCiIny4g8qy02Rxb5+2/4EZDgHoi+zBPGtzScEPI4zjFoLavpXb5BOnp0ZAIy3h/Pp75g==
X-Received: by 2002:a05:6000:2908:b0:3a3:5c7c:18a7 with SMTP id
 ffacd0b85a97d-3a4cb4ad7famr650004f8f.52.1748035693241; 
 Fri, 23 May 2025 14:28:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889a7sm27984635f8f.72.2025.05.23.14.28.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 14:28:12 -0700 (PDT)
Message-ID: <250a2a35-478f-4b3e-a517-27a0cd4fb51e@redhat.com>
Date: Fri, 23 May 2025 23:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: fix Windows build
To: oltolm <oleg.tolmatcev@gmail.com>, qemu-devel@nongnu.org
References: <20250523195703.168-2-oleg.tolmatcev@gmail.com>
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
In-Reply-To: <20250523195703.168-2-oleg.tolmatcev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 5/23/25 21:57, oltolm wrote:
> The build failed when run on Windows. I replaced calls to Unix programs
> like `cat` and `true` with calls to `python`. I wrapped calls to
> `os.path.relpath` in try-except because it can fail when the two paths
> are on different drives. I made sure to convert the Windows paths to
> Unix paths to prevent warnings in generated files.

Thanks for the patch!  The Windows build configurations that we support 
currently are cross-building from Linux and native build with MSYS2. 
MSYS2 is sufficiently POSIX-like, and also has a nice package manager.

Can you share how you set up your build environment, and especially 
where you get all the dependencies?  Generally we'd prefer to have it 
covered in CI to avoid that it breaks again.

Some more comments below.

>   import os.path
> +from pathlib import PurePath
>   
>   from tracetool import out
>   
> @@ -30,6 +31,12 @@ def generate_h(event, group):
>       if len(event.args) > 0:
>           argnames = ", " + argnames
>   
> +    try:
> +        event_filename = os.path.relpath(event.filename)
> +    except ValueError:
> +        event_filename = event.filename

Can this actually happen during the build?  (Same for other backends)

> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cf..2e3bd4057 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -413,4 +413,4 @@ endforeach
>   
>   run_target('precache-functional',
>              depends: precache_all,
> -           command: ['true'])
> +           command: [python, '-c', ''])

I wonder if this can be replaced with alias_target() too; and also the 
pre-existing code suggests that alias_target needs at least one target, 
but is that really true?

So, maybe all or most uses of 'true' can just go away.

> diff --git a/trace/meson.build b/trace/meson.build
> index 3df454935..3a318713c 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -4,7 +4,7 @@ trace_events_files = []
>   foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events
>     if item in qapi_trace_events
>       trace_events_file = item
> -    group_name = item.full_path().split('/')[-1].underscorify()
> +    group_name = fs.name(item).underscorify()

Even better.

>   trace_events_all = custom_target('trace-events-all',
>                                    output: 'trace-events-all',
>                                    input: trace_events_files,
> -                                 command: [ 'cat', '@INPUT@' ],
> +                                 command: [ python, '-c', 'import fileinput;[print(line) for line in fileinput.input()]', '@INPUT@' ],

Maybe put the command in a variable name cat, like

cat = [ python, '-c',
   'import fileinput;[print(line) for line in fileinput.input()]']

Thanks,

Paolo


