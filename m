Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD27C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGYP-0000KA-W6; Mon, 16 Jun 2025 16:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uRGYO-0000Jl-CR
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uRGYL-0007Tt-1u
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750106126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7r9gGAo00UxhvZgMwQIm7BZfgRdhCpGsmwEG8EjxjQQ=;
 b=feSKP3zaF7LLxJOKhUtildCk1zdU6ObF7tZjylmZe4tjOvecXo1Zq0HCcNJ1RP3NsaFKIO
 lsLKWjDc3TChGJEfkYOOGfTE8ot98WHlZb/FJ5Y+wHF6kr86L3pDsBhDpWnxHr5+EIUlw3
 QrvdTaVdV6VPoWUs+DJrX6yMkIZHf5I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-JRN9SmI_OD2ER3b_B1Hy_A-1; Mon, 16 Jun 2025 16:35:25 -0400
X-MC-Unique: JRN9SmI_OD2ER3b_B1Hy_A-1
X-Mimecast-MFC-AGG-ID: JRN9SmI_OD2ER3b_B1Hy_A_1750106124
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a589edc51aso119779661cf.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750106124; x=1750710924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r9gGAo00UxhvZgMwQIm7BZfgRdhCpGsmwEG8EjxjQQ=;
 b=axQsQRLBrl58J0lNp7hos42THmTjWN8LDHdACS5kr53bQ+KhSu3hQA16R3Tja5VG2r
 PpwO/up1pCy9OvlfHuSh387qyfHqOXM2isOz5X+MZOWlv7EswS3NRqUWOFzWr2KsQtZB
 dmqWv4B+lxz/gVgUF+xtIUJWSljW8bcqqSfBsqUG42kiWx+F91Y7nwz9C97gDRIjw+yK
 h7ecL4jwvq46US1+l+4+4hyjKQH0C9rxcaqzUt0Dqkz2HB8X0vcdoGOe6KbpLeiRuos5
 HxC7PPi4VAq0X7dCwvFUdeRbu7lToizjsWlixe5TcjXeS1nLC8dNCOeU/QFPhExoe5G5
 dXlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBam5Nxgqza5oulCXrtMMKxgFGVXjY426uBr+mwikvwXABsGMIBQoBxNDyGXjsyOF98W1fn/hPdVdm@nongnu.org
X-Gm-Message-State: AOJu0YwNAJLo7nsL848D7BkFaF92nXvPoBXy9b9Vjeb4uB7ZAsLEOGjC
 xboQwayuyO8TkGBHwZRVCaZpeQxVZ7slSp7VHymOZFA7TYcvpuUpK9k+zTcqB34v0YAgTCFttHq
 Zq4s9K3onc8rVcTTPfeAQ0F1BUJRbMY4aHOfm2lJcz0Je+psBdY0HHfiP
X-Gm-Gg: ASbGncv7fj8xOpnhK7IDsaMTluWVr0JXVg15VNV4nEhzuRQc60z+Fpwi6LsH1tDzHUl
 KKUuNbQMVwC4lBWOLJQtQc7ef4b0o4xaolLgzKQG6QwO0ZXbQ25duQ6UlJAkkfcv5OfBNrLHh+s
 lAR63nYhXXynySVVD5dPlk6zQqiH0/E1rge5FGpuKekUaRpHsWhBo72+PlGRwqPWfzf+i51BH5w
 uCb5HpeDqdI4IbUcI4i7VUAY2Vp/+0mvxAnqfFHSfaowdSllNpDwoetIAHHhutTp5M9wxHTzu4q
 O5kmd8s3vfF24g==
X-Received: by 2002:a05:622a:130d:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4a73c5ad40emr170189981cf.41.1750106124393; 
 Mon, 16 Jun 2025 13:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEpY3iXRe77Sfw48RrdL+eJo47RxNAL91CjjGKCa91pzaeXboyZxXY77vIzxPpxvl5AdKjvQ==
X-Received: by 2002:a05:622a:130d:b0:49b:eb1d:18ad with SMTP id
 d75a77b69052e-4a73c5ad40emr170189241cf.41.1750106123769; 
 Mon, 16 Jun 2025 13:35:23 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a2e8964sm52654231cf.19.2025.06.16.13.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:35:22 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:35:18 -0400
From: Peter Xu <peterx@redhat.com>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "beata.michalska@linaro.org" <beata.michalska@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "junyan.he@intel.com" <junyan.he@intel.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
 "Tottenham, Max" <mtottenh@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>,
 "Glasgall, Anna" <aglasgal@akamai.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Subject: Re: [Patch] Don't sync volatile memory
Message-ID: <aFCABp9-h_iBxoKe@x1.local>
References: <7987BFFC-D46A-4BAB-8973-F30E6689E05F@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7987BFFC-D46A-4BAB-8973-F30E6689E05F@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 16, 2025 at 07:43:02PM +0000, Chaney, Ben wrote:
> Not all pmem regions are backed by non-volatile memory. Syncing volatile
> memory provides no benefit, but can cause performance issues is some
> cases. Only sync memory that is marked as non-volatile.
> 
> Fixes: bd108a44bc29 (migration: ram: Switch to ram block writeback)

Do you plan to work on qemu in the future?  If so, I suggest you go
through this and repost:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

If the answer is no, I'll at least need your Signed-off-By: line here, then
I can fix all the rest for you.  The patch looks ok though.

Thanks,

> 
> ---
> migration/ram.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f25ebd9620..e3ab67acd4 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3930,7 +3930,9 @@ static int ram_load_cleanup(void *opaque)
>      RAMBlock *rb;
> 
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        qemu_ram_block_writeback(rb);
> +        if (memory_region_is_nonvolatile(rb->mr)) {
> +            qemu_ram_block_writeback(rb);
> +        }
>      }
> 
>      xbzrle_load_cleanup();
> --
> 2.40.1
> 
> 
> 
> 

-- 
Peter Xu


