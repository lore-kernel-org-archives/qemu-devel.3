Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6E9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 05:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0DpI-0002GM-M4; Fri, 26 Apr 2024 01:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0DpG-0002Fx-JB
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0DpE-0002Cy-7r
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 01:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714108121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FBOcfrAB4/j8FIJuYWsHjSzfsXKn26l+5w6Ef+gnr3U=;
 b=eNfEp6TM2xd7m9I0Y7azZy5y4hhlQMNjHeYZy3z7Q1SKM2cB3SNv3JXvdgaqS5sk6xXVzJ
 RKgyOT2Kd5pOl+B95NmlKtBbyyMdiuikrDugrjzfbb1pELztY7aS8M2RdthBengdGY6btm
 iOsmjoVvORpNrJSbmW3eZL/ujnSs5BQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-rJtIUj8FOCOxvYiKw3_MyA-1; Fri, 26 Apr 2024 01:08:39 -0400
X-MC-Unique: rJtIUj8FOCOxvYiKw3_MyA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a559bc02601so108198666b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 22:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714108118; x=1714712918;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBOcfrAB4/j8FIJuYWsHjSzfsXKn26l+5w6Ef+gnr3U=;
 b=nyIFhU2Gpy+XrGYySeAW7Ib8gv3mjQPSH7x0aW8gwfXPOTbiUjb71HrTL2W7TKUnV6
 SYJUW/BHQooOUFlBVoWp8SftcZnxrQiOt0QDo7gmeMGAqmnoys8lY1mcmO+rj22Lq7Rf
 gRFMox7l4/B84nsfI8kfwX+742lfWd+QvIzaZsOSC+2xwFSKxBkC0VCPIO/R/k/5dMQ7
 woMfKSFOU5RsgGfsF86DQbn/umlV/OQz6jbplxWAUZFe8g/77qKc8LoYR9rAggA8xV+1
 BHruAp06xwVx4BZjinJ/0pYCSMrRuN+mAbkUNazlYJ0FQMjbqqimQ4jvokzGLkeZVas5
 NOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCNnZfYUfzXLMAROk0FwN9g4yQk+wYGU1BdKO6vBsIhWvCBMDOMMoPuP7PW8oq1+OKZhC9l3JHDOMGA1y/23nRo4Iz7P4=
X-Gm-Message-State: AOJu0YxY+01EutuDLdv+S3ej6WuLbqhpxaeyhOYdsSqEnLhzBcJJj2wP
 IeW91hxZa/GMxPiRouaOajmltQd0cqTe6DmXL711JpYpQrpFnQcL5d7kyeKYxB6/iZtuMRaL4D/
 jFFgDWRVxSA5N97ypEUb/7gKNbw3Ae3GXr1m7YNzTpemAsIVKmnn1
X-Received: by 2002:a17:906:2549:b0:a52:5b71:d91f with SMTP id
 j9-20020a170906254900b00a525b71d91fmr1109462ejb.19.1714108118592; 
 Thu, 25 Apr 2024 22:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/62U5pzqn0zPx3Fi7pVSplsr3fslx3c0PnadpcNpjJjaVVUFrsXw1KAC5f2b51HdhwPjDUQ==
X-Received: by 2002:a17:906:2549:b0:a52:5b71:d91f with SMTP id
 j9-20020a170906254900b00a525b71d91fmr1109447ejb.19.1714108118187; 
 Thu, 25 Apr 2024 22:08:38 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-20.web.vodafone.de.
 [109.43.179.20]) by smtp.gmail.com with ESMTPSA id
 r25-20020a170906351900b00a55b5c365dfsm5735676eja.199.2024.04.25.22.08.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 22:08:37 -0700 (PDT)
Message-ID: <184b50ac-d435-4531-9f3c-f4d54ee059fa@redhat.com>
Date: Fri, 26 Apr 2024 07:08:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Make it possible to compile the x86 binaries without
 FDC
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, Bernhard Beschow <shentey@gmail.com>
References: <20240425184315.553329-1-thuth@redhat.com>
 <49984234-9a41-40aa-b1ea-448b8a02ab0e@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <49984234-9a41-40aa-b1ea-448b8a02ab0e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/04/2024 22.56, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 25/4/24 20:43, Thomas Huth wrote:
>> For downstream versions of QEMU, we'd like to be able to compile QEMU
>> without the FDC code included (since it's not required for modern VMs
>> anymore and the FDC code has rather a bad reputation, see the VENOM CVE).
> 
> IIRC you still need to keep the i440fx+piix machine DS due to
> migration compatibility, right?
> 
> Are you able to migrate a VM booted with FDC to a non-FDC one?

Migration from a machine with FDC to one without is likely not possible. But 
that's also not the purpose of this series. It's about having the 
possibility to build a QEMU binary without FDC at all in case you don't have 
to support old machine types with FDC anymore.

>> The q35 machine can already be instantiated without FDC, but for being
>> able to link a binary without the FDC code, the Kconfig file needs some
>> tweaks and there are two spots in the pc code that directly call functions
>> from the FDC code - those need to be disabled via #ifdefs.
> 
> Is it useful to you to have q35 without FDC but i440fx+piix with?
> Or are you removing it from i440fx+piix due to shared code with q35?

I think it might get useful.

  Thomas


