Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFEBC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqX2r-0007Kt-J1; Fri, 07 Mar 2025 07:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqX2X-000793-Cm
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:43:00 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqX2V-0006oy-Ec
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:42:57 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so15279605e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741351373; x=1741956173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vRnjOs83itsvoh900U1UZ4mbuqsyGHaXX1sMayf90qE=;
 b=ZHKDigCL+VoylTcT9Y1KwArPgrSyea+2JzdJziQEFPqk9jq3eQj2XerlWGc8O1bgAK
 jOLZXVRer+xFftr+ch8f91m3YKfy95YCuIRvTc1Rowz5xmoi25KO72nlZGo5AWyYC4bf
 1AmsEeyc2o9WadFXmkn+H4hFn9j8y66ZRDAveLcpnHIiqh2fa8VZlEoJrsCK+n+GtS9h
 rHpoUpfHqALjaAcx6HgY17ECYvw/5YKuANfQgpSEXuLBenUbC27v7wpK7YZQU1HYJefe
 3sxXp3Rq/+c3Lr55zR6WiazTnSmiovAbpTtl3YAKEykYJOVpk5s3V1wd6809qksVu0B9
 t7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741351373; x=1741956173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vRnjOs83itsvoh900U1UZ4mbuqsyGHaXX1sMayf90qE=;
 b=UdffdeR49rnLnWVTIYqZ3xt1q65617Vawdormq9+qZ1oxP4KJq96o1LbAPljYz6o+c
 A1M8S9pUX4ocNzIvZgbzok1t4h2stw1R3P3f9S+tcMAHE0WQi//thjuaymXjQYBHn3ll
 6W+1aOIaaggtLaa/09+vp6rxQT1RCKHMnVtYU6LKtNmL49TsQYo//9rPtAF+Z99H1f8r
 oOkO4R1pH45cdIPW4QYU4zjXFmnKdK6RRiH2OCKCtLl0SNGLyKsNEjjHCR2mb40aEpGi
 5juTmFlYJkIgIbMEkPzJt2TElKKFykx21+G7jiQMGSOed5EeiVj1tf/llUk8RMvdaAHz
 IPjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa6TLR/R2hQMX2AEcFwJhZ20AQ1k7KCy2vChGTNhi5KIKhUhMQrA/5tSNj1ZysK/tB/O14PVWr5zRB@nongnu.org
X-Gm-Message-State: AOJu0YyHcdiXSTNEksIBKjK/OBPI7I2EGQvglGK4w/TsRozeYs0vbmaH
 qAjUpepbyZaPUeqMNmiPW7Y/RBUbTr+PG0ejqJp3nTsI7mkR3/GALUNL7IeIfU8=
X-Gm-Gg: ASbGncvtNYkW/67NiAFNO0V63T4JylNgdpKEyMvhJEJ9akf5Y0TW7xxBu3fIH6B8osH
 NeIv4gB3OLhEfvrCGhHWIlHtn96L0EyfpMIG5wN4Q52Tkt+RZhfofYLLFrioWywJW0DssL7hr9N
 wSUyqn5CfLBtXIW/oxGYYAiLEEe0AQcANLcp7NVw1BPQefPPYfE5LACavHpPrrWLWeHzGJQYrjB
 AVfa03NFmzvBEMOOEqDQOWk987SA0woiXLJrXsd+kdw0TXfRk0FLsZd6v7bdNVxuwPGqbarUJUj
 YtwW6xRxpwiJdXrxcgvuId4VMQjCnMbteVC+W4oL5WKCtW7VbQggL7ZaZqrgBFjVJDtP5aiybMa
 OLkUBOx2amWsu
X-Google-Smtp-Source: AGHT+IHJOC32WMs4g0zIuuaSXrBFJNSDvr64uajuzqGyLtVJ6QDGvqTckjXERkChVUF9ZjT/QI/npg==
X-Received: by 2002:a05:600c:35d1:b0:439:967b:46fc with SMTP id
 5b1f17b1804b1-43c601d9167mr22519845e9.8.1741351373097; 
 Fri, 07 Mar 2025 04:42:53 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e4065sm5337212f8f.62.2025.03.07.04.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:42:52 -0800 (PST)
Message-ID: <bcfac7ad-8631-44f6-9b65-aab39b945d4d@linaro.org>
Date: Fri, 7 Mar 2025 13:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/15] tests/functional: fix race in virtio balloon test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
 <20250307115314.1096373-11-thuth@redhat.com>
 <69bc17ce-de05-4b4f-88c2-57866c6409c4@linaro.org>
 <1d1756d1-e16c-474d-b220-05829a2a8ab3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1d1756d1-e16c-474d-b220-05829a2a8ab3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 7/3/25 13:39, Thomas Huth wrote:
> On 07/03/2025 13.34, Philippe Mathieu-Daudé wrote:
>> Hi Thomas, Daniel,
>>
>> On 7/3/25 12:53, Thomas Huth wrote:
>>> From: Daniel P. Berrangé <berrange@redhat.com>
>>>
>>> There are two race conditions in the recently added virtio balloon
>>> test
>>>
>>>   * The /dev/vda device node is not ready
>>>   * The virtio-balloon driver has not issued the first stats refresh
>>>
>>> To fix the former, monitor dmesg for a line about 'vda'.
>>>
>>> To fix the latter, retry the stats query until seeing fresh data.
>>>
>>> Adding 'quiet' to the kernel command line reduces serial output
>>> which otherwise slows boot, making it less likely to hit the former
>>> race too.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> [thuth: Break long line to avoid checkpatch error]
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/functional/test_virtio_balloon.py | 26 ++++++++++++++++++++-----
>>>   1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> This fix isn't really working, and is more of band-aid IIUC.
>>
>> With the following patch restricting to KVM accel, do we still want it 
>> merged?
> 
> Yes, I think it still makes this test more robust.

Fine then, thanks.

