Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C76EE2099
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voL5U-00065i-2s; Fri, 06 Feb 2026 07:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voL5R-00065O-Ei
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:37:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voL5P-0006ZE-1o
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770381441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SWk3TzQpfUphGfQ7hLifZ6tXWeL+5SshFfitb5aJdAg=;
 b=XQnweTkF7tKXOdva6mhuA2tNVDfCeZwyynHtGKe4/k7Q+m8aNipMM2eIYbsA2wy9Zc4Bcb
 19yd50UXtYXv6fMf1xjn78Unp1LGikDsJThgYFatwJ8z4VNMA0E5nDXeLWEP6Jq7w0+sRa
 bCi0v773JM+a2NXpEzffSIslPUbULGE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-4FgtpEHsN0yyqUKfY-4Weg-1; Fri, 06 Feb 2026 07:37:20 -0500
X-MC-Unique: 4FgtpEHsN0yyqUKfY-4Weg-1
X-Mimecast-MFC-AGG-ID: 4FgtpEHsN0yyqUKfY-4Weg_1770381439
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4362f8b5a65so74495f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770381439; x=1770986239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SWk3TzQpfUphGfQ7hLifZ6tXWeL+5SshFfitb5aJdAg=;
 b=dEpBZ7WTo313uuZbCbRPBGg5qPKlcmq8HEvVTewHakKn3cTjNCbwcad08AlNEc57XE
 F12heKhvJUA38jVYbazOrPRPHVVZ97KxBInKaKTh/bdhcJ0mGbr/k1qpdmpcSl8Vn7V9
 gODqc6WsFywFgYHL8+bqeSrm4uDk+YKOtJHPxypClLT+F9gTJwdGOdmEpHcwgHBG33e2
 w7XwN1IDQfnFbdPN4r7bDalN/bHf4uL7TV+FuEF/xBGMc067eFsdvuRkSSzy8ZpKw4dV
 LzawzcTGMRGBxTRAKLkQoMriKfXqM8/qyldu3Zg+HNwEKxUAKlxDqu0Z3iLC0pw3NTKQ
 w+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770381439; x=1770986239;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SWk3TzQpfUphGfQ7hLifZ6tXWeL+5SshFfitb5aJdAg=;
 b=O9UXGwOTC+bHfpFCxAPTr0qSNet3wzd9ZP/J/5znjLChOSRAI+xgS3k+vXx3tavfEW
 CAJ/SnUzExQEmEsPbQQXymyIcSb4LQm1lcRBUwtVzQbXiafhBgs0A/uPlKkb9ect4aBe
 sBk5Cs2c8B8amVnA4b2swSAEBDTz/m7nXWNzBKB6iExROxGYBSH1DWqDjfTALax+Fd15
 kopOj/1NWSpQoAasGzWfK2dHuDp8hcPp5ievGZ3BYr48E1hix3MUJhpgK4g7hWdDYTD1
 mHFRwDCHH9hO21/kMZI8/imWtf6V/gQkOJcrRcFbV1PoKukIOgDHHYRVobhQT8jnqp3C
 PQVQ==
X-Gm-Message-State: AOJu0YxAO5oHg4OGCaYkeP4gBvkKer6pAuFsWCc4SCFzzihncHxDBraN
 oHll9p57CjeoCjrDXp1wWzpWJPuOYBKCm6APt380F1jodHcIn9Yb8PO/yVSdgRe0f1AtgCwUiV8
 h3ILW4ZrMi6Iz0gz7k+4vtHrfaXTk24tRqSNEJwOekJ20Yeb9zeVe+xQL
X-Gm-Gg: AZuq6aLJPcXyw8JMCvfCH+SAnrVzvOfd4TVe2cq4SkIXiT6zJgosAZRD9nE48UYrF3q
 2NzT1z7ySR92dtJzZRlNUe1zAgMuHjicV+9yUhKiJsJVal+kf/CTM+sI5W7vmz7LTgKHbWa4Ku0
 8MrayNcoSJdLaU2sEC4WYcA9YF+jLMqdV+rjmPJVPa33e2F8JVZU8WL3om4vO0P0nkC42GtycHl
 c9HCrCBHvt9NEBeya3Iv+g0J2FAsRHCW4zAQSToX+Pu9NLywTj/BVpUjU+Cnd+9UvNK2xHalwtb
 yrv1edoZ/GbmlryhL1vno00oGzNovKeu3v/9qvrj7GpeMcc7kfGQurCx2DqowQuzQNyHGbizV/u
 vmKUuUck=
X-Received: by 2002:a05:600c:6388:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-483203a17bbmr35511465e9.4.1770381439168; 
 Fri, 06 Feb 2026 04:37:19 -0800 (PST)
X-Received: by 2002:a05:600c:6388:b0:47d:403a:277 with SMTP id
 5b1f17b1804b1-483203a17bbmr35511075e9.4.1770381438650; 
 Fri, 06 Feb 2026 04:37:18 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm119801815e9.13.2026.02.06.04.37.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 04:37:18 -0800 (PST)
Message-ID: <eedee23c-39dd-4c1a-94e4-d7f1eb0c9d2e@redhat.com>
Date: Fri, 6 Feb 2026 13:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de> <aYOjJEG5paKOObnJ@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aYOjJEG5paKOObnJ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/02/2026 20.51, Peter Xu wrote:
> On Wed, Feb 04, 2026 at 02:23:32PM -0300, Fabiano Rosas wrote:
>> Don't implement a custom migration routine at PpcMigrationTest and
>> instead reuse the generic one from MigrationTest.
>>
>> This removes the dependency of PpcMigrationTest from
>> PseriesMachine. Having one test import another causes unittest code to
>> instantiate the imported test, resulting in the setup and teardown
>> methods being invoked for the imported test class, even if no test
>> from that class will be executed.
>>
>> If run in parallel, the extra setup/teardown methods that result from
>> importing can race with the ones from the actual test being executed
>> and cause the following error:
>>
>> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
>> shutil.rmtree(self.workdir)
>> ...
>> FileNotFoundError: [Errno 2] No such file or directory:
>> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
>>
>> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
>> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/functional/migration.py            |  5 +++++
>>   tests/functional/ppc64/test_migration.py | 11 -----------
>>   tests/functional/ppc64/test_pseries.py   |  6 ++++--
>>   3 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
>> index 49347a30bb..e995328e83 100644
>> --- a/tests/functional/migration.py
>> +++ b/tests/functional/migration.py
>> @@ -65,6 +65,11 @@ def _get_free_port(self, ports):
>>               self.skipTest('Failed to find a free port')
>>           return port
>>   
>> +    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
>> +        with Ports() as ports:
>> +            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>> +            self.migrate_vms(uri, uri, dst_vm, src_vm)
>> +
>>       def migration_with_tcp_localhost(self):
>>           with Ports() as ports:
>>               dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
>> index a3b819680b..7d49ee175b 100755
>> --- a/tests/functional/ppc64/test_migration.py
>> +++ b/tests/functional/ppc64/test_migration.py
>> @@ -22,17 +22,6 @@ def test_migration_with_exec(self):
>>           self.set_machine('mac99')
>>           self.migration_with_exec()
>>   
>> -    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
>> -        with Ports() as ports:
>> -            port = ports.find_free_port()
>> -            if port is None:
>> -                self.skipTest('Failed to find a free port')
>> -            uri = 'tcp:localhost:%u' % port
>> -
>> -            dest_vm.qmp('migrate-incoming', uri=uri)
>> -            source_vm.qmp('migrate', uri=uri)
>> -            self.assert_migration(source_vm, dest_vm)
>> -
>>   
>>   if __name__ == '__main__':
>>       MigrationTest.main()
>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
>> index b45763c305..3996a4a878 100755
>> --- a/tests/functional/ppc64/test_pseries.py
>> +++ b/tests/functional/ppc64/test_pseries.py
>> @@ -9,7 +9,7 @@
>>   
>>   from qemu_test import QemuSystemTest, Asset
>>   from qemu_test import wait_for_console_pattern
>> -from test_migration import PpcMigrationTest
>> +from migration import MigrationTest
>>   
>>   class PseriesMachine(QemuSystemTest):
> 
> I wonder if PseriesMachine would be better to inherit directly from
> MigrationTest, to avoid the timeout setup and temp QemuSystemTest to be
> created on the fly (I'm not familiar with the test framework on side
> effects).  But I don't see a major issue with it either so far.

I think I'd also prefer to inherit directly from MigrationTest.
You could put the test_ppc64_linux_migration() method into a separate class 
that inherits from MigrationTest, while the other test_* methods stay in the 
old class, so that there is for sure no impact on the other tests.
(Having multiple test classes in one file is fine, we have that in a couple 
of other places already).

  Thomas


>>   
>> @@ -116,7 +116,9 @@ def test_ppc64_linux_migration(self):
>>           wait_for_console_pattern(self, console_pattern, self.panic_message,
>>                                    vm=source_vm)
>>   
>> -        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
>> +        mt = MigrationTest()
>> +        mt.timeout = self.timeout
>> +        mt.migration_with_tcp_localhost_vms(dest_vm, source_vm);
>>   
>>           # ensure the boot proceeds after migration
>>           wait_for_console_pattern(self, self.good_message, self.panic_message,
>> -- 
>> 2.51.0
>>
> 


