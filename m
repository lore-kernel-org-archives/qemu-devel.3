Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3704DD15DB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2usz-000218-Gh; Mon, 21 Oct 2024 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2usx-00020o-4p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:03:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2usu-0001vl-S9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729526635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M9Qsh3DBQ00a2nbZSB+KW24daCz6XQ0W466yHgWW60E=;
 b=ZmFpiJ56aGZBEpcMs8jo3mRCaC82zJH4VBWXjq9mEvuUSg/A2PioAELusAWKkcqut9X3Ty
 in8Z6wOErGx4Dg91K+bUfkwzAsq3ya5jgiLY8dNmKiJ2FHUEoCdApdZMSZK1whGPiPavhT
 1y6aqzYUQ5Me9aO0bkgORvCx/cxP7UY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-VtBMdxmaNziv-IIlvjX9-Q-1; Mon, 21 Oct 2024 12:03:52 -0400
X-MC-Unique: VtBMdxmaNziv-IIlvjX9-Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314a22ed8bso34456375e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 09:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729526631; x=1730131431;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9Qsh3DBQ00a2nbZSB+KW24daCz6XQ0W466yHgWW60E=;
 b=VXafMPPEAnyzElqubCwAbgNOStEJLENOpwWHf9dzG0lgfdiwb5utXzvq6jy6EK2Jje
 iUsl4dg3oQ1mi4fx6fV6KQxCX+TtwastwsEW9TjyvGcRPXlewq17quPIQj8XlEdXPM5+
 YkC3xBiYiDBN8MUNsEA2dJKU1w1mj9tdFbJM+Z6AEUcu4G/5qMY2+1c7M+3nBmHwTStW
 k2KnhB9AzXlZI9wUmDN78OFj+jMhSXuLv7VcAbXox2gCi7dLDBVRP6lEdAlSJKbyGWEi
 J3LI67KCajN9XIMwFRkONK7cd+qT8mzSsqVO5QbBbBGrrAN+vzbPRCHiSXaOITIJ7amc
 QkLA==
X-Gm-Message-State: AOJu0YyjNDiWI1ZJIFDvwqcpuSKdLh8ksikMYtQSCm9ki1x2yiTaL6HZ
 +HKwlToH8R4zr1DYQvQKOPTWhoVfrXFzH5FPNPeI6n8a15c4Mud5BJhleYCeaM6kfFP1l4vMuoI
 f3Eytdr2wSxrSXgWhWR/cmVrdGGPrCIW34pdjBotYmqMRO5fr0Tg3
X-Received: by 2002:a05:600c:458d:b0:431:5aea:964 with SMTP id
 5b1f17b1804b1-4316166a975mr82613205e9.19.1729526631207; 
 Mon, 21 Oct 2024 09:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbZ5r9MwI5gXrPQnQkVUOECzTKwoCl7FzR/UrAaslRVWaiJzftjq7B+DwNmcP9YQJUMbb4g==
X-Received: by 2002:a05:600c:458d:b0:431:5aea:964 with SMTP id
 5b1f17b1804b1-4316166a975mr82612885e9.19.1729526630793; 
 Mon, 21 Oct 2024 09:03:50 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-24.web.vodafone.de. [109.42.50.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f57f89fsm60829845e9.16.2024.10.21.09.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 09:03:50 -0700 (PDT)
Message-ID: <b54859e3-a5b6-45b6-b459-2b8eb098742c@redhat.com>
Date: Mon, 21 Oct 2024 18:03:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Test updates (tuxrun tests, new QTest maintainer,
 ...)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241021113500.122500-1-thuth@redhat.com>
 <CAFEAcA9VKkjfYgnv=x5kp+KUZ4rC0y9-KiCWBG+F84MBh7rxPw@mail.gmail.com>
 <a8bbb335-55f4-4c34-b56f-76482391c80e@redhat.com>
 <d5db0cb8-0ec3-4f41-a14c-7d07cbe6f4ec@redhat.com>
 <CAFEAcA8xdxdzXeX7YfZgz45sRqzEsDSWxrhkz11VOSWfVhQ3Dg@mail.gmail.com>
 <9a267d01-1259-4e2a-8ad6-e963923bed2c@redhat.com>
 <CAFEAcA-otzGP7ZB+rsj_x1oStcsT+N3ypuhtVzKHwvUBPbMLPw@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-otzGP7ZB+rsj_x1oStcsT+N3ypuhtVzKHwvUBPbMLPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On 21/10/2024 17.39, Peter Maydell wrote:
> On Mon, 21 Oct 2024 at 15:11, Thomas Huth <thuth@redhat.com> wrote:
>> Looking at the log files of the job, I can see in
>> https://gitlab.com/qemu-project/qemu/-/jobs/8141649069/artifacts/browse/build/tests/functional/aarch64/test_aarch64_tuxrun.TuxRunAarch64Test.test_arm64be/
>> console.log:
>>
>> 2024-10-21 13:20:32,844: Run /sbin/init as init process
>> 2024-10-21 13:20:34,043: EXT4-fs (vda): re-mounted. Opts: (null). Quota
>> mode: none.
>> 2024-10-21 13:20:34,350: Starting syslogd: OK
>> 2024-10-21 13:20:34,423: Starting klogd: OK
>> 2024-10-21 13:20:34,667: Running sysctl: OK
>> 2024-10-21 13:20:34,739: Saving 2048 bits of non-creditable seed for next boot
>> 2024-10-21 13:20:34,966: Starting network: blk_update_request: I/O error,
>> dev vda, sector 5824 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,028: blk_update_request: I/O error, dev vda, sector 8848
>> op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,051: OK
>> 2024-10-21 13:20:35,088: blk_update_request: I/O error, dev vda, sector
>> 12936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,149: blk_update_request: I/O error, dev vda, sector
>> 17032 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,181: Welcome to TuxTest
>> 2024-10-21 13:20:35,882: tuxtest login: blk_update_request: I/O error, dev
>> vda, sector 21128 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector
>> 25224 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,882: blk_update_request: I/O error, dev vda, sector
>> 29320 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
>> 2024-10-21 13:20:35,887: root
>>
>> So this is indeed more than just a timeout setting that is too small...
>> I don't get the virtio errors when running the test locally, though.
>> I guess this needs some more investigation first ... maybe best if I respin
>> the PR without this patch for now 'til this is understood and fixed.
> 
> I guess big-endian is one of the setups most likely to be
> broken :-)

The weird thing is that the old version of the test (avocado based) still 
seems to work fine. And if I run the test locally, I'm also sometimes seeing 
these errors in the console.log now, but they occur just later, so the test 
still finishs successfully... I'll try to have a closer look later, but I 
currently don't have time for such debugging :-(

  Thomas


