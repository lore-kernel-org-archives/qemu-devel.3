Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2201D6AAF4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8L9r-00072F-Kk; Thu, 02 Apr 2026 12:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8L9m-00071a-Jx
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8L9k-000378-Um
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775148271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PnUC1L4BkBN294VRbD4UmSNuyJ+uH34P03BQFu7pXZk=;
 b=QmyWgB3GSSrfWTVbTXNA3cPgv3ssJVwhiguvUmuVbvkhE7BGHzHPPbiFEO/WeJMMtNjTnY
 fBkowKTuzpFcJHKwA3UK9zLC0sAxNvuMp16xZbzO5tf5Uje2XoWszy/iUja2WU3YOuUyo4
 xEbIrxnyTHFmSUWisR5U4FMho9lj200=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-u_36SQHxPcq6ckcVg38_EQ-1; Thu, 02 Apr 2026 12:44:30 -0400
X-MC-Unique: u_36SQHxPcq6ckcVg38_EQ-1
X-Mimecast-MFC-AGG-ID: u_36SQHxPcq6ckcVg38_EQ_1775148266
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b9c4d923668so66231466b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775148266; x=1775753066; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PnUC1L4BkBN294VRbD4UmSNuyJ+uH34P03BQFu7pXZk=;
 b=Adxa6E370YPAJizrMrFU5PihU6aR5xTojxul9s/5Skt9Xh6LTNQNZ5tlXQsmOMtrYy
 Dhxd5l4FCXx0ErMX8TNUgwr7fH33YEOlkommyu6a/SJoQb20V8JmX6yfa6skd53lrPg5
 5rSBH1T6BbERTTRR2JApSOcRVHDJ4vn7Sx25+8IiJizu3D+eHFNblSBBv0hI8u96knhK
 AgYIazXm9qmhY4e7taYqSrHjhvWHtyhSfGXOAM8k7CGsF8gGSsCO3pRkKLRsdmJN2grY
 fnBN+AksZKC1S0/jI8FolwMLT99/9DACrqZK/YsEyqsi0FjptRSwfx0tM3EFOl1zYT+U
 P04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775148266; x=1775753066;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PnUC1L4BkBN294VRbD4UmSNuyJ+uH34P03BQFu7pXZk=;
 b=Y13mYTl6xKOmY2g9mi8z38aBDJGnJhdmb2HJ2PBRo/L/dsTjEGt5tMiLXwi5GUitjZ
 O69D3qgyPgb8n4Se0ftUWXHYof9p5l/F2+uUTC7kmrdjF+3FSeT5dyNCPMtzXw6DKNC8
 Dl7OnZQ+2sl4HW5Pv6rqWmxXmjZjCGsy1jJSqId/7B5khCUFfuHRrRbOEaCB3TO+9TXt
 vBCvzo9XUplJHRv7bhfAAfHg1V7gfuwdYpkK2Fl13++NERfIzyKesyQNXpquQ7UahcsD
 rd717lfFJnEVvRYScyitordMj1Th+w5U0/Orj2J2VXVL3qHtxjuZMYjjd3pQ8gmbOjo4
 Te/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXspOonXIdRP3gVoYurF8X1JdlAWD0ftBZozNgJ7VCsjYFJGBd+81vzTRao7jccdtPQjS/+gy67d0W7@nongnu.org
X-Gm-Message-State: AOJu0YykdfYYRZQGuw7z38hgwyLKKB4twtyvN8KQh0jbOzuz1cqFuLU7
 hixSC85c0DQcqEYkdODLlW73VFEzQ/BfWo3chfYzmVmwe6ymuI1KdxzQR2nG+2xutPH2Lx5utQJ
 50sCzm5DdQelOePm9Bl1cZD4cWt7oSHKzZ/XcjR5afCJYAaP4cfLyHTsv
X-Gm-Gg: ATEYQzwaZeAY3IQubW/ngdhdynSE6OOqgq8gO0Rhi8UeA8BrDdlu/ksXtIIgKmfJXQp
 +5y0xyGWiti4a0JBoMXQYGiRWi5Bh8Yn8cPf8c0418e13xGXxuAVRfAC3wX5wGSylKNVhllOuke
 Hs1VizdH4Mglr/tP7z5trAKCZaioCCQYEsnM4wMyLRaBs9259d2U5zfrYLLt/DntcHmiiWJ7NDb
 yqzursctKimkFOvavJtWVhhhj0+I2Ve1nIQxjo1Ve1SHNwvJHz4cwvpUmK8w8I8HIoTGry6FGdC
 M8XGo0fafBfEw9CYS70rJJXwc3QRpt+eLJZqxJM7e032XVyPK4+0cpQLYew8GKg/xkKfHctQ9Kn
 1ADzBJLHWSvWKspvxIKE=
X-Received: by 2002:a17:907:3895:b0:b97:c968:d9ba with SMTP id
 a640c23a62f3a-b9c1378f46emr553731666b.5.1775148265832; 
 Thu, 02 Apr 2026 09:44:25 -0700 (PDT)
X-Received: by 2002:a17:907:3895:b0:b97:c968:d9ba with SMTP id
 a640c23a62f3a-b9c1378f46emr553729666b.5.1775148265277; 
 Thu, 02 Apr 2026 09:44:25 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3ca9975bsm111228966b.22.2026.04.02.09.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 09:44:24 -0700 (PDT)
Message-ID: <2f86e58f-4fe0-460d-b517-2ae78a2d4509@redhat.com>
Date: Thu, 2 Apr 2026 18:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 00/10] Deprecate the qemu-system-i386 binary
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260402095132.29245-1-thuth@redhat.com>
 <CAFEAcA8EyCn83zEcysm=4Py-BsQKSBV0KcBUMjMm4Df-pF2BoA@mail.gmail.com>
 <988641b4-9e93-40eb-9742-63d8c1e17547@redhat.com>
 <ac6bSqRgUviOyXtF@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ac6bSqRgUviOyXtF@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/04/2026 18.37, Daniel P. Berrangé wrote:
> On Thu, Apr 02, 2026 at 03:02:17PM +0200, Thomas Huth wrote:
>> On 02/04/2026 13.20, Peter Maydell wrote:
>>> On Thu, 2 Apr 2026 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> This is a follow-up to my 3-years old patch series here, now with the
>>>> universal binary initiative in mind:
>>>>
>>>>    https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg04541.html
>>>>
>>>> This patch series allows to run qemu-system-x86_64 in 32-bit-only mode
>>>> (by renaming or symlinking the binary to "qemu-system-i386" or something
>>>> similar with a "-i386" suffix). After doing this, qemu-system-x86_64
>>>> should be a full superset of qemu-system-i386 (apart from 32-bit KVM
>>>> support, which however is not required anymore now that we removed support
>>>> for 32-bit hosts). It is now possible to migrate a guest that has been
>>>> started with an old "qemu-system-i386" binary to a qemu-system-x86_64
>>>> binary that has been renamed with a "-i386" suffix.
>>>
>>> I think my reaction here is similar to what it has been when
>>> the similar idea has been raised for qemu-system-arm : we should
>>> have a coordinated plan that is considering all architectures,
>>> not just dropping a single binary for one architecture where
>>> it happens to be more straightforward.
>>
>> Sure, I'm open for suggestions ... how should that coordinated plan look like?
>> Maybe we could simply stop adding new versioned machine types to the 32-bit
>> flavor binaries, and then let the old machine types expire? And when there
>> is no versioned machine type left anymore, we could remove the 32-bit
>> binaries?
> 
> On i686 the versioned machine types are shared with x86_64
> and likewise  arm7  'virt' machine is shared with aarch64.
> So there's no concept of "stop adding machines" unless we
> go out of our way to block what we're already doing for
> 64-bit from being used on 32-bit.

As an initial step, we could do something like this:

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -364,6 +364,8 @@ static void pc_q35_machine_options(MachineClass *m)
                       pc_q35_compat_defaults, pc_q35_compat_defaults_len);
  }

+#ifdef TARGET_X86_64
+
  static void pc_q35_machine_11_0_options(MachineClass *m)
  {
      pc_q35_machine_options(m);
@@ -371,6 +373,8 @@ static void pc_q35_machine_11_0_options(MachineClass *m)

  DEFINE_Q35_MACHINE_AS_LATEST(11, 0);

+#endif
+
  static void pc_q35_machine_10_2_options(MachineClass *m)
  {
      pc_q35_machine_11_0_options(m);
@@ -378,7 +382,11 @@ static void pc_q35_machine_10_2_options(MachineClass *m)
      compat_props_add(m->compat_props, pc_compat_10_2, pc_compat_10_2_len);
  }

+#ifdef TARGET_X86_64
  DEFINE_Q35_MACHINE(10, 2);
+#else
+DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
+#endif

  static void pc_q35_machine_10_1_options(MachineClass *m)
  {

... and similar patches for all other versioned machine types (i440fx and 
arm virt).

Then wait for 6 years, and finally remove the 32 bit target binaries ;-)

  Thomas


