Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20957C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 13:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuAj2-0001Yy-AY; Mon, 17 Mar 2025 09:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAim-0001W6-O7
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuAil-0000k7-2D
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 09:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742218892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QqfwtvlblDJBk8WUeg9UYrPs059izbFi06n4mzryQ5g=;
 b=MIvyPBnl9CRQ4PowbIh1mCKQhIlWEf00/MSWAibSVspGyRlnKWFK4mx4nH0Iey3x/8PUGd
 rf0MUvjQJDfDLmbwg7JQRRcgiTRv0FBAD2sZKreV+je0s4ZbuQJBSfBU/Bgy/BSLUZq2XH
 d64dTC1V8siK7MOmEF7PUihwFsebnoA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-uP3YFhJQOH6k6dbPMiDL2g-1; Mon, 17 Mar 2025 09:41:31 -0400
X-MC-Unique: uP3YFhJQOH6k6dbPMiDL2g-1
X-Mimecast-MFC-AGG-ID: uP3YFhJQOH6k6dbPMiDL2g_1742218890
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so1860191f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 06:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742218890; x=1742823690;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqfwtvlblDJBk8WUeg9UYrPs059izbFi06n4mzryQ5g=;
 b=wRjpnLJsSTfEVg8dZplko5gry8qE7pAcDjRCCHsRfQfzlOfQ7nfvaNk5UuvgXZy8Je
 34tH4rpnjioMB+XZYVazfgmwSC1bX+SC/F6xf6QVDMJAFI6cW9a3j2TeJOwes3pni1Yy
 uru35U3H5VY+qbJ2ZI+73C/kCw5u1xmQA/tuh8j2sIEcRNajs7vgYQYzfFoHzYv+wzJR
 PRbK1FMbJsz4EX9N2938Hj1ZbDt2uiTVrMHbtH/Pqcb4yEqKsp13nuLVPUWQcy0crLuu
 8h5WX9IkuCA23cCwQburHN3Fov5x46vD/yW5V8Wu83yOSh4hf+xhS4KhNKuNkLZReX2S
 pBkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxkpCLKJMVVNvTaG4v4HV1QTMCeqhlk3JEta1lYPDb4MYKByUvIvB7j9zdGzWXMuRXkSVgEgDLNbP@nongnu.org
X-Gm-Message-State: AOJu0Yy/P6VTeuFkm7DJ29N28xSgJiuQM1xVacPAFqpRcekL3XiLfTDm
 og0/mKyZtY2lZDUi4gTNEfYyoEzElfZXdg5SphWIjK7voVVoScf9wpW7/VUR5CxpDl5FKCzpemI
 bNEBM4yDCco1nOj+hw8a/MepCUQexqLq/USD5TfKUjXpA2uFu9oJh
X-Gm-Gg: ASbGncu44jettX6+DFvBvi91u46G9crZZySPG9GS7EWkHw42w/5bp9LJB1W6mDLgude
 HQLWgFgwXV9618JBSbS+HZ/ewOgLsl8B4nxfeep3ycy0WSVqZjkpW/O04g47//n9GztKSk74soo
 HWmENi/PS3MNmf66WX6KA3HV177qAXfGGg4QS4THNoIjfY1QOORsyLBz33mbFkD4s0bUOGeZkZ7
 odr7qFVe0K5PZsXbNsWfkymk6StrxDU7K/+VOJqaAyo9ug3fq6147V5dCGxMGUfadZNntKBbH4K
 E2B6zMGKuAAof7WwiAFfHg2QetOTa0BaW+eeKDJAVGyTA4Y=
X-Received: by 2002:a05:6000:1acb:b0:391:3406:b4df with SMTP id
 ffacd0b85a97d-3971d9f0e43mr10555913f8f.20.1742218889965; 
 Mon, 17 Mar 2025 06:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAF1+x1HycAfyO3vhtywQPqUueewhvtliwc45br8x8/quXxEbW8bRKeEEX5sFjSAw0MpCTEg==
X-Received: by 2002:a05:6000:1acb:b0:391:3406:b4df with SMTP id
 ffacd0b85a97d-3971d9f0e43mr10555895f8f.20.1742218889563; 
 Mon, 17 Mar 2025 06:41:29 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb40cdc5sm15031349f8f.80.2025.03.17.06.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 06:41:29 -0700 (PDT)
Message-ID: <f2168937-5252-4e91-80d6-2ad344f443fa@redhat.com>
Date: Mon, 17 Mar 2025 14:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] s390: implementing CHSC SEI for AP config
 change
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, clg@redhat.com, akrowiak@linux.ibm.com
References: <20250311151616.98244-1-rreyes@linux.ibm.com>
 <20250311151616.98244-6-rreyes@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250311151616.98244-6-rreyes@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 11/03/2025 16.16, Rorie Reyes wrote:
> Handle interception of the CHSC SEI instruction for requests
> indicating the guest's AP configuration has changed.
> 
> Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   target/s390x/ioinst.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index a944f16c25..f061c6db14 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -17,6 +17,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-bus.h"
>   #include "target/s390x/kvm/pv.h"
> +#include "hw/s390x/ap-bridge.h"
>   
>   /* All I/O instructions but chsc use the s format */
>   static uint64_t get_address_from_regs(CPUS390XState *env, uint32_t ipb,
> @@ -573,13 +574,19 @@ out:
>   
>   static int chsc_sei_nt0_get_event(void *res)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_get_event(res);
> +    }
> +
>       return 1;
>   }
>   
>   static int chsc_sei_nt0_have_event(void)
>   {
> -    /* no events yet */
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        return ap_chsc_sei_nt0_have_event();
> +    }
> +
>       return 0;
>   }

  Hi!

This unfortunately fails to link when configuring QEMU with the 
"--without-default-devices" configure switch:

/usr/bin/ld: libqemu-s390x-softmmu.a.p/target_s390x_ioinst.c.o: in function 
`ioinst_handle_chsc':
/tmp/qemu-mini/target/s390x/ioinst.c:587:(.text+0x1ce1): undefined reference 
to `ap_chsc_sei_nt0_have_event'
/usr/bin/ld: /tmp/qemu-mini/target/s390x/ioinst.c:578:(.text+0x1d1c): 
undefined reference to `ap_chsc_sei_nt0_get_event'
collect2: error: ld returned 1 exit status

I guess you have to rather use some callback mechanism, stubs or #ifdefs 
here instead.

  Thomas


