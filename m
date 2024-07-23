Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 00:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3e3-0005mw-Cn; Mon, 22 Jul 2024 20:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3e2-0005m4-2W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:44:46 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW3e0-0004a7-E4
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 20:44:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fc2a194750so931535ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 17:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721695482; x=1722300282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7sXlLBuUoV9FCxzFNBdP6x9cnPnW0IWm/0/GHx5GwcU=;
 b=GbGzdtJY80czUqlaDLHOyVL/aIsl5cGWZNJd3O9dxgWFQocS6csW6zXaAFHTSL391A
 cEW6ihD4wSNSpDJJTqMSs60u9lvHcKzuO+BX0iMhc1TYelrUjy8nGBVZ2jz3/Af2ZDZE
 mPijsoEg7t/4x5sZbBhbGvLwkKrl6+BOIa4ZUqZ3UY106504oaKrHv94mVt0g4NevwTZ
 zxyv/dcNESIz1f9NA3cJFUzemmrjBjkUnd7kVU2Yts5kxQSl2Jt2/e2/AAlLXAwtz1IP
 NQrMSYzP2XOhrW6iYIIEN2SFGQvdpy8idOKF/Y7PxUjQjXZo6vhI+GLyfuNdujAlm1Uk
 ssfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721695482; x=1722300282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7sXlLBuUoV9FCxzFNBdP6x9cnPnW0IWm/0/GHx5GwcU=;
 b=hOLYyfLif7COE8G3sUM5wsO//0NiKnfs5whNOwMN1ebSlCiX6XLXs2piOW02EeUT4p
 LtbMUglFpDhzkpNnfYY7m1Y8xYAU1ZD47fA+OvoH58sKZ3PtntCjlpi3Wv5vB1HuzKMS
 6SZYHo/65YCRAYwE1q2PgyX2Ur7gf7twqyJA3eeaTFlWBqVBQ+714GqU//HseKqh22Pu
 56qI6WjIJed8gtyQfcFqXxLE7S1ynRH/ZWOyS0WeNYXhPOfl2F/5SPYkf8bxOwhzazC4
 wVZbobgWLYQ35PYFKYoJYA9wFeqEsqcLwG5MvZu/sxI9lyRsNqIJiZ15Obodsip87K0R
 xWFw==
X-Gm-Message-State: AOJu0Ywr8+OGZ2Uvsr55SfT0TNICiLSKMYl5+FeexcYOac6fn8n2JO9n
 Blq4SuI/YaiY614ZyywZKd1A4BJSCu/s2bxxCl3CxI7ZO2ivBSwXKYlzN9xJtbcY5F1d6vtTlb6
 LRFeK9A==
X-Google-Smtp-Source: AGHT+IEFIHHhUzqX7RDH2NgEyWruDLixEeFtr3C9w6bZm/8NTT18WdCpbPNfQ6KOwy3pRbyNsX4Uug==
X-Received: by 2002:a17:902:7044:b0:1fc:2e36:511a with SMTP id
 d9443c01a7336-1fd7454c482mr77119955ad.14.1721695482238; 
 Mon, 22 Jul 2024 17:44:42 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f28ffd0sm61589985ad.72.2024.07.22.17.44.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 17:44:41 -0700 (PDT)
Message-ID: <891bb4d1-b6f1-40e8-b0d0-8f0ab1826901@linaro.org>
Date: Tue, 23 Jul 2024 10:44:36 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
 <20240722201719-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722201719-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/23/24 10:20, Michael S. Tsirkin wrote:
>> Fails ubsan testing:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
>>
>> ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access within
>> null pointer of type 'struct vhost_net'
>>
>>
>> r~
> 
> Thanks! this is just make check under ubsan build, right?

Yep.  For avoidance of doubt, the configure line is at the top of the log.


r~

