Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176B8C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd6jt-0008MW-6x; Thu, 22 Feb 2024 05:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6jr-0008MJ-2u
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:55:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd6jo-00082o-Ov
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:55:38 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41279203064so9626895e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708599335; x=1709204135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kebqUSP2m77cw/AFNttxNd7Rli6XADFYi2bPtg2xNEw=;
 b=v7144p5vWh1NFtgp1EWMQGh+SIEtgicpH2nicUudGP/BYSv2/7930lhqFK2y7oLwM7
 6TYuZXUSfAMQVX9VDS2hOiJ+rf/H7s1/EF5zBlle5P3hLawhIDWX9cLz/J8Ly4ZsnoBF
 CRMtgTnvQT5FXTv/yPzkqwmEKu5xz+C0ozgoXabjFcheaggOAK2EtdSNz5au4GoegH3V
 +paC8SIHwOxfufFHHHbyocpaYJlGom8lkvk0ig1oXty8WbK5yEyzbVrJDf2YIXsNAJ1N
 f0GPa7p9n8DiNEKEk30SZBsjkJzLXfHP/4HfrsNk3P7rns2hG26QGfpE3YS7QoNDk4Gv
 1UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708599335; x=1709204135;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kebqUSP2m77cw/AFNttxNd7Rli6XADFYi2bPtg2xNEw=;
 b=ddkU+EgDZh27IsdfRN9pMVmtu+NkDUjuwE1tPgtP0NhXQhoTPv42Gsx+cCKlDJW+F2
 EugOBJ1F6mVgTO36TWulk+EbLXowQDbBwwOSdUD11kdOGUJ8SeWH5QB04jNpB2tPUlRT
 N0XIAW0prHKw2IXifmChAEz8r1fgs2kXYODn04g7dR2p773TtSQVzkvF0iSrq25Sfeb/
 OGhoRtUtZW6+OY4hTsqaK5OBr2JOW0YOIR5f0D5Xk4Wpe+CuOjy/+6kSDMp6ZUOe+puc
 sxeUVitzRb355MVHyYfzG89JgycrnlcfbF1wBvgGYG/tzVEJ9IPEcJmGnQ6B18WLV65w
 dmDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/b3GXsSrPPcWW59WqX1dtcoRzzKvJwqmeyBSRlDgy69gm77OVOLY2M3W/3rDPPkzZtGoqEYGME+s/nWqgFp71uCCOTEo=
X-Gm-Message-State: AOJu0YwKm6oO/vx+26zC3v16Q1qRFrmfyq0O1DWy5309Bq4GqE8ceOtA
 gh2vZNoVzqOkcY5eJii/1YhI+olWjPeOTArNO9D3kJNxJUYmDtLPSHv5vbLj5VU=
X-Google-Smtp-Source: AGHT+IF1YjGPaghPOAIY9UXWaMb83HL/sIwoNYVChOQ5O+PU/VnfOD0UpkPhAKmLDhRCmHBmdlB8pQ==
X-Received: by 2002:a05:600c:3b18:b0:412:7723:c754 with SMTP id
 m24-20020a05600c3b1800b004127723c754mr2950941wms.10.1708599334748; 
 Thu, 22 Feb 2024 02:55:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w16-20020a05600c475000b004128c73beffsm981767wmo.34.2024.02.22.02.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 02:55:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 037B45F89B;
 Thu, 22 Feb 2024 10:55:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Faiq Ali Sayed <faiqueali.109@gmail.com>,  qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, Edgar E. Iglesias
 <edgar.iglesias@gmail.com>, Stefano Stabellini <stefano.stabellini@amd.com>
Subject: Re: QNX VM hang on Qemu
In-Reply-To: <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
 (Peter Maydell's message of "Thu, 22 Feb 2024 09:45:44 +0000")
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
 <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
 <CAOpGCn+BHsVPG1_2-avx6Ex10dc-nKYuVv=3VTct=MYRb4TmYw@mail.gmail.com>
 <CAFEAcA9_MDHQyQ6q76OpUXgEO9f_osS23oMhyTC4vNSBqtD1-A@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 22 Feb 2024 10:55:33 +0000
Message-ID: <871q94ahui.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

(adding the other ZyncMP maintainers to the CC)

> On Wed, 21 Feb 2024 at 18:20, Faiq Ali Sayed <faiqueali.109@gmail.com> wr=
ote:
>>
>>
>>>
>>> This is also useful information. I would suggest you look
>>> at what the difference is between the image that boots and
>>> the one that doesn't: is it the same format (and what format
>>> is that)? is the way it is loaded on the real hardware the
>>> same, or different?
>>
>>
>> I am not able to distinguish between the images as they are in binary fo=
rm,
>> I noticed that the smaller size image can boot in Qemu.
>> I normally put the image into an SD card of the real hardware to boot.
>> so it is quite difficult for me now to distinguish.
>>
>>
>>> From the debug info from gdb you provided, the file clearly
>>> is not a raw binary file -- the initial bytes seem to be
>>> largely ASCII text. So it might be that this image is in
>>> a file format that whatever the real-hardware loader
>>> recognizes, but QEMU doesn't, whereas the images you have
>>> that work are really raw binaries. In that case you'd want
>>> to convert the image somehow to a format QEMU can understand
>>> (eg ELF, or raw-binary).
>>
>>
>> ahh, that also makes sense, ok now let me try to convert the images, and=
 let's see.
>> Does Qemu provide such a tool or do you know any?
>
> We don't know what format these images are in, so hard
> to say, but I would expect not (mostly QEMU's image
> conversion handling is for filesystems, not guest
> binaries). You'll probably do best to look on the QNX
> and/or Xilinx side -- Xilinx should document what
> file formats it is that their boot process accepts.
> Your third-party vendor presumably also knows what
> format it is that they're generating the image in.

I did have a brief look through the Xilinx wiki pages to see if I could
cobble together a test case for their PetaLinux images. A bunch of pages
led to login walls which I assume are customer only. I did find:

  https://github.com/Xilinx/soc-prebuilt-firmware/tree/xlnx_rel_v2023.1/zcu=
102-zynqmp

which has a number of the components for the firmware but there was no
clear way to combine them into a single image. I did try just feeding
the ELF's to the command line but there was a clash between zynqmp_fsbl
and the bl31 (which I think is the normal ATF image).

  ./qemu-system-aarch64 -M xlnx-zcu102 -audio none -smp 4 -serial mon:stdio=
 -display none -s -S -device loader,file=3D/home/alex/lsrc/tests/testcases/=
zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf -device loader,file=3D/home/alex/ls=
rc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf,cpu-num=3D0 -device loa=
der,file=3D/home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/system.d=
tb,addr=3D0x00100000 -device loader,file=3D/home/alex/lsrc/tests/testcases/=
zcu102-zyncmp-prebuilds/u-boot.elf  -dtb /home/alex/lsrc/tests/testcases/zc=
u102-zyncmp-prebuilds/system.dtb
  qemu-system-aarch64: Some ROM regions are overlapping
  These ROM regions might have been loaded by direct user request or by def=
ault.
  They could be BIOS/firmware images, a guest kernel, initrd or some other =
file loaded into guest memory.
  Check whether you intended to load all this guest code, and whether it ha=
s been built to load to the correct addresses.

  The following two regions overlap (in the cpu-memory-0 address space):
    /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf=
 ELF program header segment 0 (addresses 0x00000000fffc0000 - 0x00000000fff=
e6058)
    /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf ELF pr=
ogram header segment 0 (addresses 0x00000000fffe0000 - 0x00000000ffffe000)

  The following two regions overlap (in the cpu-memory-0 address space):
    /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/bl31.elf ELF pr=
ogram header segment 0 (addresses 0x00000000fffe0000 - 0x00000000ffffe000)
    /home/alex/lsrc/tests/testcases/zcu102-zyncmp-prebuilds/zynqmp_fsbl.elf=
 ELF program header segment 1 (addresses 0x00000000fffe9e00 - 0x00000000fff=
e9e88)

Most of the use cases on the Xilinx pages are hidden behind their launch
scripts for their downstream fork. It would be nice if we could get at
least one image published somewhere that we could add an avocado test
for and hopefully an entry in the Arm system emulator pages (we have
fairly complete docs for xlnx-versal-virt).

>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

