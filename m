Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDC3C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPul-0001ht-Ir; Tue, 18 Feb 2025 10:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPue-0001hK-Ej
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPuc-0004Nx-Tr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739894010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MrY0o8q7SSkfv+KE4Sd4GzKDRGangjGr9ENyIlSpyo=;
 b=AmPN98XookE+ssswx4dGzhq311AjCbGOmV7RoZxRoyLByFG2josChNXvZbyjxyut9FvkY1
 pxvxf1NId56WMC1WsP1YfB6fgkiyc2kgF8ujgYVmntjd+lxheQgWHS9xOlcITuhy4rLKxk
 fe7HaIjEg4hP+bEF0a2Cgg387i4qT9Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-iiUlNNZaPsiTzCqh5HO1VA-1; Tue, 18 Feb 2025 10:53:28 -0500
X-MC-Unique: iiUlNNZaPsiTzCqh5HO1VA-1
X-Mimecast-MFC-AGG-ID: iiUlNNZaPsiTzCqh5HO1VA_1739894008
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2ef5f0dbso2079341f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:53:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739894007; x=1740498807;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MrY0o8q7SSkfv+KE4Sd4GzKDRGangjGr9ENyIlSpyo=;
 b=e+3Vf4sRUG+OlJQ12Mhh1tevPi76qjkjoFCLdJ5gTMtyvSG4DsYCtEjp9Q6E421bR/
 LplTwuoiTQ/S553L0aIpzLkahPjyC0mPp4Hphpabd/0+kRpSn5Kw34dkYn69OeMvdXQ9
 brgrpLbv428MUNm6KM/NrOyEpa9RrRCXR0rUPAwUsJAE9VG2J7FbZjr+32ufzTbKyao0
 opKEWGxFGJOoN+toi8XfUoPTYTWS0I/UdVrxSN6os2VIy4Oms7wMrv/CFtyT01MzTHGB
 WWzUkkdYtuAFWOc1aihsehkeMp0rlUup2v6FtiY8zMBoKp9c4m9eL2Q5jQf7wOLByEiv
 1XNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3PGqpeh6U/89GZPtYh03oBjDP7GU7ZKOgZGIq4VsizHX1bPrC37718Us2bSIP0doafzmybtFk/qA4@nongnu.org
X-Gm-Message-State: AOJu0Yzj/0t8nmXQUDk6fcB2LMcxQUbsxVbMX+e7OysMcnIWcBmn4IMQ
 zGmJ9Ht3SCqqsBgRzSU6m3YnBZrEqmdXltz6z2QaKQMbgwhKJPXs0Tp4Nb004+2qiGbk2skr3yh
 BsP7ZjsJur7YjYx6sjr49x/cj8AGc4jaqwkt45bbXXhD1DejnFev4
X-Gm-Gg: ASbGncum/jd15J8FJAV23se/6IK4/KHD0G985l/m5+rlIuANF17WM9Vx+aEf07NO/cS
 ReBhqNzez3k73e0JjJxNbSNKgnGS3uQH/d+Dz/NMRno4Xe8jHR4qnH9BhLgpve7Kbv1+8rBNJ42
 n2NjotXCpZv6yLREVdKo7rnns5I+UovNoPY0d8E3Ck30gqCIu5qiczh4ECQqa2HuqFlW0H+/MWt
 tP4ONyp7VadSAiLHwqinhGrEaA8Y2xo8YKZSB6B/lqtlG0mAsF8xnAB7A976+3oOXyKrhUji6yL
 4kcTEugjhDXkP7Xo9qA+QzJAO3eh5/i9AOO+KlWb8yp4BYMopXIk
X-Received: by 2002:a5d:64ec:0:b0:38f:47f0:e7b7 with SMTP id
 ffacd0b85a97d-38f47f0e871mr8711195f8f.16.1739894007653; 
 Tue, 18 Feb 2025 07:53:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEPdn89bxLQwws9Y3KfLy8aycIDZe1kRyr39nkzm3i56eOV6/acpHmTDq8O4gtGlMao/TcsA==
X-Received: by 2002:a5d:64ec:0:b0:38f:47f0:e7b7 with SMTP id
 ffacd0b85a97d-38f47f0e871mr8711089f8f.16.1739894006013; 
 Tue, 18 Feb 2025 07:53:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8115sm15569779f8f.92.2025.02.18.07.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:53:25 -0800 (PST)
Message-ID: <07bed04b-e000-42d0-971a-53d96344d658@redhat.com>
Date: Tue, 18 Feb 2025 16:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] arm/cpu: Store aa64isar0 into the idregs arrays
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-4-cohuck@redhat.com>
 <1af2d33f-c876-4c23-afb8-be63447960f4@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <1af2d33f-c876-4c23-afb8-be63447960f4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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




On 2/7/25 7:46 PM, Richard Henderson wrote:
> On 2/7/25 03:02, Cornelia Huck wrote:
>> -    t = cpu->isar.id_aa64zfr0;
>> +    t = GET_IDREG(idregs, ID_AA64ZFR0);
>>       t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
>>       t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /*
>> FEAT_SVE_PMULL128 */
>>       t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /*
>> FEAT_SVE_BitPerm */
>> @@ -1252,7 +1262,7 @@ void aarch64_max_tcg_initfn(Object *obj)
>>       t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
>>       t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* FEAT_F32MM */
>>       t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
>> -    cpu->isar.id_aa64zfr0 = t;
>> +    SET_IDREG(idregs, ID_AA64ZFR0, t);
>
> This doesn't belong to this patch.
Yes my fault, ID_AA64ZFR0 handling can easily be put in a separate patch

Eric
>
>
> r~
>


