Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE8AC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:00:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVQV-0008Av-D2; Fri, 07 Mar 2025 05:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVQJ-00083F-PR
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:59:26 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVQH-0005Kj-LF
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:59:23 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tqVQD-00000000RMe-0hsD; Fri, 07 Mar 2025 11:59:17 +0100
Message-ID: <dbb85fdf-fa4b-48dd-8d1c-87fcab1cd8df@maciej.szmigiero.name>
Date: Fri, 7 Mar 2025 11:59:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <4d727e2e0435e0022d50004e474077632830e08d.1741124640.git.maciej.szmigiero@oracle.com>
 <629dff3c-865d-47d9-a01a-d212dfed1efb@nvidia.com>
 <97b87f22-b867-4282-ba13-efba16458859@maciej.szmigiero.name>
 <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
 <d85c8d21-5e1b-4162-9f5b-fe270beb5eca@nvidia.com>
 <498a07aa-d539-46e6-90e9-8c41a59a6b2f@maciej.szmigiero.name>
 <bdf53809-b0da-489b-b25a-28be1286c06a@nvidia.com>
 <7eb4dd80-0ae3-4522-bd1d-b004c19c4bf2@redhat.com>
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
In-Reply-To: <7eb4dd80-0ae3-4522-bd1d-b004c19c4bf2@redhat.com>
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

On 6.03.2025 15:26, Cédric Le Goater wrote:
> On 3/6/25 15:23, Avihai Horon wrote:
>>
>> On 06/03/2025 16:13, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 6.03.2025 14:37, Avihai Horon wrote:
>>>>
>>>> On 06/03/2025 12:32, Cédric Le Goater wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 3/6/25 11:15, Maciej S. Szmigiero wrote:
>>>>>> On 6.03.2025 07:47, Avihai Horon wrote:
>>>>>>>
>>>>>>> On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
>>>>>>>> External email: Use caution opening links or attachments
>>>>>>>>
>>>>>>>>
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>
>>>>>>>> Implement the multifd device state transfer via additional per-device
>>>>>>>> thread inside save_live_complete_precopy_thread handler.
>>>>>>>>
>>>>>>>> Switch between doing the data transfer in the new handler and doing it
>>>>>>>> in the old save_state handler depending if VFIO multifd transfer is enabled
>>>>>>>> or not.
>>>>>>>>
>>>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>>>> ---
>>>>>>>>   hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
>>>>>>>>   hw/vfio/migration-multifd.h   |   6 ++
>>>>>>>>   hw/vfio/migration.c           |  22 ++++--
>>>>>>>>   hw/vfio/trace-events          |   2 +
>>>>>>>>   include/hw/vfio/vfio-common.h |   6 ++
>>>>>>>>   5 files changed, 172 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>>>>>>> index 1d81233c755f..bfb9a72fa450 100644
>>>>>>>> --- a/hw/vfio/migration-multifd.c
>>>>>>>> +++ b/hw/vfio/migration-multifd.c
>>>>>>>> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>>>>>>>>       return true;
>>>>>>>>   }
>>>>>>>>
>>>>>>>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>>>>>>> +{
>>>>>>>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>>>>>>>> +
>>>>>>>> +    /*
>>>>>>>> +     * Emit dummy NOP data on the main migration channel since the actual
>>>>>>>> +     * device state transfer is done via multifd channels.
>>>>>>>> +     */
>>>>>>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static bool
>>>>>>>> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>>>>>>> +                                               char *idstr,
>>>>>>>> +                                               uint32_t instance_id,
>>>>>>>> +                                               uint32_t idx,
>>>>>>>> +                                               Error **errp)
>>>>>>>> +{
>>>>>>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>>>>>>> +    g_autoptr(QEMUFile) f = NULL;
>>>>>>>> +    int ret;
>>>>>>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>>>>>>> +    size_t packet_len;
>>>>>>>> +
>>>>>>>> +    bioc = qio_channel_buffer_new(0);
>>>>>>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>>>>>>> +
>>>>>>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>>>>>>> +
>>>>>>>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>>>>>>>> +        return false;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ret = qemu_fflush(f);
>>>>>>>> +    if (ret) {
>>>>>>>> +        error_setg(errp, "%s: save config state flush failed: %d",
>>>>>>>> +                   vbasedev->name, ret);
>>>>>>>> +        return false;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>>>>>>> +    packet = g_malloc0(packet_len);
>>>>>>>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>>>>>>>> +    packet->idx = idx;
>>>>>>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>>>>>>
>>>>>>> The packet is sent on the wire.
>>>>>>> Shouldn't we use cpu_to_be32() for version, idx and flags? Also below in vfio_multifd_save_complete_precopy_thread().
>>>>>>> And then use be32_to_cpu() in patch #26 when receiving the packet?
>>>>>>
>>>>>> Is it even possible to migrate to a host with different endianess here?
>>>>>>
>>>>>> Also AFAIK big endian hosts barely exist today, is any of them even VFIO-capable?
>>>>>
>>>>> s390x is VFIO capable. VFIO PCI migration is not supported on these.
>>>>>
>>>> It is indeed a niche use case and not even applicable today, but if we want to add support for it after the release, we will have to add a compatibility option for older QEMUs.
>>>> If we add support for it now, then we can avoid the compatibility option.
>>>>
>>>> It's a really small change and it can come even after the series is merged, as a fix.
>>>> So IMHO it wouldn't hurt, for completeness.
>>>
>>> For sure, any such bit stream change will need re-testing the whole VFIO migration.
>>>
>>> But I will be testing the queued buffers size limit anyway so it would make
>>> sense to test both at the same time.
>>>
>>> Wouldn't it make more sense, however, to squash this endianess change already
>>> to the relevant patches rather than to have such bit stream modifying patch on the top?
>>>
>>> It would help prevent backporting mistakes - when someone forgets about this last patch
>>> and ends with a different bit stream.
>>
>> I agree.
>> Whatever you and Cedric decide.
>>
> 
> PR was sent. So it will be a "Fixes" patch.

I have posted both of these patches now.

> Thanks,
> 
> C.

Thanks,
Maciej


