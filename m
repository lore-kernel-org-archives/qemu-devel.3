Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE744C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8XL-00045x-5v; Fri, 25 Sep 2026 12:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8Tx-0001BC-2z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:09:09 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xA8Tu-0007kv-Rz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:09:04 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc7979d1dadso267181a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790352541; x=1790957341; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zo4UVr9NgHzNHCNt/RWIjK3x7Vl4DN69AW8Tq/SOckU=;
 b=fUkNi994V7leSfYJkvdkZ5qcP/CJNHDJXldN49UOANNOaYzA9QP1tFgU11HZKm4azB
 J1OFMZKH8GHf0hQTQ8d+XINY/BROD4InX4xX0oiu2I0Ci6T7fPKXfjl8FBx+5m07uSJP
 MYZFya4TFZ87VCJDuQMVmRP6WmmZcHegrJyuVAOuK/ELQqCxTEBTGoaSwv95Umbb5CE0
 FQ8EoQetPSp5+1rA5DVFYOyi2AY6n8GLtA/UyfiD1wOiI0DQ/a9lHSidCRTTr9VMgaX5
 4sbNWMl8vV/v3ggdspjRVER3iG9rfiBzGFJjwSJTMtromyWHy0yIZbopwAElgsykJ80S
 pZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352541; x=1790957341;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zo4UVr9NgHzNHCNt/RWIjK3x7Vl4DN69AW8Tq/SOckU=;
 b=nrF07q90vvp9i4Ib/e6IF3WBosTXwKeWE7YY3i++6gQWZ8aCIoZdBNyArSvwUmrGiA
 ztcBuaLlhqGIWy7gt89pclbUWlf8xcAZsHZjHjoegadc4JL60Qo1pWwIE7ulEkp4udzS
 Asd8QjgBY+AcAf3tuWMzlMQfC44BdNDgnmIG3KZYUiODnA+kbBxAEefO/2ZRIvifpujA
 WVIDsq/aWvGQpTasxeMHyjaXfPFvWg7JjdLe2A48QLFSkgzaFqphkAcwsdpmGO8PR72b
 K22tJ1NUngaZ60ywaBVb0MXurf6J5rQvBrzl90CCm3+bbPB182zALdj+Wvw4h18Vke8c
 2q5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiLgxy093CJYZAxolLITyzXkwYBfPlxSLhDDuGFMHheM3tV4S1nRBX/lw0ldyPvtSQiJVHLSjvPM3r@nongnu.org
X-Gm-Message-State: AFuF++nevo2VZS2H5yH43BU0xit/R/v/uzLxPrgEt6hTFWHlvK3x0AKl
 cEm1JYVdxhOSDbTHgm5Yz3Go0XGn79u0m3CGsYkeswvHdOSALJVAg0+iF9wma0Ai3YAaxj17VIH
 NT1cb
X-Gm-Gg: AYBFou3EDApNtfx6Sti3DaWaHV617VdE3mknhJei7i2myvO9657PAf4aJl737kF7vXC
 Yz3Zybdga+kK3e07/3vnuHdY6/l+67jqL1MnmIN1onEYuwHnL0uOEYox/2oC0GhhSanHUb/LUTm
 UGlrw869JGLBIV/J9na/6vHRGYNMDFhEjPVS1YG6kPPa5/k9FDD9FOMZOKv8gRSRM0RZf4QcdZV
 9NCyBqzwMpWLupoPryVSgAoKTRGq3r6ie9g6fnvxC0xkfsyMUebHbxJOh917Qk4UAH2wC5aN2PV
 YStjTnVPKS/i8JK4/ef0yPJFrdkLvQnlkbK7Y6wLwIAEinnoZXhrBPNAHkjVlM7HyvwnCKUUsZN
 rj48+pthcKvmCXT2BETFnOkvjaH4I1AdddY7Dj1oQ3wJHkGkS3yeBcJqaKkjz+h3uQJjdokVOU9
 nzVhI35buVckXYyF6T9CNnlZSnVuJ3vQSWHGJlNsSvbDdstmZCxO86Z01U6quh2ERt/Ocv8nkGj
 nDal3mCn9JHRx+U1JdVCgEjhV43IOKR+q9JC9jcvFNxAnetRFQ=
X-Received: by 2002:a05:6a20:c88b:b0:3dd:a197:edea with SMTP id
 adf61e73a8af0-3de0e9187aemr6648611637.57.1790352540970; 
 Fri, 25 Sep 2026 09:09:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87feb67dc92sm1419096b3a.51.2026.09.25.09.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:09:00 -0700 (PDT)
Message-ID: <a6cfb8ee-ce2e-408b-bc70-e85e8db7ed38@linaro.org>
Date: Fri, 25 Sep 2026 09:08:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260924135634.2626603-1-berrange@redhat.com>
 <98a4b3e6-e538-4bd2-8cad-7307ce24b698@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <98a4b3e6-e538-4bd2-8cad-7307ce24b698@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Good idea, Daniel. While you're fixing typos, Thomas:

On 9/25/26 00:51, Thomas Huth wrote:
> On 24/09/2026 15.56, Daniel P. Berrangé wrote:
>> Recently QEMU has received a denial of service attack on
>> its bug tracker in the form of 120 reports in 10 minutes,
>> and now repeated by another reporter in the form of 50
>> reports in the same day.
>>
>> Prior to switching security disclosures to the bug tracker,
>> single reporters have submited 18, 22, and 114 bug reports.

submitted.

>>
>> None of this is sustainable. It is an effective denial of
>> service attack on the project maintainers' time. Every bug
>> report is a TODO item added to someone's workload.
>>
>> It is time to put hard limits on how many bugs, discovered
>> with assitance of automated tools, we are willing to accept

assistance

>> in a givenm time frame.

given


r~

