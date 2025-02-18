Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A34C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIRH-00021e-0S; Tue, 18 Feb 2025 02:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkIRA-000214-7f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:54:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tkIR8-0006f2-1j
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739865272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rcIeEpoMi5rOG2baKSj5QWr5E8MuNQM/npSP1I9uegY=;
 b=MsQEBRaacOIYtaOeSz7XbZt2CJzrtmVHS4TWaJ5ou2fLvC4wmlTK5ldKwnTi6V7lCNDyzC
 DT2pTPNELGTvwP+Z7iQYFn4BCnBi8wZO7hxAer9kBWOLeZu/6OUPibHn2nbRgfGSzyMJrA
 BL6J4MCb0L/5apt2ESy/QlNjQIIP1i4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-P2ndDUBqNZyEOJWv1W_f1w-1; Tue, 18 Feb 2025 02:54:31 -0500
X-MC-Unique: P2ndDUBqNZyEOJWv1W_f1w-1
X-Mimecast-MFC-AGG-ID: P2ndDUBqNZyEOJWv1W_f1w_1739865270
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f39352f1dso918118f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 23:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739865270; x=1740470070;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcIeEpoMi5rOG2baKSj5QWr5E8MuNQM/npSP1I9uegY=;
 b=Aa1r26QocshUHgkl6zv1eXl445fgMVoPGfWMmXvww6WWkKjSllRgNAGfZqCycMhLom
 csqtz4xRbTpggtECY3NCcPZ9Ay3wSX052WsFAb7pZSh9faqFD40Gka0NcwdebtwfLNQ5
 pHfoCgNB+It4/rgGyKWm2VH60MAEzBNFXwO2JSbUKP9gludLL5twvMZ4f9VfRXTL01EY
 ztsTg/r+6gtk5EXcYM/lsaiOg7MF1VFdlz8T90j0Aw7HxKedkH2M9/rVIBTRWTJ0mqkc
 AxGyQDyZoRzHwhc2or1XhevAgOt3rh0/DIM08V4oZaNfwjwuPfCLe0evY76cKUWGR0wc
 ASzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVekquWUNdbnDCWDL/i5s3SsW23cVq0XMStlLKCO+8y6tb9VVBLUpQu8YM7JToLLAeckaulErmOkF0o@nongnu.org
X-Gm-Message-State: AOJu0YzXhBU1iiGWHEY+rSpAjXpoYMttubTJAYyn2hK7/VyBhb9Iysk/
 H/SDUwZPMxsePqRRc+t17JxIl2/ZsWXaIz/fyd9K+urfAumH3CS3xGWO1T/vDaFAATPB+DoMGdD
 NX6330nu1tAeH3R81cBXuWz+t6gCzX0hwLfvTEho9d6Lv1Ne6ZSlB
X-Gm-Gg: ASbGncsHuvK/UG8M8a1Zp2Rb02aefltd/7lm5NoljbIKwQSjXadtvxW+/zet8KG307s
 VQm8YaVJTHBqPdBPEfZ56qZNkrXGS3tfoBiCCsWW68sS6zh9Gup1P517gOWcDvKAFBAywMMhF3z
 pIvSsqaisKaFnOeTwrTuhdGWZF6wLUGuFZIS/z0gAgcI3GgBSHt0qU2oh7rHwOj4FY8p52zMm1b
 IbwJS9OCBeh5ZKr8vXcOHi1NTkYmBkQ+ve5jBzsaxfil3lTeXrv2J0LQXDm98k5a4cbxUUncETS
 rP5h2FH15rfh6PZrzR0LBR5k7XME+1beATlftbPq
X-Received: by 2002:a05:6000:2c8:b0:38c:5bfa:a93d with SMTP id
 ffacd0b85a97d-38f33f11877mr11626959f8f.10.1739865269867; 
 Mon, 17 Feb 2025 23:54:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh0JIMR5tWdMTVYcL5R5xSdmC9XEvmrRfPItxsJGOensgj6yDpGVyrnrk/J+7q66KR0n/u+g==
X-Received: by 2002:a05:6000:2c8:b0:38c:5bfa:a93d with SMTP id
 ffacd0b85a97d-38f33f11877mr11626929f8f.10.1739865269391; 
 Mon, 17 Feb 2025 23:54:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:38c8:6df5:c9ca:a366?
 ([2a01:e0a:165:d60:38c8:6df5:c9ca:a366])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f2591570esm14445407f8f.59.2025.02.17.23.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 23:54:28 -0800 (PST)
Message-ID: <9f8b347f-64ab-44b9-a5ca-053ae239a484@redhat.com>
Date: Tue, 18 Feb 2025 08:54:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <1fcf182307e8e1f67a3c226e62d26cad3a2f60d0.1738171076.git.maciej.szmigiero@oracle.com>
 <6c337aec-d004-4ede-a86b-0c934b275fa9@redhat.com>
 <1ab2d96f-f37d-466e-83db-0e3d39581bc7@maciej.szmigiero.name>
 <c614346e-a625-427e-a6a7-03a885e7fce4@redhat.com>
 <319789d3-703a-4d4b-8d5a-f2a229666fad@maciej.szmigiero.name>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <319789d3-703a-4d4b-8d5a-f2a229666fad@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/17/25 23:13, Maciej S. Szmigiero wrote:
> On 17.02.2025 10:38, Cédric Le Goater wrote:
>> On 2/14/25 21:55, Maciej S. Szmigiero wrote:
>>> On 12.02.2025 11:55, Cédric Le Goater wrote:
>>>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>
>>>>> Add support for VFIOMultifd data structure that will contain most of the
>>>>> receive-side data together with its init/cleanup methods.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>> ---
>>>>>   hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
>>>>>   include/hw/vfio/vfio-common.h |  5 ++++
>>>>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>> index 3211041939c6..bcdf204d5cf4 100644
>>>>> --- a/hw/vfio/migration.c
>>>>> +++ b/hw/vfio/migration.c
>>>>> @@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
>>>>>       size_t len;
>>>>>   } VFIOStateBuffer;
>>>>> +typedef struct VFIOMultifd {
>>>>> +} VFIOMultifd;
>>>>> +
>>>>>   static void vfio_state_buffer_clear(gpointer data)
>>>>>   {
>>>>>       VFIOStateBuffer *lb = data;
>>>>> @@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>>>>       return qemu_file_get_error(f);
>>>>>   }
>>>>> +static VFIOMultifd *vfio_multifd_new(void)
>>>>> +{
>>>>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>>>>> +
>>>>> +    return multifd;
>>>>> +}
>>>>> +
>>>>> +static void vfio_multifd_free(VFIOMultifd *multifd)
>>>>> +{
>>>>> +    g_free(multifd);
>>>>> +}
>>>>> +
>>>>>   static void vfio_migration_cleanup(VFIODevice *vbasedev)
>>>>>   {
>>>>>       VFIOMigration *migration = vbasedev->migration;
>>>>> @@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>>>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>>   {
>>>>>       VFIODevice *vbasedev = opaque;
>>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * Make a copy of this setting at the start in case it is changed
>>>>> +     * mid-migration.
>>>>> +     */
>>>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>>>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>>>>
>>>> Attribute "migration->multifd_transfer" is not necessary. It can be
>>>> replaced by a small inline helper testing pointer migration->multifd
>>>> and this routine can use a local variable instead.
>>>
>>> It's necessary for the send side since it does not need/allocate VFIOMultifd
>>> at migration->multifd, so this (receive) side can use it for commonality too.
>>
>> Hmm, we can allocate migration->multifd on the send side too, even
>> if the attributes are unused and it is up to vfio_multifd_free() to
>> make the difference between the send/recv side.
> 
> Allocating an unnecessary VFIOMultifd structure that has 12 members,
> some of them complex like QemuThread, QemuCond or QemuMutex, just
> to avoid having one extra bool variable (migration_multifd_transfer or
> whatever it ends being named) seem like a poor trade-off for me.
> 
>>
>> Something that is bothering me is the lack of introspection tools
>> and statistics. What could be possibly added under VFIOMultifd and
>> VfioStats ?
> 
> There's already VFIO bytes transferred counter and also a
> multifd bytes transferred counter.
> 
> There are quite a few trace events (both existing and newly added
> by this patch).
> 
> While even more statistics and traces may help with tuning/debugging
> in some cases that's something easily added in the future.
> 
>>>> I don't think the '_transfer' suffix adds much to the understanding.
>>>
>>> The migration->multifd was already taken by VFIOMultifd struct, but
>>> it could use other name (migration->multifd_switch? migration->multifd_on?).
>>
>> yeah. Let's try to get rid of it first.
>>
>>>>> +    } else {
>>>>> +        migration->multifd_transfer =
>>>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>>>> +    }
>>>>> +
>>>>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>>>>> +        error_setg(errp,
>>>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>>>> +                   vbasedev->name);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>
>>>> The above checks are also introduced in vfio_save_setup(). Please
>>>> implement a common routine vfio_multifd_is_enabled() or some other
>>>> name.
>>>
>>> Done (as common vfio_multifd_transfer_setup()).
>>
>> vfio_multifd_is_enabled() please, returning a bool.
> 
> Functions named *_is_something() normally just check some conditions
> and return a computed value without having any side effects.
> 
> Here, vfio_multifd_transfer_setup() also sets migration->multifd_transfer
> appropriately (or could migration->multifd) - that's common code for
> save and load.
> 
> I guess you meant to move something else rather than this block
> of code into vfio_multifd_is_enabled() - see my answer below.
> 
>>>>>       vfio_migration_cleanup(vbasedev);
>>>>>       trace_vfio_load_cleanup(vbasedev->name);
>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>> index 153d03745dc7..c0c9c0b1b263 100644
>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>> @@ -61,6 +61,8 @@ typedef struct VFIORegion {
>>>>>       uint8_t nr; /* cache the region number for debug */
>>>>>   } VFIORegion;
>>>>> +typedef struct VFIOMultifd VFIOMultifd;
>>>>> +
>>>>>   typedef struct VFIOMigration {
>>>>>       struct VFIODevice *vbasedev;
>>>>>       VMChangeStateEntry *vm_state;
>>>>> @@ -72,6 +74,8 @@ typedef struct VFIOMigration {
>>>>>       uint64_t mig_flags;
>>>>>       uint64_t precopy_init_size;
>>>>>       uint64_t precopy_dirty_size;
>>>>> +    bool multifd_transfer;
>>>>> +    VFIOMultifd *multifd;
>>>>>       bool initial_data_sent;
>>>>>       bool event_save_iterate_started;
>>>>> @@ -133,6 +137,7 @@ typedef struct VFIODevice {
>>>>>       bool no_mmap;
>>>>>       bool ram_block_discard_allowed;
>>>>>       OnOffAuto enable_migration;
>>>>> +    OnOffAuto migration_multifd_transfer;
>>>>
>>>> This property should be added at the end of the series, with documentation,
>>>> and used in the vfio_multifd_some_name() routine I mentioned above.
>>>>
>>>
>>> The property behind this variable *is* in fact introduced at the end of the series -
>>> in a commit called "vfio/migration: Add x-migration-multifd-transfer VFIO property"
>>> after which there are only commits adding the related compat entry and a VFIO
>>> developer doc update.
>>>
>>> The variable itself needs to be introduced earlier since various newly
>>> introduced code blocks depend on its value to only get activated when multifd
>>> transfer is enabled.
>>
>> Not if you introduce a vfio_multifd_is_enabled() routine hiding
>> the details. In that case, the property and attribute can be added
>> at the end of the series and you don't need to add the attribute
>> earlier.
> 
> The part above that you wanted to be moved into vfio_multifd_is_enabled()
> is one-time check for load or save setup time.
> 
> That's *not* the switch to be tested by other parts of the code
> during the migration process to determine whether multifd transfer
> is in use.
> 
> If you want vfio_multifd_is_enabled() to be that switch that's tested by
> other parts of the VFIO migration code then it will finally consist of
> just a single line of code:
> "return migration->multifd_transfer" (or "return migration->multifd").
> 
> Then indeed the variable could be introduced with the property than
> controls it, but a dummy vfio_multifd_is_enabled() will need to be
> introduced earlier as "return false" to not break the build.


Sorry but I have switched to another series now, the one for live update,
and I will recheck your v5 proposal.


Thanks,

C.



