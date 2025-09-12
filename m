Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42386CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 21:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxB4F-0002KG-N8; Fri, 12 Sep 2025 17:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uxB4E-0002K3-Cj
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 17:12:26 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uxB4C-0006EO-5G
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 17:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757711541; x=1758316341; i=deller@gmx.de;
 bh=a7mCyRxLWOiZtOZJEhQmO7xhnUsaYfCo6YSwU0rltrs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Dz+hrrmjpapx37xrpK5N8/EzSN2fQBaE5up4EEHv5+siC6sBhfKJAzVsMIc7fRK8
 wyEcLdFtRw0QbK5k48NrtroxXGEdWhSAFoE6Bd19cTuSFfLfuAeORyenn8qcgvqr8
 yaXts/GpVxxTOxaoiAJ5weZ4PG/Xq80JbzcCnMyNny8CS+P/KmN3BIZ2VP59h01zc
 OoMGnlhCOtfwOeG+/7bf7GaBPiR9cWXM+ykEeV2WAQtZOGey0DjDdFddHPplGaiBx
 cF9VNqDPZWOBfaXRzzNLewhpo9Io60/6CXEpeXjr3PA19+pdFfS4CuX1iDDpiSz9h
 8IAJS+7yWqAsx26MAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.58]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1unvff2v6U-00W6ch; Fri, 12
 Sep 2025 23:12:21 +0200
Message-ID: <8bd6755a-3e32-4c56-a948-61f27bdefd6c@gmx.de>
Date: Fri, 12 Sep 2025 23:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: seabios-hppa: is it acpi-aware?
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Development <qemu-devel@nongnu.org>
References: <c6aa3d2a-dfc6-4303-9a47-e0e2c3ffb2a5@tls.msk.ru>
 <9d4ae773-0414-4701-a59e-85873da26bf9@gmx.de>
 <ecfa6dad-aa24-46f5-8025-a42c7c31f623@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <ecfa6dad-aa24-46f5-8025-a42c7c31f623@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q1c9+N+lMzri/Ntu6d3FvMn8JDgArWYCosxw2DMdiW53mY0anZ0
 d4ycKmmNfED3x2YMGHzJO+HZFcr+AZLr4V6tTEPNb/3kP6yt+jhqDW+QiCgQ/TSPXyfLHgc
 TcpEb04V4FmgsQFvtngFcM4cq7RYHGLHhoqox1Np9IUee4ubK6fUXY5ZEsCa8L1DTVgGvmK
 fCtTEViUQ7BvbgedkcBdg==
UI-OutboundReport: notjunk:1;M01:P0:yob5s4HooI8=;kv21Gv680636oQFrtso25KFwDqz
 3YgFM7OVWbp1S6t+W2VaciB8ufoM3LkeM8Ba8LTyxyFYEQCfYG1SejRMzuUlUp1TMhoI9cPcV
 EIg6D9VUb/WR/fAFHBSINRR9E0yjeqnw3jVWH8bvjVTdxVZZmcdAfy1/hxs2EHCwAdayQ0XXM
 U5xQiFj8Gjl8sCqOJw4hROWTAkq4/dKF+0MgTuKjo0bcZfiFRojd+mDivJQlmLCt5sLp3nUWg
 TDtUq6DrDcSpo9SGpHbMVwFzRRFFHlTicy9ho3Pr16GTA9T2LfYPmgTtrRsaR0fvl7n5k6/Vv
 j380F5objZeIUgzJxIp+ir7vTYCZJ6ua/VXpX2LrAWBBi5B+mefAXSMq5PdD83fBexo5F611U
 860BLam4L+j9XCDRMxhgv/qjKEz/7hDAJaUurq/YKwyOF9ajxxz5RPRh3JIsMprKCdqsVaNVj
 FEbdAdwuxl/HFr5b5ZmEDttdOobcSA1x5RIFpvW+1o0D9zbylICKAT+tnplrYNaQcsbiWW/nm
 Pkk6RvNo6ZpGE7KY340YZGboI8yZKDWFTL26gonBG5q+y/U35iAKVurKebpSG4b8onAEks8Ij
 AfBYKBCJiRamPpD+KRtSz0RVz3OpyTrsoQ9XAfY5rXFSsrrIegw+evo/RDjijENYQNhqxFE4C
 AxmbzqCSP4wbESMXnFrj0s36sIQI0kc6fEhVEX0q7BkeU8JxvPlLiVcAbauVU7G97Dors1UHK
 hoDOGKg+cHc8+GgvyYMRwDJv5bUUobabPsBzqNNdL+SiSZav7+kqn1UJBbT5agA+7dKXgoRVp
 6uLY7+5TMITuEqZzlxNwGTYOeTYDCcsjlMBnbl+20luG1EjthjvzqzuoLTNIDbLuvELjVjE0U
 cwROTGWWLgVbX+/0t+9m1znPwUs3ygD7XO1iBU/FwgqKXJBh76FXQjT1Y2LEj/UG9fIgpDwkJ
 DYGOZs3LcD1ReGL5EKTBO+Vii28vdEr5VM7A+FNWLNPyrSp7NFtpwwkmqnriM/cz+KB//YdBV
 AgrS5IZy+cTtAwZ840EaOZM1zYUTUt51VInymgbPlmSUQolUemzu+lHBWJkhMwXYG0UdmIQcI
 eat9ZRl2Q1wYu1G1wmOiLx5R1FiCoH20ZpEBl0WXGhEaAMxz7ksP+pGl1qGPz7NuuXYrY1M+D
 24xGwEG4UeGbGDBJBix3Y36GmBUxmCpGVBk+Jrmxu2ylUhm30JNZX5ggJkxH60wbQFEXP0nLh
 75Z/TjkPTmjTCRoNYN246/8aR/CEZjSK/8VakniwdDj53k8GjXwmQjzlZcpvq2b3xmzEfm7IK
 cXnCyRGl69Gskme1FO/fdpStMHh0vcAGiILoXkk2G/keTVuQP6/4G4QASKUNSUgBiafB0OnmV
 HT3jj0NBqMa46rEcBtTqUei0ZIeIac08GhMggRWrp15Q0rNS04Cx9eOl1/d8tX0u4HvIkNTIn
 A9tFNJYdO/EOqAACd3WrQMbaeBzqTDXDbpgK8PS0F/AihF2bgXBjD9nz9j2qiH0FDIRU66Hbe
 Erm58XY859AOE20mF9bMFftl+xXjgw/81ntjGFUM8GylyUwcZhyZnQRGqbaiPf8YfmUs1to9k
 eU/n4wL601FnN6cHPiCiqzYqerCxcxGa3sfgFPyf+BSzWv0NXvlRvG4JFZicdtcBL95g+sheh
 ivkuXqkld/M3ugyjg+MWd08oo5B7jHbejo7AM4tFlIkAtlwyRgWCSCfjAqjWVRNeiYD2UOcFI
 oU/Cl2r/cl19QweARdXT7iTyfq3IvhTkIOTmik/bsirTK7qhbISVhN2HhVwilr2M2uYPdB50O
 jajJNcXWXgfpILjjIal6P9P3X6Y4xJXZlQUHE2mHJdIT+tTOC67JIy0N+2JGaYZAUxMQkpxe+
 nYY02PKruhdaGGDX66Dj0CdU2gVL7DC4SqgcEvktRF0kZGvIX1eqvbdTxofwWJrpaIPiiw7wX
 tdpyCSwsM9N+fO16Yrv/RakR8JI/DisaZUHI67T60yhZIfBhibzixjtZJhruAcjcc3SO8d4oo
 xdpcR4IjsEcHxTSiCgiMCW8a+9V8Eu6GRT3lr36wKn0DiI447Jq45vxVMMyA8z+h1/bo84N5l
 qMjSbmcuWhbl7EhHuw+KO0NmmmR/k7SDJBGV4uNbJpF1rw3rrF/BpIQraag2hrgPEWyvfUnwq
 /3R5hn56obM+4QzheS1ocJ1TjBJuK4r7tUvVp8vs6eMJzt1DhARRziXGpsQjXn/JKC1CuDo6A
 7dV6iuSKsRppZVrTcrO5RZ3Ea44AEhPA2tM0yzjVPUW7N6Q7oQFf/5+qxTM0WkSDSF9enzOg/
 UAQwQNcHFmKHmNIKu0kNd0kspncnyc+unWX4iXdsmKTkw73eb/OKhpEYK26fVIPc4LZxhyHZO
 9VNkVmgu/0wzzRlLNMDW3jHhOLEmwl+ufdmowrivQYMpCMh2w1zof+oy5FB0aVCle9b/H6zyr
 nSPla9TRCaL1+L6O5YZ9HWVcJYHToZoKRL0TYN1kluaPNSJ3xP2mfgtRkdmJQSleQb0fj0VI0
 RXkGBTCv9tCFX5d7i2dlzGDpD6eOkkIYSNov38V1nyP0PW+LBwEmzBsu8joqzb5klJHa5a0Nr
 H/MxR+IcoTun52CITWTFuQPfvbTxzNMKKH78vh4FUFKyd/gPTI8BmF68tXzxoAU9uiHxSA1KX
 sEfs0lqSUg/7d3PxZtqhVmAxMHENGOReSsXtm0eiq6aWTBM8Q64Ghw0U/g/HzN9TvppMZS31I
 lyrkquxk4ieXuZyOn3oU0k41FyhgJLEWgZWkfgHe88FUzEtJZVSnI2VKPS35qz6cgaT2eejKc
 bGOYKIZTT4S1abo0bGkq3T2LxT7XPT1azEHJznyQE3fYE7f5a820asm1x0YKK2n6lSvUkPdFU
 NJobf52TIOvvArIzy1/JsYvJWIN2TtR8Ky0lijlGkFzDuyw5UuAJpQk9DC51w6tLIOF4SL/+H
 weDn0nRHxFxcw7b3FO+DPSLt6pPJiSQ2AKO27XmGymX3jk5pTnrSYdy/CDVw4LF25s2V2esyS
 nh1C9j6aqfHGXbYYZUf7iFa1LWs7RiNo1nwIcEZmyHR1ynSqCir9pb4fCV5zHHBGO5xiNHLH1
 uw5dovMWPvxviUYWqpFp9+OLmyO7zdQKEYeeL8H0h8Lfad7UaFX876aCa8jg9iIbbIQJdrwhN
 OmtU6I9uUt6YexdqHacFRnYIAk6mvFszfeMLlzKXZ6oHuVnoPQbmV7rdxWpAW3dXRxCXDvdlc
 TuJGN4/GUKrq/S6gIgg6pjA5FLt2s10B5CZeb5Rn4A5JDuPa3Jz37d4OeOnqrvZhnxjIaEVex
 enFSChQI+KLqn8rqZl/2y1Y1RsKiI943fPoVfyjswAyZMLtuWHXiirwdVt+pvw+X8zct6Y51Z
 D4gJkEylcwTPg6H5+TP7EFMEZbxGAUWwIk9k5B4L1WRKFKy60/PW8PS6qWQP8l+NORfbl5AC/
 9UD8yik1Je1/er+gneSO5R/EQXKy6cHTDLWXDZg7rcgQ3HtfOJ2HZpdNpVdEoqQIp7boSfVKi
 USIA7Hdzi/SaXhtBim84KSo/60QZ5KAJ/n6ckPJExk0oQjseOlGL+knvOYM3RU2XbWhO3gZif
 mCtDoMLjPbWBC9c3tBaq6SuMsNEn/Wk0YcpfGZEpb/qQydyl5p06ixaJ+RBfTU5xegKsObmwE
 J7jxkImEgH1kqaJMasOXhxikWsz0DMvYIWytz3tLUGWPnCoM7McBEGIV5jIc4FBjFM1Be26AD
 k9kmwH/xe+Uflv6LCsWGZEeFq4nvTYdhc0G2yxw/OqV4uMS6Q62kfYb9VnrbFzj1mlIrLPUKj
 3nY+XuDPHxoVPcuAIdnyzwxllVTnF+mk6eXLbPmj1oiqlCUJ4LCNwl9OkdvElaKxTUx7q8+bR
 FeEWhsCjm9/sCSXeVAbXL2t266nVPKPoI+/H7HoWnzOVdkncxzb78B0ttkR4BX+NLjlEMsYfO
 HyTSL6hv6Z8Jno8MKaBiiHG1/1HiyCcBycrPPe0T67H2clR3HO7zK0VnqGjojHxp8c1IXZCCD
 vZvFJ0tG6a3cQ9aMD7FXydqUjlsDdyitK4hMCjXIrxZuUqTI/936rcqlJCuWbAzxTveQO+bN5
 PD5icsQYGT5NbZ37pmNdOeQmyzNFdW1gPga2M2kMNnVr45KA3U8HKTW7W/XYu1NJF3KwexqN9
 gcepvMwSo1hmu7mfuSBZjEF+2V9tr6oYiPQFh52FD9rnzqFEgAtm6v1mxpoudwn2O5mFAFP8M
 Kce9oicqqNO6BwaNZIk0QRVQBZdjevEDy//1ng+963USJcrTJS3W925CUzq9jUINb7p+zLlXK
 So9jl+4AGUx9M3qiR+i8WhC0/40ILuBHME6SrA/INtIhKRTgbWYAZL5PfLilDP7YDfhcMgxAN
 lCQc8w6XsaF9ijv8Mbv/QBe0mNbE93ncSsRU/8HBP6EFOUAbIp0B1kwAwaNC5M/JPy2GoLNM4
 oX/s4v10OU8N8aW3dtJtlD9MkICI3mR96cTU4zKLm+W5GP021Mm64fgGUK+PbL8uVv40CV02g
 7c3h8zOi3EgKAAyYZX7WxUrOu9LAy7R83PPQiQeyQv+dQi1ibzVTGyTZvBu6C+drLFE4VITd4
 Nd6u0CwyeNf7bJqq3j7zNYVJbH6X/7lWPPFOY/bgK5MNEx83c4azGTDa7RkkcxyD0C1FVk/oO
 s3mdGIA=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/12/25 23:09, Michael Tokarev wrote:
> On 12.09.2025 23:49, Helge Deller wrote:
>> On 9/12/25 22:35, Michael Tokarev wrote:
>>> Does seabios-hppa needs ACPI?
>>
>> No.
>>
>>> When building, it embeds the acpi tables (src/fw/acpi-dsdt.hex etc).
>>
>> That table can be dropped.
>> If you come up with a patch to build without, I'm happy to
>> apply it.
>=20
> It boils down to just this:
>=20
> diff --git a/roms/seabios-hppa/Makefile.parisc b/roms/seabios-hppa/Makef=
ile.parisc
> index 751a3479ca..d64118aca0 100644
> --- a/roms/seabios-hppa/Makefile.parisc
> +++ b/roms/seabios-hppa/Makefile.parisc
> @@ -44,5 +44,5 @@ SRC32FLAT=3D$(SRCBOTH) post.c e820map.c romfile.c opti=
onroms.c \
>  =C2=A0=C2=A0=C2=A0=C2=A0 fw/coreboot.c fw/lzmadecode.c fw/multiboot.c f=
w/biostables.c \
>  =C2=A0=C2=A0=C2=A0=C2=A0 fw/paravirt.c fw/shadow.c fw/pciinit.c fw/smm.=
c fw/xen.c \
> -=C2=A0=C2=A0=C2=A0 fw/acpi.c fw/mptable.c fw/pirtable.c fw/smbios.c fw/=
romfile_loader.c \
> +=C2=A0=C2=A0=C2=A0 fw/mptable.c fw/pirtable.c fw/smbios.c fw/romfile_lo=
ader.c \
>  =C2=A0=C2=A0=C2=A0=C2=A0 hw/virtio-ring.c hw/virtio-pci.c hw/virtio-blk=
.c hw/virtio-scsi.c \
>  =C2=A0=C2=A0=C2=A0=C2=A0 hw/tpm_drivers.c hw/nvme.c \
> diff --git a/roms/seabios-hppa/src/fw/paravirt.c b/roms/seabios-hppa/src=
/fw/paravirt.c
> index fba4e52db6..37ddac9c0d 100644
> --- a/roms/seabios-hppa/src/fw/paravirt.c
> +++ b/roms/seabios-hppa/src/fw/paravirt.c
> @@ -252,5 +252,5 @@ qemu_platform_setup(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0 acpi_setup();
> +=C2=A0=C2=A0=C2=A0 //acpi_setup();
>  =C2=A0}
>=20
>=20
> but I'm not sure this is the right approach - since it modifies
> the original seabios source (in paravirt.c).

I think that's Ok.
Both versions diverged anyway in the meantime.
 =20
> BTW, upstream seabios stopped embedding acpi tables in recent
> version.

Ok.

Helge

