Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC5606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g7OTB/Qu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=riNqn6mI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVO3a-0002E8-HD; Mon, 23 Nov 2026 02:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVO3Y-0002DG-Il
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:01:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVO3W-0000oZ-Ip
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795417296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sdqrTFCVis/ozIAGVPOqqXg8WrMVgYTPHKd4qNq3f+k=;
 b=g7OTB/QuM7Wd9qh3KiGi2MmkbycDjylfg+PIUHd4TfIKzlxOP/lIDADNM7PXA4ZjnsWS/j
 ZX0h7IOl7ZQmZ4mfw10AoDePG4jITlwY10a5w0STtLLflZqaXhXq85495vT3lZ2Wq2l/Nr
 jqgjxB94E2qd1DltdPWxYci9OhnZL5A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-k55K-qFJPviLmBNgPWG3sg-1; Mon, 23 Nov 2026 07:01:34 +0000
X-MC-Unique: k55K-qFJPviLmBNgPWG3sg-1
X-Mimecast-MFC-AGG-ID: k55K-qFJPviLmBNgPWG3sg_1795417293
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6b57668479aso3332791a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 23:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795417293; x=1796022093; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sdqrTFCVis/ozIAGVPOqqXg8WrMVgYTPHKd4qNq3f+k=;
 b=riNqn6mIxtM2vPvDVUssEK+fGTvp/6Hj/YHjF9zab4csOWM5WwyYTxGmxjlnRhxQ2F
 DSZsMKlZcAwiatjKhaGwbcokAomY8wXs/ZWkBWHmBAhEluSxe+z9DlDNc6otz7Ylvoqw
 cYqI3eS99aziFQl4peD6m7VL87oHKE8f3VwpV1LBQhJl5xjFPBCj3HWCgLxwzq/73mHQ
 p6Dc0TTyYHL8fg2+DujJyLRPfm4N0ohI5boIEUl/ZCbqw7eX+TfsV8mcdIiH9JOzdURN
 Ki2zGM2HoEHAriUdcimNg2iA/h7S4LaDQQyWCQeEHmm5ChybpCWD+kIlZkADBTYPcgLG
 aLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795417293; x=1796022093;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sdqrTFCVis/ozIAGVPOqqXg8WrMVgYTPHKd4qNq3f+k=;
 b=eX7bT/QJnzBU3C/YHa4QXUZLkgXpXnWna9W+7J2Oo91EOT2Q2ta2CbYlDVAEWQXDgs
 rT4fROoSJkiyadpmusYgf0UvmrEe9/EGjVkwTHAX2yjEvgBqL6UbVgpE/z18z9dUrh9p
 rROXBK6TGiXTtyYOLQ/ZVW2E/CxwvAnUwF1jh2ad4SJOJn7NJv9/+O+5fKz1yROVfUCH
 k2R4HKcmGoMNvECKNgYCkag7/qLw3JAxSpMNuXI1xpDoqKnreoAsJUq7oSx4/RHxytsg
 HSlwsDhxvndzdJw4c6OX3pY6UL2vQhKkxFyfDGSDjky9oCBDWoumDRsSI+Q93sdLOaw+
 31+g==
X-Gm-Message-State: APuU4Z+H3RpH592PcOkgjgZMcsy2Ni3o6r+CFM4XwUHiVV04imUaD0jd
 QJ/ZVDPgj5DJX1AE22+k2nh3paQ5BwPH3tKXVa8piawDSSiynbqmjRucwYSIpDunFIE039vCbjN
 zNJtP7p8GI9EfdnOaAJ42OmhhPKeBVqTAS94wJ7riMQnhs1pZiIv3VXQu
X-Gm-Gg: AZFdTZeLBxoDNIHp0W1IlFN91uDSBzImOpxb3cnHmH6f3v7td6AuE61dwA42TpralB/
 5N/pRs7guykcJclDCZ4LM6UuSWQMopG8aphWAJjBxvT62WuhxISuq1g/eSXpwGTLwzJ0YiTChdO
 O90q1XKCqk5Dnoy1LLHnLiXbLhWc1LYOILwVdNC6c/HPqzmv/iYm1LoNCCThKUOmBtqOh0UiKS4
 worlcP9PVwDb7i/+8+jQlf1qbCjA8KHy4aCmjxnzVcFaHKWIT4tx9OqOGzNprBBwPZvUN9gpMPa
 9eOrVC2FZE9d7pzy96YTU0eYYkPbFp5ciOYXK/N+cp1fX8zEUJy8yN3wWqbELi6zOa3cu2JhjUX
 6tpcSb/oUIJEXDSS7d2gDM5x2l7144AMlaXmBRaC3McRR
X-Received: by 2002:a05:6402:270c:b0:6b6:f3ca:94c9 with SMTP id
 4fb4d7f45d1cf-6ba37d6434amr7262827a12.26.1795417292255; 
 Sun, 22 Nov 2026 23:01:32 -0800 (PST)
X-Received: by 2002:a05:6402:270c:b0:6b6:f3ca:94c9 with SMTP id
 4fb4d7f45d1cf-6ba37d6434amr7262693a12.26.1795417290351; 
 Sun, 22 Nov 2026 23:01:30 -0800 (PST)
Received: from [192.168.0.9] ([47.65.243.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm18609537f8f.23.2026.11.22.23.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 23:01:29 -0800 (PST)
Message-ID: <05860cf1-ba01-428e-b891-e8d0f4ca2cd8@redhat.com>
Date: Mon, 23 Nov 2026 08:01:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tests/functional/ppc64: Fixes and improvements for
 hypervisor tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, peterx@redhat.com,
 farosas@suse.de, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com, gautam@linux.ibm.com,
 amachhiw@linux.ibm.com
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
 <87y0an4he9.fsf@draig.linaro.org>
 <497b4b73-07b8-4c53-af59-e62a3043ec8e@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <497b4b73-07b8-4c53-af59-e62a3043ec8e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 22.11.26 um 03:19 schrieb Aniket Sahu:
> 
> On 20/11/26 9:36 PM, Alex Bennée wrote:
>> Aniket Sahu <asahu1x@linux.ibm.com> writes:
>>
>>> This series fixes several issues in the PPC64 hypervisor functional tests
>>> and improves their robustness and reliability.
>> Just a quick note to say the power hardware we have from OSUL doesn't
>> expose a hypervisor so we can't currently run these tests in the
>> upstream CI. Do you know of any way we could get such hardware added to
>> the CI?
> Hypervisor tests are part of the thorough test run (mentioned as hv in the 
> meson.build file), and if I remember correctly, only quick tests are run as 
> part of the CI on gitlab.
Just a FYI, only the quick functional tests are run when you do a "make 
check". But the whole functional test suite (i.e. the thorough tests) are 
run when you do a "make check-functional". And that's what we're doing in 
the various functional-system-* jobs in the CI, see .gitlab-ci.d/buildtest.yml.

  Thomas


