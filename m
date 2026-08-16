Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D048C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 16:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvdsw-0004xO-RA; Sun, 16 Aug 2026 12:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wvdsv-0004wy-5F
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 12:38:57 -0400
Received: from sonic311-24.consmr.mail.gq1.yahoo.com ([98.137.65.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wvdst-0006qy-4K
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786898331; bh=C0sJATbIEzCXBKFkvm1mIxHiLUKgF5Nx8A6WCamwvOU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=geP8y+qxiQc/Q0qWRmkbHjDVdDzIrnSKmPMfpuycf1VUquHTRmK/6MssLQL2aGjYE/wBwApclK+/y3J53Ff6woow3lLy4KWEsgMUuBudjiGfvzXwLhzsD+FMd8gbWWfLwhe2boXLFAZPYzRIOX4MwBhuIhU6uks7dGR5sqFc3fdhu2yZV4DLvbJuduflqk5Kl+dY6HWPk3NbPp/WVMmtyWpLaM+GSnf4enYPs8Rm/46/D84uwNRgUr0QQrnj/akQ1D3fo7U/TnJ4WRyovX+rigdbZ6YjK51PLtIquGo7SfSqbIxrqzeJ4stppps0ZJYBjdPNzPxNZKUTJDOPoQMIOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786898331; bh=LigkW4p4Zw3dbQlrMjr+JkyCTSTy9CFpcs3vR5j07M4=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=DJq1pGZe3+7u9AMsvWnZs69Gkrtj5nD4882/rdNnI22PsIb89xUFwOaYAKrfcSgeG4MYCp+WIAF/bIv+naxE1rKiDYzCGXHe51ciSjtacB5gt2KmwZhveAJRZ2IDT6heJr70DsXHxRbKbxiwOVs4SweO2AfLdAPNoW+c/cmIa7IBI+FDLcskRqC24RGekiStNLgVE3KbS23J0LDYBf+6w7IPrnN6IzgN7VQ9a+dKumZQvDudpsvB22KfOSXl79SjdGuU163/BkK4D9DgS3QyFqeP0QkMDOrnTc7Vt/8BjKetBSLH/vc0cW9B4sH9Do7e/XJS5J9/rMbpkezRYcKo9g==
X-YMail-OSG: mi1Fjr4VM1mKXdfSGDTmPLedmUrd3u9GsxEXg7sL4hkdA0ZlPYLC0qSwancAxiq
 8dRCAOqzD7xesGAddhnGczRWcjdinVI0k3oW5ZQyJu_m.FvQUVsVnfKHgadsx77tWQuQVIxkWsdu
 6p94pMZp.Hvx07jZ6CSO__VgAaACRRMDa1AYy5fnMsDoYV7nrN_B6DZPbKAWrqFBwahjPMLY.T59
 cqVTk4gMEzDiH.Z2HMQIOfDnsTph_GnMS1UZgJB2yi.MJa_XIPnPZemRcbWEJX6VkE800vZ4RXaS
 078qFWZj8A_xSYjdlfn2MeM7u1HnaYrEREwfHYdC8DlX4GBF3rnCXA8TLtELu6mY9hOJ0Q01rO0z
 AJKaqDlAWckp7Z7TkB4_0eBbRsGblisdt0kpOjXKzyWl0G1c71bnlSM5Pv5SI33dYqJCiaC10moq
 B.oGAAhyyV6s9XFaWYKA4sipGiOp0DTimcP5TVyURxPzVvvCbbxqQYDQVwAVbk7Wws0CfOGdgSCv
 odb5NbWUwvvOnBbXylUjtcloESzMHl3Wy4yTwGE860GBkFWCsd4gr1tn3t3Y6TqgNOxh6cvhXxrG
 2.YW1z9.uT5I_mEhKd7EfSZMhSLmPOiC2xPyuecRLYZkIcqBsYO2TRs.gZus3EMOQmFOcF0VZCIG
 eo1DLEVaKmHUrpk62Ys0UvPeqcWSs75UKIwkmQF0V6Oev5hABWu3KmPk4VjfTOiPYk8i5OJ1X3NI
 SlI3r4X.8Cp.D_k2DAbOR_ZSVubXLVOXfRtWXTiyzrpkbl0xBoYPDABfmfHHTd.TTKTXWtHR7e6C
 tvh1mrzWBywe3c1kEXpgkcNDPfltkwKsfQ6CJxJwTcIvEoXap5iHvtwh7RH9OEUoQrG4Ca3y6WOz
 INtwJdvbIo4VQ.NhbWHXdEumpsn.6wdKBnwU4YPuQnI7sk_mqChAjgoWNZa3k.aUYuDPXDzyTPCh
 9njwCn7qJhsPYgLE3ajeja5guu2YSTIqUerRqC.rAfFcdX8BbVxCgz.GBo_4IyG8Rl7RBRLripGX
 _j25y5h03jf2F0qLRan1qXChl33zVqT8mu_Thuic9VN1tR9wx7OuMe8YcxkAO.YK9qLqT5iNyDYg
 XkFA8ojOsN6OOXa10SwawfTftaX3yQqPqzbgZJ7UFDRnup8zScG0vlkPQgzQAy72PB1k2Ok9wZZe
 GeCUWCahlW2G0SzvHL3SG17geuJbfrGpJmxpkquqN0d5ca2kGb_Cuz4deaKpwhLN4H.HYiqKRrvt
 CjSIhWZEPRZ7ZTHzIgz33hsDMjdzsu1vnqIshXkYv.xaNR73mzSSUiavZAuK36sk1g7wb25Xh1Q2
 CK8kxYnIo3UAxrqeY_9NUGFqwwbvW8hoNQBqe1wAvUVdpKimInzAiwJQHdy04dfNLexsuSBe3.3X
 o9qv8Z5Kok_FE4OeFIowMxWNOPY199iDi7upMEvCVDnNPL7PjGTH6dwwZVZeheMPa.0hUyl7FBzt
 yHP2WnWmmE8pE8o8ObmdutkqeXWxdyl4_MZXjrk5RFWkwHXjnmFxaxnQUnkGT8YzAciI.WIXTJg5
 1Y.eLbslrwJgnYMV9jyX7E2inpR4LVZIqfeBvSTh7tf75KRsPcZKaDPHcF4m9n.6mamAPtymigDz
 Fzi3q1cNFXnfSnexrRMogce6tr8H9tVa2lr_CM6.axTfsohbJl.MbvstlH_msya4HiwgJvjhZL58
 kTFrlKuVBy86Wt9XHtaktGGYWapWRDa7CHjH8d_gjr.FhZ9C3mJwLA93rNkow5_fDegzoa3w70Um
 _8j4Kpnm9iWHICOiTr0Y5aCr41BXy8Afdg_8Hgnnop1wBX7rtI.BYiU4ULpW95oZcwVGxO4LXrYO
 bzq_FUKviEPtmlAOeySnBQ19mLzO3qWrypLAc4jnPdpISCzVtFbA3lcDPUuXOfgjJszh5m.0Kp2W
 SX8_MKcf_Lq28ge6mZbCecrePap9nJEpgDDj86.V8jR76mGqDqy.TI_ACpr60BWIu8l5BUUT4kCF
 mzwuvz6MorPmHogNz9_deBRqAq_J5Mbx5k99W2JpDfmGaXTDKu__pOnUHgAJ_UgjOh0cu6ZF4q6F
 MOEnFyIto7jLW3.lmLo9DZQnIHX_YqHNKBlPF2vtIBNj2IddNeOW5kPBHMylUWzG5RFceHfZhzpe
 elm0NqsT7GzOKQuQjIar1VsLMzrFgV3uaRllqCCXfkPcTb63ln2ZfxT98znlSQZ9iDRdnPSaQTzr
 d_jlfj4Ls0OUTFi2oq5lx0YOMUW0jHOkqaqlw.WJO
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 28290891-21d0-464f-b5ba-54585c5604a9
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sun, 16 Aug 2026 16:38:51 +0000
Received: by hermes--production-ne1-6dbcb84f44-59qmb (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID a7c0d4753902ab36fdd683af5fb0813d; 
 Sun, 16 Aug 2026 16:38:48 +0000 (UTC)
Message-ID: <a98b7e5f-240b-4642-b488-fac69846b3f8@aol.com>
Date: Sun, 16 Aug 2026 12:38:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@vates.tech>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@aol.com>
In-Reply-To: <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.65.205; envelope-from=brchuckz@aol.com;
 helo=sonic311-24.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On 8/14/2026 3:35 AM, Jan Beulich wrote:
> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>> -- snip --
>>>> +    /*
>>>> +     * Read the value the device model is initialized with.
>>>> +     * If the device model supports OpRegion 2, it will
>>>> +     * return the host IGD OpRegion address. If not, it
>>>> +     * will return 0. If the device model does not support
>>>> +     * OpRegion 2, the device model expects us to give it
>>>> +     * the address to which it will map the OpRegion in the
>>>> +     * guest and then expects us to do nothing more to setup
>>>> +     * the OpRegion, so that is all we will do in that case.
>>>> +     */
>>>
>>> Hmm, exposing the host opregion to a guest certainly feels like an issue.
>> 
>> Well, that is how it is now. I am only retaining it to maintain backward
>> compatiblily with DM versions that do not support the extended VBT and
>> OpRegion 2+. My previous comment about backward compatibilty and DM
>> compatibility also applies here. If we don't worry about that, we can do
>> away with any cases where we are permanently mapping the host opregion to
>> the guest and implement this new approach of always exposing a copy of
>> the OpRegion and VBT to the guest instead.
> 
> How does "permanently mapping" matter? hvmloader runs inside the guest, so
> exposure just to copy the data isn't any better in terms of this being a
> layering violation. The more correct thing to do might be for the DM to
> put in place a copy before the guest (i.e. hvmloader) even gains control.
> (How in turn the DM would learn of the contents of the opregion is a
> separate question then.)

Hi Jan,

I am working on v3 of this patch and I want v3 to address this problem of a
"layering violation" that you mentioned here, but I do not understand exactly
what you mean. Do you mean to say that the current code we have in place and
have had in place for over the past 10 years [1] in the Qemu DM that traps and
maps the OpRegion into the guest is a "layering violation?"

[1] https://xenbits.xen.org/gitweb/?p=qemu-xen.git;a=commitdiff;h=5cec8aa38cc
("xen, gfx passthrough: add opregion mapping")

>>>> +    /*
>>>> +     * Write rvda_host as 2 successive 32-bit values
>>>> +     * to communicate location of the VBT to the device
>>>> +     * model. If rvda_host is not 0, The device model
>>>> +     * unmaps the OpRegion and eventually maps the VBT
>>>> +     * after we also write the guest address where the
>>>> +     * VBT will be mapped.
>>>> +     *
>>>> +     * If we send rvda_host = 0 to the device model, it
>>>> +     * will assume we do not need OpRegion 2 support and
>>>> +     * it will not unmap the OpRegion.
>>>> +     */
>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>> +               (uint32_t)(rvda_host & 0xfffffffful));
>>>> +    unsigned long rvda_host_upper_32 = (uint64_t)rvda_host >> 32;
>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>> +               (uint32_t)rvda_host_upper_32);
>>>
>>> Why would you need to communicate a host property to the DM?
>> 
>> The DM cannot access the host rvda value because it is only accessible
>> from the host kernel, and the DM is only a user-space process on the host.
> 
> I don't follow this: Anything the guest can access should also be accessible
> by its DM.

I also don't follow your comment here so permit me to comment and ask some
questions for clarification.

I was thinking it is enough for the domain the DM is running in to have
access to the resource for it to be legitimate for the DM to map the resource
into the guest. So I also think that whether or not the DM itself can access
the resource is irrelevant to the question. But you seem to be saying, no,
that is not enough, the DM itself should be able to access the resource
before it can be allowed to map the resource to its guest. Is that what you
are saying?

Perhaps your comment here is related to the concept of a "layering violation"
mentioned above. Are you saying it is a layering violation for the DM to
map an MMIO resource to its guest unless it actually has access to that
resource? If so, what kind of access to those device resources should the
DM have? Read access? Read/Write access?

If the specs only say the DM "should" have access to the resources it maps
into its guest, then I would think it would not be a layering violation.
But if the specs say the DM "must" have access before it asks the hypervisor
to map the resource to the guest, then I would admit that yes, we have a
layering violation because the DM is mapping the OpRegion to the guest
even though it does not have access to the OpRegion.

So, where are the specs for what the DM can and cannot do? Are they publicly
available, or are they proprietary or only available to members of the Linux
Foundation and/or the Xen Project? If the specs are publicly available, then
if possible, please show me the specific place in the specs where the Qemu DM
is violating the specs when it maps the OpRegion to its guest.

Thanks,

Chuck

