Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBDBFC5907
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvW5y-0001DG-Al; Thu, 26 Feb 2026 02:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvW5x-0001D5-1C
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvW5v-0003s4-B9
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772092053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WAe0UEOhzgoa8Qvog3JKx0Gvxos7Hs+OG/g97VHH3aM=;
 b=IudEWRtvyJ1r07zj0JOGCT2bKT76NpftRc/xls5R5qsuAJfnVO23Z3jYz9JTVTpxhUTddm
 c68SrhoNvVReovE7jpGYGEr2Adq/46ZB6/nKRLUPmZyGZThaKR9vQ6U5Y1zNeRWrzpv3dn
 ORnmcot4sincGk2g2XIczq4t+5PjM3c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-LmK8HNyZPam7HWNRKCi_yQ-1; Thu,
 26 Feb 2026 02:47:27 -0500
X-MC-Unique: LmK8HNyZPam7HWNRKCi_yQ-1
X-Mimecast-MFC-AGG-ID: LmK8HNyZPam7HWNRKCi_yQ_1772092046
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A7641956054; Thu, 26 Feb 2026 07:47:26 +0000 (UTC)
Received: from [10.45.225.23] (unknown [10.45.225.23])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 998EC1955F2D; Thu, 26 Feb 2026 07:47:22 +0000 (UTC)
Message-ID: <a4a5405b-ca98-4e96-8244-329b0d33ba57@redhat.com>
Date: Thu, 26 Feb 2026 08:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com,
 Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de> <aYOjJEG5paKOObnJ@x1.local>
 <eedee23c-39dd-4c1a-94e4-d7f1eb0c9d2e@redhat.com> <87ecm83ct9.fsf@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87ecm83ct9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 25/02/2026 19.20, Fabiano Rosas wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 04/02/2026 20.51, Peter Xu wrote:
>>> On Wed, Feb 04, 2026 at 02:23:32PM -0300, Fabiano Rosas wrote:
>>>> Don't implement a custom migration routine at PpcMigrationTest and
>>>> instead reuse the generic one from MigrationTest.
>>>>
>>>> This removes the dependency of PpcMigrationTest from
>>>> PseriesMachine. Having one test import another causes unittest code to
>>>> instantiate the imported test, resulting in the setup and teardown
>>>> methods being invoked for the imported test class, even if no test
>>>> from that class will be executed.
>>>>
>>>> If run in parallel, the extra setup/teardown methods that result from
>>>> importing can race with the ones from the actual test being executed
>>>> and cause the following error:
>>>>
>>>> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
>>>> shutil.rmtree(self.workdir)
>>>> ...
>>>> FileNotFoundError: [Errno 2] No such file or directory:
>>>> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
>>>>
>>>> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
>>>> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>>    tests/functional/migration.py            |  5 +++++
>>>>    tests/functional/ppc64/test_migration.py | 11 -----------
>>>>    tests/functional/ppc64/test_pseries.py   |  6 ++++--
>>>>    3 files changed, 9 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
>>>> index 49347a30bb..e995328e83 100644
>>>> --- a/tests/functional/migration.py
>>>> +++ b/tests/functional/migration.py
>>>> @@ -65,6 +65,11 @@ def _get_free_port(self, ports):
>>>>                self.skipTest('Failed to find a free port')
>>>>            return port
>>>>    
>>>> +    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
>>>> +        with Ports() as ports:
>>>> +            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>>>> +            self.migrate_vms(uri, uri, dst_vm, src_vm)
>>>> +
>>>>        def migration_with_tcp_localhost(self):
>>>>            with Ports() as ports:
>>>>                dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
>>>> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
>>>> index a3b819680b..7d49ee175b 100755
>>>> --- a/tests/functional/ppc64/test_migration.py
>>>> +++ b/tests/functional/ppc64/test_migration.py
>>>> @@ -22,17 +22,6 @@ def test_migration_with_exec(self):
>>>>            self.set_machine('mac99')
>>>>            self.migration_with_exec()
>>>>    
>>>> -    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
>>>> -        with Ports() as ports:
>>>> -            port = ports.find_free_port()
>>>> -            if port is None:
>>>> -                self.skipTest('Failed to find a free port')
>>>> -            uri = 'tcp:localhost:%u' % port
>>>> -
>>>> -            dest_vm.qmp('migrate-incoming', uri=uri)
>>>> -            source_vm.qmp('migrate', uri=uri)
>>>> -            self.assert_migration(source_vm, dest_vm)
>>>> -
>>>>    
>>>>    if __name__ == '__main__':
>>>>        MigrationTest.main()
>>>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
>>>> index b45763c305..3996a4a878 100755
>>>> --- a/tests/functional/ppc64/test_pseries.py
>>>> +++ b/tests/functional/ppc64/test_pseries.py
>>>> @@ -9,7 +9,7 @@
>>>>    
>>>>    from qemu_test import QemuSystemTest, Asset
>>>>    from qemu_test import wait_for_console_pattern
>>>> -from test_migration import PpcMigrationTest
>>>> +from migration import MigrationTest
>>>>    
>>>>    class PseriesMachine(QemuSystemTest):
>>>
>>> I wonder if PseriesMachine would be better to inherit directly from
>>> MigrationTest, to avoid the timeout setup and temp QemuSystemTest to be
>>> created on the fly (I'm not familiar with the test framework on side
>>> effects).  But I don't see a major issue with it either so far.
>>
>> I think I'd also prefer to inherit directly from MigrationTest.
>> You could put the test_ppc64_linux_migration() method into a separate class
>> that inherits from MigrationTest, while the other test_* methods stay in the
>> old class, so that there is for sure no impact on the other tests.
>> (Having multiple test classes in one file is fine, we have that in a couple
>> of other places already).
>>
> 
> A new class will make it cumbersome to access the class attributes from
> PseriesMachine:
> 
>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
>      panic_message = 'Kernel panic - not syncing'
>      good_message = 'VFS: Cannot open root device'
>      ASSET_KERNEL = Asset(...
> 
> The "best" way is to make the whole class inherit from MigrationTest. If
> you're ok with that I can send a v3.

Fine for me, too!

  Thanks,
   Thomas


