Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C91C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wug3A-0005Ed-Sk; Thu, 13 Aug 2026 20:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wug39-0005ES-JC
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:45:31 -0400
Received: from sonic311-25.consmr.mail.gq1.yahoo.com ([98.137.65.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wug36-0007Wv-1s
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 20:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1786668324; bh=med8W4SJgsW4Ig9i60JVAUshGqMBQhKmKaNcqyw34Uo=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=GnFE0wEjl8TLFVgdgdoLeKo4SO8SFHLpLiLXXKgcblQoQD9GremCIya7ThPztxieROEqmd4UtQ1EFUkqnLnhCh+nI+95JJ7i15PnZej87iPJKtnhjoyt3wFFJJD+WyLhfBEA/th1Y+OahU2iP91zlHOW4ZFVvoK9L/v+yndUa3aQw1yqavtEw1mI3zuWkeh3lQb74IC/JkFZu0pDRMPipOEyUh2RqU9IapWQwBaBy4Rq87BgGPfZuzsmzpZ3WR0tnRJFszUL6o6WrjkyeQDsnngaV38poD88ceNnunnJhJi04XCIXn48dAG56AAuNehiuNagNQEy5MjczG9ibhg1ZQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786668324; bh=ty85poDP6eVDUAo7KTHE7uQndVo+Sjj+5dgt6tVZ+bm=;
 h=X-Sonic-MF:Date:From:Subject:To:From:Subject;
 b=JHZCRW/anWFB2RVfzWFTfq9Qj46suCFPalapPdjh81qyi8QyiOhkIrEITHUapbjvwfLHcshx9CtvsIgrgEK0hTVrhsU+X2j+RZ8CXjX8FvMI6wj+y2/50w7UVHVY5YYHBwC0mHhm5TW9SpaCw0JLI+7Vb4JH0VE58wyjvTaBfl8ifupX2LLZTHyw0lJne4FhGjfybjFepCzBG7XiHSz/ir9TRRP2/sFDbzfVSu17i/PBHuvg1gliUislk5PENaDfkd2US52JWHAR0Gbp7t9OcoGPWBhYEXWEMN4v+I+kbIyp3UVwkeIeYnj+yBxep97/CiQ+Y+lN0A6RFYwxtotz0w==
X-YMail-OSG: 477.2F0VM1lV8ulneowsKkjEQVFnxPmwkXHyZf5Ypm9eOiBCwIGgL15.UcLC2dt
 OkezSuUxQC2s3I6OjBo77emUL8qHYU0ZQSJzItaLDjfnja4crqonD1V4dovIf48.bSMEAxKixpQ4
 s7qYlAUkqlux643P682YBYo4O3.JyDr3i7aHN9ZrI3LOr.xAFrG3oA1azrQphlfUz7PuqaJmwXof
 jE0uCGwZFoLtCVcsHDqNfVnLIf46jr5GzC.Ri2EHyKb54v72BBRbUOmrsy0QG2u7vLGmgz3A8ZpB
 vDD5NCZ_20lCtI4TOlQfVelWi8RisEClBRMDS5wQ6P0xi48FCGce1cjr84lIYMcdli4bMx3b1fpZ
 D3YWHnLhQCj3sxmycqUKkshVtW0zpycDKXlO_VwP46.vsFEsU_arqYIWuUxsaZh7KdyyXf6zeaMc
 nnsXN1ZBEUA3QZKYKeCnuGat1DLNKCVH04fGPfFtcS.FaJ5qvittjsrLZYNa.D6iN1vdicQgNY2w
 JQ.1IDVr7TSB..jFT5LYGQUZu5pua6GPEfNqQDjGFjzlhFnnp74gpq3AiUeeIIXTK5V.VlK5P_NT
 1pQtfGvG4JukU3jdxrcsZWyUf_boRUC.nqmp0xmFUwpmX64yxA6N1NXUTmKRLyUfvKIUy6TrGag7
 GMb79hi_.FG4qbt0p7rMQKD3CUYnnIdGuYozR31kzXiifg6oUBevRkiBAHpLchRSim3_BrXriy9l
 8vaNEpzp5CqSUcwtWgzJ6SikxH.soILygMtLEX.RpsUKP_ya4.LTyrIiz3715Km8my0V23pRPun9
 pXLNEvqGx4GACxptAWvvWOfnG6JNk7dYweIhfWcRmGXQi0FjgT7mGhQYhTQPS7chbhUmng25kGdr
 owQu5Ey4x9aiTQcNYGhAFOUSOnPpC8D1q8d2RTQbTvGKj6mTp.KIR8GvZ9oQglVe7sZKdIrQOuBq
 LaM0BiwRfJqOcGPys5NJryKyARMD3bIN4ocmW48G7wMNBPK4MM1pCJ95IrVLm4mCEKBsZ9d3NELb
 BFvDGpDl_Ednda2ImSf2pnRDNN6a2Dzax_tojsqvrm4y3Y81hN3MleL892shG658VMUGjvpYeYX4
 V6uvjkwYUY3ZDiJGCvTkph2VZ53yZ1b4ghtafsQ.iigUw5zLhawGuD8ZUZbqzC9Ini0yI12L4u80
 Scj37U7MPvsxghVd.WThOH_Y3ddQWx86u7OK1G0iiW71TPVvxtsC9b00yW2ILqJNwNx_hDTUNmC0
 YoQYNIS2.3MvMfijJKuohu9R2hFmvG_UHL0bsPmfCi86BHdjN.vJTE.NEg4eEuGxWr6vXWZMxcAm
 kZhEczaeVrd5OmfrDRHcY4EuHk9wPSN319bBdh3OAx3JoBPGR2HrPRP7O.86gnkN2yUr3EyCSI6J
 bWgWBWLpXh6sDkMAAB3tMpZelrcf7R3C0Y2o6Dt8kILeQoWISqw.sBR5rUUUcXVbICGjPHCZSxIK
 BNDVtoycpCSYyJWf9qYGKc6OWSbrCCudm0z3nUrmJ8h05QrJtUhd7qAj1LVTeNctZhAnyZLIk_47
 V82en2.qs9n43gzm7Qj_lRUMn.w9k2zbNFhv_tGBGlDb6K7n9_IKjl1SX8JkGlnV5tLTBhjrP_dC
 WZNTLl7zkBOgwOyQSjlTpxAjborJhXI8xpeMqe2wxncqi6nw4aFn3RCG7xGATj.da7agYTV_i.s4
 qImf0mdwEUgyOoILpFXJRX5Y2uNbceW1hXOP5Wmm64j9OFOZS45Umg72W5IPZhr1NrmY2Z8yBGva
 K5HsDkMOEvL33JGD4oFDQ0S1hChjpR2Fpnq1px.krzt60kBxL8ScS3YfWm7LRWXTpiKAbGrlOne7
 oJBZisT2MQAWLjdr_Kq64QJJ8UormUn7Rr_7cF3cRHT0VeUWxPt7C5.vHALPm2R0Y06tbDa_18xs
 Nzes76xtrnfleyocMTvDwNIlrbM5xktSyrXmIlDtLJvXm8zpGbu7_IQYRJjz0Mb3P_6eW2ZnSecw
 dr.Vk2a_plcjIwvUBVGqY3zzsmtmjWi6AfpsM2YuV5pRvGAfoQInOGy.a_e7P7YvdbFWFwnVPvti
 cwowGa3rt0Zzehy0CdN6VRszJn_2C5Y9eSnjbLUhCfit6c8kw7Qk7_PlimrRkpbZB3H6W6oiw8Rn
 3A.pEnJp25vYMqwpTD7W0sIEkeoxADVeKXn_37w_Ausv2NrVGDX5rO6VcO7byz.5zqJXo9MPBx5S
 2ME.uNamyuOiuHG0FwoyVutcmufzGIAP7MuiZTlWDAoE-
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: 627afcf6-d3c6-44e4-93b4-0916a4facba5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 00:45:24 +0000
Received: by hermes--production-bf1-54b5569bdc-bf8lf (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID c68ffe5c704d55fdb9e81073ff8d3cd9; 
 Fri, 14 Aug 2026 00:45:22 +0000 (UTC)
Message-ID: <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
Date: Thu, 13 Aug 2026 20:45:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chuck Zmudzinski <brchuckz@netscape.net>
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
Content-Language: en-US
In-Reply-To: <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.206; envelope-from=brchuckz@netscape.net;
 helo=sonic311-25.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 8/13/2026 6:35 AM, Jan Beulich wrote:
> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>> -- snip --
>> To address this problem, this patch implements support for
>> Intel IGD devices with an extended VBT and OpRegion version 2
>> and higher which is required for most modern Intel IGD devices.
> 
> First of all: Where's the spec of all of this?

Hi Jan,

Thank you for your review.

Well, your first question is quite provocative. Certainly more
social/legal than technical.

I presume by "all this" you mean code in this patch such as:

#define IGD_OPREGION_RVDA 0x3ba
#define IGD_OPREGION_RVDS 0x3c2
#define IGD_OPREGION_VERSION 0x16

which defines the offsets of the rvda, rvds, and version fields from
the base address of the Intel OpRegion.

Also, I presume that "all this" includes the meaning of the 8-byte
rvda value, the meaning of the 4-byte rvds value, and the meaning of
the 2-byte version value.

So my answer is as follows:

I do not have access to the official spec that defines "all this" but
I do have access, as does the general public, to the Linux kernel's
implementation of support for the Intel IGD from many sources such as
git.kernel.org. The Linux kernel has enough accurate information about
the spec of "all this" to provide very good support for the Intel IGD
on bare metal.

To elaborate a bit more, the spec of "all this" can be derived from the
Linux kernel code that supports the Intel IGD. It would certainly be better
to have the official spec from Intel, but alas, as far as I can tell, it
is a proprietary spec that is most likely only available to Intel's OEM
customers who need the spec to write the firmware for these devices. Of
course we could ask Intel for the spec because we write firmware for these
Intel IGD devices too. How do you think that would go? You, as the maintainer
of Xen firmware that (at least implicitly in xl.cfg man pages, etc.) claims
to support the Intel IGD, certainly have the right to ask them for the spec.
Me, as a lowly customer/user of a handful of their devices at most, probably
has less of a right to ask them for the spec.

The situation here is analogous to Xen support for the Processor Properties
Topology Table referenced in a commit that you Acked [1] just a few weeks
ago. I presume you Acked that commit not because it is based on an official,
open spec of the Processor Properties Topology Table that is available to
the public, but because it is based on Linux kernel code that supports
the Processor Properties Topology Table.

[1] https://xenbits.xen.org/gitweb/?p=xen.git;a=commit;h=99794c8a8ff8b1d277c09d4736384fd5bb94f2d6

So it was acceptable to use a spec of the Processor Properties Topology
Table derived from Linux kernel code as the basis for a commit to the Xen
codebase just a few weeks ago. Why would it not also be acceptable to use
an updated spec for the Intel IGD OpRegion and VBT derived from Linux kernel
code in the code for tools/hvmloader in the Xen codebase that already
has code that is based on the spec for older versions of the Intel IGD
OpRegion and VBT?

> 
>> ---
>>[...]
>> 
>>  tools/firmware/hvmloader/Makefile         |   1 +
>>  tools/firmware/hvmloader/config.h         |  15 +-
>>  tools/firmware/hvmloader/e820.c           |   4 +-
>>  tools/firmware/hvmloader/intel_opregion.c | 297 ++++++++++++++++++++++
> 
> Nit: Please use dashes in favor of underscores in new files' names.

Ok.

> 
>> --- a/tools/firmware/hvmloader/Makefile
>> +++ b/tools/firmware/hvmloader/Makefile
>> @@ -35,6 +35,7 @@ OBJS += smp.o cacheattr.o xenbus.o vnuma.o
>>  OBJS += e820.o pci.o pir.o ctype.o
>>  OBJS += hvm_param.o
>>  OBJS += ovmf.o seabios.o
>> +OBJS += intel_opregion.o
> 
> While this list isn't well sorted, I think your addition still wants to move
> up by a line.

Ok.

> 
>> --- a/tools/firmware/hvmloader/config.h
>> +++ b/tools/firmware/hvmloader/config.h
>> -- snip -- 
>>  #define PAGE_SHIFT 12
>>  #define PAGE_SIZE  (1ul << PAGE_SHIFT)
>> +#define tools/hvmloader/pci.c3
>> +#define IGD_OPREGION_SIZE ((IGD_OPREGION_PAGES - 1) << PAGE_SHIFT)
> 
> This is odd, and hence wants a comment.

Yes, I could add a comment, probably a long one, to explain this
oddity. It is a problem of backward compatibility where we have a
definition, IGD_OPREGION_PAGES, that is currently set to 3 both here
in hvmloader and in the Qemu DM, but should be 2 because the OpRegion
size is really exactly two pages but the current implementation set it
to 3 because the host OpRegion is not always aligned on a 4k page
boundary so three pages are needed to map the entire host OpRegion to
the guest. I could re-write the patch setting IGD_OPREGION_PAGES to 2
and avoid a comment here, but that would complicate the logic of how
igd_opregion_e820_pages is calculated and probably introduce the need
for comments in other places. 

I am open to suggestions about how best to handle the backward compatibility
problem and the problem of ensuring compatibility between hvmloader support
for Intel IGD passthrough and DM support for that same feature. For now,
however, I am trying to keep what is applicable to the current implementation,
and this odd value of 3 for IGD_OPREGION_PAGES is one of those things
I am keeping for backward compatibility.

Perhaps the best solution would be to presume there are so few current
users of this feature that we do not need to worry about backward
compatibility and breaking existing setups. I say this because the code
here in hvmloader and in Qemu upstream to support Intel IGD passthrough
is very badly bit rotten and I doubt there are very many, if any, working
implementations currently in the wild based on unpatched vanilla Xen/Qemu
upstream code, particularly with more modern Intel IGD devices and more
recent versions of Qemu. If you give your blessing, then I can rework the
patch without worrying so much about backward compatibility and about what
happens when a guest is configured with a version of hvmloader that has
this patch and a version of the DM that lacks the compatible patch, and vice
versa, that is, when hvmloader lacks support instead of the DM lacking
support. Then we could completely remove this oddity of setting
IGD_OPREGION_PAGES to 3 in the current implementation in both hvmloader
and the Qemu DM as well as many other oddities that result from the current
implementation.

> 
>> +#define IGD_OPREGION_RVDA 0x3ba
>> +#define IGD_OPREGION_RVDS 0x3c2
>> +#define IGD_OPREGION_VERSION 0x16
>> +#define IGD_OPREGION_MASK 0xfff
>> +#define IGD_OPREGION2_SUPPORT_MASK 0x1
>> +#define IGD_OPREGION_SIGNATURE "IntelGraphicsMem"
>> +#define IGD_VBT_SIGNATURE "$VBT"
>> +extern unsigned long igd_opregion_pgbase;
>> +extern uint32_t igd_opregion_e820_pages;
>> +void intel_opregion_setup(uint32_t vga_devfn);
> 
> Blank lines please ahead of the new #define-s you add and between those new
> #define-s and the new decls.
> 
> For igd_opregion_e820_pages I further cannot spot any use which would justify
> the use of a fixed-width type; unsigned int will do, and will then be in line
> with ./CODING_STYLE.

Ok I will pay more attention to CODING_STYLE. I know that libxl
has a specific CODING_STYLE document. Is there a specific one
for hvmloader? I do not see one in the tools/firmware/hvmloader
directory. I assume the one that matters for hvmloader is the
one at the top level of the Xen code source tree, not the libxl one.

> 
>> --- a/tools/firmware/hvmloader/e820.c
>> +++ b/tools/firmware/hvmloader/e820.c
>> @@ -243,11 +243,11 @@ int build_e820_table(struct e820entry *e820,
>>          nr++;
>>  
>>          e820[nr].addr = igd_opregion_base;
>> -        e820[nr].size = IGD_OPREGION_PAGES * PAGE_SIZE;
>> +        e820[nr].size = igd_opregion_e820_pages * PAGE_SIZE;
>>          e820[nr].type = E820_NVS;
>>          nr++;
>>  
>> -        e820[nr].addr = igd_opregion_base + IGD_OPREGION_PAGES * PAGE_SIZE;
>> +        e820[nr].addr = igd_opregion_base + igd_opregion_e820_pages * PAGE_SIZE;
> 
> Are these new multiplications at risk of overflowing? I.e. how many pages can
> there be in an extreme case?

We are allocating down, so as igd_opregion_e820_pages grows, igd_opregion_base
will shrink. The danger is that igd_opregion_base will go below the minimum
possible value that is compatible with our memory map. I could add a check for
that. I think our memory map allows for tens if not hundreds of pages in the
region where the OpRegion and VBT are located, and typically the OpRegion + VBT
is only about 4 or 5 pages. It should probably be a BUG() if somehow we detected
a VBT whose size was large enough to cause this problem.

> 
>> --- /dev/null
>> +++ b/tools/firmware/hvmloader/intel_opregion.c
>> @@ -0,0 +1,297 @@
>> +/*
>> + * intel_opregion.c: HVM Intel OpRegion setup.
>> + *
>> + * Leendert van Doorn, leendert@watson.ibm.com
>> + * Copyright (c) 2005, International Business Machines Corporation.
>> + *
>> + * Copyright (c) 2006, Keir Fraser, XenSource Inc.
> 
> What do these cover?

I am considering this new file to be a modified/derived version of
tools/hvmloader/pci.c, so if I understand correctly this file needs
to retain the copyright information of tools/hvmloader/pci.c. At the
very least, the #include statements at the top of this new file which
are from tools/hvmloader/pci.c are covered by these copyrights. I also
consider the statements that are moved from tools/hvmloader/pci.c to
this new file to be covered by these copyrights. IANAL, so to be safe,
I include these copyrights even though the covered code is relatively
small compared to the rest of the file.

> 
>> + * Copyright (c) 2026, Charles Zmudzinski.
>> + *  -- snip --
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program; If not, see <http://www.gnu.org/licenses/>.
>> + */
> 
> Please use an SPDX line instead in new files.

OK.

> 
>> +#include "util.h"
>> +#include "config.h"
>> +#include "pci_regs.h"
>> +
>> +unsigned long igd_opregion_pgbase = 0;
>> +uint32_t igd_opregion_e820_pages = IGD_OPREGION_PAGES;
>> +
>> +static bool verify_opregion(const uint32_t addr)
>> +{
>> +    const char *opregion_signature = IGD_OPREGION_SIGNATURE;
>> +    if ( memcmp((const void *)addr, (const void *)opregion_signature, 16) )
>> +        return false;
>> +    return true;
>> +}
> 
> Style: Blank line please between declaration(s) and statement(s) as well as
> ahead of the main "return" of a function. There further isn't really a need
> for an if() or two return statements here. Also please avoid casts wherever
> possible. Finally, the local variable isn't really needed here either - the
> string literal can be passed directly to memcmp(). All of this helps
> readability as well.

OK.

> 
>> +static bool verify_vbt(const uint32_t addr)
>> +{
>> +    const char *vbt_signature = IGD_VBT_SIGNATURE;
>> +    if ( memcmp((const void *)addr, (const void *)vbt_signature, 4) )
>> +        return false;
>> +    return true;
>> +}
> 
> Same comments here, obviously (and potentially elsewhere).

OK.

> 
>> +void intel_opregion_setup(uint32_t vga_devfn)
>> +{
>> +    uint32_t igd_guest_opregion;
>> +    uint32_t pages_needed; /* for OpRegion + VBT */
> 
> The former probably wants to be fixed-width, but for the latter I see no need.

OK.

> 
>> +    void *opregion_scratch;
>> +    void *vbt_scratch;
>> +    void *vbt_source;
>> +    /*
>> +     * absolute value in the host/guest except
>> +     * as noted in the comments
>> +     */
> 
> Nit: Comment style (see ./CODING_STYLE).

OK.

> 
>> +    static unsigned long rvda_host;
>> +    static unsigned long rvda_guest;
> 
> Why static? The function can't be called more than once, if I'm not mistaken.

I think you are right that we only do the setup once so I will
drop static here. I still think if I drop static I will want to
initialize these to zero later, because (correct me if I am wrong)
only static variables are initialized to zero if not explicitly
initialized, and without either static or an initialized value,
these would be initialized to some undetermined random value
until explicitly set to the desired initial value. Of the two,
I think that the more important one to intitialize to zero is
rvda_host, because I use an initial value of zero for that variable
to test for the case when we do not need extended VBT support.

> 
>> +    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
>> +    /*
>> +     * Tentative value for the number of pages to reserve
>> +     * in the E820 map for the OpRegion and VBT.
>> +     *
>> +     * This will be the final value for the E820 map if
>> +     * the device model lacks support for OpRegion 2 or
>> +     * if the host OpRegion version is < 2 or if we never
>> +     * allocate more pages in the E820 map for the VBT.
>> +     */
>> +    igd_opregion_e820_pages = IGD_OPREGION_PAGES;
>> +
>> +    /*
>> +     * Read the value the device model is initialized with.
>> +     * If the device model supports OpRegion 2, it will
>> +     * return the host IGD OpRegion address. If not, it
>> +     * will return 0. If the device model does not support
>> +     * OpRegion 2, the device model expects us to give it
>> +     * the address to which it will map the OpRegion in the
>> +     * guest and then expects us to do nothing more to setup
>> +     * the OpRegion, so that is all we will do in that case.
>> +     */
> 
> Hmm, exposing the host opregion to a guest certainly feels like an issue.

Well, that is how it is now. I am only retaining it to maintain backward
compatiblily with DM versions that do not support the extended VBT and
OpRegion 2+. My previous comment about backward compatibilty and DM
compatibility also applies here. If we don't worry about that, we can do
away with any cases where we are permanently mapping the host opregion to
the guest and implement this new approach of always exposing a copy of
the OpRegion and VBT to the guest instead.

> 
>> +    const uint32_t igd_host_opregion = pci_readl(vga_devfn,
>> +                                                 PCI_INTEL_OPREGION);
>> +    if ( !igd_host_opregion ) {
> 
> Nit (style) Brace placement (throughout).

Ok. I see this is not the proper coding style.

> 
>> +        printf("device model lacks extended VBT "
>> +               "support. Continuing with legacy support only\n");
> 
> This message can easily confuse / worry people. (If it was to be kept, it
> would also need style adjustment.)

I think some message is needed here to indicate the incompatibility of
versions of the DM that do not support the extended VBT with versions
of hvmloader that do, especially if we are not going to worry as much
about the backward compatibility / DM compatibility problem I mentioned
multiple times in previous comments above.

This message could encourage upgrading the DM to a version that supports
the extended VBT instead of just giving this scary notification.

Also, I will more carefully read CODING_STYLE and try to fix all those
issues you have pointed out (and any others I might find).

> 
>> +        /*
>> +         * Write the the OpRegion offset to give the OpRegion
>> +         * address to the device model. The device model will trap
>> +         * and map the OpRegion at the give address.
>> +         */
>> +        pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>> +                   igd_opregion_pgbase << PAGE_SHIFT);
>> +        return;
>> +    } else {
> 
> No need for "else" after an unconditional "return".

Ok.

> 
>> +        printf("host OpRegion address: 0x%x\n",
> 
> The shorter %#x please (also elsewhere).

Ok.

> 
>> +               igd_host_opregion);
>> +    }
>> +
>> +    const uint32_t igd_host_opregion_page_offset =
>> +                   igd_host_opregion & IGD_OPREGION_MASK;
> 
> I think like in the hypervisor we don't want to mix declarations and
> statements just yet.

The only way I could separate the declaration from the statement would be
to drop the const modifier because if I do:

    const uint32_t igd_host_opregion_page_offset;
...
    igd_host_opregion_page_offset = igd_host_opregion &
                                    IGD_OPREGION_MASK;

The compiler will report an error. If I drop the const modifier from
the declaration, the compiler will not report an error but I lose the
protection the compiler gives me from making mistakes by modifying a
variable's value that should be constant.

I am not a C guru but some research indicates that while it is legal in
C to declare a variable with the const modifier without also assigning
it a value at the same time with a statement, it is not recommended to
do this because the variable will be initialized with some undefined
random value that cannot be changed because we used the const modifier
in the declaration. This implies strict enforcemnt of the rule "we
don't mix declarations and statements" results also in the corollary
rule "we never use the const modifier for variables in C."

> 
>> +    igd_guest_opregion = (igd_opregion_pgbase << PAGE_SHIFT) |
>> +                          igd_host_opregion_page_offset;
>> +
>> +    /*
>> +     * We know at this point the device model supports
>> +     * OpRegion 2.
>> +     *
>> +     * Indicate to the device model that we support
>> +     * OpRegion 2 by setting the least significant bit
>> +     * of the address we give to the device model.
>> +     * The device model will notice this bit set and
>> +     * respond appropriately to our writes to the
>> +     * register where the OpRegion address is stored.
>> +     */
> 
> Specifically noticeable here: Please make better use of line length in
> long(ish) comments.

Ok.

> 
>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>> +               (igd_opregion_pgbase << PAGE_SHIFT) |
>> +                IGD_OPREGION2_SUPPORT_MASK);
> 
> This looks to imply qemu is the only possible device model.

Yeah, this is an issue. Other device models that intend to support
the Intel IGD with hvmloader will also have to be compatible with this.
It would be easier if we did not have to worry about backward
compatibility and supporting what we had in the codebase for many years
in both hvmloader and Qemu and we would not need IGD_OPREGION2_SUPPORT_MASK
in that case. Instead, we would just completely deprecate all previous
implementations of the Intel IGD passthrough feature in both hvmloader and
the Qemu DM as unsupported. So my previous comments about backward
compatibility apply here again.

> 
>> +    printf("guest OpRegion tentative "
>> +           "address: 0x%x\n", igd_guest_opregion);
>> +
>> +    if ( !verify_opregion(igd_guest_opregion) ) {
>> +        printf("error: IGD OpRegion signature "
>> +               "not found.\n");
> 
> No full stop in messages please.

Would it be OK to just get rid of the error message here?

> 
>> +        BUG();
>> +    }
>> +   --snip --
>> +        rvda_host = 0;
>> +    }
>> +    const uint32_t rvda_host_page_offset = rvda_host &
>> +                                           IGD_OPREGION_MASK;
> 
> Why host_page_offset here when ...
> 
>> +    const uint32_t rvds = *(uint32_t *)(opregion_scratch +
>> +                                        IGD_OPREGION_RVDS);
>> +    const uint32_t rvds_page_offset = rvds & IGD_OPREGION_MASK;
> 
> ... it's just page_offset here, and when further you use it below to set
> rvda_guest?

The size of the VBT, rvds, is the same on both host and guest, so we do not
need to specify host or guest, but the base address of the VBT, rvda, is
not the same on the guest as it is on the host, so we need to specify which
one for rvda. I can change this to rvds_host_page_offset because it is
not wrong, but it might be confusing because I use that value later on
for computations involving the guest also.

Actually, I only use rvds_page_offset below to help decide whether or not to
retain the host OpRegion page offset in the guest. I don't know if this is
necessary, though, and I could test without retaining the same page offset in
the guest and always place the both the OpRegion and the VBT on a page
boundary in the guest (if I place the OpRegion on a page boundary and
also always place the VBT contiguous after the OpRegion, the VBT will
always be placed exactly two pages after the base of the OpRegion and thus
also on a page boundary). All the devices I test have enough room to retain
the page offset of the host in the guest without requiring allocation of
an extra page, so if there are regressions I will notice them in my testing.
If always placing OpRegion and VBT on a page boundary works with no regressions,
then I could completely remove rvds_page_offset from the code. I will still
need rvda_host_page_offset though, because it is needed to get the exact
location of the VBT in the guest when the DM temporarily maps the host VBT
to the guest.

> 
>> +    printf("VBT size: 0x%x\n", rvds);
>> +
>> +    if ( !rvds || !rvda_host ) {
>> +        printf("guest OpRegion address: 0x%x\n", igd_guest_opregion);
>> +        rvda_host = 0;
>> +    }
>> +    /*
>> +     * Write rvda_host as 2 successive 32-bit values
>> +     * to communicate location of the VBT to the device
>> +     * model. If rvda_host is not 0, The device model
>> +     * unmaps the OpRegion and eventually maps the VBT
>> +     * after we also write the guest address where the
>> +     * VBT will be mapped.
>> +     *
>> +     * If we send rvda_host = 0 to the device model, it
>> +     * will assume we do not need OpRegion 2 support and
>> +     * it will not unmap the OpRegion.
>> +     */
>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>> +               (uint32_t)(rvda_host & 0xfffffffful));
>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>> +               (uint32_t)rvda_host_upper_32);
> 
> Why would you need to communicate a host property to the DM?

The DM cannot access the host rvda value because it is only accessible
from the host kernel, and the DM is only a user-space process on the host.
The KVM/vfio solution is to have the kernel vfio driver provide rvda to
Qemu, and I think it would be possible for the xen-pciback kernel driver
to also expose rvda to the DM, but that would likely require patches to
the kernel xen-pciback driver and probably also to libxl or other toolstack
which uses QMP to plug the Xen PCI passthrough devices into the PCI bus
provided by the DM. This solution avoids needing to touch libxl and kernel
drivers.

> 
>> +    /* In this case, we use the mapped OpRegion */
>> +    if ( !rvda_host )
>> +        return;
>> +
>> +    /*
>> +     * Update the number of pages the device model
>> +     * needs to map for us to get a copy of the VBT.
>> +     *
>> +     * N.B.: Here, igd_opregion_pgbase is really the page
>> +     * base of the location where the device model will
>> +     * map the VBT.
>> +     */
>> +    uint32_t vbt_pages_needed = rvds >> PAGE_SHIFT;
>> +    if ( rvds & IGD_OPREGION_MASK )
>> +        vbt_pages_needed++;
>> +    if ( vbt_pages_needed > igd_opregion_e820_pages ) {
>> +        igd_opregion_pgbase = mem_hole_alloc
>> +                              (vbt_pages_needed - igd_opregion_e820_pages);
> 
> Nit: Indentation.

Ok. It should always be a multiple of four spaces, I presume. I admit I did
not check that.

> 
>> --- a/tools/firmware/hvmloader/pci.c
>> +++ b/tools/firmware/hvmloader/pci.c
>> @@ -43,7 +43,6 @@ uint64_t pci_hi_mem_start = 0, pci_hi_mem_end = 0;
>>  #define BAR_RELOC_THRESH GB(1)
>>  
>>  enum virtual_vga virtual_vga = VGA_none;
>> -unsigned long igd_opregion_pgbase = 0;
>>  
>>  /* Check if the specified range conflicts with any reserved device memory. */
>>  static bool check_overlap_all(uint64_t start, uint64_t size)
>> @@ -190,14 +189,7 @@ void pci_setup(void)
>>                  virtual_vga = VGA_pt;
>>                  if ( vendor_id == 0x8086 )
>>                  {
>> -                    igd_opregion_pgbase = mem_hole_alloc(IGD_OPREGION_PAGES);
>> -                    /*
>> -                     * Write the the OpRegion offset to give the opregion
>> -                     * address to the device model. The device model will trap 
>> -                     * and map the OpRegion at the give address.
>> -                     */
>> -                    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>> -                               igd_opregion_pgbase << PAGE_SHIFT);
>> +                    intel_opregion_setup(vga_devfn);
>>                  }
> 
> With this preferably also drop the figure braces.

Ok.

> 
> Jan


