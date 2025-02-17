Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40995C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 22:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk9Md-0000nZ-0D; Mon, 17 Feb 2025 17:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9Mb-0000n1-95
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:13:17 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9MZ-0003ng-3o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 17:13:16 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tk9MU-00000007PKK-2nR2; Mon, 17 Feb 2025 23:13:10 +0100
Message-ID: <319789d3-703a-4d4b-8d5a-f2a229666fad@maciej.szmigiero.name>
Date: Mon, 17 Feb 2025 23:13:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/33] vfio/migration: Multifd device state transfer
 support - receive init/cleanup
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxhgUJD0w7
 wQAKCRCEf143kM4JdwHlD/9Ef793d6Q3WkcapGZLg1hrUg+S3d1brtJSKP6B8Ny0tt/6kjc2
 M8q4v0pY6rA/tksIbBw6ZVZNCoce0w3/sy358jcDldh/eYotwUCHQzXl2IZwRT2SbmEoJn9J
 nAOnjMCpMFRyBC1yiWzOR3XonLFNB+kWfTK3fwzKWCmpcUkI5ANrmNiDFPcsn+TzfeMV/CzT
 FMsqVmr+TCWl29QB3U0eFZP8Y01UiowugS0jW/B/zWYbWo2FvoOqGLRUWgQ20NBXHlV5m0qa
 wI2Isrbos1kXSl2TDovT0Ppt+66RhV36SGA2qzLs0B9LO7/xqF4/xwmudkpabOoH5g3T20aH
 xlB0WuTJ7FyxZGnO6NL9QTxx3t86FfkKVfTksKP0FRKujsOxGQ1JpqdazyO6k7yMFfcnxwAb
 MyLU6ZepXf/6LvcFFe0oXC+ZNqj7kT6+hoTkZJcxynlcxSRzRSpnS41MRHJbyQM7kjpuVdyQ
 BWPdBnW0bYamlsW00w5XaR+fvNr4fV0vcqB991lxD4ayBbYPz11tnjlOwqnawH1ctCy5rdBY
 eTC6olpkmyUhrrIpTgEuxNU4GvnBK9oEEtNPC/x58AOxQuf1FhqbHYjz8D2Pyhso8TwS7NTa
 Z8b8o0vfsuqd3GPJKMiEhLEgu/io2KtLG10ynfh0vDBDQ7bwKoVlqC3It87AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZ7BxrgUJ
 D0w6ggAKCRCEf143kM4Jd55ED/9M47pnUYDVoaa1Xu4dVHw2h0XhBS/svPqb80YtjcBVgRp0
 PxLkI6afwteLsjpDgr4QbjoF868ctjqs6p/M7+VkFJNSa4hPmCayU310zEawO4EYm+jPRUIJ
 i87pEmygoN4ZnXvOYA9lkkbbaJkYB+8rDFSYeeSjuez0qmISbzkRVBwhGXQG5s5Oyij2eJ7f
 OvtjExsYkLP3NqmsODWj9aXqWGYsHPa7NpcLvHtkhtc5+SjRRLzh/NWJUtgFkqNPfhGMNwE8
 IsgCYA1B0Wam1zwvVgn6yRcwaCycr/SxHZAR4zZQNGyV1CA+Ph3cMiL8s49RluhiAiDqbJDx
 voSNR7+hz6CXrAuFnUljMMWiSSeWDF+qSKVmUJIFHWW4s9RQofkF8/Bd6BZxIWQYxMKZm4S7
 dKo+5COEVOhSyYthhxNMCWDxLDuPoiGUbWBu/+8dXBusBV5fgcZ2SeQYnIvBzMj8NJ2vDU2D
 m/ajx6lQA/hW0zLYAew2v6WnHFnOXUlI3hv9LusUtj3XtLV2mf1FHvfYlrlI9WQsLiOE5nFN
 IsqJLm0TmM0i8WDnWovQHM8D0IzI/eUc4Ktbp0fVwWThP1ehdPEUKGCZflck5gvuU8yqE55r
 VrUwC3ocRUs4wXdUGZp67sExrfnb8QC2iXhYb+TpB8g7otkqYjL/nL8cQ8hdmg==
In-Reply-To: <c614346e-a625-427e-a6a7-03a885e7fce4@redhat.com>
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

On 17.02.2025 10:38, Cédric Le Goater wrote:
> On 2/14/25 21:55, Maciej S. Szmigiero wrote:
>> On 12.02.2025 11:55, Cédric Le Goater wrote:
>>> On 1/30/25 11:08, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Add support for VFIOMultifd data structure that will contain most of the
>>>> receive-side data together with its init/cleanup methods.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>   hw/vfio/migration.c           | 52 +++++++++++++++++++++++++++++++++--
>>>>   include/hw/vfio/vfio-common.h |  5 ++++
>>>>   2 files changed, 55 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 3211041939c6..bcdf204d5cf4 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -300,6 +300,9 @@ typedef struct VFIOStateBuffer {
>>>>       size_t len;
>>>>   } VFIOStateBuffer;
>>>> +typedef struct VFIOMultifd {
>>>> +} VFIOMultifd;
>>>> +
>>>>   static void vfio_state_buffer_clear(gpointer data)
>>>>   {
>>>>       VFIOStateBuffer *lb = data;
>>>> @@ -398,6 +401,18 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
>>>>       return qemu_file_get_error(f);
>>>>   }
>>>> +static VFIOMultifd *vfio_multifd_new(void)
>>>> +{
>>>> +    VFIOMultifd *multifd = g_new(VFIOMultifd, 1);
>>>> +
>>>> +    return multifd;
>>>> +}
>>>> +
>>>> +static void vfio_multifd_free(VFIOMultifd *multifd)
>>>> +{
>>>> +    g_free(multifd);
>>>> +}
>>>> +
>>>>   static void vfio_migration_cleanup(VFIODevice *vbasedev)
>>>>   {
>>>>       VFIOMigration *migration = vbasedev->migration;
>>>> @@ -785,14 +800,47 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
>>>>   static int vfio_load_setup(QEMUFile *f, void *opaque, Error **errp)
>>>>   {
>>>>       VFIODevice *vbasedev = opaque;
>>>> +    VFIOMigration *migration = vbasedev->migration;
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * Make a copy of this setting at the start in case it is changed
>>>> +     * mid-migration.
>>>> +     */
>>>> +    if (vbasedev->migration_multifd_transfer == ON_OFF_AUTO_AUTO) {
>>>> +        migration->multifd_transfer = vfio_multifd_transfer_supported();
>>>
>>> Attribute "migration->multifd_transfer" is not necessary. It can be
>>> replaced by a small inline helper testing pointer migration->multifd
>>> and this routine can use a local variable instead.
>>
>> It's necessary for the send side since it does not need/allocate VFIOMultifd
>> at migration->multifd, so this (receive) side can use it for commonality too.
> 
> Hmm, we can allocate migration->multifd on the send side too, even
> if the attributes are unused and it is up to vfio_multifd_free() to
> make the difference between the send/recv side.

Allocating an unnecessary VFIOMultifd structure that has 12 members,
some of them complex like QemuThread, QemuCond or QemuMutex, just
to avoid having one extra bool variable (migration_multifd_transfer or
whatever it ends being named) seem like a poor trade-off for me.

> 
> Something that is bothering me is the lack of introspection tools
> and statistics. What could be possibly added under VFIOMultifd and
> VfioStats ?

There's already VFIO bytes transferred counter and also a
multifd bytes transferred counter.

There are quite a few trace events (both existing and newly added
by this patch).

While even more statistics and traces may help with tuning/debugging
in some cases that's something easily added in the future.

>>> I don't think the '_transfer' suffix adds much to the understanding.
>>
>> The migration->multifd was already taken by VFIOMultifd struct, but
>> it could use other name (migration->multifd_switch? migration->multifd_on?).
> 
> yeah. Let's try to get rid of it first.
> 
>>>> +    } else {
>>>> +        migration->multifd_transfer =
>>>> +            vbasedev->migration_multifd_transfer == ON_OFF_AUTO_ON;
>>>> +    }
>>>> +
>>>> +    if (migration->multifd_transfer && !vfio_multifd_transfer_supported()) {
>>>> +        error_setg(errp,
>>>> +                   "%s: Multifd device transfer requested but unsupported in the current config",
>>>> +                   vbasedev->name);
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> The above checks are also introduced in vfio_save_setup(). Please
>>> implement a common routine vfio_multifd_is_enabled() or some other
>>> name.
>>
>> Done (as common vfio_multifd_transfer_setup()).
> 
> vfio_multifd_is_enabled() please, returning a bool.

Functions named *_is_something() normally just check some conditions
and return a computed value without having any side effects.

Here, vfio_multifd_transfer_setup() also sets migration->multifd_transfer
appropriately (or could migration->multifd) - that's common code for
save and load.

I guess you meant to move something else rather than this block
of code into vfio_multifd_is_enabled() - see my answer below.

>>>>       vfio_migration_cleanup(vbasedev);
>>>>       trace_vfio_load_cleanup(vbasedev->name);
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 153d03745dc7..c0c9c0b1b263 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -61,6 +61,8 @@ typedef struct VFIORegion {
>>>>       uint8_t nr; /* cache the region number for debug */
>>>>   } VFIORegion;
>>>> +typedef struct VFIOMultifd VFIOMultifd;
>>>> +
>>>>   typedef struct VFIOMigration {
>>>>       struct VFIODevice *vbasedev;
>>>>       VMChangeStateEntry *vm_state;
>>>> @@ -72,6 +74,8 @@ typedef struct VFIOMigration {
>>>>       uint64_t mig_flags;
>>>>       uint64_t precopy_init_size;
>>>>       uint64_t precopy_dirty_size;
>>>> +    bool multifd_transfer;
>>>> +    VFIOMultifd *multifd;
>>>>       bool initial_data_sent;
>>>>       bool event_save_iterate_started;
>>>> @@ -133,6 +137,7 @@ typedef struct VFIODevice {
>>>>       bool no_mmap;
>>>>       bool ram_block_discard_allowed;
>>>>       OnOffAuto enable_migration;
>>>> +    OnOffAuto migration_multifd_transfer;
>>>
>>> This property should be added at the end of the series, with documentation,
>>> and used in the vfio_multifd_some_name() routine I mentioned above.
>>>
>>
>> The property behind this variable *is* in fact introduced at the end of the series -
>> in a commit called "vfio/migration: Add x-migration-multifd-transfer VFIO property"
>> after which there are only commits adding the related compat entry and a VFIO
>> developer doc update.
>>
>> The variable itself needs to be introduced earlier since various newly
>> introduced code blocks depend on its value to only get activated when multifd
>> transfer is enabled.
> 
> Not if you introduce a vfio_multifd_is_enabled() routine hiding
> the details. In that case, the property and attribute can be added
> at the end of the series and you don't need to add the attribute
> earlier.

The part above that you wanted to be moved into vfio_multifd_is_enabled()
is one-time check for load or save setup time.

That's *not* the switch to be tested by other parts of the code
during the migration process to determine whether multifd transfer
is in use.

If you want vfio_multifd_is_enabled() to be that switch that's tested by
other parts of the VFIO migration code then it will finally consist of
just a single line of code:
"return migration->multifd_transfer" (or "return migration->multifd").

Then indeed the variable could be introduced with the property than
controls it, but a dummy vfio_multifd_is_enabled() will need to be
introduced earlier as "return false" to not break the build.

> 
> Thanks,
> 
> C.
> 

Thanks,
Maciej



