Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C7EC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 07:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYKua-0003PK-NG; Fri, 09 Feb 2024 02:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYKuY-0003Os-QI
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:02:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rYKuX-00079L-9g
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 02:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707462175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ucwVg+iez726D5scYK0nCZOvWhtDE6jTHEibllEEP54=;
 b=QszVDN0aXmAwqsqai9GaV8d9H8qn0MkqLkbVcfbLleleGEGRSz32Ky7tyCKwauGmU+XkcH
 uwhe3KXwYaU+AgmE+agaQlrfDaFX3+Ae8gDz4quHwVqz/htoT60rpTrH28LlmiYlycDIJA
 tkFXzjTNt1NK/3/XgVDSR1quA8J0le0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-E2YnpSDSNkO3w7VofZcqvg-1; Fri, 09 Feb 2024 02:02:53 -0500
X-MC-Unique: E2YnpSDSNkO3w7VofZcqvg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-783350c4584so99186385a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 23:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707462172; x=1708066972;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucwVg+iez726D5scYK0nCZOvWhtDE6jTHEibllEEP54=;
 b=D2xRVMyB+rnNBCigfRO9PbSWHL7UI9KhEggRFjsaJmFcGo7kzl9nOnSIeuWq2ty7W4
 AFBbFpNv18Vu+9pSpBziV3tWNuGNwbbUAghAYusG1IQf+8izmaWqhOKELKJb48oviWAd
 saZzgO2t21yeLZ9T8rELrwUp5sbY7iYshz7xXwtXVpSY0s7PNICC0NK0JBgSHVJYbhE6
 rAQ5bOHBfY46gHkzZQL4dlsbkSU57lDSypF7e7QTRpLJlBSImivO0wXEjk5wc9ULDR80
 ghnqdr3P2rkzPFyBONgzfKtvP+GY+v4/Q8O/CK5uztXFRiLbiVA8lszxoh5zn3rklXAt
 q5Hg==
X-Gm-Message-State: AOJu0YyJa/SibENss4S2CtXY5nFJSRCe7mQDhLLIb158kfKGtGfgsWBP
 rYmRO1uDJIU6GPEHiSyPJfyYBSYLo/rRp9fr6/cSfebs4jq/4kOqakV1aqJAM4IBMfRr03ENJzb
 K2h8eKi6XPb/59OB9upr4l2woXyX68JbRczeNbdHakhEJw2V7clQk
X-Received: by 2002:a05:620a:2911:b0:785:afa3:6c0b with SMTP id
 m17-20020a05620a291100b00785afa36c0bmr1042587qkp.52.1707462172544; 
 Thu, 08 Feb 2024 23:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF16IUvmBnjULEgGFmehmrii8CkYthi92dHH6F5V/iiezPHFJ0f21bDQ7J71R/ag/7jnc2aGQ==
X-Received: by 2002:a05:620a:2911:b0:785:afa3:6c0b with SMTP id
 m17-20020a05620a291100b00785afa36c0bmr1042570qkp.52.1707462172230; 
 Thu, 08 Feb 2024 23:02:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUAg8M8iGRiKWGBTK0F258WihbbxWq59HmgeoEuDNeTusIZgcMUSJcV0Rs9wNXi8ZnIQelsm2D+CWqXa/44yhH2KEaGd/Q=
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de.
 [109.43.177.145]) by smtp.gmail.com with ESMTPSA id
 z4-20020ae9e604000000b007855e8a5e51sm492876qkf.19.2024.02.08.23.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 23:02:51 -0800 (PST)
Message-ID: <12a41472-5d91-4e8c-9cc1-e255313791c9@redhat.com>
Date: Fri, 9 Feb 2024 08:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unit Test Aborts when building with -ftrapv compiler option
To: Richard Schmitt <richard.schmitt@starlab.io>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <DM6PR09MB528878EFFA4532FF15D778DF9C442@DM6PR09MB5288.namprd09.prod.outlook.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <DM6PR09MB528878EFFA4532FF15D778DF9C442@DM6PR09MB5288.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.213,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 08/02/2024 20.23, Richard Schmitt wrote:
> In an attempt to build qemu with hardened gcc compiler options, we specified 
> the -ftrapv switch rather than the -fwrapv switch.  The switches define the 
> behavior of integer overflows.  -ftrapv causes an abort on integer overflow, 
> -fwrapv causes overflows to simply wrap without any error indication.  
> Wrapping overflows can result in unexpected behavior and therefore, 
> hardenened builds typically recommend trapping overflows.
> 
> The abort occurs when running the “test-string-input-verifier” test and 
> begins at line 129 of the source:
> 
> v = visitor_input_test_init(data,
> 
>                              “-9223372036854775808, 9223372036854775807”);
> 
> check_ilist(v, expect3, ARRAY_SIZE(expect3);
> 
> Where expect3 is declared as:
> 
> int64_t expect3[] = { INT64_MIN, INT64_MAX };
> 
> The actual abort occurs in “string-input-visitor.c” line 209:
> 
> *obj = siv->rangeNext.i64++;
> 
> The test, as coded, will generate an overflow.  Using the -fwrapv compiler 
> option hides the overflow.
> 
> My question, is it the intent of the qemu community to rely on the overflow 
> wrap behavior or should this be considered an issue and added as such in 
> gitlab’s issue list?

As far as I understood, QEMU deliberately depends on this behavior - at 
least we require -fWrapv in meson.build:

# We use -fwrapv to tell the compiler that we require a C dialect where
# left shift of signed integers is well defined and has the expected
# 2s-complement style results. (Both clang and gcc agree that it
# provides these semantics.)

  HTH,
   Thomas



