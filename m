Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC28CD1CDC0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 09:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Aq4-00034M-0L; Tue, 22 Oct 2024 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t3Aq0-00031h-JF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t3Apz-0004xT-7P
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 05:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729587958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrHLxwRE+GF0JGhPtMdnJe0Lj6PAJa6X1mxAxpSEUpU=;
 b=XrFgR7swJ91ExtrpPkAMJnRrSVEtMUz6l51pHRlrzPMTMKofKRjaV0hTuYDqzb7E8L++lI
 +p1dJDV83yl4+gFHMGfaqav2C5YERlYj6lRhqekD2LsMMvnhc/cPwvykMPyES0DJd2eUjz
 0dv0NZpYBHUusw6usgiHfJVD6CgI76k=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-0n-5CtKxMmiRsO0FP0creQ-1; Tue, 22 Oct 2024 05:05:57 -0400
X-MC-Unique: 0n-5CtKxMmiRsO0FP0creQ-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-50d83a838b3so1607726e0c.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 02:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729587956; x=1730192756;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrHLxwRE+GF0JGhPtMdnJe0Lj6PAJa6X1mxAxpSEUpU=;
 b=r+uVY6ng+SJhOHM4M0ssQbXG/s3q9WIAYVZJO2/XUUHFzXqAoiZYabm/0yKoUBrYM3
 wPhsLxl1u/Pms0d/7h9irRSTxfw5fRJrrvRQAe5geRZmcddHGhUb1pcs2zwd4dHSRjh4
 Ep5G1cXm8A51v47Za47ph5xnBtgppLHqnUMM2rPYHylVOW4QEclyM3bkv9Oz6MmlUTLb
 TZbr/Zyqjy6eSBozzu/gH2epd9cIWEKgSiW/7x75xIRXmezdQypa9YgTjcc9Wi9ONsuz
 8Q7C6z0KcaTnw1Pcc1rofusxBZ279ZaLO8BLpCtpbH2uwKJRDul+xlAedHUNRH5KYj0q
 ZZ/w==
X-Gm-Message-State: AOJu0Yx0Jgqmyxzxb7IhhSAiQafNEayA5im9OfRiXYTBWA2lZRfyzRm5
 SXFWYN3x7eIUSnT75oyL7ExyDVCM3pNKfEEWaZG8+d/7aYOMpzjbPnv6LXjvJWgsyaIqqW7UAj8
 Auts3sWpRyki2HgORUUjZwgyWnOuyv5CD8NqDmfoEnXB2Oxd9k1TR
X-Received: by 2002:a05:6122:3c83:b0:50d:7a14:ddf6 with SMTP id
 71dfb90a1353d-50fb627f4bemr2222744e0c.10.1729587956395; 
 Tue, 22 Oct 2024 02:05:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv5aghmDxxavw0nzlG49v4ibqMMt7HzZuHnxlOUp50pA7NQWxWG2ibQvXv5GYAUmKiJ1KfgQ==
X-Received: by 2002:a05:6122:3c83:b0:50d:7a14:ddf6 with SMTP id
 71dfb90a1353d-50fb627f4bemr2222723e0c.10.1729587955997; 
 Tue, 22 Oct 2024 02:05:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it.
 [79.46.200.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1659dff41sm261080085a.30.2024.10.22.02.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 02:05:55 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:05:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v6 00/16] Introduce support for IGVM files
Message-ID: <mz4kfys6rljozu64ow6q2hpokf2zghn5f4onummomu23wivvro@pr4hhhjoq45x>
References: <cover.1727341768.git.roy.hopkins@suse.com>
 <71c6e846d1988f985e9902909a75f6f5a57a2967.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71c6e846d1988f985e9902909a75f6f5a57a2967.camel@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Mon, Oct 21, 2024 at 03:44:26PM +0100, Roy Hopkins wrote:
>> Here is v6 of the set of patches to add support for IGVM files to QEMU. This
>> is
>> based on commit a5dd9ee060 of qemu.
>>
>> This version addresses all of the review comments from v5 [1].
>
>Hi all. I'm just drawing attention to this series again. It has been through a
>number of review cycles and all outstanding suggestions and changes have been
>addressed.
>
>Are there any further changes required before this can be merged?

LGTM, I think I reviewed/acked all of them!

Thanks for this work,
Stefano


