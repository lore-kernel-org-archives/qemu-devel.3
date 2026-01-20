Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E01AD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAS1-00050l-0f; Tue, 20 Jan 2026 07:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viARw-0004yW-1i
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:03:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viARu-0004I0-BS
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768910584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vHAz0BJbdAQaWn3tqm5U93G4LyMZwJO1Eh6wuzVHc+s=;
 b=NBMT0aTslsLWmR1jS4t8SMkhFK+0m9YJ6D79BJRso1n2RZxofsUmu6EweY5u8C6MTpoDXa
 STluDPXiA4wPXT5aOvSwiqsh1KFDtVG7FCz0me5Xo1UoDodcJjDAEab4G4TM7iAIiLXKXl
 Kz3O3G0zD/i+VsjfH9cbiOflM9PWCAo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-MGAvz1OQNhOZXdn3vu6xXA-1; Tue, 20 Jan 2026 07:03:02 -0500
X-MC-Unique: MGAvz1OQNhOZXdn3vu6xXA-1
X-Mimecast-MFC-AGG-ID: MGAvz1OQNhOZXdn3vu6xXA_1768910582
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b7cea4b3f15so697814066b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768910581; x=1769515381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vHAz0BJbdAQaWn3tqm5U93G4LyMZwJO1Eh6wuzVHc+s=;
 b=Xyt0k9e9FmAzgSZEqE/TJRsCeP9ihoXafDy2XJNm3afxCMHaPiSCgkWWE9A+Ej7fDm
 SJo3oKuXLOXwT03T037vO7xfoTpH4grFyg2ha2kh+WuhNWKcXdlVxypZ2No+qaPf69uv
 +OQZUKYqN/FjdTZEd4L+7mlqmDMvDLaTh8+TXSlyjiXuHxnQ0SX30aQVWzpyGSp8m4kv
 XkhFPBd78NIOjsxXPyzFeoXLsvdNSz6vkegSzSZQY92LShrwB0msX775bOqF8bpzdcL2
 Fb93MGsifqZu3nnygjqNRMvilTUJRmo7/CcW2mmMcAzlMnv4cQHKGOGjsj/y4pk9YdEp
 b9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768910581; x=1769515381;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHAz0BJbdAQaWn3tqm5U93G4LyMZwJO1Eh6wuzVHc+s=;
 b=XK2ClixAzfDBFBDx5XAkfzgQm+gY+khvCWy5EgJ04NTv4PnCWOow9gP23ge0Xaz7oD
 l0qBo6ORkO8cP3VXo20VJNo888zzDIsUNqrBQ98qpeyN+Wzz3QxLEDgAqy1jqsurGwHr
 toBJbsttPFfo5nwZaNP6JzS0G5UwISGefkqOuWBd0vjxOgYXsG1gfsHogdu5Q69R/P/a
 wxZEYOnYpZ8wXGthMct9eJw4+KUFflwF+QDwe/4DSTTgSm0Rusux2feKj1GVzwhjfN2E
 6qY7gLYSXfkDRUZs+DplqBCOR5TsWWVvL/aa4lqEEcSI+UMBt73lgbKzbT4OEuU4kfKT
 o1PA==
X-Gm-Message-State: AOJu0Yzp7scDTpJxusrgKY1pl7/wR0gL+eYTzMeqH3zrwmQCS4ucX8FF
 t/4Zf1+JvtUkPv4eXuPeHTMN5C4FCzydHHLNfkKr8lwf+N3PeCK2zQsbqU3nrK164lqK/SBYLP8
 P5QNBXGJg2bszuAdiRqpSaqu+PUcH+RynJCWEY8x+5qVO39vWxZXKtTGQ
X-Gm-Gg: AZuq6aI3ItRDhgc9RW8j3MVEBk/+BYwKZUqBD4sCPLe8/K0kj1Uq8Y/6UU4AidOD2dK
 znY8Iuq9gYrwDuB/faRs1iUT6wRjYC3gUdjXtxQ5droRwY7/LxW5o9GXA9qC0XxJr/n9v8lGa7L
 i2n5gqrmy591UeB8NNyQzvsiFp+TZ359mLkdG1V9otenikvsRltzcpzhcKXajG9tOjV03E5okBc
 /2rbUHIjgeRsFo4mPNPeV7FMSOgnTTA2TEGLupTlivrInisRPJ+zm2N7S6lUkfHpMmvM11obv75
 9ItETlRqkJRPUpjhsvkB+VEKoLLBz12GASTW+AsDyOkdECsCams9BUH3W0sp6uza25J9sJOfRLJ
 u5qbu
X-Received: by 2002:a17:907:3e12:b0:b87:322d:a8d0 with SMTP id
 a640c23a62f3a-b8792f8b97cmr1299593266b.41.1768910581543; 
 Tue, 20 Jan 2026 04:03:01 -0800 (PST)
X-Received: by 2002:a17:907:3e12:b0:b87:322d:a8d0 with SMTP id
 a640c23a62f3a-b8792f8b97cmr1299591366b.41.1768910581140; 
 Tue, 20 Jan 2026 04:03:01 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.5]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168c7bsm1455074366b.20.2026.01.20.04.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 04:03:00 -0800 (PST)
Message-ID: <35b3750b-31ab-4120-8edd-74aa1ae5f0bf@redhat.com>
Date: Tue, 20 Jan 2026 13:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: Remove duplicated entry of --gdb in the help
 text
To: Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, gustavo.romero@linaro.org
References: <20260114155355.82096-1-thuth@redhat.com>
 <878qe0jfgs.fsf@draig.linaro.org>
 <bc463c63-ec0c-4666-a9ed-7c53e02a24c4@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <bc463c63-ec0c-4666-a9ed-7c53e02a24c4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/01/2026 12.31, Michael Tokarev wrote:
> On 1/14/26 20:01, Alex Bennée wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Since --gdb has recently been added to meson_options.txt, the help
>>> text shows up twice in the output of "./configure --help":
>>>
>>>   $ ./configure --help | grep gdb
>>>     --gdb=GDB-path           gdb to use for gdbstub tests [/usr/bin/gdb]
>>>     --gdb=VALUE              Path to GDB
>>
>> It's a shame to loose the default value - is there anyway for the meson
>> version to show the auto-detected value?
> 
> Maybe we can drop this line from meson but keep it in ./configure?

The meson stuff is generated automatically, so no clue how that could be 
done in a nice way?

  Thomas


