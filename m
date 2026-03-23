Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16563F483D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iF1-0004M8-27; Mon, 23 Mar 2026 12:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iEt-0004KK-Hi
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:34:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iEq-0003nf-SS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:34:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso3090805e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774283685; x=1774888485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W44l1oLZoJUW7IKaKFPRn2qixRx23D3QDvkpQdC+BBs=;
 b=S7Ay4OJuAYTsHlnthae/BLu8ExhidCHCytbD9fGloj3VF7D0SLM3vWzNApMQeGnIO0
 exL7luSQlV5GosXY3f5zLAa8zRjGlQBpHf4Kj3ZdD0i/OoGKDlr7Zmtqd9gpo+ei6C/l
 9egMZRmqvYv6DWMAcBszvqc8xrH4nxKhbaA3fj0wTYLsF/BgQp03mNnu+d1T9s3c4HzH
 2I4EYmjkV+b1L2tuV/O968aVmb53bKkuWRUaZ9kqPquCUO/DrybJOy/HznmcoG6Y9oHZ
 cKsCJKPjzk95HmysTgThcKbP2MhrGg7ryrxRfngm/DQ3e+ydTNEaJTXftu+SK/IOWrBt
 XEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774283685; x=1774888485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W44l1oLZoJUW7IKaKFPRn2qixRx23D3QDvkpQdC+BBs=;
 b=fLStIQjlD14Xi2FfZV/WU1e471GlPeqPHkPjkAjlI50MCpW9ZBgmnrfSmH54Rr4y1k
 y5oLYqT85tHqEoGcMLhIAikM9CiyvY7hiZVyw8FCiJmscYm0nmQOQtX/0mysXZxCUYNk
 iKoZpIm5bJnwehAClkpxJOXL3LM3bOVTxEOvYEqzEv+Kplf0Lrq6UkZ7I2hIv1yJJzuj
 MaROwxxjVrOe0Alxc518IePILoRsJBzsCrt9eLqQiE26naB8IDeJtLzI+0EUlzW4TNWW
 uo2sRcnZE1z6n1G6VnyokpxEmknwrItJkk8M+nGdTn+u67nIOXgaJw0RnB2csJutEvXU
 TVLQ==
X-Gm-Message-State: AOJu0YxUW9aB1m8lOhbJ2E6JGnO+LEPC/p+APEsuld0TcGYMuhL3fsuY
 gpCam+SXvaMBSlgN0IK6uaxrskT3a9yKMlAEQnju8+uw2qiTs0hW/iRYKyQi5Jif9h8=
X-Gm-Gg: ATEYQzyZ3q6yvomFe16XES2mMQtOctF2h7UHaKMBQ5z2LTS+nGokf0pPVfICSJcQ0Nl
 Bz4dmi9aIBuJyx66QE46BGTFA3SUWty34+vVEb8utYP2J6VY/jeSyfEUF3i0f0JlUJj8ODe0LFo
 MmA5v4QOV80lz2LYcNhr78LAH+HkMhreXlTCIYOLXnuRNmfhGxYZ4cRbdfQdKb4e61xrNKUl+L8
 IPUTe9bPjUc+INwXI2eHgs1+bKFm9q1NBhuPxdti/Gv1Mee0IB0u+8lW6CjserAfLyxyUxxLMG8
 K9WwODnrrZ22U8zng5IIEDg/8GEB9QaO8gTjp9lmYFYfSo1d7gw9Unk2/pqjuvr0RlSYK6n0Pgq
 rOYYuCK54/c2MvdBYx7L9FrIQ9Vw9s5f1KqBrD0V/jaY/JRKLqXRhngRXWz9iunMwvUDtAXsZQF
 CHA53XcHu/T5irh21a9gOC9V0sIIsE+bFf2SwmLl0yjZrSp7Y/GZ/zw84AHqkKMiaH6Q==
X-Received: by 2002:a05:600c:c083:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-486fedf9b7cmr146302285e9.11.1774283684840; 
 Mon, 23 Mar 2026 09:34:44 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe85e4b4sm85751705e9.3.2026.03.23.09.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 09:34:43 -0700 (PDT)
Message-ID: <1c1bf900-aa17-4db4-8d33-fca40ed4da58@linaro.org>
Date: Mon, 23 Mar 2026 17:34:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260323151934.92880-1-philmd@linaro.org>
 <CAFEAcA-F8_B8ni2kNefoG2f9dwB9NXXCV9M_V3sd2k=KWYf6SA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-F8_B8ni2kNefoG2f9dwB9NXXCV9M_V3sd2k=KWYf6SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 23/3/26 17:30, Peter Maydell wrote:
> On Mon, 23 Mar 2026 at 15:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We use "deprecated since ..." and "removed in ...".
>> Replace "since" by "removed in" for removed features.
>>
>> Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
>> Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
>> Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
>> Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
>> Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
>> Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
>> Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
>> Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument @detach")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I checked these commits to confirm that none of them were cases
> where the "since X.Y" had just been moved over to removed.rst
> without updating it from the "version we deprecated this in"
> value to "version we actually removed it" value.

Me too :D

> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

