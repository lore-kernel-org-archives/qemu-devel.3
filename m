Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37416D21275
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 10:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1NkA-0004hr-EN; Thu, 17 Oct 2024 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1Nk1-0004fB-Hv
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t1Nk0-0005K0-0Q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 06:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729160901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BwsQu4OObXG8zFgQjaI3N/fpBdXK8yP9KVO21U2+Jbc=;
 b=VT+KNxwhXh65KS2B+hEbp3LSYEisvM4YMRHaVvJIIbdb0EwYo9cKqNzhNyo7rGp4idoWNL
 efP61GtP2ec+1NS+LjLfUsOIRW0BBRlJmrZ0lzH4u6fdeTRmr2iaKVr0wED3u+j/MOeSUz
 uvcV1b/Lzjsp0W3FNsO9naqf4XAwk3k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-kYODo_8FM3-gLlBQv5SjiA-1; Thu, 17 Oct 2024 06:28:20 -0400
X-MC-Unique: kYODo_8FM3-gLlBQv5SjiA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159603c92so4155715e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 03:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729160899; x=1729765699;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BwsQu4OObXG8zFgQjaI3N/fpBdXK8yP9KVO21U2+Jbc=;
 b=w6Xbxz9oFQouwcU3IHYsD3kgY3dRDMtQY5VWVIdG1R/dN5LTnImkQLaVmU59YN7LKI
 eLygqfjMSn2OLHtu1da34CMVg24iG/aXkaA/TT4pMq6GQt9SAte04wDPxUTAX2FSP3VS
 3DvNSG4O6txpEdXbOSk6LxjKkKWoRFstoOhzBt5Mav6fAgi3Qgas3wffwIpnGOlzEf0L
 OPjAVmdEDZ2JPVbSvOR7q2FPoVw+NNAf86T+cp2SL/mjb4X/C1YDdB5n6ixafQdO8H8r
 Ns5SVmuAI9a+OCFmTowh4hcqnEeqwWlyPSe2WxXLKrMoitpM0K7b5YB+4cS6cygK8Sq/
 NyZw==
X-Gm-Message-State: AOJu0YzrcpoSxy7cJDlwBuGr6COGeumbnjNffpmir6ZFqEafQ0TFo/wg
 /+wGDa8LDSFV9J/4y8yiQIo5W7yP9i+79f6GnLEu5t1kwXVDtbke+PUeYRsl9rOa+0Pe/Geya6i
 +q2DbPk5f/BOIcSs3nudG1z1xPkbn8XKV3u0Z7dCR0SrE5MeVvG8s
X-Received: by 2002:a05:600c:510e:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-431255d4dafmr141307115e9.2.1729160899349; 
 Thu, 17 Oct 2024 03:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKgpDrU+sGDjK8Pis0QpsdnW8V0j1vOh9wWhCAfWujIPI53/X9XOWqjh4+tyssU/FQM2cyEw==
X-Received: by 2002:a05:600c:510e:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-431255d4dafmr141306965e9.2.1729160898915; 
 Thu, 17 Oct 2024 03:28:18 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43158c55fa3sm21622095e9.37.2024.10.17.03.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:28:18 -0700 (PDT)
Message-ID: <63828708-4c76-4549-bf83-647d3a743f20@redhat.com>
Date: Thu, 17 Oct 2024 12:28:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/s390x: fix constraint for 32-bit TSTEQ/TSTNE
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241017091401.783102-1-pbonzini@redhat.com>
 <CAFEAcA_1mryG9RyeAqfeRQOvqysO=vV3m=012kLmTsT6p-CdZA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_1mryG9RyeAqfeRQOvqysO=vV3m=012kLmTsT6p-CdZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/17/24 12:00, Peter Maydell wrote:
> On Thu, 17 Oct 2024 at 10:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> 32-bit TSTEQ and TSTNE is subject to the same constraints as
>> for 64-bit, but setcond_i32 and negsetcond_i32 were incorrectly
>> using TCG_CT_CONST ("i") instead of TCG_CT_CONST_CMP ("C").
>>
>> Adjust the constraint and make tcg_target_const_match use the
>> same sequence as tgen_cmp2: first check if the constant is a
>> valid operand for TSTEQ/TSTNE, then accept everything for 32-bit
>> non-test comparisons, finally check if the constant is a valid
>> operand for 64-bit non-test comparisons.
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Should this cc stable? Does it cause any current problems?
> (AIUI the x86 target changes in your pending pullreq do
> trigger this.)

Yeah, that's a good idea.  It's probably possible to construct x86 code 
that triggers it (I'm surprised it wasn't found until now).

Paolo


