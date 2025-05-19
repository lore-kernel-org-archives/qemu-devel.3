Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DFCC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 07:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGvGr-0006Pw-Gf; Mon, 19 May 2025 03:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGvGi-0006Pe-HG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:50:41 -0400
Received: from mail-4319.protonmail.ch ([185.70.43.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edmund.raile@proton.me>)
 id 1uGvGe-0006tK-LD
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=rqcbsavazzakdeyxprnoqasgdq.protonmail; t=1747641033; x=1747900233;
 bh=mqhRosdkh7dT1sIOLfJP4ULlkCLzv6bGRPMvffRa92I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=Y5jfTYKMz4Vuvw/2skNxcipVyd3C8l0pi4AMZVxqvVo1MxIFa4PArZehMkhaGKNsf
 VrNDzXujAyR0iMpVoO81nfoOGE0ihiAj1EHWfJB/PL+hTQGRB5jMZq+THU0SB9XdCr
 QIYPdeBx7P6AowfQEEYdAj6YDSjgN07fHQRXCaVeWjsvL05/GETy2ItjWUOuZOuRdJ
 QSpC7b4QJomo66U9Ugwh2U5gcZQ4HWrIyaBjaF3GuJbAi+iPMN18EWs357V7119TzU
 DCzpq2UXG0Rll6day2MA9yqvWV9L2WEhWH2opKkyjB9sGqvJnIwjR4mAzx0XhY9fXY
 OVH2EYTrqRcGg==
Date: Mon, 19 May 2025 07:50:28 +0000
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
Subject: Re: [PATCH] vfio/igd: Respect x-igd-opregion=off in IGD quirk handling
Message-ID: <Ftpz4gV8B-EGJQv-DRgdYLeJKNwvotqbkYApK9qXCst9DaaIe2CmEC535Nr4T7qLOYThHLqGmN5a3I4ZFsPN5zgyW5PHA4o12XLlte7lIwk=@proton.me>
In-Reply-To: <d6ff843c-51a0-4e58-83a9-afef3a165b94@kaod.org>
References: <nlfoN7cj2SVJ6LQahdnb_xWG6orCIn4hxHq8JTND4cH2gXCVy9X0KKJkVZdNiG6YmFX-1Qkc_fW2tUwk5LkQcZaJz4Lwy5OpMtaVCK7Tq-E=@protonmail.com>
 <20250518171730.1ba5bc31.alex.williamson@redhat.com>
 <6TP1d19UA0waLH71Mea1s2U0yFtyKMpqqf6miU7O44BYZm04F4vOJ5c565O09PliXCbSNJJxuIm0zh2Re-gWa6jo08YraLuPOdebgp30n5M=@proton.me>
 <96ecbe23-c3b6-488f-99d6-7875e5b3ed4c@kaod.org>
 <E4Tw043i3BaGIoDJcv2goFAjtxMAUUdCctQUsQX7YX-lRIZBR8RgJuQ4twN-AQcGS0A5Q6fdjNPSKwMDW0qmZkx832IJjV4XnCZ8oaEmh6Q=@proton.me>
 <d6ff843c-51a0-4e58-83a9-afef3a165b94@kaod.org>
Feedback-ID: 45198251:user:proton
X-Pm-Message-ID: 7952dadc3d548ee199bcbef9a3162023f86f9c9e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.19; envelope-from=edmund.raile@proton.me;
 helo=mail-4319.protonmail.ch
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "edmund.raile" <edmund.raile@proton.me>
From:  "edmund.raile" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>On 5/19/25 08:59, edmund.raile wrote:
>>> Hello,
>>>
>>> On 5/19/25 02:01, edmund.raile wrote:
>>>>>> Restore SR-IOV Intel iGPU VF passthrough capability:
>>>>>> Check x-igd-opregion=3Doff parameter in vfio_pci_igd_config_quirk an=
d
>>>>>> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=3Doff is
>>>>>> respected despite subsequent attempt of automatic
>>>>>> IGD opregion detection.
>>>>>>
>>>>>> Fixes: 7be29f2f1a3f ("Merge tag 'pull-vfio-20250509' of https://gith=
ub.com/legoater/qemu into staging")
>>>>>
>>>>> Can you bisect to a specific commit from the merge?  The merge may be
>>>>> where the issue was introduced to mainline, but the merge commit itse=
lf
>>>>> is more than likely not the source of the issue.  Thanks,
>>>>>
>>>>> Alex
>>>>
>>>> I have to admit, I have no idea how to pluck apart
>>>> that merge pull using git.
>>>
>>> Please use git-bisect. The manual contains enough information to get
>>> you on the right track.
>>
>> I'm quite impressed that git bisect in main repo has the power
>> to bisect into commits on a branch of a fork repo
>
>I wouldn't used a fork repo to isolate the issue.
>
>vfio-10.1 is a dev branch. patches come and go.
>
>vfio-next contains candidates for upstream. The tree should be stable
>enough but patches are force pushed on this branch to keep it in sync
>with upstream.
>
>Please use the main QEMU repo instead.

That is what I did and did not expect to work.
The commit ID is from the main repo.

>
>> despite
>> being summarized into one commit on the main repo.
>> I did not think this was possible which is why I said I don't know
>> how to do this.
>>
>> c0273e77f2d7aab3312eb557b49332da528ff66b is the first bad commit
>>
>> So merging it into the main qemu repo changed the commit number
>> but it's the very commit I found; it adds the automatic IGD
>> opregion detection.
>>
>> Should I send in a patch v2 and correct the Fixes tag or can you do
>> this while committing?
>>
>> This would then be the correct tag:
>> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
>
>
>Please send a v2.

Will do that.

>Use ./scripts/get_maintainer.pl to get the email recipients.

I did that originally but included Stefan Hajnoczi
<stefanha@redhat.com> since he did the original merge pull.

>
>
>Thanks,
>
>C.

