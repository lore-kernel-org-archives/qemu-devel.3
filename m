Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E233C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoBm-0002Tb-Eb; Wed, 19 Mar 2025 03:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuoBk-0002RY-4Y
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuoBf-0007Th-6X
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742370599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FAWe/b5zwgPR1XGZx2zULtlehaK55yPwIgjjxhxauKs=;
 b=XyFMYvIvlsQPiFzE/GhV96ERtAqjnyk+qjVB5j61Xhro7iRakvP262PoS+4sqyhrV9dhCu
 StuQ3LaG88Iasv+QZUx45mUvxKisVKFeWv58S2BixWOa0RQ/JEkpC/+GOOEvfPKWmvqEQD
 Ilvh+cUc1pK+HZl8Lun0IoncsSfQDdY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-MyoJ-csaMm2NmsyjvCgOag-1; Wed, 19 Mar 2025 03:49:57 -0400
X-MC-Unique: MyoJ-csaMm2NmsyjvCgOag-1
X-Mimecast-MFC-AGG-ID: MyoJ-csaMm2NmsyjvCgOag_1742370597
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ac2815aba51so486627566b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742370596; x=1742975396;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FAWe/b5zwgPR1XGZx2zULtlehaK55yPwIgjjxhxauKs=;
 b=tZtAXYam9AmRqAm47X6kHOFUvFHCRnUQRrN/Ltox441GIBVLD+A4Url+/1iRJUGsG6
 vFA9XqAkBOaRAX0CHTeG9SypXxluXqHXSuZ/T36bs7BggYh/ZjXXnhBOvM5oHJDTwesS
 v56aEGU4Iou5OqhBqcI49yzEdfSZkdPnHIS0oDFejG3UcZJ5NCttCJAxEDtIb/gjzWZD
 8LnnpeErcNSb4lgx23EwqStqrySdoMP30vt/7YgsrRp0gG24Dj/VwKtY+DKXFOLFcmlP
 i3LMEJGwvqqWprRcZktI8l5IJY5swXYt2Osmr8Q7NF2bxgabCx1ssgfk3K21JTwJ7sVc
 fOtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW43WrLKCscLsIeXitL4kT4eEUkRV6z+Kjq80SW2GD3OgvhhfemlsVlJo5GhWeBm99fPE42db4MQvuM@nongnu.org
X-Gm-Message-State: AOJu0Yy5vk5CPkxbSQrHxITCK1wHJArGQZNG6TgLnlKQvbxXdT1/w6Pj
 HnwFjp43K/lmdWIXnit7pjcHpPnRCr9mLEZnQAv+2iX45HA4+gN3vI8Uyyv82ItUvxFmAPs4dD/
 jXth/usqBx7pf8tV+HFmDAbHlNRMr3FTdzf8rLf112KvhVFpwX8r3
X-Gm-Gg: ASbGncvC/7Df3/RMadpXKdu3fXF1tappr/RLkb5uayza/hK9S9Q+F4HwsMTMzmn8Gl9
 Cm4ts24N4UC0lI6cWJy/5FiQNiyJu30K05iniLfe3dhPgFcihlht76Q0jtuE3dLrRici35xI/1X
 FGYTszM+1ZK5N4+VlA0QW1tsAqW9aFEDRdXeTbHh5xLgARCvqz4K6qo59LglmBQZWts8yQCvJ0U
 7Q5D/a2S4tLOh28IG9dgODbAWIv8ckTPSwlyf8uZhwX1ljHeFCjBhiCNCTgAqcok+2tkievAsvE
 3hrr26vwHjgkpODEvmGq/+ymi45CrYwdggAkIiq5wA==
X-Received: by 2002:a17:907:d2dc:b0:ac3:a7bb:1c2f with SMTP id
 a640c23a62f3a-ac3b7a97f9cmr174572766b.7.1742370596477; 
 Wed, 19 Mar 2025 00:49:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaWyYco99bSLVyk8JUgyK1kQ2K7NSC//Wiqc3ELEHjq/j2pSZw/gvwcxMOVLX6u+o2fwfD9Q==
X-Received: by 2002:a17:907:d2dc:b0:ac3:a7bb:1c2f with SMTP id
 a640c23a62f3a-ac3b7a97f9cmr174569866b.7.1742370596001; 
 Wed, 19 Mar 2025 00:49:56 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-2.web.vodafone.de. [109.42.50.2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314858edcsm957470966b.85.2025.03.19.00.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:49:55 -0700 (PDT)
Message-ID: <8b749710-a5bf-4da9-a6af-160ccb0bbcc5@redhat.com>
Date: Wed, 19 Mar 2025 08:49:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: test_migration.py not working with netcat-traditional
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: ovoshcha@redhat.com, farosas@suse.de, philmd@redhat.com,
 bcain@quicinc.com, quic_mliebel@quicinc.com,
 "Daniel P. Berrange" <berrange@redhat.com>
References: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/03/2025 22.13, Matheus Tavares Bernardino wrote:
> Hi,
> 
> tests/functional/test_migration.py says "The test works for both
> netcat-traditional and netcat-openbsd packages." But when I run it for
> qemu-system-aarch64 on an Ubuntu 22.04 container with netcat-traditional
> installed, I get the following error:
> 
> TAP version 13
> Traceback (most recent call last):
>    File "/pwd/tests/functional/test_migration.py", line 97, in test_migration_with_exec
>      self.do_migrate(dest_uri, src_uri)
>    File "/pwd/tests/functional/test_migration.py", line 72, in do_migrate
>      self.assert_migration(source_vm, dest_vm)
>    File "/pwd/tests/functional/test_migration.py", line 40, in assert_migration
>      self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
> AssertionError: 'failed' != 'completed'
> - failed
> + completed
> 
> not ok 1 test_migration.MigrationTest.test_migration_with_exec
> ok 2 test_migration.MigrationTest.test_migration_with_tcp_localhost
> ok 3 test_migration.MigrationTest.test_migration_with_unix
> 1..3
> 
> With netcat-openbsd (the default), it runs fine. Perhaps the test is no
> longer compatible with netcat-traditional?
> 
> QEMU was configured and built with:
> ../configure --without-default-features --target-list=aarch64-softmmu

For me it works with both flavors of "nc", the ncat and the netcat one... 
but I'm also running on Fedora. So no clue, could you maybe check whether 
there is some additional information in one of the logfiles in 
tests/functional/aarch64/test_migration.MigrationTest.test_migration_with_exec/ 
?

  Thomas


