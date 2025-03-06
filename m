Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3DCC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 10:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq8Wr-0001dD-QR; Thu, 06 Mar 2025 05:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tq8Wp-0001cP-6c
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:32:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tq8Wm-0008TR-4m
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 05:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741257147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cqjcd4/l6fI0YQ/L+fz/PmpwBpmihzYmiDbpyHzKkBw=;
 b=Cd0VsqBDIn173i/FwdrxTT/HuJ9CRvhrFtqF4/xCgc3hiPkVMVyWpPHoZE1V2Ci1F24tvx
 vlEHsNvbFhoL7OcDzYLC3C9UiET9J31xu52BqoBCZlYNwGI2VaJJmNS3llxHmiHC6sz8wS
 gAxF64rnTipFfarA4OB3CESZjkBYSjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-HY9NLAYHOVuJ-8MMaZsWNA-1; Thu, 06 Mar 2025 05:32:25 -0500
X-MC-Unique: HY9NLAYHOVuJ-8MMaZsWNA-1
X-Mimecast-MFC-AGG-ID: HY9NLAYHOVuJ-8MMaZsWNA_1741257144
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3911232fd8bso349449f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 02:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741257144; x=1741861944;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqjcd4/l6fI0YQ/L+fz/PmpwBpmihzYmiDbpyHzKkBw=;
 b=CFaSnULSBUs6aJiPCoASIfwFG60BS806RQDwW6D+5RzzNN+LOfZtEHBzxO9H3mQamF
 1k1VyEiLI6ljcOhxNxWGbEOlE0mLkwYmjhc2MAG9RBrID1mHsVkXTWCkG29OE+G7Yp/o
 0VopSyPko5Me8APbPwNoGz9TYASTYR1vZzTBNlD5tv00YCMKrA9dVljEacx8+pf/9GVm
 f80k9rnz8u9OLT+Q4uC135nSbB1MCByFrPGRBXULXKZPH9R09RRSM4ugUwlFv0+7xs3Q
 jJN8mPB4PZdAcwbBUKbYfsB88UhE8rnJHBNFPj8A6m6bIY8ihaMlrbV8W56CtMKHUSfo
 K5Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkGrozBoEMo8FwW5jql/DEImB7a6if4UWtq4Q7MLSaY198um8bHBC6mHQ8wSxtekTEgGAkyXEWJgtk@nongnu.org
X-Gm-Message-State: AOJu0Yx9S12zh3pRkdf/ReR+z6x+YHGgF74eFwLvaRmb8ZG1C+6b4J25
 tXuchnVLH5pcJU72EzqDOFlMArKECs18lt06PUl+xhV6nCAqftDsn/HifQGficq8s5qnxIDfYAk
 OLk+hVfHv8yX2fiEVaZ6901n3z2LAGGQVVaudvXAQIwW5X0HbHMxa
X-Gm-Gg: ASbGncukEo3dM766yqNN/9PTQydlN5Lj1JFSvkr5W7gPCmlKWaih/HtKejUTDvUaHUU
 Af+VVef2St9T/hDuSQz3V2O9vUYRYouqiBX2rq1EAhGOPTdtn9hNhVUMcxqpsz3B3s0kHTtXvIE
 5oWpGlHuRfRqIzp1M+QHH+2YGRW6EcNGCVgYJichEKlj6F9YMqtNJ8WfcUABr9nn5fsYwZQeMpt
 qeXwsgxbq7h3DEUTv/wEtb8WdFddRZFPWCtlX8OnNrNS54Nj2gjOmWpEns5QncxeQE20M8kIXJr
 6sTcwprwjy8Mj039fRiisFPmQIVVixvtOtgH6Qc6sZOdXzOkIRVB/g==
X-Received: by 2002:a5d:5982:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-3911f7466a7mr6200435f8f.27.1741257144383; 
 Thu, 06 Mar 2025 02:32:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlvqd/Wc++3MwqS2COCf7stA/Oo99V6xIkbM6lQchRYretDU35cWni2zbmoDssAWuPQB80WA==
X-Received: by 2002:a5d:5982:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-3911f7466a7mr6200407f8f.27.1741257143975; 
 Thu, 06 Mar 2025 02:32:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm15275325e9.37.2025.03.06.02.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 02:32:23 -0800 (PST)
Message-ID: <973268d4-85d6-4a17-ae76-2d20d8cfd7cb@redhat.com>
Date: Thu, 6 Mar 2025 11:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 30/36] vfio/migration: Multifd device state transfer
 support - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <97b87f22-b867-4282-ba13-efba16458859@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 3/6/25 11:15, Maciej S. Szmigiero wrote:
> On 6.03.2025 07:47, Avihai Horon wrote:
>>
>> On 05/03/2025 0:03, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> Implement the multifd device state transfer via additional per-device
>>> thread inside save_live_complete_precopy_thread handler.
>>>
>>> Switch between doing the data transfer in the new handler and doing it
>>> in the old save_state handler depending if VFIO multifd transfer is enabled
>>> or not.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration-multifd.c   | 142 ++++++++++++++++++++++++++++++++++
>>>   hw/vfio/migration-multifd.h   |   6 ++
>>>   hw/vfio/migration.c           |  22 ++++--
>>>   hw/vfio/trace-events          |   2 +
>>>   include/hw/vfio/vfio-common.h |   6 ++
>>>   5 files changed, 172 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
>>> index 1d81233c755f..bfb9a72fa450 100644
>>> --- a/hw/vfio/migration-multifd.c
>>> +++ b/hw/vfio/migration-multifd.c
>>> @@ -496,6 +496,148 @@ bool vfio_multifd_setup(VFIODevice *vbasedev, bool alloc_multifd, Error **errp)
>>>       return true;
>>>   }
>>>
>>> +void vfio_multifd_emit_dummy_eos(VFIODevice *vbasedev, QEMUFile *f)
>>> +{
>>> +    assert(vfio_multifd_transfer_enabled(vbasedev));
>>> +
>>> +    /*
>>> +     * Emit dummy NOP data on the main migration channel since the actual
>>> +     * device state transfer is done via multifd channels.
>>> +     */
>>> +    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
>>> +}
>>> +
>>> +static bool
>>> +vfio_save_complete_precopy_thread_config_state(VFIODevice *vbasedev,
>>> +                                               char *idstr,
>>> +                                               uint32_t instance_id,
>>> +                                               uint32_t idx,
>>> +                                               Error **errp)
>>> +{
>>> +    g_autoptr(QIOChannelBuffer) bioc = NULL;
>>> +    g_autoptr(QEMUFile) f = NULL;
>>> +    int ret;
>>> +    g_autofree VFIODeviceStatePacket *packet = NULL;
>>> +    size_t packet_len;
>>> +
>>> +    bioc = qio_channel_buffer_new(0);
>>> +    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-save");
>>> +
>>> +    f = qemu_file_new_output(QIO_CHANNEL(bioc));
>>> +
>>> +    if (vfio_save_device_config_state(f, vbasedev, errp)) {
>>> +        return false;
>>> +    }
>>> +
>>> +    ret = qemu_fflush(f);
>>> +    if (ret) {
>>> +        error_setg(errp, "%s: save config state flush failed: %d",
>>> +                   vbasedev->name, ret);
>>> +        return false;
>>> +    }
>>> +
>>> +    packet_len = sizeof(*packet) + bioc->usage;
>>> +    packet = g_malloc0(packet_len);
>>> +    packet->version = VFIO_DEVICE_STATE_PACKET_VER_CURRENT;
>>> +    packet->idx = idx;
>>> +    packet->flags = VFIO_DEVICE_STATE_CONFIG_STATE;
>>
>> The packet is sent on the wire.
>> Shouldn't we use cpu_to_be32() for version, idx and flags? Also below in vfio_multifd_save_complete_precopy_thread().
>> And then use be32_to_cpu() in patch #26 when receiving the packet?
> 
> Is it even possible to migrate to a host with different endianess here?
> 
> Also AFAIK big endian hosts barely exist today, is any of them even VFIO-capable?

s390x is VFIO capable. VFIO PCI migration is not supported on these.

Thanks,

C.




