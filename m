Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F49CA101F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 00:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwUrr-00024u-Oy; Wed, 10 Sep 2025 20:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwUrq-00024f-9e; Wed, 10 Sep 2025 20:08:50 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uwUro-0005JK-5s; Wed, 10 Sep 2025 20:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=+P+V4H2H+BNozEPtg6NgeX7u6wj6Do083o6eSL4fmQM=; b=CXzbiOohELM/iIPj
 3xj05Y1SRC9zI5kXeD3ifnPggMoD6nTBXLIWmlcil1H5AHYZcmAT/hw12LXZzLCXcVhrLmAENva6D
 xYnal/3czmfCmgexZkGyEdVsHr5OZAaJ6O/6YcNjnlh5zkEqjrBNMT8GQUdPCSuqnJIyUAUvqPRD9
 ZoHp23Lkzd271SiZs+0AmXwVJqUz0dU+qqKDjqcEKME1bCpGTm3NoLXUfTGkEqzmmFTan8kZFEAZy
 QcgkB5uCyUbA1nAXp1IdqiqthU41nTRWpb+cbvJmDEqE/s4QY8uyAuUeTaY/pfmdMQmmEcROX9SNA
 SQNNEXUY6Aww3MYEnA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uwUrl-00A3Lg-23;
 Thu, 11 Sep 2025 00:08:45 +0000
Date: Thu, 11 Sep 2025 00:08:45 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 09/20] ui/vnc: remove use of error_printf_unless_qmp()
Message-ID: <aMITDSYgYpyzWOqn@gallifrey>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910180357.320297-10-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:06:04 up 136 days,  8:19,  1 user,  load average: 0.00, 0.01, 0.00
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
> The error_printf_unless_qmp() will print to the monitor if the current
> one is HMP, if it is QMP nothing will be printed, otherwise stderr
> will be used.
> 
> This scenario is easily handled by checking !monitor_cur_is_qmp() and
> then calling the error_printf() function.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  ui/vnc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 68ca4a68e7..439d586358 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3530,8 +3530,10 @@ int vnc_display_password(const char *id, const char *password)
>          return -EINVAL;
>      }
>      if (vd->auth == VNC_AUTH_NONE) {
> -        error_printf_unless_qmp("If you want use passwords please enable "
> -                                "password auth using '-vnc ${dpy},password'.\n");
> +        if (!monitor_cur_is_qmp()) {
> +            error_printf("If you want use passwords please enable "
> +                         "password auth using '-vnc ${dpy},password'.\n");
> +        }

OK, but while you're here, could you add the missing 'to' please.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

>          return -EINVAL;
>      }
>  
> @@ -3570,9 +3572,11 @@ static void vnc_display_print_local_addr(VncDisplay *vd)
>          qapi_free_SocketAddress(addr);
>          return;
>      }
> -    error_printf_unless_qmp("VNC server running on %s:%s\n",
> -                            addr->u.inet.host,
> -                            addr->u.inet.port);
> +    if (!monitor_cur_is_qmp()) {
> +        error_printf("VNC server running on %s:%s\n",
> +                     addr->u.inet.host,
> +                     addr->u.inet.port);
> +    }
>      qapi_free_SocketAddress(addr);
>  }
>  
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

