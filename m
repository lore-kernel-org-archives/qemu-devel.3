Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C6BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPal-0004OA-PH; Wed, 27 Mar 2024 05:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPah-0004Nk-I1
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:29:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rpPaf-0005U0-Uh
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711531740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5S6Pzx9Yu28hFnnLxK/M6kuhVhva6jpL3fEUZCYtHvk=;
 b=hMQ81mx6qiu/jRcUonX9ku9MNRurYFy1qrkeYcMTLESYGiFCexyKuPgdhogntNVZEOYvOF
 Zv2hCQArGZtHZq17SVW+yy+YdQtzERiPvD7nqmUhpdv6j3WXEo3L5UCrTF3g+jpAGlQ0Ug
 JWU/8HPygxIB48vhzjQsMqFWt+LQZmI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-bopQVQiiOtCIF6m-NgqPFQ-1; Wed, 27 Mar 2024 05:28:58 -0400
X-MC-Unique: bopQVQiiOtCIF6m-NgqPFQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a473769f8d0so295367966b.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711531737; x=1712136537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5S6Pzx9Yu28hFnnLxK/M6kuhVhva6jpL3fEUZCYtHvk=;
 b=F8dWdJ4ewmKOU3ITLUn9dDKL1e7EZaaNEu0CRJg834ure66g1rJIntfStIuiBOq5J4
 QNn/46rgkZivUB4mfs2lX8y6EHRo4pk4Gq3DQBT0KE7ItxMm9h6LwU2quzVvhqIDavgT
 Ddo4L21hPXo/zD8AcA/fHruL9Y9VYEzaQA4jXBTYplIbljY23xNIlRxdjFoP16v5I6m0
 wYgCvHbAHthdmbvLbJzCp7CnYmP6tcWheHbi4Ga04zvt+ts7LJRHHZt+/l53B0A/en1y
 aAU60GfTX0NZPAcB5+8LaaAZeIzGY9i91bHWsSLDRkzjnx5xm7vPgBU7vVgopu/JMKRF
 B1hQ==
X-Gm-Message-State: AOJu0YzcwTEwcuVG9I69eWuDkjGDw7prHBvVmceNiUTe81nDXkg543xW
 CnFisxMpJieFbJuJeqKxq+ZcmxBJTxDvyCNqbsVI8Q1OpcBS4y2LkgCcdPNe9yMBLpMTzoi6hQf
 JqwafYaCEdpGbGVTSjWI2R1Bb0q2//Q6ys4VlBhdKMCJWv2y3fNff
X-Received: by 2002:a17:907:9485:b0:a4a:348c:de85 with SMTP id
 dm5-20020a170907948500b00a4a348cde85mr3035329ejc.37.1711531737607; 
 Wed, 27 Mar 2024 02:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6WcM3aIxnp/rHQOt5ooG88cpSxn9IKSvBL5NJ9w8UciZwD4fP1xUvyQ8sOls6AQHhm5gxA==
X-Received: by 2002:a17:907:9485:b0:a4a:348c:de85 with SMTP id
 dm5-20020a170907948500b00a4a348cde85mr3035310ejc.37.1711531737173; 
 Wed, 27 Mar 2024 02:28:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 l24-20020a1709066b9800b00a46be85684bsm5182626ejr.223.2024.03.27.02.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 02:28:56 -0700 (PDT)
Date: Wed, 27 Mar 2024 10:28:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 gmaglione@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 slp@redhat.com, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-9.1 v2 03/11] libvhost-user: mask F_INFLIGHT_SHMFD if
 memfd is not supported
Message-ID: <cgbmaphimcjyumgm5utowikxtc3zgryhdanpv6mdzgd5lseqc7@5eeor25j2ija>
References: <20240326133936.125332-1-sgarzare@redhat.com>
 <20240326133936.125332-4-sgarzare@redhat.com>
 <ixiutci362bjtfb7n7l7knacx22fy2v4jqcpyc475cnmsyymwf@6yyguuh5j2oz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ixiutci362bjtfb7n7l7knacx22fy2v4jqcpyc475cnmsyymwf@6yyguuh5j2oz>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Mar 26, 2024 at 09:36:54AM -0500, Eric Blake wrote:
>On Tue, Mar 26, 2024 at 02:39:28PM +0100, Stefano Garzarella wrote:
>> libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
>> message if MFD_ALLOW_SEALING is not defined, since it's not able
>> to create a memfd.
>>
>> VHOST_USER_GET_INFLIGHT_FD is used only if
>> VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
>> that feature if the backend is not able to properly handle these
>> messages.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
>> index a11afd1960..1c361ffd51 100644
>> --- a/subprojects/libvhost-user/libvhost-user.c
>> +++ b/subprojects/libvhost-user/libvhost-user.c
>> @@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
>>          features |= dev->iface->get_protocol_features(dev);
>>      }
>>
>> +    /*
>> +     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
>> +     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
>> +     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
>> +     * is negotiated. A device implementation can enable it, so let's mask
>> +     * it to avoid a runtime panic.
>> +     */
>> +#ifndef MFD_ALLOW_SEALING
>> +    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
>> +#endif
>
>Masking the feature out of advertisement is obviously correct. But
>should we also fix the code for handling
>VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD to return an error to any client
>that requests it in error when the feature was not advertised, instead
>of panicking?

Totally agree!

Do I send a separate patch from this series or include it in this
series?
I would do the former because this one is already long enough.

Thanks,
Stefano


