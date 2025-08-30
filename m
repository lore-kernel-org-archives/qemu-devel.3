Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D01DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 23:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUxx-0007Oc-4t; Sat, 30 Aug 2025 19:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUxu-0007OB-5e; Sat, 30 Aug 2025 19:26:34 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUxs-00029w-3p; Sat, 30 Aug 2025 19:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=SaTkd3o+M20TxnwkQV8tWwcM1oeWVwxqDzK95EyWDj4=; b=eOZkz8U3I/wLJjSw
 OOw/nUcuHMz7SGIPOtbbpZP1piWItPV78Y62sTdz/ck/jzPv0ip53imvG96aLTO1wWFuZhTxjPAz2
 zgmXmKYLm9gzWZod4DejFbJPl/VKWgqHUXHja6zghjPFsaLPc3IxQTEUsNHh857Q00zUYc0wQ2AY+
 Qa2RO9dfOyi6IReUw4v5HeYs5K89G7PDjjHy6/vPf7HrmhwV+H/r1/xWif/56xNQMg5nigSrzP/BL
 4PIRC3kOmrhNsbjhjWIC8wnHru7r7IESuUQeS+c7hex+9DKBbfRZigkK9/VWYqrzor7QRKVB6TgHn
 zOZbiO9hI5rWZ2aImw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1usUxp-007aXB-2Q;
 Sat, 30 Aug 2025 23:26:29 +0000
Date: Sat, 30 Aug 2025 23:26:29 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 06/14] util: set the name for the 'main' thread
Message-ID: <aLOIpXI92MQ6cbq_@gallifrey>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829180354.2922145-7-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:24:04 up 125 days,  7:37,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> The default main thread name is undefined, so use a constructor to
> explicitly set it to 'main'. This constructor is marked to run early
> as the thread name is intended to be used in error reporting / logs
> which may be triggered very early in QEMU execution.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Initially I was unsure why it was in qemu-thread-* - given these
are identical between the posix/windows versions; but I'm not sure
where else it would go.  You'd probably want it in both system and user,
and probably the none-emulator binaries as well.
So this may be the best place.

I'd probably rename it though, it looks like an operation on
a qemu_thread;  like qemu_thread_create() and qemu_thread_start()

Other than that;


Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  util/qemu-thread-posix.c | 6 ++++++
>  util/qemu-thread-win32.c | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index ddaa1de4dd..275445ed94 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -22,6 +22,12 @@
>  #include <pthread_np.h>
>  #endif
>  
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +    qemu_thread_set_name("main");
> +}
> +
>  static void error_exit(int err, const char *msg)
>  {
>      fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 62eaa11026..7a734a7a09 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -22,6 +22,12 @@ typedef HRESULT (WINAPI *pSetThreadDescription) (HANDLE hThread,
>  static pSetThreadDescription SetThreadDescriptionFunc;
>  static HMODULE kernel32_module;
>  
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +    qemu_thread_set_name("main");
> +}
> +
>  static bool load_set_thread_description(void)
>  {
>      static gsize _init_once = 0;
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

