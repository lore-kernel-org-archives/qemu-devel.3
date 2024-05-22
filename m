Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1482C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 17:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9pgS-0006J2-6H; Wed, 22 May 2024 13:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s9pgP-0006IL-Ac
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:23:22 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s9pgM-0001Vy-SU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 13:23:20 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e428242a38so98604191fa.2
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716398596; x=1717003396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=capHptUnvb9f7+wvqsxy4dNEFd1Da9TErzcgNpMjs9g=;
 b=baVlHaNbIy2o3kDVW2BTY/xvLT5POSFLIN4wdoV2ZBPqP11LZffdi75hgRS5ZmKfwp
 WV5X7yP9qKwkIUZURfCeIiLFfeNrucAp8drZN4uRx0mKPphNWF71Y/bKiXauKmOLnhOm
 W4dSgefItLAh+9lXrL1dv+H7IZEoRsVwk5sIpbjqr1CRplXOGG+IuZ9cgTyHCyrom3kt
 Wum6QFp/+Z9CVxomFdHISVjJNzu0fCNxKpOYfvdD6BSYujBgirf1lVNc2MRyZivGqmuh
 rgYUap756SqJZANXNP1G5Gr3cLUnnnM9jSk88KISUZMBN+XINQunadKj690OTF6V49q0
 GHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716398596; x=1717003396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=capHptUnvb9f7+wvqsxy4dNEFd1Da9TErzcgNpMjs9g=;
 b=OdanAtlUcRRsQbkUoBg0czj6uucgCHN5xbKRFOzq911+8sVy8cl0zCj5Fie8n6kUyv
 OgE9u8dQkeLvLMyrwKWJd/qE0B4bDBqWbzzePp54ATDW/LdDGW+2IRY5/gEGe6D41Yc/
 3DCViBMWOdsAl1OGTyOLG4AySqHwo37P/C6M6bP40OHUf9GaP4Nuo58Vq/aSSB6YUd1F
 45RGwamllcW/VP5eUTF13Nql5jRELCRz/9yY/tFXqN7a1cYiikVVq9+TNV7f3Q1eAuSl
 FTLTBSoFfIvG/AcWR3Y6dsyyqDMTk7kSW67oKyHUvBa3Byvh8Od0U1Av3g5FvvizRoHD
 TpIg==
X-Gm-Message-State: AOJu0YxICjKkQ0b+tqwRnXvwQy2oArXAbca5kgFEcdeqmXyphGX2ahwK
 lV7m0xZ3yLBsT/N4n+YZjt+P6M8mFuRHi06BIHmc0CS+p5dfQgQW9o1q/AbE96fBX7vZNFZ03ln
 Sdb6Tz7+LMEhuV0dTYMB4uHKi0lE=
X-Google-Smtp-Source: AGHT+IHsMWqN6GdhH6dGwh15eVFO7Qt/oZ93Dk9rAeFywgEzw46rJIRPiNcRgtK5S48tyu+GXv9eO94HCDmA1OeIE1U=
X-Received: by 2002:a2e:b1c7:0:b0:2e0:3ad2:b371 with SMTP id
 38308e7fff4ca-2e949490864mr21802361fa.25.1716398596226; Wed, 22 May 2024
 10:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
 <Zk4QGlUAmre1l74h@redhat.com>
In-Reply-To: <Zk4QGlUAmre1l74h@redhat.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 22 May 2024 23:23:04 +0600
Message-ID: <CAFfO_h4yLaX9ajTWo+obHYjozJ1NvUouvfFr7AqcrSaCgo8SVg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi Daniel,
Thanks for reviewing.

On Wed, May 22, 2024 at 9:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, May 18, 2024 at 02:07:52PM +0600, Dorjoy Chowdhury wrote:
> > An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
> > enclave[2] virtual machine. The EIF file contains the necessary
> > kernel, cmdline, ramdisk(s) sections to boot.
> >
> > This commit adds support for loading EIF image using the microvm
> > machine code. For microvm to boot from an EIF file, the kernel and
> > ramdisk(s) are extracted into a temporary kernel and a temporary
> > initrd file which are then hooked into the regular x86 boot mechanism
> > along with the extracted cmdline.
>
> I can understand why you did it this way, but I feel its pretty
> gross to be loading everything into memory, writing it back to
> disk, and then immediately loading it all back into memory.
>
> The root problem is the x86_load_linux() method, which directly
> accesses the machine properties:
>
>     const char *kernel_filename =3D machine->kernel_filename;
>     const char *initrd_filename =3D machine->initrd_filename;
>     const char *dtb_filename =3D machine->dtb;
>     const char *kernel_cmdline =3D machine->kernel_cmdline;
>
> To properly handle this, I'd say we need to introduce an abstraction
> for loading the kernel/inittrd/cmdlkine data.
>
> ie on the   X86MachineClass object, we should introduce four virtual
> methods
>
>    uint8_t *(*load_kernel)(X86MachineState *machine);
>    uint8_t *(*load_initrd)(X86MachineState *machine);
>    uint8_t *(*load_dtb)(X86MachineState *machine);
>    uint8_t *(*load_cmdline)(X86MachineState *machine);
>
> The default impl of these four methods should just following the
> existing logic, of reading and returning the data associated with
> the kernel_filename, initrd_filename, dtb and kernel_cmdline
> properties.
>
> The Nitro machine sub-class, however, can provide an alternative
> impl of thse virtual methods which returns data directly from
> the EIF file instead.
>

Great suggestion! I agree the implementation path you suggested would
look much nicer as a whole. Now that I looked a bit into the
"x86_load_linux" implementation, it looks like pretty much everything
is tied to expecting a filename. For example, after reading the header
from the kernel_filename x86_load_linux calls into load_multiboot,
load_elf (which in turn calls load_elf64, 32) and they all expect a
filename. I think I would need to refactor all of them to instead work
with (uint8_t *) buffers instead, right? Also in case of
initrd_filename the existing code maps the file using
g_mapped_file_new to the X86MachineState member initrd_mapped_file. So
that will need to be looked into and refactored. Please correct me if
I misunderstood something about the way to implement your suggested
approach.

If I am understanding this right, this probably requires a lot of work
which will also probably not be straightforward to implement or test.
Right now, the way the code is, it's easy to see that the existing
code paths are still correct as they are not changed and the new
nitro-enclave machine code just hooks into them. As the loading to
memory, writing to disk and loading back to memory only is in the
execution path of the new nitro-enclave machine type, I think the way
the patch is right now, is a good first implementation. What do you
think?

Thanks.

Regards,
Dorjoy

