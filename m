Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778AECF64A6
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 02:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLuly-0003wI-NK; Wed, 19 Nov 2025 21:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLulv-0003w6-1e
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:51:47 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLult-00060R-BL
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:51:46 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763607092; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Fd8K7WM/elGjnNSHY+4eV7/rEGsFFMHm62IZgkmTqltO5LxTiluFMXbWN076rh+bYA2dpS4iotrSp1Yf/JPU+RsHq+KB4e3AZCZGZTRbFdGbAFX3hHzggs6c/M7qRRIJ+ZJdYTkoXjqoNvBB7b+Lm3jlcnEl1iVnZRbAO8c5Ids=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763607092;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=rijxsv9s+a/MMeOGuAk4Rw1NDESS3tx75M90YbDiHGA=; 
 b=lwW663YHCHKb/DNoJgOw2vyW2aMnaTPkonxhMnu3BOzQGxSdC/O2tXFSwwaEYR/dHFz0upJFYNNOQ96eEs2WaIMkkd6UA+MaJCFUi9prdBopi6lB8g3iZ1/ZMtJyeq1HysWA9LNoml7yPXstAzwHG+dw5JYs2Hld4r5QG/ywsxQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763607092; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=rijxsv9s+a/MMeOGuAk4Rw1NDESS3tx75M90YbDiHGA=;
 b=eYmFIAltKV6i1WdqsJjvQI7ZRJjFVjdzrlDWH0DTsreYBgP/YKLNBklYganKt5La
 ywf8EgX9BlHGFh305ghjenbUdTZxPwjPvy/c+YKHO6CnqIPVtFdax7cwF56+kbNCC1q
 XUq+ED98rQVsFudGVDhPOk95D45LChfk8xENPOYI=
Received: by mx.zohomail.com with SMTPS id 1763607090575401.51251250266307;
 Wed, 19 Nov 2025 18:51:30 -0800 (PST)
Message-ID: <050d8c75-0506-4aa9-96cc-985e0c493349@collabora.com>
Date: Thu, 20 Nov 2025 05:51:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Markus Armbruster <armbru@redhat.com>
Cc: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
 <874iqrnbaz.fsf@pond.sub.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <874iqrnbaz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 11/18/25 08:45, Markus Armbruster wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 11/17/25 16:22, Markus Armbruster wrote:
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>
>>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>>>> index ed5ae52acb..ea2928b706 100644
>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>>>  
>>>>>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>>>>                                          cmd, NULL, &res->iov, &res->iov_cnt);
>>>>> -    CHECK(!ret, cmd);
>>>>> +    CHECK(ret >= 0, cmd);
>>>>
>>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>>> see how this change improves anything. You now saying that ret > 0 is
>>>> okay, while it shall never happen.
>>>
>>> Please see
>>>
>>>     Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in virgl_cmd_resource_create_blob 
>>>     Date: Mon, 17 Nov 2025 08:49:42 +0100
>>>     Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>>     https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>>
>> It's a rather common bug when errno isn't negated by mistake and a
>> positive error code is returned. Ignoring positive values when they
>> aren't expected opens door to unnecessary problems, IMO.
> 
> No convention can avoid *all* possible problems there.  I know which one
> has created more grief for *me*.  Your experience may be different.
> 
> virtio_gpu_create_mapping_iov() returns -1 on error, 0 on success.
> We could change it to return false on error, true on success.

True/false are also often confusing. As was written in the other email,
this variant is now good to me. In the end I'm glad for having this
discussion, it will help with further improvement of virtio-gpu code.

-- 
Best regards,
Dmitry

