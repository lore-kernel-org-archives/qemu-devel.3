Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD9C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfNe-0000eR-FS; Tue, 02 Jul 2024 11:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOfNd-0000Z3-6J
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sOfNb-0000Ll-2c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719933913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0tpRout87JkbbO0udX29/nyn2IA3E1ZPlM1iE7t+DY=;
 b=LRpGyRRHFFs1+DTzHQ8jvNQTEyYK5whWGZPbY5/SFZ4/Ly+/jWAVJGyPD0PdVWVIxl7J0u
 SLQzMS0DVh3jvV5b9zODGPKHymmVupdQTavklL0s9zYZYB/hcTB+RnWZD5J6JfAyANb49C
 BSECHSnPsOIFq3IYBL61Ovu94vPpijs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-2RzixQlxNW2XCGCkf5dJnA-1; Tue, 02 Jul 2024 11:25:12 -0400
X-MC-Unique: 2RzixQlxNW2XCGCkf5dJnA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b5cec74f1dso7834386d6.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719933911; x=1720538711;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0tpRout87JkbbO0udX29/nyn2IA3E1ZPlM1iE7t+DY=;
 b=VmD0TLKU4IOEY3V+hq3zZFu5WTt+AXb3eCEa6w32+1HyQqPtEU9inJBrAnqtTcRiun
 Ji3tZD+ycHE4rcnlR7rjOkfOTTOU6qMpwVDB8J4mjtewvbjjCeK7JOk9+4A/7ratuTsA
 Wqy8mf2gQqXnklXdv9evdvZhD5yzWXgXwJkgpZKZB2hWTv0qL4I++BzTsu1nNnChMNA4
 ANMiO9InhSJliaOXnY4PX1/82jgTfBDaTWbrsyA4mjh5KduHMfQKV49UWnsyL9KpZGBy
 LmE+srjW5Rl50+M3pKPfMYu523kY9K3xCgHN0lD0fIEB6+LlaShiXyxEr4cevCxSaA+D
 yz0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu9+t0HeHtgchbKyw+/1L4tFk6XWBrtsyf1/gRSodRRCe5KlcBbhH8z+838PkCLz0eXbTLg40258ACkX1AUiqDcFVlEk8=
X-Gm-Message-State: AOJu0YysOe/FF0CK58DDo3w2S+UOOZ0h9JqaeQKE02kAqTRLeZ3SxKSw
 4ENPE6+aurt+MgwXX/A/Hj6yuavLC9P67Fkzv2kEZINZG7S4wblcbvZONe0tPNI42VC9JYKRGLE
 ORfe4tq4sUfMpdCxcQ5SCgyUS3s9R23GiImIF++HYUKB3+zuRIv/c
X-Received: by 2002:a05:6214:caf:b0:6b5:dc5a:ffe0 with SMTP id
 6a1803df08f44-6b5dc5b01d8mr12896066d6.38.1719933911747; 
 Tue, 02 Jul 2024 08:25:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTNY4xh8toscMeq0eKHOHQAgdchW6fy3EiOvQLHkGStgk8CUg+4ZnsbRJAMT56oqZdQ9sOsQ==
X-Received: by 2002:a05:6214:caf:b0:6b5:dc5a:ffe0 with SMTP id
 6a1803df08f44-6b5dc5b01d8mr12895926d6.38.1719933911507; 
 Tue, 02 Jul 2024 08:25:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59e368ac9sm44187926d6.25.2024.07.02.08.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:25:11 -0700 (PDT)
Message-ID: <d5aa033d-fc09-41b1-b0c9-15df9e765ced@redhat.com>
Date: Tue, 2 Jul 2024 17:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio/display: Fix potential memleak of edid info
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, marcandre.lureau@redhat.com,
 kraxel@redhat.com, chao.p.peng@intel.com
References: <20240701014809.255682-1-zhenzhong.duan@intel.com>
 <20240701014809.255682-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240701014809.255682-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/1/24 3:48 AM, Zhenzhong Duan wrote:
> EDID related device region info is leaked in vfio_display_edid_init()
> error path and VFIODisplay destroying path.
> 
> Fixes: 08479114b0de ("vfio/display: add edid support.")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/display.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 661e921616..9c57fd3888 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -171,7 +171,9 @@ static void vfio_display_edid_init(VFIOPCIDevice *vdev)
>   
>   err:
>       trace_vfio_display_edid_write_error();
> +    g_free(dpy->edid_info);
>       g_free(dpy->edid_regs);
> +    dpy->edid_info = NULL;
>       dpy->edid_regs = NULL;
>       return;
>   }
> @@ -182,6 +184,7 @@ static void vfio_display_edid_exit(VFIODisplay *dpy)
>           return;
>       }
>   
> +    g_free(dpy->edid_info);
>       g_free(dpy->edid_regs);
>       g_free(dpy->edid_blob);
>       timer_free(dpy->edid_link_timer);


