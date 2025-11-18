Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32757CEBF61
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 01:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLApv-0003Qj-KR; Mon, 17 Nov 2025 20:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLApt-0003QO-Sn
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 20:48:49 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLApr-0006gI-JE
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 20:48:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763430510; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C+nnhV/ItjYrqBrKypYb0KbMwSEtAl1ujqYMhOxoMS7nDsxhqj4NEcC6Q6aKgj7XTA9Zn3mJHmSgFzhxttlNeOBPoatXB4RfT23zw4Mqr7Z/JTPbYdeUweH4OJ0QN3s++sSQRGs4tSqoWSpfbNd1OgjHCGYeGI/I65RtDeVPW/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763430510;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CHE1gWTJDWNJjK/QyOPKNfiNtCAf3WNT+GMueWfkwOM=; 
 b=IFtN6Xcwl0p8jNIpQZaEOXHG+IpiYyfgR6p4OPqpdnffU801y3jawHJLC6px/9K30rmuO4Tn/uMEpjE1ZSSIGeJQk5xRGROdvgO/74eY6ZUGAbuVzWER7c9SwjcrElgvqYgiF0Rqas0Y9n/kMuruSMbTpPFlqK8eMlrMC1hPcoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763430510; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=CHE1gWTJDWNJjK/QyOPKNfiNtCAf3WNT+GMueWfkwOM=;
 b=dx1z4mHo3etO3Bm60Auq8dlIiEluvLUmNPdQ7BrPYRFEbaAIgxLVYnv+SsWZdZNY
 qDDSMzQlGlfxvu5djM89hlbaSH6N+5ETsxsnYit8ECDwK2STIuMBioL36GBEuhNtsCg
 R4FbbWutM32SLmmn87v4fsQPvZ5TWDMrMWS/OqY0=
Received: by mx.zohomail.com with SMTPS id 1763430507995190.46182993313073;
 Mon, 17 Nov 2025 17:48:27 -0800 (PST)
Message-ID: <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
Date: Tue, 18 Nov 2025 04:48:23 +0300
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
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87bjl0pzeq.fsf@pond.sub.org>
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

On 11/17/25 16:22, Markus Armbruster wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> On 11/17/25 13:51, Honglei Huang wrote:
>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>> index ed5ae52acb..ea2928b706 100644
>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>  
>>>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>>                                          cmd, NULL, &res->iov, &res->iov_cnt);
>>> -    CHECK(!ret, cmd);
>>> +    CHECK(ret >= 0, cmd);
>>
>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>> see how this change improves anything. You now saying that ret > 0 is
>> okay, while it shall never happen.
> 
> Please see
> 
>     Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in virgl_cmd_resource_create_blob 
>     Date: Mon, 17 Nov 2025 08:49:42 +0100
>     Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/

It's a rather common bug when errno isn't negated by mistake and a
positive error code is returned. Ignoring positive values when they
aren't expected opens door to unnecessary problems, IMO.

-- 
Best regards,
Dmitry

