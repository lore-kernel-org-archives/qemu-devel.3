Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C9FC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 06:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7qwD-0003LA-4X; Fri, 17 May 2024 02:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s7qvy-00039o-25
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1s7qvw-0004Md-MI
 for qemu-devel@nongnu.org; Fri, 17 May 2024 02:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715926751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azZK2YuNYK/XC0mMM3t1O3rjeFfFXiB7DFi21tMw3EE=;
 b=O8qic63LZqk/2hQgm6DyMMmjHuvwRBOFQv92xiLVXjhB4t7jjTKj1qNsWKGsHs+x9vSPMX
 rdekLNPybEN2turm6Qtoa08fSlteQ0Eim7qkBxaIw7ZPWV6DtQRBtpQFrQgDskUCYO1BQ2
 NOFiMLBxvtQRNTrH9fk6tJIaqfAiSPU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jivdXu6PM_a0SKUpv16w-g-1; Fri, 17 May 2024 02:19:09 -0400
X-MC-Unique: jivdXu6PM_a0SKUpv16w-g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79308bfe615so145185485a.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 23:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715926749; x=1716531549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azZK2YuNYK/XC0mMM3t1O3rjeFfFXiB7DFi21tMw3EE=;
 b=aleYISm/wvNEaxJEjUivkQ2A8fwNJq6q5CZRbrnolB3JqVNfLfPR9R0LS86aHOzXdO
 h7TNlOet3rqqVSUEYPVDYpmPYj2QM19taiz5kVMZE9O9QUZfpM26BclnGnJbHAFXI+6N
 SKNR4Ouk76HYNZoMm8FEjCaQR9Fbhwhf151ZxBf3FNzK/KoJ6HU/1x2XbFb6MfMVwBea
 /yW0CTe6XCGBI3HV4+Df10nwXmHo9MK3pnzDYO+0o6GDPEPu4pjAyTVOYvpdPszLowJH
 xMzXf5QB+y5O5iXGWjgks8PGrFBvgJl8IKYBJ+tj+cBJtWhCs5cDp2yNDnkzHeewY0vq
 2mVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpMwaXOhKjPusaLyFWsHSL7MaEjDwSMCrtRIaQGlIhoD9G+FkLIgS1wD1uXHSCla0MfZJ+6khVYa4jt0qhmraui0gc8wE=
X-Gm-Message-State: AOJu0Yya1wlWYVmFQLsQiLPZzvZN/jMc2QyZFJsyM+HJk9P2ac6H4M2D
 eaLLYmrooAaI2DbEqDmmSumkzbLKbbtkZRVXBK5Zbs1dr77soO6Gct2EkLjz2gGL9/AiuYQMDg/
 0kpN26UemOzQN8b9w5wEPU8mvNoUvJ54vLE7lRgWJ48DGe0OWJ5Vu
X-Received: by 2002:a05:6214:451c:b0:6a0:ce12:b8a4 with SMTP id
 6a1803df08f44-6a1681bc3fcmr262780846d6.21.1715926749145; 
 Thu, 16 May 2024 23:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlga1V/ta2OITum/sk7EEgFlBykp1Vl19sDB6AJYglFa9Pjl9U0lT1uKkQDoJsAsAN3j0TdQ==
X-Received: by 2002:a05:6214:451c:b0:6a0:ce12:b8a4 with SMTP id
 6a1803df08f44-6a1681bc3fcmr262780646d6.21.1715926748763; 
 Thu, 16 May 2024 23:19:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a35ba07275sm20971906d6.27.2024.05.16.23.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 23:19:08 -0700 (PDT)
Message-ID: <2dee2b91-b809-4563-b6b0-830998894d76@redhat.com>
Date: Fri, 17 May 2024 08:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/s390_flic: Fix crash that occurs when saving the
 machine state
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240517061553.564529-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240517061553.564529-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/17/24 08:15, Thomas Huth wrote:
> adapter_info_so_needed() treats its "opaque" parameter as a S390FLICState,
> but the function belongs to a VMStateDescription that is attached to a
> TYPE_VIRTIO_CCW_BUS device. This is currently causing a crash when the
> user tries to save or migrate the VM state. Fix it by using s390_get_flic()
> to get the correct device here instead.
> 
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: 9d1b0f5bf5 ("s390_flic: add migration-enabled property")
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/s390_flic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 7f93080087..6771645699 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -459,7 +459,7 @@ type_init(qemu_s390_flic_register_types)
>   
>   static bool adapter_info_so_needed(void *opaque)
>   {
> -    S390FLICState *fs = S390_FLIC_COMMON(opaque);
> +    S390FLICState *fs = s390_get_flic();
>   
>       return fs->migration_enabled;
>   }


