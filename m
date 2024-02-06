Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B4FC48286
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXH5V-0004T6-L9; Tue, 06 Feb 2024 03:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXH5O-0004Sc-G0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:45:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXH5M-0005Se-OV
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707209143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hs/vll1tnGO2FGjeDc4AgpXNx882f9mVjyOtHfgTSPM=;
 b=H51cnkdNTy3MwDSeETm7ZFI5amBGiU8Q0kp7xOYu4paT35u2LiHL/l83zGq2Dy4b6BUf2/
 tUSn06MMq429PXBNk6f3gN7pYKenPJXuDptAas6CQt/FDKxiapPPa4HhRHhHP+OeDoOhQc
 TUUfhitYvYqDZhAVr4D6tuNQ6+KoyRg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-Pu7Kl7X8M_Sb-MYCXqeKZg-1; Tue, 06 Feb 2024 03:43:49 -0500
X-MC-Unique: Pu7Kl7X8M_Sb-MYCXqeKZg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d055407fa4so47444691fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 00:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707209027; x=1707813827;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hs/vll1tnGO2FGjeDc4AgpXNx882f9mVjyOtHfgTSPM=;
 b=F6UmT7ULYInN6Ks62PiRvrtd+nKJV090Y0jaSm4U5wQjwM9sRs/GEZNqhXteoDtqoN
 4Uo3IAzXz4L4Af1VMAR+3J1emaBSCASoHwS2+W2Fyj2MgndP5upbppkg5b1sy5xoJQfH
 IogQ2OnWL0CWd3ccbx57bog9a+1Shhbiou5b3x+Jt/diG6g0yNTqRiBVSRXUpkUecVM6
 Z9BUB/azp7gBk9z4kMdZGtU1gvBRUjccDhjZU7vHeSR2zZtnKZkJOv4xAZcQS23E7uy4
 uZ5q9nWVgHVdlMOeuTRXooMUTLI8bnQSHz/fYK+YU6g2Dr7lbQqDsJiTbSTLVMWGzqi/
 CpqA==
X-Gm-Message-State: AOJu0Yx4u2GkBJtpbkKDPfUaOZqQjcqrAmN9+aqMfIU6IxUy6wN5m1XV
 FoBb6bKJ18/wF/gpQLRPig7Ove5/hhJ/edmH4/kbBvYUETn+Jd3H0eeMMSiMkB981pknv6Nleju
 ini32vKe1fvDssAc8iV0e8wyNTYTJc8OkIg2xLcRtW4SXh5KBQuRc
X-Received: by 2002:ac2:434c:0:b0:511:3a13:158 with SMTP id
 o12-20020ac2434c000000b005113a130158mr1038642lfl.35.1707209027780; 
 Tue, 06 Feb 2024 00:43:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAm5aZDwBlKYEISoLnHgPTqtnuiwxVnWzqoj8EjBn2HUxJG7U0Gdox3cMkgVe1RTAbzqRDrw==
X-Received: by 2002:ac2:434c:0:b0:511:3a13:158 with SMTP id
 o12-20020ac2434c000000b005113a130158mr1038634lfl.35.1707209027454; 
 Tue, 06 Feb 2024 00:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU5+kU54QSY5UrY5BwTKVkLI5Q9GDPdi2wu+EZYJmDBKXlQg0jf9RxSJj0/C2qvtXYPSPB5LKhn2uRdt//yGT3EiK+q5TRcREeKOLqENucce6g5WnUMttAI3XOfFM8H/CgXEwr025SQnZ9rqM+EE5p1eQUrRpeOx6P9GT3Y3v37aJdPrqeykaZ+SXWaZHrcBw==
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 x12-20020a1709065acc00b00a3793959b4asm868553ejs.134.2024.02.06.00.43.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 00:43:47 -0800 (PST)
Message-ID: <719780b0-4a47-415e-af72-563cf62019f0@redhat.com>
Date: Tue, 6 Feb 2024 09:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] target/s390x: Emulate CVB, CVBY and CVBG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
References: <20240205205830.6425-1-iii@linux.ibm.com>
 <20240205205830.6425-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240205205830.6425-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05/02/2024 21.54, Ilya Leoshkevich wrote:
> Convert to Binary - counterparts of the already implemented Convert
> to Decimal (CVD*) instructions.
> Example from the Principles of Operation: 25594C becomes 63FA.
> 
> Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/helper.h            |  2 +
>   target/s390x/tcg/insn-data.h.inc |  4 ++
>   target/s390x/tcg/int_helper.c    | 76 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/translate.c     | 16 +++++++
>   4 files changed, 98 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


