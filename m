Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD1DC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfWG-0007Bz-BO; Mon, 09 Jun 2025 12:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOfWD-00075g-4u
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOfWB-0002c2-Ee
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749487118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PnOjUVOxZQIgogQhs4HSfRWIiU3AjxjEKeVgf6jSbAk=;
 b=jMgzOCh1IDtfaaBN1PT46YS5Em0fASd/CnGV0ZuNzQvRCa34VsBpSOlVMcsfhKBqFGTAcK
 ZDXLui8HnE4h8axwXYJp4pMbAJcmTRnHvVgrTbuUmKEX6he4neD6PbbtdAnn840k+Racfs
 RzvLfr4aECyiDhdUN28SfHJmSgBaMYY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-GutzuNe8OYG-Vi5jQD9cyg-1; Mon, 09 Jun 2025 12:38:34 -0400
X-MC-Unique: GutzuNe8OYG-Vi5jQD9cyg-1
X-Mimecast-MFC-AGG-ID: GutzuNe8OYG-Vi5jQD9cyg_1749487114
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450d244bfabso36419925e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749487113; x=1750091913;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PnOjUVOxZQIgogQhs4HSfRWIiU3AjxjEKeVgf6jSbAk=;
 b=O94pW56sZUbyZ5OMPoOwdwW1hcw2vP89QjQstcmHzOpVngyRMomt2NDII6xK9sL+/c
 +ne1jzRzcE3/P4TdkwF4NLMfqQ+wnwf6tHkfJalgg6LE/DL79CES0Zcibzzl1zx0RH+g
 xPxJro9SIrhOfvgEEQ2TCiTpdgn/NSi6F3sHY/7dsiho4J+iV9i2BMmwgNWlyhplOdnD
 VkZCHa7B0r2a1HEXIFBnCFCnUkI5tk4nBua8/1sUnoNCJLapj9V2EqomUeHFc9h5YXpr
 von9/EbEdGZErxejsf/dX309wobXwO5dMfcv3E9QBYE6Ldg+IRz/JEN/VqyHIAfql3yP
 yZ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDibSH5uHzxSCBZj3Y0n6H5kHnDthb9kEFSsndTwWpC6mprchuiVC/as9bAbn3F4qMphcUkh34i/os@nongnu.org
X-Gm-Message-State: AOJu0Ywarr0ArSo8MaqPPtnTIEEPaAwYG5mkLiDgIHK8CzgXEqHOpAbr
 NxhV76rIN05Cf8gBvD5TeRH2E5r0pAynDbCBDiYENyEspOD+y7at93+oGeHiu/QXeAnaIztKurx
 EvRbQQgW3j9xYhEyJWePH+f8SOmtJRXi1uGh3Jccg2Z7Zq1uRV+gOORC/
X-Gm-Gg: ASbGnct1kHn/m8Y8743VKSapizMPLKf3JcHmL2QQUJe7W4G0FYUY8MmpisyOEp28hGq
 +J/GKDL/jJMiHnJc5RiToRHH5HtGyth11mNK1qh3qCJrsH3kHVj/C+ehjLgOseJfU0MxDPsKkW+
 /Y5YFN/+GCCYViOetI5sBGF8BXOy25kJYmf53gZxl94Y1ZtqPspLcyUcIfd9JJdMHvg/CslOz74
 fmx/VroxtIxz0dEgzmBxlgxBto3ERwvka74OOgrVtbZkhXgkhyeQoCS5tsEjMlQ3RSBdpiXmrZF
 wryWnjvvAoBoSw==
X-Received: by 2002:a05:600c:c104:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-45307458ae4mr57726775e9.12.1749487113541; 
 Mon, 09 Jun 2025 09:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKmOo5EPAMbX5DAjxN2zeN3jUs3xEUPmibQuxCYxFGcugmAcSS3H6nKcn7cgRTDUF9Wc4R6g==
X-Received: by 2002:a05:600c:c104:b0:453:745:8534 with SMTP id
 5b1f17b1804b1-45307458ae4mr57726575e9.12.1749487113208; 
 Mon, 09 Jun 2025 09:38:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-451f8fd2b89sm69606555e9.3.2025.06.09.09.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Jun 2025 09:38:32 -0700 (PDT)
Message-ID: <04c3ef19-deef-44a9-b056-3b295246ad5a@redhat.com>
Date: Mon, 9 Jun 2025 18:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] docs: Avoid duplicate labels with a sphinx extn
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250429163212.618953-1-peter.maydell@linaro.org>
 <CAFEAcA_hV=962gFfKc-7D91X-MXxVs=VrKQVzOKaLS2gJDt5Lw@mail.gmail.com>
 <CAFEAcA98gbjUX08NccePxGB2k0S+fjFArgz4WjFc5CZdDQ0ezg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA98gbjUX08NccePxGB2k0S+fjFArgz4WjFc5CZdDQ0ezg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 6/9/25 18:18, Peter Maydell wrote:
> Ping^2 on this one?

No objections if it's the easiest way to solve the issue.

Alternatively, is there a Sphinx way to write something in the spirit of

#ifdef DEFINE_THE_LABEL
.. _label
#endif

This way, you could have the nbd label enabled when including into 
system/images, but not when including into system/qemu-block-drivers.

Paolo


