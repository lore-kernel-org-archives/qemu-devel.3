Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18082C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPga-00055e-C1; Tue, 18 Feb 2025 10:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPgY-00055K-El
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkPgW-00021L-5U
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739893134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q6RSWJxfEGqes3umox+llGPyGNYXu5Aw8FHp2E+UoKk=;
 b=irsDQkcBnBT50bIilZsK2Jsfe9JOr1gAROqoxZuUAdz8N6vOfIslgqwvMfHZSwwz4lNhhB
 u39hI+IRaJ0Zod3VsKMM+d1fL5cwAjYKxyRR0km1T2BLRBxKGXluPi4v2ZG3387VuOXKr2
 rQFTirEO/0fxDI4NINDoClrRyZcm6rw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-ZWkYc0IjMLaYUGaqdNlRIA-1; Tue, 18 Feb 2025 10:38:52 -0500
X-MC-Unique: ZWkYc0IjMLaYUGaqdNlRIA-1
X-Mimecast-MFC-AGG-ID: ZWkYc0IjMLaYUGaqdNlRIA_1739893131
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394b2c19ccso46336385e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 07:38:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739893131; x=1740497931;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q6RSWJxfEGqes3umox+llGPyGNYXu5Aw8FHp2E+UoKk=;
 b=XgLkI4i9Iwb0EUHvZVzLOpeNOmgAchLXSAm5SRYyJ55CW7p3G1BCKu1zK9tOqdrAwm
 3/64pMlUxbrvTh89I2xxgK7K3TjX47fjXafLlRir4oPbdYquM0kYwH9OvvsAaQCSrsxE
 5vcts4yLubJlkvdemMwW2oDc62OFouiZAotlaaSMWLbE2P9hHHgBS9OGMquzq9a3YlFa
 dc8RmEmcsIdTmtaBZXrDoscDKKmSraJPXHwXHvJQpjhEpOC/vu8KO/DNLQiAko6uacXG
 1IQ3vbzAUlZIJYLFTuODnzKo7hrgFkSP5wKtSW6q7Lm06O3taeiDBwE+jOfCYKYChK7x
 0wuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/oAQDLezcVPZwEKzl8fZggIMG6G2Kxgn3feR/SB4seoCVq9xUnuhM86gvf+3p4xoLmENqtLBIMES6@nongnu.org
X-Gm-Message-State: AOJu0Yw889sVTgtJ+R7saP7NZIT8prz34kM6aftY8yyzOpww6Alao91F
 sVKlv8SP818QdC5JXPN8YkFDy7gTzBi228w4uJz4Gro2+z0KNSaVdI73J6MZOfPazw4Mi1ygsuG
 GtV0dRoXBt3CBCATPqjoWTOrOlH4sJe1V1c0IniDjTQ3yrugnXU9y
X-Gm-Gg: ASbGncs0ZYGaoRwtIdRy9jyaudkLq1KEIVyUAjhNp3eV5OXgD0G6QlGnQMuqn+PGP8z
 4hq3G1ijy+E2uoM/TX889vSij2l3M1VScuDR3ZyV550m9ZJ41tl63eYhh39GLIkeU+eXODJ16IB
 bnK9c5nxkdhIpdbsFJqU8+kQC9aUCeL/BaaerACB/7oXvqv2AQsIWZ02JRdFpcTUPvkZnfNsUeR
 LcRPwm+5nawu/uddykyxLaD2pA5MWyuou4nBxN4Vkns01Rv/RAzYyGnNcQho4xdzokVDUGWYQF0
 7Sj8eQig60Sfp0ios0ezxuIouBHDSbNLzgm2bipsTHVynfIZmfV8
X-Received: by 2002:a05:600c:4450:b0:439:916a:b3db with SMTP id
 5b1f17b1804b1-439916ab5bdmr53775025e9.6.1739893131141; 
 Tue, 18 Feb 2025 07:38:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0lXXYKr9Ztikg8NlradTIHoBc+AjlyWYZwDDRD7KWTu7PVtvQSEf4kPCeJMnHMcT0YHL+kg==
X-Received: by 2002:a05:600c:4450:b0:439:916a:b3db with SMTP id
 5b1f17b1804b1-439916ab5bdmr53774765e9.6.1739893130745; 
 Tue, 18 Feb 2025 07:38:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43959d3d5f3sm185943015e9.0.2025.02.18.07.38.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:38:49 -0800 (PST)
Message-ID: <884138d7-3b76-406d-8603-16eaa59deaba@redhat.com>
Date: Tue, 18 Feb 2025 16:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] arm/cpu: Add generated files
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-16-cohuck@redhat.com>
 <f5878231-79b8-4e29-bfb0-f9a57ac3f6a4@linaro.org> <874j117rnn.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <874j117rnn.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 2/10/25 4:20 PM, Cornelia Huck wrote:
> On Fri, Feb 07 2025, Richard Henderson <richard.henderson@linaro.org> wrote:
>
>> On 2/7/25 03:02, Cornelia Huck wrote:
>>> And switch to using the generated definitions.
>>>
>>> Generated against Linux 6.14-rc1.
>>>
>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>> ---
>>>   target/arm/cpu-sysreg-properties.c | 716 ++++++++++++++++++++++++++++-
>>>   target/arm/cpu-sysregs.h           | 116 +----
>>>   target/arm/cpu-sysregs.h.inc       | 164 +++++++
>>>   3 files changed, 860 insertions(+), 136 deletions(-)
>>>   create mode 100644 target/arm/cpu-sysregs.h.inc
>> Why are we committing generated files and not generating them at build-time?
> We'd either have to carry a copy of Linux' sysregs file, or generate a
> build dependency on Linux. I think we should handle this similar to the
> Linux headers update, where we do an explicit update and check for
> anything unexpected that might have crept in. (Same applies if we switch
> to any other external source for register definitions.)

Yes this was the initial intent, I mean do a manual import from linux
sysreg or any other reliable source such as the JSON dump pointed out by
Marc. That way we are still able to analyze potential breakages.

Eric
>
>


