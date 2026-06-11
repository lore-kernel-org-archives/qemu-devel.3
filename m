Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9825CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXaBP-0005LJ-G9; Thu, 11 Jun 2026 03:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaBM-0005L1-9I
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:50:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wXaBI-0001EX-SX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 03:50:31 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B7o9hS061311
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 11 Jun 2026 16:50:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=S0aO5pH9MERwtJ+2252kq6QaebGVJXwQpnOxCvdQvx0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781164210; v=1;
 b=j+XexPL6U+12gP+d2/hWeyQqUYDa9weOfDi2FYwpLz7FiEM8WX/sdeeLPWt4qsnS
 mvORLnbnybd/ajLpLO2v/4gA6icB0VsGgPEBTiyL4XlrtsL5CPreYfINM1ctfzKK
 L7PA2IELxkup1+QcdElAcM8ReN0hksOi18V1PbdxiyxtsGXQG7yHeV8S9tiUQZXt
 hR/ryNfTiWcX86U1A9ytYvbfIkmmAZNV9MZpRgqFdMvteiuVoebnVqpZZxJLWXZw
 su+ylm/zWJ+RM4+5aTjeDQwzGv6Lem9AQxibxboJCOt3xX5miVE2l2D/3M+ZysCd
 4OJG82LOOz514KjvTgUOEw==
Message-ID: <ab53b726-97dc-48e4-93c3-7a32eacf65a5@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 16:50:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/33] ui/console: register console in QOM tree
 dynamically
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
 <20260608-b4-ui-v2-30-9ea6355ea08f@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260608-b4-ui-v2-30-9ea6355ea08f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
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

On 2026/06/08 16:16, Marc-André Lureau wrote:
> Consoles created after init_displaystate() (e.g. hotplugged
> display devices) were never added to the /backend/console[N]
> QOM tree. Extract qemu_console_add_to_qom() and call it from
> qemu_console_register() when the display is already initialized.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/ui/console.c b/ui/console.c
> index 975eaf15706..e01d893df4b 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -376,6 +376,13 @@ void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len)
>       }
>   }
>   
> +static void qemu_console_add_to_qom(QemuConsole *con)
> +{
> +    g_autofree gchar *name = g_strdup_printf("console[%d]", con->index);
> +    object_property_add_child(object_get_container("backend"),
> +                              name, OBJECT(con));
> +}
> +
>   static void
>   qemu_console_register(QemuConsole *c)
>   {
> @@ -413,6 +420,10 @@ qemu_console_register(QemuConsole *c)
>               }
>           }
>       }
> +
> +    if (phase_check(PHASE_MACHINE_READY)) {
> +        qemu_console_add_to_qom(c);
> +    }

Coldplugged consoles are not added to the QOM tree when -preconfig is 
specified because x-exit-preconfig will happen after init_displaystate() 
but before phase_advance(PHASE_MACHINE_READY). Below is an LLM-written 
reproduction case:

build/qemu-system-x86_64 \
   -machine q35 -nodefaults -display none -S -preconfig \
   -device bochs-display,id=gfx0 -qmp stdio <<'EOF'
{"execute":"qmp_capabilities"}
{"execute":"qom-list","arguments":{"path":"/backend"}}
{"execute":"x-exit-preconfig"}
{"execute":"qom-list","arguments":{"path":"/backend"}}
{"execute":"qom-list","arguments":{"path":"/machine/peripheral"}}
{"execute":"qom-list","arguments":{"path":"/backend/console[0]"}}
{"execute":"quit"}
EOF

Regards,
Akihiko Odaki

>   }
>   
>   static void
> @@ -1089,17 +1100,13 @@ void qemu_console_remove_notifier(Notifier *notifier)
>    */
>   DisplayState *init_displaystate(void)
>   {
> -    gchar *name;
>       QemuConsole *con;
>   
>       QTAILQ_FOREACH(con, &consoles, next) {
>           /* Hook up into the qom tree here (not in object_new()), once
>            * all QemuConsoles are created and the order / numbering
>            * doesn't change any more */
> -        name = g_strdup_printf("console[%d]", con->index);
> -        object_property_add_child(object_get_container("backend"),
> -                                  name, OBJECT(con));
> -        g_free(name);
> +        qemu_console_add_to_qom(con);
>       }
>   
>       return display_state;
> 


