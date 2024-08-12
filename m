Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE99BC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 07:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdPYk-0000PQ-Mu; Mon, 12 Aug 2024 03:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sdPYi-0000OX-VC
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sdPYU-0004l2-M5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 03:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723448005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zT6wuCKiRsYdiQxfFQSrTjOcl1iJ0UV60/tdF3C+AGg=;
 b=RhskZwPxIMfug+fP537srzG/m4H1NGkXs24qFk+IE89C+1kBq+7I7+V2FZAaX0wwI5f1Pr
 sBd8gjicbYawd58MXGYJ5sOPKNhwT3jSVyh79TBi2WEo3MA84nXgi1B2T9cnRuNER7LhPS
 l9Qh4isw1ZVnV4mCDIQIFaoy/KJzrcM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-mJJ887zRMCydYKRd3bdIUg-1; Mon, 12 Aug 2024 03:33:09 -0400
X-MC-Unique: mJJ887zRMCydYKRd3bdIUg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4280645e3e0so29096835e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 00:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723447988; x=1724052788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zT6wuCKiRsYdiQxfFQSrTjOcl1iJ0UV60/tdF3C+AGg=;
 b=lO81sgpgMNQ7uRgboSi6FSzhxD3vpPNo0sSfh0FVNanAXihmzk7xMxHDJYYAZQ7Npp
 otnHHGz0Ygm8wO0K6tF6rXjIgU7PPfsLnfYr2/Mu6lZWmhcKK/LYA93FuLe2X/5ah1wh
 ttkw8GXt9H4uGafWccEup/n5V24OwwTAac/dOk/burJki/rpXcyVpn/xQiztkkpb8uvu
 MJw80Mur9mkT1vxpmxmW3VD6LaLGc/aqdQMbYPYTKwUmbyBrzCUDzFTtZq/3HTRLuj2c
 jNOh6eRHPWKMyBVcaeegMwjQY+P5OiwcGvr3Xdiyn0FxsuxcDIAlIwUsDr3U3ytI/rS6
 QUyA==
X-Gm-Message-State: AOJu0YybqQJfljm7ZrzVeGrW+Xj5UZzHRvzJeHz6KwDj8RZ8G1keDtFT
 DmzU/U37fjaHF0iUqRceJPZzesJo8cmkxsmiZf8/VxK5lLl6mMPPvDNZWjF45tA86lG4XuqcLxI
 pB3HOwYw2C5WMw3ggjJS/di9jYdgTlNz+EA8bcr5qRzFjXg/+C5VU
X-Received: by 2002:a05:600c:45d0:b0:426:5cee:4abc with SMTP id
 5b1f17b1804b1-429c3a29abcmr65727335e9.20.1723447988243; 
 Mon, 12 Aug 2024 00:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCkcbvTf91I/LLuOWtCCOIOmgKFN1F9vkNdpjC6am8P5LHrXE56bSD+iUiO+VdlmRX8CE9g==
X-Received: by 2002:a05:600c:45d0:b0:426:5cee:4abc with SMTP id
 5b1f17b1804b1-429c3a29abcmr65727045e9.20.1723447987778; 
 Mon, 12 Aug 2024 00:33:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c36bd6csm6701474f8f.6.2024.08.12.00.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 00:33:07 -0700 (PDT)
Message-ID: <8b73937b-9361-4ff5-a4b2-344cc64ed6aa@redhat.com>
Date: Mon, 12 Aug 2024 09:33:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] tests/avocado/intel_iommu.py: increase timeout
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-4-crosa@redhat.com> <ZqdvR3UFBCAu8wiI@redhat.com>
 <CA+bd_6Lepg=uXs1NViYV5eZBGot2ZRAYUi-NDXwSBsdBk17LPA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CA+bd_6Lepg=uXs1NViYV5eZBGot2ZRAYUi-NDXwSBsdBk17LPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cleber,

On 8/1/24 03:02, Cleber Rosa wrote:
> On Mon, Jul 29, 2024 at 6:30 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
>> On Fri, Jul 26, 2024 at 09:44:28AM -0400, Cleber Rosa wrote:
>>> Based on many runs, the average run time for these 4 tests is around
>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>> default 120 seconds timeout is inappropriate in my experience.
>>> Let's increase the timeout so these tests get a chance to completion.
>> A high watermark of over 5 minutes is pretty long for a test.
>>
> I agree.
>
>> Looking at the test I see it runs
>>
>>    self.ssh_command('dnf -y install numactl-devel')
>>
>> but then never actually uses the installed package.
>>
>> I expect that most of the wallclock time here is coming from having
>> dnf download all the repodata, 4 times over.
>>
> Exactly.
>
>> If the intention was to test networking, then replace this with
>> something that doesn't have to download 100's of MB of data, then
>> see what kind of running time we get before increasing any timeout.
>>
>>
> I was trying not to get in the way of the original test writer.
>
> Eric,
>
> Are you OK with replacing this command for a simpler file transfer?
> Any suggestions?
Sorry I am just returning from PTO. Yes I am OK to replace it with a
file transfer if it takes too much time. When the test was written we
just found out a bug with that exact dnf install command so at that time
this was a reproducer. Either replace it with a dummy file transfer or
withdraw it from the automated tests.

Thanks

Eric
>
> Regards,
> - Cleber.
>


