Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3565EC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visAE-000303-U2; Thu, 22 Jan 2026 05:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visAB-0002vs-Qu
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:43:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visAA-0007za-8f
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769078621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LTltZq9+JCsUWsSmaaNgTGkB37YX5SdewpF/HCOajP4=;
 b=HCohk/ueHVpJt/CTGF+IenCYqHJnLVXCIhzENHhqVRwtSnhhipJdaAJcGAtw0kMYgE44e6
 IymgeTq7fceQsFnTa4TkMeo9zV1WnnbJRzQFBEAu5oWw2jyUe/jXGT59PNvFus2IzGKl+U
 R56QZYt1IT9Vj90v85YOgRLLhkGG2hE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-hns4VqWFOoylT68bYltatQ-1; Thu, 22 Jan 2026 05:43:39 -0500
X-MC-Unique: hns4VqWFOoylT68bYltatQ-1
X-Mimecast-MFC-AGG-ID: hns4VqWFOoylT68bYltatQ_1769078618
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801d21c280so5497695e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769078618; x=1769683418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LTltZq9+JCsUWsSmaaNgTGkB37YX5SdewpF/HCOajP4=;
 b=tuO7UJKxpRw1hsSdXxxGO198WTtTfmVmO6/ybZtPNXGj7DFB44j18RaOkngLlSLucA
 ikgfTERa00mSKKv99kPMfTZPabuOhSbKFfiJ7vvHaaU00jVcqpiPZROBPG8l4E5ar0to
 LGDAIYt/jwudv6k1XKDxyr8QApq4z7PH9Cvi33qE2g+noEIZv8robqGM/5Lu76h8hM/8
 Amvsj4XAPilbYbUn7UoLtAkV9l8jKoOU01uGokFu/J+W7ilyCCd6C+9UR7UQg0QZv58s
 6z6dBaM7unwvfO1brJBXBVRjLRCL8kTF+5bsOXPAxhg3RNLzbIeLzgSbHqTbCrcLq67g
 54Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769078618; x=1769683418;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTltZq9+JCsUWsSmaaNgTGkB37YX5SdewpF/HCOajP4=;
 b=fwvl5M/FP89MK9OdMfMqy7Mbp6f07aITFopDDtG0gIP0vTEqe5Fv86BcfyNvE7SxJB
 IxHIm9Bpd5hb/HttmVEK3STCqL9wmAP0yXsPMmWOh250DwmSB38AplEgkQsJJypnF2bo
 uy3A5mZv6L1oRVgs76HH4ZvmPYA2jNvfpBtC1VMY8AZzdyXJFcrfohH2ZlO/YTZrt5Ef
 AOKWm9KYwaQrpb/8ZkVgLn2cB4QXOeoFCyY5mlwK8ZRHwuIP2HCZilPDVegdqOnzFzgQ
 kMHvk2UtBKgvTE9ysokiQxGSXRKCwC6KOR43eiVZ+xMjshFe47df5JOkAvycc70oMUAM
 fm1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0VNhWzVxbXGOwzLigWQbHrDmFADR6cDoCnFnW9rIu7IQ35+6bSqFagUAUtTqOLOgtzPZQ2zEciLiU@nongnu.org
X-Gm-Message-State: AOJu0Yw274e1ZsZF3TtpkiFPOwdRu83Mt7OVGIl18K6XsvNcPaULPvmy
 T2o34ZSWRFBIm33XMrroxebZ2VqTVM48NtDYZuUwCOZL277pCDkA5DGMnlSKVYg2iXAW3ARMPSJ
 GSG1XWdnQdQkLmujCu9g9DQ5oUsQOyLDX+cy8u+PtQ0VF569MEd7cuE9J
X-Gm-Gg: AZuq6aKNtyvviHC/3xudR9vQqip2BpA4/otHHTso1Re2xyEMhGuPPGCHgDBWYEQ24UH
 OiFzPFnDcC8p5qlzW0WyEqgDtDF7ZIPaHQh7nc2i3Hg2KzGl+jHJwsq5ZV1YWUrxlJxFnshHZhZ
 67JNI8P5Or8T5PHjBz3QqtIBu2m/5oHd2/tVRiZf2/6FjMvx6Y2Gj6HL4jCmEzF0C2rgK2EtdE8
 ufyqUqysZTkGngtFRjeEJROtfW5XFMfMmHN9x5mZYMj92PF+e41Q5aBexfWIIgY9klDJ4lYYmk1
 PsY5c3JE+9K2qcnZBFSsHRssb/ZNdSuIivCivQ69bisl4k69q1S1Rq0g1/5by0gSth1DiY7aRJv
 z0u3QsxM=
X-Received: by 2002:a05:600c:4e43:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4801e358875mr290739805e9.35.1769078617735; 
 Thu, 22 Jan 2026 02:43:37 -0800 (PST)
X-Received: by 2002:a05:600c:4e43:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4801e358875mr290739265e9.35.1769078617247; 
 Thu, 22 Jan 2026 02:43:37 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804252b02dsm49755985e9.5.2026.01.22.02.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 02:43:36 -0800 (PST)
Message-ID: <130b8f26-2369-48f5-bbd6-e27210707b9f@redhat.com>
Date: Thu, 22 Jan 2026 11:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aXH4PpkC4AtccsOE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22/01/2026 11.14, Daniel P. Berrangé wrote:
> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
>> Hi Marc-André,
>> I haven't seen discussion about the project ideas you posted, so I'll
>> try to kick it off here for the mkosi idea here.
>>
>> Thomas: Would you like to co-mentor the following project with
>> Marc-André? Also, do you have any concerns about the project idea from
>> the maintainer perspective?

I'm fine with co-mentoring the project, but could you do me a favour and add 
some wording about AI tools to 
https://wiki.qemu.org/Google_Summer_of_Code_2026 to set the expectations 
right? Since we don't allow AI generated code in QEMU, I'd appreciate if we 
could state this in a prominent place here to avoid that some people think 
they could get some quick money here by using AI tools, just to finally 
discover that AI generated code is not allowed in the QEMU project. Thanks!

> IMHO, our baseline for functional testing images ought to be
> a Linux Kconfig recipe used to build a dedicate kernel, plus
> a busybox build for the target.

Not sure if we want to add kernel compilation time to the functional tests 
(even if it's only done once during the initial build)...? That could easily 
sum up to a couple of hours for a fresh checkout of QEMU...

  Thomas




