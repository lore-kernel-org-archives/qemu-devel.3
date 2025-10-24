Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EB0CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDJQ-0002Wj-ET; Fri, 24 Oct 2025 04:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vCDJK-0002WY-NF
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:38:10 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vCDJG-0005eH-0Y
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:38:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 08294807E5;
 Fri, 24 Oct 2025 11:37:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:d2ca:5878:b4a3:44a5] (unknown
 [2a02:6bf:803e:400:d2ca:5878:b4a3:44a5])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ubUJmh0FouQ0-SSLNDgr6; Fri, 24 Oct 2025 11:37:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761295078;
 bh=ctEp3zChlpszliTvJWkR4BlJ/v/LSfTHZFSnDNWkgrQ=;
 h=In-Reply-To:Cc:Date:References:To:Subject:Message-ID:From;
 b=nWTA6vq1uqb6T6W4SrzuC+5W8s/fmbWcsswya9bchtlB5Q+5qOC8DmgMXhKmNfoyD
 HMasR3Op/bmiAAYY944iPOFIktyh6GYaZ/NXHFbt+NtXaLFqw1S/zAShKgsKj6VYmC
 P8eZ72chG1es2gzkjRe8RBouH6U/qD1WCI7Rb0+8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Content-Type: multipart/alternative;
 boundary="------------M3SUegZjfVEf3lwFyaUmhxve"
Message-ID: <2490be9d-73db-4087-a20e-8f85b1eee2a8@yandex-team.ru>
Date: Fri, 24 Oct 2025 13:37:56 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
To: Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
 <CAPpAL=zL2iQWQM98R-xRoSFkMEYB+xqtB3KOGc9gAfQnymJxMg@mail.gmail.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <CAPpAL=zL2iQWQM98R-xRoSFkMEYB+xqtB3KOGc9gAfQnymJxMg@mail.gmail.com>
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

This is a multi-part message in MIME format.
--------------M3SUegZjfVEf3lwFyaUmhxve
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, thanks for testing!

On 10/23/25 19:29, Lei Yang wrote:
> Hi Alexandr
>
> According to my test result, this series of patches introduce issues,
> it prints the following error messages when compiling the process
> after applying your patch.
> The test based on this commit:
> commit 3a2d5612a7422732b648b46d4b934e2e54622fd6 (origin/master, origin/HEAD)
> Author: Peter Maydell<peter.maydell@linaro.org>
> Date:   Fri Oct 17 14:31:56 2025 +0100
>
> Error messages:
> [1849/2964] Compiling C object
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
> FAILED: libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
> cc -m64 -Ilibqemu-x86_64-softmmu.a.p -I. -I.. -Itarget/i386
> -I../target/i386 -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt
> -Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui
> -Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/libmount
> -I/usr/include/blkid -I/usr/include/sysprof-6
> -I/usr/include/gio-unix-2.0 -I/usr/include/slirp
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g
> -fstack-protector-strong -Wempty-body -Wendif-labels
> -Wexpansion-to-defined -Wformat-security -Wformat-y2k
> -Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self
> -Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
> -Wold-style-declaration -Wold-style-definition -Wredundant-decls
> -Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
> -Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
> -Wno-shift-negative-value -isystem
> /mnt/tests/distribution/command/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
> -iquote /mnt/tests/distribution/command/qemu/include -iquote
> /mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
> /mnt/tests/distribution/command/qemu/host/include/generic -iquote
> /mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
> -fzero-call-used-regs=used-gpr -fPIE -DWITH_GZFILEOP
> -isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET
> '-DCONFIG_TARGET="x86_64-softmmu-config-target.h"'
> '-DCONFIG_DEVICES="x86_64-softmmu-config-devices.h"' -MD -MQ
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -MF
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o.d -o
> libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -c
> ../hw/block/vhost-user-blk.c
> In file included from
> /mnt/tests/distribution/command/qemu/migration/options.h:19,
>                   from ../hw/block/vhost-user-blk.c:34:
> /mnt/tests/distribution/command/qemu/include/migration/client-options.h:26:1:
> error: unknown type name ‘MigMode’
>     26 | MigMode migrate_mode(void);
>        | ^~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:66:7: error:
> unknown type name ‘BitmapMigrationNodeAliasList’
>     66 | const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
>        |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:80:1: error:
> unknown type name ‘MultiFDCompression’
>     80 | MultiFDCompression migrate_multifd_compression(void);
>        | ^~~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:89:1: error:
> unknown type name ‘ZeroPageDetection’
>     89 | ZeroPageDetection migrate_zero_page_detection(void);
>        | ^~~~~~~~~~~~~~~~~
> /mnt/tests/distribution/command/qemu/migration/options.h:93:27: error:
> unknown type name ‘MigrationParameters’; did you mean
> ‘MigrationState’?
>     93 | bool migrate_params_check(MigrationParameters *params, Error **errp);
>        |                           ^~~~~~~~~~~~~~~~~~~
>        |                           MigrationState
> /mnt/tests/distribution/command/qemu/migration/options.h:94:26: error:
> unknown type name ‘MigrationParameters’; did you mean
> ‘MigrationState’?
>     94 | void migrate_params_init(MigrationParameters *params);
>        |                          ^~~~~~~~~~~~~~~~~~~
>        |                          MigrationState
> ninja: build stopped: subcommand failed.
> make[1]: *** [Makefile:168: run-ninja] Error 1
>
> Thanks
> Lei

I have the same issue on my machine...

In file included from 
/home/dtalexundeer/code/qemu-upstream/migration/options.h:19,
                  from ../hw/block/vhost-user-blk.c:34:
/home/dtalexundeer/code/qemu-upstream/include/migration/client-options.h:26:1: 
error: unknown type name ‘MigMode’
    26 | MigMode migrate_mode(void);
       | ^~~~~~~
In file included from ../hw/block/vhost-user-blk.c:34:
/home/dtalexundeer/code/qemu-upstream/migration/options.h:65:7: error: 
unknown type name ‘BitmapMigrationNodeAliasList’
    65 | const BitmapMigrationNodeAliasList 
*migrate_block_bitmap_mapping(void);
       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/dtalexundeer/code/qemu-upstream/migration/options.h:79:1: error: 
unknown type name ‘MultiFDCompression’
    79 | MultiFDCompression migrate_multifd_compression(void);
       | ^~~~~~~~~~~~~~~~~~
/home/dtalexundeer/code/qemu-upstream/migration/options.h:88:1: error: 
unknown type name ‘ZeroPageDetection’
    88 | ZeroPageDetection migrate_zero_page_detection(void);
       | ^~~~~~~~~~~~~~~~~
/home/dtalexundeer/code/qemu-upstream/migration/options.h:92:27: error: 
unknown type name ‘MigrationParameters’; did you mean ‘MigrationState’?
    92 | bool migrate_params_check(MigrationParameters *params, Error 
**errp);
       |                           ^~~~~~~~~~~~~~~~~~~
       |                           MigrationState
/home/dtalexundeer/code/qemu-upstream/migration/options.h:93:26: error: 
unknown type name ‘MigrationParameters’; did you mean ‘MigrationState’?
    93 | void migrate_params_init(MigrationParameters *params);
       |                          ^~~~~~~~~~~~~~~~~~~
       |                          MigrationState

When I send a patch, did you know, is any CI performed (like compilation)?

I was thinking that there was some issue in my environment (or some 
other code) because it even reproduces on the latest master if I add 
this include to the vhost-user-blk.c file:

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c index 
c0cc5f6942..70235737f0 100644 --- a/hw/block/vhost-user-blk.c +++ 
b/hw/block/vhost-user-blk.c @@ -31,6 +31,7 @@ #include 
"hw/virtio/virtio-access.h" #include "system/system.h" #include 
"system/runstate.h" +#include "migration/options.h"

So, it looks like there is a problem with the client-options.h file 
(that needs to include the qapi file) or in qapi generation process. If 
I apply this patch:

diff --git a/include/migration/client-options.h 
b/include/migration/client-options.h index 289c9d7762..38cf53388d 100644 
--- a/include/migration/client-options.h +++ 
b/include/migration/client-options.h @@ -10,6 +10,7 @@ #ifndef 
QEMU_MIGRATION_CLIENT_OPTIONS_H #define QEMU_MIGRATION_CLIENT_OPTIONS_H 
+#include "qapi/qapi-types-migration.h" /* properties */

the problem goes away..

--------------M3SUegZjfVEf3lwFyaUmhxve
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi, thanks for testing!<br>
    </p>
    <div class="moz-cite-prefix">On 10/23/25 19:29, Lei Yang wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPpAL=zL2iQWQM98R-xRoSFkMEYB+xqtB3KOGc9gAfQnymJxMg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">Hi Alexandr

According to my test result, this series of patches introduce issues,
it prints the following error messages when compiling the process
after applying your patch.
The test based on this commit:
commit 3a2d5612a7422732b648b46d4b934e2e54622fd6 (origin/master, origin/HEAD)
Author: Peter Maydell <a class="moz-txt-link-rfc2396E" href="mailto:peter.maydell@linaro.org">&lt;peter.maydell@linaro.org&gt;</a>
Date:   Fri Oct 17 14:31:56 2025 +0100

Error messages:
[1849/2964] Compiling C object
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
FAILED: libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o
cc -m64 -Ilibqemu-x86_64-softmmu.a.p -I. -I.. -Itarget/i386
-I../target/i386 -Isubprojects/dtc/libfdt -I../subprojects/dtc/libfdt
-Isubprojects/libvduse -I../subprojects/libvduse -Iqapi -Itrace -Iui
-Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0
-I/usr/lib64/glib-2.0/include -I/usr/include/libmount
-I/usr/include/blkid -I/usr/include/sysprof-6
-I/usr/include/gio-unix-2.0 -I/usr/include/slirp
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g
-fstack-protector-strong -Wempty-body -Wendif-labels
-Wexpansion-to-defined -Wformat-security -Wformat-y2k
-Wignored-qualifiers -Wimplicit-fallthrough=2 -Winit-self
-Wmissing-format-attribute -Wmissing-prototypes -Wnested-externs
-Wold-style-declaration -Wold-style-definition -Wredundant-decls
-Wshadow=local -Wstrict-prototypes -Wtype-limits -Wundef -Wvla
-Wwrite-strings -Wno-missing-include-dirs -Wno-psabi
-Wno-shift-negative-value -isystem
/mnt/tests/distribution/command/qemu/linux-headers -isystem
linux-headers -iquote . -iquote /mnt/tests/distribution/command/qemu
-iquote /mnt/tests/distribution/command/qemu/include -iquote
/mnt/tests/distribution/command/qemu/host/include/x86_64 -iquote
/mnt/tests/distribution/command/qemu/host/include/generic -iquote
/mnt/tests/distribution/command/qemu/tcg/i386 -pthread -mcx16 -msse2
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
-fzero-call-used-regs=used-gpr -fPIE -DWITH_GZFILEOP
-isystem../linux-headers -isystemlinux-headers -DCOMPILING_PER_TARGET
'-DCONFIG_TARGET="x86_64-softmmu-config-target.h"'
'-DCONFIG_DEVICES="x86_64-softmmu-config-devices.h"' -MD -MQ
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -MF
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o.d -o
libqemu-x86_64-softmmu.a.p/hw_block_vhost-user-blk.c.o -c
../hw/block/vhost-user-blk.c
In file included from
/mnt/tests/distribution/command/qemu/migration/options.h:19,
                 from ../hw/block/vhost-user-blk.c:34:
/mnt/tests/distribution/command/qemu/include/migration/client-options.h:26:1:
error: unknown type name ‘MigMode’
   26 | MigMode migrate_mode(void);
      | ^~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:66:7: error:
unknown type name ‘BitmapMigrationNodeAliasList’
   66 | const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:80:1: error:
unknown type name ‘MultiFDCompression’
   80 | MultiFDCompression migrate_multifd_compression(void);
      | ^~~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:89:1: error:
unknown type name ‘ZeroPageDetection’
   89 | ZeroPageDetection migrate_zero_page_detection(void);
      | ^~~~~~~~~~~~~~~~~
/mnt/tests/distribution/command/qemu/migration/options.h:93:27: error:
unknown type name ‘MigrationParameters’; did you mean
‘MigrationState’?
   93 | bool migrate_params_check(MigrationParameters *params, Error **errp);
      |                           ^~~~~~~~~~~~~~~~~~~
      |                           MigrationState
/mnt/tests/distribution/command/qemu/migration/options.h:94:26: error:
unknown type name ‘MigrationParameters’; did you mean
‘MigrationState’?
   94 | void migrate_params_init(MigrationParameters *params);
      |                          ^~~~~~~~~~~~~~~~~~~
      |                          MigrationState
ninja: build stopped: subcommand failed.
make[1]: *** [Makefile:168: run-ninja] Error 1

Thanks
Lei</pre>
    </blockquote>
    <p>I have the same issue on my machine...</p>
    <p>In file included from
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:19,<br>
                       from ../hw/block/vhost-user-blk.c:34:<br>
/home/dtalexundeer/code/qemu-upstream/include/migration/client-options.h:26:1:
      error: unknown type name ‘MigMode’<br>
         26 | MigMode migrate_mode(void);<br>
            | ^~~~~~~<br>
      In file included from ../hw/block/vhost-user-blk.c:34:<br>
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:65:7:
      error: unknown type name ‘BitmapMigrationNodeAliasList’<br>
         65 | const BitmapMigrationNodeAliasList
      *migrate_block_bitmap_mapping(void);<br>
            |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:79:1:
      error: unknown type name ‘MultiFDCompression’<br>
         79 | MultiFDCompression migrate_multifd_compression(void);<br>
            | ^~~~~~~~~~~~~~~~~~<br>
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:88:1:
      error: unknown type name ‘ZeroPageDetection’<br>
         88 | ZeroPageDetection migrate_zero_page_detection(void);<br>
            | ^~~~~~~~~~~~~~~~~<br>
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:92:27:
      error: unknown type name ‘MigrationParameters’; did you mean
      ‘MigrationState’?<br>
         92 | bool migrate_params_check(MigrationParameters *params,
      Error **errp);<br>
            |                           ^~~~~~~~~~~~~~~~~~~<br>
            |                           MigrationState<br>
      /home/dtalexundeer/code/qemu-upstream/migration/options.h:93:26:
      error: unknown type name ‘MigrationParameters’; did you mean
      ‘MigrationState’?<br>
         93 | void migrate_params_init(MigrationParameters *params);<br>
            |                          ^~~~~~~~~~~~~~~~~~~<br>
            |                          MigrationState<br>
      <br>
    </p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">When I send a patch, did you know, is any CI performed (like compilation)? </span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">I was thinking that there was some issue in my environment (or some other code) because it even reproduces on the latest master if I add this include to the vhost-user-blk.c file:</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index c0cc5f6942..70235737f0 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -31,6 +31,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "migration/options.h"</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">
</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">So, it looks like there is a problem with the client-options.h file (that needs to include the qapi file) or in qapi generation process. If I apply this patch:</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 289c9d7762..38cf53388d 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -10,6 +10,7 @@
 #ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
 #define QEMU_MIGRATION_CLIENT_OPTIONS_H
 
+#include "qapi/qapi-types-migration.h"
 
 /* properties */</span></p>
    <p class="CPO0LE0j16AwB0G2HeuZ" dir="ltr"><span
      style="white-space: pre-wrap;">the problem goes away..</span><span
      style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------M3SUegZjfVEf3lwFyaUmhxve--

