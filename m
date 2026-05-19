Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ABDCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLSl-0000No-LA; Tue, 19 May 2026 10:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wPLSi-0000NK-KY; Tue, 19 May 2026 10:30:24 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wPLSf-0004Bp-Id; Tue, 19 May 2026 10:30:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1779201011; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KX2OUZCfirYJzGc9OdBz8S7uPsLIClgnKgDd9TSkfv8gTpXTgtSkDvoe9xA0Lh8gxDbfIla+P+Qr71gbiXSMptuZnSPuQJ0bRaUzEHEi9G9y60cMQEB5lPO3lUvZaCLoKJJ0a0z3sTLnB0pPRLxydzz5ru1WU3Ao3ONxDwoqq1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779201011;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B3dlJb9qxmGBPw1fx+h43aQD4VqpQoEPjLlov5qePoI=; 
 b=QOkCpvhOci9qtg4wCqdtMX24q8NgpN8oAH84B3pasGzU32Y9sQ3/fPkQFSNSBxJVahlsDOGQpojgWFD4090zX93rgwJly06qfs2fupxOVf6NmoIT78ehvfZ7SfTWGciUZzclfxgM5v2RGKQihKUy4xNWtyW7czeweskBY25pVY4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779201011; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=B3dlJb9qxmGBPw1fx+h43aQD4VqpQoEPjLlov5qePoI=;
 b=hea74VpAFAhI+GHyekOWUBeEd5LTOmGdmAD6FWukfow2oY2Zv9PWEunvsUdzgiek
 LexFAFAfY/4yViFyFgYtBmtIOKOTsirabH93aeTLevva61hKKuthixk9kaH6rdMx0oe
 Li308sm4QYVPqiMr1+QFanl1DSbFVjPD+lBYZaL8=
Received: by mx.zohomail.com with SMTPS id 1779201010058441.81294088275627;
 Tue, 19 May 2026 07:30:10 -0700 (PDT)
Message-ID: <6d3ab702-a931-4a48-81b4-d774b25095c1@collabora.com>
Date: Tue, 19 May 2026 17:30:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] virtio-gpu: advertise VIRTIO_GPU_F_BLOB_ALIGNMENT
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, marcandre.lureau@redhat.com,
 visitorckw@gmail.com
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-5-lucaaamaral@gmail.com>
 <87se7nbr96.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87se7nbr96.fsf@draig.linaro.org>
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

On 5/19/26 13:58, Alex Bennée wrote:
> Lucas Amaral <lucaaamaral@gmail.com> writes:
> 
>> Set blob_alignment to the host page size so the guest kernel can
>> align blob BAR offsets accordingly, avoiding alignment mismatches
>> with the VMM's memory mapping API (e.g., hv_vm_map on macOS).
>>
>> Guest-side kernel support (drm_mm alignment) is pending upstream
>> Linux merge.
>>
>> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
>> ---
>>  hw/display/virtio-gpu.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index de7a86a7..44ae5034 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1532,6 +1532,14 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>  #endif
>>      }
>>  
>> +    /*
>> +     * TODO: guest-side F_BLOB_ALIGNMENT support pending upstream Linux merge
>> +     * (Sergio Lopez's patches, Nov 2025). Until merged, the guest won't
>> +     * negotiate this feature. The host advertises it per OASIS virtio spec.
>> +     */
>> +    g->parent_obj.virtio_config.blob_alignment =
>> +        cpu_to_le32(qemu_real_host_page_size());
>> +
> 
> Is it merged yet?

Not merged, I actually missed the v2 patches Sergio sent couple weeks
ago [1], thanks for bringing it up. In general, it's enough to have the
field defined in the virtio spec, there should be no need to wait for
the kernel patch to land.

[1]
https://lore.kernel.org/dri-devel/20260428194450.518296-1-slp@redhat.com/

-- 
Best regards,
Dmitry

