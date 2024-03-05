Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C482C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPDY-00033X-HL; Tue, 05 Mar 2024 02:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhPDU-00032T-EE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:28:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rhPDS-0004Lf-O7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709623677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wSDlwUjKQ3h/+oMby1NULjzvaM/98uHLBBJBALNFrNo=;
 b=RhQTQSEcmOrZRyk6v9kk+ikgZ2XVu3FCsWaPj/eJWE/aPeVktJodGL/9lC4p/j2Q71k5Ka
 EoXTqKofYFfFNuzglRQ7CTuMG7IfEeci6isrj+7UrXVgTSIU4eP9Nkf4AkeH5GGmkmxtz9
 auRKHuTf466VGp/RcQ4kMEwiixPr6qs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-trxOGFiZPtmSdhcSQfEKLQ-1; Tue, 05 Mar 2024 02:27:55 -0500
X-MC-Unique: trxOGFiZPtmSdhcSQfEKLQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5673cc14ca4so847222a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709623674; x=1710228474;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSDlwUjKQ3h/+oMby1NULjzvaM/98uHLBBJBALNFrNo=;
 b=dglJufrDcU5PNUWPqbyeVLdvlxZtR4sYERUePH68s0sMX9rBB0fFcjPWBW5CKD2PeS
 r8itVP4labVk99yTK8XOKi6GXeI910bGLSehuVWUvLwRZR9K8iacQpeEwrwF/P6oO+v/
 9K5mlCIMo586scU7qilwP/uVRXn1nsNaJ7XSW+9I95iG4caab9qHNEZoHL52LmnxpCMN
 hJDYpmsXx/gIUWKoxjirREyToZW+IVDWw9uNVOeXJwOcrZXbLLjYhp2JnLMz4BKDC2Bn
 A+mFirpN3h11hoT/PVJELb6wu9q2tkkH15nMD7oui+/eEYi0ttHgmDf46YXthde6wpZU
 Xe1g==
X-Gm-Message-State: AOJu0YwLl0Ak0H2KKqY8WH1Ct+OgxkcBP/K8BvuhRwX7Il1ED/3IQ5uR
 GAJJfWHo1h0QM010j9NAZwp4b+OQg61YS//Hd3OYzQhuXkqey6AEF95qjdZsnZujaM2hdJSm+3+
 ddm37h6ot+rZgA3SOHYWlB1AlJQ3QmxrqxpueIRsvTJeeuk0pv/ji
X-Received: by 2002:a05:6402:40c8:b0:567:15a6:848e with SMTP id
 z8-20020a05640240c800b0056715a6848emr5808232edb.18.1709623674141; 
 Mon, 04 Mar 2024 23:27:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVh5ofpakgtUzKbVnO5m0VVOEJYNo6MfBW6fbVz4FsRfChwwtulUgsWwJfO8NE3OMIUiS0pw==
X-Received: by 2002:a05:6402:40c8:b0:567:15a6:848e with SMTP id
 z8-20020a05640240c800b0056715a6848emr5808218edb.18.1709623673821; 
 Mon, 04 Mar 2024 23:27:53 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-243.web.vodafone.de.
 [109.43.178.243]) by smtp.gmail.com with ESMTPSA id
 l17-20020aa7cad1000000b005673b5a2370sm2419214edt.44.2024.03.04.23.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:27:53 -0800 (PST)
Message-ID: <4f6e1748-a917-4b2b-847d-fbfe04a3e43e@redhat.com>
Date: Tue, 5 Mar 2024 08:27:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/mem/cxl_type3: Fix problem with g_steal_pointer()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org
References: <20240304104406.59855-1-thuth@redhat.com>
 <20240304104406.59855-4-thuth@redhat.com>
 <20240304151037.00000f6c@Huawei.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240304151037.00000f6c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 04/03/2024 16.10, Jonathan Cameron wrote:
> On Mon,  4 Mar 2024 11:44:06 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> When setting GLIB_VERSION_MAX_ALLOWED to GLIB_VERSION_2_58 or higher,
>> glib adds type safety checks to the g_steal_pointer() macro. This
>> triggers errors in the ct3_build_cdat_entries_for_mr() function which
>> uses the g_steal_pointer() for type-casting from one pointer type to
>> the other (which also looks quite weird since the local pointers have
>> all been declared with g_autofree though they are never freed here).
>> Fix it by using a proper typecast instead. For making this possible, we
>> have to remove the QEMU_PACKED attribute from some structs since GCC
>> otherwise complains that the source and destination pointer might
>> have different alignment restrictions. Removing the QEMU_PACKED should
>> be fine here since the structs are already naturally aligned. Anyway,
>> add some QEMU_BUILD_BUG_ON() statements to make sure that we've got
>> the right sizes (without padding in the structs).
> 
> I missed these as well when getting rid of the false handling
> of failure of g_new0 calls.
> 
> Another alternative would be to point to the head structures rather
> than the containing structure - would avoid need to cast.
> That might be neater?  Should I think also remove the alignment
> question?

I gave it a try, but it does not help against the alignment issue, I still get:

../../devel/qemu/hw/mem/cxl_type3.c: In function 
‘ct3_build_cdat_entries_for_mr’:
../../devel/qemu/hw/mem/cxl_type3.c:138:34: error: taking address of packed 
member of ‘struct CDATDsmas’ may result in an unaligned pointer value 
[-Werror=address-of-packed-member]
   138 |     cdat_table[CT3_CDAT_DSMAS] = &dsmas->header;
       |                                  ^~~~~~~~~~~~~~

 From my experience, it's better anyway to avoid __attribute__((packed)) on 
structures unless it is really really required. At least we should avoid it 
as good as possible as long as we still support running QEMU on Sparc hosts 
(that don't support misaligned memory accesses), since otherwise you can end 
up with non-working code there, see e.g.:

  https://www.mail-archive.com/qemu-devel@nongnu.org/msg439899.html

or:

  https://gitlab.com/qemu-project/qemu/-/commit/cb89b349074310ff9eb7ebe18a

Thus I'd rather prefer to keep this patch as it is right now.

  Thomas


