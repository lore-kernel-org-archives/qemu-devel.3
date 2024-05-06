Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA15C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 10:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3vel-0005w4-SC; Mon, 06 May 2024 06:33:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3vej-0005vm-SO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3veS-0003bT-WB
 for qemu-devel@nongnu.org; Mon, 06 May 2024 06:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714991575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SwfIFN2LkBmHmHTsCafuIVfuvf8yJ5OhZhTTs/SVQZc=;
 b=M7mDYQtyTahXSvwLyBwTrMqGapVJ9kig1Qoqk4Mvy7Ojoi8GzqleXtdv5ZbVacKL/NCcQL
 VWXsWhQLBXEf3LFJgVUlSvEITWWvbF+wZicV6gl6SSAKPRIFUsEYI7FvagM13eLqXwHe6l
 ofebagOF/ny4sfogZLieCDR50u+hOl0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-Im6RiJVTPhOaCHXL1etvKA-1; Mon, 06 May 2024 06:32:54 -0400
X-MC-Unique: Im6RiJVTPhOaCHXL1etvKA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43d175821fdso24896211cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714991573; x=1715596373;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwfIFN2LkBmHmHTsCafuIVfuvf8yJ5OhZhTTs/SVQZc=;
 b=l2bj03vS/VLdXUyrecIiOOvmsF0o638jKteQgT6XPmx6OyPKZMlc+79nsjZyGLzokE
 rGJOMcYI4/trM8xSijG5mQgV7CHRoqP+8439yPdlq26papO29JhlNF6e6rgatBASYSgV
 Q+w8/ZZu+wE/qmSQuA8a1qrbOjsdK5cA+wAYKj3swytYkEXuleVNneuA06OP26Kg5iYS
 Twkg8QpQVKGmuSSz+YAWk6S3M7vnsDpnHQ98mceNGj/VUEFK5laIZXCN5nGY/I8Ig8Ti
 HhTSSls7lZJbLQD+abd0tMsRyVVV3m2fPYYSL45uHRs4nq9Ws9Y6sBWMSAkjtAlvd2Sd
 boQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/0bAAbqIwezjDXboJCdpy2YsUcxDGmqL+x2zYybxokIyU0K8imZbvSpkGmJBDrijoFTDTEWf5GiOVZbcYtGpI2uMICwo=
X-Gm-Message-State: AOJu0Ywo5hbErcEuDJV47iV9VmEjNYuE02ogBVlH3mPEU/eKyMEy54OO
 /hs7nuxSg0ZTdSWIMEvf+DFE501UGRVez/aL50BI+rgcgI/CnnXqYOJXqtpILBPbcPfz/Z2MWy5
 UEF5Lifmlqf+UJIRZVmyar+7C/N7/+on5nHHLO1XyFEMHu9KXpLUN
X-Received: by 2002:a05:622a:1184:b0:439:d0c9:1677 with SMTP id
 m4-20020a05622a118400b00439d0c91677mr12284091qtk.47.1714991573380; 
 Mon, 06 May 2024 03:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrVUFGRyYoAS80PcINSsxizCnF64U2hDVgwaXtvZEjMhUdOHb1GA8yGxhDHUkINOTx1aQCYA==
X-Received: by 2002:a05:622a:1184:b0:439:d0c9:1677 with SMTP id
 m4-20020a05622a118400b00439d0c91677mr12284076qtk.47.1714991573010; 
 Mon, 06 May 2024 03:32:53 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 fx7-20020a05622a4ac700b004366d3eef03sm4975123qtb.68.2024.05.06.03.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 03:32:52 -0700 (PDT)
Message-ID: <ee45bbb2-a21b-41d6-b137-ad0e736838a1@redhat.com>
Date: Mon, 6 May 2024 12:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] blog: KVM Forum 2024 CFP
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20240506101348.30469-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240506101348.30469-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 06/05/2024 12.13, Paolo Bonzini wrote:
> Add a new post linking to the KVM Forum 2024 Call for Presentations.
> Thanks to Stefan Hajnoczi for providing a draft of this post!
> 
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   _posts/2024-05-06-kvm-forum-cfp.md | 36 ++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 _posts/2024-05-06-kvm-forum-cfp.md
> 
> diff --git a/_posts/2024-05-06-kvm-forum-cfp.md b/_posts/2024-05-06-kvm-forum-cfp.md
> new file mode 100644
> index 0000000..23398fe
> --- /dev/null
> +++ b/_posts/2024-05-06-kvm-forum-cfp.md
> @@ -0,0 +1,36 @@
> +---
> +layout: post
> +title:  "KVM Forum 2024: Call for presentations"
> +date:   2024-05-06 07:00:00 +0100
> +categories: [presentations, conferences]
> +---
> +
> +The [KVM Forum 2024](https://kvm-forum.qemu.org/2024/) conference will take
> +place in Brno, Czech Republic on September 22-23, 2024. KVM Forum brings
> +together the Linux virtualization community, especially around the KVM stack,
> +including QEMU and other virtual machine monitors.
> +
> +The Call for Presentations is open until June 1, 2024. You are invited to
> +submit presentation proposals via the [KVM Forum CfP
> +page](https://kvm-forum.org/2024/cfp).

This link is wrong, the right one is:

          https://kvm-forum.qemu.org/2024/cfp/

  Thomas


