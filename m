Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06CFC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJhQ-0001Zo-2y; Wed, 26 Feb 2025 10:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJhO-0001ZK-Qq
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:51:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJhN-00045m-4t
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740585107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=88tE2ESN9Zzugn6eMqpRiidtDRLUjiPpJA7DHgSLz/I=;
 b=fxf0/R5bBzHpPe06WEjDHzPNdxmAnZiAMdUWh2TFoCtVmggo5Otl7InVpI8YE+rRE5GKpX
 Skc/vx1MpBWX5Wyc1CoU9cv7fyur+lI5WHWkVZ49ARTMHVQ8zrRtIls/B/v4ud5Wv3flOo
 ONLay6jt8PIoIJM1LEw6UTLrIqpY/08=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-YYYw8mGCMyeuQfDcQ_OhyQ-1; Wed, 26 Feb 2025 10:51:44 -0500
X-MC-Unique: YYYw8mGCMyeuQfDcQ_OhyQ-1
X-Mimecast-MFC-AGG-ID: YYYw8mGCMyeuQfDcQ_OhyQ_1740585104
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c09a206b3eso1362212885a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585104; x=1741189904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=88tE2ESN9Zzugn6eMqpRiidtDRLUjiPpJA7DHgSLz/I=;
 b=fZkixfbxGbkNRcFsG3XHZeCohAhBdrYxZDE1dLTUePLYeCkqrMtM4Z7Iox33ovatnP
 JxWcKqV28XwCI2JurLTuUjEvXHSCaC96LM8t1sT704AtM220VyVTlD88AkRW1k1Y5fOd
 vuZykzMippwuNtMGdQh/9RAopRlPUPc6+uM24H3AgfqTRxQyptisJL7+wTtCxfeKLuoW
 EEoeX+pjNew4eG4sSnht/VZa+JiH/zdjZoMygfeeWHBW2FtPVMcN4X0rnhCvVpMtUR3W
 Ec0tJ2Tan2gxOwm+zPfx8+rLpX7nS5yR0j0mk5wxQ6EDZFYbHRcl/a7GwCFZIuHOegzx
 iknQ==
X-Gm-Message-State: AOJu0Yw2E7jP4JQBjRLqa/Bn4yQY/2zzBaBNsheyKh3S3Q80neHOYigY
 DqMEVxqtQkGBWecIeP4EEgkZ4S0Tb4ZuiPl+CQ10qlLIs23haB5dtNyWl12SKZp0DIzjb9ekzSj
 uNkaevMDRl1wRNUFI2SWgpVpjJdmTjMkb+vNyNz7HZ6co84XQd+ctFlEK5u8d
X-Gm-Gg: ASbGnctXNDFWVoFN3mi63XJmcu1jWPTarCZfHRWFW2VMsgkHqbZpqo1/Ndr+KazcHlM
 2HhXpcnjdI9bBD250lLU5Zps1bk8maKMawpDitHJkFm8Yd6b/B9SHEwczT8/jM50/bF1rkHwQfP
 WEZaCFfoOw52tCpo5DcKM75099R26jNTYAaLFZpFPRY6dv5IfXE1zSk4VuugWrXDtp7BRNvG3wy
 VovYJNRt+Dv+eD2dhoE05C3NsaIG9R0CW7Z7U88UHYi4XsI9N5qv0JsIy8AqL/C9x5Dcg==
X-Received: by 2002:a05:620a:c41:b0:7b6:7850:21d4 with SMTP id
 af79cd13be357-7c247fe1ddbmr503355885a.52.1740585104100; 
 Wed, 26 Feb 2025 07:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXiIHb6ciWLB1XEuukxD1eTYTcDgFCNMb4q40/doY5+FqpVaS0x7ptcMwm/5x/tdJM9+jHog==
X-Received: by 2002:a05:620a:c41:b0:7b6:7850:21d4 with SMTP id
 af79cd13be357-7c247fe1ddbmr503353085a.52.1740585103880; 
 Wed, 26 Feb 2025 07:51:43 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c23c34f611sm257939185a.116.2025.02.26.07.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:51:43 -0800 (PST)
Date: Wed, 26 Feb 2025 10:51:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] migration: Unfold control_save_page()
Message-ID: <Z784ja61Oh1cv0V0@x1.local>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-6-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226063043.732455-6-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 26, 2025 at 02:30:42PM +0800, Li Zhijian wrote:
> control_save_page() is for RDMA only, unfold it to make the code more
> clear.
> In addition:
>  - Similar to other branches style in ram_save_target_page(), involve RDMA
>    only if the condition 'migrate_rdma()' is true.
>  - Further simplify the code by removing the RAM_SAVE_CONTROL_NOT_SUPP.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

[...]

> @@ -56,7 +55,7 @@ static inline
>  int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>                             ram_addr_t offset, size_t size)
>  {
> -    return RAM_SAVE_CONTROL_NOT_SUPP;
> +    g_assert_not_reached();
>  }

Not sure if some compiler will be unhappy on the retval not provided, but
anyway we'll see..

Reviewed-by: Peter Xu <peterx@redhat.com>

>  #endif
>  #endif
> -- 
> 2.44.0
> 

-- 
Peter Xu


