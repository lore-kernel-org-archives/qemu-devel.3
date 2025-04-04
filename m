Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26875C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0gQw-00045r-9P; Fri, 04 Apr 2025 08:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gQu-000459-0F
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u0gQr-0001a3-4T
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743770760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEttCtD5fGY5H0D8TTGn+51C/dbz1dCDEgR+ZQlMeYM=;
 b=D93OrvE1l7LfDa5oSUiFfCXyzEDGc+T+npsWIQAlzrC3g9HlHjqq6DiMAYEGplajcJnEXR
 FjmY+bzu3c1iyggqDFve1IiKL6qjoAWu9ujWqqDnqnSrMZjjK5CScZpTIwgLvcIzserXHt
 kAserqXLqWrK5BZc4VbzcCRMtIJmLqE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-RX2Z_Mt2MeiAQP145Q4rtQ-1; Fri, 04 Apr 2025 08:45:58 -0400
X-MC-Unique: RX2Z_Mt2MeiAQP145Q4rtQ-1
X-Mimecast-MFC-AGG-ID: RX2Z_Mt2MeiAQP145Q4rtQ_1743770758
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cec217977so13095385e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 05:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743770757; x=1744375557;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IEttCtD5fGY5H0D8TTGn+51C/dbz1dCDEgR+ZQlMeYM=;
 b=dkAFLpMxt3XHy58laY2kFZ02PmiPg6elZhZxVcbe+EVbo+GUdUhGl1jtLOuJXaV24K
 qcGfZ8LEZWB/1eRmt7l2FliVmT7V2uQ+eADL4XRIBa3bKjOVCisDLg3s0AYJ5d1HWEGW
 E/pS9YABzDXHMlvloP+3ldm0r4bED6KDbPhmz2Dz2DxbKcNFUBhgP3Ge86k4f6xQhVHL
 2+AT7DPJ3IbsIsUorgLH8Z1zKLAuihFnsShvbeEmJTNqbYubTo6tHHc2Rc4eHVWLRW2Z
 k2/VllsaEB+/KgSrljj68TWbif1f5/FE0Uz5mmAI9PaL7CK+v9kVqJDKjRg8s51ByU5X
 f8WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP40D/XoeBhJsTm1SQIfgb+Hv2n3E9D8hsNmXFEhH6qRIHKrlmlcrGZ4UuuZyK1W+aua0riex2Q/I5@nongnu.org
X-Gm-Message-State: AOJu0Yw0YD9XWNvXrfJDFvHrCulQNLcsKbqZ4mWkgrnUhIH2L95M3zi2
 rGj1nMItGc3qMd9MAdq3ZGSxMzrRnozH2CIMggixxqW6AsaeE0LIZZ7MZtTugTQ3SiJqsXTGSyH
 TOSFyqngtRavPxkQyAGSbq+1nqqTHEzIqy+DosjJ8H6oigFPLuQfw
X-Gm-Gg: ASbGncvvT7+M7qQl0N0ImUBlQ9CQVZhX0brQblcTKDXUMojB48IJOGXBqILVmJXMD9u
 dNXW7IYU7yiN9H03jZpW0qozy0CoI7I0/09ZtY/H3b3CtpxEK396BF/SHSfweVKZlC/rdhDDrst
 k9ut86nHuHHLX1+rkJD0SRIvPV38LDMpa12TsvSKPm3lsYfBjkDSm5n/XVJ6uOxUa3kTT/Qc5LZ
 MWtv0iA3OYTqwnbhulSaGE3gkajMJiCUGpAJXHWCoCl3r5G87kKik0oLLw7HCt59LphiEP+Ozjx
 SkG4KwUs/vXkFiSsfZjevlVXnuTAfBc19MkjF1EkjFBOkEfCaukVNftHHJjbI8gw0824KCRTU7W
 xhCLSORHqlL0MnXi+KW2cUdZQZ3YfjUDMs/YyZTfYs5tl
X-Received: by 2002:a05:6000:1acd:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39cb35ab18bmr2976356f8f.34.1743770757496; 
 Fri, 04 Apr 2025 05:45:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvTU5qbrN0oc4+nbkEE/1y730cJfkjZzH2I+Kw+wfE2klg/KREQ6HHWmdmbnOh+uow1nxw4Q==
X-Received: by 2002:a05:6000:1acd:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-39cb35ab18bmr2976332f8f.34.1743770757071; 
 Fri, 04 Apr 2025 05:45:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d66:d61a:f3cf:3494:9981?
 (p200300cfd74f9d66d61af3cf34949981.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d66:d61a:f3cf:3494:9981])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a0a90sm4248852f8f.21.2025.04.04.05.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 05:45:56 -0700 (PDT)
Message-ID: <fcb5513f-0b7c-4e27-a4aa-9244a8d328dc@redhat.com>
Date: Fri, 4 Apr 2025 14:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com> <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
 <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
 <87tt7eu0nt.fsf@pond.sub.org>
 <cfad66d7-1ba1-440e-9a48-4d0c91eb5aa1@redhat.com>
 <Z-vWlL1_P5UmK2Gl@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <Z-vWlL1_P5UmK2Gl@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
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

On 01.04.25 14:05, Kevin Wolf wrote:
> Am 27.03.2025 um 14:45 hat Hanna Czenczek geschrieben:
>> On 27.03.25 13:18, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> On 26.03.25 12:41, Markus Armbruster wrote:
>>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>>
>>>>>> On 26.03.25 06:38, Markus Armbruster wrote:
>>>>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>>>>
>>>>>>>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>>>>>>>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>>>>>>>
>>>>>>>> We can use this to implement multi-threading.
>>>>>>>>
>>>>>>>> Note that the interface presented here differs from the multi-queue
>>>>>>>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>>>>>>>> allows processing multiple virtqueues in a single iothread.  The
>>>>>>>> equivalent (processing multiple FDs in a single iothread) would not make
>>>>>>>> sense for FUSE because those FDs are used in a round-robin fashion by
>>>>>>>> the FUSE kernel driver.  Putting two of them into a single iothread will
>>>>>>>> just create a bottleneck.
>>>>>>>>
>>>>>>>> Therefore, all we need is an array of iothreads, and we will create one
>>>>>>>> "queue" (FD) per thread.
>>>>>>> [...]
>>>>>>>
>>>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>>>> ---
>>>>>>>>    qapi/block-export.json |   8 +-
>>>>>>>>    block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>>>>>>>    2 files changed, 179 insertions(+), 43 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>>>>>>> index c783e01a53..0bdd5992eb 100644
>>>>>>>> --- a/qapi/block-export.json
>>>>>>>> +++ b/qapi/block-export.json
>>>>>>>> @@ -179,12 +179,18 @@
>>>>>>>>    #     mount the export with allow_other, and if that fails, try again
>>>>>>>>    #     without.  (since 6.1; default: auto)
>>>>>>>>    #
>>>>>>>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>>>>>>>> +#     given iothreads (instead of the block device's iothread, or the
>>>>>>>> +#     export's "main" iothread).
>>>>>>> When does "the block device's iothread" apply, and when "the export's
>>>>>>> main iothread"?
>>>>>> Depends on where you set the iothread option.
>>>>> Assuming QMP users need to know (see right below), can we trust they
>>>>> understand which one applies when?  If not, can we provide clues?
>>>> I don’t understand what exactly you mean, but which one applies when has nothing to do with this option, but with the @iothread (and @fixed-iothread) option(s) on BlockExportOptions, which do document this.
>>> Can you point me to the spot?
>> Sure: https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#object-QMP-block-export.BlockExportOptions
>> (iothread and fixed-iothread)
>>
>>>>>>> Is this something the QMP user needs to know?
>>>>>> I think so, because e.g. if you set iothread on the device and the export, you’ll get a conflict.  But if you set it there and set this option, you won’t.  This option will just override the device/export option.
>>>>> Do we think the doc comment sufficient for QMP users to figure this out?
>>>> As for conflict, BlockExportOptions.iothread and BlockExportOptions.fixed-iothread do.
>>>>
>>>> As for overriding, I do think so.  Do you not?  I’m always open to suggestions.
>>>>
>>>>> If not, can we provide clues?
>>>>>
>>>>> In particular, do we think they can go from an export failure to the
>>>>> setting @iothreads here?  Perhaps the error message will guide them.
>>>>> What is the message?
>>>> I don’t understand what failure you mean.
>>> You wrote "you'll get a conflict".  I assume this manifests as failure
>>> of a QMP command (let's ignore CLI to keep things simple here).
>> If you set the @iothread option on both the (guest) device and the export
>> (and also @fixed-iothread on the export), then you’ll get an error.  Nothing
>> to do with this new @iothreads option here.
>>
>>> Do we think ordinary users running into that failure can figure out they
>>> can avoid it by setting @iothreads?
>> It shouldn’t affect the failure.  Setting @iothread on both device and
>> export (with @fixed-iothread) will always cause an error, and should.
>> Setting this option is not supposed to “fix” that configuration error.
>>
>> Theoretically, setting @iothreads here could make it so that
>> BlockExportOptions.iothread (and/or fixed-iothread) is ignored, because that
>> thread will no longer be used for export-issued I/O; but in practice,
>> setting that option (BlockExportOptions.iothread) moves that export and the
>> whole BDS tree behind it to that I/O thread, so if you haven’t specified an
>> I/O thread on the guest device, the guest device will then use that thread.
>> So making @iothreads silently completely ignore BlockExportOptions.iothread
>> may cause surprising behavior.
>>
>> Maybe we could make setting @iothreads here and the generic
>> BlockExportOptions.iothread at the same time an error.  That would save us
>> the explanation here.
> This raises the question if the better interface wouldn't be to change
> the BlockExportOptions.iothread from 'str' to an alternate between 'str'
> and ['str'], allowing the user to specify multiple iothreads in the
> already existing related option without creating conflicting options.

Sounds good.

> In the long run, I would be surprised if FUSE remained the only export
> supporting multiple iothreads. At least the virtio based ones
> (vhost-user-blk and VDUSE) even have precedence in the virtio-blk device
> itself, so while I don't know how much interest there is in actually
> implementing it, in theory we know it makes sense.

For the virtio-based ones, I don’t know whether the interface should 
allow to map virtqueues to threads, though (as virtio-blk allows now).  
It doesn’t make sense for FUSE because of the round-robin nature, but 
for other exports, I don’t know.

But I’m happy to not worry about that for now. :)

Hanna


