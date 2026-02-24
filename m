Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFC0F4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuyD4-0007QJ-IY; Tue, 24 Feb 2026 14:36:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuyD3-0007Q7-Cm
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:36:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuyD1-0001M5-Kw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:36:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48378136adcso35544665e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961798; x=1772566598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gz0hdvwNtJpyGLr4uNgkGLDV5sk43Pa1ZYps8z6H3y4=;
 b=OGGChNhypXTqkGDJWbSQIFSqhe6La2PI+7Qbivn2uimo9FqvkIpAenF/AeiEQZYcY8
 GTcrL+gUm6d2xaLyF8BGIGElokUwm5lK0K2oHPRh0Mz/1g8HvqQyS6wyYf+mFXQxdzCz
 r0fK64kqHT176EmVeTtxCbtWiwB2CpoDISiYxu4I6lxCFt7r1rOMUIvWKC+1TgWrwEeM
 YkFE4SXXv+MjC/HHbhBLh0iSPMHXb1jWs5ogFVRIq8fg9k1RPPtmg1uRNuwfqT0n4ADY
 TQRVz1AEcpW1WpCkjCW+G7TbzzWB2eOrp1aX035Ij4CwnnN19usZSY5USIkQ0fITUwPB
 KiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961798; x=1772566598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gz0hdvwNtJpyGLr4uNgkGLDV5sk43Pa1ZYps8z6H3y4=;
 b=FqMwhQCDepWcRSY0SqwC5xpjOyWIv9vbgCeUzrphjUUt61qAq44lTHgw4h6f+g/gRC
 jVG6ydkHxel96EU0tAMha5JGH7PjcTkutrp/CO9K6gSOmIxgF4sorA1jXyNYfZL9Wdxs
 oPY9D98X6eOXbxP2LpK8kysLxhlACOuQDKfUO8Ts6mB1UUnpX5bziRuSqm+2ul4MMHZ8
 f/7sB9RZr1mHis7wY7WhDl7UI/wYIm3/xDeLMlZkgdoYQsAVyZDC4nUv8kZ1ylg5Nj88
 pxLhs/B1DiyxfVRnrE+PMoUVODyNgajlu3ZmmxEKYI/vJwZnTtZKI3egoyvdW8sLnP5K
 J4tw==
X-Gm-Message-State: AOJu0Yy4kASg3EYL7LB/31cGkWGSuaNt3SqRUMCyitKvXMY6gTh7DTUL
 dTkj1l5Bddb7Ndq2ZpgG8c0FCqI7YTth6KNSf+YCJYljmZiobcb3NgJrhVcVkTp/L+4=
X-Gm-Gg: AZuq6aIbKAXHFTivZiJ6RmjYNm9xFZTa5kdt4HX3UY2IltpvCZJXQob6YtqdpoB2VOS
 S9kFzjCjA05TmZAu7G+DSdqi8f++uBEED/l0SRgJvMb30ZkPfq9sEApEycC2NyIVduKF9YREVaR
 eoAevldxizMtQypRkQJw1+iqYvp2rW3JsnEiL67NNiJxq7tMmDDL9j9MtfwiCmaumzYCnVWENQD
 nN1us/8L38AY5dJMLOXrJDLvPSslJEaxZbHra2T9cCseG/dTgrLGFKtlAGB5zBT1e2qGmP1LD/I
 uyP+jHGza+pcYvo4gYsB3B7SBkq/h2ouxN7SHHP66TzfURAXlKFOxEm+oguv7OCM6Ce1ujxSjSX
 lyyCSDfAYsnBYB1a+5KK+uOwOABRUzL1rgn5J995jCRCnUwTAJkAXDdKOJikposMwGshQeunKw8
 lUk6W11hqfHdn7nu919mEEyNentpZqDsVBx5QzxBaP19mLxzaZMbuvIRqt1p55rWC38w==
X-Received: by 2002:a05:600c:1f93:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-483a962cf2bmr241127375e9.20.1771961798095; 
 Tue, 24 Feb 2026 11:36:38 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa015sm29091103f8f.8.2026.02.24.11.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:36:37 -0800 (PST)
Message-ID: <7e01d12e-d66e-4a06-90aa-b9547fb6d34b@linaro.org>
Date: Tue, 24 Feb 2026 20:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Content-Language: en-US
To: stefanha@redhat.com, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, richard.henderson@linaro.org,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
 <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
 <20260224134436-mutt-send-email-mst@kernel.org>
 <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8e97ad8-e54c-4134-a7d8-cbc91f7f4bae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

On 24/2/26 20:21, Pierrick Bouvier wrote:
> On 2/24/26 11:07 AM, Michael S. Tsirkin wrote:
>> On Tue, Feb 24, 2026 at 07:33:14PM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Pierrick,
>>>
>>> On 13/2/26 00:45, Pierrick Bouvier wrote:
>>>> This series eliminates some target specifics in hw/virtio and 
>>>> replace them with
>>>> runtime functions where needed, to be able to link virtio code in 
>>>> single-binary.
>>>> After a first try on a series [0] doing this change and making all 
>>>> virtio files
>>>> common, Richard asked to refactor this part, thus this independent 
>>>> series.
>>>
>>>> Pierrick Bouvier (3):
>>>>     hw/virtio: add virtio_vdev_is_{modern, legacy}
>>>>     hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
>>>>     hw/virtio: remove virtio_access_is_big_endian
>>>
>>> Patch #2 has been merged as commit 6325407f67d.
>>>
>>> Since we don't have feedback from the maintainers Cc'ed, I took
>>> the liberty to rebase your series, trying to address Zoltan's
>>> concerns on patch #1.
>>
>>
>> So as I said, main use-case where we would worry about perf is
>> virtio storage. So it's mostly for storage guys to ack.
>> Did not get Stefan's feedback yet on whether he is happy.

Are you available to discuss this topic during our next community
call (Tue March 3, 2pm UTC)?

>> I don't understand if we always want to build a single binary though.
>> If not we could address all perf worries by having both  generic
>> and target specific implementations by using linker tricks (weak 
>> symbols or
>> whatnot).
>>
> 
> This is not possible unfortunately, since concerned function is declared 
> static inline. If we want to follow the linker approach, we would still 
> have to pay for an indirect function call. That's why we insist so much 
> to change the current definition, as it's the only way to move forward.
> 
> The other solution is to exclude virtio completely from single-binary, 
> but we don't want to have specific config for this, and we worked hard 
> to keep our promise over all other subsystems we touched with satisfying 
> compromises for concerned maintainers.
> Virtio and vfio are the last two left. After that, there is nothing 
> really blocking the path towards the goal.
> 
> I invite you to watch the presentation we did with Philippe in latest 
> KVM Forum, it will probably answers on some of your questions.
> 
> Especially, you'll see we insist on single binary being a recollection 
> of existing compilation units, and not yet another configuration to 
> build (and potentially fail).
> 
> Regards,
> Pierrick


