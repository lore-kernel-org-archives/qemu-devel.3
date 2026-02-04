Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38BFEA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniuX-0001lY-IW; Wed, 04 Feb 2026 14:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniuG-00014w-4T
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:51:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vniuA-0001gj-TO
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770234664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0qVu0kXtMHWzluizRVmwIEy1t9qzTm/kWC2WlOqKuxQ=;
 b=F4C9kRn2RkVL/bmW1zloDAMlHvZaszCXykPPeNfdd+mfYoPzxvy+OTZXaZb/uQf04sllQf
 sfp8OOhJoPeRT8VnVlbnEPb0JK6AdbN7SbhPTPpKixTI+xTSFmACy/pu7PuSswUMmrtKU2
 u9EeGUQ1DM9eNw84WODlyM+40HX1EFs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-EC-s9SHdP-6ZZm03KTnV7Q-1; Wed, 04 Feb 2026 14:51:03 -0500
X-MC-Unique: EC-s9SHdP-6ZZm03KTnV7Q-1
X-Mimecast-MFC-AGG-ID: EC-s9SHdP-6ZZm03KTnV7Q_1770234662
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50336ebabe0so46012801cf.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770234662; x=1770839462; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0qVu0kXtMHWzluizRVmwIEy1t9qzTm/kWC2WlOqKuxQ=;
 b=q2jt5BKtV9ZZ5g46Glg1EAz6QJ2H5W+Dhccz31rUyURuQnvN5nsED5l3RAqJ6V4aSq
 OINzp7pFT/VfrG37M9rSmKVxdiIGyfp8IAaYIlTQm7eepAaKHqEa7l0PMQnUSv7VbI8K
 XuiwnsmN1YkAVdhCY1KLgojh+ngrq1mAC8qiz1JV3GXegfr3KOFAdKRXJJnxIJO0uiWm
 4Allm0kdqGvrsqVXt0Lbqyt0IzFzzdmvtqnrk4j9ud7tQC+/7kY2SRiMWnAjeGM0+778
 Gc6l3ISPAZDzcr52lD0zL7xcNzBgNSsWeJXUjroC9TS6fWF4pyQ4FLEw66MBooJcaHm/
 mXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770234662; x=1770839462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qVu0kXtMHWzluizRVmwIEy1t9qzTm/kWC2WlOqKuxQ=;
 b=QBqsFhcycWB7ZYF5r6iKZxiTQuX/Jkhxvy6LPLkYarLbK4KS5DaqLgx/NFofLK8/Nf
 1D2S7QSPIJHzZ09F5QAvz6BiKz4m5i1nklBLYy6xUV0/EFKkE1zc3v+fQnlGP7huQi/A
 ZXQxvIytNzWyeVngLRRMr98YiQ6c22bA8unuZhNmerKD20iqsOAGfx3h4oDxCnYRx06Y
 3QhakZN8Y/OZUc/hecIDKG6FCQ7QLyi+9mnquun+0l/YFVtsKlbTJmXqSO3IWG6hMA//
 Pdw5sE4DmPBzw3/o7lUdhH8Ja686rPUkZNcfBq+dJRUD82P75VxjTd2tECXQrmtk/hZg
 7Pzg==
X-Gm-Message-State: AOJu0YyrJVX/zCryZnYBbF9Eb2fK9PbsGGJEeqrw/QkF5YpkFA3tfZWV
 2jxxp/R5kTTvlLikMD/CXGUmTgkJWs4Zfcg51yyFfKaxxnMnelS+qnuBguuic/7hPw2CAJckOao
 yHgLTxBi0a/n8yugWxnwg4hkbQmBp74Tb32F8K5x/Br9RNTmoDHLY5tia
X-Gm-Gg: AZuq6aL6P0pGtwtW2fXaYmStos02Sia1eU0U48J5t+FhF2I7opuoke5Pnn0iR3dGSVs
 SLt2IZ5jB5VCoT2KrUtGfDAD9sFph66sSsAq2ZIYfhqdgTHSIHjcIh0a+CwZddGojstCAY4/BB1
 toXQ77PRFDt4FnGHrRugkgxmZ1EVifF4FPD9T/uFhoh5j7WcjBP3E9HrQlnXdLH+GLg0U5G8rWN
 pB+IaUReSx7xHAIS6itA4yr5AQ/aT0O2UerCofKSZiYZm4SOZKVIWQyamfoUtygD2kayKrv5Xqd
 t1cn7YTsqHPY2SNHF3rr7izg1eRVdXWQrGPwqzCNDmMGCh82iGjtdUBcIL+ZcSVyOdT9gsmG/ck
 AIpA=
X-Received: by 2002:a05:622a:349:b0:501:3aed:fa5f with SMTP id
 d75a77b69052e-5062aa49736mr8102581cf.12.1770234662272; 
 Wed, 04 Feb 2026 11:51:02 -0800 (PST)
X-Received: by 2002:a05:622a:349:b0:501:3aed:fa5f with SMTP id
 d75a77b69052e-5062aa49736mr8102271cf.12.1770234661781; 
 Wed, 04 Feb 2026 11:51:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ca2fd2b5e3sm251469385a.25.2026.02.04.11.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:51:01 -0800 (PST)
Date: Wed, 4 Feb 2026 14:51:00 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, berrange@redhat.com,
 Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] tests/functional/ppc64: Remove custom migration
 routine
Message-ID: <aYOjJEG5paKOObnJ@x1.local>
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204172332.21367-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Feb 04, 2026 at 02:23:32PM -0300, Fabiano Rosas wrote:
> Don't implement a custom migration routine at PpcMigrationTest and
> instead reuse the generic one from MigrationTest.
> 
> This removes the dependency of PpcMigrationTest from
> PseriesMachine. Having one test import another causes unittest code to
> instantiate the imported test, resulting in the setup and teardown
> methods being invoked for the imported test class, even if no test
> from that class will be executed.
> 
> If run in parallel, the extra setup/teardown methods that result from
> importing can race with the ones from the actual test being executed
> and cause the following error:
> 
> File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in tearDown
> shutil.rmtree(self.workdir)
> ...
> FileNotFoundError: [Errno 2] No such file or directory:
> '<SRC_DIR>/build/tests/functional/ppc64/.../test_migration_with_exec/scratch'
> 
> Fixes: f4e34d0fd5 ("tests/functional: Add a OS level migration test for pseries")
> Reported-by: Aditya Gupta <adityag@linux.ibm.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/functional/migration.py            |  5 +++++
>  tests/functional/ppc64/test_migration.py | 11 -----------
>  tests/functional/ppc64/test_pseries.py   |  6 ++++--
>  3 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 49347a30bb..e995328e83 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -65,6 +65,11 @@ def _get_free_port(self, ports):
>              self.skipTest('Failed to find a free port')
>          return port
>  
> +    def migration_with_tcp_localhost_vms(self, dst_vm, src_vm):
> +        with Ports() as ports:
> +            uri = 'tcp:localhost:%u' % self._get_free_port(ports)
> +            self.migrate_vms(uri, uri, dst_vm, src_vm)
> +
>      def migration_with_tcp_localhost(self):
>          with Ports() as ports:
>              dst_uri = 'tcp:localhost:%u' % self._get_free_port(ports)
> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
> index a3b819680b..7d49ee175b 100755
> --- a/tests/functional/ppc64/test_migration.py
> +++ b/tests/functional/ppc64/test_migration.py
> @@ -22,17 +22,6 @@ def test_migration_with_exec(self):
>          self.set_machine('mac99')
>          self.migration_with_exec()
>  
> -    def do_migrate_ppc64_linux(self, source_vm, dest_vm):
> -        with Ports() as ports:
> -            port = ports.find_free_port()
> -            if port is None:
> -                self.skipTest('Failed to find a free port')
> -            uri = 'tcp:localhost:%u' % port
> -
> -            dest_vm.qmp('migrate-incoming', uri=uri)
> -            source_vm.qmp('migrate', uri=uri)
> -            self.assert_migration(source_vm, dest_vm)
> -
>  
>  if __name__ == '__main__':
>      MigrationTest.main()
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index b45763c305..3996a4a878 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -9,7 +9,7 @@
>  
>  from qemu_test import QemuSystemTest, Asset
>  from qemu_test import wait_for_console_pattern
> -from test_migration import PpcMigrationTest
> +from migration import MigrationTest
>  
>  class PseriesMachine(QemuSystemTest):

I wonder if PseriesMachine would be better to inherit directly from
MigrationTest, to avoid the timeout setup and temp QemuSystemTest to be
created on the fly (I'm not familiar with the test framework on side
effects).  But I don't see a major issue with it either so far.

Acked-by: Peter Xu <peterx@redhat.com>

>  
> @@ -116,7 +116,9 @@ def test_ppc64_linux_migration(self):
>          wait_for_console_pattern(self, console_pattern, self.panic_message,
>                                   vm=source_vm)
>  
> -        PpcMigrationTest().do_migrate_ppc64_linux(source_vm, dest_vm);
> +        mt = MigrationTest()
> +        mt.timeout = self.timeout
> +        mt.migration_with_tcp_localhost_vms(dest_vm, source_vm);
>  
>          # ensure the boot proceeds after migration
>          wait_for_console_pattern(self, self.good_message, self.panic_message,
> -- 
> 2.51.0
> 

-- 
Peter Xu


