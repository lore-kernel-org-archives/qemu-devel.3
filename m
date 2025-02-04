Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68072C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKZh-0005W2-Q1; Tue, 04 Feb 2025 10:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfKZR-0005Ts-Q4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:10:38 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfKZO-0006bm-CA
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:10:36 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfKZH-00000006qzW-3K1P; Tue, 04 Feb 2025 16:10:27 +0100
Message-ID: <2b13fbe2-899f-44fe-b6aa-e8bba3016c1f@maciej.szmigiero.name>
Date: Tue, 4 Feb 2025 16:10:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
To: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <871pwdah5s.fsf@suse.de>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <871pwdah5s.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4.02.2025 16:00, Fabiano Rosas wrote:
> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
> 
>> On 3.02.2025 23:56, Peter Xu wrote:
>>> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
>>>> On 3.02.2025 21:20, Peter Xu wrote:
>>>>> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
>>>>>> On 3.02.2025 19:20, Peter Xu wrote:
>>>>>>> On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
>>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>>
>>>>>>>> Multifd send channels are terminated by calling
>>>>>>>> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>>>>>>> multifd_send_terminate_threads(), which in the TLS case essentially
>>>>>>>> calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>>>>>>>
>>>>>>>> Unfortunately, this does not terminate the TLS session properly and
>>>>>>>> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>>
>>>>>>>> The only reason why this wasn't causing migration failures is because
>>>>>>>> the current migration code apparently does not check for migration
>>>>>>>> error being set after the end of the multifd receive process.
>>>>>>>>
>>>>>>>> However, this will change soon so the multifd receive code has to be
>>>>>>>> prepared to not return an error on such premature TLS session EOF.
>>>>>>>> Use the newly introduced QIOChannelTLS method for that.
>>>>>>>>
>>>>>>>> It's worth noting that even if the sender were to be changed to terminate
>>>>>>>> the TLS connection properly the receive side still needs to remain
>>>>>>>> compatible with older QEMU bit stream which does not do this.
>>>>>>>
>>>>>>> If this is an existing bug, we could add a Fixes.
>>>>>>
>>>>>> It is an existing issue but only uncovered by this patch set.
>>>>>>
>>>>>> As far as I can see it was always there, so it would need some
>>>>>> thought where to point that Fixes tag.
>>>>>
>>>>> If there's no way to trigger a real functional bug anyway, it's also ok we
>>>>> omit the Fixes.
>>>>>
>>>>>>> Two pure questions..
>>>>>>>
>>>>>>>       - What is the correct way to terminate the TLS session without this flag?
>>>>>>
>>>>>> I guess one would need to call gnutls_bye() like in this GnuTLS example:
>>>>>> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>>>>>
>>>>>>>       - Why this is only needed by multifd sessions?
>>>>>>
>>>>>> What uncovered the issue was switching the load threads to using
>>>>>> migrate_set_error() instead of their own result variable
>>>>>> (load_threads_ret) which you had requested during the previous
>>>>>> patch set version review:
>>>>>> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>>>>>
>>>>>> Turns out that the multifd receive code always returned
>>>>>> error in the TLS case, just nothing was previously checking for
>>>>>> that error presence.
>>>>>
>>>>> What I was curious is whether this issue also exists for the main migration
>>>>> channel when with tls, especially when e.g. multifd not enabled at all.  As
>>>>> I don't see anywhere that qemu uses gnutls_bye() for any tls session.
>>>>>
>>>>> I think it's a good to find that we overlooked this before.. and IMHO it's
>>>>> always good we could fix this.
>>>>>
>>>>> Does it mean we need proper gnutls_bye() somewhere?
>>>>>
>>>>> If we need an explicit gnutls_bye(), then I wonder if that should be done
>>>>> on the main channel as well.
>>>>
>>>> That's a good question and looking at the code qemu_loadvm_state_main() exits
>>>> on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
>>>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
>>>> in qemu_loadvm_state() - so still not until channel EOF.
>>>
>>> I had a closer look, I do feel like such pre-mature termination is caused
>>> by explicit shutdown()s of the iochannels, looks like that can cause issue
>>> even after everything is sent.  Then I noticed indeed multifd sender
>>> iochannels will get explicit shutdown()s since commit 077fbb5942, while we
>>> don't do that for the main channel.  Maybe that is a major difference.
>>>
>>> Now I wonder whether we should shutdown() the channel at all if migration
>>> succeeded, because looks like it can cause tls session to interrupt even if
>>> the shutdown() is done after sent everything, and if so it'll explain why
>>> you hit the issue with tls.
>>>
>>>>
>>>> Then I can't see anything else reading the channel until it is closed in
>>>> migration_incoming_state_destroy().
>>>>
>>>> So most likely the main migration channel will never read far enough to
>>>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>>>
>>>>> If we don't need gnutls_bye(), then should we always ignore pre-mature
>>>>> termination of tls no matter if it's multifd or non-multifd channel (or
>>>>> even a tls session that is not migration-related)?
>>>>
>>>> So basically have this patch extended to calling
>>>> qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
>>>
>>> If above theory can stand, then eof-okay could be a workaround papering
>>> over the real problem that we shouldn't always shutdown()..
>>>
>>> Could you have a look at below patch and see whether it can fix the problem
>>> you hit too, in replace of these two patches (including the previous
>>> iochannel change)?
>>>
>>
>> Unfortunately, the patch below does not fix the problem:
>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>>
>> I think that, even in the absence of shutdown(), if the sender does not
>> call gnutls_bye() the TLS session is considered improperly terminated.
>>
> 
> I havent't looked much further into this, but can we craft a reproducer
> for it with current master code? It would help us take a look at this
> problem independently of this series. Even an assert somewhere would
> help.

Sure:
diff --git a/migration/savevm.c b/migration/savevm.c
index bc375db282c2..f1a34b73f507 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2940,7 +2940,13 @@ int qemu_loadvm_state(QEMUFile *f)
  
      /* When reaching here, it must be precopy */
      if (ret == 0) {
-        ret = qemu_file_get_error(f);
+        MigrationState *s = migrate_get_current();
+
+        if (migrate_has_error(s)) {
+            ret = -EINVAL;
+        } else {
+            ret = qemu_file_get_error(f);
+        }
      }
  
      /*

QTEST_QEMU_BINARY=./qemu-system-x86_64 tests/qtest/migration-test -p '/x86_64/migration/multifd/tcp/tls/psk/match'
> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> Broken pipe
> ../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
> Aborted

But we still need to support existing QEMU versions
that do not properly terminate the TLS stream anyway.

Thanks,
Maciej


