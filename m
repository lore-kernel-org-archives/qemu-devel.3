Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C6C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ronm2-0005O1-Ig; Mon, 25 Mar 2024 13:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ronly-0005Mk-RF
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ronlu-0000NP-4H
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711386365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=60Vm3FYCTlVUjokVPdVqeGDuPIRwaDJ804UfDMRgld0=;
 b=Xdo+a0/TZ/xKQ2RdnP6RsSvdGe1dow7oWkwLcfsCgpYZmbr0s8E2OIM4ppfQNrh85ACkpr
 DWYvdsFzyA8Es8Iu3l6jIZMNKXBy9PlDGX6IoKc8KVIW8KYwFJ4RmYi2CFjKAWWEHDiPRG
 KFGzWoHRPizWrBG0rZE0+qwoq77GtJk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-rYYQ_bYMM_S-1seirpB35w-1; Mon, 25 Mar 2024 13:06:01 -0400
X-MC-Unique: rYYQ_bYMM_S-1seirpB35w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-341cdbcbd62so306760f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711386360; x=1711991160;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60Vm3FYCTlVUjokVPdVqeGDuPIRwaDJ804UfDMRgld0=;
 b=bzUpcvCF6t375wbM7+TThxgzJkRm4O/ZA2PppL9NUTPJNzPfgHgO22l4/8wR9Hq4BZ
 peBlwYFlgaW7g8g2BPpkDnk6vH7DM3a9KLCiI727Eql/jl0WwbLgZ96oKK6XlbNaKndp
 rrwViXVu3BZi56Ro7o7FRRzjt5hmtIN6s6nclaZmeTnKMYiD0kenK5Y0fttWHysmcfRw
 gc9rBYGI1cMrMefrgayU/Rls6ECaD7gjA/o4LO02G+L4k5rk0rd6qHQVHvUgWJO8+0Ag
 be7WqwNsBXhPHDet1SjaPkWDCD/ehyErrzc3xQv9C91izy3CFgVlgcyVBr4oJZeLr44i
 8OCQ==
X-Gm-Message-State: AOJu0YzZIKTEEf8tuXyTEYsj0BZ7DOfyszUAbBcNMVGzdomI07zg8lD9
 wniJbLq5eQVXGnU6V8WcymVNbMoaWwv6J4r94oI1m0f28JJBS304n7ShSuRRzshD9Y21NtT5WMJ
 dh1bJ63WOXmAIxwdDqRoBo0lxF/9Ty84iD6QpYoer/RXX5hVtZPoA
X-Received: by 2002:adf:ec01:0:b0:341:73f6:2151 with SMTP id
 x1-20020adfec01000000b0034173f62151mr5165047wrn.24.1711386359935; 
 Mon, 25 Mar 2024 10:05:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbFobW7VTBcFrYfASJzwFfGBWlwHrPyApaCHdd0D34184yBgw/ILGgywBZMCJgY7jO/eNCAQ==
X-Received: by 2002:adf:ec01:0:b0:341:73f6:2151 with SMTP id
 x1-20020adfec01000000b0034173f62151mr5165034wrn.24.1711386359601; 
 Mon, 25 Mar 2024 10:05:59 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-176-158.web.vodafone.de.
 [109.43.176.158]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d4847000000b0033ec9b26b7asm9845647wrs.25.2024.03.25.10.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 10:05:59 -0700 (PDT)
Message-ID: <8daafae0-7751-45e7-bc4f-d9a825ceec70@redhat.com>
Date: Mon, 25 Mar 2024 18:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: how do the iotests pick a machine model to run on ?
To: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>
References: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
 <ZaqCA5uYWFSgK6F-@redhat.com>
 <CAFEAcA_n-pgzd-bne7VvHk5a3Q9ofpxWsmWTshtV=nKfZd9ESA@mail.gmail.com>
 <CAFEAcA-PKwFOj6=H+v=8B-xMg0=vUPf0gE8-=3N2N1XY1TLDog@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-PKwFOj6=H+v=8B-xMg0=vUPf0gE8-=3N2N1XY1TLDog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 19/01/2024 17.18, Peter Maydell wrote:
> On Fri, 19 Jan 2024 at 15:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>> (Also, we should probably put an entry for sh4 in machine_map,
>> because the default board type (shix) is about to be deprecated,
>> and the r2d board type is thus a better choice.)
> 
> The good news is if we add r2d to the machine_map, then
> only 3 iotests fail:
> 
>   191 -- not sure exactly what's going on. QEMU complains
>          "machine type does not support if=ide,bus=0,unit=1".
>          Side note: the test harness seems to throw away the
>          stderr from QEMU with this error message, leaving the
>          test failure log rather uninformative. I had to
>          run everything under strace to get hold of it.
>   203 -- this wants a machine type that can be migrated;
>          sh4 CPUs don't support migration, so the test
>          fails because the 'migrate' command returns the error
>          {"error": {"class": "GenericError", "desc": "State blocked by
> non-migratable device 'cpu'"}}
>   267 -- similarly, wants a machine that supports snapshots,
>          so fails when the loadvm/savevm get the error
>          Error: State blocked by non-migratable device 'cpu'
> 
> How should a test indicate "I need a machine type that
> supports migration" ?

We could maybe add a flag to the machine_map to indicate whether the machine 
is capable of migration or not. In the latter case, we could skip all tests 
that are in the "migration" group ?

  Thomas



