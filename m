Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531D606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=L+uvFI0m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbtg-0003JU-QM; Sat, 24 Oct 2026 09:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKbtZ-0003JA-2R
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:34:49 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xKbtW-0002FJ-MU
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792848885; x=1793453685; i=deller@gmx.de;
 bh=G5KjzYPy3029uDjrNdf7mtsv4raZptbKVfFWKE4/3P4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=L+uvFI0mVR652knum24nqxlm4K4tHt5oZ/hnUprK2hto+vRAOA8f5I9Wa30Vi/KH
 dVcstOhDJZH/OofquNPQst2TpJci65ND61Y91nzn0ypyA2yuRM2AMQ4vNV9ZVNztU
 cDQ5uRlSPRIRhhzxCPAiBtnF1kcF114/R41dkSMQ4czCMzBwFDbBE9jyhg4gg8X6W
 KuloFZA6lYA+lmsnJpT04OuqbqUFdL/gWnNFQj6b2nFgKPitIiudgi2HxTzz908XU
 iJf+IdxecUkSqtlsxBeLBfqXN7+9ee5FNzHYygc6afyXN1GINaTyxVMVLwX/g5ATe
 VG6/hpLfCUm/KVZfJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAONX-1xS0PX3edn-005sZ0; Sat, 24
 Oct 2026 15:34:44 +0200
Message-ID: <3653de48-cda5-4dd5-957f-fe86a069a2ad@gmx.de>
Date: Sat, 24 Oct 2026 15:34:42 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user/vdso: reproducible?
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <c9bcda59-f2f9-4036-8aeb-1e36e1b68498@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c9bcda59-f2f9-4036-8aeb-1e36e1b68498@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qj3AwEnqyM8THkayrppvzb/b6PBkZkCKDtNnWszBkqvzpJDMVS6
 bemzC3msS/YJGHwug8dnX1WbVD7+K/h03usO+VgXkux76WkATBGz4QLq/2yVtk3A+MAFMgh
 aqpzu/eT9Yv8w/4+SDdfBsauApwoDn8jsQmDTG/IxS1xtkAWjXVMjabE/KPXxOSlIkgat5s
 mzeJA6QSRDNuVX0badX5A==
UI-OutboundReport: notjunk:1;M01:P0:C9JFNPR7HTQ=;ceMAJeyApOMiq7wX+H8h/XY12dK
 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
 bUyo6nFUVkPTdvjC4GobGouA/ZM+A=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/26 07:51, Michael Tokarev wrote:
> Hi!
>=20
> Once again I'm trying to fix a long-standing issue in debian & ubuntu wi=
th
> vdso files build.
>=20
> One of the requirements here is to build everything from source, ensurin=
g
> the things can be rebuild and are reproducible (that is, the shipped bin=
aries
> can actually be produced from the provided source and not something else
> with a hidden backdoor).
>=20
> It'd be nice to just build the vdso.so files during regular package buil=
d.
> But this does not work correctly neither in debian nor in ubuntu infrast=
ructure
> due to several reasons.=C2=A0 The main problem is that to build all vdso=
 files,
> one need to have cross-compilers for all architectures on every host
> architecture for which qemu-user packages are produced, which is problem=
atic
> (especially for lower-power, or "small", architectures).
>=20
> Additionally, llvm/clang, which can produce binaries for multiple archit=
ectures
> and is available on all host architectures on debian, does not handle sh=
4 and
> hpps which are currently needed to rebuild vdso files in qemu, so it is =
also

I assume you meant "hppa" instead of "hpps".

> not an option, at least not yet (sh4 support hopefully will be available=
 soon).
>=20
> I'm using tricks to build vdso files on one architecture and use the res=
ult
> when building linux-user packages on all architectures.=C2=A0 But this d=
oes not
> work correctly neither in debian nor in ubuntu.
>=20
> An alternative is to actually use the binaries provided in qemu source
> tarball.=C2=A0 However in order to do that, I have to actually verify if=
 the
> binaries are produced from the actual source shipped with these binaries=
.
> It doesn't seem to be a difficult task because of the similicity of the
> sources - it is a simple assembler-language file which - in theory -
> should be trivially reproducible.
>=20
> However, when I build a vdso file locally with the same compiler options
> and compare it with the binary shipped with qemu, I see this:
>=20
> linux-user/aarch64 $ diffoscope vdso-be.so*
> 2026-10-23 18:59:46 E: diffoscope.comparators.elf: Command '['objdump --=
line-numbers --disassemble --demangle --reloc --no-show-raw-insn --section=
=3D.text {}']' returned non-zero exit status 1.
> 2026-10-23 18:59:46 E: diffoscope.comparators.elf: Command '['objdump --=
disassemble --demangle --no-show-raw-insn --section=3D.text {}']' returned=
 non-zero exit status 1.
> --- vdso-be.so
> +++ vdso-be.so.mjt
> =E2=94=9C=E2=94=80=E2=94=80 readelf --wide --symbols {}
> =E2=94=82 @@ -19,15 +19,15 @@
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6: 0000000000000380=C2=A0=
=C2=A0=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0=C2=A0 6 .gnu.=
hash
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7: 00000000000003b8=C2=A0=
=C2=A0=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0=C2=A0 7 .dyns=
tr
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8: 0000000000000430=C2=A0=
=C2=A0=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0=C2=A0 8 .gnu.=
version
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 9: 0000000000000440=C2=A0=
=C2=A0=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0=C2=A0 9 .gnu.=
version_d
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10: 0000000000000478=C2=A0=C2=A0=
=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 10 .eh_frame_hdr
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11: 0000000000000490=C2=A0=C2=A0=
=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 11 .eh_frame
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12: 00000000000004b8=C2=A0=C2=A0=
=C2=A0=C2=A0 0 SECTION LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 12 .text
> =E2=94=82 -=C2=A0=C2=A0=C2=A0 13: 0000000000000000=C2=A0=C2=A0=C2=A0=C2=
=A0 0 FILE=C2=A0=C2=A0=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0 ABS cc0Lcfxq.o
> =E2=94=82 +=C2=A0=C2=A0=C2=A0 13: 0000000000000000=C2=A0=C2=A0=C2=A0=C2=
=A0 0 FILE=C2=A0=C2=A0=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0 ABS ccuckKYd.o
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14: 0000000000000158=C2=A0=C2=A0=
=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0=C2=A0 1 $d
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 15: 00000000000004b8=C2=A0=C2=A0=
=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 12 $x
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16: 00000000000004f0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 12 sigreturn_r=
egion_start
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 17: 00000000000004f4=C2=A0=C2=A0=
=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 12 sigreturn_r=
egion_end
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 18: 00000000000004a4=C2=A0=C2=A0=
=C2=A0=C2=A0 0 NOTYPE=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0=C2=A0 11 $d
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 19: 0000000000000000=C2=A0=C2=A0=
=C2=A0=C2=A0 0 FILE=C2=A0=C2=A0=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0 ABS
> =E2=94=82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20: 00000000000001a0=C2=A0=C2=A0=
=C2=A0=C2=A0 0 OBJECT=C2=A0 LOCAL=C2=A0 DEFAULT=C2=A0 ABS _DYNAMIC
> =E2=94=9C=E2=94=80=E2=94=80 strings --all --bytes=3D8 {}
> =E2=94=82 @@ -1,14 +1,14 @@
> =E2=94=82=C2=A0 __kernel_gettimeofday
> =E2=94=82=C2=A0 __kernel_clock_gettime
> =E2=94=82=C2=A0 __kernel_clock_getres
> =E2=94=82=C2=A0 __kernel_rt_sigreturn
> =E2=94=82=C2=A0 linux-vdso.so.1
> =E2=94=82=C2=A0 LINUX_2.6.39
> =E2=94=82 -cc0Lcfxq.o
> =E2=94=82 +ccuckKYd.o
> =E2=94=82=C2=A0 sigreturn_region_start
> =E2=94=82=C2=A0 sigreturn_region_end
> =E2=94=82=C2=A0 _DYNAMIC
> =E2=94=82=C2=A0 __GNU_EH_FRAME_HDR
> =E2=94=82=C2=A0 _GLOBAL_OFFSET_TABLE_
> =E2=94=82=C2=A0 LINUX_2.6.39
> =E2=94=82=C2=A0 __kernel_clock_getres
> =E2=94=9C=E2=94=80=E2=94=80 readelf --wide --decompress --hex-dump=3D.st=
rtab {}
> =E2=94=82 @@ -1,10 +1,10 @@
> =E2=94=82
> =E2=94=82=C2=A0 Hex dump of section '.strtab':
> =E2=94=82 -=C2=A0 0x00000000 00636330 4c636678 712e6f00 24640024 .cc0Lcf=
xq.o.$d.$
> =E2=94=82 +=C2=A0 0x00000000 00636375 636b4b59 642e6f00 24640024 .ccuckK=
Yd.o.$d.$
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000010 78007369 67726574 75726e5f 726567=
69 x.sigreturn_regi
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000020 6f6e5f73 74617274 00736967 726574=
75 on_start.sigretu
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000030 726e5f72 6567696f 6e5f656e 64005f=
44 rn_region_end._D
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000040 594e414d 4943005f 5f474e55 5f4548=
5f YNAMIC.__GNU_EH_
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000050 4652414d 455f4844 52005f47 4c4f42=
41 FRAME_HDR._GLOBA
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000060 4c5f4f46 46534554 5f544142 4c455f=
00 L_OFFSET_TABLE_.
> =E2=94=82=C2=A0=C2=A0=C2=A0 0x00000070 4c494e55 585f322e 362e3339 005f5f=
6b LINUX_2.6.39.__k
>=20
> So basically, the difference is just in the temporary .o filename
> used during the build process, and that name is random.

Is there a way to use a static name instead, e.g. tell the Makefile
not to use a dynamic file name?
 =20
> After stripping both files from debug info (aarch64-linux-gnu-strip),
> things becomes exactly the same.
>=20
> Can't we strip them during build anyway?

If you strip them, you loose the ability to debug at runtime in the guest.

> (I'm not an expert with these reproducible build thing, maybe they
> have more ways to handle differences like this, and maybe more
> suggestions to further improve the situation besides stripping -
> asked them too).
>=20
> It's interesting that adding -s switch to gcc produces slightly differen=
t
> binary than not using -s and stripping after the link explicitly.
>=20
> linux-user/aarch64$ diffoscope --tool-prefix-binutils=3Daarch64-linux-gn=
u-=C2=A0 vdso-be.so*
> 2026-10-23 19:06:01 E: diffoscope.comparators.elf: Command '['objdump --=
line-numbers --disassemble --demangle --reloc --no-show-raw-insn --section=
=3D.text {}']' returned non-zero exit status 1.
> 2026-10-23 19:06:01 E: diffoscope.comparators.elf: Command '['objdump --=
disassemble --demangle --no-show-raw-insn --section=3D.text {}']' returned=
 non-zero exit status 1.
> --- vdso-be.so
> +++ vdso-be.so.mjt
> =E2=94=82=E2=94=84 xxd not available in path. Falling back to Python hex=
lify.
> =E2=94=82=E2=94=84 Format-specific differences are supported for ELF bin=
aries but no file-specific differences were detected; falling back to a bi=
nary diff. file(1) reports: ELF 64-bit MSB shared object, ARM aarch64, ver=
sion 1 (SYSV), dynamically linked, BuildID[sha1]=3Dba5dd46a2ef8dde79536f81=
dd8126e0ee2f3df39, stripped
> @@ -6,15 +6,15 @@
>  =C2=A000000000000004f40000000000001000000000020000000400000000000001a0
>  =C2=A000000000000001a000000000000001a000000000000001000000000000000100
>  =C2=A000000000000000086474e5500000000400000000000004780000000000000478
>  =C2=A00000000000000478000000000000001400000000000000140000000000000004
>  =C2=A00000000400000004000000000000015800000000000001580000000000000158
>  =C2=A00000000000000044000000000000004400000000000000080000000400000010
>  =C2=A000000005474e5500c00000000000000400000003000000000000000400000014
> -00000003474e5500ba5dd46a2ef8dde79536f81dd8126e0ee2f3df3900000000
> +00000003474e550047654bef50c6d25c99110c67c0eddb8e67b78bab00000000
>  =C2=A0000000000000000e000000000000005a00000000000000040000000000000350
>  =C2=A0000000006ffffef50000000000000380000000000000000500000000000003b8
>  =C2=A0000000000000000600000000000002a0000000000000000a0000000000000077
>  =C2=A0000000000000000b0000000000000018000000006ffffffc0000000000000440
>  =C2=A0000000006ffffffd0000000000000002000000006ffffff00000000000000430
>  =C2=A00000000000000000000000000000000000000000000000000000000000000000
>  =C2=A00000000000000000000000000000000000000000000000000000000000000000
>=20
> So, can we at least strip the files?
>=20
> Something like this (for all files):
>=20
> diff --git a/linux-user/aarch64/Makefile.vdso b/linux-user/aarch64/Makef=
ile.vdso
> index 82ed2011087..e5655888eb4 100644
> --- a/linux-user/aarch64/Makefile.vdso
> +++ b/linux-user/aarch64/Makefile.vdso
> @@ -10,7 +10,9 @@ LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -Wl,-z,max-page-=
size=3D4096 -Wl,-T,$(SUBDIR)/vdso.ld
>=20
>  =C2=A0$(SUBDIR)/vdso-be.so: vdso.S vdso.ld
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) -o $@ $(LDFLAGS) -mbig-endia=
n $<
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) -o $@.tmp $(LDFLAGS) -mbig-e=
ndian $<
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(STRIP) $@.tmp && mv -f $@.tmp $@
>=20
>  =C2=A0$(SUBDIR)/vdso-le.so: vdso.S vdso.ld
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) -o $@ $(LDFLAGS) -mlittle-en=
dian $<
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(CC) -o $@.tmp $(LDFLAGS) -mlittl=
e-endian $<
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(STRIP) $@.tmp && mv -f $@.tmp $@
>=20
> Or maybe we can use something else to make this "more reproducible".
No idea right now.

Helge

