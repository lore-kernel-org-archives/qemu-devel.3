Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7965CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSaZi-00066a-Om; Thu, 28 May 2026 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSaZg-00065r-8a
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:15:00 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSaZd-0006Yn-DC
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:14:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4904127c32cso41569385e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779974094; x=1780578894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1sXnDjBtedl4dlu3qx2UCX04Ft34HYDbeu+lvubeXM=;
 b=QE6kUVGWQRer6JTdcPhpCG8ctTLKZy+Vptt5QmdxQ6ay/3lcusW8qjT/0TsYQaOLgT
 GnF3xb+9DFr1P0Jc55BWKjoHQ1lhL9XimUdO53ZaNiC+32DzGw4aoNU4U3oFAMTZDdDl
 NhCLY1FoAE27tSQuSLrjsP9kQ7zR/GkzNRheaoPrBthnuPBY0mZckv6eQTy3Gn+QmWoL
 iDOHDiInEZcJQMHioRCcFUx7ssPVoAshrKEeH6LAHdtUxLfzYbhQimamFMudeM+pdgir
 l58j10dQaQrKbs8Nt/GGaZcYpZ+6uXHhtWvNK4uuDZ3/bc/kaaWP5whcV4K819HtcT00
 ECww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974094; x=1780578894;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1sXnDjBtedl4dlu3qx2UCX04Ft34HYDbeu+lvubeXM=;
 b=oQjCX+xw2QH+VTW7Om4P7yTuoz8yAmx5wDJGXbxo+TI245krI/6bf1xYas71Ol5jz4
 Smpg8Wmjq+1Xl3b70fNFUYJFxn0vDCS5Yq0koqsvPqg5zbm+AswE/UXqhIjitSwRL9/Q
 s0wjf79doazEuVykb+in3oiE+yAu/MBpdWHzwhGUh1kpIhrEkoj6wSQJy+2+C/R3flDq
 PhtENdhJrCmHDsZwxE/w19Oj69pnEVxNxf0Z8CIZ6gFlnfP3Copx6RHB6yEaI0Ki9A4L
 wujxvEW4P+dJqqlFA60/ymrXRCH9VAGVoOXktMNaeOqgjU9YaKgtYVYTEpmXLLOhqMNW
 lu7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fkNAf0rjk/nRe/ZkRXOL8Qbz1IkdDRrZ/fipC8rnbHLpUJQXnuAXz9y79OFsaaaBGOxTu/jla9FrE@nongnu.org
X-Gm-Message-State: AOJu0YwCsy+2peYrTaLGDnLni1vyLi8xmL+ZzwFkBEUT/Up+yRlXq/jG
 wj0fbhiZzjOK1aceysi2LDrkF/RMgDIOqCT48iMs89ZO8VHoa0uFq/yb3N0gwpXS8H4=
X-Gm-Gg: Acq92OE7/ReKW9ySaH4IVT+hnYtWGV9BWj+JedaI0ANUlumUTy60zo2fJVHaEd1jZYO
 FX2l46IHBQBfncB6tsV2mryjFY3GFus774enoCbg3YcbewtT27/7g4CsHcoTJhKzJ+BYEokY98c
 IoPMmMY2ctyL+6XMjO7WGCdCjS1vZuHGdcQPGWYt5pFBOrRsShPcXOHlge4m0616lz/ioQqIEHn
 mZ9CLXwkU5jctHcPhapqc3rRT4jZgar2KV7Ynv3qe53rdt6fkB5PXO6GM1ZWj/tdyjcixFLXROC
 mLKLFSGKFKGqp6o3fEcTFaoQqvJIshuKkWnzJfg/NSXqBuGafD8dEZ0K+uv37ejPB1k8aUC4jFL
 eTgK/HJf93YilerT7u2kg9sEGvWQohKizDnVOGslJmhDzhSFG33qP7ajmWXtZX5CYqBWdEStrkg
 U/K3ey4DP+YR//sGruNgp4OjHmYsnGkCbyIw5vr8oKhZOOSCZm/5X/hFbN5xe9jirknro5/IOEt
 tiy
X-Received: by 2002:a05:600d:6413:20b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-490428ed552mr336011285e9.29.1779974094195; 
 Thu, 28 May 2026 06:14:54 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b57054esm17360705e9.3.2026.05.28.06.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 06:14:53 -0700 (PDT)
Message-ID: <97305cce-c9d4-462d-994e-69c81798234e@linaro.org>
Date: Thu, 28 May 2026 15:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Update email addresses for Daniel Henrique
 Barboza
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20260528083814.32795-1-philmd@linaro.org>
 <ce9f76c7-7a19-48df-a5f9-675573570b50@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ce9f76c7-7a19-48df-a5f9-675573570b50@oss.qualcomm.com>
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

On 28/5/26 13:25, Daniel Henrique Barboza wrote:
> 
> 
> On 5/28/2026 5:38 AM, Philippe Mathieu-Daudé wrote:
>> Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> I suppose your gmail one could also go
> 
> Yeah, got a handful of patches on that one as well.
> 
> If you could add the entry for "danielhb413@gmail.com" in this patch
> that would be great.

OK, done and queued, thanks!

> 
> 
> And also slap in a
> 
> 
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> 
> 
> And thanks for doing it!  I completely forgot about .mailmap ....
> 
>> ---
>>   .mailmap | 2 ++
>>   1 file changed, 2 insertions(+)

