Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA9C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:03:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMus-0004mJ-Fo; Mon, 15 Apr 2024 10:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMub-0004j5-Um
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:02:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMuU-00008w-2Q
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:02:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713189732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXDNlHlRADNS9aOWimzmw7tIndReKZC0UBS+/FsN9PM=;
 b=OuV46nDRxa56sDgKSsUTWZsvcurKcawSDlAt/EHT2IxJBklTI/UFS/hMVjLHlGYKpv5zAb
 KAUjRc5ec6WNQUjPpJOC4rSe8aOGpYhIVgWanv3rT2OIr9Adf3mNhpwve3SeeMJZU6uN4X
 B7iKLCfA0ITzWaZODjO/1HO4XDuAW/Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-YZYtXeULOIyeN78f-P90Kg-1; Mon, 15 Apr 2024 10:02:03 -0400
X-MC-Unique: YZYtXeULOIyeN78f-P90Kg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78ed20d9423so346133185a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713189722; x=1713794522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXDNlHlRADNS9aOWimzmw7tIndReKZC0UBS+/FsN9PM=;
 b=lfYSKEiZKoW5Xw6bciZ9aZ4RwX891S6wsHWxiBk3ia1b54l2URU51Ye4CJfPauTRpO
 n0s9zdg2ybJ0zp2lOG7cOpz1LViAWnEqLPPyVOCe51KZ+k2eWyBXZnRH8YvKq3k3bn82
 JbRnUoasFWX8CAr4skJcS04bU2anAax6WSu1peJJoDcopn33PNL61xQI4yk3NsbWpcxK
 vJg9awDYaVk0EU1Jc+eSJETVyFTJCI+xyS0D7AUUa2DKKkWtYtjAxQZlWxc+ZGkWBWF7
 t3TX0XAy3l4ADQ5czTxznQ+T2Irr/Tn+q10rbAsvtu+wzUIUU1iY29O+Oes4FRmqY2Dk
 jjRQ==
X-Gm-Message-State: AOJu0YzGkOKrhPP3eFYEarTGhod1DDflG2DHl69gD9ontuDWi6Sz5pcG
 729wMPcftxSmRyfVtUe5QoX78D5nS541ayiirKowZS7f+/B+mEJMWyGEzJQuJTcaAdi6Ft+jfX+
 u6I8tMgRtxlVVQmD8nJWYDfe81qUGigJNcipXxOR3N9GGbcgssAZN
X-Received: by 2002:a05:620a:4482:b0:78e:ddf9:5f5d with SMTP id
 x2-20020a05620a448200b0078eddf95f5dmr6840897qkp.18.1713189722240; 
 Mon, 15 Apr 2024 07:02:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz/Tpb2yCVZ2jloxWv8paKM4FHNdw2/d0JfsIbXCKXX2Ltr1QuUYiLnH9/Lz+upqICBMnADw==
X-Received: by 2002:a05:620a:4482:b0:78e:ddf9:5f5d with SMTP id
 x2-20020a05620a448200b0078eddf95f5dmr6840843qkp.18.1713189721776; 
 Mon, 15 Apr 2024 07:02:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 v23-20020a05620a0a9700b0078ebb13a03csm6347225qkg.67.2024.04.15.07.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 07:02:01 -0700 (PDT)
Message-ID: <071b84be-ac31-4b64-8514-a5f4ec581077@redhat.com>
Date: Mon, 15 Apr 2024 16:01:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] hw/vfio/pci: Replace sprintf() by g_strdup_printf()
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-block@nongnu.org
References: <20240410160614.90627-1-philmd@linaro.org>
 <20240410160614.90627-3-philmd@linaro.org>
 <20240412092546.348163c0.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240412092546.348163c0.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/12/24 17:25, Alex Williamson wrote:
> On Wed, 10 Apr 2024 18:06:03 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
>> resulting in painful developper experience. Use g_strdup_printf()
>> instead.
> 
> Isn't this code only compiled for Linux hosts?  

It is not.

> Maybe still a valid change, but the rationale seems irrelevant.

I agree the commit log should be rephrased.

There is also a v2 doing a different change :

   https://lore.kernel.org/qemu-devel/20240411101550.99392-1-philmd@linaro.org/

This is a bit confusing.

Thanks,

C.



