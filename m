Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6827C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmA0t-0006KX-9Y; Mon, 18 Mar 2024 06:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmA0r-0006KK-Bo
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rmA0q-0007MP-0C
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710756875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rd0mlqKV1h+bex2zyLd3Kqfs5evAE28zEo/PAE3sths=;
 b=D8sKwccyRvTvwNrTsRJOGDiuQ5ijmkQ3BnHQ/+Oyz/UA16HPJUhEG0YqdUnzrCToxhxLe/
 +LYJu7NBpqtd/g8L8ZI2nVi9Btw5eu1LR5SSyIawyk8cENPLqHYLgdZORlqIIEkSdDn3WJ
 P398T/zo9vTgQVu21M8Za+90ZwoORjU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-S0Hh6ECDNSKgLMyvXWXZOQ-1; Mon, 18 Mar 2024 06:14:33 -0400
X-MC-Unique: S0Hh6ECDNSKgLMyvXWXZOQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ed489edcaso1473749f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756872; x=1711361672;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rd0mlqKV1h+bex2zyLd3Kqfs5evAE28zEo/PAE3sths=;
 b=U0WKL/CGVSY9o4ukxlNE6fPfj3jTIPb9hbItSNVHFn8h8u6fstAffRpM1Z97cR33vJ
 JGOqSj9mfCRzzvIZtft52WVQ6fjgjVmu6gIt+ohGUr1ipdUGGY3jH/VY9meSCfmV4MaO
 2FiqjNjY/qfYXLSumXBJDA1VPNimOFDLPVF7G0N1HoKSBAL3GH+SRKJ5TfC+AYCis4FX
 AcIlh8hnLKu9epSKEHNzjnGke79zHhZ5JTAv2CySSQCU6uX5uVvwHbVRTwgGt2se6P5j
 SfDQ6Ah2kxZbPwYeGRC+Sm7cBFR89Z3+MEH7aR3W+//oPpKnq7joUhWwK6zBAmf4EJ26
 VJoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRkbA6ajLuW6zMgfQhcfq0Ur12HbJIlpxf+z2yu+TE164xkvfsUfEHW2WSFFuOhkqOmPNiq069EU0nQaS4+1R1wx2DAS4=
X-Gm-Message-State: AOJu0YyqAII2dvdpoZ/pZdCULRcdOL6mLqMrNOlIchSGId2vc2Uczj0Y
 DCUA5o0xXWG537hT6GZ2nPoIm8+tgGwrR2P8f7fCVS9LRBOFVuNMFH40OtaSOQvq362hwHO/u24
 nTZEpOUaTtSucuRwXdLc9pyugaHwJWlKcpIXe8FgToQAGvM3SWirSNTaTAEwK
X-Received: by 2002:a5d:6dad:0:b0:33f:8e6d:ab6f with SMTP id
 u13-20020a5d6dad000000b0033f8e6dab6fmr4547856wrs.62.1710756872555; 
 Mon, 18 Mar 2024 03:14:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUHg8L2kFvGr3Pb94NLexVS5RFlQ8hXTRgka/mbkmDVrfQoJWOHoCgC0+F/VMI0pYdpDGGUg==
X-Received: by 2002:a5d:6dad:0:b0:33f:8e6d:ab6f with SMTP id
 u13-20020a5d6dad000000b0033f8e6dab6fmr4547847wrs.62.1710756872193; 
 Mon, 18 Mar 2024 03:14:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b?
 (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de.
 [2003:cb:c737:1f00:94ff:246b:30d0:686b])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a5d45c8000000b0033e7715bafasm9429944wrs.59.2024.03.18.03.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:14:31 -0700 (PDT)
Message-ID: <57c8506e-3f6a-4d1d-9720-c9b030781109@redhat.com>
Date: Mon, 18 Mar 2024 11:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] system/cpus: Fix resume_all_vcpus() under vCPU
 hotplug condition
Content-Language: en-US
To: Keqian Zhu <zhukeqian1@huawei.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
 jiangkunkun@huawei.com, salil.mehta@huawei.com
References: <20240317083704.23244-1-zhukeqian1@huawei.com>
 <20240317083704.23244-3-zhukeqian1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240317083704.23244-3-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 17.03.24 09:37, Keqian Zhu via wrote:
> For vCPU being hotplugged, qemu_init_vcpu() is called. In this
> function, we set vcpu state as stopped, and then wait vcpu thread
> to be created.
> 
> As the vcpu state is stopped, it will inform us it has been created
> and then wait on halt_cond. After we has realized vcpu object, we
> will resume the vcpu thread.
> 
> However, during we wait vcpu thread to be created, the bql is
> unlocked, and other thread is allowed to call resume_all_vcpus(),
> which will resume the un-realized vcpu.
> 
> This fixes the issue by filter out un-realized vcpu during
> resume_all_vcpus().

Similar question: is there a reproducer?

How could we currently hotplug a VCPU, and while it is being created, 
see pause_all_vcpus()/resume_all_vcpus() getting claled.

If I am not getting this wrong, there seems to be some other mechanism 
missing that makes sure that this cannot happen. Dropping the BQL 
half-way through creating a VCPU might be the problem.

-- 
Cheers,

David / dhildenb


