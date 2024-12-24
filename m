Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C575E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtWw-0006uI-5C; Mon, 23 Dec 2024 20:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtWh-0006tp-BP
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:16:02 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtWc-0000ew-71
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:15:57 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 3D6961380139;
 Mon, 23 Dec 2024 20:15:51 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 20:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735002951;
 x=1735089351; bh=yCvWyr38S2wL7pJ+RPL6CF3yGvgsNMQ7L8ec2RjIknw=; b=
 sx17j1AdlrLFSK8zIkBXxX38x0aWumi0be+9FrRQTLdjs6XJ5Rewilr58U3oY/2Z
 hy1tuD1S+GRYjP7ijGFJFOOF2++TAnVi6sl0eCLl13NvlZbUlN+/8TCMIl0kl06t
 k1OlWJu85n3K76U0JU9QYbsWw/ykHLMfuy1Sp7IlRoEsTPCApyFLMBwR8fgcM3YD
 rJw/B9MUv5eoML3T/NZD53/n+ihrgQ4rn4sujGCsHmhgTuOK8/0/9f959vCVNRGN
 o4G99X+Rep55iLwt265921whZWYKiT5zLbzn7AC3GFEpCCIUWgCXuXTajP/DYcUz
 Ap+OSsf+5NWE6uphoB372g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735002951; x=
 1735089351; bh=yCvWyr38S2wL7pJ+RPL6CF3yGvgsNMQ7L8ec2RjIknw=; b=V
 UXeNJ/AkIxT5ubgi6g9bCB39XmBP+GYdV+iTQY8DFNgNXcOFfzXqLRbWOl1sY0gg
 o2g4Z3SGcQOc2Fcjt5FqPcmnuzyBLcKQRM/qOscocGPQ8NxxYnb31Ea5RqOI2l4W
 l9mc7vLKTIoLlKN2CelEzPj+ZM0PqTHcFGvsyU21lQ128+BkRZNMZzwQ8EyYGKjP
 KBR8KGc4a8jKFRWzbVT1RYa4am6rCjBdohyGeSriJn3FJB2LhVnK0/d17pL+vRMe
 koKsJ0b/O9j2WAtZaIpA3D2PKS3VRfrNuNwKqcyH4t12NlKDjikgreogOY1xP3t1
 lcYK2F9UPcOK5uDWisyow==
X-ME-Sender: <xms:RgtqZ6cytYv7YWABdqqlTNVGHYXOYISZa_uopIGArD7-8wnMQw1hSA>
 <xme:RgtqZ0O3khNtVT28WhcsH0R0ODJkYerzmk9NEK4HLaXg6Fn4Ui-_Ii3ebmQ5sRAM3
 kP4JBWnOacUeEYK7DY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddufedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeikedvgeejgefhuddtkeff
 keffvedvfeegjeejfefhheevuedvleevffekjedvnecuffhomhgrihhnpegvfhhirdhsuh
 hpphhorhhtpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
 rghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtghpthhtohepmhgrohgsihgsoheslh
 hoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhg
X-ME-Proxy: <xmx:RgtqZ7iRQiltnSOxiRH4v-BZkBZtnD7T4MGLGdkDi6ADW2ZvELfpKA>
 <xmx:RgtqZ3_Hxorfro5XjEWXNlxuEQD2fFpoFT516CC661Iudzq6a2lGRw>
 <xmx:RgtqZ2vPNvWLCbpC-Tnqg80Gk4GYO5AGukksgzJ5I5MJ0FIqTo9FxA>
 <xmx:RgtqZ-EOOyg3wpz9ItZF-lYz27J4MOv1XVMXyB1lV-c8qPSnzWLtUg>
 <xmx:RwtqZ_4-JtO1NlXAgCCfNGLT-I8jeQNenCjNQHi1JcUrxPvM-864_KkH>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 892D81C20066; Mon, 23 Dec 2024 20:15:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 01:15:30 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>
Message-Id: <7ade5370-c5e1-4340-8ed7-80cd489798ae@app.fastmail.com>
In-Reply-To: <81a42119-741f-6ab6-e88d-05c9e609670f@loongson.cn>
References: <20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com>
 <81a42119-741f-6ab6-e88d-05c9e609670f@loongson.cn>
Subject: Re: [PATCH] hw/loongarch/boot: Support Linux raw boot image
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8824=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8A=E5=8D=8812:56=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
> Sorry, I do not know the background.
> Now kernel image with EFI format can boot if uefi bios is provided.
>
> What is this patch to do?  is it to direct boot kernel with EFI format=20
> without UEFI bios parameter?

Yes, it=E2=80=99s now capable for booting vmlinux.efi without BIOS, as w=
ell as raw kernel built without EFI STUB.

Thanks

>
> Regards
> Bibo Mao
>
> On 2024/12/23 =E4=B8=8A=E5=8D=888:30, Jiaxun Yang wrote:
>> Many distros are shipping raw kernel images (i.e. vmlinux.efi).
>>=20
>> Support booting such image by parsing header as per Linux's
>> specification [1].
>>=20
>> [1]: https://docs.kernel.org/arch/loongarch/booting.html
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> It is based on my previous booting protocol patch
>> ---
>>   hw/loongarch/boot.c         | 45 ++++++++++++++++++++++++++++++++++=
+++++++++++
>>   include/hw/loongarch/boot.h | 17 +++++++++++++++++
>>   2 files changed, 62 insertions(+)
>>=20
>> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
>> index 93847b0eaf8e50ce1a990b91267780e6785e1c2f..5bc889c51fafa9c6d3742=
6b9bee9709c12183927 100644
>> --- a/hw/loongarch/boot.c
>> +++ b/hw/loongarch/boot.c
>> @@ -260,6 +260,43 @@ static uint64_t cpu_loongarch_virt_to_phys(void =
*opaque, uint64_t addr)
>>       return addr & MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>>   }
>>  =20
>> +static int64_t get_linux_image_info(struct loongarch_boot_info *info,
>> +                                    uint64_t *kernel_entry,
>> +                                    uint64_t *kernel_low,
>> +                                    uint64_t *kernel_high)
>> +{
>> +    int fd;
>> +    struct loongarch_linux_hdr hdr;
>> +    int64_t kernel_size =3D -1;
>> +
>> +    fd =3D open(info->kernel_filename, O_RDONLY | O_BINARY);
>> +    if (fd < 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (read(fd, &hdr, sizeof(hdr)) !=3D sizeof(hdr)) {
>> +        close(fd);
>> +        return -1;
>> +    }
>> +
>> +    if ((le32_to_cpu(hdr.mz_magic) & 0xffff) !=3D MZ_MAGIC ||
>> +        le32_to_cpu(hdr.linux_pe_magic) !=3D LINUX_PE_MAGIC) {
>> +        close(fd);
>> +        return -1;
>> +    }
>> +
>> +    *kernel_entry =3D le64_to_cpu(hdr.kernel_entry);
>> +    /* Early kernel versions may have those fields in virtual addres=
s */
>> +    *kernel_entry &=3D MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BIT=
S);
>> +    *kernel_low =3D le64_to_cpu(hdr.load_offset);
>> +    *kernel_low &=3D MAKE_64BIT_MASK(0, TARGET_PHYS_ADDR_SPACE_BITS);
>> +    kernel_size =3D le64_to_cpu(hdr.kernel_size);
>> +    *kernel_high =3D *kernel_low + kernel_size;
>> +
>> +    close(fd);
>> +    return kernel_size;
>> +}
>> +
>>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>>   {
>>       uint64_t kernel_entry, kernel_low, kernel_high;
>> @@ -270,6 +307,14 @@ static int64_t load_kernel_info(struct loongarch=
_boot_info *info)
>>                              &kernel_entry, &kernel_low,
>>                              &kernel_high, NULL, 0,
>>                              EM_LOONGARCH, 1, 0);
>> +    if (kernel_size < 0) {
>> +        kernel_size =3D get_linux_image_info(info, &kernel_entry,
>> +                                           &kernel_low, &kernel_high=
);
>> +        if (kernel_size >=3D 0) {
>> +            kernel_size =3D load_image_targphys(info->kernel_filenam=
e,
>> +                                              kernel_low, kernel_siz=
e);
>> +        }
>> +    }
>>  =20
>>       if (kernel_size < 0) {
>>           error_report("could not load kernel '%s': %s",
>> diff --git a/include/hw/loongarch/boot.h b/include/hw/loongarch/boot.h
>> index 96ec15016a314499acf65c6c47e0c4932aa99d01..5e8bd4dd73bbb27abccfa=
1fa577df52aed15b6a2 100644
>> --- a/include/hw/loongarch/boot.h
>> +++ b/include/hw/loongarch/boot.h
>> @@ -8,6 +8,23 @@
>>   #ifndef HW_LOONGARCH_BOOT_H
>>   #define HW_LOONGARCH_BOOT_H
>>  =20
>> +/* Linux Image Format */
>> +#define LINUX_PE_MAGIC  0x818223cd
>> +#define MZ_MAGIC        0x5a4d /* "MZ" */
>> +
>> +struct loongarch_linux_hdr {
>> +    uint32_t mz_magic;
>> +    uint32_t res0;
>> +    uint64_t kernel_entry;
>> +    uint64_t kernel_size;
>> +    uint64_t load_offset;
>> +    uint64_t res1;
>> +    uint64_t res2;
>> +    uint64_t res3;
>> +    uint32_t linux_pe_magic;
>> +    uint32_t pe_header_offset;
>> +} QEMU_PACKED;
>> +
>>   /* UEFI 2.10 */
>>   #define EFI_SYSTEM_TABLE_SIGNATURE       0x5453595320494249
>>   #define EFI_2_100_SYSTEM_TABLE_REVISION  ((2<<16) | (100))
>>=20
>> ---
>> base-commit: c69612063e1844b76ac01e3a781b979548c3585c
>> change-id: 20241222-la-direct-kernel-boot-c598264710e7
>>=20
>> Best regards,
>>

--=20
- Jiaxun

