Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5A7C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 20:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZyLg-0002Qg-HQ; Mon, 20 Jan 2025 15:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tZyLe-0002QV-QW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tZyLa-00084D-Tc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737404769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SX4XhTTgvUyedWCIkQ6NCrH72F1OBgxDjm+F1qYS3K8=;
 b=YafQoMY4pMYCBZ8tdhuqleCAjDb0kpMP9qqs7mOsqNkBhNLuRrPyRjGH7Nena4cAiZMLX7
 /bbgHlwh1s2AraPjOunj4L7fB6lGeSrtiADGm+SAx80y0vecuRIul4eRyqZQhZ1iK9Q5A3
 3q95F604UmZIHSjj2WNBAwg5hI0PWck=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-hIvS-YTXPP-zRGEIQykMYw-1; Mon, 20 Jan 2025 15:25:56 -0500
X-MC-Unique: hIvS-YTXPP-zRGEIQykMYw-1
X-Mimecast-MFC-AGG-ID: hIvS-YTXPP-zRGEIQykMYw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436248d1240so23712235e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 12:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737404755; x=1738009555;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SX4XhTTgvUyedWCIkQ6NCrH72F1OBgxDjm+F1qYS3K8=;
 b=JfM04skJ/1vOONZaUd5sIfqFris69w1XtsA6laplWZ6ercdpk+LZysHzh7SWtBaqQ8
 ydOSVrKTR60sWTd9t0q6JiCKCfLsAbzIbEKC8v6rak518lxu//9xeTUwvgYN3ITFSv+1
 //NG6T5EsE1bAjE6bU4NrZ7iatK0XgPrqnaDqZjtWJrxvL7RLRAaU8GXTpQCVaQW9VLC
 4b+UUOF8tV0VC/sXvyfeneTz0lN8ri3umr1G8TQDpFyscXco4xOjsO5nxTTEy4N4HdRc
 dHdYpwlWFqPjMwa0RjOVP+jmC6SF47XBN7oYcCTpNrOApjCYpy87qonw888Y/n2bmOjm
 Hm1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ZKybVImBzPEhkmjAUof7Im+vONYserRViV8I42q6xNe8379aSL50gjgYhisk5V2+h9w//LFq3+cL@nongnu.org
X-Gm-Message-State: AOJu0Yy/mmmgjHugRm2uLizEi58ysSWWvFcd1DGrywWPOE0Ijh7YCsb6
 Oiu26Lq4KRFDp48mJCWxS1KrYRs5iX3BUKBBwzCkWKob+4crFfmMr8holZZZpe9VURzHJ7w7WtV
 FxxN124DFFh0LbdO/u8fKXVcodCZqZtIFNTJGGGbUfL6RmbF8G11y
X-Gm-Gg: ASbGnctXq5usm1UPiyzLYNZklmUB1GO1kmCoDf+J+ZrUHBVFw0bUexI59dGjrDeuv6l
 7tGVRQzdJIjeqEQpqylbo7iEtAnB26hIOQ/0VMNv62/suGaOjdyvzmbQ8nBEcsOjDE0dVYPtujU
 NX3L39tffzZCVmmSxm5C7QLUITge15EQgOS1/hdWuxMyS4zHvfCDnJEwTeOA4PD6Xqd24rEVsH/
 03/dCIf34xJ473hVF6iutw4/bX3nuW/CEm1cNdi480VDmanxuwoE+KUhLSFU6avyLQLnXA8tutf
 pbwd/qiMRwpbm8wZKa3Brxq0uAHs69g7xUVDlalAjVIesCzPdV4XKX6qMR36q2Zz7YMDR5lpgDS
 VWtlMCt2NTvlIx3+NB43Umw==
X-Received: by 2002:a05:600c:4f84:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-4389144fbffmr146996435e9.31.1737404755634; 
 Mon, 20 Jan 2025 12:25:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFldN9qp5couChV3iXffXexECj3Up8UkpuBKDPK2O0owJVe4OWsUnJxqoWElK17bk+6BeVD8g==
X-Received: by 2002:a05:600c:4f84:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-4389144fbffmr146996235e9.31.1737404755307; 
 Mon, 20 Jan 2025 12:25:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:e400:431d:9c08:5611:693c?
 (p200300cbc72ee400431d9c085611693c.dip0.t-ipconnect.de.
 [2003:cb:c72e:e400:431d:9c08:5611:693c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438a1ec39a3sm101412595e9.16.2025.01.20.12.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 12:25:53 -0800 (PST)
Message-ID: <b812fd19-055b-4db1-bdff-9263c8b6b087@redhat.com>
Date: Mon, 20 Jan 2025 21:25:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
To: Peter Xu <peterx@redhat.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, Chenyi Qiang
 <chenyi.qiang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-3-chenyi.qiang@intel.com>
 <d0b30448-5061-4e35-97ba-2d360d77f150@amd.com>
 <80ac1338-a116-48f5-9874-72d42b5b65b4@intel.com>
 <9dfde186-e3af-40e3-b79f-ad4c71a4b911@redhat.com>
 <c1723a70-68d8-4211-85f1-d4538ef2d7f7@amd.com>
 <f3aaffe7-7045-4288-8675-349115a867ce@redhat.com> <Z46GIsAcXJTPQ8yN@x1n>
 <7e60d2d8-9ee9-4e97-8a45-bd35a3b7b2a2@redhat.com> <Z46W7Ltk-CWjmCEj@x1n>
 <ba6ea305-fd04-4e88-8bdc-1d6c5dee95f8@redhat.com> <Z46vxmZF_aGyjkgp@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z46vxmZF_aGyjkgp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On 20.01.25 21:19, Peter Xu wrote:
> On Mon, Jan 20, 2025 at 07:47:18PM +0100, David Hildenbrand wrote:
>> "memory_attribute_manager" is weird if it is not memory, but memory-mapped
>> I/O ... :)
> 
> What you said sounds like a better name already than GuestMemfdManager in
> this patch.. 

Agreed.

:) To me it's ok to call MMIO as part of "memory" too, and
> "attribute" can describe the shareable / private (as an attribute).  I'm
> guessing Yilun and Chenyi will figure that out..

Yes, calling it "attributes" popped up during RFC discussion: in theory, 
disacard vs. populated and shared vs. private could co-exist (maybe in 
the future with virtio-mem or something similar).

-- 
Cheers,

David / dhildenb


