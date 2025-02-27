Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3412C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnlx7-00009O-Qq; Thu, 27 Feb 2025 17:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlwz-00005c-TA
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:01:51 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlwy-0007Xq-1C
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:01:49 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tnlwu-000000007OW-03P9; Thu, 27 Feb 2025 23:01:44 +0100
Message-ID: <7c41add3-72ad-4aec-bd74-3c9715fda5c7@maciej.szmigiero.name>
Date: Thu, 27 Feb 2025 23:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] vfio/migration: Update VFIO migration
 documentation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <2031790b755aa95b61470b286fa787b78be08107.1739994627.git.maciej.szmigiero@oracle.com>
 <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <cbebee68-f891-4946-885d-01a8ed24e6c1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 27.02.2025 07:59, Cédric Le Goater wrote:
> On 2/19/25 21:34, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> Update the VFIO documentation at docs/devel/migration describing the
>> changes brought by the multifd device state transfer.
>>
>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>> ---
>>   docs/devel/migration/vfio.rst | 80 +++++++++++++++++++++++++++++++----
>>   1 file changed, 71 insertions(+), 9 deletions(-)
>>
>> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
>> index c49482eab66d..d9b169d29921 100644
>> --- a/docs/devel/migration/vfio.rst
>> +++ b/docs/devel/migration/vfio.rst
>> @@ -16,6 +16,37 @@ helps to reduce the total downtime of the VM. VFIO devices opt-in to pre-copy
>>   support by reporting the VFIO_MIGRATION_PRE_COPY flag in the
>>   VFIO_DEVICE_FEATURE_MIGRATION ioctl.
> 
> Please add a new "multifd" documentation subsection at the end of the file
> with this part :
> 
>> +Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
>> +_STOP_COPY state via multifd channels. This helps reduce downtime - especially
>> +with multiple VFIO devices or with devices having a large migration state.
>> +As an additional benefit, setting the VFIO device to _STOP_COPY state and
>> +saving its config space is also parallelized (run in a separate thread) in
>> +such migration mode.
>> +
>> +The multifd VFIO device state transfer is controlled by
>> +"x-migration-multifd-transfer" VFIO device property. This property defaults to
>> +AUTO, which means that VFIO device state transfer via multifd channels is
>> +attempted in configurations that otherwise support it.
>> +

Done - I also moved the parts about x-migration-max-queued-buffers
and x-migration-load-config-after-iter description there since
obviously they wouldn't make sense being left alone in the top section.

> I was expecting a much more detailed explanation on the design too  :
> 
>   * in the cover letter
>   * in the hw/vfio/migration-multifd.c
>   * in some new file under docs/devel/migration/
> 

I'm not sure what descriptions you exactly want in these places, but since
that's just documentation (not code) it could be added after the code freeze...

> 
> This section :
> 
>> +Since the target QEMU needs to load device state buffers in-order it needs to
>> +queue incoming buffers until they can be loaded into the device.
>> +This means that a malicious QEMU source could theoretically cause the target
>> +QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
>> +
>> +The "x-migration-max-queued-buffers" property allows capping the maximum count
>> +of these VFIO device state buffers queued at the destination.
>> +
>> +Because a malicious QEMU source causing OOM on the target is not expected to be
>> +a realistic threat in most of VFIO live migration use cases and the right value
>> +depends on the particular setup by default this queued buffers limit is
>> +disabled by setting it to UINT64_MAX.
> 
> should be in patch 34. It is not obvious it will be merged.
> 

...which brings us to this point.

I think by this point in time (less then 2 weeks to code freeze) we should
finally decide what is going to be included in the patch set.

This way this patch set could be well tested in its final form rather than
having significant parts taken out of it at the eleventh hour.

If the final form is known also the documentation can be adjusted accordingly
and user/admin documentation eventually written once the code is considered
okay.

I though we discussed a few times the rationale behind both
x-migration-max-queued-buffers and x-migration-load-config-after-iter properties
but if you still have some concerns there please let me know before I prepare
the next version of this patch set so I know whether to include these.

> This section :
> 
>> +Some host platforms (like ARM64) require that VFIO device config is loaded only
>> +after all iterables were loaded.
>> +Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
>> +device property, which in its default setting (AUTO) does so only on platforms
>> +that actually require it.
> 
> Should be in 35. Same reason.
> 
> 
>>   When pre-copy is supported, it's possible to further reduce downtime by
>>   enabling "switchover-ack" migration capability.
>>   VFIO migration uAPI defines "initial bytes" as part of its pre-copy data stream
>> @@ -67,14 +98,39 @@ VFIO implements the device hooks for the iterative approach as follows:
>>   * A ``switchover_ack_needed`` function that checks if the VFIO device uses
>>     "switchover-ack" migration capability when this capability is enabled.
>> -* A ``save_state`` function to save the device config space if it is present.
>> -
>> -* A ``save_live_complete_precopy`` function that sets the VFIO device in
>> -  _STOP_COPY state and iteratively copies the data for the VFIO device until
>> -  the vendor driver indicates that no data remains.
>> -
>> -* A ``load_state`` function that loads the config section and the data
>> -  sections that are generated by the save functions above.
>> +* A ``switchover_start`` function that in the multifd mode starts a thread that
>> +  reassembles the multifd received data and loads it in-order into the device.
>> +  In the non-multifd mode this function is a NOP.
>> +
>> +* A ``save_state`` function to save the device config space if it is present
>> +  in the non-multifd mode.
>> +  In the multifd mode it just emits either a dummy EOS marker or
>> +  "all iterables were loaded" flag for configurations that need to defer
>> +  loading device config space after them.
>> +
>> +* A ``save_live_complete_precopy`` function that in the non-multifd mode sets
>> +  the VFIO device in _STOP_COPY state and iteratively copies the data for the
>> +  VFIO device until the vendor driver indicates that no data remains.
>> +  In the multifd mode it just emits a dummy EOS marker.
>> +
>> +* A ``save_live_complete_precopy_thread`` function that in the multifd mode
>> +  provides thread handler performing multifd device state transfer.
>> +  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
>> +  from the VFIO device and queues it for multifd transmission until the vendor
>> +  driver indicates that no data remains.
>> +  After that, it saves the device config space and queues it for multifd
>> +  transfer too.
>> +  In the non-multifd mode this thread is a NOP.
>> +
>> +* A ``load_state`` function that loads the data sections that are generated
>> +  by the main migration channel save functions above.
>> +  In the non-multifd mode it also loads the config section, while in the
>> +  multifd mode it handles the optional "all iterables were loaded" flag if
>> +  it is in use.
>> +
>> +* A ``load_state_buffer`` function that loads the device state and the device
>> +  config that arrived via multifd channels.
>> +  It's used only in the multifd mode.
> 
> Please move the documentation of the new migration handlers in the
> patch introducing them.
> 
>
> Thanks,
> 
> C.
> 

Thanks,
Maciej


