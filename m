Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AB0C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc3yk-0007CG-B7; Wed, 16 Jul 2025 11:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc3yZ-00072M-7W
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uc3yU-0003Qx-RW
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752679391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2G7VmQZ3xC58VaCAbrR1jdBGwlvZFQHqY8eO1k1QY3c=;
 b=Siae1irB0DW0hcLdqQh3Ud+g/6TAzZOew+e9Y9M1MEyaisjw69UIee7FGGf/ALMSxDQzvq
 lt2Ri4CxclJluOb6PbtDu4V+Muh8wwT5MHLNxaAhKMjJVOCe9J4qD6uDIxnHy43JG0EYZT
 Zq1+RCkkDHInVqfX4vjtUg2ryk89tyQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-3bqZkWawOU-ah2f9rQRw0w-1; Wed, 16 Jul 2025 11:23:10 -0400
X-MC-Unique: 3bqZkWawOU-ah2f9rQRw0w-1
X-Mimecast-MFC-AGG-ID: 3bqZkWawOU-ah2f9rQRw0w_1752679389
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456013b59c1so26734335e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752679389; x=1753284189;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2G7VmQZ3xC58VaCAbrR1jdBGwlvZFQHqY8eO1k1QY3c=;
 b=g3gYwKI1Ib7uaeQsEyBZnYTYKQFJjmUHW3RWNsQdjhkHDHoE3aqY9Cw5iMy+E1Txgz
 34V5Poqd76zpunKjCDxo41UPXhYJrZWzU3sjjYV0viaLc0yyJS+h4tEm8G/zrtKX/ayI
 P0m+4CPxbe6R/eZRdS1/6M/0CE+W/ZgaZQYHX+iD62cjQgo53Fqlu2udlO8ON7TP6ZLO
 XEGI6vy8Uds1oTJ+wm2WzqD9SPfQwoSc7nfY3froQuJnZPD2yblfJ/5NYBF5clTLtiBT
 ItwLLkfiFoAKaD+c77qbEqkdAvhn75W4nAJ3IEfBsysqWDVAy42JsL6Tig5z7fGge9ET
 luhg==
X-Gm-Message-State: AOJu0YwTys48rNsT6l5OyJYTaF9Mro+IDc+m9dNrGaenjC1dKswXReMY
 x7aBPg3xwxTcsEajKymI30va1suLlD2+Hg5KAHmEnrapZXwGmPfpciLZoUb/sSCGAzPC+ZKydZf
 qMGTMbuyqZDBrCQKL3CrAcCzqevd7DSMsXt5NgNE67twjx7mjoF6sYTaa
X-Gm-Gg: ASbGncunmzOiXPZv2siHGd9gbxBXHXh6NuaSh2OUgBfr9htoZtpgtbH8WNhnK90AUYm
 XRvLJ9ui8jsSjfv3uZjAB+t5Umc0KshGTpbst9oWqhghpk1zLpbAdycWOLAELA4uEjLIrS19dRw
 mCzMNFnK5/9OFUW5BMdchh0MR4QOdMEq7a3PMWlMQP3fL8MyQjfstdmAeCfOjv8BiMbbmvIn16P
 OnUF42zu1YrIHkHQyNJQih9TNSyDY5ajfl9bc6nitt88UYiPKZiz8eX+R0WZU1UFoZNm1+Cu7Eq
 s0AUGGaM4Cvm87TzcYbCMR+iLr4upSYVBP8zGJANAms=
X-Received: by 2002:a05:600c:1c16:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-4562e33d501mr37602715e9.10.1752679389009; 
 Wed, 16 Jul 2025 08:23:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbIYTg7NdhIwhNXhVbhoAar0qr/aWDZ2TPo9lN4X0oPQYYG4CeteQZOb5pddgtatvWZ5jg6A==
X-Received: by 2002:a05:600c:1c16:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-4562e33d501mr37602375e9.10.1752679388514; 
 Wed, 16 Jul 2025 08:23:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e135sm18331084f8f.72.2025.07.16.08.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 08:23:07 -0700 (PDT)
Message-ID: <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
Date: Wed, 16 Jul 2025 17:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure on top of current git
To: Paolo Abeni <pabeni@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/16/25 16:44, Paolo Abeni wrote:
> Hi,
> 
> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
> commit c079d3a31e.

No and I cannot reproduce it.

What host is it (processor) and kernel version?

Paolo

> it core dumps with the following error:
> 
> qemu-system-x86_64: ../target/i386/kvm/kvm-cpu.c:149:
> kvm_cpu_xsave_init: Assertion `esa->size == eax' failed.
> 
> Dumbly and blindly reverting 29f1ba338baf60a9e455b6fdc37489ca1efe25aa
> and 5f158abef44c7e0945fc5f76715ef135a9bf9bd2 solves the problem for me.
> 
> Is that a known problem?
> 
> Paolo
> 
> 
> 


