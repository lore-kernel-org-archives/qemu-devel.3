Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4ACC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 07:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri8FF-0005Ml-TJ; Thu, 07 Mar 2024 02:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8FE-0005Mb-Dm
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ri8FC-00020H-Lt
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 02:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709796765;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucxwlMHUiD30hPQAXtYZXvvoHVuX18aAqzgAW+oZSTA=;
 b=V+ca42vktYCWVO0HaBHpByKxomTALeQB+Nkm/3f911euXbccHRLDJPcsEm0IR4/FeEmR6j
 kgsBmEpnPe2/wgjR8d41BD/gpvU+B5laeB7Wrklrpo/9GB1Sbicnikm8CMQMgJ0ARk1oke
 0a9lGhkVtQmxBdFk7hq0nsZdVsZDI18=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-Oap0xakBO5aFpLH6eUOtfA-1; Thu, 07 Mar 2024 02:32:44 -0500
X-MC-Unique: Oap0xakBO5aFpLH6eUOtfA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-69078fb1cd9so7297756d6.1
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 23:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709796763; x=1710401563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucxwlMHUiD30hPQAXtYZXvvoHVuX18aAqzgAW+oZSTA=;
 b=w4q8F+PCACbCGk+X4HWGMR8Ix8Vn+RowJqSPccqaEvrv4CAzIRe8hDLWrkdJsRPKjv
 o5hayg7fABuQc7IElj3HUoqxYIQRbze24sLLcT4g7Txpquy1LvIYYPKNvk44Uu4kT3e1
 86nGDJ7pcXLnaNK5jzMLxTPBipO2XxcCHtn/vdPYNXsTlS4dcwRTot1TMMPzwXFAcU66
 JCfFHEpVbvO2ihNYY7w5hcgvyAjMS/8mhhOkLzutf5qmK7NyO4R4pniL6D3oVI2EPEIn
 01yg7nwGOuFce99ZGN9n/QVlP7mredxjnkMHE6kFwW07Rz8bc+wWVoYEAPijidx1f2XB
 CjFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg7hF0vMlXkvS4cPlHnAjNx+ST6MY8ajTk2FoyCkY+8VCBD31NRUCg/bRkI9M4VYWkGK6IV4FC3ZqcyMvX0GTDnjxfsqk=
X-Gm-Message-State: AOJu0YxQu+PXNPdcsp3yTXyd7khGmaz5wCUgVbFUPUTly3kDrGor8TIR
 /Q/kL1S4Ai5qEErZkFFS2C8cWzgs6B/Vqd4H7xnzInjY/XY+8M03xT6cphTTxCDl33LZcidnBsR
 MLn3lm9+nbtEiXA6ib/cStwYEt3VTtV73tY6pAnozrI1mA0ZwmIJ8
X-Received: by 2002:ad4:5685:0:b0:690:7a5e:b321 with SMTP id
 bd5-20020ad45685000000b006907a5eb321mr7864516qvb.17.1709796763595; 
 Wed, 06 Mar 2024 23:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYE5uUIQaWWVUSRbGyD7k1ra44Zff+AudMZEC2GXv6oBlelLWn1uyTDm7jyQ3uTqiBOiLWkg==
X-Received: by 2002:ad4:5685:0:b0:690:7a5e:b321 with SMTP id
 bd5-20020ad45685000000b006907a5eb321mr7864499qvb.17.1709796763261; 
 Wed, 06 Mar 2024 23:32:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 qj22-20020a056214321600b0068f73372424sm8415701qvb.90.2024.03.06.23.32.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 23:32:42 -0800 (PST)
Message-ID: <07478583-ce74-4de3-8983-010c6617e4a8@redhat.com>
Date: Thu, 7 Mar 2024 08:32:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] qemu-options.hx: Document the virtio-iommu-pci
 granule option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, imammedo@redhat.com,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240306203348.65776-1-eric.auger@redhat.com>
 <20240306203348.65776-5-eric.auger@redhat.com>
 <fcaf95d2-bb09-4c55-a333-21a93a707ad2@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <fcaf95d2-bb09-4c55-a333-21a93a707ad2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Philippe,

On 3/6/24 21:44, Philippe Mathieu-Daudé wrote:
> On 6/3/24 21:32, Eric Auger wrote:
>> We are missing an entry for the virtio-iommu-pci device. Add the
>> information on which machine it is currently supported and document
>> the new granule option.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   qemu-options.hx | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 9a47385c15..757df3eac0 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1172,6 +1172,14 @@ SRST
>>       Please also refer to the wiki page for general scenarios of VT-d
>>       emulation in QEMU: https://wiki.qemu.org/Features/VT-d.
>>   +``-device virtio-iommu-pci[,option=...]``
>> +    This is only supported by ``-machine q35`` and ``-machine virt``.
>
> Don't we need to precise x86 and arm here?
Well I got inspired of intel_iommu doc. I think this is sufficiently
precise, no?

Thanks

Eric
>
>> +    It supports below options:
>> +
>> +    ``granule=val`` (possible values are 4k, 8k, 16k, 64k and host;
>> default: host)
>> +        This decides the default granule to be be exposed by the
>> +        virtio-iommu. If host, the granule matches the host page size.
>> +
>>   ERST
>>     DEF("name", HAS_ARG, QEMU_OPTION_name,
>


