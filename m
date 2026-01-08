Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34789CF6A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmDk-0006OL-4z; Thu, 08 Jan 2026 04:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdmDg-0006NK-6M
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:22:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vdmDe-0004TU-OR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767864133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2b8AL++Sq65Hn06lcFM6/SrmlS13BnyNPseRxoFOj6s=;
 b=TwVfLzXMGVL8CkJvdcc+XwhU1ELYFA2qzQR1ONju5GH92Wdh1EFzyYV4OCLYLVkdPv0Wm3
 GvyOxL2m6BUGPsv4rXtKScbvTW4FUVRRhO7iqjfeWOLHCOvpFO34h8G/JpntzK2v1CDc7z
 iGYPqRSMKl0lQFemj5eJxZ3PbA6J6YI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-zepxhcQvMUCdUoN2QSPkDg-1; Thu, 08 Jan 2026 04:22:12 -0500
X-MC-Unique: zepxhcQvMUCdUoN2QSPkDg-1
X-Mimecast-MFC-AGG-ID: zepxhcQvMUCdUoN2QSPkDg_1767864131
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477bf8c1413so20474105e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 01:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767864131; x=1768468931;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2b8AL++Sq65Hn06lcFM6/SrmlS13BnyNPseRxoFOj6s=;
 b=NHbGV+kD6OeiKqvB+1AySc9UiX9lStJ/ze8XsruNVgX2rYVnUIMlsGii/aciVJgHlg
 jexBfA6cgZ/gBMHVSdywbjOim8dQDT0ZtDXBh8RDD66Lbr1SWsT7fzrYHe9X+B8Cvwlm
 Z66Id+/tZj8ZQZe3oSB3wYaiOdsXBliaM6DQr7SytS4iydXIwtK12xx0Ufs/JTYByFPf
 20HLfxNUT4BF6DZDep2br6KJ7wOMPAJodG80vzwGoec1ENFIC9jW/b64/PhdjIo1V6vS
 g34hCWzIUb/zvKcuA7Nx8qwIZPlQiOR4I2tmHqtVJwi5NcBNcAYfg07A2ZrB1gWlkWHj
 76Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3kv6aCaR1Ggp/manjpnmyJvwL6FfPwSDGJLFhBNCVdAhcZYON5st018ooTYl+fM2Zo7Koq/qLvHrb@nongnu.org
X-Gm-Message-State: AOJu0Yz+ZprdHjuFkJ+Yu67Mo+UA1+HqMkQwPwm4gV2okhm9nHD7GrJY
 66clI0OUz6n54wz9EKhsnG6pbsEdsXufOD4FUJR6R7U1yruxpvWXSvvLWTbzpoF6CdJIizejGql
 owDx6lN6j6SYbENE0GsUd7qWy3wjjoxpA8IlGMy+D+3mWWOndDZKQsvFC
X-Gm-Gg: AY/fxX7zM3b5pZ68mZc12nK+JEv63KzrSFbCAODW/9JdpTD2pu0nQuZTbtML9YWbUrh
 /19YXpqcKoZcXiBMA9nAiHJ+b0hkEaVQMgbUsjP96OoSg4be50jzcWJKtj6zLFf6pYYJOzOQLJN
 IiXiitbxjNtpKF/dUsAFoZnHPdDlELPpghXV1VVqNeROpEbfnRzFU4b04Gl/EYZPE2L6NOhWnHa
 9cEKSbWgjPVVk464fBI3m/8SeonidyHr7B3vmthRO2Aex4Ve04n+bMO7+cKm7povtNnYBj9YPoQ
 9oquVFV1cyJHvrzWJ5B+ehxJ6g65df+3VyuFfU25/EKj8IXubreWZCLpRtOvVprt+R11kdfq5De
 PG5brGoK1ifnzIPQ8+ulaQVTTSUmE3vFSPcB5UmKA8FfE2MzRCOzXV25P9g==
X-Received: by 2002:a05:600c:4fc6:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-47d84b0a902mr60309755e9.5.1767864131220; 
 Thu, 08 Jan 2026 01:22:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo2aSMuuc/f2tcoAs14n9hghA/8f66wOIKnR3xddA0hvceyqviEcu9Y7ZzQfy/7YTBu9DYVQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:a21c:2066 with SMTP id
 5b1f17b1804b1-47d84b0a902mr60309565e9.5.1767864130774; 
 Thu, 08 Jan 2026 01:22:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f661a03sm152971985e9.13.2026.01.08.01.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 01:22:10 -0800 (PST)
Message-ID: <0d6a3bae-87bc-4c94-9c6f-5fee4be27948@redhat.com>
Date: Thu, 8 Jan 2026 10:22:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>
References: <20251216235731.1793908-1-pierrick.bouvier@linaro.org>
 <16a8de8d-3054-4d7f-b4b1-1588aa54ee24@redhat.com>
 <8c822a27-17c8-452c-94de-67de9597552f@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <8c822a27-17c8-452c-94de-67de9597552f@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Pierrick, Tao,

On 1/8/26 3:22 AM, Tao Tang wrote:
> Hi Eric,
>
> On 2026/1/8 02:32, Eric Auger wrote:
>> Hi Pierrick,
>>
>> On 12/17/25 12:57 AM, Pierrick Bouvier wrote:
>>> This will be used to access non-secure and secure memory. Secure
>>> support
>>> and Granule Protection Check (for RME) for SMMU need to access secure
>>> memory.
>>>
>>> As well, it allows to remove usage of global address_space_memory,
>>> allowing different SMMU instances to have a specific view of memory.
>>>
>>> User creatable SMMU are handled as well for virt machine,
>>> by setting the memory properties when device is plugged in.
>> Will Tao's [RFC v3 08/21] hw/arm/smmuv3: Add separate address space for
>> secure SMMU accesses
>> be rebased on top of that. How does it cooperate?
>>
>> Thanks
>>
>> Eric
> Yes — my latest Secure SMMU V4 will be based on Pierrick’s
> memory/secure-memory property infrastructure.
>
> In my earlier [RFC v3 08/21] implementation, I made the Secure
> AddressSpace global, which may be a real design problem (notably for
> multiple SMMU instances). I have already rebased and updated my V4
> code on top of Pierrick’s patch; it’s currently under debugging. 
OK thank you for the confirmation

Eric
>
> Thanks,
> Tao
>


