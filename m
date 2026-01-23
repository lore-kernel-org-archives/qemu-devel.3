Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3821D74EED
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 15:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJWl-0003Eb-62; Fri, 23 Jan 2026 10:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjJWe-0003BO-TI
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:56:46 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vjJWd-00055Y-77
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 10:56:44 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82318b640beso595375b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769183800; x=1769788600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6t04NU0w884dfN28yF/6Ge0FsY+81Z3QWXgyOd1PAmg=;
 b=o2OklFLuGsZCJuf0SGRqVHA2Ybcxr7RrUQb4+V3X0eXIFlM3g+FVqsEtV3cR9iBECR
 S+MP12ErEwGWYtdulgULWz6auKVGfrPyfjmJloE4IVapgVKGOpgUUjvfBkeXCVPc6+ZA
 b5Jeh6nlLelK9KQr8YMEWySMCurmhDT4Zm0Wv3Bak11EH4qnQUMH3h3vAyy+/SfNqqph
 BIZ6o//VtxsYrfhbPxgBky/KrRLjRq6QI+VH3EPg9plWtMsxKz3qnDtZ4emSqGTS68GY
 Z4wjFD+aZW6L9ONWZo+h1eBXkC5hT2Lnf4NIDqoLIMh/gQHt5u9Rltwifnw17zWj0xWx
 mV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769183800; x=1769788600;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6t04NU0w884dfN28yF/6Ge0FsY+81Z3QWXgyOd1PAmg=;
 b=iKQxSD2CBXkXbBErVHdC3rKJVgrCpSBpqYQ4fxcCYltG+ExOIcN3NV0NLFWUxxmX0e
 EG5qAhhOgMBZ9vIQIPrJuda3+ZZiHD2hAFxGldit54sT+9YUAuW5yj0H11h7YNsPtA0P
 0Xfv+0gGQU/pAOLbh8NMtrMV4/PksOpGIUbFdpS+5sK0o4tid/VQ97DgqcNGf9fxR/Yw
 TQLf+5+aU8N009s/TQUPdK/4hl/L4gkH7yij7bLI1LJpP6nXqotVF2OrMgzP2yIsHBLl
 ASh6Xw5rvvR5uT+LX8NhWjcLeFSbccgs0Mu0QGIkuWTuHEQcOhR8d8rm6UBAJttO/vQE
 GMhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7aYl4Xlo+JUjzEMJEl65gIAvF4SJv6deUXLXgVVL4fFpa7iT/j3h4zXOYXW60IGeEsE6N01jnI4YU@nongnu.org
X-Gm-Message-State: AOJu0YxRI9cRDrWBgcbEHNlYpkapLayyZEq/oCgD/wHzjUmpblvVjAfq
 8iJLMa3dXy/iiUmz4u+e4kXYP3hwVzTPgE5AOU4TVuTDS45kY15Ge0CRBHGrPramGR8=
X-Gm-Gg: AZuq6aJtj9wxeJvS/afHSimpTEx/DnbrD4FBer6vpQRh5A98wfg4wJebOTs5P/w1LVh
 GmgOdtHYI63Obr+9Y7UtTOoiy263daf5quMiKvW3HIosRCbzwb6+Ez1HzupUIE0ONHmD7VNJbO4
 MaZCrlyMpXkgZjguOVQEYN71rfiICbSK+ABiVzzj7nDOEYNfQWxXAFrM2gjL559NaedHPIY4yGZ
 EPoCGeInQZMGsidgTr5gAZUZt9h2c1NKr/YxLY/vYUGtbGww8Lc2y084ist/QYRlvVCqgvuxBG8
 BjoofJIPFhi1IthPOrZcltXyHqAlLJ30NVggw1V0WjpjRmjYlPbToLYFCSRfMCpj1LmXIhF3aDQ
 BlCCW/KyvmOoktY/p/dTQInUoY0tf3IRGUd5iDFfxmWH4OIFsIhVgmq5s9Bf/djWq1Oha/SKr01
 O9zPA8tmj0ONGwUH4c9nqjD8jjLY6aKNbkOIP27Ga5cHOWn5Qn6+sqz5JzdpPMjYmevlY=
X-Received: by 2002:a05:6a00:1d9e:b0:823:16b2:2498 with SMTP id
 d2e1a72fcca58-82317e0091amr2720434b3a.36.1769183799926; 
 Fri, 23 Jan 2026 07:56:39 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8231876e718sm2554003b3a.62.2026.01.23.07.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 07:56:39 -0800 (PST)
Message-ID: <4163b033-426c-47f0-91f9-3ef76dec3fec@linaro.org>
Date: Fri, 23 Jan 2026 07:56:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 xsDNBGK9dgwBDACYuRpR31LD+BnJ0M4b5YnPZKbj+gyu82IDN0MeMf2PGf1sux+1O2ryzmnA
 eOiRCUY9l7IbtPYPHN5YVx+7W3vo6v89I7mL940oYAW8loPZRSMbyCiUeSoiN4gWPXetoNBg
 CJmXbVYQgL5e6rsXoMlwFWuGrBY3Ig8YhEqpuYDkRXj2idO11CiDBT/b8A2aGixnpWV/s+AD
 gUyEVjHU6Z8UervvuNKlRUNE0rUfc502Sa8Azdyda8a7MAyrbA/OI0UnSL1m+pXXCxOxCvtU
 qOlipoCOycBjpLlzjj1xxRci+ssiZeOhxdejILf5LO1gXf6pP+ROdW4ySp9L3dAWnNDcnj6U
 2voYk7/RpRUTpecvkxnwiOoiIQ7BatjkssFy+0sZOYNbOmoqU/Gq+LeFqFYKDV8gNmAoxBvk
 L6EtXUNfTBjiMHyjA/HMMq27Ja3/Y73xlFpTVp7byQoTwF4p1uZOOXjFzqIyW25GvEekDRF8
 IpYd6/BomxHzvMZ2sQ/VXaMAEQEAAc0uUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
 dmllckBsaW5hcm8ub3JnPsLBDgQTAQoAOBYhBGa5lOyhT38uWroIH3+QVA0KHNAPBQJivXYM
 AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH+QVA0KHNAPX58L/1DYzrEO4TU9ZhJE
 tKcw/+mCZrzHxPNlQtENJ5NULAJWVaJ/8kRQ3Et5hQYhYDKK+3I+0Tl/tYuUeKNV74dFE7mv
 PmikCXBGN5hv5povhinZ9T14S2xkMgym2T3DbkeaYFSmu8Z89jm/AQVt3ZDRjV6vrVfvVW0L
 F6wPJSOLIvKjOc8/+NXrKLrV/YTEi2R1ovIPXcK7NP6tvzAEgh76kW34AHtroC7GFQKu/aAn
 HnL7XrvNvByjpa636jIM9ij43LpLXjIQk3bwHeoHebkmgzFef+lZafzD+oSNNLoYkuWfoL2l
 CR1mifjh7eybmVx7hfhj3GCmRu9o1x59nct06E3ri8/eY52l/XaWGGuKz1bbCd3xa6NxuzDM
 UZU+b0PxHyg9tvASaVWKZ5SsQ5Lf9Gw6WKEhnyTR8Msnh8kMkE7+QWNDmjr0xqB+k/xMlVLE
 uI9Pmq/RApQkW0Q96lTa1Z/UKPm69BMVnUvHv6u3n0tRCDOHTUKHXp/9h5CH3xawms7AzQRi
 vXYMAQwAwXUyTS/Vgq3M9F+9r6XGwbak6D7sJB3ZSG/ZQe5ByCnH9ZSIFqjMnxr4GZUzgBAj
 FWMSVlseSninYe7MoH15T4QXi0gMmKsU40ckXLG/EW/mXRlLd8NOTZj8lULPwg/lQNAnc7GN
 I4uZoaXmYSc4eI7+gUWTqAHmESHYFjilweyuxcvXhIKez7EXnwaakHMAOzNHIdcGGs8NFh44
 oPh93uIr65EUDNxf0fDjnvu92ujf0rUKGxXJx9BrcYJzr7FliQvprlHaRKjahuwLYfZK6Ma6
 TCU40GsDxbGjR5w/UeOgjpb4SVU99Nol/W9C2aZ7e//2f9APVuzY8USAGWnu3eBJcJB+o9ck
 y2bSJ5gmGT96r88RtH/E1460QxF0GGWZcDzZ6SEKkvGSCYueUMzAAqJz9JSirc76E/JoHXYI
 /FWKgFcC4HRQpZ5ThvyAoj9nTIPI4DwqoaFOdulyYAxcbNmcGAFAsl0jJYJ5Mcm2qfQwNiiW
 YnqdwQzVfhwaAcPVABEBAAHCwPYEGAEKACAWIQRmuZTsoU9/Llq6CB9/kFQNChzQDwUCYr12
 DAIbDAAKCRB/kFQNChzQD/XaC/9MnvmPi8keFJggOg28v+r42P7UQtQ9D3LJMgj3OTzBN2as
 v20Ju09/rj+gx3u7XofHBUj6BsOLVCWjIX52hcEEg+Bzo3uPZ3apYtIgqfjrn/fPB0bCVIbi
 0hAw6W7Ygt+T1Wuak/EV0KS/If309W4b/DiI+fkQpZhCiLUK7DrA97xA1OT1bJJYkC3y4seo
 0VHOnZTpnOyZ+8Ejs6gcMiEboFHEEt9P+3mrlVJL/cHpGRtg0ZKJ4QC8UmCE3arzv7KCAc+2
 dRDWiCoRovqXGE2PdAW8788qH5DEXnwfzDhnCQ9Eot0Eyi41d4PWI8TWZFi9KzGXJO82O9gW
 5SYuJaKzCAgNeAy3gUVUUPrUsul1oe2PeWMFUhWKrqko0/Qo4HkwTZY6S16drTMncoUahSAl
 X4Z3BbSPXPq0v1JJBYNBL9qmjULEX+NbtRd3v0OfB5L49sSAC2zIO8S9Cufiibqx3mxZTaJ1
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/23/26 12:44 AM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jan 22, 2026 at 7:46 PM Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 1/22/26 3:28 AM, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Thu, Jan 22, 2026 at 2:57 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Thu, Jan 22, 2026 at 10:54:42AM +0000, Peter Maydell wrote:
>>>>> On Thu, 22 Jan 2026 at 10:40, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>> Once we have written some scripts that can build gcc, binutils, linux,
>>>>>> busybox we've opened the door to be able to support every machine type
>>>>>> on every target, provided there has been a gcc/binutils/linux port at
>>>>>> some time (which covers practically everything). Adding new machines
>>>>>> becomes cheap then - just a matter of identifying the Linux Kconfig
>>>>>> settings, and everything else stays the same. Adding new targets means
>>>>>> adding a new binutils build target, which should again we relatively
>>>>>> cheap, and also infrequent. This has potential to be massively more
>>>>>> sustainable than a reliance on distros, and should put us on a pathway
>>>>>> that would let us cover almost everything we ship.
>>>>>
>>>>> Isn't that essentially reimplementing half of buildroot, or the
>>>>> system image builder that Rob Landley uses to produce toybox
>>>>> test images ?
>>>>
>>>> If we can use existing tools to achieve this, that's fine.
>>>>
>>>
>>> Imho, both approaches are complementary. Building images from scratch,
>>> like toybox, to cover esoteric minimal systems. And more complete and
>>> common OSes with mkosi which allows you to have things like python,
>>> mesa, networking, systemd, tpm tools, etc for testing.. We don't want
>>> to build that from scratch, do we?
>>>
>>
>> I ran into this need recently, and simply used podman (or docker) for
>> this purpose.
>>
>> $ podman build -t rootfs - < Dockerfile
>> $ container=$(podman create rootfs)
>> $ podman export -o /dev/stdout $container |
>> /sbin/mke2fs -t ext4 -d - out.ext4 10g
>> $ podman rm -f $container
>>
>> It allows to create image for any distro (used it for alpine and
>> debian), as long as they publish a docker container. As well, it gives
>> flexibility to have a custom init, skipping a lengthy emulated boot with
>> a full system. As a bonus, it's quick to build, and does not require
>> recompiling the world to get something.
>>
>> You can debug things too by running the container on your host machine,
>> which is convenient.
>>
> 
> Very nice! I didn't realize you could export and reuse a container that way.
>

It's a just a filesystem, so you're free to include what you want. An 
advantage on custom solutions is that Dockerfile is a standardized format.

> I wonder how this workflow can be extended and compare to mkosi
> (beside the limitation to produce tar/fs image)
>

mkosi takes care of more things for you, like setting up users, probably 
supports partitioning your disk, and make it bootable. See it as 
something like debootstrap + install.
The container based approach above give you an ext4 filesystem, the rest 
is up to you.

> For qemu VM testing, it would fit better along with our Dockerfile &
> lcitool usage.
>

It's nice and easy to prototype indeed. As well, unrelated, but I think 
it's better for everyone to spend time learning Dockerfiles instead of 
an ad-hoc solution QEMU wants to use. The worse would be custom python 
scripts reinventing the wheel and recompiling everything: long to 
iterate and impossible to decipher except for the one who wrote it.

> I wish a tool would help to (cross) create & boot such (reproducible)
> images & vm easily.
> 

I was looking exactly at this, and I've been surprised that nobody 
except bootc tried reusing existing containers: it seems to be a perfect 
match. Beyond the convenience, you get build caching for free, which is 
very important when you iterate on system images. And you can host the 
result directly and for free on dockerhub, even if that's several GB.

Bootc forces the usage of a specific "base" image, which, IMHO, goes 
against what people should expect. Now, instead of having a normal 
Dockerfile, you have a Dockerfile based on a black box you can't modify 
easily. If I'm wrong and if someone is familiar with bootc here, I would 
be happy to hear the opposite.

> 
>> I took a look at bootc, but was not really convinced of what it added
>> for my use case compared to the 4 commands above.
>>
> 
> Having a regular VM bootable image could be desirable for some cases
> (tpm, secure boot testing for ex).
> 
> --
> Marc-André Lureau

All that said, containers are just a suggestion. If mkosi is a good 
tool, I would be happy to see it used. Just avoid going down the rabbit 
hole reimplementing everything like it has been suggested on this 
thread: we would not have one problem only, but two problems instead.

Regards,
Pierrick

