Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5BCC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcpk-0002Zy-2C; Mon, 27 May 2024 12:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sBcpi-0002Zb-IH
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:04:22 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sBcpd-0000Gc-W5
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:04:22 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2e95a7622cfso39255691fa.2
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716825852; x=1717430652; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lxVdkFRKMhvmVq3j8qkX0mPoC07s61lZohcTdmqZTbQ=;
 b=m+cEXViAG1UakjqCqFo47pjdDKo8AbBCTXLl1NyztMnymuBwd2QWEf8ZXm1FNa8d/t
 maEmxv+ljoV5ric9xvDhPhfjWhfeYC/fDVg+v2JBIlRRiIiL+8Q6sQZUimj/yhQp1sfE
 NWJQX+e95valq+Vj8ZrjHbMMyB/DHSpYojb0g3D6QLoa0veIvmrboSLThmrb/EmNs7L+
 2PYhrqoTEHlcJqq4uuMZox/3H1egQQ+FeIaZQrL6klGYxgUjDwFZR1HdLzanN1U49Cig
 cskBnAwzcz0z1O1nwoHo1HayrRgc9h7KB+tKkPbMcV7dAhsXJNcLLjqUKk3vnYm9vEV6
 0S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716825852; x=1717430652;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxVdkFRKMhvmVq3j8qkX0mPoC07s61lZohcTdmqZTbQ=;
 b=m9L/9DPuc49qWmpKL6exFN3GSJqy3Qs+blQ/DAWY/Df71U9+HabS8i812C3Rn6QNug
 MsC0vBpolNwdtxYyrHb5zzM/2gfPjPLNPnj2AAnC6zRJwt6SXBe3GT5OCBMt6u8SEgds
 fe+zPcZ1JodmwYgVKQTqqwe4j3xNwIGHpMmDFcJLOvAuWkxTajHEgZBJld9l13Le5KI5
 ooFSfNGsbpDNwsLPmm9xWggcbb0I7wNOnmODW6Y3QaFZmbpyhQo93W9krGKlmZCpoPxV
 XSVo9sUqZ6OVUCNG5p16pIGmlvePOcbQ1LiPmt8ueV45YXzVhnUZE/Epg0q6sb/fFdc6
 RBDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ZHbmy9HDy7rWzCJfn7RJ8RlMKP8sP7Uj8ZTRKONhDu1smE6xjESz4h+NUPwmnXxuO/HBU0nJ4Gl51++ufpCGcWY0MO0=
X-Gm-Message-State: AOJu0YxHeUAubJLU/AeVDw/ekISH7/9asTKU1gwApTd31MHvsH//bDWA
 20dzrX7hCl05UzYN+ft4Hcm992bqKVTzrzOzyr+2Vqw3v1Z/rCCQUmHVRu/ftbIEMXjv0D9cXfa
 2ZYGHH3AgoDowQD6c9KuKgJfkBH4=
X-Google-Smtp-Source: AGHT+IGk3c5hLwzWxhjMKdKpNcwdJPWXjqNHEVT/5Y5htj37OgklUPn81c7vIbXz3htxUVfa6XIMEqAUQLkLzmQYNRc=
X-Received: by 2002:a2e:8796:0:b0:2e9:5263:36e9 with SMTP id
 38308e7fff4ca-2e95b276558mr62130331fa.43.1716825851899; Mon, 27 May 2024
 09:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
 <bf9dc551-49e4-4ed9-941d-c095bab5755a@linaro.org>
 <CAFfO_h7_V13k9WizTYrY-UsjUhvWFeY4Fn7a_8_c4qEz4=hYFg@mail.gmail.com>
 <919e6b8c-2f9b-4f91-97e2-20146bf18263@amazon.com>
In-Reply-To: <919e6b8c-2f9b-4f91-97e2-20146bf18263@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 27 May 2024 22:04:00 +0600
Message-ID: <CAFfO_h7hrR+cZk17LFY8iun3xE2ygkFrKXoibTXwZ2+UZRmQdw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: Alexander Graf <graf@amazon.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, agraf@csgraf.de, stefanha@redhat.com, 
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hey Alex,

On Mon, May 27, 2024 at 9:51=E2=80=AFPM Alexander Graf <graf@amazon.com> wr=
ote:
>
>
> On 27.05.24 16:52, Dorjoy Chowdhury wrote:
> > Hi Philippe,
> > Thank you for reviewing.
> >
> > On Mon, May 27, 2024 at 4:47=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >> Hi Dorjoy,
> >>
> >> On 18/5/24 10:07, Dorjoy Chowdhury wrote:
> >>> An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
> >>> enclave[2] virtual machine. The EIF file contains the necessary
> >>> kernel, cmdline, ramdisk(s) sections to boot.
> >>>
> >>> This commit adds support for loading EIF image using the microvm
> >>> machine code. For microvm to boot from an EIF file, the kernel and
> >>> ramdisk(s) are extracted into a temporary kernel and a temporary
> >>> initrd file which are then hooked into the regular x86 boot mechanism
> >>> along with the extracted cmdline.
> >>>
> >>> Although not useful for the microvm machine itself, this is needed
> >>> as the following commit adds support for a new machine type
> >>> 'nitro-enclave' which uses the microvm machine type as parent. The
> >>> code for checking and loading EIF will be put inside a 'nitro-enclave=
'
> >>> machine type check in the following commit so that microvm cannot loa=
d
> >>> EIF because it shouldn't.
> >>>
> >>> [1] https://github.com/aws/aws-nitro-enclaves-image-format
> >> The documentation is rather scarse...
> >>
> > Do you mean documentation about EIF file format?  If so, yes, right
> > now there is no specification other than the github repo for EIF.
> >
> >>> [2] https://aws.amazon.com/ec2/nitro/nitro-enclaves/
> >>>
> >>> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >>> ---
> >>>    hw/i386/eif.c       | 486 ++++++++++++++++++++++++++++++++++++++++=
++++
> >>>    hw/i386/eif.h       |  20 ++
> >>>    hw/i386/meson.build |   2 +-
> >> ... still it seems a generic loader, not restricted to x86.
> >>
> >> Maybe better add it as hw/core/loader-eif.[ch]?
> >>
> > Yes, the code in eif.c is architecture agnostic. So it could make
> > sense to move the files to hw/core. But I don't think the names should
> > have "loader" prefix as there is no loading logic in eif.c. There is
> > only logic for parsing and extracting kernel, intird, cmdline etc.
> > Because nitro-enclave machine type is based on microvm which only
> > supports x86 now, I think it also makes sense to keep the files inside
> > hw/i386 for now as we can only really load x86 kernel using it. Maybe
> > if we, in the future, add support for other architectures, then we can
> > move them to hw/core. What do you think?
>
>
> I think it makes sense to put EIF parsing into generic code from the
> start. Nitro Enclaves supports Aarch64 with the same EIF semantics. In
> fact, it would be pretty simple to do a sub-machine-class similar to the
> x86 NE one for arm based on -M virt as a follow-up and by making the EIF
> logic x86 only we're only making our lives harder for that future.
>

Understood. I will move the eif.c and eif.h files to the hw/core
directory. Thanks.

Regards,
Dorjoy

