Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EB5E66882
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 19:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEw1g-0000nV-EE; Sat, 23 Nov 2024 14:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1tEw1d-0000nD-5T
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 14:42:37 -0500
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1tEw1b-00086P-LC
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 14:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1732390951; x=1732995751; i=j.neuschaefer@gmx.net;
 bh=9hLBbGjQ6lrgcJpz4e7B9vixxPP1KpZBbYCUB3vcQ2E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BRE56QGJuhXH2rcbrbmKRTt8w5pgQMMlPcM6NXpFUgtGtAMvIGSvaBXI8yv3oG/T
 v2Jngu1TQZw6TexVg2FbN5EmnEiHySVIQAUS0sRe3tsCSE6ceyRYVTM+GOHVyOzhz
 BBlL5s4BMDnCknrQcyFCkwCKep5px55MqL8wz80CfJ/8dJn82cJrwzOTHIjAvMwjW
 QoMYLVLBlneSLizY3V+36TggGVfT6VBkwxr7/VNNimAQx0BTP2FBGBv3l2JQDmjE6
 KPVvX6V8T9guaRmpQGZazzupa9enoqQg5kdEknCXPt/viGnqODzJWKQ783ddhDEXn
 STBSBJF1gSi8Yj5Ehw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.53]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7R1T-1tnTdi2RRN-00xvi0; Sat, 23
 Nov 2024 20:42:31 +0100
Date: Sat, 23 Nov 2024 20:42:31 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PULL 1/2] linux-user: Print tid not pid with strace
Message-ID: <Z0IwJ-IEjflCZ5tm@probook>
References: <20241123150706.19740-1-richard.henderson@linaro.org>
 <20241123150706.19740-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241123150706.19740-2-richard.henderson@linaro.org>
X-Provags-ID: V03:K1:SYlS28Ob+WK/dzrbTQ3aeSx1ViPrRd7yfqk+aLJR9Z1cQDujrql
 l7MRk0LxsZoNjMtOgzoB6xKwpS6cpq3PbibucAh6B4RWTMsM1zVvBzj1IHdHk+Lvu8fqHVB
 wkWrj4UFM5fQlwJvv9HRPup2FAJKrUjSjBmvhv/6aX4HJQmM5VJ3bKsCIUJJiYv6AAmkovE
 BZvBQgRGbVKnGuJ5rynsg==
UI-OutboundReport: notjunk:1;M01:P0:PNFJ8avhqy4=;UObOByRM2NeiDL4JrigFJJ9SFCX
 rq7kcssNq0YKFkMTHv/Ffh6W4S+Qo8V7ASPrA/wd/oxtnb2BJMdVhSEZ87DmM/c3gVo20Omim
 VXNjZgtsk04yvSLpmw0F3d+44MCU/23048sL3YXgqywAA/BrCTE8sjh+w9WC+0LTHZ8+0tRFf
 hNYwyqwWdG1vOIIu2GnQrH40fnR9c6g98Sw3cOID69roNi/61OtiCZFBT6Mu7ZME5G6k6wMje
 myqIGvkqpU1+tUavtHG0VqEzJTnT3vcGpzqe4wZ000jSWpT0hohVoms0hWDJcqI4dHFMYLuJ6
 z063zTBukW3PUQM/kjlS9DUyyDytO5I6E4rcv0F6vWoy4Ow76lDGZNIqgGmNJ2IZHhwOxd1MP
 rHLw2cDqdEQ5idvyca3E/JrouiZlh2dfLA4klK+ElL9Wj+IYBIiEZeFOsPkB+KcAaVC0L1phD
 XxjV13VDFDlSb95RURtIGtMBg79C9iPBdBnL1BkryJKzeXYw4yWec7Tom7ixy+jyEP1ypcfn9
 33ysL2RYx/9jleC76EOkF1A35UFJ0DXC6sf5qGti+HHfi5dWexQ0d7AYWXRN/wWGkZh1Jtp1C
 nHp1LJA8g50vqb3wL6da70GC6So612HcKOxAr6zlcGckKnJ+m+RKahloQDht+vZBGw6NistME
 Em1KLCCQLJg15UerdMudyMnxIEZoEfMLIok3+spQPeI5cE9da5tFwG31oAppYVHS64fWQo35I
 Yqg0wZQNgpquCWpNGNKca3Uiu4ZgZmxilg/DuP0bIJZNZpqBBI8EQZ25HRjQZ4CHTWgvwJ87d
 lJ+kg7jp1GV952OOsQOhDFisp+1K6hHhHuFMznBNCFoKwheEUD7qun0b1CPTKE4Rk9YHq+WiP
 +HTeefzPZ8x+lLdfxTFAcJDH6vvv8HFwzcXkQbMV912dRBAGEwcsKWraD
Received-SPF: pass client-ip=212.227.15.15; envelope-from=j.neuschaefer@gmx.net;
 helo=mout.gmx.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Nov 23, 2024 at 09:07:05AM -0600, Richard Henderson wrote:
> From: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>
> This aligns with strace, and is very useful when tracing multi-threaded
> programs. The result is the same in single-threaded programs.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Message-Id: 20241024-strace-v1-1-56c4161431cd@gmx.net
> [rth: Use TaskState.ts_tid via get_task_state()]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/strace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index b70eadc19e..f68c5cdc44 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4401,7 +4401,7 @@ print_syscall(CPUArchState *cpu_env, int num,
>      if (!f) {
>          return;
>      }
> -    fprintf(f, "%d ", getpid());
> +    fprintf(f, "%d ", get_task_state(env_cpu(cpu_env))->ts_tid);

Ah, that works too. Thanks for taking care of this patch!

J.

