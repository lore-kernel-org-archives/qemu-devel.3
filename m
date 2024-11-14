Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB3BD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfzj-0006I3-I9; Thu, 14 Nov 2024 14:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBfze-0006Hp-5A
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:59:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBfzc-00018O-BS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731614342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tlql7bsXt9efqMnjhB29oANIpU/0ClLbojigR7tb9A4=;
 b=BCnNiVqLXSi/tiU4ECjh3zQ2cZFt458xX9w4H0m53hery3Mf8HHKccZiJAmx4K7YIRZWo3
 ysF/dHj1ulV7rycfBW3N3WyYrK6NSsEqqKb/SuXd4F4sH/3JbHZQGIiRhadQrE7m1wy2dk
 f17Wr5F326lgKHSLkBhBSRvMIp479iM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-PQK3wuZ0MgqN9aIo0PQuoA-1; Thu, 14 Nov 2024 14:59:00 -0500
X-MC-Unique: PQK3wuZ0MgqN9aIo0PQuoA-1
X-Mimecast-MFC-AGG-ID: PQK3wuZ0MgqN9aIo0PQuoA
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83abf68e7f0so95623239f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731614339; x=1732219139;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tlql7bsXt9efqMnjhB29oANIpU/0ClLbojigR7tb9A4=;
 b=LtPqbog+OmEw59V/jpkav2j9r2BXxgFWA6AMPTkDJVsVxhnxIlPo/xdd02viVCXBG/
 Tq+h8Yet87KAPSvdhR549wFYOJG/MDkNEVCGwgzyzMPZ76ziCAsjUJ9QdVCICSGfBBA/
 vXMKdco+fiO3iCc1aA1zxoCoZeSc152734PO39lRw8uPVNa9ifQWgYJpoyNYuWl0HJVj
 IBjRJqEOzL3UrnpLh0v1GUhUPDiG+5C9G251cB+f3Vj3Zc/EGma9U68sS7GKFQWLBEjz
 LNFcHWIuyK+g3AGnFpeO1jz6Ul3ev/aTmSi4hX7PLV+r8KhiPQinhgttU0VoLMv8A7wv
 bXJQ==
X-Gm-Message-State: AOJu0YznWWC8hELsAZJ8zTotSP+0s0koiZ+E4OiU8jypvXXuCbI2D6Ar
 Smy/VtHck/3Pu9e/QkFYiGT5oU/hIgRGYyXBcUFymNC+BTOhwrFHj1R6lL3qC2beLGPJt59XURb
 YsjqOe6RoTOIjakS1BXdKflkQTG7vQm8DHDxqY5VzBLHE8HGpYO1e
X-Received: by 2002:a05:6602:2b90:b0:83b:29a5:ff91 with SMTP id
 ca18e2360f4ac-83e6c2cbb71mr32380239f.9.1731614339246; 
 Thu, 14 Nov 2024 11:58:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ+cJJkXq2qy11tK30Ls7EHqteVe35uFvk2UogEyHWXleW1/RF7axajXoFmnPhKAtl5ixNLQ==
X-Received: by 2002:a05:6602:2b90:b0:83b:29a5:ff91 with SMTP id
 ca18e2360f4ac-83e6c2cbb71mr32378839f.9.1731614338969; 
 Thu, 14 Nov 2024 11:58:58 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e02fc542c1sm401356173.32.2024.11.14.11.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 11:58:58 -0800 (PST)
Date: Thu, 14 Nov 2024 14:58:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/8] qom: refactor checking abstract property when
 creating instances
Message-ID: <ZzZWgG91nqSL4d2J@x1n>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111155555.90091-2-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

On Mon, Nov 11, 2024 at 03:55:48PM +0000, Daniel P. Berrangé wrote:
> @@ -753,7 +761,7 @@ typedef union {
>  } qemu_max_align_t;
>  #endif
>  
> -static Object *object_new_with_type(Type type)
> +static Object *object_new_with_type(Type type, Error **errp)
>  {
>      Object *obj;
>      size_t size, align;
> @@ -777,7 +785,10 @@ static Object *object_new_with_type(Type type)
>          obj_free = qemu_vfree;
>      }
>  
> -    object_initialize_with_type(obj, size, type);
> +    if (!object_initialize_with_type(obj, size, type, errp)) {
> +        g_free(obj);

obj_free(obj)?

> +        return NULL;
> +    }
>      obj->free = obj_free;
>  
>      return obj;

-- 
Peter Xu


