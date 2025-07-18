Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1787BC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uccnV-0000tA-U1; Fri, 18 Jul 2025 00:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ucclv-0005tZ-OY
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 00:32:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ucclr-0005n3-KI
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 00:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752813148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4eDb14VFzn9u5RCPQWGl7aU7ceyMFTortuK6AaFF0Pc=;
 b=i0a/vHpbgtqYqyxFWASeejF5/1KNH7sL4ANJhYulATTzePDPssZzbAB+8FeJ+q2AXv5fLn
 gbtmXVuxjTEarqDIqt/B6J/nKOD+Rk1Fhe3v2zxVfCHjwbNLvPJeh8R8ZYS1BT/4FJHcHn
 VsiZWNe9+lI7gxn6LfTxO0eYrrn7c5s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-z64abOjjOCO0e0KKByD-Ag-1; Fri, 18 Jul 2025 00:32:26 -0400
X-MC-Unique: z64abOjjOCO0e0KKByD-Ag-1
X-Mimecast-MFC-AGG-ID: z64abOjjOCO0e0KKByD-Ag_1752813145
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so639784f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 21:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752813145; x=1753417945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4eDb14VFzn9u5RCPQWGl7aU7ceyMFTortuK6AaFF0Pc=;
 b=hul6WLODAb4IKqf+peDg3df2lRMCyKFhayvu84obby+2wsv++8SsjpMfVeWvUR5+H8
 fVUzSG9gTk1lokI071JQfZ1cx86E06mTxWS67MRPMa2MTGzumwDrJP3+FVQEWLhww5H4
 n53C1PwPrQrrtUNSOmS+LSoak4fBkvn3lA3orrlwNrCR4ZkfweDal8bRi64+SVnSBTxh
 Co1Uyn/4PD0x59Q0zTQCj/Yi2mh9+BDbwx9VEpCMq8sKtLkHed/I9J14WwbkOjfUo79n
 1weE17l57Olk8o25kSCJb7PDKFAD2dGROwTk1xau6if07MGigxo1uYeesRASrT5PisvX
 Merw==
X-Gm-Message-State: AOJu0YxMoBxDOqi7tmake4LPoqCmQ8BzGabStG42ei3hBD1Vox/PACsC
 KaNOFk98RylJrBxjQgIInBkOen5h+rpjzgVB4uW497ZSLGAMpweD3lILP/GCHfgI8DpRuovlO7r
 QeB1LqrglRAOz1a+H2LgYFnQ/NFwTTYLRNUaCc2j6say5TIOhb7Jc4gmy
X-Gm-Gg: ASbGncsQEjTXcpxF+Cak9gdF9AbxDDrV+ZE8O0zwtKyFwqYuPIoEHoALact7NzeHiHS
 8EFmBZ+L+iqH++z63EinYboRkdoP+Qf7ZXT9y27Id5oSYKAb0m7XcqJ0rKzyd2/Wz9+Duhb3gkC
 /25dx3uQTPimknAyLUJxwTOZTNYiFARBE1X+2mxtBpwDkQtPBwKqvcnjjsC4E+UNl9awzaKdB6a
 2HkRuT7BrCguchmfV8x+zh2oN43FVZbQnLzb/3svWFjv8Hq3uclt4jqPzwvvE6A/Kj7zQdSmBFk
 B8DJ+zorpYRRAjKaY6SUdqedJunqckyBB8reqJWB9q1zXFOnthYJFlIyuLE/AusFFRZgB/yK1KE
 =
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3b613e66f70mr4678919f8f.16.1752813145239; 
 Thu, 17 Jul 2025 21:32:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU/mOAZaUzMlNsbaEAs9Sl+WXOwA9BIee7ux9O++lPL7oaYaSa8UvtUUqfQ6Ik8+8pP0iMUw==
X-Received: by 2002:a05:6000:1a8e:b0:3a4:f7e7:416b with SMTP id
 ffacd0b85a97d-3b613e66f70mr4678905f8f.16.1752813144760; 
 Thu, 17 Jul 2025 21:32:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bac1sm696410f8f.25.2025.07.17.21.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 21:32:23 -0700 (PDT)
Message-ID: <189d6fa6-71c0-4dd1-999b-0260ad554c63@redhat.com>
Date: Fri, 18 Jul 2025 06:32:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: Fix Aspeed title
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Ed Tanous <etanous@nvidia.com>
References: <20250715061904.97540-1-clg@redhat.com>
 <CAFEAcA8B4gh68qYH+NK_G3V+FViTRtCmKLbyayJCbgBqtV1_Qw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA8B4gh68qYH+NK_G3V+FViTRtCmKLbyayJCbgBqtV1_Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/17/25 19:01, Peter Maydell wrote:
> On Tue, 15 Jul 2025 at 07:19, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> commit ad8e0e8a0088 removed the "======" underlining the file title
>> which broke documentation rendering. Add it back.
>>
>> Fixes: ad8e0e8a0088 ("docs: add support for gb200-bmc")
>> Cc: Ed Tanous <etanous@nvidia.com>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
> 
> Thanks for the patch; I'll pick it up via target-arm.next since
> I'm doing a pullreq for rc0 anyway.

Please do. It's the only patch I have on the aspeed side for now.

Thanks,

C.



