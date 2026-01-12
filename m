Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57F5C9EC8D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIRm-0001g9-Uk; Mon, 12 Jan 2026 08:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfIRl-0001ej-9G
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfIRi-0000n3-RO
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768226340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Hc+LPZXEZH9FCbiKp5+SwLUFMbUJuplxKRp1zbJ7Go=;
 b=ghaWN+k+0s0Wmgk+9aiU6VOeO4LM2Dg3GTd+QDJiKpLq1xv5RGBjm/7lRAZcPgThS6kpwP
 v30bVNuU6+TMTaCR8wgPgYxk+SSR3I7RtMqXbrdbcD/+oXN45YVyWl92H2hvg/jedpfFyh
 YL1rzpHDA9g6LnBlZWl76ymPJU9Exf8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-H7iJGWfGNsiL50O93XV3ew-1; Mon, 12 Jan 2026 08:58:59 -0500
X-MC-Unique: H7iJGWfGNsiL50O93XV3ew-1
X-Mimecast-MFC-AGG-ID: H7iJGWfGNsiL50O93XV3ew_1768226338
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdaba167so3234202f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768226338; x=1768831138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0Hc+LPZXEZH9FCbiKp5+SwLUFMbUJuplxKRp1zbJ7Go=;
 b=gQ5ZO6E1FkZMb0wrZbQtvkBNIJm90jK4TzkVGiYHGnZfhl/nnE+EHx84r5QXnqIU2i
 HjL1D5iozsZLYPdmEy1LUkPl7qgztufoeDs4b9mEKR2UyEepHMrQvPrUe5/8nrsyPzRP
 A1V6N3UITfS9XcES1XQh5M46XMRdpxQhWLl9B+CrEVnCpdK+W5el17zKNUkCpWAy5iF0
 0uH+PkS7+Ay0rKhzDWhApqn8aM7W1a0/i/SzamBPE+L1uBzTZR+DgdEXoGKUMQjs4wFG
 mxw2+ToPmbXqyjI1qiyBaiqOg/WuprvCYhm/ytYj65WPYjepwpll2w/DjD3WVaVElttf
 Z/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768226338; x=1768831138;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Hc+LPZXEZH9FCbiKp5+SwLUFMbUJuplxKRp1zbJ7Go=;
 b=Ixq9JVEZg9gCBx/Ln/dBPVQam94i3QmpmEeYVSHBEGBz0xI5SiHgO45cujaAyjjGX2
 YqtAeGOQ9eHE0NWPnwzN3Tq2qV+k7fXRIZt1uoEsHpQx1lKtsHn5ibAlFQBHh7qR4nlz
 S/S9Ah26OMPuh0JM+ElTcnYHtomWlx6CtZXN8yX1E/hjpAP/LzX1R+kUv45tXyoV+fsB
 M63PTJkdVqUTPQP62msvq/WwM8DUEwBKs8X5JYGiM9oULzSCPEfbbJ55rs5dN5YdXWot
 8K3V9LozKt+vmCfKZtNmSwKRE5EHNVQ0Uutstb01k+PFwBh8j9StONw8x5XihW/kum9F
 xrNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe7QCwwgxoGxXriu2pH0iYRtNmj5wEZFAnCIzoldVVlTwtnzHreEN4UIzN4aAn9fFAviP3x5uqKKTG@nongnu.org
X-Gm-Message-State: AOJu0Yz5D6uPFdRZIkGyc+qG6XNBSAlNLmcjL2+15eplrUjfG4g7FQ9n
 8zdv4559cMDJVZenoWhI7A9FuNDo3VZpyhAUsG2Xz0vWVZO7fzAYzSjAzP0bnAqFw3y0wnt5vNZ
 Z5jR60dxDDSB1RTdwC/r4e+iKzDLnNC6NCVgzW/4lTDEmEHuRhraNfQSu
X-Gm-Gg: AY/fxX7Nx2K0SSLhrPatoxK6LzjlZqbjbz2unE6KA8Lz0fiV+qMep2oZB4qTWtfS9vI
 HyiOjcl/7AHJAtEiwv56yLTChb/7MoghLbzn4Mha1oPyQjnVJiA7LYDz0xhwyiuZPYCp9j7j+Fq
 g6ZSn2E4JS+bx3YwISMYQgSkgqnHsJVYZBDiubDSMq7S8fHe47FfU4VkaadmZoZJf5vc5RrQJi1
 aop9qOAJqQ5haQRwZlsbb0+4PpHIre08LkKv8VbM3mZLrp3tex6ATrXDUOOPYI3q0R4VCAQ4iI8
 80+Z/JyorrgvHiqmP/8YfvKTux8FgysBowAGPKNPpyRBsM6enhecmDs7k4uDBZ1QrP4QLnkss3m
 Bic9PqZw=
X-Received: by 2002:a05:6000:2409:b0:432:c07a:ee62 with SMTP id
 ffacd0b85a97d-432c3775b85mr25989312f8f.62.1768226338297; 
 Mon, 12 Jan 2026 05:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnp8Tn3OXLklv6wPIKjq9ml4gyGr24/x6wCsYGXPeo4d8EQwRirB32wGOQ0TCj8xsASt6Y2w==
X-Received: by 2002:a05:6000:2409:b0:432:c07a:ee62 with SMTP id
 ffacd0b85a97d-432c3775b85mr25989259f8f.62.1768226337834; 
 Mon, 12 Jan 2026 05:58:57 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432d9610671sm21186504f8f.34.2026.01.12.05.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:58:57 -0800 (PST)
Message-ID: <36bbfd90-d996-4075-9041-a62c00485e99@redhat.com>
Date: Mon, 12 Jan 2026 14:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/29] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-16-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-16-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/12/2025 22.32, Zhuoying Cai wrote:
> Add IPIB flags to IPL Parameter Block to determine if IPL needs to
> perform securely and if IPL Information Report Block (IIRB) exists.
> 
> Move DIAG308 flags to a separated header file and add flags for secure IPL.
> 
> Secure boot in audit mode will perform if certificate(s) exist in the
> key store. IIRB will exist and results of verification will be stored in
> IIRB.
> 
> To ensure proper alignment of the IIRB and prevent overlap, set
> iplb->len to the maximum length of the IPLB, allowing alignment
> constraints to be determined based on its size.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


