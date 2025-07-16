Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC9C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 15:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc4Ba-0001cK-Qv; Wed, 16 Jul 2025 11:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc470-0007a1-3m
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uc46v-0005Fk-Ve
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 11:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752679916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BIqQtUhEYRmIZi0kAmjgHKL4R6I58qwrgX+odvlqBPQ=;
 b=EYnnA5auONcyVo36zz/GdBN/KULX8Gz11Ba0rliNBq7czqdMLY3DqNzPzrIsBDUo2NacYu
 +i+SD6RRCYQ13LIngoFg5Mmw151ewu0rAODqcIpibBlfcDvZ4sYX/LMrUcpb5f2YCmfzLK
 6tJqF8+XA2aJSRzvBbS9Ip6TaiItoJI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-07aZ0MgoPoWtAyCBZ0bRQg-1; Wed, 16 Jul 2025 11:31:54 -0400
X-MC-Unique: 07aZ0MgoPoWtAyCBZ0bRQg-1
X-Mimecast-MFC-AGG-ID: 07aZ0MgoPoWtAyCBZ0bRQg_1752679913
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso43830195e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 08:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752679913; x=1753284713;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BIqQtUhEYRmIZi0kAmjgHKL4R6I58qwrgX+odvlqBPQ=;
 b=BveBiL0QxDq/3u4gfvVn/oGBoMZamMTEdg/zEojU770J/mgUeGSr2zKn9aSfJ6u3oU
 46FHeOTCarGx+eVin/rNRlE/6HLU1Fzqn23Ay1+KI+dr6M2iquFhrE4vhFaEjB0lFbAN
 dtinzNo7NFHwh4XghhJLZjvrZusD1lxscp2HB3nFcSOI7sSEkyiF3P+8GIzXTWLw6mWq
 pIdLKFpQ3VafARScbo/mEMjiAdx0emBAgNhfMCv2YBqdS9exyv8ntWZX5iQz30mYUSiX
 6aDQiZjHT2fPhRRDKk+NWDbqG2XOk387r5Y1r9b+DTZtKBvVZkaJi8Paj72ZGjVNBUIU
 v5IQ==
X-Gm-Message-State: AOJu0YyQNgNFwww1+IJOHni+LizJ3URvkjAOFHs/2Y4B0dcHNht/y3AT
 luKKkVxO3gGidTpCWtp3G4gOcRe9uWOfrJlABvbHAdn25ggiPflM564jl6BIGeQpRHyf7OJfgWa
 ayQQUNxyGwTHOZBUKKhg+oEguF9Q8sDjSxV/EN+ILJtMHailmJp/pvQikb53TW4xy
X-Gm-Gg: ASbGncsrEglrKijyepfduXVHuxZ9yFOsbQfk7IbrU8Czs9oV7mstSg2zgFDSNccriKO
 YCDKIiWpWKeUe+7/bt0vZuqL0jTv9SLra0ed6DM9qKlmkomL7AIZL7NJBB4zEVwI/WIYRLoSifA
 PyZVrAr3tH1zKxZ1b0JOQiLaCGwFisF4brYwJwWAdtYrsjumznPdOWn/hN7HSfdac9wuXRAeWzo
 RJ6dTGKr4spBw0gmcnb1pKWAlokWc0IBCD36/l4T5ics2TFC+gqf+UqXU7/bv/Kfcy88YMYtWHU
 GnRsHwyto+iKbL/UWT1KYykhWW0r0hzhnCD+Hd3kN+USpwg2PU9GYopvndc9nwwZ2Zwp9Qw34lv
 hauXFiKutbLA=
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id
 5b1f17b1804b1-4562e38aa91mr35645745e9.19.1752679913163; 
 Wed, 16 Jul 2025 08:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhL38J2DkR9DhAcfh1siw4haHY19rkIyEbn6jxpXZei1uMaDPprp17ovmET1WCOx14nivBwg==
X-Received: by 2002:a05:600c:35cd:b0:456:1a87:a6cb with SMTP id
 5b1f17b1804b1-4562e38aa91mr35645445e9.19.1752679912757; 
 Wed, 16 Jul 2025 08:31:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8193e3sm24384765e9.18.2025.07.16.08.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Jul 2025 08:31:52 -0700 (PDT)
Message-ID: <2063d371-a9df-4788-a93b-29f5f506ea42@redhat.com>
Date: Wed, 16 Jul 2025 17:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: boot failure on top of current git
From: Paolo Abeni <pabeni@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <6c04f89b-0313-481a-9d26-1fe9e60e0616@redhat.com>
 <1331c1fe-6064-4580-8464-02dee23c1fe2@redhat.com>
 <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
Content-Language: en-US
In-Reply-To: <5b901f04-da30-4f40-8ab9-803e03e43414@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
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

On 7/16/25 5:26 PM, Paolo Abeni wrote:
> On 7/16/25 5:22 PM, Paolo Bonzini wrote:
>> On 7/16/25 16:44, Paolo Abeni wrote:
>>> I'm observing boot failure for a rhel-9.7 VM. I'm using qemu git tree at
>>> commit c079d3a31e.
>>
>> No and I cannot reproduce it.
>>
>> What host is it (processor) and kernel version?
> 
> Host CPU is AMD EPYC 7302 16-Core Processor, the running hypervisor
> kernel is ~current net-next (v6.16.0-rc5 + plus net-next new features
> for 6.17)

I'm sorry, I should have waited a bit and added than I can observe the
same failure even while the hypervisor is running kernel
5.14.0-576.el9.x86_64.

/P


