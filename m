Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528FBD172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkU-0005kt-TG; Sun, 01 Feb 2026 18:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkO-0005cc-C6
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgkL-0000Lr-GR
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so28019415e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988048; x=1770592848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZRw4Jpq35QM/dky6kvdeQenoyRpwADsax3hxZmnnWWk=;
 b=pkeSHDuiOmhXsXgn+AGSpL9TTgFL1KxDTg89IfcXV07MAMvouU3dyEvrbhgv6HPgDG
 VamgPgEZjunDC8U1G9WV9v+hsstNlLmX7ydgd1Hp1Md0VWtUdifAZ2h85w9QFslgs6gK
 lneIuWFWzqvhIHHJQOsfO5E+Lxg+DWv2e0BBdy+nhWOQOIeS8Pr5U6dLNHYEADiOnveT
 I4cZ5TbfN57JV75H9FV6Um+qbxg30fRwcUE3FelC+/caw1QEG4f8MIb43/lOMXlwyZb1
 r/gLIoUovytAiIzLb+/fQkppJbvdMjlT6v7ZujeW7axCTsnl6DTW6XAVbFIw1JZqOh+a
 bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988048; x=1770592848;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRw4Jpq35QM/dky6kvdeQenoyRpwADsax3hxZmnnWWk=;
 b=xDJidPimG3KDADb9aIwCK/2BrDTv9iL1zdpIA9hAhQ9YmHwLEH9w0c9P0bzqj7uJYH
 NyGxuHaCTR5V5U/swsGgOZi76QUGpUwV/GlNNM6owia6K81nU7KHuKvFuXnk/Hl7TcNg
 LMOvdIy3DfwAr9pBKpzEb3EmYl7Dls7Fk8errtHhGsSWxSauailoOPNQ/rcaptFEjSTd
 d8eYxANGEqZDupo18PhwTIVAKR8bfbVPvph3dq0Evgqoo18zB59kEDW68OFK3q/LWcB9
 HRUgE/ooYIVSsWci2ONQtvYUEVR8k01ZMTKLap9YnNTwXZtjU0OTGWK3iBE1V97KPNRG
 L7BA==
X-Gm-Message-State: AOJu0YyMIIT/jhT/IkW00Q7xNzzO0SukbgXHzh3ps2iCcemEhGVKVEnj
 8+jT5ki5WCKA3L4OmO4iSJ1SYpGNo0sf9QgkWfr/C2iaGLQR8IVMIQv6OtIgyMoMusU=
X-Gm-Gg: AZuq6aJ35jzu0q/G2oYOvllf3Bb75WdeK0VbpMO1E43mikEqdDFCR3vao4/rDLSQLF1
 gYL+auRL30efIeiM1fGod4UBrz3oDmjYSzNObUasVBMNUs0mzWP42Oy2BkzdHmmeTVBbPwDZzDA
 ummovJzWXVgQHIJKNMIdi3L6Zvmtxtqlq7of2Zft4yW8s2NaRSwqqL2g0B/33mKFMazqGi9NOz3
 ojwiNvIoj5xyBrYl+yhzlgdPw8KqIvGghIQk/l9MlHMLxwRw9oy2FLBGydL7g0tOZa2gevMAwbV
 +0OzJs6jZiVkv9tyGKrWGrvmcpHLuFf+W1+lcrXp6vNF2KMm3P0pJf3x1WEGM7DGyEJ9EXTLm+y
 jMF2zqLn6PJiAxKnwILgOXsZUt9UjGp9PbhArLiUC9WyJTVQ0NccVfAe3+XafPQ5XJwIVWUf13e
 +B4hBnACwKe6VrufejBk/dGeUjB6ArfBQwoLSAYUqWb5IneqSEo4oN1g==
X-Received: by 2002:a05:600c:608a:b0:477:214f:bd95 with SMTP id
 5b1f17b1804b1-482db491f0emr104404945e9.23.1769988047872; 
 Sun, 01 Feb 2026 15:20:47 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd78d3sm365491525e9.1.2026.02.01.15.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:20:47 -0800 (PST)
Message-ID: <cf73175f-0616-4830-af38-bcb7d21d31c0@linaro.org>
Date: Mon, 2 Feb 2026 00:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
 <20260131124842-mutt-send-email-mst@kernel.org>
 <299f59f7-62c3-42f4-99c4-b7c7cfb111c2@linaro.org>
 <3417f499-f5ac-41c5-8d40-33c5c1c10e50@linaro.org>
In-Reply-To: <3417f499-f5ac-41c5-8d40-33c5c1c10e50@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/2/26 23:41, Philippe Mathieu-Daudé wrote:
> On 1/2/26 23:36, Philippe Mathieu-Daudé wrote:
>> On 31/1/26 18:48, Michael S. Tsirkin wrote:
>>> On Fri, Jan 30, 2026 at 06:00:56PM -0800, Pierrick Bouvier wrote:
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Performance impact?
>>>
>>> the reason we have these is for performance ...
>>
>> If this is a worry, we can declare the virtio LD/ST helpers in
>> VirtIODevice and set them in virtio_reset(); the call chain will
>> be even simpler than doing that check on every calls.
> 
> Or just have a VirtIODevice::access_is_big_endian boolean
> field (re)initialized in virtio_reset(), and drop this
> virtio_access_is_big_endian() method.

Implemented as v2:
https://lore.kernel.org/qemu-devel/20260201231959.88559-1-philmd@linaro.org/

