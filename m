Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A4BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kjn-0004Jt-4J; Tue, 30 Apr 2024 06:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1kjm-0004J0-22
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1kjk-0005Uv-7W
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714472962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aW3OTZQEeRLexcIL/yRGaeeXgT2rr2+rfi0/6bm4v8E=;
 b=H5INFIEWLOKLXXzzYcPlZQIxR02Ff0N8nITdJliBpzp3y6hxCceTtMpdK1f8WJuaFOqZpn
 5pVR5+XU5QaFke8o6+38kXqXupyXNSg4K4ow75IIQLH7kG9rqux30AX324bgZA2ZrftHT9
 QdmszvH3OspUEddWo9oA2+jBoLtAh3g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-iY1GhaM_OsGh4aesfhhKRg-1; Tue, 30 Apr 2024 06:29:20 -0400
X-MC-Unique: iY1GhaM_OsGh4aesfhhKRg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-790f55f69a7so287977485a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 03:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714472960; x=1715077760;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aW3OTZQEeRLexcIL/yRGaeeXgT2rr2+rfi0/6bm4v8E=;
 b=bwmWbYG1Hv0mKkO/rjH90xTo29zLQFvnHDBNU2ZgZibhrHaP0dg+VphzUPKboOQVFH
 HuU/O1B4N3XfypOmkwd/4X2vgERt4Fv5tBDB0Svxm34E3kKU2Pxz22B0ZK/yUQBi4ZEb
 U+g6LcEg7e8zwXpUh3bofzHS+arF++A2dDaWhBcYWDIEcQBZgo82bS77uIPudRWJ9AC1
 uoTzhAM9moDnW9fmZZ/CXaLflaWbZSxDHMA3PUCM6AfsPfQitD5YckLFKdhR2BPIYxtt
 NqTW8nOzsC0VJYEiYoE4D1OrYcwciQL5H41VP9PljNhmSy70UEmQbgsXMKvy+nJpQHmc
 jYJQ==
X-Gm-Message-State: AOJu0Yw0p3fgJynIh26Tc1jkVnA1nMF3jrwLi2mZfWfzkAd4ZAnJ74M4
 kAUOhe8bkF4/6LD/D4nFpzskXPDEJkUiDg+vDpNPCQSvOVM6w7VrZejXSyN7Loa80P74m0f70mO
 VFmbDuFh7reioCdODOHugCpLecHi2KRSqnVzAEqKAfF2qKliEiqnE
X-Received: by 2002:a05:620a:4510:b0:790:ad7a:d147 with SMTP id
 t16-20020a05620a451000b00790ad7ad147mr2764833qkp.62.1714472960150; 
 Tue, 30 Apr 2024 03:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJyp2d5vR1ErATnz/wUu8iodvbb9Yad4cBs8q8y3+w4v45TAtNt63u/kxMjUP4gghlIEvg7g==
X-Received: by 2002:a05:620a:4510:b0:790:ad7a:d147 with SMTP id
 t16-20020a05620a451000b00790ad7ad147mr2764811qkp.62.1714472959852; 
 Tue, 30 Apr 2024 03:29:19 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 m6-20020ae9e006000000b0078efdcd9aa6sm11295972qkk.127.2024.04.30.03.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 03:29:19 -0700 (PDT)
Message-ID: <05cab8d3-bda0-4452-92d7-061f4719eba7@redhat.com>
Date: Tue, 30 Apr 2024 12:29:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240430064529.411699-1-thuth@redhat.com>
 <ZjDAGuONZ_Zem3fL@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ZjDAGuONZ_Zem3fL@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/04/2024 11.55, Daniel P. Berrangé wrote:
> On Tue, Apr 30, 2024 at 08:45:29AM +0200, Thomas Huth wrote:
>> Old machine types often have bugs or work-arounds that affect our
>> possibilities to move forward with the QEMU code base (see for example
>> https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
>> cannot be fixed without breaking live migration with old machine types,
>> or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
>> commit ea985d235b86). So instead of going through the process of manually
>> deprecating old machine types again and again, let's rather add an entry
>> that can stay, which declares that machine types older than 6 years are
>> considered as deprecated automatically. Six years should be sufficient to
>> support the release cycles of most Linux distributions.
> 
> Reading this again, I think we're mixing two concepts here.
> 
> With this 6 year cut off, we're declaring the actual *removal* date,
> not the deprecation date.
> 
> A deprecation is something that happens prior to removal normally,
> to give people a warning of /future/ removal, as a suggestion
> that they stop using it.
> 
> If we never set the 'deprecation_reason' on a machine type, then
> unless someone reads this doc, they'll never realize they are on
> a deprecated machine.
> 
> When it comes to machine types, I see deprecation as a way to tell
> people they should not deploy a /new/ VM on a machine type, only
> use it for back compat (incoming migration / restore from saved
> image) with existing deployed VMs.
> 
> If we delete a machine on the 6 year anniversary, then users
> don't want to be deploying /new/ VMs using that on the
> 5 year anniversary as it only gives a 1 year upgrade window.
> 
> So how long far back do we consider it reasonable for a user
> to deploy a /new/ VM on an old machine type ? 1 year, 2 years,
> 3 years ?
> 
> 
> How about picking the half way point ?  3 years ?
> 
> ie, set deprecation_reason for any machine that is 3 years
> old, but declare that our deprecation cycle lasts for
> 3 years, instead of the normal 1 year, when applied to
> machine types.
> 
> This would give a strong hint that users should get off the
> old machine type, several years before its finally deleted.

Sounds like a good idea, too! Since I have to drop this patch here anyway, 
could you maybe write such a new patch? (or do you want me to try to 
formulate this?)

  Thomas


