Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E920EC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 05:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riSXV-00088z-FT; Fri, 08 Mar 2024 00:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riSXT-00088r-Pn
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 00:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riSXR-0000OU-VH
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 00:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709874776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7nAkU7cm7f85BDg+oumV91TbG7RunlUK9Bv2fRrQbEo=;
 b=dVzjbX9Xo8CvfRoA7SoZSbTmuJX12IJ+L5Kb7gHZE3+R7CF9tIfABiZ+h+FgVslyKeTBb4
 3FHIc2IspMx+qWqIF/sJoCayYa4OJYVrkQi4uu+cJrhVdmjuS37iH19ZG3uxCjhjkfjHqk
 jJf1Gxjm/P6OFqfJ2lUjoStVM7fyng8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-K7mbdCoVMnWMSueZ34a7yg-1; Fri, 08 Mar 2024 00:12:53 -0500
X-MC-Unique: K7mbdCoVMnWMSueZ34a7yg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d2b9aa4e35so9918761fa.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 21:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709874772; x=1710479572;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7nAkU7cm7f85BDg+oumV91TbG7RunlUK9Bv2fRrQbEo=;
 b=MMtmL4ySVNwHboFyAIJFRM9U/lh0huIwkXhRvyKdHQaNtuEt0lJTrpt6ol+klGQPsI
 C7sQwjMVgh0r00cqtGirRWfLPpUtSdsVmWb/X4hkbJ+vwtBewbKbDMBViglOzyHmRFW3
 gbiBQRdSVuzuc/B6hRoFItx62fVbhCYkZdEXoyQHSTDaMcaH5AK/wYcDeLeBemMBX9Vw
 hn2mP6cwCZ36bJGXnwcs+PhFX2hry6u9VWfi0y0MH2IaQ7mp2ZSEvy97sfcU4nB5qOT8
 1pYMUvJ2noTD5NxDwZHSz/rw1MxLHHh6+eCsV9oF9LtBtOeOu4t8Cva9y1GcwTBNjaIz
 bkmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhInGMhzCtArE/+FhZBSD9/I4A1rIFtih7rL+FZf3IEjih6iePNUqg8TVXcIOyVs4uCraqkBIA5o+zAxVrwEH/suTozFE=
X-Gm-Message-State: AOJu0Yz2jZ0Nt9ATMoHPQGFTebo1fj1DzQjU8CjGMdaJ4oEpRgh0EqCa
 9ZEtzbTNsDEfSGs/JIXXc/GDXUAS1QH4d/IInzljTpijOa67vRM5ae6HISJmP1AhDVJxsqsUw5r
 KXgXeV3Sv+ia4xRTpVmD6mth0wP+NvcfzKDVrBKJtNaX10LV+DNfm
X-Received: by 2002:a05:651c:2127:b0:2d4:1369:697e with SMTP id
 a39-20020a05651c212700b002d41369697emr2061457ljq.20.1709874772429; 
 Thu, 07 Mar 2024 21:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu4hH6RspwVBKoMC/vFBFB8dLvTi+2K0MeL2caF3nKym/oDXEgXvtXC/ux/uLm8H/hFgq7Yg==
X-Received: by 2002:a05:651c:2127:b0:2d4:1369:697e with SMTP id
 a39-20020a05651c212700b002d41369697emr2061447ljq.20.1709874772073; 
 Thu, 07 Mar 2024 21:12:52 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 h7-20020aa7de07000000b005664afd1185sm8737890edv.17.2024.03.07.21.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 21:12:51 -0800 (PST)
Message-ID: <e11f53d6-2e87-47eb-8ccb-aa35d2e17919@redhat.com>
Date: Fri, 8 Mar 2024 06:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/sparc/cpu: Rename the CPU models with a "+" in
 their names
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240307174334.130407-1-thuth@redhat.com>
 <20240307174334.130407-2-thuth@redhat.com>
 <79771813-9b46-4459-b286-e9ddb4549f83@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <79771813-9b46-4459-b286-e9ddb4549f83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On 07/03/2024 22.22, Richard Henderson wrote:
> On 3/7/24 07:43, Thomas Huth wrote:
>> +    /* Fix up legacy names with '+' in it */
>> +    if (g_str_equal(typename, SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IV+"))) {
>> +        g_free(typename);
>> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IVp"));
>> +    } else if (g_str_equal(typename, 
>> SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIi+"))) {
>> +        g_free(typename);
>> +        typename = g_strdup(SPARC_CPU_TYPE_NAME("Sun-UltraSparc-IIIip"));
>> +    }
>> +
> 
> Legacy names don't include dashes.

This check is done after sparc_cpu_type_name() has been called, which 
transforms the spaces into dashes, so we need the dashes here.
(otherwise I'd need to check for all "valid" combinations, like 
"Sun-UltraSparc-IV+", "Sun UltraSparc-IV+", "Sun-UltraSparc IV+" and "Sun 
UltraSparc IV+").

  Thomas



