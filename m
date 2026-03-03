Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940C5EC1459
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxR1j-0001Kd-JX; Tue, 03 Mar 2026 09:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxR1F-0001Ei-Ud
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vxR1C-0004OR-Fa
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 09:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772549197;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+c8AoCeFzluR9KrpvTjGq6/pF+pIQS41oeINMDAlzk=;
 b=hkA1sM9v315y914jjc3ZJlSX7tNbi0Av/9DpEhCiYlLBrTyKRTH0/Ghl9wJaqN6fUQZAiy
 DPFyJs5ryIDpsQGCUIoRy4lZIeEVMCYQXF44YqHxFZcsubxtRGmoKnZZSKgfP9GtT+RI6o
 bV7BDc6xWIbcCHnD0hXZWuSi6xQ0ueY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-n-kNrfx6M-2aR6kHtpA4yQ-1; Tue, 03 Mar 2026 09:46:35 -0500
X-MC-Unique: n-kNrfx6M-2aR6kHtpA4yQ-1
X-Mimecast-MFC-AGG-ID: n-kNrfx6M-2aR6kHtpA4yQ_1772549194
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43996fb9cf9so5203257f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 06:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772549194; x=1773153994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+c8AoCeFzluR9KrpvTjGq6/pF+pIQS41oeINMDAlzk=;
 b=f9WTRnuSSDtGqAm7h9NDUKdDQegypQm/Dr2cfE+GO78lGbVTpEYnY7IWfUyj5+ME8n
 FSgINUDvZNXZC6VJbhvO0UtwZfs9Mm+8Ay+Gx7HG1vrmo3B9ezL3nD9x5lVNmXNQ9OBH
 NSBtm/vO/Iro77oIHLNIbt01qyfbHt5GQH+VlxwNLyGTnPL0t1FtH+1IhLhBU+4snKcD
 XBprKZfy1lQRmRK5E3LkVvjAzSvn+ndHoaLgeqMAl7G6khXp805tdHMt4uO7gc6VGpjq
 Zl2da62W5om7UiLgdmJ66P76FvOPAhwv6sD2LOHAyT7riY43/fnl1NBta7Ib1r+1iXnt
 DNjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxuuRmq3Yvq6qFuE2G4Zf57hG/rRbU/OvCEFFkI0hhxhXXtD1drmQM0mza9ern1/4iBH/mKb7xW6pA@nongnu.org
X-Gm-Message-State: AOJu0Yylp5CmW3Mqr7c3dqcOMVp5HYHEPQ/WAqwg2VKvJ91AQdsYjT4f
 R1sJok7h10Itz3W/z97ehdKk04qPyjMia70xTI63JWD+hbUSqwGR37AWay/T0uhUsSQ7k9zsb5n
 SveZPMhUxxjF2C3FgnKB5jZTfEJZKLhYQyKIl2U9df5UjG4BGfKgKTSMw
X-Gm-Gg: ATEYQzyORVu99f3zdckRiMVyzHf+4exRrrKXe3aRuftxoddPEK/69bOeIjL2TJAEh1A
 N6ZsdZet3JFrFSaLAet1j9kDs5Wb9j3MTip/g1YnJwivauKvMzMHYdqsAlyBw02TpLUwe95JWDn
 sYK2QMECANmTmW1/G56zSogForrh37WgStmM4iTG2K1hQi0ZXDbtAKueWVgSEl1pXycgME3s7+m
 xLjAa0JENzzd/MmWmogs2hSdw2Stmpw3oJeseT9R8uzmVm1f4kIIPaqF1nvD1LJFcZR6gJ7d2dV
 9nOECZ7Dorx7wrDGbkEChHysAfsZ0CoGJuj7PhbisSft9tSS+f8rT4Tpj81pTtw3eDxK/lcqhbE
 TpiR3sgLsc4lY0ldw8DhJ0L+zalfZQ5CG1ozeZatddUaqRVBfQeErf1w8NqLzVR31z2yI/A==
X-Received: by 2002:adf:f204:0:b0:439:b6f9:b438 with SMTP id
 ffacd0b85a97d-439b6f9b878mr10520486f8f.33.1772549193701; 
 Tue, 03 Mar 2026 06:46:33 -0800 (PST)
X-Received: by 2002:adf:f204:0:b0:439:b6f9:b438 with SMTP id
 ffacd0b85a97d-439b6f9b878mr10520426f8f.33.1772549193194; 
 Tue, 03 Mar 2026 06:46:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439c2f8c0e7sm2900275f8f.29.2026.03.03.06.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 06:46:32 -0800 (PST)
Message-ID: <34e0763f-b79e-4149-a4bb-066a158c5371@redhat.com>
Date: Tue, 3 Mar 2026 15:46:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vmstate: Introduce VMSTATE_VARRAY_INT32_ALLOC
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, sebott@redhat.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20260226100232.500781-1-eric.auger@redhat.com>
 <20260226100232.500781-2-eric.auger@redhat.com> <aabnCoT3Wp6L_ZuJ@x1.local>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aabnCoT3Wp6L_ZuJ@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 3/3/26 2:50 PM, Peter Xu wrote:
> On Thu, Feb 26, 2026 at 11:01:29AM +0100, Eric Auger wrote:
>> Already existing VMSTATE_VARRAY_INT32 requires an array to be
>> pre-allocated, however there are cases when the size is not known in
>> advance and there is no real need to enforce it.
>>
>> Introduce VMSTATE_VARRAY_INT32_ALLOC as we currently have for UINT32
>> and UINT16.
>>
>> The first user of this variant will be the target/arm/machine.c cpreg
>> indexes/values arrays.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

Eric
>


