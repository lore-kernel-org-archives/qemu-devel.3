Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D5AC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOig-0004Ug-Lj; Fri, 07 Feb 2025 08:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tgOic-0004U0-Hs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:48:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tgOiZ-0007ty-4L
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738936105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oocHq1tE0J56Z1msQqpJpwEdwC4XO8/Z1+ZEBp+1m44=;
 b=Ws+lvO00nI+cN/D2/737xzKcUD0ToG8fQdoTXCNDrxL0IER1Qnpm3HD+MsDfbgH2RxUHKU
 /g/mO7Dhqpva5xVyQC85EwsYFEAf+VKHcVtUDdfBdrboTFQ0YpwB33VGQ3rvAZgpqjAOqc
 TA9vN7EnrNxgx3cGMvmiryRAYIn+sm0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-8DnL_8SJOi2pl2_PBeVIJQ-1; Fri, 07 Feb 2025 08:48:22 -0500
X-MC-Unique: 8DnL_8SJOi2pl2_PBeVIJQ-1
X-Mimecast-MFC-AGG-ID: 8DnL_8SJOi2pl2_PBeVIJQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so12869975e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738936101; x=1739540901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oocHq1tE0J56Z1msQqpJpwEdwC4XO8/Z1+ZEBp+1m44=;
 b=QoWP39ZXr4YyjnxSY3XJgIwGQbKOqV6h7ISldKLX+4eUemttqdnueT6LsLqd1AojbT
 3tRT7PnkvvFlKi5xRUFTHlF5hjaHUfbJI8PevZtoOuyoeSMP/Vzx6NJ5iL3LgL+9VZvm
 /FQtndc3XL5p1zaQNrnVM5K8xfoniPzX/73Dbc8xQVE7B/jzAIROWw4WQ4E0BkJKDrZA
 8PV1bwSuegRTLjsoyHjUJHMqMj4jsJYdQKWdyK8Gc91g3sSw2MYsXEt1Pw4efSvv862W
 Sq/x1p0FDdh+Nc0Lm4yUEGmSaas8BXTc1l76p9CQMTEVlp2fQsHgQYaVsuCBIuJxybty
 g+XA==
X-Gm-Message-State: AOJu0YwcAwAwB2NmNp2VN4C/I7MEaMlywfGmDL8dbhZbmVA2eVT52Hnz
 Req42qE3nnhhDkrbIbRM+3z+THxFAcBxTpGlt4fOO49SjXEL5+TzCEHRlqvTcVNiWkA09PyKpbE
 4EA29MNDYvIbbxTr013Uxuhszs4p4l+HugD8Py3Nz3LTlft65qNZo
X-Gm-Gg: ASbGncssyAqZT8IkDPX7GFrnDuxR9u2GxPnfCyoKZ63DsDj3pWN9cEbuaGpcG777qkw
 Ns+R5VK7SDzuVuLJopixpDb/+5M31eMbP6lyRQ+IHMdZkieR0q68bQql9N7Yq2dtZcyB2NhNip5
 3VPcJXzIOLLPZb9ZRRh/KezQBvF/c+5Z4bthZz3iL1wqnE9pFl5X4t2PYDQfzPzP5FPtfD2B07s
 eZB5kf4ztj5iuMRZBfPJA0CBprpC4Ahx60DLINikWo8w77l0XbiwxsJq1TeTeKgxagKoHm/NiAW
 hHiSiNbx3MEZ6X2qcgfXFS6/fwXDtw1qa4ZRWOxcCtoD+6C1+GZkOuIFlRUoGoiZgaqPCuu9Xsy
 3Hxkf4+3+aE/tmlJYwN1IsPp4DLdWP+s9xA==
X-Received: by 2002:a05:600c:a45:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-439249913a5mr31390635e9.15.1738936100943; 
 Fri, 07 Feb 2025 05:48:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJvxNkuaO/bd8Xm6z7ZexWgm5qQX4iRxNntYdl99g/Musovi08+5k5In8E3W8HxV1v/oX3qw==
X-Received: by 2002:a05:600c:a45:b0:434:a923:9310 with SMTP id
 5b1f17b1804b1-439249913a5mr31390345e9.15.1738936100510; 
 Fri, 07 Feb 2025 05:48:20 -0800 (PST)
Received: from ?IPV6:2003:cf:d712:44fb:19ca:1c3d:6b27:934a?
 (p200300cfd71244fb19ca1c3d6b27934a.dip0.t-ipconnect.de.
 [2003:cf:d712:44fb:19ca:1c3d:6b27:934a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd36967sm4620439f8f.37.2025.02.07.05.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 05:48:19 -0800 (PST)
Message-ID: <0a85b381-35c4-424f-9052-7b321b1afe02@redhat.com>
Date: Fri, 7 Feb 2025 14:48:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, Akihiko Odaki
 <akihiko.odaki@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Bibo Mao <maobibo@loongson.cn>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 German Maglione <gmaglione@redhat.com>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <f3639df5-05cf-4aef-adfc-8a39ed7767ce@redhat.com>
 <CAJSP0QUOzyqE16HL+QfXqQA3oZQ=4b=nt4_8JkoSSx5U_b7MsQ@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QUOzyqE16HL+QfXqQA3oZQ=4b=nt4_8JkoSSx5U_b7MsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07.02.25 14:41, Stefan Hajnoczi wrote:
> On Fri, Feb 7, 2025 at 7:35 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 28.01.25 17:16, Stefan Hajnoczi wrote:
>>> Dear QEMU and KVM communities,
>>> QEMU will apply for the Google Summer of Code internship
>>> program again this year. Regular contributors can submit project
>>> ideas that they'd like to mentor by replying to this email by
>>> February 7th.
>>>
>>> About Google Summer of Code
>>> -----------------------------------------
>>> GSoC (https://summerofcode.withgoogle.com/) offers paid open
>>> source remote work internships to eligible people wishing to participate
>>> in open source development. QEMU has been doing internship for
>>> many years. Our mentors have enjoyed helping talented interns make
>>> their first open source contributions and some former interns continue
>>> to participate today.
>>>
>>> Who can mentor
>>> ----------------------
>>> Regular contributors to QEMU and KVM can participate as mentors.
>>> Mentorship involves about 5 hours of time commitment per week to
>>> communicate with the intern, review their patches, etc. Time is also
>>> required during the intern selection phase to communicate with
>>> applicants. Being a mentor is an opportunity to help someone get
>>> started in open source development, will give you experience with
>>> managing a project in a low-stakes environment, and a chance to
>>> explore interesting technical ideas that you may not have time to
>>> develop yourself.
>>>
>>> How to propose your idea
>>> ------------------------------
>>> Reply to this email with the following project idea template filled in:
>>>
>>> === TITLE ===
>>>
>>> '''Summary:''' Short description of the project
>>>
>>> Detailed description of the project that explains the general idea,
>>> including a list of high-level tasks that will be completed by the
>>> project, and provides enough background for someone unfamiliar with
>>> the code base to research the idea. Typically 2 or 3 paragraphs.
>>>
>>> '''Links:'''
>>> * Links to mailing lists threads, git repos, or web sites
>>>
>>> '''Details:'''
>>> * Skill level: beginner or intermediate or advanced
>>> * Language: C/Python/Rust/etc
>> === Asynchronous request handling for virtiofsd ===
>>
>> '''Summary:''' Make virtiofsd’s request handling asynchronous, allowing
>> single-threaded parallel request processing.
>>
>> virtiofsd is a virtio-fs device implementation, i.e. grants VM guests
>> access to host directories. In its current state, it processes guest
>> requests one by one, which means operations of long duration will block
>> processing of others that could be processed more quickly.
>>
>> With asynchronous request processing, longer-lasting operations could
>> continue in the background while other requests with lower latency are
>> fetched and processed in parallel. This should improve performance
>> especially for mixed workloads, i.e. one guest process executing
>> longer-lasting filesystem operations, while another runs random small
>> read requests on a single file.
>>
>> Your task is to:
>> * Get familiar with a Linux AIO interface, preferably io_uring
>> * Have virtiofsd make use of that interface for its operations
>> * Make the virtiofsd request loop process requests asynchronously, so
>> requests can be fetched and processed while others are continuing in the
>> background
>> * Evaluate the resulting performance with different workloads
>>
>> '''Links:'''
>> * virtiofsd repository: https://gitlab.com/virtio-fs/virtiofsd
>> * virtiofsd’s filesystem operations:
>> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/passthrough/mod.rs#L1490
>> * virtiofsd’s request processing loop:
>> https://gitlab.com/virtio-fs/virtiofsd/-/blob/main/src/vhost_user.rs#L244
>>
>> '''Details:'''
>> * Skill level: intermediate
>> * Language: Rust
>> * Mentors: Hanna Czenczek (hreitz@redhat.com), German Maglione
>> (gmaglione@redhat.com)
> Thanks, I have added your project idea to the list:
> https://wiki.qemu.org/Google_Summer_of_Code_2025#Asynchronous_request_handling_for_virtiofsd

Thanks!

> Do you want to give any guidance on which crate to use for
> asynchronous I/O? Do you want async Rust (e.g. tokio) or not?

That would depend entirely on the student.  I’m open for async Rust 
(tokio or even homegrown), but they could also decide they’d rather do 
it in some different manner (e.g. with callbacks that would return 
descriptors to the guest).  I’ll add that info, if that’s OK.

Hanna


