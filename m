Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C69CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 04:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS5nL-0002fl-Oc; Wed, 27 May 2026 00:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wS5nI-0002f1-DX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 00:23:01 -0400
Received: from ms-2003f-snip4-1.eps.apple.com ([57.103.72.142]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michaeljclark@mac.com>)
 id 1wS5nG-0000B3-G2
 for qemu-devel@nongnu.org; Wed, 27 May 2026 00:23:00 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPS id
 1BCAE180012C
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:22:52 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhKAkMOUhxBCE4dXwJLVxQEFVoOXwpXHFMbXwxFAHIdWBsdDlgGEhZdRV4MVEVRH1RYQQ4KWhIYXBRcUFgeRhJWDV0JGQZBXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVl8RWlZQAlpLXxldRQ9aUQoFEQ0bA0AGXwMSFEwGCwJGUxFfQR4IAl8CFQkdVQsOClQwVBlQQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
 t=1779855775; x=1782447775; bh=soQUqDB6EMAoeTOqu0SOvlCcw2MYQzPUU18P4gPt89w=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:x-icloud-hme;
 b=mulLfLB/TXjHHEBkkbfHgWJywQu43RZH/OXWWNXipihAlWbGsAmrxkDhoTMY2eJ0KXbEtBO5sb0zcswxTDqj5GcalEn0Se0JO2jADKa7enq8svrXmWeQQGzcuzeCzxRQiTcepE0dKQNQsdICUKCr7uMkcZ0zbaA3k0H6o/T7njXm6kwtW+dkkUV+MTyd7ZyxhfB8Lci0WWAxaJ5u2q4H6pzB9w08b+Y+/+Nvl7JC/brktrecy8YTREfkfYRtGpkmzSO17H9G3yYUtJXf9hTblq66X4agEH7j5tNy1TmW/AvTKVRCEyL8pcvFOU5pMNG5YNevYIwlrAEtIZXaNVWU5g==
Received: from [192.168.1.3] (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-2 (Postfix) with ESMTPSA id
 CCC761800115
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 04:22:51 +0000 (UTC)
Message-ID: <7fa7a4c0-141b-45f5-aaf9-e540e0eff9af@mac.com>
Date: Wed, 27 May 2026 16:22:49 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GLYPH: TLB miss handlers, virtualization, and modes
From: Michael Clark <michaeljclark@mac.com>
To: qemu-devel <qemu-devel@nongnu.org>
References: <2143170d-8998-4812-9204-57febae9d755@mac.com>
 <4cab865f-f9aa-4add-8c1c-08a9048041d0@mac.com>
Content-Language: en-US
In-Reply-To: <4cab865f-f9aa-4add-8c1c-08a9048041d0@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA0MCBTYWx0ZWRfX2Ru1zMvBj3kt
 K4f9UT6yLz1pSUvCr78nQsA2PXKdl5Om7hsrAIgcrn5tKrg02IvzbyXPreoe7fvtJ57xoyLWsNV
 eIJ8hw8eUkiTLJbMLtiJUC1C0hGNKAcnkJ8DZUueB2UhK5yN086NUMHQh9xwSaASKzrrtaINCOI
 7BbJORyuKMTZGbyiv8S8cc6x9GOBZNO2Sr9dzfEWtuRbw81YIrqo0GJveCyuEaAKJUthocDrkoL
 SKHWIaLfQ7uDTg0AHAhBlQl2N7Wj5hQHLLArBXfquuFQLoiijJjUED8R8AZXjttMaWopuEsNpgY
 TKyYGvcG48MR1qIdstsp7K9lTdJmkIh77I2gn2GIAvaHX/zAstodSxkYlVtR0I=
X-Proofpoint-GUID: ywrnQBroPbLBmjkWB3s4HohLl-uzlgb1
X-Authority-Info-Out: v=2.4 cv=B+S0EetM c=1 sm=1 tr=0 ts=6a16719d
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=u0hES8UrWMkA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YJ9zdN9lAAAA:8 a=NEAV23lmAAAA:8
 a=M55iCpE8kyM7TKSI8u0A:9 a=QEXdDO2ut3YA:10 a=eqbXquKEjoujS2g1hgVW:22
X-Proofpoint-ORIG-GUID: ywrnQBroPbLBmjkWB3s4HohLl-uzlgb1
Received-SPF: pass client-ip=57.103.72.142; envelope-from=michaeljclark@mac.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On 5/18/26 17:18, Michael Clark wrote:
> rather lengthy update on a high-level architecture exploration:
> 
> - https://metaparadigm.com/~mclark/glyph.pdf
> 
> I have reached an inflection point with nested virtualization and SLAT.
> I believe I expose enough from an architectural perspective to support
> SLAT in this version of the architecture, theoretically, as we have a
> dominating machine capability for each virtual domain. it still needs
> testing in a full system architectural simulator. I think this version
> of the specification is worth a fine look, though. I just made a change
> to domain context switching for nested traps, keeping in mind SLAT plus
> TLB miss handlers for first level address translation.

received some feedback and made several more simplifications:

- page color caps are trimmed to the subset mapping to Intel PKRU.
- the array extension (image load store) has been commented out.
- domain capability trap routing has been further simplified.

curious on feedback for the domain capabilities privilege model.
it still needs to be tested in simulation. they should be amenable
to accelerated translation as they only need to be checked on
interrupts and access to privileged registers or instructions.
user-mode plus single supervisor would occupy two domain slots.
page table colors has a pretty direct mapping to Intel PKRU.

4K pages using the default scheme without TLB miss handlers should
be amenable to fast shadow paging on Intel X86. there are still lots
of missing details. VM and instruction fences are not yet defined.
of course we need to add the instructions. that will be done last:

- https://github.com/larkmjc/x86

