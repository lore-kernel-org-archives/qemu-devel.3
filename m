Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ABAC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmyzL-0008I9-DE; Tue, 25 Feb 2025 12:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmyzJ-0008Hl-U9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmyzH-0007hB-Tf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740505494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pUA6dcoWA6DWF24Hx3F4ZGrifyYO46bbd5FnWEURH3U=;
 b=hT8ejJe68yNGYqX8KHCUrckE4KQ6eBn9mu+bmffEFAevaTI5Xb8Nqw91LMFMqOmhOQfBIu
 qW23cx9LD7wI4/Aup42FHdmmPaiOXhYMEE7HfIkkKSUO77DwgU4GFccyCn1jkvsxUjchGx
 LaF/BzLeU+bduPy/zMenoLb6OPheBEk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-W27nSInuPZKXNIFF4CyI5A-1; Tue, 25 Feb 2025 12:44:51 -0500
X-MC-Unique: W27nSInuPZKXNIFF4CyI5A-1
X-Mimecast-MFC-AGG-ID: W27nSInuPZKXNIFF4CyI5A_1740505490
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f2726c0faso6211215f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 09:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740505490; x=1741110290;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pUA6dcoWA6DWF24Hx3F4ZGrifyYO46bbd5FnWEURH3U=;
 b=jFWOYOOc3WsiNFPnfhKTWQtRG4XskjlVNq3oGm53sNZNsjuCoHTyzQ42xUeHs7G+nU
 uIeKAgcvU4EadhqnasiIiTnVv/Ev9OtzacDoEp+YvhNS51c1RjuBjN5FqWl9dfdVu3sp
 BGHwDwM/X5ngB6JV45rf1dKYn1+rRcRfZ9H6MZhWGB3WxIkLRiY0ahU7LvK1kG2uaU+e
 Df6jDytMpBvQTkx1sbdT/T3D1JdNQvqkEl1R7C3QtL1UHRpq1iZCFfRVq89TyXVJ9z82
 xEx8YpNucjrnLGXBuPskfc0mdcBYeV3FAB8O0Cua+JaxXT1VstioIi+ObRXCvAh9HVHG
 6uYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4RT5quwkL30uE2CxfQCdXKq+wwuiVS95VlzCd2uf7eWXf6WtPxkYUEosQfA2nXQVwu6LgaYRj/Bmm@nongnu.org
X-Gm-Message-State: AOJu0Yya+GA9At9iX1Qh3eiWQWXdA874wpb8eb6GaiX5hbEMfZzRn+Pw
 SgFz7PJsvFFPp8nM4QU7MgpOPF/exV5wxl6lrmLiMdY8/gvbWuXsR1UBBU1pB8+I4KVySFo4fQC
 zkT0f5iwaT30LZjCqZ9RHXd8kDu+CpLRT6g0G23ResK+0a6eg+uFO
X-Gm-Gg: ASbGnctNHkXLXReb8bWJRYCfTmv4RjHivnv1er/hPX2Xrsuttbhz0N5ArfvPY9+gj4U
 RbCFrAoV6N+ZoU7xqQ5iDkFlMJauqeSe0TRpAggKeyE3EEIz7qORx4s7mh73HdWoR3eFBUy2Evm
 eluWU3SI5h2Dg1Jxy68WtKX3UXd7dzVQ1z5FWx+fCJLUOrnt4BqJ8ExnhaYwB0Jet4J/NmtRR4r
 rVVQIKckgx5yymrHJ5zAzjUPMQV+nfdPeUB0qEOl+pFRHNuksDpimzME3JPlqol9wfDy92ATloe
 RqOsgPcY9AkCmV6bNDkNMt1B0f7bpbQcYXN8siBH4WetBhc=
X-Received: by 2002:a05:6000:dcf:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-390cc63c045mr3831490f8f.48.1740505490593; 
 Tue, 25 Feb 2025 09:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI3hqvSsunJwEL0cEYgBcVZHnmXQmHnn5aCm7sqXc6o4Sb0EPSHjH1xXCM+FG73AL038EomA==
X-Received: by 2002:a05:6000:dcf:b0:38d:c44a:a64b with SMTP id
 ffacd0b85a97d-390cc63c045mr3831473f8f.48.1740505490210; 
 Tue, 25 Feb 2025 09:44:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02e486csm146874595e9.18.2025.02.25.09.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 09:44:49 -0800 (PST)
Message-ID: <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
Date: Tue, 25 Feb 2025 18:44:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with iotest 233
To: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
 <Z72XfP8gI9-SB4B9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z72XfP8gI9-SB4B9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/02/2025 11.12, Kevin Wolf wrote:
> Am 25.02.2025 um 08:20 hat Thomas Huth geschrieben:
>>
>>   Hi!
>>
>> I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When running
>>
>>   ./check -raw 233
>>
>> the test simply hangs. Looking at the log, the last message is "== check
>> plain client to TLS server fails ==". I added some debug messages, and it
>> seems like the previous NBD server is not correctly terminated here.
>> The test works fine again if I apply this patch:
>>
>> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
>> --- a/tests/qemu-iotests/common.nbd
>> +++ b/tests/qemu-iotests/common.nbd
>> @@ -35,7 +35,7 @@ nbd_server_stop()
>>           read NBD_PID < "$nbd_pid_file"
>>           rm -f "$nbd_pid_file"
>>           if [ -n "$NBD_PID" ]; then
>> -            kill "$NBD_PID"
>> +            kill -9 "$NBD_PID"
>>           fi
>>       fi
>>       rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
>>
>> ... but that does not look like the right solution to me. What could prevent
>> the qemu-nbd from correctly shutting down when it receives a normal SIGTERM
>> signal?
> 
> Not sure. In theory, qemu_system_killed() should set state = TERMINATE
> and make main_loop_wait() return through the notification, which should
> then make it shut down. Maybe you can attach gdb and check what 'state'
> is when it hangs and if it's still in the main loop?

I attached a gdb and ran "bt", and it looks like it is hanging in an exit() 
handler:

(gdb) bt
#0  0x00007f127f8fff1d in syscall () from /lib64/libc.so.6
#1  0x00007f127fd32e1d in g_cond_wait () from /lib64/libglib-2.0.so.0
#2  0x00005583df3048b2 in flush_trace_file (wait=true) at 
../../devel/qemu/trace/simple.c:140
#3  st_flush_trace_buffer () at ../../devel/qemu/trace/simple.c:383
#4  0x00007f127f8296c1 in __run_exit_handlers () from /lib64/libc.so.6
#5  0x00007f127f82978e in exit () from /lib64/libc.so.6
#6  0x00005583df1ae9e1 in main (argc=<optimized out>, argv=<optimized out>) 
at ../../devel/qemu/qemu-nbd.c:1242

  Thomas


