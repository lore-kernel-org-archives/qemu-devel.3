Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAF2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 10:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ2Qj-0004FN-HE; Tue, 24 Dec 2024 05:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ2Qh-0004FF-2F
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 05:46:23 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQ2Qb-0000s2-HS
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 05:46:22 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 60DFE1140093;
 Tue, 24 Dec 2024 05:46:14 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Tue, 24 Dec 2024 05:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735037174;
 x=1735123574; bh=m9L63Sc2i1RbqPLuiBlw7xbTb0iF7VJycxo8R7ryaUQ=; b=
 KMFBKf2h7NXngwez4V2DRbGotUsTqBk6/E1Mt+gwXFDn5uaZ1BVYV4WvEHglVG30
 a+2K/mqMo/FrvohjfG1u7C+dAg0LuRxbJSHH8Aj4VUyZgNkIfvirNuT0U784J3Fv
 LLH9K3IDB3cBhW1LDBPs1K3HYNAkrJawPj5yjU30ENvesB6ku0Eae7yXUTtqCjVC
 +l3m+a/3spdOXq6l5PBRnDT3bikpn5sQ8DhiiSHCNhtWrv9LU4j9gaiqvDZwXw2e
 lTblqQb1XABEi1PTxnEwBnhquCQ3/lolog/TQP9INmNi79TDhECtCiCQAlfIukSj
 BUNvrvBkGn6b4k754QNKFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735037174; x=
 1735123574; bh=m9L63Sc2i1RbqPLuiBlw7xbTb0iF7VJycxo8R7ryaUQ=; b=q
 1CmL5JVOzeMQRQ6d1O3BBRoOUl4Wzk2BEwiKWxIWoNbrfdHQxzGwCnFfMJ2OwPN9
 834iyh1Cm95kV/haRP/Mehn6pmoWba50ySSlXWeQrGe00J7z/2lY0LryNyq9kWV2
 oug4Q9UzqhbZK3iS5JWo+V4KVIpMy2u0WxrhOvGyInc4ZmnjjczQkTi2YifEVnkI
 gr13SX0GFPZ0ek3g1UD6SMrI4TP+eFt7uOf8UKS1kj/W/kgv/qPBijuIJlr4Tr0t
 k6IdyOofeRn1db4xmfy9vYCRNGKFSbME/3pfXHxY38MwLp8Mf8rYaeCX3MefQUTL
 CJ7b4QuqtKP30XLlKC9cA==
X-ME-Sender: <xms:9ZBqZ607GQhF2RNcDwvDcefvEkN-_VS4IpGg15lD4Bjg4q74Nrn3xQ>
 <xme:9ZBqZ9HyzW9q3ROXUWNmqUBoRE8odrKEflWHunfX10l7Y6IDEdq6nv54_j7aOrzZm
 0Qq5nhfqGVc7gPpi80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugedgudejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:9ZBqZy6B5LAeC3mo_OxW70hK_IAeHGF0rHAFa8qbd2l5ZJPvHchSsw>
 <xmx:9ZBqZ73ApdzSgCWgc6RtT1JlPMuuuqELlprtKkWJRmWlNudNENSUZg>
 <xmx:9ZBqZ9GiPK7hXw3t83rz-RqcMjSPoW1cLGqPoDm5AOhj1ETUvwp-hw>
 <xmx:9ZBqZ0-1q4HJHgHsUtuRCiJ0Z0oE_oe2S-niqV5gKSW8vgCMJfKdSw>
 <xmx:9pBqZyTZ8DLfaqBPPT4-pYFkOfuIGwwWmaa0QaMEPqgODrlioBpMI2cs>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B5AD61C20067; Tue, 24 Dec 2024 05:46:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 10:45:53 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>
Message-Id: <9983380b-598b-4e8b-a690-80ec15dd35c6@app.fastmail.com>
In-Reply-To: <63150c24-2353-2904-d6d2-39935a40321d@loongson.cn>
References: <20241223-la-direct-kernel-boot-v1-1-a79995d8b15e@flygoat.com>
 <63150c24-2353-2904-d6d2-39935a40321d@loongson.cn>
Subject: Re: [PATCH] hw/loongarch/boot: Support Linux raw boot image
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.159;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a8-smtp.messagingengine.com
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
=E4=B8=8A=E5=8D=884:03=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
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
> Can we read file header file firstly?
> If it is ELFMAG, load_elf is called.
>
> If it is EFI_PE_MSDOS_MAGIC, check zimg magic in linux_efi_zboot_heade=
r,=20
> else loongarch_linux_hdr for plain image if zimg does not match.

I'd say as checking will be done by load_elf, the fallback path makes mo=
re
sense here.

See similar design on Arm's arm_setup_direct_kernel_boot.

But you are right, I should handle vmlinuz.efi with linux_efi_zboot_head=
er
as well.

>
> Regards
> Bibo Mao
>
>> +    }
[...]

--=20
- Jiaxun

