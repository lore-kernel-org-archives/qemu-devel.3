Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A4DC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 21:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdGAc-0007LP-0B; Thu, 22 Feb 2024 15:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdGAU-00077Q-1a
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdGAR-0005Qu-PI
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708635582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AUX/BdzGIpFBFaOLj98NOKT7A46p6pU8MqvlKqdtnrw=;
 b=eiFQ3O6S0noLLnQFH5scfpmuYR/B+N+P1VDYYW0Wd4xfGNTVdi9RiKFsAyrN926mlPRRP3
 FZS6LjIIH0Hn/RedKiz4gyIFDYK7180WAJ1H6XJsiGLVcf6J8SfaK5sS19ELJHNRmT8rgy
 jUXn4TQWQjy7Xub+7Q+HsgEjz2z72gM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-SisKMlfpNqqinU76alatIg-1; Thu, 22 Feb 2024 15:59:40 -0500
X-MC-Unique: SisKMlfpNqqinU76alatIg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a3f52ebbb6cso7330566b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708635578; x=1709240378;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AUX/BdzGIpFBFaOLj98NOKT7A46p6pU8MqvlKqdtnrw=;
 b=pQCTovrVp34s5uT07kKSnOFoLe919ZJ0erFXbcPPzzlBCRCOBZbSRYtlXaUULyc6X8
 3ytrgN6MKJHLssIF0LM43Jjkv3GO0u3W89mmoeWrzgQ3IdMQHwIUD6wUhEmuk6WzZsTE
 la6dfRoJUybajgb6eHJiiWWDd38Vfu6ySUMLlsnJrCjuyZwU2kmkRjRVgf8m+CApj2+k
 jqiW3L/hTVlKLVzj3/sOdNKt3fGchW6Lz8VHLaiB842m4zRm1rn54iQwSmsh65wX7B3u
 4RUweq1XVsxZL9TlGtT/D1gyx4GY/ijyox9mwnhABw9uJKPealQpJsuDQT/SQE/ozuem
 qpuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfsASVyeTJnGlv2eATRhG2+fmYPqQfALr9RUPF2cC1APiqG8l1ZTHFQUMhELoWI728TAh+1jig3UYwy4CGiaoodd/UsUM=
X-Gm-Message-State: AOJu0Yyq5X/0DxiJdhbklopM4+eqPLfAEaiuD9Cppc8GgKJ4IJFOETPA
 asYxt8pU/B9U83332tMsjqOcmzmMoeSSNxBegHKzA2XA7W6tehz3BMpnuj970E2LnUuVgrMknMY
 6t737QqF83Gy0mcYhN+08SvBnv7Outc7aIpi8He26Hw8ERtTfVInf
X-Received: by 2002:a17:906:b80c:b0:a3f:5628:e364 with SMTP id
 dv12-20020a170906b80c00b00a3f5628e364mr8594ejb.24.1708635578730; 
 Thu, 22 Feb 2024 12:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAKrfekgPfffIweaD2jjYa/bHYUpsfCEI7SKFNXLPt+FwpNeFBrIjSD6/OaYZsKaqwBn36zA==
X-Received: by 2002:a17:906:b80c:b0:a3f:5628:e364 with SMTP id
 dv12-20020a170906b80c00b00a3f5628e364mr8580ejb.24.1708635578409; 
 Thu, 22 Feb 2024 12:59:38 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-100.web.vodafone.de.
 [109.43.178.100]) by smtp.gmail.com with ESMTPSA id
 m8-20020a1709060d8800b00a3eeb10acb4sm3093142eji.185.2024.02.22.12.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 12:59:37 -0800 (PST)
Message-ID: <f9fe86e0-e562-45d5-a4cc-aa0052ef5368@redhat.com>
Date: Thu, 22 Feb 2024 21:59:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix migration dirty bitmap coherency with
 TCG memory access
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
References: <20240219061731.232570-1-npiggin@gmail.com>
 <c15b1b35-c613-4811-b76f-faed6c7ac942@redhat.com>
 <CZ9I9VE1A542.30BIYSXFQT963@wheely>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CZ9I9VE1A542.30BIYSXFQT963@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/02/2024 02.13, Nicholas Piggin wrote:
> On Tue Feb 20, 2024 at 12:10 AM AEST, Thomas Huth wrote:
>> On 19/02/2024 07.17, Nicholas Piggin wrote:
>>> The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
>>> aligned ranges forgot to bring the TCG TLB up to date after clearing
>>> some of the dirty memory bitmap bits. This can result in stores though
>>> the TCG TLB not setting the dirty memory bitmap and ultimately causes
>>> memory corruption / lost updates during migration from a TCG host.
>>>
>>> Fix this by exporting an abstracted function to call when dirty bits
>>> have been cleared.
>>>
>>> Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>
>> Sounds promising! ... but it doesn't seem to fix the migration-test qtest
>> with s390x when it gets enabled again:
> 
> Did it fix kvm-unit-tests for you?

It does, indeed! With your QEMU patch here, your new selftest-migration test 
of the k-u-t is working reliably with TCG now, indeed. Thus feel free to add:

Tested-by: Thomas Huth <thuth@redhat.com>

>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -3385,15 +3385,6 @@ int main(int argc, char **argv)
>>            return g_test_run();
>>        }
>>
>> -    /*
>> -     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
>> -     * there until the problems are resolved
>> -     */
>> -    if (g_str_equal(arch, "s390x") && !has_kvm) {
>> -        g_test_message("Skipping test: s390x host with KVM is required");
>> -        return g_test_run();
>> -    }
>> -
>>        tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
>>        if (!tmpfs) {
>>            g_test_message("Can't create temporary directory in %s: %s",
>>
>> I wonder whether there is more stuff like this necessary somewhere?
> 
> Possibly. That's what the commit logs for the TCG disable indicate. I
> have found another dirty bitmap TCG race too. I'll send it out after
> some more testing.
> 
>> Did you try to re-enable tests/qtest/migration-test.c for ppc64 with TCG to
>> see whether that works fine now?
> 
> Hmm, I did try and so far ppc64 is not failing even with upstream QEMU.

Oh, indeed! Actually, now that you mentioned it, I remembered that I checked 
it a couple of weeks ago already:

https://lore.kernel.org/qemu-devel/7d4f5624-83d2-4330-9315-b23869529e99@redhat.com/

> I'll try with s390x. Any additional build or runtime options to make it
> break? How long does it take for breakage to be evident?

For me, it normally breaks after running the migration test a couple of few 
times already, let's say one time out of ten runs?

  Thomas


