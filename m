Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA52CF64A6
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 02:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLugo-0000vy-Jz; Wed, 19 Nov 2025 21:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLugk-0000nH-OB
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:46:27 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLuge-0004wJ-PB
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 21:46:24 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763606764; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cq4jmajgjq7PF+trEZxbOztABVmSPWcT2GaOTbySEYTlZ+LIcM6AkTOyLy9dlNaWXwVti3mgyuZcWaupyeJYLm0qm/+crhWbUEGp3dO6bC2SkoWO2DSATGLjixmzK/eKPYwZKAjyQKmnmnbtdjX28cp22EtyMe+VVJfGjhmhrqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763606764;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4LFJk2K/PwoEdZfI7T7Fs9DaNA/bQLvTaMut6LFg1C8=; 
 b=B9n4i3E0T2AziwOW0DAbfSi91oCwPFtVLDqK6vaQ+CcXzmlb9qGMsgSHKlRyj3oMTUIEOKAX8pLN+BkN2u6LnC9TPHE+uzi26ZoqGc0tm0AyJUQXTQPBEL0ht1r0pQrxTNTWC2bH4BPZFkiCau83HKaYTxPMBqitCSotWgiOr+c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763606764; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4LFJk2K/PwoEdZfI7T7Fs9DaNA/bQLvTaMut6LFg1C8=;
 b=LUsRnoIbtCBP2Oc8w+lM1vRnTbT9UuOgInaH4NBmZ++ofC5OI18O73tzJmAoMcwJ
 AgYXwTq945NHk1ru+nGGTNR56x9i1/oAqh5lbg+ZEb9SpdjLG94lgcZBVNCCsOX5asE
 KXVIyIvgVbftqDFznvP78cMPC1KOv8N6JQJezkLA=
Received: by mx.zohomail.com with SMTPS id 1763606762763452.01202034915775;
 Wed, 19 Nov 2025 18:46:02 -0800 (PST)
Message-ID: <54f36d07-1300-407b-8985-d590a76aa04e@collabora.com>
Date: Thu, 20 Nov 2025 05:45:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Honglei Huang <honghuan@amd.com>, Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
 <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
 <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
 <d0005fdb-29ac-471f-b2dd-9eddebb6bd83@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <d0005fdb-29ac-471f-b2dd-9eddebb6bd83@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/20/25 04:29, Akihiko Odaki wrote:
> On 2025/11/20 4:16, Dmitry Osipenko wrote:
>> On 11/18/25 15:32, Honglei Huang wrote:
>>>
>>>
>>> On 2025/11/18 09:48, Dmitry Osipenko wrote:
>>>> On 11/17/25 16:22, Markus Armbruster wrote:
>>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>>
>>>>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-
>>>>>>> gpu-rutabaga.c
>>>>>>> index ed5ae52acb..ea2928b706 100644
>>>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g,
>>>>>>> struct virtio_gpu_ctrl_command *cmd)
>>>>>>>          ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>>>>>> sizeof(att_rb),
>>>>>>>                                            cmd, NULL, &res->iov,
>>>>>>> &res->iov_cnt);
>>>>>>> -    CHECK(!ret, cmd);
>>>>>>> +    CHECK(ret >= 0, cmd);
>>>>>>
>>>>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>>>>> see how this change improves anything. You now saying that ret > 0 is
>>>>>> okay, while it shall never happen.
>>>>>
>>>>> Please see
>>>>>
>>>>>       Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
>>>>> virgl_cmd_resource_create_blob
>>>>>       Date: Mon, 17 Nov 2025 08:49:42 +0100
>>>>>       Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>>>>       https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>>>>
>>>> It's a rather common bug when errno isn't negated by mistake and a
>>>> positive error code is returned. Ignoring positive values when they
>>>> aren't expected opens door to unnecessary problems, IMO.
>>>>
>>>
>>> How about apply the v2 or v3 firstly to fix the
>>> virtio_gpu_create_mapping_iov() block issue in virtio-gpu?
>>>
>>> I will create another thread for the `CHECK(!ret, cmd);` thing in
>>> rutabaga.
>>
>> There was a precedent of virtio-gpu not handling positive error codes
>> properly [1]. To me there is no problem that needs to be fixed when
>> virtio_gpu_create_mapping_iov() is never expected to return positive
>> values and doesn't return them.
>>
>> [1]
>> https://lore.kernel.org/qemu-devel/20240129073921.446869-1-
>> dmitry.osipenko@collabora.com/
>>
>> It's a common expectation that errors are negative. But in practice it's
>> not always true, especially when interacting with external code.
>>
>> Functionally this patch doesn't change anything. Will leave to Alex and
>> Akihiko to decide on it.
> 
> I'm fine either way.
> 
> This is a "trade-off" scenario where both two options have upsides and
> downsides. I often avoid making an argument in that case because it
> tends to be subjective and cannot be confirmed, leading to bikeshedding.
> 
> In my opinion, such a function should not return int in the first place,
> but should return bool. The wide range of values int can take causes
> problems; bool allows compilers to enforce that it only returns two values.
> 
> Sign is one of those problems. int leads to a mistake like returning
> errno instead of -errno.
> 
> Functions may have completely different ideas for integer return values.
> In case of virtio-gpu, virtio_gpu_create_mapping_iov() returns -1 but
> virtio_gpu_update_dmabuf() returns -EINVAL. This is confusing.
> 
> Sometimes it is still preferred to keep functions returning int for
> consistency, but looking at include/hw/virtio/virtio-gpu.h, three return
> bool and three return int, so returning int here does not improve
> consistency.
> 
> That all said, this is a bug fix, not refactoring. This patch does fix a
> bug and avoids polluting the codebase, so it is fine for me. Perhaps it
> may be nice to have a patch to convert all functions returning int to
> bool to avoid pitfalls and improve consistency, but that can be done later.

Let's settle with the current variant, I'm okay with it now.

-- 
Best regards,
Dmitry

