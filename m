Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAA6CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27Xy-0000um-0d; Fri, 26 Sep 2025 08:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v27Xs-0000tO-6b
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v27Xl-0002Iu-5Y
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758889639;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsWfiTp+l6jxmRKx/mFg7s7HJADNlxaRnHjOI9QMktY=;
 b=bjLdosLyqbhL5gT/xcVcMQe7zE/8ENsWZVXzhv3DlEGR0P3kGUqYFJ+BGZw9k5YYWOGbA2
 T8a00Vs2YtszQtCwRm+XmLQfPyMhxLztC8fOXblNrdCQYASquT7/Yurq/gzGtWA/jpW19Q
 7MMuHoOREjl9UrQYvcD4k1cdX3RNwmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-gSh87KYvOOGni-qqVtGW3A-1; Fri, 26 Sep 2025 08:27:18 -0400
X-MC-Unique: gSh87KYvOOGni-qqVtGW3A-1
X-Mimecast-MFC-AGG-ID: gSh87KYvOOGni-qqVtGW3A_1758889637
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e19f9d18cso12916945e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 05:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758889637; x=1759494437;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BsWfiTp+l6jxmRKx/mFg7s7HJADNlxaRnHjOI9QMktY=;
 b=mOcXrqxSTM8R8qVzJP1LkYc93HDtWE0QMQs/KhV2yZNMl7VzL1taAdudt42oQrcNlf
 fqAUwbYc3ECSgvG1WxniYP/nWq3COXEasN1VRCjAnZ9T12KBxIoOvIpTWQ8Nt53HLrgN
 q4yKtJfQhi0iB9svWDhWp1SOtkDw7BwSehJnRiqvEAl+P/MkFAIu38uscQ6ETX2IUAUy
 VCRttJzXu/ovyH9NQo/UOHWjZckgT6zrQCDfSoz0bY7/CVU34+IeekT1ZDsdswjK4rpf
 oebWJFSKTNOkjeG4TfymF6Mrc8HDXNqdjYhv1ENAnafoMB0/JbFfUDWTM31slphLzPSM
 dWTA==
X-Gm-Message-State: AOJu0YwuAhqSgNpqb0HHlpPJrpv2oEwx+DlZNUV9Q0i9W/MREq7+Ll9I
 x6FsWXz7HcJjap82zYd5cMeHFB/BLBiz0PR7Q0cUtPjW2orxI8daP4VbF4t8GcbbVswq6hHhbGb
 v5YWUz97sFy/sp7X6k4Q8W3Ur8i8ThMJYJUk8NTCdqvRpqrMhtXX9RFmv
X-Gm-Gg: ASbGncuqElB6S2jxaSqQDLIcbnsGp8NMc3+0egs/C/A1SLkZYDk+KgVQwExFv9PMY/B
 wgX8qWLU+Q1aypC+Giizh07ist8XC6jYatjcWsR3TwTamCVtO5HPF1ftSD9LFkPBc26gL3qz+4F
 RonrcUYS9RmViabd708X86w+XlYXE/D1WhKID7W8CZjOiw9jVIjVtXwckdtbqCCngBVaG/T7wTk
 oWni02sGAEKm+uPTMSX8k200wcshIi6J6GsIDAlDHoAvRNDeOvNzTLoE0baOtIrIkQrzCXj8NgO
 TL33L4Si1Wl6bVzoYSsiQVVero6wu5PZ+8N33m7fdf4jfGwgGvWgREeQdJqLeEGtUdkicJDDnpC
 N1nLX15EZBMY=
X-Received: by 2002:a05:600c:3b8a:b0:45d:98be:ee95 with SMTP id
 5b1f17b1804b1-46e329a0df0mr74371575e9.3.1758889636756; 
 Fri, 26 Sep 2025 05:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSTDtzG5lTwrRQ2l7PFh+Jcwu+dXxQe88IZDYOuL++BTvXKFBG+saGCGH0bLAFaV1s4PJzuw==
X-Received: by 2002:a05:600c:3b8a:b0:45d:98be:ee95 with SMTP id
 5b1f17b1804b1-46e329a0df0mr74371295e9.3.1758889636311; 
 Fri, 26 Sep 2025 05:27:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb017sm6897468f8f.3.2025.09.26.05.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 05:27:15 -0700 (PDT)
Message-ID: <89cb92fa-7049-4e41-a34d-29f5ebbcdcab@redhat.com>
Date: Fri, 26 Sep 2025 14:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] hw/arm/smmuv3: Correct SMMUEN field name in CR0
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>, pierrick.bouvier@linaro.org,
 philmd@linaro.org, jean-philippe@linaro.org, smostafa@google.com
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250925162618.191242-3-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250925162618.191242-3-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Tao,

On 9/25/25 6:26 PM, Tao Tang wrote:
> The FIELD macro for the SMMU enable bit in the CR0 register was
> incorrectly named SMMU_ENABLE.
>
> The ARM SMMUv3 Architecture Specification (both older IHI 0070.E.a and
> newer IHI 0070.G.b) consistently refers to the SMMU enable bit as SMMUEN.
>
> This change makes our implementation consistent with the manual.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 516f2ffa75..71a3c0c02c 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -116,7 +116,7 @@ REG32(IDR5,                0x14)
>  REG32(IIDR,                0x18)
>  REG32(AIDR,                0x1c)
>  REG32(CR0,                 0x20)
> -    FIELD(CR0, SMMU_ENABLE,   0, 1)
> +    FIELD(CR0, SMMUEN,   0, 1)
>      FIELD(CR0, EVENTQEN,      2, 1)
>      FIELD(CR0, CMDQEN,        3, 1)
>  
> @@ -182,7 +182,7 @@ REG32(EVENTQ_IRQ_CFG2,     0xbc)
>  
>  static inline int smmu_enabled(SMMUv3State *s)
>  {
> -    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
> +    return FIELD_EX32(s->cr[0], CR0, SMMUEN);
>  }
>  
>  /* Command Queue Entry */


