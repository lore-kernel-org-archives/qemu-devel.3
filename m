Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41ACA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 08:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umSzq-0002A6-G6; Thu, 14 Aug 2025 04:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1umSzo-00029q-53
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1umSzk-00013u-Lt
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755158850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aw6ElKPrxJaqLuNhgoU229hFO1WzteZ5QqmH5MUjSf4=;
 b=KSzdpka9743Beye4Qs/x3oLVAmeEHnj+kpsMgkrXLtI+azbacOVEyQtgYBXnfjFZgXEltQ
 ymnhou344XL5dppzpHfz5/wWU9Y70vR2MTvPm9G/3Ex7os8XjF+/8WGfOXzpwVaHeXaENC
 +imyTqsS555+/r4kCYhdZMWj71ZAryk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-krs6YUs3MaOtRVPEcAO__A-1; Thu, 14 Aug 2025 04:06:17 -0400
X-MC-Unique: krs6YUs3MaOtRVPEcAO__A-1
X-Mimecast-MFC-AGG-ID: krs6YUs3MaOtRVPEcAO__A_1755158777
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a88dae248so16534146d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 01:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755158777; x=1755763577;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw6ElKPrxJaqLuNhgoU229hFO1WzteZ5QqmH5MUjSf4=;
 b=BkzlLlNcnvMuxvKDyDCXoC+2gsk7FRyyz6lbEcwW2NSug9QtJx6hu/1xNXiSARun6n
 H1oW07j3Ri/G6syjDBsZeGFkQLvv0GhAvy3ksyqJxBOy4QZE1r+W6AVTyOBs0yZNGGjJ
 5WqcLhpWpqXY7kffQyVRkEkcRT4ooJpTIT794KdRe52SfqI5V/CTL8d0GNrGbjPRlobI
 GfPEqs8quPIT0srjqGgw9ko9DkEihvZt+Qcxl+JR0KUhrRMHonq2nRVFEMsIz4oo2vas
 GUcNNq4Aidfu5xDoFOVGVdQUpM4/3D620a14kx7w2fp9zA5WwI/+CGn98tjinQDE0Bq/
 TLQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjdzdfm9AXgaJgzebKf1rEY+xY5tz5kW1kYsu3gGPz3Gdkkqru/5r9Zec3uBaj+a2t4aLvcCRHWwL@nongnu.org
X-Gm-Message-State: AOJu0YwNKK0LVq9dZKAIbuvOKmCgJCkAH3jDmGBd+O+lc8ZTtxniuHC5
 QSfWgs7bUG3NOahqQ39BZR50PNLyPNPmiJJ7RRRjo1l439PvTWuE/JOPen1ML68jCBN8xIucX/O
 hH2LPwNL9Ia9rAatN2O+sFvgY/4BkuaE14zmu4vXFIcx9bQ5P71KLOyXt
X-Gm-Gg: ASbGnctJBjOBcyqNGp1P6lsQ25iLmaGrZDFIX+Eu4KFNIih4DVk4BCVOPO+a5TB4z6I
 x0YEAHqNwXMmkKk8qEIntBqAJIzpQxIbu5HI2HGgOsvhOMC/NO91xVuJG8StGY6oFEL4W4XQf5Z
 ABMgwU96Cf+vTAJ03WIBHWiP6DeymF7lQy0093bj7DkEQqr5YTDb/+xI625heEg40bksFT7FeHQ
 YRxyXp6iPNNsV5cNPxLB5RXSMdlwFJPSPjP+Ng2hzGU11GP/7dTyHgp4RtirjmmYWJmC3G5ZgC2
 E8noXKl1JEsdvxB92cWghcfZiiFQuy0kUBz4NO4=
X-Received: by 2002:a05:6214:2627:b0:707:612d:3adb with SMTP id
 6a1803df08f44-70b97e2ec82mr19491336d6.18.1755158776844; 
 Thu, 14 Aug 2025 01:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7lVUmLcn69AeEGlIltasyng2VdZBjCKeuYdoN1KmCwRsZIIixWIrMuZD4aCM/GKm/xByjQg==
X-Received: by 2002:a05:6214:2627:b0:707:612d:3adb with SMTP id
 6a1803df08f44-70b97e2ec82mr19491116d6.18.1755158776397; 
 Thu, 14 Aug 2025 01:06:16 -0700 (PDT)
Received: from [10.43.3.236] ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ae6cc98e4sm10293116d6.21.2025.08.14.01.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 01:06:15 -0700 (PDT)
Message-ID: <23a9cb5f-dda8-403d-964d-b27338d6c94a@redhat.com>
Date: Thu, 14 Aug 2025 10:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QGA installation issue on Windows
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Jan Tomko <jtomko@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
References: <CAPMcbCpSQS5yWUCcGum6nWq=+HTaxFmJjm57_cgmJp+fMtC1JQ@mail.gmail.com>
 <aJCTJf67oTZseYUr@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <aJCTJf67oTZseYUr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/4/25 13:01, Daniel P. Berrangé wrote:
> On Mon, Aug 04, 2025 at 01:54:09PM +0300, Kostiantyn Kostiuk wrote:
>> Hi Michal,
>>
>> I want to discuss your patch
>> https://gitlab.com/qemu-project/qemu/-/commit/c6f5dd7ac8ef62dcdec4cdeda1467c658161afff
>>
>> Unfortunately, we found bad behaviour on Windows. On Windows, we run QGA
>> with `-d --retry-path` options by default, so we expect that QGA will start
>> even without the vioserial driver and will wait for communication
>> forever.
>>
>> This worked previously, but after your patch QGA service fails if the
>> vioserial communication channel is missing. This behavior is totally
>> unacceptable for us.
>>
>> You send this patch to fix a Linux problem, but it causes a Windows problem.
>> So, what we need on Windows, if --retry-path specified, we should ignore
>> any channel error and retry the connection. If -d and --retry-path are
>> specified, it should become a daemon first to make Windows Service Manager
>> happy.

The original problem I tried to fix was (and I am bit hazy on all the
details): when somebody built their own kernel but forgot to enable
virtio-serial then qemu-ga would fail to initialize but with a
completely irrelevant error message.

> 
> This looks pretty simple to fix - in the initialize_agent() method, if
> channel_init() fails, then simply ignore the failure if 'retry_path'
> is set, because the later code in run_agent() will already correctly
> retry the connection.

Yeah, do you want me to post such patch?

Michal


