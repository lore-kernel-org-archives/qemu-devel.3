Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22CC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 06:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTbpl-0001VF-93; Tue, 16 Jul 2024 02:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTbpj-0001UE-5d
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTbph-0005U7-FZ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 02:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721111919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yBPuJMAPoUAjBGHKAMYIE/JLEN0ytW91YTDHlvkig0M=;
 b=AqjHdId3A9ELUHdHGhf7Q8gLAtFKrNCPAk0bmNGYlAyHWHGgiBFtxiXF8GfRlokUpNNSGJ
 jAacmNJS42FRTJtZTuthhrTf7yiySfFT5cGt0cm1SELh8MsmY0aF4yir2fnUBX1kykYqJs
 h1M4Q49VrZW1jdsdyBXij159bwlUUWk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-lIobl1mZOF6-f0Tme_KDIA-1; Tue, 16 Jul 2024 02:38:33 -0400
X-MC-Unique: lIobl1mZOF6-f0Tme_KDIA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-59980727364so3562706a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 23:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111912; x=1721716712;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yBPuJMAPoUAjBGHKAMYIE/JLEN0ytW91YTDHlvkig0M=;
 b=ujMfW/v8lNs8QEqdJn02/jvEeORsPkDGSiuIGsm2G4fO4M2Za/v4Qc4iEyAoLg7ArH
 s7XrJ160Q11AiFVptHE3Ab0Qa/ZO3hBy3xn3zvxJNPbxflvGJrCrxPJ1i0F46bJY4D8n
 QQVZk1MCSLH0d/GzJXiWT1LMiTxW50rLBuQjNVcc1iqeSvSCGxkOuWO13+9511aUfqJ0
 HtFBJqzg/vltsyuFmT8sURcBbXugqHuejGz0ARYzmR2nbXnS/cX+fPyadmFPEPjHcj34
 HgvM+HefRzW8zg57i8t8jXqv3puVs18g5V8oQz09auzUjkIoRHYKaC8V+4QlzSnl73pi
 X/VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUgGm9rm5sIIWxlMcz+oEYZdWxvfil/nxTC7IPEyzBxbgeKl47uwlEucgxbDFucVG14LQW4byr1bQqdvaF22HQp3ol1Zw=
X-Gm-Message-State: AOJu0Yx/5S6MF/KlRLRg5Tbj5L/HmcNIPu2tERbUhCuwmnCRHJrmdm/U
 1EZN3PKUKnA3Akdowt/EU2AXCVi8HTBMzioWTYfRXbTxcUcLsuDQc7kJcCrRFcFe5WyolGhibkN
 DqZZkdAqf9pS9KQG37QCYj4+uQ6vWNBnVfQfjR8cFrjvn491FuQS1
X-Received: by 2002:a05:6402:34c7:b0:582:8078:b44a with SMTP id
 4fb4d7f45d1cf-59eeb9d49f6mr807167a12.0.1721111912589; 
 Mon, 15 Jul 2024 23:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2Je9L2RY3hWh0LgrHKml0R+8eohHGROtn2Z1+6QALa2UsXNyYWLcq4b5S1WkmcoLpFEUoxA==
X-Received: by 2002:a05:6402:34c7:b0:582:8078:b44a with SMTP id
 4fb4d7f45d1cf-59eeb9d49f6mr807150a12.0.1721111912219; 
 Mon, 15 Jul 2024 23:38:32 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-101.web.vodafone.de.
 [109.43.177.101]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59b268a293csm4327162a12.67.2024.07.15.23.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 23:38:31 -0700 (PDT)
Message-ID: <f09b78e1-383a-4fce-8e19-45e9240d245f@redhat.com>
Date: Tue, 16 Jul 2024 08:38:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FreeBSD update required for CI?
To: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>
References: <63699dab-42d9-45ca-932f-acd6df688b6e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <63699dab-42d9-45ca-932f-acd6df688b6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/07/2024 01.00, Richard Henderson wrote:
> Hi guys,
> 
> CI currently failing FreeBSD:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7347517439
> 
>> pkg: No packages available to install matching 'py39-pillow' have been 
>> found in the repositories
>> pkg: No packages available to install matching 'py39-pip' have been found 
>> in the repositories
>> pkg: No packages available to install matching 'py39-sphinx' have been 
>> found in the repositories
>> pkg: No packages available to install matching 'py39-sphinx_rtd_theme' 
>> have been found in the repositories
>> pkg: No packages available to install matching 'py39-yaml' have been found 
>> in the repositories
> 
> Has FreeBSD ports updated to something beyond python 3.9, and we need an 
> update to match?

Yes, we discussed it in IRC yesterday: Python has been updated there, we 
need to update lcitool to the latest version to get the fix for it. Alex is 
planning to provide a patch.

  Thomas



