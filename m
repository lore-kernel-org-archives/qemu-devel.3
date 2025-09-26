Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D75CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27v8-0005dX-Hg; Fri, 26 Sep 2025 08:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27v6-0005dE-Ta
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v27uv-0007jS-0y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758891068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UZwPR8KjezRG8M2r0uya15bF5b7eCBWA8imat/ch2H8=;
 b=YTU/6IL2pl8pIWYx6/0YaOE6QSZfV7PmyK6uB6q6GTKU6Jl9gyXmzoisNQJKzyzMRKhc2v
 iBLkfsQ0Kuj0TtJtzG/an0ooYwHFeIifkeGd+DHYaS/ZYrL0qYSTqy73UM4XNB8q2+rH77
 aVfe7Rfz54PpLkfAUzRJqkDpYzDfDoc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-l03SlJ3KMuqIstU4sqKkIA-1; Fri, 26 Sep 2025 08:51:06 -0400
X-MC-Unique: l03SlJ3KMuqIstU4sqKkIA-1
X-Mimecast-MFC-AGG-ID: l03SlJ3KMuqIstU4sqKkIA_1758891066
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3dcb36a1so5050735e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758891065; x=1759495865;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UZwPR8KjezRG8M2r0uya15bF5b7eCBWA8imat/ch2H8=;
 b=TfJsMJ7qsTrkAq1L/4tmbkclV70SvRq9s4IYLDOiJj/owBUeW2Re6qJ6yEFw81jcOD
 u+RxCamwBt9mij2wePjXWfsO3wah2NPVeNUBC0gVmbC00BaXcBB7LnPT2dLo0hCQzMkc
 hmzrjr+z2f6ELKDuUEI13nDeaYe8I3QhWLOMwRZExGanmUVuhHoJ3rYxnx88osiVmhh2
 2ibvPooV1s+97mTAPXCa6oMQoa+JLFMAjz94Uq1fZYu9Qj+Qalumbuu4KRgMKeogrVsM
 J8JMTHicfdNpr0N3/fhNxlsTcuWWjfSvBl4N7SbPp3EmJU/oGCbkEgTkq7ENlZiBzPxX
 vJhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhuXQYmhLuygSNT/sxkakqGKmfN1xRyAAtUcly1zJdr5EUpFHqv94EMitxTJRr3pG+4rIrij2a0m+B@nongnu.org
X-Gm-Message-State: AOJu0Yxd5Nich5db6zc8CHcZyJs/obYyLn+o6RMni7VoqsWWbGDpgvwo
 xL0taGpTb/O2BP8gvKzxHHEXxCFBuGlKWHZ3fhFriUtTgbUOee+TyYWXRHrPBqPekfrqOwvNEPt
 WRd9fC3HPfDscxXtwfpF4WAf6thNWJznOlvCs22698NP0IynBevXsRqJV
X-Gm-Gg: ASbGncsmPcSOGNkhegS6c5cCvG3Gc1L1FSMjRXiNcODm8NW/7jleM8tPV6r5Ubg26Xq
 EH+/Y772YwlpcFDIvqJM1r/7tQWeSxlBcbraYYjCiTNU3kJzIX1Z0OImlsGVQTvThx/+eIBKRnt
 VNqXrC95lp0Ocj0+qhxi8MyQhCa6vGaAfMagZCbAJq+aVkSdLjdlNG/p41IZ49Ys7OMYKFBeeT8
 QpgFXLvy2dh/FN4cTe8AGkCdj5x6QI8LjS8woUvdvHd3i+AhtkguUnO0re6Nw66p8YQWWHTjPzU
 nJQc2YiNF3jq9PbuGdRXkL64mPF/RW3N2skUQwokV6RkG8f7lvtd6O0DVHThxfvN3QD4KWkZ/9m
 /GdxAFg==
X-Received: by 2002:a05:600c:5486:b0:46e:27fb:17ff with SMTP id
 5b1f17b1804b1-46e329d47e4mr60798965e9.2.1758891065487; 
 Fri, 26 Sep 2025 05:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpd3yu5PaCQyaRutYhYSmDCnqcnbDz6f6go242komNFGl/zvyANmgTg/b2xdWdG7sNB97ntw==
X-Received: by 2002:a05:600c:5486:b0:46e:27fb:17ff with SMTP id
 5b1f17b1804b1-46e329d47e4mr60798585e9.2.1758891065002; 
 Fri, 26 Sep 2025 05:51:05 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab838b6sm115182885e9.24.2025.09.26.05.51.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:51:04 -0700 (PDT)
Message-ID: <a651058e-5559-4996-a281-f51b8d8887d6@redhat.com>
Date: Fri, 26 Sep 2025 14:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/28] pc-bios/s390-ccw: Refactor zipl_run()
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-18-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-18-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> Refactor to enhance readability before enabling secure IPL in later
> patches.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/bootmap.c | 49 ++++++++++++++++++++++++--------------
>   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 0f8baa0198..ff0fa78cf0 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -674,6 +674,35 @@ static int zipl_load_segment(ComponentEntry *entry)
>       return 0;
>   }
>   
> +static int zipl_run_normal(ComponentEntry **entry_ptr, uint8_t *tmp_sec)
> +{
> +    ComponentEntry *entry = *entry_ptr;
> +
> +    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> +           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +
> +        /* Secure boot is off, so we skip signature entries */
> +        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> +            entry++;
> +            continue;
> +        }
> +
> +        if (zipl_load_segment(entry)) {
> +            return -1;
> +        }
> +
> +        entry++;
> +
> +        if ((uint8_t *)&entry[1] > tmp_sec + MAX_SECTOR_SIZE) {
> +            puts("Wrong entry value");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    *entry_ptr = entry;
> +    return 0;
> +}
> +
>   /* Run a zipl program */
>   static int zipl_run(ScsiBlockPtr *pte)
>   {
> @@ -700,25 +729,9 @@ static int zipl_run(ScsiBlockPtr *pte)
>   
>       /* Load image(s) into RAM */
>       entry = (ComponentEntry *)(&header[1]);
> -    while (entry->component_type == ZIPL_COMP_ENTRY_LOAD ||
> -           entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -
> -        /* We don't support secure boot yet, so we skip signature entries */
> -        if (entry->component_type == ZIPL_COMP_ENTRY_SIGNATURE) {
> -            entry++;
> -            continue;
> -        }
>   
> -        if (zipl_load_segment(entry)) {
> -            return -1;
> -        }
> -
> -        entry++;
> -
> -        if ((uint8_t *)(&entry[1]) > (tmp_sec + MAX_SECTOR_SIZE)) {
> -            puts("Wrong entry value");
> -            return -EINVAL;

So in this case the code returned -EINVAL ...

> -        }
> +    if (zipl_run_normal(&entry, tmp_sec)) {
> +        return -1;

... but now it's always returning -1.

It likely does not make much difference in this case here, but it's 
certainly better style to preserve the error value.

  Thomas


>       }
>   
>       if (entry->component_type != ZIPL_COMP_ENTRY_EXEC) {


