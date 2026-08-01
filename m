Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F0C55175
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 12:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8RD-000267-5O; Sat, 01 Aug 2026 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wq8RB-00025o-Op
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:03:33 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wq8R9-00054w-OE
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1785585808; bh=W0MydP2oUX8/HYVYaoYYc6r8/esVa87AQ2CEiLLTU1E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=ffC9Ik3graT2CJhW++p7INhiiZEAHJIgo3bsG+g/reKKr7HZ/P4uyycCyMpDguWtYS38lLy9zPVLhB5RVYfHLQn86SacE1qCWbjmrdRH8H6NYE3iBqQ8Mhjc0U/LfNXdXuTs/ks5LYZLgOUfFWCNudc/Fh5Ad6OOLDgm/jv8KtOS26ttk2qzBI59+N4gCbbc48i3vJ/dKAcNmgMxKrjImk8jDZlxMjTKo3FU080qFYj/++60OOF1u19i6DIQRIsQ6zEk91nOnfXRB+8FToYJdsPktyZnxKiwwXBf3s5h4tHzHv7mPsy5WZN6SOUlX7goBlGWRpj6g88Rf8HF5lptVA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1785585808; bh=VA3wADtmLWVH2/OEkFO9nIiNxhVsfZRpcgwrie4z1wo=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=TumVOIKNKpXhAVJmMPra0bLYp46neYIUct0hSGptSSiiP03izywkag8iVlv7cvg64oh9NqVpbsTq1SbDqSHaM/rnZy7u+/GFbqgAV46CpILoy8iwNNB1U/3znf0vQIYT1dGIlVGqgk2Lq5JndZfo1kd05515Sm/1iZMPXutm+g2RZH0yiYwjc3RLbJ2uXs0OJJ3VtGKqqDREuhijI0lc9BnavX5jCQLmeYhGgrxQP2fjo3schk4JrS9Jm55fkUZ7q4dU0feMwExuLWdd9HoYa6TQXb83wewLZw0LP/7fulU//MmRM8yrh/haRHjUH4zvwC8UsEmEU0xHmZTQJj657w==
X-YMail-OSG: 7AOkLyYVM1nc0L2KIboVCyc2u3fUpk01ULdAuHHVXgEIrgHjs_utYiXQ7Qhf420
 VT5ESB0Y6XHjA0QySs7e_CVe7JDA8XhV8k0EyCXUUDWHIEsvHsSzeajILGXneruw_uOJc_KgGol_
 7kyGnFb.8NtPYUWKyISUYzLSklmnE8pkyNgwODg0QdjVcDQD4LLGHVEGLpnRdGlxO0OWrJHG9bWA
 MfOID75l5SZ7QYmQvviM38Xx2jrjcPzqtG.LRZRsGdST.nTLnAkmf0J2tZkUfcL.qyHJXGHqeHT0
 DS6RG1elXwk.VYT1TyxR94EIqfwhcXST5HVjEv2azWmcQ10Z.q.EZ1nyAIa8dJ0YPSfr9HHS4R0K
 bX9MEEPiUUFd.Bb6Ba8LmSGpnZ0g3zke7Sp0dtX0p7jn3KBUxrdo89331srrIz.JhSdSJLdw9_0h
 DRn1bD3C3XySL0Hr.8rGMcOnBXJ6LSBYXYJTynxmOlmO_3JOFJ2ZsrasmqFxKl_6xHjUDCvRskm9
 zbwA_bLtxZUcw4F.4TSJrEsAuupNxqBu1IFIpl_SUDAAXvbk9FeAhAiHronBFsykkvr0RTlKsPSj
 h1OnB3xmCY_uhIyrznnyf9GX_gABBChwlX2wfr9s2ycJ8xNPAwLLVtONMNx5wD9E3S7jmTeEK6P5
 5mTvNr4qMBpCnGnBCvmlADi9Aong2W4lTkCBEU7vUiMfQPzu4QanDZfNJ_fDdospmBGNol3aKc_3
 Z9nacZUYws1q1R3GRsDfgBYLcKsjdNYxiFw42kfQFcDfz.GFCqpVNIOZtYrlVQqKCOZUkvNWJAdC
 and42_N3cqaddYlOuYWMYF0_7SC1aGA1UvH6k7MX1edgDOj1kK8Ue7SB1P90UEKXIXlfqzx8Gd5o
 SmC.Z2kWbzKrfojIOswLtDzRvJneint46VOsuhqLa_sODPQ3INjBzvHXfykwjhJ.I2Cp4A2MyQ7L
 Rvdm3HjHd4wLEeamS9TXJ8rVfLV8bMYYJ2t2RxHus_nELfQpvgu9s_2F8C5n6EftOwtU3SbmSIxm
 Mr1U6Ug6pAnR8N6hRFRBrK3Q9fYD8i5yJzTnq2ZPLwcs1kOPagQE31QWVfGz6ZmBw4kphSM2MG48
 S4Ja40GRmTfKYvNZIQzIlnM03HHw3kB99nk07qTDtn4v0lN4mlUMnJAOc2sIO00c4jZ0zC_lVP.x
 HlUrEb6PI8H.jDPXfKRXCB1.hsDQBti4pfK1.3KoGZXjyryBr8r7EknKFzL_EWNcme2toBjP8W8Y
 2qPYWnV_RofGLsIUtbWwIkWLZU5pvNjEIbkDXBhqp7jBR5_Rb2O90Cvqa5Zshq4loupZa8P_Vt7_
 vee549jbJ0OTVf2.D8gnRPdBrouQ5vR6paWvYNJt5R7YeojbZXC3HmahVClWcgjcqoZH.Ew4lLAM
 YslY7bjVWhne0HqbAOhltpVgtc60dvBMhupgUgEoa7PkgUtUPSqtl6H5J9XPqGZyFm95cg0IGb36
 FGxSBesQKzm4NCD6wWRujxR8taVaIg7YID6nrjlM3aQCElD4E8cvKns1eqWR1sKPeg0NdHA5nog6
 SQyi5gPmDyDG1C9h1cq3LEghD9neV0yJ.sFILIifGsLVIrvDAuVhk61PNArv7J26fOQJl166IaUo
 lW7waRJlvMEnQ0ZdcJByL683UlNSLltQ72bIaxs3wPg4iywosj1o9yXd7Ve1j1_OA7o0mo.fV3AH
 jU_4JnOOLMIbwIEzr3Qg01wC8sUZkLl9GL27Ef5bYAcf5PRtu5tD4cTRRamLBjPIjAl8iK0pAfKu
 NbJMB93KLenZRQ5KYqqEH2KBEEBLG5zsT6regLwEFrs81wrYm_WcohyQf9hJmRJv82DL6SNzXbCi
 E9yGmtHUIKvfGwbQJezNDdXwnoiYE5mnpkFJEqlBMjuiW61rAFRePEJqgVK0SZs2UzZlUDrubnge
 ._sszneJ7fX2LIf42Mx9mOG7BaLPUPelWDcyZFO3RkicjEtU092GENvuXqH2kUmhcCjxZRudSaKs
 6DidXiKiR8tDe9ZIsGdJcW8ppLOM...vpipu3sL7SUkGlxAfQKF.wvstak8WnZV9MHBIfvgxqQI0
 WBYuEjB5C9IU_088XSD2tMGI2YUEHU3vetkXbewC6jvgjadaSu426Q4p9NGKi2_zxe6z7NegCAPV
 TEZ9HDGDXVNM1FnjUNNvGkf_ZAyxMattWPy3d0LBVTlM1D8hzR3wtiACeNtbAgkaMtTdAOtqVfhx
 qsZPZOeRuobdkp6rLtMe1.Ff.19IsqWMq4ekCGo78EvpfZYDNpo.Axw--
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: c0652755-41f1-40de-b129-bf55e3b14eed
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2026 12:03:28 +0000
Received: by hermes--production-ne1-6f6bdbdd7c-w9xxm (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID ad3319020c74423f6b69925ddd631e52; 
 Sat, 01 Aug 2026 12:03:23 +0000 (UTC)
Message-ID: <7e4719b8-7396-4daa-aa8e-4c4836951de9@netscape.net>
Date: Sat, 1 Aug 2026 08:03:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/hvmloader: implement Intel IGD extended VBT support
To: xen-devel@lists.xenproject.org
Cc: qemu-devel@nongnu.org, Jan Beulich <jbeulich@suse.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>
References: <20260801000354.16446-1-brchuckz.ref@aol.com>
 <20260801000354.16446-1-brchuckz@aol.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <20260801000354.16446-1-brchuckz@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.147; envelope-from=brchuckz@netscape.net;
 helo=sonic301-21.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 7/31/2026 8:03 PM, Chuck Zmudzinski wrote:
> Modern Intel IGD devices do not work well with the current
> implementation of support for the Intel IGD in hvmloader because
> it lacks support for an extended video bios table (VBT).
> 
> Code 43 errors in Windows guests and failure of the guest screen
> to light up are some of the problems that occur with the
> current implementation.
> 
> To address this problem, this patch implements support for
> Intel IGD devices with an extended VBT and OpRegion version 2
> and higher which is required for most modern Intel IGD devices.
> 
> This patch also depends on compatible support in the device
> model. If hvmloader detects the device model lacks such support,
> it will fall back to the currently implemented protocol for
> configuring the OpRegion to provide backward compatibiltiy for
> systems that lack a device model with support for an extended VBT.
> 
> Support for an extended VBT is implemented in the newly introduced
> function opregion_setup() which is implemented in the new file
> intel_opregion.c.
> 
> Major differences between this implementation and the current
> implemntation that only supports older devices without an
> extended VBT:
> 
> 1. The current implemntation reserves a constant number of
>    pages (3) in the E820 map for the OpRegion which is set by
>    the IGD_OPREGION_PAGES macro in the current implementation.
>    With OpRegion 2 and higher, the OpRegion can have an
>    extended VBT that must be provided to the guest with the
>    OpRegion. This means the size of the region is not fixed,
>    so in this new implementation the IGD_OPREGION_PAGES constant
>    is changed to a variable in e820.c, igd_opregion_e820_pages,
>    that is set to its proper value based on the the size of the
>    VBT. In this new implemntation, the size of the ACPI NVS region
>    reserved for the OpRegion in the E820 map is equal to the value
>    of the igd_opregion_e820_pages variable instead of being set
>    to the constant value determined by IGD_OPREGION_PAGES.
> 
> 2. The current implemntation provides the guest with access
>    to the unmodified OpRegion on the host via memory mapping
>    from the host to the guest. This is insufficient for
>    OpRegion 2 and higher because some devices will require
>    modifications to the OpRegion for proper operation in the
>    guest. So this new implementation provides hvmloader with a
>    copy of the host's OpRegion that hvmloader can modify as
>    needed for proper operation. Mapping the OpRegion from the
>    host to the guest is only used temporarily during setup of
>    the OpRegion by hvmloader and once hvmloader has a copy of
>    the OpRegion and the extended VBT, the device model removes
>    the host mapping and hvmloader configures the guest to use
>    the guest's possibly modified copy of the OpRegion instead.
> 
> 3. The current implementation lacks useful debugging information
>    for the more recent devices. This new implementation provides
>    useful debugging output from hvmloader, such as the detected
>    host OpRegion version and address, the values for rvda, rvds,
>    and the guest OpRegion address when the guest_loglvl is set
>    to all/all.
> 
> Link: https://lore.kernel.org/kvm/20211012124855.52463-1-colin.xu@gmail.com/
> Link: https://lore.kernel.org/kvm/20210325170953.24549-1-fred.gao@intel.com/
> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
> ---
> Later versions of this patch will provide a link to the compatible patch
> for extended VBT support in the device model which will be posted to
> the qemu-devel and xen-devel mailing lists and Cc'd to the appropriate
> maintainers and reviewers soon.

I forgot to mention that there is an undocumented setting that works in
the xl.cfg(5) domain configuration file, firmware_override, that makes it
possible to use a patched version of hvmloader alongside an installation
of unpatched upstream Xen or a version of Xen packaged by a distro. So
one can download the source for one's installed version of Xen, apply this
patch and build just hvmloader and then install the patched version of
hvmloader with a different filename, such as hvmloader-igd-testing, into
the same directory where hvmloader is installed (usually something like
/usr/libexec/xen/boot) and then one can configure a guest to use the patched
version of hvmloader with one's installed version of Xen by adding a line
like this to the domain xl.cfg file:

firmware_override = 'hvmloader-igd-testing'

> 
> The compatible patch for the device model is part of a larger patchset
> that fixes many of the problems that currently affect the feature of
> Intel IGD passthrough to Xen HVM guests. This patch should be considered
> as a companion patch to that patchset for the device model. Do not try
> to test this patch with a real Intel IGD device without also applying
> the patchset for the device model because without those patches, the
> guest will most likely fail to start if an Intel IGD is passed through
> to the guest.
> 
> There are different requirements to support OpRegion version 2.0
> and OpRegion version 2.1+, with support for OpRegion 2 the more
> difficult case because it always requires modifications to the OpRegion
> for proper operation in the guest. For some details about OpRegion
> 2 and higher and the extended VBT, see the links in the commit message.
> 

