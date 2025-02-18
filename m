Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD42C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 11:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkLzn-0002rE-Sh; Tue, 18 Feb 2025 06:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkLzi-0002qi-2S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkLze-00010s-9K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 06:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739878942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYFiM7+SnDa3qBFNCUzCy41sKq6H2/+OeY+qMU/MNFg=;
 b=F311Cy2OlMOa2Js2qvaBuaL/WfkcetvWUdwKrZPjypU7pY4NpdUBeM9Vh00u9xBF0PcjmE
 gNqoUMf6dt4aTArDEtgV76ntbrCwJeYL2MAt+UDKApiEVEyjd00zchAYmHESrJ/J+gATY9
 etdp2+eCNmiDuQn3laXlk9jSFtjb7Xw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Jm6aFe2pNayJrMzBFjQbaQ-1; Tue, 18 Feb 2025 06:42:19 -0500
X-MC-Unique: Jm6aFe2pNayJrMzBFjQbaQ-1
X-Mimecast-MFC-AGG-ID: Jm6aFe2pNayJrMzBFjQbaQ_1739878938
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43935bcec0aso43595925e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 03:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739878938; x=1740483738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cYFiM7+SnDa3qBFNCUzCy41sKq6H2/+OeY+qMU/MNFg=;
 b=iIRyUxbY4HrWmL+gGlz2WOyty1R2a+glc8V/wXzBXDPlSy3yU0UiTE4Y2wTuKhIsW1
 PcoTvVOVOuqtpmy5nBMokDRmC5Z8z/jmp2rx2QsPzzBt5HxFE9tr0EHfiJk6au32FrNj
 iL5XY7UDWiVzbaA0xHx1iqEN1lHyIpomfR7vnJJrSexOZP+d7SvSQuRHrEm8Oo2Dqhl8
 EtwfKyQ3+GyBkPHHDgxylR7p6fm9v5mmcjzoOlvLiVgo8qPS0PUoCcUsQlL61gQKFkXf
 1uCuvoFM87/hWeLsA/JmxKBwT5AmNvOdbJQtGfYpRwQXky6pCeWRMnSiN1w1Ie/ALhEt
 UsNg==
X-Gm-Message-State: AOJu0YxUB4cpGzPCkJ9HB6wxSD3e4iu2TATMRvylM9qiOlxTl/2Vx0Vw
 iWh84TBJ4+56bEYbE1WwOWVq0GUCxrlXjsNYr/+R+E8qNhPmJSWa04/+Xvgkp/N2aU6nFOMpALd
 hKHioLu9IceFW5SjyHLfTaD32oED2dSFdZA2jKniGhkmZ/3IKWDIx
X-Gm-Gg: ASbGnctnzlnDLIb7uRc8UGMb+kHqtSGEkRLnr47540fhxHuOgGSod3jrR7BTjocdGxP
 pVuCbWKPF9qGMn6dz0/lDrAK+M3f4UXaR5KhkdYIoLTowa2aJM8XNevgd8PjvUyacYVB2RkZ96+
 fI/biEcAQo4a4qBnEFGF/xm8zn6WAfvXZRwNVoCX2F+JY00flAjA3/dQf327j9bZRWbKUBnR02Q
 ldCwq+cBJYHJRfPoacvKnXegwneAlU/H94YrSwGRMC2TisTtl6gRc19ByaEzl5FRI3LNQnqVLlK
 HUsKHce8gkhsn8YHgvqviXEdcjiIScSvNxWW734QdNI9fbUVRMr9
X-Received: by 2002:a05:600c:3594:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-4396e730949mr123278725e9.28.1739878938040; 
 Tue, 18 Feb 2025 03:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRBImzIPCi1seiBPvR8HuCZVINctMRAz/aqqm/7yl3AkGFg5t7VKu+KkGqMZL4LnZ6Euxf0w==
X-Received: by 2002:a05:600c:3594:b0:430:57e8:3c7e with SMTP id
 5b1f17b1804b1-4396e730949mr123278195e9.28.1739878937515; 
 Tue, 18 Feb 2025 03:42:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7bcsm178892785e9.28.2025.02.18.03.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 03:42:16 -0800 (PST)
Message-ID: <a5d89352-597f-4adc-8f67-a5a7dd9bcffb@redhat.com>
Date: Tue, 18 Feb 2025 12:42:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] docs/cpu-features: Update "PAuth" (Pointer
 Authentication) details
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Ninad Palsule <ninad@linux.ibm.com>,
 sebott@redhat.com, maz@kernel.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Yi Liu <yi.l.liu@intel.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, richard.henderson@linaro.org
References: <20250217163732.3718617-1-kchamart@redhat.com>
 <20250217163732.3718617-3-kchamart@redhat.com>
 <ff481ffd-545f-4d0c-b53a-3cf9e0f8f388@redhat.com> <Z7Qnsm02w6gao_ui@gezellig>
 <CAFEAcA8H0P14JaAtpcwG99SYkqAdhoNzyQBuO++YjJjM1rUbPw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA8H0P14JaAtpcwG99SYkqAdhoNzyQBuO++YjJjM1rUbPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 2/18/25 12:34 PM, Peter Maydell wrote:
> On Tue, 18 Feb 2025 at 11:29, Kashyap Chamarthy <kchamart@redhat.com> wrote:
>> (Cc: Richard Henderson; context: "SME" and "RME" feature discussion
>> below.)
>>
>> On Mon, Feb 17, 2025 at 06:43:01PM +0100, Eric Auger wrote:
>>> The resulting header layout seems weird to me.
>>> Initially we had at top level (assuming ===):
>>>
>>> KVM vCPU Features
>>> TCG vCPU Features
>>> SVE CPU Properties
>>> SME CPU Properties
>>> RME CPU Properties
>>>
>>> and now
>>>
>>> TCG vCPU Features has somehow disappeared giving the impression that
>>> there are none.
>>> Maybe we shall
>>> - rename KVM vCPU Features -> KVM only vCPU Features
>>> - Add a TCG only vCPU features including both SME and RME ones
>>> - introduce a top level KVM and TCG vCPU features with below:
>>> PAUTH, SVE, detailing potential different semantic for both KVM and TCG mode
>> Yeah, it can be done.  Would you be okay if I do it as a follow-up?  As
>> this a re-work of the entire doc with several features.
> I think personally I would favour not having the split of
> "KVM only", "TCG only", etc sections. Instead document
> all of the properties in the same format, and have each
> property say whether it is TCG-specific, KVM-specific, etc.
This other alternative looks totally fine to me as well.
>
> Some of these properties may at some point in the future
> change, after all -- SME is currently TCG only but may get
> support in KVM and HVF in future; "aarch64" is currently
> KVM only but we might some day support it in TCG.
agreed

Eric
>
> thanks
> -- PMM
>


