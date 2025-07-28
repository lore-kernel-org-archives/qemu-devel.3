Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20ADC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSrN-0005hv-FK; Mon, 28 Jul 2025 14:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ugSq3-0004QA-MG
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1ugSpz-0005iw-EQ
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753728274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGXzUZ510np36L63WzHTuKHobXdeDFdLmYslN2exktI=;
 b=Jc44+CdzTMqMe69QDi74qgdevxoEcATt2/B3UnvLqEyQFFgCp1M0Hrel7mZGhf16THpERV
 jm28Cxe+jkwkNYSO5m4lE+1UmV2XOKMkOCqgP0Uy7/coNi03F21xPQvC0Eai3IUjQqMejK
 A0kW6oqrIEsVl49NUX6NJdmuCiDnffY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-BejDLYE9Mt-F1lW-h-Eu8w-1; Mon, 28 Jul 2025 14:44:33 -0400
X-MC-Unique: BejDLYE9Mt-F1lW-h-Eu8w-1
X-Mimecast-MFC-AGG-ID: BejDLYE9Mt-F1lW-h-Eu8w_1753728272
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b7886bfc16so795875f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753728272; x=1754333072;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yGXzUZ510np36L63WzHTuKHobXdeDFdLmYslN2exktI=;
 b=pIzPLklO4kZw5Q2EKkoR0KwGfdeTWBWbZwe9ZnM3c+K1cRzeZqaK4sgyN/8ZKGo6hd
 Cn39G4H02cbjPYSClgVDI2aA/3GDsAmirW7e3kRVr/lDa8RyI8/pcgh0TSaUzEJ8I/AV
 KBmNFtp/lXv36AaI5tP/lQAKMFqp13qE60FMiwWOD2xPM5RcIdU/Ihxpv9znV0nE/UDI
 0j0l5GNMpN6YKEJsoHN1HmXXIHG9P/FGCU61FXp1Glz82h4xmZU6qEwlTS3W8W9n8aF8
 Uti39GBBS4jj3wVXMU7vUYSZHPVHjm47wF2CCseBmCtjERqByjjDoqqvhW/b9aJ+4FCj
 C1Uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+wv1kjHPJiexPiHa/hpN8CsDbencwy6B00zzN3SGy5ZYiTV/oYKu0Cqbm60BjtTNgtrA3m2ppcfj@nongnu.org
X-Gm-Message-State: AOJu0Yxj03LedZHf9/ETprHdkYGaxCy/NStPTAur9i0R3iwSIawBVOPL
 niC6ZgpG+eD+dddXGbsSrD37fSuTGS0UGF2coJx9Uv3txy+yeBeMAkFHQV5Hv4vdjtSrvrkdr3Z
 5CWSJLNed4saAa+FxY+/tiur81EmEGrEcGXpywj4dJw4OuW+Vs7IMA12V
X-Gm-Gg: ASbGnctw93hUpk7F0rTtrFiizW8dlEa1eZIjp5WamUCyAcFgNiMkk3C1D9Npk0dgGjX
 xxtBL9CPhCVcD04IMzMCCekCTXur8LJNmY0s9f0HfNPNYoZYcfIo/M1uzX8pK0EljOwnGq/ubkZ
 VynnGSyA5i7ZRVf8m0gtcmYpjtxU2bleaCa/ZhkwrsvA3z/yfS++BTWTAXYMnzzRE0aU2Q+8Afo
 ML3u/kHZQHcxDrv8j0Qs82+UJpg6A1gYUYZrirMI9eIKxN4M2SJOGrgx+7JfLswHrr17vR81UVA
 2c5sWSHecNjQdBIvLmIKhW6rP44qxrGqHwOVu1xvmeNb53/UhL2LqOdkisvMqYRjDILjM2M=
X-Received: by 2002:a05:6000:40df:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3b77679c439mr9356661f8f.57.1753728271894; 
 Mon, 28 Jul 2025 11:44:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtH64HmfvTqfo1lGreGCnVSOa78zwRKXUaNwgYrWnhUTZSwc32+ciZJ9NWrwDDyH5TiLGZ0g==
X-Received: by 2002:a05:6000:40df:b0:3a5:1240:6802 with SMTP id
 ffacd0b85a97d-3b77679c439mr9356647f8f.57.1753728271493; 
 Mon, 28 Jul 2025 11:44:31 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f4f3.dip0.t-ipconnect.de.
 [79.241.244.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78889682bsm4126378f8f.77.2025.07.28.11.44.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 11:44:31 -0700 (PDT)
Message-ID: <412ac05c-b293-4e86-af20-2ddd8544ed2c@redhat.com>
Date: Mon, 28 Jul 2025 20:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Silence warning from ubsan
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250728172545.314178-1-thuth@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250728172545.314178-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.07.25 19:25, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When compiling QEMU with --enable-ubsan there is a undefined behavior
> warning when running the bios-tables-test for example:
> 
>   .../system/physmem.c:3243:13: runtime error: applying non-zero offset 262144 to null pointer
>      #0 0x55ac1df5fbc4 in address_space_write_rom_internal .../system/physmem.c:3243:13
> 
> The problem is that buf is indeed NULL if the function is e.g. called
> with type == FLUSH_CACHE. Add a check to fix the issue.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


