Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9010606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kb8UhQ/D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN8XA-0000l0-H1; Sat, 31 Oct 2026 08:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN8X7-0000ka-GK
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:50:05 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN8X5-0005dP-PZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 08:50:05 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c468bd799ecso194957966b.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 05:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793451001; x=1794055801; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pu9ySH8wzdJoDr7hznf3MAjhVSU3v9f1o/vWoFVp6HE=;
 b=Kb8UhQ/D2ZuqBm6jRZMTo+ySdjndz96HiLk4hbMYb9QTg8UifEpYiTwbNumflzrmza
 JwOM5wWUuajdT77R3BPvOKGGhcuO32ubLL77lSVqLLGBgBj5GG7CDcrEeQH3IRlyjBZJ
 neN2WpZwqZ8q+fV4J4J78TxVDLMkByKe0nlzs9xI0/MJi9CXdHbezOU+MfOyXUlL+T30
 T33/+OTlRhYDjmc0ipOR1JWXtegRfuBwFpxnomvN26/1KypqG5naaTryMlt/qNtaH7bT
 He9boLKxP2rq5nExTCoUAoeg75X56v6louC66xAR5CZs1YVgIT8XjGRpQ7fDe9e472kY
 wvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451001; x=1794055801;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pu9ySH8wzdJoDr7hznf3MAjhVSU3v9f1o/vWoFVp6HE=;
 b=V0g9XbkNNfqoIoivutLVNDh5KSI+CDydehbpGWcgApH78wd0FZUPu2vXhfvRJ9kYZb
 /5zqNMFGXdW/asDEnKni8J87kVejSuaTSHjUzIb5WhS1a7tddWUkTCxKHt2aVOnRMkTh
 9ddFtKnQi/5eI8ZcqTAydQlnG//8UzwY3kGgsi1EnC8+N/nOafcLVL3q+LgL4sV0FfX5
 cyfLYrJDJC3O/gfAp551Aer/StHiBhDGRM17JrsWv4dEI8gsxQd8rbXDf+Hvi57AC3Fr
 NTa+y76IkTRoHTRy/Krqi6rhMmYNZlaSAlgw3KCgAGfmzaxIT+UJTsEjf2qtcR9+cKXv
 vpkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPXzk2uH7ruC3lPnKnAbJdDC0zdojUXmsGrV8+t/Tup2jRcOMIcYUO4k/NaYJ3sOJ6UsMTqW0/A4/W@nongnu.org
X-Gm-Message-State: AFq9FYI3tNXPkxt1flV1h3NDAGeytFzJiSQVK2SWi/HEMkGUVAC9ehp5
 KbZbP1WKJ2FmAvOGAMolxvU4PMc0tEgp4dhatbeqP28r35u6cRgL4i9Z
X-Gm-Gg: AYBFou2dQ8kSZ8/RPYNK8Mr8BwB0aaVq81vjU+YAkIEtrDEm1c0vGn+M8IXefmta+Lw
 delgmQs+oj0BfYI9/5SwVKW9NQgGl1hHYy62ZIQiI5x9zId7fRgqV3YQStLhxzy6d08t7+qeiDo
 h1xdD/7jiQZPBra9pJzjUiN5NgKUQRxLpx6RZLka4sj2zagEPWlpmM6FCQMV/pWVYmS1i0577Kh
 CmRjlnuE0wC7VH1G8USMae5Amgh6QNqablO1sm/QjZOFP/X6fObM5DrFjRFy6tIgISu5Y1v4e/+
 Sd6QplPZUcz8XGZRcFC3ZbHB50XAssQtYGKmlo4+ZGbnS5J5NwMuRseQGkB52XHN4IklBDIDYFj
 BqSQZwTdlCGo6WwNh0dWA2+K2ODPmrgc3ubVS7zfHvGFicGy6UZC+QTFfK/4f2NxSkSlP0P42Pr
 5FioBPmPT+LIxhhgTe1Cc2PdsMUJIWRwe3M1DFJyqprYRDs0k3yBzHwy3hkscX3m4z4Iym8ADY5
 IsSAujhobzZ5DU306i05HwWzx+m8gnDICEh1ycRy5k8uqyj13CNx2i2FqrPddbEFus/DidbhZr2
 SNN3SEm6l+r8jYc3mQd9G1BSvjkFbBw/GvkeBhZ1/WLhHxUrqs41C149THoGjc0Cb3yvBOVvNkp
 qshEljl76r7LIj76SCucHcoX2Tw==
X-Received: by 2002:a17:907:a890:b0:c46:9ca9:f522 with SMTP id
 a640c23a62f3a-c4ca7a69782mr413209566b.26.1793451001044; 
 Sat, 31 Oct 2026 05:50:01 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabcfd21asm180292666b.18.2026.10.31.05.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:50:00 -0700 (PDT)
Date: Sat, 31 Oct 2026 13:49:02 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] qga: fix crash when a signal arrives during shutdown
Message-ID: <auXjvuRiFvkCxkAN@tulp>
References: <auU_X4KYujIpR2Qo@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auU_X4KYujIpR2Qo@humpty.home.comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Brad Smith wrote:

> qga: fix crash when a signal arrives during shutdown

For some reason your commit message bodies duplicate the title.

> quit_handler() stays installed for SIGINT and SIGTERM for the life
> of the process and dereferences the global ga_state. cleanup_agent()
> frees the agent state and clears ga_state, so a SIGINT or SIGTERM
> arriving after cleanup makes quit_handler() dereference NULL in
> ga_is_frozen() and the agent crashes with SIGSEGV.
> 
> This happens in practice when qemu-ga runs under something that
> forwards signals. For example, running it under sudo and stopping it
> with "pkill -f" signals both sudo and qemu-ga, so the agent receives
> SIGTERM twice.
> 
> Reproduced on FreeBSD by sending SIGTERM after cleanup_agent() under
> lldb.
> 
> Return early from quit_handler() when ga_state is NULL, and clear
> ga_state as soon as the command state cleanup is done, before the
> main loop and the state are freed, so a signal during the rest of
> cleanup does not touch freed memory. ga_state cannot be cleared
> earlier, as command cleanup callbacks such as
> guest_fsfreeze_cleanup() still use it.
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  qga/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/main.c b/qga/main.c
> index fd19c7037d..8cc9810572 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -167,6 +167,10 @@ init_dfl_pathnames(void)
>  
>  static void quit_handler(int sig)
>  {
> +    if (!ga_state) {
> +        return;
> +    }
> +
>      /* if we're frozen, don't exit unless we're absolutely forced to,
>       * because it's basically impossible for graceful exit to complete
>       * unless all log/pid files are on unfreezable filesystems. there's
> @@ -1589,13 +1593,13 @@ static void cleanup_agent(GAState *s)
>          ga_command_state_free(s->command_state);
>          json_message_parser_destroy(&s->parser);
>      }
> +    ga_state = NULL;
>      g_free(s->pstate_filepath);
>      g_free(s->state_filepath_isfrozen);
>      if (s->main_loop) {
>          g_main_loop_unref(s->main_loop);
>      }
>      g_free(s);
> -    ga_state = NULL;
>  }
>  
>  static int run_agent_once(GAState *s)
> -- 
> 2.56.0
> 

I was testing this change by sending SIGTERM in a loop and noticed that
it still crashes with SIGSEGV or SIGARBT from time to time. I was able
to fix that by ignoring signals in the clean up routines:

diff --git a/qga/main.c b/qga/main.c
index 8cc9810572..47686bca80 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -167,6 +167,12 @@ init_dfl_pathnames(void)
 
 static void quit_handler(int sig)
 {
+#ifndef _WIN32
+    struct sigaction action = {
+        .sa_handler = SIG_IGN,
+    };
+#endif
+
     if (!ga_state) {
         return;
     }
@@ -203,6 +209,13 @@ static void quit_handler(int sig)
         return;
 #endif
     }
+
+#ifndef _WIN32
+    sigemptyset(&action.sa_mask);
+    sigaction(SIGINT, &action, NULL);
+    sigaction(SIGTERM, &action, NULL);
+#endif
+
     g_debug("received signal num %d, quitting", sig);
 
     stop_agent(ga_state, true);
@@ -1587,6 +1600,18 @@ static void cleanup_agent(GAState *s)
     if (s->load_avg_pdh_query) {
         PdhCloseQuery(s->load_avg_pdh_query);
     }
+#else
+    struct sigaction action = {
+        .sa_handler = SIG_IGN,
+    };
+
+    sigemptyset(&action.sa_mask);
+    if (sigaction(SIGINT, &action, NULL) != 0) {
+        g_warning("error configuring signal handler: %s", strerror(errno));
+    }
+    if (sigaction(SIGTERM, &action, NULL) != 0) {
+        g_warning("error configuring signal handler: %s", strerror(errno));
+    }
 #endif
     if (s->command_state) {
         ga_command_state_cleanup_all(s->command_state);


