Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4C2C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYki-00066q-Jw; Thu, 13 Feb 2025 07:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tiYkd-00064M-Ut
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tiYkc-000854-EA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739451328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=34aDo8ciuIjSIrc1HEIigZQAB0/DFvc2KzKOnsg2A9A=;
 b=YZca+NpSrJnoDJ8eeGioNdemu6QSlxvLrspV6TzdxIIvXBFHtz89vzeESILmzdNwiFkCKt
 OBZURgSZt7fWAmZkweglyZ9uPXRh9dAsPX+SaC6E9AaQXoad5ytKNbuf/z6Wz3hNm3prAH
 ZBDwtlvu2tEpmnY9q6GG3w2JmXtxcIQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-lXtGVy9ePf-JkoaNHX0Xrg-1; Thu, 13 Feb 2025 07:55:26 -0500
X-MC-Unique: lXtGVy9ePf-JkoaNHX0Xrg-1
X-Mimecast-MFC-AGG-ID: lXtGVy9ePf-JkoaNHX0Xrg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so6501425e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739451325; x=1740056125;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=34aDo8ciuIjSIrc1HEIigZQAB0/DFvc2KzKOnsg2A9A=;
 b=dva67hCnKGrQApVPRjHO0oCBRBkW5Uzk9sUOcuYYhha59rfPwsoHiPoIJG0eyuDul2
 fwY3RKQDANE+dnVf5NhipNAGrc6H8clAgC89YaoP0jFXZozfJykArdi/rP8n1IUw9wI7
 S6Zb7CgB84QCSo4G/iF/4R7qAwq13qV1svoFUnu9czskJpQwQZoEdHMTLY35PuIlYoy1
 xo2gFitrYm3j8bPdN6MOgV8sKr38s83ao/3uv9B6JGRkxZkfUXjX1QMYcQ7Tq0XDci2q
 uBHhlpVUWBmcqM9A1uh8REdty/xzJFesMOE1YKVSVIOsXYFsj8RC82hHV/omDMGFucRt
 X0uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk6Um4eP6+zZ6+FYHGMqt9A2cQzD62RhstaffPmJlBEsI60m5cu+2cvmhqTuVyWnlcmZSMaGoAHHub@nongnu.org
X-Gm-Message-State: AOJu0Ywesl9jl2UfhT5JE6pnzZQx+1mKhTB2yXXwli4VsrqR8MlifjI3
 zY0RbEgz2wtLhdfVA4aqUbeJk3HZVmfepBEz77+QNGyVhu6UAjVp5BqgqLqECtARCEj0mTHPCL1
 4TqYV1anewfYO4tg7OG/IY9xCHM/hx9aHI1FGEAFUDXwr/AHIIccP
X-Gm-Gg: ASbGnctccHntxLr4lj0hCfekfvnHFI2G+SQiAUwrHjntbH4J/J5JpGSf7W+ka66ETcl
 rTove6NVT1CgCrSBBBiGzOT7ESUECZwBHAseJFX5NT95Azx6lXVQdAEX3UTsAfTjW1C0I0clvE8
 VHQm+JLVZwZwowg861sBjoJdYpEU3tz99BD8LH+Ka++GLxBVNUPgZp3ZSmxfFW+sgCnzpI5Cs+D
 FR/i20hrELmY5jrLhzy+xptrcUnVngTwDvbadGchjrSU9NNw5X9/2QkWFUknkOkBHi9BkR4Jpl2
 zsl5que3tywzZUAhkRBFc/X7KqXMo/aB+YcOCzMnb6pDxSa3PfINKmFP2wCRJloAaC6Ap1K+oQB
 mtnkGWBpnCe4C9z2OELz9aXqWAmkTdw==
X-Received: by 2002:a05:600c:1d9b:b0:439:60ef:ce88 with SMTP id
 5b1f17b1804b1-43960efd0aemr28660155e9.23.1739451325557; 
 Thu, 13 Feb 2025 04:55:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSDrqniyt5fMAAWMSitV//U4tinpx9mjKyxJxXd4lJPiH0usApshznBMYNEoZeXECMv1t3ZA==
X-Received: by 2002:a05:600c:1d9b:b0:439:60ef:ce88 with SMTP id
 5b1f17b1804b1-43960efd0aemr28659905e9.23.1739451325160; 
 Thu, 13 Feb 2025 04:55:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:100:347d:db94:161d:398f?
 (p200300cbc7180100347ddb94161d398f.dip0.t-ipconnect.de.
 [2003:cb:c718:100:347d:db94:161d:398f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f22fsm48032635e9.5.2025.02.13.04.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:55:23 -0800 (PST)
Message-ID: <da153767-f9e3-49f3-9462-e625b447ca3e@redhat.com>
Date: Thu, 13 Feb 2025 13:55:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] physmem: teach cpu_memory_rw_debug() to write to
 more memory regions
To: Stefan Zabka <git@zabka.it>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250210084648.33798-1-david@redhat.com>
 <c36fe3a8-9541-4775-a538-91eeb9d6e3a3@zabka.it>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c36fe3a8-9541-4775-a538-91eeb9d6e3a3@zabka.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On 13.02.25 00:26, Stefan Zabka wrote:
> Sorry for the delayed engagement, I failed to apply the patch set from
> the mailing list and had to remember that David had published this
> change set on GitHub.
> 
> Tested-by: Stefan Zabka <git@zabka.it>
> 
> This addresses my initial use case of being able to write to a single
> MMIO device. I have not set up a scenario with an interleaving of
> MMIO and RAM/ROM regions to ensure that a single large write is
> correctly handled there.
> 
> Reviewed-by: Stefan Zabka <git@zabka.it>
> 

Thanks a bunch!

> I don't know if this counts for anything, but I've read through the
> entire patch series, tried to make sense of it and couldn't spot any
> issues. It should be noted that I am a terrible C programmer and have
> only written basic devices so far.
Hard to believe ("terrible C programmer") :) Any review is appreciated!

-- 
Cheers,

David / dhildenb


