Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775A1C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 18:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKMB2-0000Ob-Aq; Thu, 20 Jun 2024 14:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKMAz-0000L0-TV
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sKMAy-0007Dj-DW
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 14:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718906782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=W6s8Ymps8X6Fgc/XoR6+DRMYUMxCvawAMps4ZSLtNDE=;
 b=Tmkg+4tgIPFS3iZSSjsY37SYDd3/fN0CWiCAP4fA4fM/SeH9OmcKBrE3dfKXEP5+oUq2NX
 3K4HWPMuUmYuICA6CK+YDEIiBpG8k6hkO0unBME2J/Ns1wO5K75PUa5tASiMxQJDTuj9ls
 Sjh1HPg1QxueQVQqP8LHCZn+qlkAiio=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-jLJTkc3ZM8m6jh5fMqdnvg-1; Thu, 20 Jun 2024 14:06:21 -0400
X-MC-Unique: jLJTkc3ZM8m6jh5fMqdnvg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a6f381ea95dso121389366b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 11:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718906780; x=1719511580;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6s8Ymps8X6Fgc/XoR6+DRMYUMxCvawAMps4ZSLtNDE=;
 b=nIf3HO2oOp99wfVHCnxP5G/YsI8g0AHzMnTaBFXwBGwZK0RNx9qXcviFOUwb+e97pU
 zTHS+LFwywyKQGONaynP4+pPS2Nn4h62iDenqtPsNwTfM6uRP/QGtIbMUxAdAUcw346a
 hIm2Kh572LgThkC04olZz90MChRIafJFZorceneIzIRFzMxbQuumbRhBBTrvxW7O04yu
 D1PaIhRQm2zn6jbge9/SDMgBhw9P4ChXp+B2AowTvBj8ilyRefTlOJ3QPYc3tn6wg+4M
 pycZmyExMbozUehD0BXC7j2tXV4U4OYPj/uwcVv4a9FOPUXFo61ySlpVqesT+yDKrzx6
 kEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrIhE6JBZ1az9nuuI6cajHYzF9cADMRlqJZqfQtmr49ciFrGQW5tQApGaqtMKygHZJbcjUuqq1GO8Tt6D+OfFUvFov3O4=
X-Gm-Message-State: AOJu0YxCVkHNy2WfZ3UpEtxed1C1CJf1YG8d4wQKgy7Oa1Na/y+WM0o8
 tG+1tl5e9rTyp7UG0ExpK55JrRNCYBe3NH7nlay1ogKpoUaoqJBNLD9GgRVucemGQGenBHykWT2
 J0pzsmeZr0t15rCyAo9MAmag4w2LLZbS2y7rZm7Cfpkik26lhsftV
X-Received: by 2002:a17:906:6890:b0:a6f:377f:5c0e with SMTP id
 a640c23a62f3a-a6f9462bc1dmr646142466b.0.1718906779920; 
 Thu, 20 Jun 2024 11:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyOPVmt01FcCRrqggc5Ss8khB73oVzpRuiHGgdCJUDnzsCJkBwPQdEmkAuTBMfK7VgIquC0Q==
X-Received: by 2002:a17:906:6890:b0:a6f:377f:5c0e with SMTP id
 a640c23a62f3a-a6f9462bc1dmr646141066b.0.1718906779502; 
 Thu, 20 Jun 2024 11:06:19 -0700 (PDT)
Received: from [192.168.10.81] ([151.62.196.71])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa416asm797332366b.224.2024.06.20.11.06.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 11:06:19 -0700 (PDT)
Message-ID: <4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com>
Date: Thu, 20 Jun 2024 20:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224604.879275-1-rkir@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240618224604.879275-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/19/24 00:46, Roman Kiryanov wrote:
> void* pointer arithmetic is not in the
> C standard. This change allows using
> the QEMU headers with a C++ compiler.
> 
> Google-Bug-Id: 331190993
> Change-Id: I5a064853429f627c17a9213910811dea4ced6174
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Would it work instead to declare MemoryRegionCache's ptr field as char*?

Thanks,

Paolo


