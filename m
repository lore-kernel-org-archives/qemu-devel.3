Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D03FC4829A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 09:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYjVS-00084y-Qo; Sat, 10 Feb 2024 04:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYjVP-00084a-VZ; Sat, 10 Feb 2024 04:18:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYjVK-0007iq-6d; Sat, 10 Feb 2024 04:18:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 480EE4C093;
 Sat, 10 Feb 2024 12:19:44 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1EC807832D;
 Sat, 10 Feb 2024 12:18:27 +0300 (MSK)
Message-ID: <d60ddc11-b4b4-4fee-b9c0-08bea513f8d3@tls.msk.ru>
Date: Sat, 10 Feb 2024 12:18:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/34] migration/multifd: Join the TLS thread
Content-Language: en-US
To: peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, qemu-stable <qemu-stable@nongnu.org>
References: <20240208030528.368214-1-peterx@redhat.com>
 <20240208030528.368214-27-peterx@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <20240208030528.368214-27-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

08.02.2024 06:05, peterx@redhat.com :
> From: Fabiano Rosas <farosas@suse.de>
> 
> We're currently leaking the resources of the TLS thread by not joining
> it and also overwriting the p->thread pointer altogether.
> 
> Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to blocking handshake")
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/20240206215118.6171-2-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>

This change, which is suggested for -stable, while simple by its own, seems
to depend on the previous changes in this series, which are not for -stable.
In particular, whole "Finally recycle all the threads" loop in multifd_send_terminate_threads()
(to which the join is being added by this change) is moved from elsewhere by
12808db3b8 "migration/multifd: Cleanup multifd_save_cleanup()" (patch 24 in
this same series).

We can probably add the missing join right into the previous location of this
loop (before 12808db3b8).  I did this in the attached variant for 8.2, is
this correct?

Should we pick this up for 7.2 too?

Thanks,

/mjt

>   migration/multifd.h | 2 ++
>   migration/multifd.c | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 78a2317263..720c9d50db 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -73,6 +73,8 @@ typedef struct {
>       char *name;
>       /* channel thread id */
>       QemuThread thread;
> +    QemuThread tls_thread;
> +    bool tls_thread_created;
>       /* communication channel */
>       QIOChannel *c;
>       /* is the yank function registered */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index fbdb129088..5551711a2a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -630,6 +630,10 @@ static void multifd_send_terminate_threads(void)
>       for (i = 0; i < migrate_multifd_channels(); i++) {
>           MultiFDSendParams *p = &multifd_send_state->params[i];
>   
> +        if (p->tls_thread_created) {
> +            qemu_thread_join(&p->tls_thread);
> +        }
> +
>           if (p->running) {
>               qemu_thread_join(&p->thread);
>           }
> @@ -921,7 +925,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>       trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
>       qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
>       p->c = QIO_CHANNEL(tioc);
> -    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
> +
> +    p->tls_thread_created = true;
> +    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
>                          multifd_tls_handshake_thread, p,
>                          QEMU_THREAD_JOINABLE);
>       return true;


