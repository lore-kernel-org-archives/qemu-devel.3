Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67193C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 10:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWw2S-00032e-Eb; Mon, 05 Feb 2024 05:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWw2Q-00032F-VI
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWw2P-00038m-9N
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 05:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707128235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yr3Ze9WOLIVWm9sgj6dZ9tZE4kf9BvzD8rL1HFxThEE=;
 b=Ob/n7tpwGRwNTgODP85xUXq9r2USYKeHydIAK1wMB5IQ4jRWuPxYpdGTby2hdAAvS06H59
 NZWG7JxgqVXIv08TLUFQco5EHMsLkoTKPJx4adctNU55SW3rGVZTLgOHXUSmlrEJDR/CeD
 gJjtoxHlhBncp7jcZWWXMyaTPmEr5Ww=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-KwevxVfaNEikMN1LvHulXw-1; Mon, 05 Feb 2024 05:17:14 -0500
X-MC-Unique: KwevxVfaNEikMN1LvHulXw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7855f31ecb2so387827685a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 02:17:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707128233; x=1707733033;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yr3Ze9WOLIVWm9sgj6dZ9tZE4kf9BvzD8rL1HFxThEE=;
 b=WN4fAsFaVbKd0CCNLSahAhgEh30u78lQ581ScX37talnueBL6v/FUOxpaW4x3N1cMZ
 /KjyB2Q3GFtYdezJWvZhzlhEdY88PAvD2vrdApnZ34actHzjQ/7j5pkP9xP3VA52FqFW
 Ghe2EqLe7hWKCcwyJEmXfWQyXai5Mtd/IpvGUy2Xx+1mSU/O1bdjv+AznvDXXGdGHPqY
 u0G7pgexVDGuGmeChdDXqcd4DOGnoI7qakIwfAZ9vFpzY/91VUPswRILvmMi7CvhG5dB
 Yu4kIN0986u4Wp2kiAr1/7QjZtIAK0ndalhYn8SWAc+OuC+UrNpLDuv1P6Rm7d1m/PiG
 X6NA==
X-Gm-Message-State: AOJu0YxrNPlg96f3teMZ8lO/xirIty+T4tx07iN43sbYR+HOMIxaAOG0
 GM9GIQgk4hu5dqLC8JDI9oo71UltqhMlgkTK9xRPQBnWyMFmL8tbL7PrMG8YwO/XcEb+Tey/Z5u
 LpbB9WaXjRpB6DceLYDmpHtNBAkPsUOUQdi7DlXT0zYehZORqXTyb
X-Received: by 2002:ae9:c013:0:b0:785:3e6e:77e5 with SMTP id
 u19-20020ae9c013000000b007853e6e77e5mr7790829qkk.30.1707128233625; 
 Mon, 05 Feb 2024 02:17:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWHQTpjUmna1vqN9uVrkvICZ1VHGQUXUHMDpW3/xeBtw/cv4PMyiqyYndtlR99hWscNhU45Q==
X-Received: by 2002:ae9:c013:0:b0:785:3e6e:77e5 with SMTP id
 u19-20020ae9c013000000b007853e6e77e5mr7790817qkk.30.1707128233387; 
 Mon, 05 Feb 2024 02:17:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW78VD+GhWkSYA4M/dgrFzxLGHWTi/lt2+ZHIyCeEjgP5Ye8KoWdTlAZ3n6EQItsT6/94VHYe3xyuE5DI9OICE=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05620a110c00b0078366823711sm2843567qkk.119.2024.02.05.02.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 02:17:13 -0800 (PST)
Message-ID: <d42fe4a4-e5bb-4bff-9bd0-7d4d1294177b@redhat.com>
Date: Mon, 5 Feb 2024 11:17:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration: Fix return-path thread exit
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-3-clg@redhat.com> <8734ubhqr9.fsf@suse.de>
 <d2d0314a-494f-4ace-ba73-e14019fb4fd3@redhat.com> <87zfwihpf6.fsf@suse.de>
 <ZcBYBexsJ7X2yeZm@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZcBYBexsJ7X2yeZm@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/5/24 04:37, Peter Xu wrote:
> On Fri, Feb 02, 2024 at 12:11:09PM -0300, Fabiano Rosas wrote:
>> Cédric Le Goater <clg@redhat.com> writes:
>>
>>> On 2/2/24 15:42, Fabiano Rosas wrote:
>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> In case of error, close_return_path_on_source() can perform a shutdown
>>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>>>> and the shutdown fails, leaving the source and destination waiting for
>>>>> an event to occur.
>>>>
>>>> At close_return_path_on_source, qemu_file_shutdown() and checking
>>>> ms->to_dst_file are done under the qemu_file_lock, so how could
>>>> migrate_fd_cleanup() have cleared the pointer but the ms->to_dst_file
>>>> check have passed?
>>>
>>> This is not a locking issue, it's much simpler. migrate_fd_cleanup()
>>> clears the ms->to_dst_file pointer and closes the QEMUFile and then
>>> calls close_return_path_on_source() which then tries to use resources
>>> which are not available anymore.
>>
>> I'm missing something here. Which resources? I assume you're talking
>> about this:
>>
>>      WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>          if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>>              qemu_file_get_error(ms->to_dst_file)) {
>>              qemu_file_shutdown(ms->rp_state.from_dst_file);
>>          }
>>      }
>>
>> How do we get past the 'if (ms->to_dst_file)'?
> 
> We don't; migrate_fd_cleanup() will release ms->to_dst_file, then call
> close_return_path_on_source(), found that to_dst_file==NULL and then skip
> the shutdown().
> 
> One other option might be that we do close_return_path_on_source() before
> the chunk of releasing to_dst_file.
> 
> This "two qemufiles share the same ioc" issue had bitten us before IIRC,
> and the only concern of that workaround is we keep postponing resolution of
> the real issue, then we keep getting bitten by it..
> 
> Maybe we can wait a few days to see if Dan can join the conversation and if
> we can reach a consensus on a complete solution.  Otherwise I think we can
> still work this around, but maybe that'll require a comment block
> explaining the bits after such movement.

yes. The series should have been sent with an RFC.

I changed PATCH 1 to use migrate_has_error() instead of
qemu_file_get_error(ms->to_dst_file). I will keep PATCH 2 as it is for
the time being and wait for more feedback.

The prereq series adds an Error** argument to the .save_setup() and
.log_global*() handlers. I should send this week.

Thanks,

C.





> 
> Thanks,
> 


