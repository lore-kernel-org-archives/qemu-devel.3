Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532D9C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqiU-00019r-Fh; Wed, 21 Feb 2024 12:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcqiS-00016R-Au
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcqiP-00058A-CG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708537744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3LCRHBUB44VCRx1SbzrRwRIjtYFeaXSC6AIvpMGPcKQ=;
 b=XL4m3Yom+d6IGoaWVT2ZnCcXzsI3uRygzagDt5JblMRyWPXYTLy0mMboPWAUkAGZPkBAx4
 CPJL7naKELWwxLNuLIC4UhltSfj6tOla3lgoaXROH3rUbwu124gXq7W1xCdLzSXbeM1tzE
 lk3Bgr05ADQvlh7GBUhjMjYWdA5DyHs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Qccm7D4VN6KNgusY3s-2RA-1; Wed, 21 Feb 2024 12:49:02 -0500
X-MC-Unique: Qccm7D4VN6KNgusY3s-2RA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d11878726so2810418f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537741; x=1709142541;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LCRHBUB44VCRx1SbzrRwRIjtYFeaXSC6AIvpMGPcKQ=;
 b=K4kUZDrpLRWLae9shj/GC3K1zPfAMEx8QC6Wy+Rr9ofJyB7UhDAijM75XCDbvYwkKk
 Apv7cCVbhpUBWpAx39tKegsOPjBdgy/dquIdITorkdkUrXJG5VnFIDmngsj+NAM8WLpm
 ndkTjqIFWcTc7g+U3E79s5/Ygj+7xS4F3hE5aE2+NwnZUl/BIDdOtKrcB6DhQPfoGKtx
 R65sImeifmhaOo7+FkBCcJtnxJVNsxxwLdw3IRVlKWaQ2n4kNRpvnOxiUGinw2sXQRLb
 mgKQ66reIECvhdE9ACY09fAOKlIHffe6X7Nzlh0c5q6qP9GwlmXctr3UcTi3JBbfJztD
 JHvQ==
X-Gm-Message-State: AOJu0YywdZvm6jxEF6X34SVH79BYQbCYZ8xh2VS+FmzhWiZizp+5Kqk1
 JqUptBJd5OAuZtvwV2D+YaBaK78Vxk+sjNUNz83MpFOHwx1z5VOnTr2YIj5vrqSnF6A7ATqv0R0
 MCCydRCeeZ98NmoMUpyQqAPXBhY6RPyUB7ntgjJ6jGlvlpH1JX4IbemUq0lP2naRVTWwRkjBV3K
 fNQ/o3NUftgpObZiFDibsxlJOTwGV5DgQr
X-Received: by 2002:a5d:4b4c:0:b0:33d:3665:666f with SMTP id
 w12-20020a5d4b4c000000b0033d3665666fmr7879425wrs.44.1708537741332; 
 Wed, 21 Feb 2024 09:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2udLz4bLNBkrqI1dlNDAyHhZamoi4wm37iqDymN1vceom076dbP4NTbUvvpzV7fIJWEyW8g==
X-Received: by 2002:a5d:4b4c:0:b0:33d:3665:666f with SMTP id
 w12-20020a5d4b4c000000b0033d3665666fmr7879408wrs.44.1708537741003; 
 Wed, 21 Feb 2024 09:49:01 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c19d300b004126ca6c241sm7475815wmq.23.2024.02.21.09.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:49:00 -0800 (PST)
Message-ID: <34e092c0-35b8-4f8f-8ed1-1f5aeb0f9d07@redhat.com>
Date: Wed, 21 Feb 2024 18:48:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] meson: Enable -Wvla
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-4-thuth@redhat.com>
 <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8dac5c1a-5780-45ca-90fe-147f1ab2fe28@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/02/2024 17.59, Thomas Huth wrote:
> On 21/02/2024 17.26, Thomas Huth wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>>
>> QEMU has historically used variable length arrays only very rarely.
>> Variable length arrays are a potential security issue where an
>> on-stack dynamic allocation isn't correctly size-checked, especially
>> when the size comes from the guest.  (An example problem of this kind
>> from the past is CVE-2021-3527).  Forbidding them entirely is a
>> defensive measure against further bugs of this kind.
>>
>> Enable -Wvla to prevent any new uses from sneaking into the codebase.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Message-ID: <20240125173211.1786196-3-peter.maydell@linaro.org>
>> [thuth: rebased to current master branch]
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   meson.build | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/meson.build b/meson.build
>> index c1dc83e4c0..0ef1654e86 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -592,6 +592,7 @@ warn_flags = [
>>     '-Wstrict-prototypes',
>>     '-Wtype-limits',
>>     '-Wundef',
>> +  '-Wvla',
>>     '-Wwrite-strings',
>>     # Then disable some undesirable warnings
> 
> Sigh, there's a new warning in the latest master branch:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/6225992174
> 
> Caused by commit d65aba828 ("hw/sparc/leon3: implement multiprocessor")...
> Clément, Philippe, could this maybe be written in a different way that does 
> not trigger a -Wvla warning?

I think the DO_UPCAST is wrong here - if I got that right, DO_UPCAST is 
supposed to check that the second parameter is at the same location as the 
first type later points to. This is not the case here. I think we rather 
want container_of() here, so this patch is likely a simple fix:

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -150,7 +150,7 @@ static void leon3_cpu_reset(void *opaque)
  {
      struct CPUResetData *info = (struct CPUResetData *) opaque;
      int id = info->id;
-    ResetData *s = (ResetData *)DO_UPCAST(ResetData, info[id], info);
+    ResetData *s = container_of(info, ResetData, info[id]);
      CPUState *cpu = CPU(s->info[id].cpu);
      CPUSPARCState *env = cpu_env(cpu);

I can send it as a proper patch, too.

  Thomas


