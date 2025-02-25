Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6DBC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 21:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn22l-0002Iw-JG; Tue, 25 Feb 2025 16:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn22i-0002IP-GB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:00:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn22f-0004ox-Lo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 16:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740517236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+rHHhDmhfXBr6buJiQDAJDP6cg+X9pEAX1JZtQE14Uo=;
 b=isqwDxtC2BpLK+j5UnuwMbSQtgbHYx9D7oQ52eStsTDqYcdVw1kLrdVtH91QPhFfwlXfH9
 1IHIvMy1FZ1X4nE3XEN/cAu6H/AzeeOK4rZ/4qrg1NaqrqLvvNScUcV6wlr01+o2sRzJ0/
 o9QYGXOF5hS7CoP9Y7qECI3GHfvCHJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-pWic03IZMMCW4hhyQsciNw-1; Tue, 25 Feb 2025 16:00:32 -0500
X-MC-Unique: pWic03IZMMCW4hhyQsciNw-1
X-Mimecast-MFC-AGG-ID: pWic03IZMMCW4hhyQsciNw_1740517230
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393ed818ccso44166945e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 13:00:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740517230; x=1741122030;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+rHHhDmhfXBr6buJiQDAJDP6cg+X9pEAX1JZtQE14Uo=;
 b=ggoveZGT1pfGMBAsy0B3GzTlSOryAFbplR8i10bthebZCDZGdI9KRSPj84lWe0aSPQ
 JwTRkqxgcq4+Xq+YZydP8+pzYK8yla1Cm1DEAzeJo7AhmNYSoKD82l2A8YA3qLWBe0tP
 SqZD/VYtNZHGvJeD8QlZTT4QYme8zMM0qliAScl5akoVtOVlOpkPjYoETZqOm+J0ZBQ5
 0n4VNXTmrXPZaGl4/9hYYxg7ANqvxhJEdil3BKMpBzDHGii02XKofRG2PGhk9rmMbT+1
 mVf/3fu04y7cW91FyDDErKMajBRloREtN2q3Z6vQ+THauQPKVVbfYC3N89Q6C4XRN73q
 G8Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcSpzRDMqVdWuz+7qv25T8vX8vvgK0qR9HQpWUOLOY4eXSa+eWUx8UNcPgZraO1Lo4b6C4Yc/fWPNl@nongnu.org
X-Gm-Message-State: AOJu0YxA3mjjwLDIlgGkjKeQppeWtonMDNrNk7THQLCQv42DFrYY32rf
 KkJ6G/A9CNiViZ+iLYVPH7RFPL3mHP8qwHw1WOKWllcaS8V4g0C/bHeuZr7WVMoSQFxFYYCGoWK
 k3icB+uL4DKhbtGGw2KXJFsJGnSUUgGqNl9V66MjbWmc4q0tKggL1
X-Gm-Gg: ASbGncundw6qVaNBWga312+gdJjl4Jz1suIZK+uI2wG8582Wc4sVrYge5xCTfk10KPb
 v4Q3jiTw4nBpvpdyS1l2lxvwzzxI6c93gE9pXz0YheEG71o0A1fdGScWYphuL+lz/VF6GGTk87m
 PIFiWn1puBcxa5yTEOFeZV4QP4LtARQohGxqPMC12BKJx6f5KxMPJn/NkRyLqGziXm8DKa+HsFp
 eZBtprdJusSYdYMvULTu/wIQEqT9+GSa0emQeL2Xyv/yjOhY1U/JSTG8TBbA6nWRYn5p9l8mQ4C
 eLM8ocyXwz9IMNBCu1b53OiQfstb7nau7EugkZSpjJusAqY=
X-Received: by 2002:a5d:4090:0:b0:38d:ba09:86b5 with SMTP id
 ffacd0b85a97d-390d4fa3559mr474639f8f.52.1740517229751; 
 Tue, 25 Feb 2025 13:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIDjW+Mx17uITR+hPcY/5r5jGEW0d0hOA59GsswsVSHf9wDwaxG/a2jeKK9DxDckiRrIcX4A==
X-Received: by 2002:a5d:4090:0:b0:38d:ba09:86b5 with SMTP id
 ffacd0b85a97d-390d4fa3559mr474621f8f.52.1740517229324; 
 Tue, 25 Feb 2025 13:00:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd883521sm3496842f8f.56.2025.02.25.13.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 13:00:28 -0800 (PST)
Message-ID: <7a81b491-d982-4a5b-b250-f7b772f64eb4@redhat.com>
Date: Tue, 25 Feb 2025 22:00:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with iotest 233
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
 <Z72XfP8gI9-SB4B9@redhat.com>
 <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
 <574cdf2e-6b8c-4ff3-9a2b-a7d00c92a788@redhat.com>
 <Z74En98KD0v11X8w@redhat.com>
 <84a51a63-50f7-4592-ba75-5e3234571987@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <84a51a63-50f7-4592-ba75-5e3234571987@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 25/02/2025 21.35, Thomas Huth wrote:
> On 25/02/2025 18.57, Daniel P. Berrangé wrote:
>> On Tue, Feb 25, 2025 at 06:52:43PM +0100, Thomas Huth wrote:
>>> On 25/02/2025 18.44, Thomas Huth wrote:
>>>> On 25/02/2025 11.12, Kevin Wolf wrote:
>>>>> Am 25.02.2025 um 08:20 hat Thomas Huth geschrieben:
>>>>>>
>>>>>>    Hi!
>>>>>>
>>>>>> I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When 
>>>>>> running
>>>>>>
>>>>>>    ./check -raw 233
>>>>>>
>>>>>> the test simply hangs. Looking at the log, the last message is "== check
>>>>>> plain client to TLS server fails ==". I added some debug messages, and it
>>>>>> seems like the previous NBD server is not correctly terminated here.
>>>>>> The test works fine again if I apply this patch:
>>>>>>
>>>>>> diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/ 
>>>>>> common.nbd
>>>>>> --- a/tests/qemu-iotests/common.nbd
>>>>>> +++ b/tests/qemu-iotests/common.nbd
>>>>>> @@ -35,7 +35,7 @@ nbd_server_stop()
>>>>>>            read NBD_PID < "$nbd_pid_file"
>>>>>>            rm -f "$nbd_pid_file"
>>>>>>            if [ -n "$NBD_PID" ]; then
>>>>>> -            kill "$NBD_PID"
>>>>>> +            kill -9 "$NBD_PID"
>>>>>>            fi
>>>>>>        fi
>>>>>>        rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
>>>>>>
>>>>>> ... but that does not look like the right solution to me. What could 
>>>>>> prevent
>>>>>> the qemu-nbd from correctly shutting down when it receives a normal 
>>>>>> SIGTERM
>>>>>> signal?
>>>>>
>>>>> Not sure. In theory, qemu_system_killed() should set state = TERMINATE
>>>>> and make main_loop_wait() return through the notification, which should
>>>>> then make it shut down. Maybe you can attach gdb and check what 'state'
>>>>> is when it hangs and if it's still in the main loop?
>>>>
>>>> I attached a gdb and ran "bt", and it looks like it is hanging in an
>>>> exit() handler:
>>>>
>>>> (gdb) bt
>>>> #0  0x00007f127f8fff1d in syscall () from /lib64/libc.so.6
>>>> #1  0x00007f127fd32e1d in g_cond_wait () from /lib64/libglib-2.0.so.0
>>>> #2  0x00005583df3048b2 in flush_trace_file (wait=true) at
>>>> ../../devel/qemu/ trace/simple.c:140
>>>> #3  st_flush_trace_buffer () at ../../devel/qemu/trace/simple.c:383
>>>> #4  0x00007f127f8296c1 in __run_exit_handlers () from /lib64/libc.so.6
>>>> #5  0x00007f127f82978e in exit () from /lib64/libc.so.6
>>>> #6  0x00005583df1ae9e1 in main (argc=<optimized out>, argv=<optimized
>>>> out>) at ../../devel/qemu/qemu-nbd.c:1242
>>>
>>> Ah, now that I wrote that: I recently ran "configure" with
>>> --enable-trace-backends=simple ... when I remove that from "config.status"
>>> again, then the test works fine again 8-)
>>>
>>> Still, I think it should not hang with the simple trace backend here, 
>>> should it?
>>
>> IIUC this is waiting on trace_empty_cond.
>>
>> This condition should be signalled from wait_for_trace_records_available
>> which is in turn called from writeout_thread.
>>
>> This thread is started from st_init, which is called from trace_init_backends
>> which should be called from qemu-nbd. I would expect this thread to still
>> be running when exit() handlers are run.
>>
>> Does GDB show any other threads running at the time of this hang ?
> 
> There is indeed a second thread running:
> 
> (gdb) thread apply all bt
> 
> Thread 2 (Thread 0x7f657096b6c0 (LWP 1117884) "qemu-nbd"):
> #0  0x00007f6573419f1d in syscall () from /lib64/libc.so.6
> #1  0x0000562bbad9b783 in qemu_futex_wait (f=0x562bbaed25d8 
> <rcu_call_ready_event>, val=4294967295) at ../../devel/qemu/include/qemu/ 
> futex.h:29
> #2  0x0000562bbad9b9af in qemu_event_wait (ev=0x562bbaed25d8 
> <rcu_call_ready_event>) at ../../devel/qemu/util/qemu-thread-posix.c:465
> #3  0x0000562bbada86a6 in call_rcu_thread (opaque=0x0) at ../../devel/qemu/ 
> util/rcu.c:278
> #4  0x0000562bbad9bba3 in qemu_thread_start (args=0x562bf958a5c0) at ../../ 
> devel/qemu/util/qemu-thread-posix.c:542
> #5  0x00007f6573398168 in start_thread () from /lib64/libc.so.6
> #6  0x00007f657341c14c in __clone3 () from /lib64/libc.so.6

Though, that does not look like the thread from the simpletrace, but the the 
QEMU RCU thread instead ... so no clue where that writer thread might have 
gone...

  Thomas


