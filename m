Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9B8CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 14:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyt0n-0004nO-Lj; Wed, 17 Sep 2025 10:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uyt0j-0004fH-Dn
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:19:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uyt0a-0001Go-2q
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 10:19:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30D54154F68;
 Wed, 17 Sep 2025 17:19:33 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 424E1283168;
 Wed, 17 Sep 2025 17:19:40 +0300 (MSK)
Message-ID: <28d4d70d-9571-45eb-a4e7-f79ea1454c2c@tls.msk.ru>
Date: Wed, 17 Sep 2025 17:19:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "tests/qtest: use qos_printf instead of
 g_test_message"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pbonzini@redhat.com
References: <20250728145747.3165315-1-armbru@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20250728145747.3165315-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 28.07.2025 17:57, Markus Armbruster wrote:
> This reverts commit 30ea13e9d97dcbd4ea541ddf9e8857fa1d5cb30f.
> 
> "make check" prints many lines like
> 
>      stdout: 138: UNKNOWN:     # # qos_test running single test in subprocess
>      stdout: 139: UNKNOWN:     # # set_protocol_features: 0x42
>      stdout: 140: UNKNOWN:     # # set_owner: start of session
>      stdout: 141: UNKNOWN:     # # vhost-user: un-handled message: 14
>      stdout: 142: UNKNOWN:     # # vhost-user: un-handled message: 14
>      stdout: 143: UNKNOWN:     # # set_vring(0)=enabled
>      stdout: 144: UNKNOWN:     # # set_vring(1)=enabled
>      stdout: 145: UNKNOWN:     # # set_vring(0)=enabled
>      stdout: 146: UNKNOWN:     # # set_vring(1)=enabled
>      stdout: 147: UNKNOWN:     # # set_vring(0)=enabled
>      stdout: 148: UNKNOWN:     # # set_vring(1)=enabled
>      stdout: 149: UNKNOWN:     # # set_vring(0)=enabled
>      stdout: 150: UNKNOWN:     # # set_vring(1)=enabled
>      stdout: 151: UNKNOWN:     # # set_vring(0)=enabled
>      stdout: 152: UNKNOWN:     # # set_vring(1)=enabled
>      stdout: 153: UNKNOWN:     # # set_vring_num: 0/256
>      stdout: 154: UNKNOWN:     # # set_vring_addr: 0x7f9060000000/0x7f905ffff000/0x7f9060001000
> 
> Turns out this is qos-test, and the culprit is a commit meant to ease
> debugging.  Revert it until a better solution is found.
..
> @@ -393,7 +392,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
>            * We don't need to do anything here, the remote is just
>            * letting us know it is in charge. Just log it.
>            */
> -        qos_printf("set_owner: start of session\n");
> +        g_test_message("set_owner: start of session\n");

Here, and elsewhere - checkpatch complains:

ERROR: Error messages should not contain newlines
#93: FILE: tests/qtest/vhost-user-test.c:395:
+        g_test_message("set_owner: start of session\n");

(while some g_test_message calls in the same patch does not contain
the newline).  This is apparently the only place where g_test_message
is used with newlines.

I wonder if we should clean this up?  Something like this:

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index 56472ca709..e8c3613560 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -394,3 +394,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
           */
-        g_test_message("set_owner: start of session\n");
+        g_test_message("set_owner: start of session");
          break;
@@ -420,3 +420,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
           */
-        g_test_message("set_protocol_features: 0x%"PRIx64 "\n", 
msg.payload.u64);
+        g_test_message("set_protocol_features: 0x%"PRIx64, 
msg.payload.u64);
          break;
@@ -428,3 +428,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
      case VHOST_USER_SET_VRING_NUM:
-        g_test_message("set_vring_num: %d/%d\n",
+        g_test_message("set_vring_num: %d/%d",
                     msg.payload.state.index, msg.payload.state.num);
@@ -432,3 +432,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
      case VHOST_USER_SET_VRING_ADDR:
-        g_test_message("set_vring_addr: 
0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64"\n",
+        g_test_message("set_vring_addr: 0x%"PRIx64"/0x%"PRIx64"/0x%"PRIx64,
                     msg.payload.addr.avail_user_addr,
@@ -465,3 +465,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
          if (!qemu_chr_fe_get_msgfds(chr, &fd, 1) && fd < 0) {
-            g_test_message("call fd: %d, do not set non-blocking\n", fd);
+            g_test_message("call fd: %d, do not set non-blocking", fd);
              break;
@@ -511,3 +511,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
           */
-        g_test_message("set_vring(%d)=%s\n", msg.payload.state.index,
+        g_test_message("set_vring(%d)=%s", msg.payload.state.index,
                     msg.payload.state.num ? "enabled" : "disabled");
@@ -516,3 +516,3 @@ static void chr_read(void *opaque, const uint8_t 
*buf, int size)
      default:
-        g_test_message("vhost-user: un-handled message: %d\n", 
msg.request);
+        g_test_message("vhost-user: un-handled message: %d", msg.request);
          break;


Thanks,

/mjt

