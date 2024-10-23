Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D364CFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fYW-0000hL-JG; Wed, 23 Oct 2024 13:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3fYU-0000gf-9q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:53:58 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3fYS-0002uF-Rr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:53:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso126372a91.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 10:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729706035; x=1730310835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6YOFRTw6YTefIHma7i4jPoc/uITOlg47pnJfBKY+1WA=;
 b=b3A+Kz7VuMKYtCH3nPboLoQH75+Fyr7LbFq8pMijhKPZ+EJDouNJJcrZrHhdFpGSh6
 q47AZfYJXhqzev3f9sEI7JPq1SFveyYUqqVci9LP4q8KFpHpg4O7pGwKxdDnF1w+uZ/2
 67ckQ8iTw62ajSCtrzOhqVDDuX2MXXbdISH8D6WlkM/E3zIg3dxfzz8IPEp+RXNxkSCZ
 wJkuEd8qcW8xEEwzK5nupbEqVNgvkXZXpTUzke5kHFAsbI17mcqL/2DPYrxnMbVbHBAy
 kHnoJcpqAqFodUJezwR1rk/HadSpT+r5NArD26/v9Yw+p2iynYFeUW79dQHmppT31sFJ
 dE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706035; x=1730310835;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6YOFRTw6YTefIHma7i4jPoc/uITOlg47pnJfBKY+1WA=;
 b=kF1oEw3dK4oBtMlqvWL5TGY/P1x6d9utgfktRHu2+GfbT651ZzI75d4YzSXPm8vWO5
 q2UsCRv8iK1Qu9ys6KqMhmJcEDCb68vjQrFbyh1wRN03tnB5utPx67K6mKagXTEI1CCt
 5F3P85vuEbstJsJ1b4beVoBOWFqW6rm55bjyBXJrK/K/mNW32T/3Yw0xHLIe8C+Jxgtf
 WZZTJ+Pnz+ZPfyqSyhN870RSoUHgvOIwcpfeCk2Snmnbmb4FCWBIlbjFuSZC77hAAJdO
 kCwPS92dYKpJt1AvxIyRSTWNxLqgjs4TQAEOHMCvxeF+v0gjtFBqvPfBitZd70+3jstD
 u0Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpxzMrjpGS1st8jCQljcQkkLZyK6ZXhMrci/Gkk5HT4I0whxDHcmglofkGvOR61zk5d9/RDY1/h96i@nongnu.org
X-Gm-Message-State: AOJu0Yzjhcs5l1X1fm/ZcP236UwQbhSr2In1YOEWLJsFS7o14Y3OuhAW
 BJjvGWHCqS30BYpb1GN7VUwd/8CU05yQa9mKOAV/G7vkTsMKfGbyWWIgdalGEPo=
X-Google-Smtp-Source: AGHT+IG6+KpqXGEz3X5LSwS6au/eP/0qPdhex8Gy4aK041HrIbLPnIIBu4fhHG9RwKAJsZbJb0WmkQ==
X-Received: by 2002:a17:90b:f81:b0:2e2:bb02:466d with SMTP id
 98e67ed59e1d1-2e76b70c68amr3613540a91.33.1729706035114; 
 Wed, 23 Oct 2024 10:53:55 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5df41f7f2sm2710258a91.0.2024.10.23.10.53.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 10:53:54 -0700 (PDT)
Message-ID: <76e0b961-849d-4a82-aa43-3377f24dbb09@linaro.org>
Date: Wed, 23 Oct 2024 10:53:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: Julian Ganz <nenut@skiff.uberspace.de>, Julian Ganz <neither@nut.email>,
 qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
 <fd9c687a05ccdcdf5a589a15fcecb38074da7c1d@skiff.uberspace.de>
 <31c78f6d-7154-41c5-be46-3ca4974fc6f4@linaro.org>
 <ec6b6c1f81730e6b73e8cf7c4b2cb2f48598918a@skiff.uberspace.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ec6b6c1f81730e6b73e8cf7c4b2cb2f48598918a@skiff.uberspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/23/24 10:12, Julian Ganz wrote:
> Hi, Pierrick,
> 
> October 23, 2024 at 6:39 PM, "Pierrick Bouvier" wrote:
>>
>> So we could have something like:
>>
>> /* plugin side */
>> void on_cf_event(qemu_plugin_cf_event_type, uint64_t from, uint64_t to) {
>>   ...
>> }
> 
> We also need the VCPU id, but yes.

Yes!

> 
>> /* API side */
>> void qemu_plugin_register_vcpu_syscall_cb(
>> qemu_plugin_id_t id, qemu_plugin_cf_event_type type, qemu_plugin_register_vcpu_cf_cb);
>>
>> We thus would have a new callback type qemu_plugin_vcpu_cf_cb_t added.
>>
>> For registering several events, we might define enum values for types indexed on every bit, so we can directly xor the enum to register several types. (same idea than existing qemu_plugin_mem_rw, but for more values, with a specific ALL value covering all possibilities).
>>
>> Does that match what you were thinking?
> 
> Yes.
> 
> Regards,
> Julian

