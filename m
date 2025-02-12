Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A728AC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 16:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiFqP-0000mN-3Y; Wed, 12 Feb 2025 11:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiFqG-0000ln-Nv
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiFqF-0003fe-6i
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 11:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739378642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NRmjn2FCKV42r37TgWqir+Va45tyQCRuwDW1ld0IbCM=;
 b=A/rrxrQX0EyeZUUpWtsJO/+mQp+CgH/ldjalVxBwNqyGAFvqRFTZUdnbepwE1NFTHWb7Ov
 tWkI9S5UModwKiXu+C/WwluVPmgA1A3KIWDSW5xinAMReT4ivnem8c36b4QUyDiclB9Rfh
 frm5lEo6eLv96j6J3/Gp/n6Qq+Kuqlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576--cx_C0hoNsKAupEX3DlyJg-1; Wed, 12 Feb 2025 11:44:01 -0500
X-MC-Unique: -cx_C0hoNsKAupEX3DlyJg-1
X-Mimecast-MFC-AGG-ID: -cx_C0hoNsKAupEX3DlyJg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43941ad86d4so18777145e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739378640; x=1739983440;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRmjn2FCKV42r37TgWqir+Va45tyQCRuwDW1ld0IbCM=;
 b=N056YQALrIfEArgqsQ/NxWREeJC16Fd+Pag156LMiN926yPEjiSbvhGSfVsjZrnFWq
 k3jTJMPIgmldtzVFOnouaYPiH8ai0Qa7A78Gk8nzaGUe54seg7qafafQW54aEFp0I+a/
 ji2uz5bMEtBep4h93DnLUC+TDVbEUo1Z7L8wHnj34PKhGkMSNOfSm32wVXuT0R5lVAF9
 oXE/ONG5OMOmx/a/ASvc66lcvtgiQLJdc3ZTavuJskdh4n1ohctZVzQYNCtcIGyr+lk7
 ve1JKgpCIND8ssoTwNv9MGaRpOyv0fGH2RbIym7nhjeSLAJhSYXU4hgZ+BOdNgX9k3zj
 soJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/U+zq6+TF2hQ4ArOqQeh5nzoVBPrOh1R3x6dO+FOlsKpmymmrBHIzhLdwaLPoDmypLjO9iW93wjFG@nongnu.org
X-Gm-Message-State: AOJu0YxcRYv9Hj23S4eUZpqnJqP+83icQWrBshhCJE0BsvHBn8a9YeQj
 jIOwrC85WTOUG6iJOyyDFQGmUUIXkr/ooOB/Noq1ikcCquxvBLI87mNiVtNDvGGYkSVs3tYEs61
 l7JFtd3W4ss1GE7VnCHqNhc418UNCxG0jZYhmKlsT5LGFOlodZb+s
X-Gm-Gg: ASbGncsufiFw8r4GZQtZE6gDlvCnI1AouV7gz9MLTZ14uywaeifhe7Oq7gU0l3mknAs
 8hr61u0JErWidthKZpy/yqua6r37qoB05fke23rGmTAQhxi8ixNLv2QxmHUgtpWM6FY6CJo+zAl
 P3DrHJWHEcsgdhlj7TVV/kSnpql3M48Vs+txNX4lACoPqXLWXvIgsdMUQrq/hqqogDH4vo5iHkv
 XyXNQs3ZKlxJwkpMcfK8rRrIbjnQ3YMPwEYBdBMdi2OCZIZGwGPHTUkUGsQ4SHZreMgE/O/NZFu
 nnqnmws=
X-Received: by 2002:a05:600c:46c7:b0:439:4355:2f69 with SMTP id
 5b1f17b1804b1-43958165de9mr41498685e9.6.1739378639830; 
 Wed, 12 Feb 2025 08:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm8DfPw7I0LAx3eBg0O30SOOQtYclyV90UafzfoAxKP9+SliopXie+ACGrBEllx/IySHS4HQ==
X-Received: by 2002:a05:600c:46c7:b0:439:4355:2f69 with SMTP id
 5b1f17b1804b1-43958165de9mr41498485e9.6.1739378639460; 
 Wed, 12 Feb 2025 08:43:59 -0800 (PST)
Received: from [192.168.10.81] ([151.95.148.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38dc4d00645sm16862976f8f.66.2025.02.12.08.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:43:58 -0800 (PST)
Message-ID: <7fe0ba58-8d91-49c7-8f93-d17f42c74fbc@redhat.com>
Date: Wed, 12 Feb 2025 17:43:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] rust/block: Add driver module
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, 
 qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-9-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250211214328.640374-9-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

On 2/11/25 22:43, Kevin Wolf wrote:
> +    /// Reads data from the child node into a linear typed buffer.
> +    pub async fn read<T: IoBuffer + ?Sized>(&self, offset: u64, buf: &mut T) -> io::Result<()> {
> +        unsafe {
> +            self.read_raw(offset, buf.buffer_len(), buf.buffer_mut_ptr())
> +                .await
> +        }
> +    }
> +
> +    /// Reads data from the child node into a linear, potentially uninitialised typed buffer.
> +    pub async fn read_uninit<T: SizedIoBuffer>(
> +        &self,
> +        offset: u64,
> +        mut buf: MaybeUninit<T>,

I think Rust doesn't guarantee no copies here, so maybe this could be

    pub async fn read_uninit<T: SizedIoBuffer>(
        &self,
        offset: u64,
        buf: &mut MaybeUninit<T>,
     ) -> io::Result<&mut T>

using assume_init_mut().

Paolo


