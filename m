Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97276C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZS3m-0005R8-6y; Mon, 12 Feb 2024 03:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rZS3Z-00058s-GC
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rZS3X-0007St-Of
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707727970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VD1EAoIPX2Cy72gesxetwe+9U1XHaA2NQ//CKjruPDU=;
 b=cliOn8N2koTMmLVee5FlsXB6a6CU6Du6do7FM/xGbJmLOpF01my1m8siOAmmIgH0ANmoir
 1e1+utzEgnAsRxwR2lR7GuwKLkFBehWR5Vd5Ee4WOmqeCV7wCIjsExKJtJqgMVnbKXtcb3
 R9ACjpLivjGOwag0ZCmcy4Z4ge+p6XA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-tCFVeYCCPdqRaML_DTSkSw-1; Mon, 12 Feb 2024 03:52:48 -0500
X-MC-Unique: tCFVeYCCPdqRaML_DTSkSw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33b6fe7f46cso687580f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707727967; x=1708332767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VD1EAoIPX2Cy72gesxetwe+9U1XHaA2NQ//CKjruPDU=;
 b=Tdaikjh6tP84dS81BHUetScjWUNBZif9ncgQlnm/NeZiQ1ebLckW+n7kc7Y/ZNu1f8
 rMlVT3goc+b58xL4teDPmgsaCuNg1lng+NhLdzMq5u8jd3oEiCfc8tCmVrwgHBxO3Ah8
 x6B1hJk16BoD0XSJmEKn6kJrqg/x27Xxw7WH9uyxWDOup9467PkM4DFl7e/2FksQQ/nv
 oiFnfsb/rEUQQYHMULbC8IshPJef0sk9AEXu6feMY9asPgLuSvGmDkIhH6t8CdUCQDDH
 h5t5uujnn3E1YPfsRCjns1FtxCjGUnOsx/jF6uDfTJnULpEpGDjXLIcwdebuOhOANHCR
 sU9A==
X-Gm-Message-State: AOJu0Yziv3+zFG/4OAj+8/378BsWuIQVzD6q1T01Xqdp8LWhK8BYG6FA
 2wMfzipkuK3UPY0LKabAWx681W36RCZW2wjZ6fW3eEYMgSrOt5pdTuSMihyJOz1xXmDs7nhQqN2
 95IgHHVEKYlirAsiXbeQbxFgW49R3yXtmoRN5MTdHL+P3T2Pwc1RM
X-Received: by 2002:a05:6000:1245:b0:33b:48f1:495c with SMTP id
 j5-20020a056000124500b0033b48f1495cmr3674855wrx.12.1707727967017; 
 Mon, 12 Feb 2024 00:52:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHviOMquJ/GSZY3zrAVSxBNqFsoQCEGqlI3OXFI54vomDE89J86V88M2CtnrVZF4z7FDoGdtQ==
X-Received: by 2002:a05:6000:1245:b0:33b:48f1:495c with SMTP id
 j5-20020a056000124500b0033b48f1495cmr3674843wrx.12.1707727966723; 
 Mon, 12 Feb 2024 00:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVO4FRGqcGfCJqCJZSOEiW4gqDLuX2Wm2CX8WnjPUi7uwTqTRqAHqbkOVQQuAtQPTg1vMK5yGNFZWbtXiOKLvwM/FkjTr6K5x2WMYgBtKQdCWPF6//4wGCMiL93Aieja0AUCktqvccOwlw9W5or/960jEVVyUgTGSS5BMr+4JuT8daJCmLXl2vlDfsC7JyxMbgTmj6a92VrNLrSlgQ0/BdPrPKkIgk8zb+5
Received: from ?IPV6:2003:cf:d740:65be:3d79:757f:8d1:97f5?
 (p200300cfd74065be3d79757f08d197f5.dip0.t-ipconnect.de.
 [2003:cf:d740:65be:3d79:757f:8d1:97f5])
 by smtp.gmail.com with ESMTPSA id
 bp9-20020a5d5a89000000b0033b4796641asm6199373wrb.22.2024.02.12.00.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 00:52:45 -0800 (PST)
Message-ID: <76457a47-f011-426c-94ac-a3c4c163c821@redhat.com>
Date: Mon, 12 Feb 2024 09:52:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240202144755.671354-1-hreitz@redhat.com>
 <9bc07eef-da55-4ebf-a4ee-1d55eb6fd921@tls.msk.ru>
 <272941d6-fb76-4c5c-968e-d441c7957646@redhat.com>
 <62012f98-f2a5-4a28-aec6-3f03b1c5feab@tls.msk.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <62012f98-f2a5-4a28-aec6-3f03b1c5feab@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10.02.24 09:46, Michael Tokarev wrote:
> 09.02.2024 19:51, Hanna Czenczek :
>> On 09.02.24 15:08, Michael Tokarev wrote:
>>> 02.02.2024 17:47, Hanna Czenczek :
>>>> Hi,
>>>>
>>>> Without the AioContext lock, a BB's context may kind of change at any
>>>> time (unless it has a root node, and I/O requests are pending). That
>>>> also means that its own context (BlockBackend.ctx) and that of its 
>>>> root
>>>> node can differ sometimes (while the context is being changed).
>>>
>>> How relevant this is for -stable (8.2 at least) which does not have
>>> "scsi: eliminate AioContext lock" patchset, and in particular,:
>>> v8.2.0-124-geaad0fe260 "scsi: only access SCSIDevice->requests from
>>> one thread"?
>>>
>>> The issue first patch "block-backend: Allow concurrent context changes"
>>> fixes (RHEL-19381) seems to be for 8.1.something, so it exists in 8.2
>>> too, and this particular fix applies to 8.2.
>>>
>>> But with other changes around all this, I'm a bit lost as of what 
>>> should
>>> be done on stable.  Not even thinking about 7.2 here :)
>>
>> Ah, sorry, yes.  Since we do still have the AioContext lock, this 
>> series won’t be necessary in -stable.  Sorry for the noise!
>
> Hm. Now I'm confused even more.. :)
>
> ad89367202 "block-backend: Allow concurrent context changes" - the first
> one in this series - apparently is needed, as it fixes an issue reported
> for qemu 8.1 (https://issues.redhat.com/browse/RHEL-19381).  Or is it not
> the case?

Ah, yes, I got confused there.  There are two (unfortunately? 
fortunately? Red-Hat-internal) comments, one of which describes the 
crash that’s fixed here, so I thought that bug described this crash.  
But the actual description in the report describes something different 
(more like what’s fixed by 
https://lists.nongnu.org/archive/html/qemu-devel/2024-01/msg03649.html, 
but I’m not entirely sure yet).

So basically I got the bug link wrong.  We now have 
https://issues.redhat.com/browse/RHEL-24593, which has been reported 
only against 8.2.

Hanna

> FWIW, truth is born in the noise, not in silence ;)
>
> Thanks,
>
> /mjt
>


