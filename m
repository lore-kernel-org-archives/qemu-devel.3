Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C36606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KH3drO9R;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ixNRuwCd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWzLo-0007EF-2k; Fri, 27 Nov 2026 12:03:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWzJr-0006OK-H8
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:01:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1xWzJn-0002my-P5
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 12:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795798859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U22JztbKCyhSusFsIPF0C3mGRCT4TgGdFAMDFdDZHA=;
 b=KH3drO9R+5aes/1jSwH/nB3U4yUgf4x8TjPxnZ+08HNUBRvno3b/IRtnE1eVCcMtvqmo3q
 jZFyW0m3Jp9+W0g4Qb4mTNrvyao90fetlMRhxAUXUeJLWC3cX1LC/CxsLV4JMe/44I9+lS
 C5qLCwmuEPruExLLzpSQHFViQpMERR0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-j7I_uuhxO42ECtGSKVckrw-1; Fri, 27 Nov 2026 17:00:57 +0000
X-MC-Unique: j7I_uuhxO42ECtGSKVckrw-1
X-Mimecast-MFC-AGG-ID: j7I_uuhxO42ECtGSKVckrw_1795798856
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a359c7f47bso68402855e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 09:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795798856; x=1796403656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4U22JztbKCyhSusFsIPF0C3mGRCT4TgGdFAMDFdDZHA=;
 b=ixNRuwCd5VnF8xbqwA+yj0/8fnVpJKVEq9IKk28yI3pZ1zyX6F2URjgOj4JtZz/TvW
 xcPK1pFsaMVDQxznV0dIPuhsp5RA9OmxVHAWu6uzmh3fQKqg1Ucbjq0OFJLgHyPaIzCQ
 p12XnjBP1LoN6VQ0BFKJf4j3xlR//gn1VlGScfn+FteYbJHMWwgO3zKYqFlI+zea9vqz
 zgzloZThRk6pHGrdlH85OLYP6+isI7twcIdA3pX7BcQho/Ww3LDj1X8aLJfihz3EQOyd
 upLduqdx5jqb14a/Vay/YplkO6IsiH2qKNOoLaQyG53ZRtlC4q9y5DlmqnRVgbqKuZ7m
 ewVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795798856; x=1796403656;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4U22JztbKCyhSusFsIPF0C3mGRCT4TgGdFAMDFdDZHA=;
 b=GhslnqT7R11wVU1m39zLDkHccY7ZOuBwOh8NgbKwwGQgoqOc5j//2yHqadk9luwyl/
 5ouPLHbAvNttsB9e5KeGA/T0HdzuH4dpm9YwbMmFyxbrhY58dGVx2b2p3CgeXHkNfH4X
 sG54hfMuar3KtflloOvv46yD0Y6N1MI7dE71IZ7nyZFgmUqR4xPqp5pg6hwZsXGtXRzT
 mO2x8B3nYQ51haCpbRGv9XBLVdZ2VBD46VGKoT8D/jDu5J5MqYNizJOvtxAwB/fHJhkf
 DcfF6qyBRgvLt3rgdgYQN+SFQDQq6QdvB+hmKJa/Kf10Vvw0OcmUArvVDYEoJNgu06VA
 wujQ==
X-Forwarded-Encrypted: i=1;
 AL+hErErueQ7eMj4RY2gBBliblgLnEv5kWn45VHL0JgRt++twi3iMnjyOUKuu0ohaJlc3iiWlkRZr77IX5Gt@nongnu.org
X-Gm-Message-State: APuU4Z+QJLxqeVCmgtlMBCK5BrstHqsqBtHJT/5SePDEiNHWgQkc5LHA
 k86ZM80MSu3jdRiI72Y4KiNKUjFluhinTwsSl99CpQJ7pdYrcjlmOrHVDOWY5RHDDveloJ6G0pB
 qgHdTP/TQYdIR5oBjDidsYaidYoZAPcpw/WYv1kiwM8r6X+NorK642El+
X-Gm-Gg: AZFdTZegwgkLtOQrFHVI6MNK9jW45BPoi89CMbsVXc+uVedi1IJj+LVxJoErLbAMmQU
 Yc2iAEsGy11/0BZLiki2/PEloqaYB26nvf5njZ4z8NCm1EkVk9DUvE8Z1sZgHknsL4kJw77yndr
 QaffF2933GSnxluR+RGocXtXwXPlzvLAr/IW9QEUJ/CKUxkxJFTEXGxKg9RBq31hxpKbLyYx6Hh
 JA2Qb7PGvwSFMwISZlgr1C9kqexsChuyvNs5sv6kHvDjQlG4heWX7o4CGeLQICqLSFYDCq1hXkr
 H6zVfqJ9j57G4Aje9mqFXbkzGQwmHJ641uy7TvlRMEy5H8q98aAWF0DDXkK7B0Ug04mm43Yvi5I
 TSdcX2/gEOZjnwnt0PKuddFVzRrd9I+dIuE2fZs7t6i/5552c9DsNy1anfyuzHuMQwRcvUDvUXU
 dwmuKwfPwOfKhhUSlY
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb88817d91mr536744485e9.23.1795798856102; 
 Fri, 27 Nov 2026 09:00:56 -0800 (PST)
X-Received: by 2002:a05:600c:45d4:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb88817d91mr536743905e9.23.1795798855650; 
 Fri, 27 Nov 2026 09:00:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:af16:8320:54ea:4bc9?
 ([2a01:e0a:f0e:9070:af16:8320:54ea:4bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bbab390cf5sm224892895e9.7.2026.11.27.09.00.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 09:00:55 -0800 (PST)
Message-ID: <64a1ab9c-e43e-43ba-970c-a9f201d82fc3@redhat.com>
Date: Fri, 27 Nov 2026 18:00:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-12.0 v2 7/9] arm/machine: Convert cpu_post_load() to
 take Error**
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Gavin Shan <gshan@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-8-peterx@redhat.com> <87se0mquhh.fsf@suse.de>
 <awmR_TMQd9c8gxhd@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-d2Das=U+da6W2j2RPR48zf4yxO2k8-SCdwDPMvF_C4w@mail.gmail.com>
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <CAFEAcA-d2Das=U+da6W2j2RPR48zf4yxO2k8-SCdwDPMvF_C4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi!

On 11/27/26 3:44 PM, Peter Maydell wrote:
> On Fri, 27 Nov 2026 at 14:23, Peter Xu <peterx@redhat.com> wrote:
>>
>> On Fri, Nov 27, 2026 at 10:22:50AM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> Convert it to post_load_errp() version, so as to be able to report verbose
>>>> errors when hit.
>>>>
>>>> A few things to mention:
>>>>
>>>> - The old "fail" count won't work with Error**, switch to fail and return
>>>>   immediately, assuming we should stop migration immediately hitting the
>>>>   1st error.
>>>>
>>>
>>> You could keep the handle_cpreg* untouched and just create a new generic
>>> Error when fail > 0 like you did for !kvm_arm_cpu_post_load() and
>>> !write_list_to_cpustate(), no? That way we don't lose the reporting of
>>> the other bugged registers.
>>
>> I can, but I thought it was good cleaning up those error_report()s.  I'll
>> see if PeterM has any preference on that.
> 
> This is largely Eric's code (cc'd).

Thanks Peter for looping me in.

Yeah. About the history,  "the fail =" pattern  was pre-existing and I kept it in 
dbfed8d80837 ("target/arm/machine: Fix detection of unknown incoming cpregs")

Then as Fabiano reported I intended to collect all failures and not stop on the first one. It would be nice to keep that I think because it helps in the failure diagnosis. 

Thanks

Eric

> 
> -- PMM


