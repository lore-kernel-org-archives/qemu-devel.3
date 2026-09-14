Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D503FC88E78
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68Aw-0008H2-0l; Mon, 14 Sep 2026 11:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x68Au-0008Gq-9i
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:00:52 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x68As-000748-Bi
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:00:52 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 bf1eefe8554c40b241ed443ff7d2da6d3b4617d050783be3d559a62e8a456d22 with SMTP id
 6aa80c19ecd1695303e9bc34; Mon, 14 Sep 2026 15:00:41 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1789398040;
 bh=32JUSj+m9eEl7jlfB2rRu65D4fqD7c+XbrzB3JXLDbQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=JQCV6J6peX0/qwAhLZ8ypXYc59mJDJzc2puzqsmA4ATvIraadktuOHrCA0qg5z9gB
 mDqJNTuwroBPngUupGoxwg315PEtI5D5v7sOWdxldDvwnsHuqXJgCmA+y6aKBGucnq
 dsoN4BuGWIN1tPRAdqIUYL15ZQZXV8DJVBZgMXoso1Ix7JwCDv1yWfZ8d4XtyWAJhf
 lledOXkFSNJg4BDvStiOeE5jTxiwE+bj4JguEdfHohz65ahG9wegUhWqyTiNxUI4Na
 hHyuFwcPDyYfQCo4DyFbK+3lo4t9XO6GvLukTJ8tj71zE1pRNGg1HbrBPFjJOIn4jg
 0FuQSh74dU3wQ==
Message-ID: <85f8ffaa-f888-416c-beba-0344ceb8bf3d@yodel.dev>
Date: Mon, 14 Sep 2026 10:00:39 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 2/9] tests/test_vhost_user_bridge: skip when running ASAN
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com>
 <20260907075640-mutt-send-email-mst@kernel.org>
 <CAJ+F1CJfjvYWRW1Az=1Q2vUMM+RS56-_a5ugLbepeznHm8pvxw@mail.gmail.com>
 <20260907093319-mutt-send-email-mst@kernel.org>
 <CAJ+F1CKiUFGqJbWuxNM54bPJg1AicBKK_i+AuXttSCy-JRr8xg@mail.gmail.com>
 <20260907152927-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260907152927-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi, Marc-André and Michael

On 07/09/2026 14:32, Michael S. Tsirkin wrote:
> On Mon, Sep 07, 2026 at 06:18:39PM +0400, Marc-André Lureau wrote:
>> Hi
>>
>> On Mon, Sep 7, 2026 at 5:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Mon, Sep 07, 2026 at 05:22:43PM +0400, Marc-André Lureau wrote:
>>>>> maybe just avoid stdbuf completely.
>>>>> i don't remember why we use it, but it looks like merely to
>>>>> disable buffering for stdout?
>>>>>
>>>>> If so:
>>>>>
>>>>> setvbuf(stdout, NULL, _IONBF, 0);
>>>>>
>>>>> will do just that with no asan issues.
>>>>>
>>>>
>>>> That requires modifying vhost-user-bridge, not sure that's what we want.
>>>>
>>>> thanks
>>>
>>> why not? it's not like it's a facility useful outside of testing qemu.
>>> If we were we'd probably disable stdout printout completely.
>>
>> Since the test redirects stderr to stdout, I guess the log is
>> fully-buffered for stdout and unbuffered for stderr, and we see stderr
>> log lines in the file log before the others. If we call
>> setvbuf(stdout, NULL, _IONBF, 0) early, we probably will get
>> interleaved stream output, but probably broken lines...
> 
> We can also just change that macro to write to stderr.
> 
>> Tbh, I don't
>> have much motivation to check or fix this, I would just like the test
>> to be green or skipped when built with ASAN. The current workaround is
>> quite ok. If you prefer setvbuf() in vhost-user-bridge.c, I am okay
>> too.
>>
>> Yodel, wdyt?
> 

Apologies for the delayed response, and thanks for finding,
reporting, and addressing the problematic interaction
between stdbuf and ASAN.

I have implemented Michael's suggestion to modify the DPRINT
macro to write to stderr and can attest that the log lines
are properly interleaved even in the absence of stdbuf.

If there are no objections, I'll submit the patch shortly.
Below is a preview.

Thanks,
Yodel

-- >8 --

diff --git a/contrib/vhost-user-bridge/vhost-user-bridge.c 
b/contrib/vhost-user-bridge/vhost-user-bridge.c
index 3f0fd0fa49..a6f7ec226c 100644
--- a/contrib/vhost-user-bridge/vhost-user-bridge.c
+++ b/contrib/vhost-user-bridge/vhost-user-bridge.c
@@ -41,7 +41,7 @@
  #define DPRINT(...) \
      do { \
          if (VHOST_USER_BRIDGE_DEBUG) { \
-            printf(__VA_ARGS__); \
+            fprintf(stderr, __VA_ARGS__); \
          } \
      } while (0)

diff --git a/tests/functional/x86_64/test_vhost_user_bridge.py 
b/tests/functional/x86_64/test_vhost_user_bridge.py
index c36c625420..5e1db48884 100755
--- a/tests/functional/x86_64/test_vhost_user_bridge.py
+++ b/tests/functional/x86_64/test_vhost_user_bridge.py
@@ -76,12 +76,6 @@ def configure_vm(self, ud_socket_path, lport, rport, 
hostfwd_port, tftpdir):
      def assemble_vubr_args(self, vubr_path, ud_socket_path, lport, rport):
          vubr_args = []

-        if (stdbuf_path := which("stdbuf")) is None:
-            self.log.info("Could not find stdbuf: vhost-user-bridge "
-                          "log lines may appear out of order")
-        else:
-            vubr_args += [stdbuf_path, "-o0", "-e0"]
-
          vubr_args += [vubr_path, "-u", f"{ud_socket_path}",
                        "-l", f"127.0.0.1:{lport}", "-r", 
f"127.0.0.1:{rport}"]

