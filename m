Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C225C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E80-0001dj-CJ; Wed, 15 May 2024 08:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7E7y-0001dF-1P
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:53:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7E7w-0000dV-58
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:53:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so4744885f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777578; x=1716382378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V0hj5FxGAHV6Zge8LY7D4KbAAoxrxcOWRjzC6Koc43Q=;
 b=ODoLB567sw3No6u6TPncFQPcSLZeqnIteL9zUx/PvOM4/k5BXppJWVXKhoO20+Gkk+
 P7QpGfHpDjYD5ZCoM6Wb8tl4iuAkbbAwh3sNaL5C3KRPmDKOR9IMtYVL+XvOc7rteowB
 5Ct1AMlLiTpZD+l985p4sYPdJwN/DHdE4ocxy5h2PSUaXusQiOavAbdxpz9tCPEcuYSE
 c9ExgBkZ2q08CbxIXn19AS4u1jBDFYBl6QtUWzLM5j4/0Et6hQ1CU2GhDtsCN/9Loyg/
 Gntnpu8TMy6IY+V6ov+CVqfxXbj2QX+A8dQ4CQIE6x02HVn8uxN5dzv7v0LCVNC0zAAx
 sWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777578; x=1716382378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V0hj5FxGAHV6Zge8LY7D4KbAAoxrxcOWRjzC6Koc43Q=;
 b=ebGdNWT1Un59JG0qxxEGqS7GRdjVNdJFrLObT2hPljsK/32UcK3D0xMOdtZw5aGt05
 aMBUCStomORAHw1SCdHGdR5cyIyeRCZUh/ICYZXHtGxA7Od6XzIwQkxImVQnWOSEKhvR
 3hFZsChs/YYw8NyswViEuR/qtGbhanEUwX/wqNeJLOHqZIwqNKUII7hzZWXhZs9q1tqO
 GWwveRRcXsxOYXmEAn4DMXtm8NQMajhLgpzXSGcnhMw4VUR9psY8foT6Pt1inyj80KyM
 8b2kZYc4xzAAf55aHQbSufZV6q9kLCVraNLbjIJ+9kUX3mruQRk+H9J8mPCiPfEJoRc9
 uQyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp2nIfZkl0FlBtf68TsQOw07Tp3NDW4tQv2L7wk9y7fHe+K0GYXGmmN5JnUEU1PWSdsddraQ4Ez3yh7ZBIXsEYteNgHDU=
X-Gm-Message-State: AOJu0YwZ629WZKjoRRC2YerVlXm3ND1FqWuXbR1MiboNTJdMjRABFF6+
 dZGMw9YlB2/0e6K8TQ49TKi94rg+/gBYgfEp/4CEcup17s1LHFvfw39Z5wBN4D8=
X-Google-Smtp-Source: AGHT+IF5g6HIgntFpHcA3IU9dceErXUSDP/bOrEVm2RH5QT4+1z5STDdW6wAlrB3w6SWdoX+kCF/9w==
X-Received: by 2002:adf:e80b:0:b0:34c:5e02:7875 with SMTP id
 ffacd0b85a97d-3504a61c7b4mr17906941f8f.7.1715777578558; 
 Wed, 15 May 2024 05:52:58 -0700 (PDT)
Received: from [10.91.1.91] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm16369145f8f.94.2024.05.15.05.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:52:58 -0700 (PDT)
Message-ID: <18cddb9e-9509-4032-a157-5c1e05dc7a80@linaro.org>
Date: Wed, 15 May 2024 14:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/11] ui/console: Use qemu_dmabuf_get_..() helpers instead
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240514131725.931234-1-marcandre.lureau@redhat.com>
 <20240514131725.931234-6-marcandre.lureau@redhat.com>
 <0a86ac2c-3635-4bb8-b86e-5fbf93676751@linaro.org>
 <678f0a75-fc4a-4553-8e6f-4dd970db89e8@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <678f0a75-fc4a-4553-8e6f-4dd970db89e8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/15/24 14:42, Cédric Le Goater wrote:
> On 5/15/24 14:38, Richard Henderson wrote:
>> On 5/14/24 15:17, marcandre.lureau@redhat.com wrote:
>>> --- a/ui/gtk-egl.c
>>> +++ b/ui/gtk-egl.c
>>> @@ -70,6 +70,7 @@ void gd_egl_draw(VirtualConsole *vc)
>>>       QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>>>   #endif
>>>       int ww, wh, ws;
>>> +    int fence_fd;
>>>       if (!vc->gfx.gls) {
>>>           return;
>>> @@ -83,7 +84,7 @@ void gd_egl_draw(VirtualConsole *vc)
>>>       if (vc->gfx.scanout_mode) {
>>>   #ifdef CONFIG_GBM
>>>           if (dmabuf) {
>>> -            if (!dmabuf->draw_submitted) {
>>> +            if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
>>>                   return;
>>>               } else {
>>>                   dmabuf->draw_submitted = false;
>>> @@ -99,8 +100,9 @@ void gd_egl_draw(VirtualConsole *vc)
>>>   #ifdef CONFIG_GBM
>>>           if (dmabuf) {
>>>               egl_dmabuf_create_fence(dmabuf);
>>> -            if (dmabuf->fence_fd >= 0) {
>>> -                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
>>> +            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
>>> +            if (fence_fd >= 0) {
>>> +                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
>>>                   return;
>>>               }
>>>               graphic_hw_gl_block(vc->gfx.dcl.con, false);
>>
>> If !CONFIG_GBM, this causes
>>
>> ../src/ui/gtk-egl.c: In function ‘gd_egl_draw’:
>> ../src/ui/gtk-egl.c:73:9: error: unused variable ‘fence_fd’ [-Werror=unused-variable]
>>     73 |     int fence_fd;
>>        |         ^~~~~~~~
>> cc1: all warnings being treated as errors
> 
> I sent :
> 
> https://lore.kernel.org/qemu-devel/20240515100520.574383-1-clg@redhat.com/

Ah, missed that.  Thanks.

>> There is no reason to have the declaration at the top, rather than here in this block.
> 
> It could be done that way too but since we need dmabuf, it might
> as well be declared at the top.

Surely it is clearly better to limit a variable's scope to it's use, even if there is a 
convenient ifdef nearby at the top of the function...


r~


