Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7010FC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKabB-0007jd-Mj; Fri, 21 Jun 2024 05:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKabA-0007jD-6x
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sKab8-00076a-Pa
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718962221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yNz8FEjgAXnzHZN9gwE5iONEU6D3ciUpoGA41ypa1Jw=;
 b=hgFja8drIGB7QtVdoUviFWcQADwOXyusizNVN3TO2Gdqgk9RU7mUakVwTQKa0j6vW1WkDh
 NczUn23UaZFZVOCQl0RhJQyuLOQKDBQZtnPBbQbz7Ln8c84OY++UWCRvepYzSIUI/KKcI0
 DEjhCH8lolTnISB/IU7XrQIc3LigfS8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-zOEpiZRyOs-rwJwTPsW6Ag-1; Fri, 21 Jun 2024 05:30:20 -0400
X-MC-Unique: zOEpiZRyOs-rwJwTPsW6Ag-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4405680124fso20291311cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718962220; x=1719567020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yNz8FEjgAXnzHZN9gwE5iONEU6D3ciUpoGA41ypa1Jw=;
 b=atUGH9pv2La9n18hA0pK9KtF8i4kKPETwinCp9wu6E1Cj+yd2wl7VCvYY1wVJePVQG
 jEHGmymlWLvWXm+YfNUucqy4ERuPUSYLzv5xUWF64qzPDHb8t+JKM4VSxpnLI94uQmP4
 TCGDkiXer+YxRvDRwIPrBlGAY0FeDdPoCXyq0usgOhEUbRbkgZ8Y2TAEME8TUG2dmZ44
 MjUkG7HZ2+E/Y663KtUxQ2f9XLZO59a0perP4npWOBF1PI5Uq3MblCSvAvC6VLwmhr0h
 Bg5nCBhhf7U4gfz7hXxsWQdZuosd4PRi1aA7DBFJNl4lw47wZs52CctQDY4bUKcZrKia
 8t4g==
X-Gm-Message-State: AOJu0Yy/wW2fhewPtNKMVVF/0fV7D/AG5v7hyuQcKl/EWo1Z9GLF+2Du
 ZdI6hhaDmw1qSez9WXX0DNe/HN/ac8NJpJEmisAncxHWQkB0wmy+Qe8wWnOYUewe5HNEyFP6IEx
 ieSyc91JOuT/UN5lYpYNN7BLpTod78Q1v237uZQ8Vic682uZIv26a
X-Received: by 2002:ac8:5842:0:b0:441:569f:7065 with SMTP id
 d75a77b69052e-444a7a73c52mr83754671cf.58.1718962219826; 
 Fri, 21 Jun 2024 02:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOg0+NABJ1nP+JETPh600T/2DDgvzKcwev5MoQsA98Cb2SsKXUOjU7WpNtEbviQY/pTj0VUg==
X-Received: by 2002:ac8:5842:0:b0:441:569f:7065 with SMTP id
 d75a77b69052e-444a7a73c52mr83754451cf.58.1718962219432; 
 Fri, 21 Jun 2024 02:30:19 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-178-117.web.vodafone.de.
 [109.43.178.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-444c2b47ce3sm8981091cf.1.2024.06.21.02.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 02:30:19 -0700 (PDT)
Message-ID: <76070bb3-abf6-491a-a9f3-549f615e23fd@redhat.com>
Date: Fri, 21 Jun 2024 11:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to use designware-root-port and designware-root-host devices ?
To: Peter Maydell <peter.maydell@linaro.org>,
 Arthur Tumanyan <arthurtumanyan@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, andrew.smirnov@gmail.com
References: <CADueUgQh-=vmoO9kqL589Xeuf_LOM_K2Rr-rBxwe8iArdNdzsA@mail.gmail.com>
 <6b1daa9c-6f37-4edb-86d4-782941f1bcca@redhat.com>
 <CAFEAcA-Yda=XXspi49Z+-7bmBP-DzL2kFMg_XfNxMviHuAX18w@mail.gmail.com>
 <CADueUgS1==4gAmNmTBLZzrnRUp9z2wxkce8+TcOeoR3w_Pg-bg@mail.gmail.com>
 <CADueUgT4xDJft6On4j+oic65UcQRv_PcNSWJg-CcdBM8My3zow@mail.gmail.com>
 <CAFEAcA-TV6MKC32zd3WP5yhLABkbDrLKtP7CCZ0kB5pbV+-5Vg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-TV6MKC32zd3WP5yhLABkbDrLKtP7CCZ0kB5pbV+-5Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 21/06/2024 11.16, Peter Maydell wrote:
> On Fri, 21 Jun 2024 at 08:07, Arthur Tumanyan <arthurtumanyan@gmail.com> wrote:
>>
>> Hi,
>>
>> I just tried to run mcimx7d-sabre machine this way:
>>
>> ${HOME}/cosim/usr/local/bin/qemu-system-arm -M mcimx7d-sabre -m 2G \
>> -kernel ${HOME}/cosim-arm/buildroot/output/images/uImage \
>>          --initrd ${HOME}/cosim-arm/buildroot/output/images/rootfs.cpio.gz \
>> -nographic \
>> -net nic -net user
>>
>> and it just prints this and do nothing: qemu-system-arm: warning: nic imx.enet.1 has no peer
>>
>> Based on what I see in the mcimx7d-sabre.c , it configures just very basic things, no PCIe at all (may be I'm wrong ;) )
> 
> The machine model in mcimx7d-sabre.c creates the SoC object
> (TYPE_FSL_IMX7). It's the code for that in hw/arm/fsl-imx7.c
> that creates all the SoC devices including the PCIe controller.
> (This structure is similar to real hardware where you have a
> board, which has one or two chips on it like RAM but most of
> the complicated stuff is inside the one big SoC chip.)
> 
>> Is there any idea what goes wrong here ? Maybe someone has experience with running this machine ?
> 
> "No output" usually means "your guest kernel is not configured
> correctly for this machine type", and/or possibly "you didn't
> tell the kernel to output on the serial port".

By the way, it seems like we don't even have an avocado test for that 
machine available. Peter, do you know whether there is a kernel for this 
machine available somewhere that we could use for testing?

  Thomas



