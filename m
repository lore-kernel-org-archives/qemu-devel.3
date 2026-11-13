Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7834A606A882
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HTbng8uI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrDE-0002nw-2a; Fri, 13 Nov 2026 08:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRrDC-0002nZ-7x
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:21:02 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xRrDA-0007oN-4Z
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 08:21:01 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa87so468629f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794576058; x=1795180858; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kmdpf6010zrVofcrVYXj+71sMJbrBWCRrbYI9D1FhyM=;
 b=HTbng8uIaKJSyvEjvoRnBfYvowgAORsiQTz2bZSKyNzINZuCbnMR8MdkX+8UCVCd5P
 LFryIg//tSs4H9ARCtRu9JhqwaeiyMdvIgQgmJJm4eheZ54g9/lPZFJIcH2iZsGjP9CT
 GFxwWn3by431q+F3wWG/Llnn+2/Khr6CEHrGBJKyt7mnEciUUfuzQz2DYgGEV9FfHH8H
 XCkZy+NDKENMyyJsZS99FhLkgTHl6yeAEfUh7AbC+zpl+uodLEtLmT1jHOupICvf1b+4
 azrMvcUYEJywinObLjplZ/gpjuOv98ELxHlyw2rVywzfgS7oc+1wRNRckwT6PpXbIhA1
 0UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794576058; x=1795180858;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kmdpf6010zrVofcrVYXj+71sMJbrBWCRrbYI9D1FhyM=;
 b=bbe1u9GjkatkUyzVIVsBqqeX89IpSOArauJHto5IwNzIvF4NBA5A4nGrcrnl6MizxV
 xlemOV+QLf4luX0s1bPCzAlAs3RhVGISgC9mK7RCam1yCyTZ4pKnPj/x6eHuZPHPuPyY
 g1w8hlF8vXGwAzx0+/k5oHxYg5qOKa35tqNKJafnookFkfH+FIiZEdwjlJV5PrN5UkHr
 Fnrc7c6dPX13csB7odUDDPaAGOiXLRY/ih2dJK4wglaPWrnsW97J9IphaDqsQfSwWpNx
 rUenTi96Z7GF3xZaLXce151lipHKOz6pAApezzDXqvVQt3JMSNKukyAHIFUbrEV/Rxwc
 4itQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHMu31B5nSV8SIW5okY5W+bxJE6sa+48c3ZMAnrw8DkvsgbgQGbjDoVEBJ84PRgIOif+ARVL/MqxG/e@nongnu.org
X-Gm-Message-State: APuU4Z8Ig6W5rTRI0qmWGTZzmpZ33wRO7chorpHx2IicS0eKYVrNkgEn
 MtzAKlpUq5bu9SAyVUW3765/QA+5FPgRQzD6BNx5suUV0hufgBliU5Wbfze5DPEoNtg=
X-Gm-Gg: AYBFou03VUK4x6cCwfzZuTlE/oYlU7UBnBG+LI74+BjRE4ig8DUDVMjRku8k3wuj+5Q
 iuHmrjinFnCw5QEZxlXYzL8LlGSLF/bDGj5yC7anvCTQvH61cER46LRwExs1LtEmmHYr4qWugQz
 Y3EHHxcb51F2o6cK33XzPtrEr75VCR1gmZNcqva2YIsEwEJt8TGn2DChfJWj/bdJMbX5kEvXcMp
 8oDubGGn36Q6ljTLCrfVgzoCuIkwqLFVQXlQR5WKPE/SSFucVy9P4erkVoeaprq60aIfxx8YclX
 ErZGxxqJB67zXV9L+W7qX5EEkA4NSZ4gNomCI5QDzdc5DDutSVmcky0ZBo1FwNi1FMJ3wTjqCTW
 pwd6/uVsTPWR9IjwISITErVE3nPmKpb4LfUkdrjb6+NFLq+QhgHCpVkK7uuuzdrpo6RCgU5++tk
 y7NDNUchllvJG29dmLQuJ7wJ+XkuTvNOtdzz7fn5Iwm+idW+miPFl60FMMHXkJA+5qy3EYz6UIb
 nVri+FnyosHnRgcerkZx+8NVyGPx7de+yK70J09UWNVNzKemtSgztEAMbi6uKBu2U5r5IURVm85
 ncGVK5A+E7VUVOdtwbZnlIfl0p9b
X-Received: by 2002:a05:6000:3c6:b0:48d:b75d:30f6 with SMTP id
 ffacd0b85a97d-49c73ce4e0amr4859950f8f.35.1794576058089; 
 Fri, 13 Nov 2026 05:20:58 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60116323sm5076828f8f.32.2026.11.13.05.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 05:20:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 685315F87D;
 Fri, 13 Nov 2026 13:20:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth
 <thuth@redhat.com>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org,  qemu-block@nongnu.org,  qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
In-Reply-To: <avb1pVvH5Ukynj4-@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 13 Nov 2026 11:33:57 +0000")
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
 <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
 <CAMxuvazfhfGSZCiSi+viwJ7f7XDWAZfjmW39n3a7a-qQyw-YSA@mail.gmail.com>
 <au3mwO32b0-PSXKu@redhat.com>
 <CAMxuvayhYcOvH2QPptrKUQGFHoRxQcM1USF5OwuZYR_g2c4zgw@mail.gmail.com>
 <au4Pa4GFA4u-XQ7J@redhat.com> <avYM-3jVbW65NYyk@redhat.com>
 <87ik21asn4.fsf@draig.linaro.org> <avb1pVvH5Ukynj4-@redhat.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 13 Nov 2026 13:20:55 +0000
Message-ID: <87cxs8c1fs.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Nov 13, 2026 at 11:16:15AM +0000, Alex Benn=C3=A9e wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Alex, as the virtio-gpu* maintainer can you give your opinion
>> > on the discussion below about virtio-gpu security tagging
>> > vs our current security policy for "virtualization use case"
>> > to ack/nack the proposal.
>>=20
>> I'm inclined to agree with Marc-Andre here - the 3D GPU attack surface
>> is large and for the in-QEMU handling we have a bunch of issues with GPU
>> context handling between threads that make it tricky. Compounding that
>> ruttabaga is not very well tested at all because its hard to enable
>> without non-distro libs (for now).
>>=20
>> Finally virtio-gpu is Odd Fixes so it's not getting the response times
>> of other VirtIO stuff in terms of handling security issues.
>>=20
>> We should encourage users to use vhost-user-gpu for 3D stuff because at
>> least then the rendering pipeline and processing of guest controlled
>> data is easier to sandbox.
>>=20
>> So I'd say:
>>=20
>>   - virtio-gpu for 2d - OK
>>   - virtio-gpu for 3d via vhost - OK
>>   - virtio-gpu for 3d in QEMU - Not OK
>
> So, IIUC, in terms of what -device help reports, that would mean
>
> Secure:
>
>   name "vhost-user-gpu", bus virtio-bus
>   name "vhost-user-gpu-pci", bus PCI
>   name "virtio-gpu-device", bus virtio-bus
>   name "virtio-gpu-pci", bus PCI, alias "virtio-gpu"

and virtio-vga

>
> Not secure:
>
>   name "virtio-gpu-gl-device", bus virtio-bus
>   name "virtio-gpu-gl-pci", bus PCI, alias "virtio-gpu-gl"
>   name "virtio-gpu-rutabaga-device", bus virtio-bus
>   name "virtio-gpu-rutabaga-pci", bus PCI, alias "virtio-gpu-rutabaga"
>

and virtio-vga-gl


> ?

Looks good to me.

>
>>=20=20=20
>> Alex.
>>=20
>> >
>> > On Fri, Nov 06, 2026 at 05:33:31PM +0000, Daniel P. Berrang=C3=A9 wrot=
e:
>> >> On Fri, Nov 06, 2026 at 06:52:27PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
>> >> > Hi
>> >> >=20
>> >> > On Fri, Nov 6, 2026 at 6:40=E2=80=AFPM Daniel P. Berrang=C3=A9 <ber=
range@redhat.com> wrote:
>> >> > >
>> >> > > On Fri, Nov 06, 2026 at 06:35:29PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:
>> >> > > > Hi
>> >> > > >
>> >> > > > On Fri, Nov 6, 2026 at 3:53=E2=80=AFPM Thomas Huth <thuth@redha=
t.com> wrote:
>> >> > > > >
>> >> > > > > On 29/10/2026 14.12, Daniel P. Berrang=C3=A9 wrote:
>> >> > > > > > These are all intended for use in a virtualization scenario=
 and must
>> >> > > > > > provide a security boundary.
>> >> > > > > >
>> >> > > > > > Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
>> >> > > > > > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> >> > > > > > ---
>> >> > > > > Reviewed-by: Thomas Huth <thuth@redhat.com>
>> >> > > > >
>> >> > > >
>> >> > > > I have a second thought about this, I'd like to exclude all
>> >> > > > gpu-accelerated paths for now. virgl/mesa/rutabaga expose a ver=
y large
>> >> > > > attack surface, so I'd like to drop them from the secure bounda=
ry
>> >> > >
>> >> > > Rather than repost, please see my response for patch 2:
>> >> > >
>> >> > >   https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01530.=
html
>> >> > >
>> >> > > TL;DR: we have already promised anything virtio related is in sco=
pe
>> >> > > for security handling for a long time, as they are all unambiguou=
sly
>> >> > > "virtualization use case".
>> >> > >
>> >> >=20
>> >> > the value of a secure policy enforcement is low if we know those
>> >> > devices are unsecure and don't have the resources to make them secu=
re.
>> >>=20
>> >> It isn't a great situation to be in, but we're already there for any
>> >> virtio devices based on our existing policies for bug handling and
>> >> security triage. We can't promise we'll get fixes for all CVEs quickl=
y,
>> >> but we will at least assign CVEs so that users are aware when there
>> >> are known problems.
>> >>=20
>> >> This contrasts to other devices where problems will remain largely
>> >> hidden for view, as we treat them as normal bugs and never call our
>> >> security concerns when committing changes.
>> >>=20
>> >> With regards,
>> >> Daniel
>> >> --=20
>> >> |: https://berrange.com       ~~        https://hachyderm.io/@berrang=
e :|
>> >> |: https://libvirt.org          ~~          https://entangle-photo.or=
g :|
>> >> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.co=
m :|
>> >>=20
>> >>=20
>> >
>> > With regards,
>> > Daniel
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

