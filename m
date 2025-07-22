Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD494C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFy8-0004Au-AA; Tue, 22 Jul 2025 12:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ueF4I-00041i-Vf
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:38:16 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ueF4D-0000e6-8e
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:38:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c43:4603:0:640:d209:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 10DD98046E;
 Tue, 22 Jul 2025 18:38:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:462::1:2e] (unknown
 [2a02:6bf:8080:462::1:2e])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3cU9U84GjmI0-OhaSCL6n; Tue, 22 Jul 2025 18:38:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1753198683;
 bh=/EpXJZhl/zhVtk0dHftVzrE7YmXN9n0SEqu0hQJ5qNQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=SUm/e3DqnkKZdDqX0ttSZINal0EWHL1UW2oA3BHnR1oZKFyhR6zRHpVdtC5mUnXJW
 XNHsj4OzuGYzoVFrVOlDJCXlmCZGELanllwUwvgZ2SMcmJG9qnrjYD19uMUIZ8rqcl
 AVYx0VVBwDvEGbg7UpbMy9AeMEJPc/sQjJrDevL4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8c9f290a-cc81-4189-83c4-4e75ddd9caf9@yandex-team.ru>
Date: Tue, 22 Jul 2025 18:38:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: make '-msg timestamp=on' apply to all qemu_log usage
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250721185452.3016488-1-berrange@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250721185452.3016488-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 21.07.25 21:54, Daniel P. Berrangé wrote:
> Currently the tracing 'log' back emits special code to add timestamps
> to trace points sent via qemu_log(). This current impl is a bad design
> for a number of reasons.
> 
>   * It changes the QEMU headers, such that 'error-report.h' content
>     is visible to all files using tracing, but only when the 'log'
>     backend is enabled. This has led to build failure bugs as devs
>     rarely test without the (default) 'log' backend enabled, and
>     CI can't cover every scenario for every trace backend.
> 
>   * It bloats the trace points definitions which are inlined into
>     every probe location due to repeated inlining of timestamp
>     formatting code, adding MBs of overhead to QEMU.
> 
>   * The tracing subsystem should not be treated any differently
>     from other users of qemu_log. They all would benefit from
>     having timestamps present.
> 
>   * The timestamp emitted with the tracepoints is in a needlessly
>     different format to that used by error_report() in response
>     to '-msg timestamp=on'.
> 
> This fixes all these issues simply by moving timestamp formatting
> into qemu_log, using the same approach as for error_report.
> 
> The code before:
> 
>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>    {
>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>            if (message_with_timestamp) {
>                struct timeval _now;
>                gettimeofday(&_now, NULL);
>                qemu_log("%d@%zu.%06zu:qcrypto_tls_creds_get_path "  "TLS creds path creds=%p filename=%s path=%s" "\n",
>                         qemu_get_thread_id(),
>                         (size_t)_now.tv_sec, (size_t)_now.tv_usec
>                         , creds, filename, path);
>            } else {
>                qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>            }
>        }
>    }
> 
> and after:
> 
>    static inline void _nocheck__trace_qcrypto_tls_creds_get_path(void * creds, const char * filename, const char * path)
>    {
>        if (trace_event_get_state(TRACE_QCRYPTO_TLS_CREDS_GET_PATH) && qemu_loglevel_mask(LOG_TRACE)) {
>            qemu_log("qcrypto_tls_creds_get_path " "TLS creds path creds=%p filename=%s path=%s" "\n", creds, filename, path);
>        }
>    }
> 
> The log and error messages before:
> 
>    $ qemu-system-x86_64 -trace qcrypto* -object tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>    2986097@1753122905.917608:qcrypto_tls_creds_x509_load  TLS creds x509 load creds=0x55d925bd9490 dir=/var/home/berrange/tls
>    2986097@1753122905.917621:qcrypto_tls_creds_get_path
>   TLS creds path creds=0x55d925bd9490 filename=ca-cert.pem
> path=<none>
>    2025-07-21T18:35:05.917626Z qemu-system-x86_64: Unable to access
> credentials /var/home/berrange/tls/ca-cert.pem: No such file or
> directory
> 
> and after:
> 
>    $ qemu-system-x86_64 -trace qcrypto* -object
> tls-creds-x509,id=tls0,dir=$HOME/tls -msg timestamp=on
>    2025-07-21T18:43:28.089797Z qcrypto_tls_creds_x509_load TLS creds x509
>   load creds=0x55bf5bf12380 dir=/var/home/berrange/tls
>    2025-07-21T18:43:28.089815Z qcrypto_tls_creds_get_path TLS creds path
> creds=0x55bf5bf12380 filename=ca-cert.pem path=<none>
>    2025-07-21T18:43:28.089819Z qemu-system-x86_64: Unable to access
> credentials /var/home/berrange/tls/ca-cert.pem: No such file or
> directory
> 
> The binary size before:
> 
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 87M Jul 21 19:39 qemu-system-x86_64
>    $ strip qemu-system-x86_64
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 30M Jul 21 19:39 qemu-system-x86_64
> 
> and after:
> 
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 85M Jul 21 19:41 qemu-system-x86_64
>    $ strip qemu-system-x86_64
>    $ ls -alh qemu-system-x86_64
>    -rwxr-xr-x. 1 berrange berrange 29M Jul 21 19:41 qemu-system-x86_64
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


