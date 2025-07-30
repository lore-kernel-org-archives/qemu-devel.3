Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7DBC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 19:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhCqA-0004nb-JA; Wed, 30 Jul 2025 15:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAx9-00034S-Bh
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:51:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhAx7-0000hC-Dr
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 13:50:59 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-749248d06faso71556b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753897856; x=1754502656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VNrO12I8KamjpTEvKeyYR8bolSvXBUZT91FWh7UG0aU=;
 b=kFWxV1F/CwYHcHFj/auCUWqCKBg+zI2O/oixo5I5jOj/MIcCW0t+qxI8mhEl9ciK6v
 wXRWhKGYroWk0GlvB8K3ilYz0PwkOE3nDXaYqRpgI2VAPTVk59BCTqYmHSShsRMyf5yi
 7HjFdl9acyaoggPN0Q9KaDj4EGewuA4M+8ul2pTA3J/vhW+mUP9HqD2PjoBq8YwHs+CO
 gF28OhXzHIYWJY5K1zV26j0rjLs5fs/iLXXoVCc8jy65byCEqNL71SQgn5KWuwIdwm0j
 IQ++V94MCp9r4LBNwEVlnriIWiDZULuj3cJ0d6Vdzy9C0k7A8ebgvEkOKAP7opZ3nVz1
 cZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753897856; x=1754502656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VNrO12I8KamjpTEvKeyYR8bolSvXBUZT91FWh7UG0aU=;
 b=BAvLLkaD5I4Ao5cyBsfBUKQnjhs+sOZfc7anqqefzVHsEv4hPr/ClbsauX1DdnjYer
 E/I11CM4LGzs8MN+8hIQ7Rlm8UkLLmJpuUYRPwIuSXSBGSj5+cBVWUrOYj9P6cUpIuSt
 LBeDMGFBf9Ard0zk3PTEtF6S6h29nzXs+dkD0v04S453BtaUPWf/mnsguGle/3w5SeTy
 bI/fsMrjVDJUpoBjjLQlq8CKkms+HT9Uq8w5fPmtJ/vtcNWmU7+3ZPvq0N8VcU1FCocl
 fS7RjQdJzDKUCv8Oqs9HjmFe4bUc5gyfPHzF/NUDPI5kbBjS6EC6GUwe5KMSjFkMFbeq
 Wg1w==
X-Gm-Message-State: AOJu0YyqLXQgF/Vkkg+WgCu6B0HcwozWY7ukNWH0SOfl6L8RHPSPPPx1
 pEORww2mIzmgS+0m0mBBPQon9RrGDEWV4ePn5MBz+WBv1OJPv0iicv2NgjaHrbxYz6sIY8OR/Wv
 3OR5E
X-Gm-Gg: ASbGnctUiJVExLkqGGWVRahEJjA3ATI8KrSiJBaVi7Y1Vo+8gKwEsaUeLnr3Z4itBeu
 pOQLPY65XXPmKX/Yr3rQZrGt3vcTK+pKOsiN7warQ7TxVipy/fhbWByKGJ1VZeGO0d5nNMXarex
 JX0ZveXCa1WD4TKkij5Kdl/c5h7UT5nksgkMeMqjJAkzOaDK02ck8XfYmUO+nLGNiA9ewNLOu66
 wEOrVSfgOA3xEJws+kwzIF8WNM5xW7pZtKwKPBCzvtbt/0eeAsL2M5xqeI+P+3T5FqgYNw8SZhd
 54MGOhQJfgxUgtmUl+0xPwQA1pY+fKZvC8yrY/xuj/hgfgdxbC6Ll477WJq2iOX9p7GeIz30KbU
 9hffjZ/nyYfpIgSHDXD1r+xg/MFCi9iOziMA=
X-Google-Smtp-Source: AGHT+IGN6NiIQq3/FAwo7T4dRVjoCkQtKrdNf5dFArLNpKiSll5HbPzsTytCg9mmCr6h3LMt+rVF1w==
X-Received: by 2002:a05:6a21:328a:b0:21f:5598:4c2c with SMTP id
 adf61e73a8af0-23dc0d91091mr6887279637.13.1753897855864; 
 Wed, 30 Jul 2025 10:50:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b42130b3592sm3574349a12.10.2025.07.30.10.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 10:50:55 -0700 (PDT)
Message-ID: <e6ac95ae-38c8-49b4-9883-9aef8a12899d@linaro.org>
Date: Wed, 30 Jul 2025 10:50:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] contrib/plugins/hotblocks: Minor bug fixes and add
 limit argument
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex Bradbury <asb@igalia.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com
References: <cover.1753857212.git.asb@igalia.com>
 <CAAjaMXbxpauL8V2FVbQ6-8TNVbG7ATRjm0Gn+J_cb=aiK_cG4A@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAAjaMXbxpauL8V2FVbQ6-8TNVbG7ATRjm0Gn+J_cb=aiK_cG4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/30/25 6:48 AM, Manos Pitsidianakis wrote:
> Hi Alex,
> 
> On Wed, Jul 30, 2025 at 4:19 PM Alex Bradbury <asb@igalia.com> wrote:
>>
>> This series contains one minor feature addition and a series of small
>> bugfixes/improvements. The addition that motivates the submission is to add a
>> limit argument for the hotblocks plugin, allowing you to control how many
>> blocks are printed rather than being hardcoded to the 20 most executed.
>> Setting limit=0 and dumping information about all executed blocks is
>> incredibly helpful for an analysis script I have downstream.
>>
>> This is my first contribution to QEMU. I've attempted to follow all of the
>> guidance in the "Submitting a Patch" guide, but apologies if I missed
>> anything.
>>
>> Alex Bradbury (5):
>>    contrib/plugins/hotblocks: Correctly free sorted counts list
>>    contrib/plugins/hotblocks: Fix off by one error in iteration of sorted
>>      blocks
>>    contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than
>>      PRId64
>>    docs/about/emulation: Add documentation for hotblocks plugin arguments
>>    contrib/plugins/hotblocks: Allow limit to be set as a command line
>>      argument
>>
>>   contrib/plugins/hotblocks.c | 20 ++++++++++++++------
>>   docs/about/emulation.rst    | 12 ++++++++++++
>>   2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> --
>> 2.50.1
>>
>>
> 
> I think the mailing list ate up your first patch. Not your fault
> though. I did not receive it in my inbox and it's not on
> lore.kernel.org either:
> 
>> $ b4 shazam cover.1753857212.git.asb@igalia.com
>> Grabbing thread from lore.kernel.org/all/cover.1753857212.git.asb@igalia.com/t.mbox.gz
>> Checking for newer revisions
>> Grabbing search results from lore.kernel.org
>> Analyzing 5 messages in the thread
>> Looking for additional code-review trailers on lore.kernel.org
>> Analyzing 0 code-review messages
>> Checking attestation on all messages, may take a moment...
>> ---
>>    ERROR: missing [1/5]!
>>    ✗ [PATCH 2/5] contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>>      ✗ BADSIG: DKIM/igalia.com
>>    ✗ [PATCH 3/5] contrib/plugins/hotblocks: Print uint64_t with PRIu64 rather than PRId64
>>      ✗ BADSIG: DKIM/igalia.com
>>    ✗ [PATCH 4/5] docs/about/emulation: Add documentation for hotblocks plugin arguments
>>      ✗ BADSIG: DKIM/igalia.com
>>    ✗ [PATCH 5/5] contrib/plugins/hotblocks: Allow limit to be set as a command line argument
>>      ✗ BADSIG: DKIM/igalia.com
>> ---
>> Total patches: 4
>> ---
>> WARNING: Thread incomplete!
>> Applying: contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>> Patch failed at 0001 contrib/plugins/hotblocks: Fix off by one error in iteration of sorted blocks
>> error: sha1 information is lacking or useless (contrib/plugins/hotblocks.c).
>> error: could not build fake ancestor
> 
> Could you resend it?

I've been lucky to receive it, probably because I'm in direct copy as a 
plugins reviewer.
However, it would be better for the mailing list if you could resend it 
indeed Alex (you can apply the reviewed-by at the same time, so this v2 
"adds" something).

Regards,
Pierrick

