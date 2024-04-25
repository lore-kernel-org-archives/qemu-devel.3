Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362B3C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 05:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzrFp-0008TT-4P; Thu, 25 Apr 2024 01:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzrFl-0008TC-2y
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 01:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzrFj-0005l2-BZ
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 01:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714021353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iHa2VxZ7WMa0+OUhGmfL1Z9T1OJD71Bqr30zbZqjitY=;
 b=LbsrwMU/gIZrp/N/T+HvOEDqnCA8GoP8H6cWcNdechs/5BTvb4uWcfrQpViD5nX/ZuykFV
 cc4uqyM/gvTOFs3vrcU7MnOcumsWw8Ni6ty+0FVwEs3AzU0YDo7tBax4655sFQ092BRkOr
 wGUERKt9drdbmnIT8F5Kd0Bpi+cHD6Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ZHaXXO9iOtChfCwFmaghBA-1; Thu, 25 Apr 2024 01:02:31 -0400
X-MC-Unique: ZHaXXO9iOtChfCwFmaghBA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5684c1abc7fso178332a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 22:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714021350; x=1714626150;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHa2VxZ7WMa0+OUhGmfL1Z9T1OJD71Bqr30zbZqjitY=;
 b=YznOKSfxbytuoXYHYuk4R6Zal5SBYkpamlncwDoz7DArlPpfv3156JZ/GqY8TxK11U
 q+7XKEEC02h7doUIGgu4Jm5G1Snzn53SCux5geV3p2DzRuzOCPpjUvioYFyHquNpeIgX
 8HaWti6lROhNKbpC+xW8V0dBR7omXgQ3xaH2C92oAxo6EnAQbjpgevkelZxHvBncS5Bh
 Ao4Bz69oyudWWzNHahp/IKPxPaxIPpboL37E3q/bUUqwR5JLXS9wcQ8mscirWbMoWliE
 4ZkUiPtnerL79Wan5tfpg8U8d2DQcDHNHDAwZz51icSQs3mq9NjYpUVUyiR9bjzO0dze
 +eIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ef4p1v8hz/wBE1hi/j0ktUYYBeWuLIkXHuePQz+D+v1FNLpviokZyw2lDa0BU6JPRBbPb3wpk+C7C4GGTnhUyQAUEqY=
X-Gm-Message-State: AOJu0YzrPT/Bl2t+qGkyEizHMgGOCn0FdeZOupxatMySj+MjK9vCR0gg
 YBQJoEhx79EjsFC0W2xWAWqKSaGzFsvgKH1zRxvS31jfzepk4WcllQ7rjJo6ScULXc0Q5VAD5wS
 ce16J2i0kNvr3TCQ1vmsn1auYcXR7VyL9JUns70isi79+tPS4UAHX
X-Received: by 2002:a50:8e08:0:b0:56e:2a0a:c133 with SMTP id
 8-20020a508e08000000b0056e2a0ac133mr3532263edw.22.1714021350623; 
 Wed, 24 Apr 2024 22:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx+ziPSXosONbbVndh/nATp3KqCYaWDaEnLfUlmyWc81jrJsvrofLW0JZC6M4+rnRrdhTpKA==
X-Received: by 2002:a50:8e08:0:b0:56e:2a0a:c133 with SMTP id
 8-20020a508e08000000b0056e2a0ac133mr3532249edw.22.1714021350267; 
 Wed, 24 Apr 2024 22:02:30 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-130.web.vodafone.de.
 [109.43.177.130]) by smtp.gmail.com with ESMTPSA id
 et6-20020a056402378600b0057245a3fd4bsm27695edb.68.2024.04.24.22.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 22:02:29 -0700 (PDT)
Message-ID: <fb62e426-fc14-4ecf-bbcc-24e8386e8880@redhat.com>
Date: Thu, 25 Apr 2024 07:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/17] tests: Update our CI to use CentOS Stream 9 instead
 of 8
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
 <20240424075735.248041-13-thuth@redhat.com>
 <49bf70e6-ad71-4bb4-80c6-2bab08a3145b@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <49bf70e6-ad71-4bb4-80c6-2bab08a3145b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/04/2024 18.19, Richard Henderson wrote:
> On 4/24/24 00:57, Thomas Huth wrote:
>> RHEL 9 (and thus also the derivatives) have been available since two
>> years now, so according to QEMU's support policy, we can drop the active
>> support for the previous major version 8 now.
>>
>> Another reason for doing this is that Centos Stream 8 will go EOL soon:
>>
>> https://blog.centos.org/2023/04/end-dates-are-coming-for-centos-stream-8-and-centos-linux-7/
>>
>>    "After May 31, 2024, CentOS Stream 8 will be archived
>>     and no further updates will be provided."
>>
>> Thus upgrade our CentOS Stream container to major version 9 now.
>>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> Message-ID:<20240418101056.302103-5-thuth@redhat.com>
>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>> ---
>>   .gitlab-ci.d/buildtest.yml                    | 16 ++++-----
>>   .gitlab-ci.d/container-core.yml               |  4 +--
>>   .../{centos8.docker => centos9.docker}        | 34 +++++++------------
>>   tests/lcitool/mappings.yml                    | 20 -----------
>>   tests/lcitool/refresh                         |  2 +-
>>   tests/vm/centos                               |  4 +--
>>   6 files changed, 26 insertions(+), 54 deletions(-)
>>   rename tests/docker/dockerfiles/{centos8.docker => centos9.docker} (82%)
> 
> This has missed a bit, since the centos-stream-8-x86_64 job still exists, 
> but now fails.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/6707154779

It's not this patch, it's rather the "ci: move external build environment 
setups to CentOS Stream 9" patch that is missing an update to 
.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml ... however, blindly 
updating the 8s in that file to 9s likely also doesn't work since there are 
runner tags involved here.
So what's the right way to update that custom runner to CentOS 9? Paolo, 
Alex, Cleber, do you know?

  Thomas


