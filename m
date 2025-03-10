Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02764C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 06:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trWyt-0006Vs-VD; Mon, 10 Mar 2025 02:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trWym-0006Ue-Od
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 02:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trWyk-0004lc-Ix
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 02:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741589464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8GBRA05wdnzbQG3xk8B3B0joQGCEbAwT9Wh72qsSn38=;
 b=PdWtHqxNm+gjE5yQwKexBOVTg+kMTfpCHBW+5c0zK9sW6hnEmy9ClhuO+9rnfa0lHiTLjm
 yg+MLBWejHBMtP0lwznjGUbmIXlrKLSKAwXj7QrsbelaBtlFLueYf8cqFLfSsAOeFSCo/C
 KBiy70JrwVxgrFMTRp8i2rqRxgzHDBI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-yiqPBiu2NZSV0I__3p_KOA-1; Mon, 10 Mar 2025 02:51:02 -0400
X-MC-Unique: yiqPBiu2NZSV0I__3p_KOA-1
X-Mimecast-MFC-AGG-ID: yiqPBiu2NZSV0I__3p_KOA_1741589462
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e5edf8a509so2121250a12.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 23:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741589462; x=1742194262;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8GBRA05wdnzbQG3xk8B3B0joQGCEbAwT9Wh72qsSn38=;
 b=GMm1WeQn1fpUP71XgHIx0vgNxIjHGjWxY3ln8arcDh6JCYH8Pp6DpQWX06HuXgRb59
 tchVqoTembV05A70nwazJi+cZ6z4+s1QzW9Q/8VT9/VzmV51JXvj7J++LHW15gLJxrBI
 8R2A3zKPXGSaPGzOPs43mcm92gm99wsNwfbCe+Ep3r4COmcBZGwAnLOfsaxSQDhgPMV1
 ahLhIyj7J15xnqKk1oQe5aO9CncqD+X+LlQlm9X+YHRRh9JOvV88bnH1EHcICbKt750x
 ojhSZMaK0Lz6TcV6AiwcVkRpBNUjL9lyohkVXui/Dc++Rl1vFhrzyau0zYhDWKavorPv
 UkyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPXadtQaKkehXJJ/9IKWSC9PpI5VT6Xs9mAMzWeQrHZ5te1bg63iUTj45uJPOogQ2H4BeFFjIcNl66@nongnu.org
X-Gm-Message-State: AOJu0Yxi71cy6FLReVcklKTqBP21n8jHy0MVU98rWkIqCLv0eyEXabr+
 mhT963yIiukjuUMIUrV6UdB4WCXRrUfiThBHTcd7gkbVt+Tfu7PN4wVoon6fZF0/5bT46LjQiHo
 roz5N00TGDPT9Z1NLboIR5Pr1vLCPHAIEkLBVYf2WUcfSDmjnFBQW
X-Gm-Gg: ASbGncsXIMi9dzoXpAkghJHX+hJviob4KeUmztiofKdzaqMC3GeYhRXBcJCkVVMzJLV
 Xxzue/2VumCZZZY9bW+qoyeOoOf7fhwzcmdMRyAZMPgihG4+AteZAYiHKKELVax33fuhTx0BeyP
 9cqvhp4u0D3UWGNj44B/uETyxjDm2OTltwopFsCR/TBnJxM/BSJwaYVi3dxOQCIO2nsgdq3JNqU
 BV2xBk1mgIlMEmpSXp4l+25HSodpQinZL3tlYSR6YPejlQzywH6GBt6ya423g2wGNh0KCDXo91R
 CUj3DndMALLLChD00vObyE8PaT4Hm8alNPbzF1b6Nt60qjA=
X-Received: by 2002:a05:6402:210c:b0:5e6:e842:f9fa with SMTP id
 4fb4d7f45d1cf-5e6e843093emr3055296a12.19.1741589461715; 
 Sun, 09 Mar 2025 23:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuTxENoZgDcOy2VpT8G5VK30DCOMhCiyjiLwmrl0Cs4mUtrQAY39PLYj513OsIf1UTi3zYQ==
X-Received: by 2002:a05:6402:210c:b0:5e6:e842:f9fa with SMTP id
 4fb4d7f45d1cf-5e6e843093emr3055277a12.19.1741589461370; 
 Sun, 09 Mar 2025 23:51:01 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c768f9a4sm6371157a12.71.2025.03.09.23.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 23:51:00 -0700 (PDT)
Message-ID: <d74d3ff3-3830-4682-87e3-a42ed57068d9@redhat.com>
Date: Mon, 10 Mar 2025 07:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com>
 <fda186da-2e31-42d6-8dd6-0ea3141a73e6@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <fda186da-2e31-42d6-8dd6-0ea3141a73e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 09/03/2025 19.55, Pierrick Bouvier wrote:
> On 6/3/24 05:18, Daniel P. Berrangé wrote:
>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
>>> On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
>>>> We are trying to unify all qemu-system-FOO to a single binary.
>>>> In order to do that we need to remove QAPI target specific code.
>>>>
>>>> @dump-skeys is only available on qemu-system-s390x. This series
>>>> rename it as @dump-s390-skey, making it available on other
>>>> binaries. We take care of backward compatibility via deprecation.
>>>>
>>>> Philippe Mathieu-Daudé (4):
>>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
>>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
>>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
>>>>     hw/s390x: Deprecate the QMP @dump-skeys command
>>>
>>> Why do we have to rename the command? Just for the sake of it? I think
>>> renaming HMP commands is maybe ok, but breaking the API in QMP is something
>>> you should consider twice.
>>
>> That was going to be my question too. Seems like its possible to simply
>> stub out the existing command for other targets.
>>
>> The renaming is just window dressing.
>>
> 
> Working on single-binary topic means specificities from every qemu binary/ 
> architecture has to be merged together. Despite appearing has a bad thing 
> now, it's definitely a step forward for QEMU, and will allow to enable new 
> usages.
> 
> The hard way is to trigger a deep refactoring, involving lengthy 
> conversations where compromises have to be found ("let's implement this for 
> all arch"). The pragmatic way is to eliminate obvious stuff.
> 
> This command is specific to an arch, so renaming is a good and obvious 
> strategy. For the backward compatible anxious developer, another strategy 
> would be to simply declare this command if the running target is s390x. But 
> then, you create a precedent to do something that should not have existed in 
> the first place. 
> 
> +1 for the renaming, and hope that users of this command are able to change 
> a line in their script to adapt to the new command.

Sorry, but no: We've got plenty of other target specific commands... 
rtc-reset-reinjection , query-sev, query-gic-capabilities, just to name some 
few. So unless you provide a patch series to rename *all* of them and 
deprecate the previous names, I don't see the point why changing just one 
single s390x command is necessary.

  Thomas


