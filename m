Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A599C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8NH-0000vc-5S; Thu, 07 Mar 2024 02:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8NC-0000uq-1G
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8N9-0006Dp-Ja
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709797258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGeULhLH7J0MoPiH3k1U9ee8OhSUjcW+ZX4V3ZKxu7Y=;
 b=I07CX8aqeZDSD9bnnOyksjjwZgs4iq2xk86IcJUWRTUOJjw4xHoZBlyccp7CIDvBPBvG5K
 LaWoKmkD/I5Qk1wFKKhxCqs0+2JxKUMxyhoEvSzWhONY9skpUKWi4JFpx/oDHEQK7pTSof
 x1NpoO5Sa3BsDZxiqdVpjT2oPyeg1us=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-DEoBd7NMN4a4wFsChvVkFA-1; Thu, 07 Mar 2024 02:40:57 -0500
X-MC-Unique: DEoBd7NMN4a4wFsChvVkFA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d1d766f83so227960f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 23:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709797256; x=1710402056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGeULhLH7J0MoPiH3k1U9ee8OhSUjcW+ZX4V3ZKxu7Y=;
 b=nSviP3ht4eDQYttfaS8nLbXw7T/O9Qju/eucoM3rxGR/J2eItugSkgV4JMLLsI6/Bl
 gD1Da9YbgMBFOmwRb1yzLuUXmGL1h//F3kTrZFBw+62YtZ/ZX5TTrPV6qXSn6LPpr4Bz
 aiJNvQA8CLV6WsVRC5QrqlSamDmYmRlPHUU2fk01XtDFw0EF8texAODETc70CMHPd1OQ
 7C7Z6OInVtQtTL5ye6Qd12Qt222uQWNgKFWdw8/8fTmDyHXj4Yc4FCcN57hATzAuCae8
 ei8SG3O42OPcWbLwMJ6I5GcYm+QClDTDrzTNi9gZ2TNYkL91BlXvpB3O5vaPm0zZ7oQj
 NZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Z/ZWsQHqJ6GbpNAslcUOiW2JUEJoGOTNye4whxlwWBUfV5N0xUQkaxyoWITMRTx1Qsvss1I/3Ely6Kecs+yegoqHGMk=
X-Gm-Message-State: AOJu0YxvT9cCJS9B7oWcPhcT6q64JM6ViuumKWhBu1yCaoyQF+gHOrCK
 xMxzw/GhJJkbFZMoGBFi6L4CCmggUb8ENu4RCekroRtewGuBIpS3vM3fe5I0ZlWFaNeMUaUTwNo
 /ZdOZ9lfdJh/nVtC8hks6oNF0XQRWtgId0DPzpLFqLUw5qogSGSFA
X-Received: by 2002:a5d:4445:0:b0:33e:10be:29cc with SMTP id
 x5-20020a5d4445000000b0033e10be29ccmr10716661wrr.28.1709797256193; 
 Wed, 06 Mar 2024 23:40:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnV+CiTPxmlSO2s0rbjeqJ9b/DhSJUrpNkygPkATuYcQbV9wMeX2eTxu1DDpaiwemzz9CVWg==
X-Received: by 2002:a5d:4445:0:b0:33e:10be:29cc with SMTP id
 x5-20020a5d4445000000b0033e10be29ccmr10716647wrr.28.1709797255844; 
 Wed, 06 Mar 2024 23:40:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n18-20020adffe12000000b0033d67791dc0sm19523743wrr.43.2024.03.06.23.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 23:40:55 -0800 (PST)
Message-ID: <e0787278-7e21-494b-ac75-ddd6814ee102@redhat.com>
Date: Thu, 7 Mar 2024 08:40:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] qemu-options.hx: Document the virtio-iommu-pci
 aw-bits option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, imammedo@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-10-eric.auger@redhat.com>
 <359b4559-0ba1-42b9-8292-c90d65043898@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <359b4559-0ba1-42b9-8292-c90d65043898@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/6/24 21:48, Philippe Mathieu-Daudé wrote:
> On 6/3/24 21:32, Eric Auger wrote:
>> Document the new aw-bits option.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> ---
>>
>> v4 -> v5
>> - tweek the aw-bits option description according to Cédric's
>>    suggestion
>> ---
>>   qemu-options.hx | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 757df3eac0..87959ede08 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1180,6 +1180,9 @@ SRST
>>           This decides the default granule to be be exposed by the
>>           virtio-iommu. If host, the granule matches the host page size.
>>   +    ``aw-bits=val`` (val between 32 and 64, default depends on
>> machine)
>> +        This decides the address width of IOVA address space. It
>> defaults
>
> "It defaults"?
Yes needs to be removed.
>
> IMO this should be squashed in patch 6/9 "virtio-iommu: Add an option
> to define the input range width".
in [6/9] the default does not yet depend on machine, hence my choice to
keep it separate and after 8/9

Eric
>
>>   ERST
>>     DEF("name", HAS_ARG, QEMU_OPTION_name,
>


