Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5ADC3DA62
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 17:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU8hD-0002cC-Pf; Wed, 17 Jul 2024 13:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU8hB-0002ab-UV
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU8hA-0005Yw-6o
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 13:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721238241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YXMXeJtB0QeW3e9c873mC3SsuGh3TloGp0TB0BkWQU=;
 b=Dzmz0FENHKrjwzjyGEBDx/sxrQbXxsdYiMX3LDXK0vAKjumz+RL456hwukzpKcpvGSA33L
 fFRGvKN9DuICcWawseblX2EDLT11jeV0bdMULNVgmR7MsGcS6t5cmRoYDoWulrjr6lPO/v
 r6b/n3mBhT1kzsGjBFrR95fMWOWmzBY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-cKMPiVXrNHuHv0n4J3dsLA-1; Wed, 17 Jul 2024 13:44:00 -0400
X-MC-Unique: cKMPiVXrNHuHv0n4J3dsLA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b79409b763so411306d6.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 10:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721238240; x=1721843040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6YXMXeJtB0QeW3e9c873mC3SsuGh3TloGp0TB0BkWQU=;
 b=qAAc0a0LuvPA2YqTPUZLyOXraguM6LQT4IeuqH5S8NJ484/l9/kAKHNIcmYH0a7kDQ
 cbaH32QUpLd8bMCUAHZT1GI5/bMJQ75zOuHfqOEMapbY8WJZ25LiFvLrNEtD2JzMazje
 tMEfRre/WnQvRU+F3iQxLIstOnMxz/iq3z/0o0rN6Ok3ewMb0CLyueX6BFhkLGMXBmU1
 mdlg1HM6X0oXhcaC3zP3T9t3qbN1ezcxcoBqnHZ9Z0Cj/N56Md1cCUM8KV8ReuzuNV57
 Zr2m8Z6wiWh8q2dwk3Zc+38XLT1/S+d8w1ao+t//54EDzax7ta6fwJNLrPeaE9hIX8Hb
 gpoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Yyp/97F7h1KOT5DKdyF5w/N4Ij+v0Vq2oduKESqftlVYwIx7PQyNPKYBBXdRO9Hs233v5Qa6HygStHYG16QQCOTCi6w=
X-Gm-Message-State: AOJu0Yz88oVeGaUI8lyjSUnyN7cfWKb3l7LA7PbSAMpGcN4JOtfLV5Y8
 g90hIFU+YyNlLPrRDhw3DCsK71teuk9fIDQCf3kJbN/jFlHUNrpHT5l3jHW7hfGTh0sbhtXJun6
 2GPQw+ymi0KHvYIP+SqHloMY7V/ywUU1OwwmPNk9EUOGsqeLRXnuX
X-Received: by 2002:a05:6214:19c3:b0:6b5:e24b:bb0a with SMTP id
 6a1803df08f44-6b78e38ae18mr33647256d6.58.1721238239696; 
 Wed, 17 Jul 2024 10:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT1xO4cG5TrH0syi3lc+B0jqAMakwNFNsVjiVyz0cIqgYgjgbjGVu5IXjsNOdWZJLNFhVw0g==
X-Received: by 2002:a05:6214:19c3:b0:6b5:e24b:bb0a with SMTP id
 6a1803df08f44-6b78e38ae18mr33646936d6.58.1721238239245; 
 Wed, 17 Jul 2024 10:43:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b79c677763sm428766d6.142.2024.07.17.10.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 10:43:58 -0700 (PDT)
Message-ID: <1e7e750b-61bd-4822-8742-124bdf66a7c4@redhat.com>
Date: Wed, 17 Jul 2024 19:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/18] SMMUv3 nested translation support
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240717150931.GA3988597@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240717150931.GA3988597@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Peter, Richard,

On 7/17/24 17:09, Jean-Philippe Brucker wrote:
> On Mon, Jul 15, 2024 at 08:45:00AM +0000, Mostafa Saleh wrote:
>> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
>> but not nested instances.
>> This patch series adds support for nested translation in SMMUv3,
>> this is controlled by property “arm-smmuv3.stage=nested”, and
>> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)
> For the whole series (3-9, 11, 12, 15, 16, 18):
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> (and I think patch 16 is missing Eric's R-b) 

Jean-Philippe and I have followed up the progress of this series,
Mostafa took into account all our comments and all the patches were
reviewed. It seems to be in a pretty decent state so if you don't have
any objection, please consider pulling it for 9.1.

On my end I did some testing in non nesting mode with virtio-net/vhost
and I have not noticed any regression.
Would be nice if someone could send his T-b for the nested part though
(Julien?).

Thanks

Eric


