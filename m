Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11178C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 18:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpAD3-0005U5-4L; Mon, 03 Mar 2025 13:08:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tpACs-0005SH-SB
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tpACp-0002Wl-UH
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 13:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741025272;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBLGARsSGkigOBi6cELIuVucqv4iup6isxmDe0b/drk=;
 b=AsTkEEWHhjYTbM0iDQdvHCguyaCCO+Kd6qZ5cM5BTz9k4p05REoXXUko4xJzwInEdCWVZT
 LZjDc7E7c+OnoNKD2IlRNTMIbZ6SnxhudOku8c5+K8Vp2vtbhM4rNdPAdw0nItQu7E1I/5
 fQLe2AtJo/al8juNbh2+KCWiVsrnXls=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-f398Oz9hNT2zjEBuqs2d_w-1; Mon, 03 Mar 2025 13:07:46 -0500
X-MC-Unique: f398Oz9hNT2zjEBuqs2d_w-1
X-Mimecast-MFC-AGG-ID: f398Oz9hNT2zjEBuqs2d_w_1741025265
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-390e271517fso2775667f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 10:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741025259; x=1741630059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rBLGARsSGkigOBi6cELIuVucqv4iup6isxmDe0b/drk=;
 b=NTH9U5VUnR4UNVx6HBrbCzkQq+ZyJHLUwNLZJzqWc0ZLs7CvOfKZ9ibxnbEUgRC8ip
 9iOChwHJ+xgpR4ooGQX1AiApoqEBDwsfCVok4uND6QJNwo1vPwlJpfykvi4n1ZLWRFMh
 JdV849NP3bTqOYVWVvHrGMu91YDnM550R+7XWLUGft0AGYn9+5AQQ+nS1vU/ss7Si/Al
 ISKuS9m8+VGG9x7EkqJQe4tKkfp6CacXbsIE0wbuzEkHHAAz44DGvD7ZK8p9aANFjsg0
 vMzZed5QwzfIa9SFk4N2vvTNQTRNutW+P/FAt5thgzlvyNlcXHtWCoIL3xqMrWxRzCCS
 tm+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyUufJUsfm0lJ4l8+nL4H0nE63pnlqMIaH1ex3UjUXZdwLV/oZ+ZyHKVprApo7rm1f3IKDEckNjSSB@nongnu.org
X-Gm-Message-State: AOJu0YxwZrQnIAH8krSRjwp3m6QWL5rLZd0upVvO/t7C1m7/9cOe4i8f
 Vk8Qs57ja8fOv2yRCj+i0sEeeHGRxa9YfQgSVQYKmtI+0OoIX9QghKjhX3LbT2+Ln5pOqBGJd+L
 5XnW2ddxkQov02L0xQkrIGiFYUR8B302Ld1kWotvj6xE+T0jeHfLe
X-Gm-Gg: ASbGnctubl6LTEPx0L1t9h4gVl9Xq11g8kOYjuSrRedg/TLPUY3vPVbefcBtboTGW3l
 syvrijn2mJcfdsF9GFPEVaGvOlgSZqydjSY0gy9q5s3qt2v+BvQ5m/+l552XlfWxj17cq+tWHx2
 ZR/xV6ZeOrnmSCcOMDiV64XnzIrf2HKEkkUfITiYw6rGiiVG4S7srQKAM+IeQGb0/8vzN0CMyct
 2EPBjmdSa8J+BRy5tfhN874EYqzWjU9HPTCSSjWg9oGlgrLufPkmJU4fI7QfWLW3QxKaZw0mL+i
 WN4LRFNYZk7SDewuB6NlOkewOdhkZAQFka9ugx3sqXOwYLQ8Pyq0piCXnFXmy6E=
X-Received: by 2002:a05:6000:1562:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-390ec7cc8f6mr12151801f8f.14.1741025259441; 
 Mon, 03 Mar 2025 10:07:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtUCJbTNewDTEEw0joVa/RrWBx1t/of6zRX4LKLmBPd941MbDM4FAIswFNXc8ewh6rxHllng==
X-Received: by 2002:a05:6000:1562:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-390ec7cc8f6mr12151785f8f.14.1741025259097; 
 Mon, 03 Mar 2025 10:07:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6cd8sm14961183f8f.44.2025.03.03.10.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 10:07:37 -0800 (PST)
Message-ID: <25f360d5-d89f-4d21-a80d-21699bc14da1@redhat.com>
Date: Mon, 3 Mar 2025 19:07:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: Make vfio-platform available on Aarch64
 platforms only
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Will Deacon <will@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-3-clg@redhat.com>
 <291bf12d-18bc-444f-b09d-3fb80e0f144a@redhat.com>
 <20250227102737.197ab32b.alex.williamson@redhat.com>
 <d069fea1-3e3d-4fff-8548-8cba491fcdc0@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <d069fea1-3e3d-4fff-8548-8cba491fcdc0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 3/3/25 3:32 PM, Philippe Mathieu-Daudé wrote:
> On 27/2/25 18:27, Alex Williamson wrote:
>> On Thu, 27 Feb 2025 09:32:46 +0100
>> Eric Auger <eric.auger@redhat.com> wrote:
>>
>>> Hi Cédric,
>>>
>>> On 2/26/25 9:47 AM, Cédric Le Goater wrote:
>>>> VFIO Platforms was designed for Aarch64. Restrict availability to
>>>> 64-bit host platforms.
>>>>
>>>> Cc: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>>> As an outcome from last KVM forum, next step may be to simply remove
>>> VFIO_PLATFORM from the qemu tree.
>>>
>>> We also need to make a decision wrt linux vfio platform driver. As I
>>> can't test it anymore without hacks (my last tegra234 mgbe works are
>>> unlikely to land on qemu side and lack traction on kernel side too),
>>> either someone who can test it volunteers to take over the kernel
>>> maintainership or we remove it from kernel too.
>>
>> I think it's more than just a kernel maintainer stepping up to test,
>> there really needs to be some in-kernel justification for the
>> vfio-platform driver itself.  If it's only enabling out of tree use
>> cases and there's nothing in-tree that's actually independently
>> worthwhile, I don't really see why we shouldn't remove it and just let
>> those out of tree use cases provide their own out of tree versions of
>> vfio-platform.  Thanks,
>
> Now (1 week before freeze for release) is a good time to post a patch
> deprecating it :)
Yes I will do that tomorrow

Eric


