Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF6CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpGz-0006XN-Mw; Tue, 26 May 2026 06:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wRpGx-0006X2-Ou; Tue, 26 May 2026 06:44:31 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wRpGv-0003zu-Td; Tue, 26 May 2026 06:44:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1779792263; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=G9Ln8nSzpsxJY/C9wMJwMWITt32C1+1wtDTSnZRMtWmkZGe09Q/gvgFQ//TPFTrIJudBdGImEc4z3kSnW7JobiKw3Cd6fEETwBT58Y9LPEiFlrtClqtBu9gFHuYFgkQlSlSN4iNVLCl3LqVKavrwqkpluZ1DNM/2YTkNTdWMaEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779792263;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HoXrJUu4A2tRq43rSlpoFLt6ugqcuSxbEHX5wYjPohI=; 
 b=MZSzaP83gR8gdEjjXVA9K1SKi6AeY0patt+WgQ7tRvezOogImur/4FIdm7dZZTx+fOGmcwJKHL69V7Mj4XTHCHZ/I6ol1RjjnKKGAmdg7b7EwJQRjJxRN6HD1kF8q3bQQIIf/g3ErED7e9V3OZjzvGZ8ZdMtKMsV/RsVAoV/RVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779792263; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=HoXrJUu4A2tRq43rSlpoFLt6ugqcuSxbEHX5wYjPohI=;
 b=jEac+cyWQnFcfPwX4jQRI2orBVIfvwiCD/30eFKGIATmRUyXWg9PM8by638kuCeo
 FxYTZ+OtNl4AN4IstbJBGkURAV5CzuQiGwKFRbyTxsndeZLqVcz5RkR2NH8/IXxo+Wu
 QtFjHgliJda/4Om3Reqb6rR/nouiHUBYZTgmr520=
Received: by mx.zohomail.com with SMTPS id 1779792260513489.0132292696708;
 Tue, 26 May 2026 03:44:20 -0700 (PDT)
Message-ID: <89b9b848-5bb1-4f13-884a-975ef3bd06bb@collabora.com>
Date: Tue, 26 May 2026 13:44:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 visitorckw@gmail.com
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-5-lucaaamaral@gmail.com>
 <87se7nbr96.fsf@draig.linaro.org>
 <6d3ab702-a931-4a48-81b4-d774b25095c1@collabora.com>
Content-Language: en-US
In-Reply-To: <6d3ab702-a931-4a48-81b4-d774b25095c1@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/19/26 17:30, Dmitry Osipenko wrote:
> On 5/19/26 13:58, Alex Bennée wrote:
>> Lucas Amaral <lucaaamaral@gmail.com> writes:
>>
>>> Set blob_alignment to the host page size so the guest kernel can
>>> align blob BAR offsets accordingly, avoiding alignment mismatches
>>> with the VMM's memory mapping API (e.g., hv_vm_map on macOS).
>>>
>>> Guest-side kernel support (drm_mm alignment) is pending upstream
>>> Linux merge.
>>>
>>> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
>>> ---
>>>  hw/display/virtio-gpu.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index de7a86a7..44ae5034 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -1532,6 +1532,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>>  #endif
>>>      }
>>>  
>>> +    /*
>>> +     * TODO: guest-side F_BLOB_ALIGNMENT support pending upstream Linux merge
>>> +     * (Sergio Lopez's patches, Nov 2025). Until merged, the guest won't
>>> +     * negotiate this feature. The host advertises it per OASIS virtio spec.
>>> +     */
>>> +    g->parent_obj.virtio_config.blob_alignment =
>>> +        cpu_to_le32(qemu_real_host_page_size());
>>> +
>>
>> Is it merged yet?
> 
> Not merged, I actually missed the v2 patches Sergio sent couple weeks
> ago [1], thanks for bringing it up. In general, it's enough to have the
> field defined in the virtio spec, there should be no need to wait for
> the kernel patch to land.
> 
> [1]
> https://lore.kernel.org/dri-devel/20260428194450.518296-1-slp@redhat.com/

Kernel patches landed to misc-next tree last week [1].

[1] https://gitlab.freedesktop.org/drm/misc/kernel/-/commits/drm-misc-next

-- 
Best regards,
Dmitry

