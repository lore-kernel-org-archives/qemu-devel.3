Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF1D1D88B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 17:00:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ktd-00029D-RZ; Tue, 15 Oct 2024 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0ktc-00028a-8z
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1t0kta-0001dR-AS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729011579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUftsG80rP1NCj+v/guWY+/O530Wtrf3qIVA931DCas=;
 b=eyfytx13WKSaifHpZQS1ymQWqZV12y7G+1CSjaDwhNwB7Nn/VKw0MjHym16+Fjk+tpQbPl
 reYW7+cCJ3xahMgq6thRZT6ItYYuEUgCZxGoD8I7dI6dUitbQqPPsYTNfUVljyAwASanuf
 BTdlREjcngX0ME88GyAHJ5iqeawhRek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-cWT21jUsPDKZoiCIeF0UsQ-1; Tue, 15 Oct 2024 12:59:38 -0400
X-MC-Unique: cWT21jUsPDKZoiCIeF0UsQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a99f43c4c7bso255043466b.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729011577; x=1729616377;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUftsG80rP1NCj+v/guWY+/O530Wtrf3qIVA931DCas=;
 b=qK7RRDrf/joIhUq4tncaQchAEYQWefK/R/29ktmdrVn9R1hSQdR0qa77rrCsdd4Bxi
 xJEb2REl8qiksxzD2WkcWgaVTcntSw2Zl4MRma2TzL8+wiMKTVnPJ7YyEKm9SO5kV2kO
 Wu5sOpiwESfQu0XBT3jrdVwcGYfA6Y3z7zko0thaPN7ZH95h5TWjzP3FfTSKqArmnwHI
 Z6FxQjbrqEFnJxVJKXn0rfm/Qg+dhrRcyl8vb+msxURuqXCWdzyO5LMDgM0Ns+frBFyg
 sJW7CAsGD0kezMPwIy60fHI8rq+ABO4HhjmEwTW6WS1dGeCivAkumAZV/pxDai9EadRJ
 nOtA==
X-Gm-Message-State: AOJu0YxxJdhBL7EdFEQgrFunqhLWEyW+AgImW7NX5RiXem9RlT57bzub
 k+43aKkvACdODXjsN2XvbWw/lWs574FMLfucL4fYFiarlIcHBBlQP2B9txwo9T+7dALbiUeGdoz
 VZJ4SI2Zr1upsg0vMZRbKs5j4hQnG+9RB5z2yvEq7N+dhtJX5da5t
X-Received: by 2002:a17:907:f148:b0:a99:f1aa:a71f with SMTP id
 a640c23a62f3a-a9a34d3cd85mr90603466b.11.1729011577251; 
 Tue, 15 Oct 2024 09:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtEsW8uf/17Ry0LIeBNRF6immJxKR6DcDW7Mso2vRljHIwdmCxq8zKXfdZAdnDQXvDbzAogw==
X-Received: by 2002:a17:907:f148:b0:a99:f1aa:a71f with SMTP id
 a640c23a62f3a-a9a34d3cd85mr90601866b.11.1729011576823; 
 Tue, 15 Oct 2024 09:59:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:2e31:9b54:c0c7:20fe:e73c?
 (p200300cfd7232e319b54c0c720fee73c.dip0.t-ipconnect.de.
 [2003:cf:d723:2e31:9b54:c0c7:20fe:e73c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29843984sm91000766b.158.2024.10.15.09.59.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 09:59:35 -0700 (PDT)
Message-ID: <814f5932-1029-4aef-8b53-ab2fb50c0812@redhat.com>
Date: Tue, 15 Oct 2024 18:59:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Ensure vmstate_save() sets errp
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org
References: <20241015141515.150754-1-hreitz@redhat.com> <Zw6TBx0HPf1OhXD7@x1n>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <Zw6TBx0HPf1OhXD7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 15.10.24 18:06, Peter Xu wrote:
> On Tue, Oct 15, 2024 at 04:15:15PM +0200, Hanna Czenczek wrote:
>> migration/savevm.c contains some calls to vmstate_save() that are
>> followed by migrate_set_error() if the integer return value indicates an
>> error.  migrate_set_error() requires that the `Error *` object passed to
>> it is set.  Therefore, vmstate_save() is assumed to always set *errp on
>> error.
>>
>> Right now, that assumption is not met: vmstate_save_state_v() (called
>> internally by vmstate_save()) will not set *errp if
>> vmstate_subsection_save() or vmsd->post_save() fail.  Fix that by adding
>> an *errp parameter to vmstate_subsection_save(), and by generating a
>> generic error in case post_save() fails (as is already done for
>> pre_save()).
>>
>> Without this patch, qemu will crash after vmstate_subsection_save() or
>> post_save() have failed inside of a vmstate_save() call (unless
>> migrate_set_error() then happen to discard the new error because
>> s->error is already set).  This happens e.g. when receiving the state
>> from a virtio-fs back-end (virtiofsd) fails.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   migration/vmstate.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>> index ff5d589a6d..13532f2807 100644
>> --- a/migration/vmstate.c
>> +++ b/migration/vmstate.c
>> @@ -22,7 +22,8 @@
>>   #include "trace.h"
>>   
>>   static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>> -                                   void *opaque, JSONWriter *vmdesc);
>> +                                   void *opaque, JSONWriter *vmdesc,
>> +                                   Error **errp);
>>   static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>>                                      void *opaque);
>>   
>> @@ -441,12 +442,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>           json_writer_end_array(vmdesc);
>>       }
>>   
>> -    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
>> +    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>>   
>>       if (vmsd->post_save) {
>>           int ps_ret = vmsd->post_save(opaque);
>>           if (!ret) {
> Perhaps here it needs to be "if (!ret && ps_ret)" now, otherwise the error
> will be attached even if no error for both retvals?

Not just perhaps, that seems kind of vital indeed...

(I blame my brain’s less-than-stellar pattern matching that might have 
interpreted this as the error path *cough*)

> Other than that it looks good.

Thanks for the quick review!  Will respin.

Hanna

>
> Thanks,
>
>>               ret = ps_ret;
>> +            error_setg(errp, "post-save failed: %s", vmsd->name);
>>           }
>>       }
>>       return ret;
>> @@ -518,7 +520,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>>   }
>>   
>>   static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>> -                                   void *opaque, JSONWriter *vmdesc)
>> +                                   void *opaque, JSONWriter *vmdesc,
>> +                                   Error **errp)
>>   {
>>       const VMStateDescription * const *sub = vmsd->subsections;
>>       bool vmdesc_has_subsections = false;
>> @@ -546,7 +549,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>>               qemu_put_byte(f, len);
>>               qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
>>               qemu_put_be32(f, vmsdsub->version_id);
>> -            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
>> +            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
>>               if (ret) {
>>                   return ret;
>>               }
>> -- 
>> 2.45.2
>>


