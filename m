Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BA2C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsda-0005wi-3w; Tue, 11 Feb 2025 10:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1thsdX-0005wS-80
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:57:23 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1thsdU-0004SJ-Oa
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:57:22 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1thsdN-00000007A5c-2pk8; Tue, 11 Feb 2025 16:57:13 +0100
Message-ID: <e7e367b0-4299-4998-b981-ca58d385db02@maciej.szmigiero.name>
Date: Tue, 11 Feb 2025 16:57:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/33] vfio/migration: Add
 x-migration-load-config-after-iter VFIO property
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <11f12c43e098ac5e2466e456e8cf8936c54210dc.1738171076.git.maciej.szmigiero@oracle.com>
 <36beb97e-ab1e-41f4-b9d0-75238d5faaa9@redhat.com>
 <afcec18d-094f-49ea-a4f9-3b868b58e60a@maciej.szmigiero.name>
 <ab34a907-7e88-463e-9924-d8fdd771bfd8@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <ab34a907-7e88-463e-9924-d8fdd771bfd8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11.02.2025 16:00, Cédric Le Goater wrote:
> On 2/11/25 15:37, Maciej S. Szmigiero wrote:
>> On 10.02.2025 18:24, Cédric Le Goater wrote:
>>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> This property allows configuring whether to start the config load only
>>>> after all iterables were loaded.
>>>> Such interlocking is required for ARM64 due to this platform VFIO
>>>> dependency on interrupt controller being loaded first.
>>>>
>>>> The property defaults to AUTO, which means ON for ARM, OFF for other
>>>> platforms.>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c           | 25 +++++++++++++++++++++++++
>>>>   hw/vfio/pci.c                 |  3 +++
>>>>   include/hw/vfio/vfio-common.h |  1 +
>>>>   3 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index adfa752db527..d801c861d202 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -254,6 +254,31 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
>>>>       return ret;
>>>>   }
>>>> +static bool vfio_load_config_after_iter(VFIODevice *vbasedev)
>>>> +{
>>>> +    if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_ON) {
>>>> +        return true;
>>>> +    } else if (vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_OFF) {
>>>> +        return false;
>>>> +    }
>>>> +
>>>> +    assert(vbasedev->migration_load_config_after_iter == ON_OFF_AUTO_AUTO);
>>>> +
>>>> +    /*
>>>> +     * Starting the config load only after all iterables were loaded is required
>>>> +     * for ARM64 due to this platform VFIO dependency on interrupt controller
>>>> +     * being loaded first.
>>>> +     *
>>>> +     * See commit d329f5032e17 ("vfio: Move the saving of the config space to
>>>> +     * the right place in VFIO migration").
>>>> +     */
>>>> +#if defined(TARGET_ARM)
>>>> +    return true;
>>>> +#else
>>>> +    return false;
>>>> +#endif
>>>
>>> I would rather deactivate support on ARM and avoid workarounds.
>>>
>>> This can be done in routine vfio_multifd_transfer_supported() I believe,
>>> at the end of this series. A warning can be added to inform the user.
>>
>> The reason why this interlocking support (x-migration-load-config-after-iter)
>> was added because you said during the review of the previous version of
>> this patch set that "regarding ARM64, it would be unfortunate to deactivate
>> the feature since migration works correctly today [..] and this series should
>> improve also downtime":
>> https://lore.kernel.org/qemu-devel/59897119-25d7-4a8b-9616-f8ab54e03f65@redhat.com/
> 
> So much happened since ... my bad. I think this patch is not well
> placed in the series, it should be at the end.
> 
> The series should present first the feature in a perfect world
> and introduce at the end the toggles to handle the corner cases.
> It helps the reader to focus on the good side of the proposal
> and better understand the more unpleasant/ugly part.
> 
>> My point is that after spending time developing and testing that feature> (or "workaround") it would be a shame to throw it away (with all the benefits
>> it brings) and completely disable multifd VFIO device state transfer on ARM.
> 
> Well, if you take the approach described above, this patch would
> be proposed after merge as a fix/workaround for ARM or we would
> fix the ARM platform.

Looks like there should be no problems moving this x-migration-load-config-after-iter
feature to a separate patch near the end of the series - I will try
to do this.

>> Or am I misunderstanding you right now and you only mean here to make
>> x-migration-load-config-after-iter forcefully enabled on ARM?
> 
> If we only need this toggle for ARM, and this seems to be the case,
> let's take a more direct path and avoid a property.

The reason why we likely want a some kind of switch even on
a non-ARM platform is ability to test this functionality there.

Most VFIO setups are probably x86 so people working on this code
will benefit from easy ability to check if they haven't accidentally
broke this interlocking.

> I haven't read all your series and the comments yet.

I keep the series updated with received review comments and re-based
on top of the latest Fabiano's TLS session termination patches here:
https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio

The changes up to this point has been mostly limited to migration
core code but it would be nice to get review comments for the VFIO
parts soon too so I can post a complete new version.

> Thanks,
> 
> C.

Thanks,
Maciej


