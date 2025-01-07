Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9009CE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 21:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVH4D-0007JA-Mw; Tue, 07 Jan 2025 16:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVH48-0007In-Qc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:24:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVH45-0003x3-2Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 16:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736285078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sglF5LUGYDBAqLGOiJqEwnzkgdaZCvFOSBsd8QUtk2s=;
 b=AVlDg6lEymU9e3KIka/j3SWrpTFff5wivxOAh+IdGOhpb5aEJbjQYAptZmEMMeMoTJ95tk
 IVyvNRXzxVxMXS8FfVvyCAbhnxMLtoJTwYH3nnfPNI10TP20zPhxLkVBpjgLXlIc2cEYTn
 Bpu/ulQAIaU6fXjTM/rEvXOUrX0qUzU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-WZ-cVp2VNdG3KkvH-OoLkQ-1; Tue, 07 Jan 2025 16:24:35 -0500
X-MC-Unique: WZ-cVp2VNdG3KkvH-OoLkQ-1
X-Mimecast-MFC-AGG-ID: WZ-cVp2VNdG3KkvH-OoLkQ
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e7f0735aso2440856785a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 13:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736285075; x=1736889875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sglF5LUGYDBAqLGOiJqEwnzkgdaZCvFOSBsd8QUtk2s=;
 b=KMNOtmzhmf2mQwNA+Zt9mMb/gx/+yw5exoEKmDQiB1PWHksD5qYjYNXfCr31CnkUNO
 wMGt3fVWDZKeBT2O7e/N8ifhTfr4vYed0M4bvD6He6gPBjH4wOo6yK1tHEwGeblaMkXm
 O1y9f6NoSF70B9ryqg708kHuKje9u+ZreYj3LR40/Fwgx0jrL+wXYZ61U0f3FcFIl5Uc
 pHke2/kuojcct4vmqJ9oUwqHSEs+Eb5CupiyReUUUU3sZvm7UeK+A0qISJW3xtbVH7+U
 VAaqGpYXmNBPqRVqmgJWXCQKnEwHsMu/IzIdUglbhge4BqkzKpAtWDv3/Wiwr2rtLVzJ
 bR0g==
X-Gm-Message-State: AOJu0YzPAEYLW5Mbf6tc7Yi+f29xp6X9qvXX4FdEL9EfDBjGFvAyY01G
 W580W7Afmku0nL/QpkL4QQb4UYwsQ2+i8K8blqRjGo8fYs7Q4BY8K6ywJJQIb2jorpa9sucoQlg
 0TOC6xCfTmTr6hNw8Tt/OIljYGdNFVsrC0MbZyq0qlnLqWC86bjgR
X-Gm-Gg: ASbGnculsRFX/OTh8C4/yFOj+kJcLwbycWTS2XUaA/jmcrUtjZ8xHvidBbYI1gVCMwd
 YrgQ6G5xEe/KKTKXWvVevtWsoGp/Y3SsdaEu1hmw6KDPb1NpmhDbBduS7B5f0zMgZU8VDU25Dz4
 hY+ARScCVkQt+TgXvLEmVYykLBVMBICTaGAcHdDIEvrDNf/F52fKlAxbIxz4viqpRiA7tJrWEFn
 QC5saISwzl3C+CpqTUMGq31wzvDkaMUWQvrG7pHYwQUDHRTtFWnS3OXX7RcAqLUsUiB7AzREtuC
 eHOyCP02YJZEFziHow==
X-Received: by 2002:a05:620a:470a:b0:7b6:de8e:da27 with SMTP id
 af79cd13be357-7bcd97af67dmr49083185a.44.1736285075372; 
 Tue, 07 Jan 2025 13:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELZHZJxhjkhSDFrh6XZXG5z+vitqxQnUPP8Ta9VMKUARNGlJYGVCNXl0nanCLzNzZhHKan2Q==
X-Received: by 2002:a05:620a:470a:b0:7b6:de8e:da27 with SMTP id
 af79cd13be357-7bcd97af67dmr49079385a.44.1736285075013; 
 Tue, 07 Jan 2025 13:24:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478df8sm1628046885a.81.2025.01.07.13.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 13:24:34 -0800 (PST)
Date: Tue, 7 Jan 2025 16:24:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] migration: Document the effect of vmstate_info_nullptr
Message-ID: <Z32bkFa4snLklsbj@x1n>
References: <20250107195025.9951-1-farosas@suse.de>
 <20250107195025.9951-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107195025.9951-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 07, 2025 at 04:50:21PM -0300, Fabiano Rosas wrote:
> The migration stream lacks magic numbers at some key points. It's easy
> to mis-parse data. Unfortunately, the VMS_NULLPTR_MARKER continues
> with the trend. A '0' byte is ambiguous and could be interpreted as a
> valid 0x30.
> 
> It is maybe not worth trying to change this while keeping backward
> compatibility, so add some words of documentation to clarify.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate-types.c    | 6 ++++++
>  scripts/analyze-migration.py | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index e83bfccb9e..08ed059f87 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -339,6 +339,12 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>  
>  const VMStateInfo vmstate_info_nullptr = {
>      .name = "uint64",

Ouch.. So I overlooked this line and this explains why it didn't go via
VMSDFieldGeneric already.

Instead of below comment, do we still have chance to change this to
something like "uint8"?  Then I suppose the script will be able to identify
this properly.

> +
> +     /*
> +      * Ideally these would actually read/write the size of a pointer,
> +      * but we're stuck with just a byte now for backward
> +      * compatibility.
> +      */
>      .get  = get_nullptr,
>      .put  = put_nullptr,
>  };
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index f2457b1dde..4292fde424 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -388,12 +388,21 @@ def read(self):
>          return self.data
>  
>  class VMSDFieldUInt(VMSDFieldInt):
> +    NULL_PTR_MARKER = 0x30
> +
>      def __init__(self, desc, file):
>          super(VMSDFieldUInt, self).__init__(desc, file)
>  
>      def read(self):
>          super(VMSDFieldUInt, self).read()
>          self.data = self.udata
> +
> +        if self.data == self.NULL_PTR_MARKER:
> +            # The migration stream encodes NULL pointers as '0' so any
> +            # 0x30 in the stream could be a NULL. There's not much we
> +            # can do without breaking backward compatibility.
> +            pass

So this change doesn't do anything, right?

It'll be weird here having it "uint64" but the super().read() will actually
only read 1 byte..  I assume the oneliner change of s/uint64/uint8/ could
be a replacement of this patch, and I hope that'll work too for the script.
So we will still see a bunch of 0x30s but I assume it's ok.

> +
>          return self.data
>  
>  class VMSDFieldIntLE(VMSDFieldInt):
> -- 
> 2.35.3
> 

-- 
Peter Xu


