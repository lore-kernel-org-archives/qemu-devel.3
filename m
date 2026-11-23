Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE84606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SMf3Pqq6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IUupr5a9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSI8-0004I5-Ox; Mon, 23 Nov 2026 06:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVSI0-0004G7-Sf
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xVSHy-0006Pw-QT
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795433568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L1rLBvEbdBKO3EShCjpw2NOpp8BZ1kb2UiYM6bFDxTs=;
 b=SMf3Pqq6o3gxTsIEdVymLArwNIJeHcBPLxzc05CL+Q4pzYRvsL+Q4iLHu5zmM0bkasPOWc
 gTp3GEC+9OOXMnh8a3qPKZfWZeqJiA5I5KCEeweAuF/bptKEV/jHrU1xSeK1v/9N1rwEF5
 rd5Xw0PpP7ywkraTXmbhPuHO+uNWCCk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-kc0Av7_1Oa-CWX_E8DljlA-1; Mon, 23 Nov 2026 11:32:46 +0000
X-MC-Unique: kc0Av7_1Oa-CWX_E8DljlA-1
X-Mimecast-MFC-AGG-ID: kc0Av7_1Oa-CWX_E8DljlA_1795433566
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so2769365f8f.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795433565; x=1796038365; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L1rLBvEbdBKO3EShCjpw2NOpp8BZ1kb2UiYM6bFDxTs=;
 b=IUupr5a9pZLv6yeAxMrcaUfzxxj3K8MMvQJo9y0MAGI+6dhzQaKwdmJhzsy9paQZzM
 3qAOSF2cKlB+Yg5OM1lp0uUo+1XQursx+HxnTBg2uOXj1rAt5dvTScMNYAg+CBSZgrZG
 cAZwYRTapLbqA2ACbeFTnpU2BVPp+dB9Tmwwe3ARMZ+5sReGJLMVMmcsk2ACPyfHZVVw
 jqyteGMpgZVA2ZPnvXzmUJWRa6/CU+Sigh1GLvcS7/8jnCbAnKuZaTyCIAjd1VVch8VM
 M7YT7ljc+qF3R0mxv3pGlXvvvOuvNWi+zgZM7DwxN/yL1WxyvjL/C/w/5gcl10Sw+dTV
 lrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433565; x=1796038365;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L1rLBvEbdBKO3EShCjpw2NOpp8BZ1kb2UiYM6bFDxTs=;
 b=fNy6oB2ge8CcjAd71gGnwgAUGKzkvxVf8oAaolY3AZYauRrVS31hknjaRWv/UYtOhO
 woknzFz1/wbJyLnFye4veOu2zaBb3p6a5YL3/anc5diM+P/hkw8q7GHLMzJKNV/Kg1+g
 raI60TPOon70uqGQMQIx0PLswWinF/tdcoSHUALX5GDKYhJl/sV5P17kyR/foRe+5Qup
 lbCLv2BY7gTpx8PU9WlDH6bkAiSfaRR8cCqoQLGHheBacY/Kttk7GBzIgVi9Wchby/cE
 KBRVgmM1SJ9eNw/Z2ZvwxmSWS3PZ1LqC8l1NfoaXd76V7Ogp+PO0jhSZhIflbP5M/sak
 HqAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHBsV0PIjD4btbNegUjkn1s/t4Ib9EPKQx0S9wYO4GiMbuy2KAppfV5HtvWZbyTi6ni7dj1p8R1f6+S@nongnu.org
X-Gm-Message-State: APuU4Z9E+Io2SC3lgGg9krXmVNyVWIcBr+6RoZNrR+t63ag41j73zBsS
 NqTWeMcCji/CNLiuga4tWBQ3x0txWvvBBYD1159YBeRn1cN7CSat0Ejtn4WvUgAwZ3p3wiTW0lz
 oxMgBM9no+7MUwC9VBkZnUbKbKw5CIOWED0Tn9nN0ZWzF2koSeRKlk5vW
X-Gm-Gg: AZFdTZfT5MrsF+kBBt+q8S+M2fAVytjoCDhAxjUsQ8p/QrPn+iPineskTLYDj6sqnw0
 Gn9mJBWTZBDxkVQlHachpZ564FMrqFf4fnhEa2RFsGr5FEEqc979w5X5RXVEijx3ZAG7bZtYB9u
 /uefxvCq/Cuqg4uPt9y24WnRtrjio3f1quHlPoxI7rC58z2J7tEPbxSNzW4lIou4Qg4VOK2wF3+
 psJsUKoQB76rINnE14TnGSkOHP/8VnTrEMky5uNvHqtv6gh/V+r0/B17E5PurxPbYtY4tHUcMzP
 NSyKfVVCuro/mGlJpjz11TSCYb8Nrm0FqHoWhqmV/z/4G8GMU2R/7fBeqF40NVodJeywzNjJfwO
 TPxqDoP7wuUb/31FFHv3TlK5KkaHvIS8jrJJuZ/14hfBK
X-Received: by 2002:a5d:64c9:0:b0:491:92e5:b5c2 with SMTP id
 ffacd0b85a97d-4abb1baaaa5mr22468585f8f.15.1795433565666; 
 Mon, 23 Nov 2026 03:32:45 -0800 (PST)
X-Received: by 2002:a5d:64c9:0:b0:491:92e5:b5c2 with SMTP id
 ffacd0b85a97d-4abb1baaaa5mr22468537f8f.15.1795433565288; 
 Mon, 23 Nov 2026 03:32:45 -0800 (PST)
Received: from [192.168.0.9] ([47.65.243.90]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dcf9sm21517146f8f.32.2026.11.23.03.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 03:32:44 -0800 (PST)
Message-ID: <41dc8ba1-839c-4c56-b7d3-876a72fde6fd@redhat.com>
Date: Mon, 23 Nov 2026 12:32:43 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
 <CAFEAcA--1GLGf=7tmkzQZ=QRPApLTdsdFskgbSibYPDF0o626w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA--1GLGf=7tmkzQZ=QRPApLTdsdFskgbSibYPDF0o626w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 23.11.26 um 12:28 schrieb Peter Maydell:
> Ping -- could I get a reviewed-by for this CVE fix, please?
> I can fix up the unnecessary "inline" keyword.

Reviewed-by: Thomas Huth <thuth@redhat.com>


> On Fri, 13 Nov 2026 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> There's no reason for the RTL8139 to be doing a DMA transfer to
>> something that isn't memory, and allowing it can cause weird
>> re-entrancy problems, such as a DMA to the PCI hot-unplug register
>> causing the device to be deleted while it's halfway through doing
>> something.
>>
>> Replace the calls to pci_dma_read() and pci_dma_write() with
>> local functions that are identical except that they pass
>> a MemTxAttrs that forbids non-memory accesses.
>>
>> This is the same approach we took to a similar problem with
>> the hcd-xhci USB controller in commit 89e653b7736 (but differs
>> from what we did for lsi53c895a in commit 4862d2c95104d).
>>
>> The known trigger for this bug requires that you turned off
>> ACPI hotplug on the QEMU commandline with
>>    -global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off
>> so most configurations won't run into it.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 3ada003aee2004d24f2 ("rtl8139: Use PCI DMA stub functions")
>> Fixes: CVE-2026-128868
>> Reported-by: VictorCHEN <ahchen-yz@outlook.com>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I'm also wondering whether there's an approach to this class of
>> bugs that would avoid us having to modify specific devices to
>> insist on DMA-to-memory. It seems a bit dubious that writing to
>> the PCI hot-unplug register can cause us to unrealize the plugged
>> device even if lots of other things are still holding a reference
>> to it. Or else we need to be more specific that you can still
>> validly (in the sense of "doesn't break things") do things on or
>> as part of an unrealized-but-not-yet-freed device, and move
>> things like pci_config_free() from unrealize to deinit.
>>
>>   hw/net/rtl8139.c | 98 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 60 insertions(+), 38 deletions(-)
> 


