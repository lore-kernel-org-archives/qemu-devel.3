Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153EFCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 21:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIZiA-0005EZ-Mf; Mon, 10 Nov 2025 16:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vIZhV-00050w-Md
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 16:45:53 -0500
Received: from esa9.hc2706-39.iphmx.com ([216.71.140.197])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vIZhR-00029d-Tp
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 16:45:25 -0500
X-CSE-ConnectionGUID: 7J9bsgu3SdC2X37UilFalA==
X-CSE-MsgGUID: QtvJVMx9QhCERXNJmJ9wVA==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.222.70
X-IronPort-MID: 89573634
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:sQzAhq1ml35yQipOsvbD5Ydwkn2cJEfYwER7XKvMYLTBsI5bpzIBz
 WsdD2uBMvmDZWbzLdkja4628EJX657UxtMyGlc/qSg9HnlHl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhXgtYwr414rZ8Eky5a2r4GtC1rADTasjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbZLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOggqe0Iw/ylWZcWq8VJcSJS1mZX7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lMTLSjfm53emARsI2tp98EcjvEoobkyQ1pd3ZJa5OrZHrRqzL4ZpF1W51iJ8WW/nZY
 MUdZHxkaxGojx9nYA9GTsJj2r3y3D+gK1W0q3rMzUYzy2HX3Ap9ypDnLZzYdsHiqcB9zhfF+
 TmYpDiR7hcyDcCB6wSg4iOVhsTipxPdeocwRaKG36s/6LGU7ilJYPEMbnOirPykz0KzRd9bA
 0oT/CUosO417kPDczXmdxixoXrBoxdFHtQPS6s17waCzqeS6AGcboQZcgN8hBUdnJZebRQgy
 xmEk86BONClmOH9pa61nltMkQ6PBA==
IronPort-HdrOrdr: A9a23:yFvToapAZMP3R9gfYo/QeAsaV5scL9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6Ki90dq7MAjhHP9OkP4s1NKZMDUO11HYSr2KgbGC/9TAIVybygc/79
 YXT0EdMqyIMbESt6+Tj2eF+r0bsbq6GdWT9ILjJgBWPGNXgs9bjztRO0K+KAlbVQNGDZ02GN
 63/cxcvQetfnwRc4CSGmQFd/KrnayCqLvWJTo9QzI34giHij2lrJTgFQKD4xsYWzRThZ8/7G
 n+lRDj7KnLiYDx9vac7R6Y031loqqs9jJxPr3CtiHTEESjtu+cXvUtZ1RFhkF1nAjg0idrrD
 CGmWZbAy060QKtQojym2ql5+Ca6kdI15aq8y7mvVLz5cP+Xz40EMxHmMZQdQbY8VMpuJVm3L
 tMxH/xjesiMfrsplWO2zHzbWAeqqOZmwtTrQdItQ0gbaIOLLtK6ZcS9ElJEJEGBkvBmfwa+c
 FVfbDhzecTd0+GZHbEuWQqyMCwXx0Ib2S7fnQ=
X-Talos-CUID: =?us-ascii?q?9a23=3AQmQ9+GsffeHqeVbBdvzTtisi6It6UCzX13jNeHS?=
 =?us-ascii?q?0IjxZE+KoSFu+8adNxp8=3D?=
X-Talos-MUID: 9a23:G8mCVApOBmOcUBwbH4cezwh+KuVWxrT/MUAmvK82neuBF31vBR7I2Q==
Received: from mail-ua1-f70.google.com ([209.85.222.70])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Nov 2025 16:45:12 -0500
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-9371caa88ceso2458344241.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1762811112; x=1763415912; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rd9f10U4qJuEgXdd3+WmVasGWeY/PwV1V4ny6jcS0SI=;
 b=O/xQ4ztfOPhMMOTZYib3RT1Q7ZwkCBLtwPJwXZJAUH4fxQKKeKULjR2FEf2w3ZSEdS
 4AKmQilujSOhTozFTyC23KVASzNDd2ReQWeYC/HFtq8GSyB6podFTMS0s9FQX84irjfV
 XU2PU1+bf5lnG3Vj58X2yngCL+59iE6peN7ejC27y4B1SVVpC5mcxg6ssTtKAToaovXk
 rvxJnkzzAUJCDb73Z2ZaA8neT7df1aGk1zNauTER/6HnYKip87RRZ6g1XnqF043KHBy2
 HxhJe1Vq2tQQvEH19Sk/KLLQN3BMbO6HTU4ew+3E7vBeXvZI4pOoADdGt5pvoQQW4flC
 RRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762811112; x=1763415912;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rd9f10U4qJuEgXdd3+WmVasGWeY/PwV1V4ny6jcS0SI=;
 b=pUYN3i+zRcfbi+0LJBCI68hOUh5sjEnA6YvZuJJdNSa/90vfzeDBo/O0svlRbhWftY
 iXB/o1htID9hTxYYWsEQO2LaEIZYND6Ytx0X19L9jzaUuW+NbFyPWv4Yqu9Sk1uYMthZ
 6gIoFY3E8QmNKvBX97sQEQ7tLcXBTDHvWwnxVmk7RNf5B3scuf7ZUtU6/A9FYNghGdZ/
 lYkVgjhox84bwt7XpNRM1e2ai1CbXU91A5yDW9zEqRV4e8jE6qUkPKzCyNv6c/3AzzX0
 tk+N7wrVCuQ8i8Ax/biSlFPIAdHytL5Iq0L8XdtFr4Yw16nkaNKxMSJZ0ncMFouErEgn
 zOsg==
X-Gm-Message-State: AOJu0Yw11uvfg1myNuBzdXE9ud3WkJlNcVR6rFFHyP8TCW8qqpcVQXMO
 +bUdGZzC/XB6iiyQaGnwIGBNntksL9Er60WKwsWYB7zRb31YMyBIG2gIp+YRY0Djkmv4uQKpWZT
 MjEQvQautTENeBFx3ETJz8OSJl6p/ESzn/QzxyuvkLbJLK17dV9xTTqe93IP1s6zTLwEhGkBXNt
 hN6WLxu77l8JCO2JrLR0ylmAqI401ytU+PQQhEVrqvDv/O
X-Gm-Gg: ASbGncv40HJMI5dTkIbD8Nw87oDuo7PQLum2mHrrIm+3zcfUD5vdZ8VRb7NT0Yi/oax
 F/9KXAcDl3GU/SwH34wPMmAQMDtF4LrGugQrxxK7EjC1DP+xBKak6BoBOjgIVWaXiDJ2/yNNRlo
 OFp1FIgt4isFaBk1A6l9KbWC77yPPElLLm2PKZdn0v8IFrfYKtlNvI/1I=
X-Received: by 2002:a05:6102:50a5:b0:5dd:b2a3:e7ad with SMTP id
 ada2fe7eead31-5ddc46c6899mr3667910137.11.1762811112485; 
 Mon, 10 Nov 2025 13:45:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8rP0UcQo8OsMV50kYwCteOzH+fz8aiUB/89lzECMhAvutcHAZpu2JFkbYRcHrlYF2CEdkr7JHjrO349dGkUw=
X-Received: by 2002:a05:6102:50a5:b0:5dd:b2a3:e7ad with SMTP id
 ada2fe7eead31-5ddc46c6899mr3667894137.11.1762811112080; Mon, 10 Nov 2025
 13:45:12 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 15:45:11 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 15:45:11 -0600
From: Alexander Bulekov <alxndr@bu.edu>
References: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
 <20251014003008.2520701-1-navidem@google.com>
 <20251014003008.2520701-2-navidem@google.com>
MIME-Version: 1.0
In-Reply-To: <20251014003008.2520701-2-navidem@google.com>
Date: Mon, 10 Nov 2025 15:45:11 -0600
X-Gm-Features: AWmQ_bme2J6DMaZiwrMkvqY6nZiQHKwqJpdvxBp18d35a34hukilI3J9iwpfOP4
Message-ID: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.71.140.197; envelope-from=alxndr@bu.edu;
 helo=esa9.hc2706-39.iphmx.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.825, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 251014 0030, Navid Emamdoost wrote:
> Add a new generic fuzz target for the QEMU VNC server. This target
> exercises both the standard VNC protocol and the VNC-over-WebSocket
> transport layer, increasing coverage of a primary remote attack surface.
>
> To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
> socket paths are generated dynamically. The fuzzer harness inspects the
> command line for placeholders and replaces them with unique paths
> created by mkstemp() before execution.
>
> ---
>
> This new target increases code coverage in the VNC subsystem
> and related networking and I/O code.
> The baseline coverage below was generated by running all existing fuzz
> targets with the oss-fuzz corpus. The new target shows significant gains:
>
> ----------------------------------------------------------------------------
> File                       New Target                Baseline        Change
> ----------------------------------------------------------------------------
> vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
> keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
> net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
> channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
> qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
> vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
> dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/fuzz/fuzz.c                 | 65 +++++++++++++++++++++++++
>  tests/qtest/fuzz/generic_fuzz_configs.h |  5 ++
>  2 files changed, 70 insertions(+)
>
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index ca248a51a6..b77c3ceb2b 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -126,6 +126,46 @@ static FuzzTarget *fuzz_get_target(char* name)
>      return NULL;
>  }
>
> +/*
> + * Global variables to hold the unique socket paths for cleanup.
> + */
> +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
> +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
> +
> +/*
> + * atexit() handler to clean up both socket files.
> + */
> +static void cleanup_vnc_sockets(void)
> +{
> +    if (g_vnc_socket_path[0] != '\0') {
> +        unlink(g_vnc_socket_path);
> +    }
> +    if (g_vnc_ws_socket_path[0] != '\0') {
> +        unlink(g_vnc_ws_socket_path);
> +    }
> +}
> +
> +/* Helper function to find and replace a placeholder in a GString */
> +static bool replace_socket_placeholder(GString *cmd_line, const char *placeholder,
> +                                       const char *path_template, char *global_path_out)
> +{
> +    char *placeholder_ptr = strstr(cmd_line->str, placeholder);
> +    if (placeholder_ptr) {
> +        int fd;
> +        strcpy(global_path_out, path_template);
> +        fd = mkstemp(global_path_out);
Appologies for the delay. Let's use g_mkstemp, if possible.

> +        if (fd == -1) {
> +            perror("mkstemp failed");
> +            return false;
> +        }
> +        close(fd);
> +
> +        gssize pos = placeholder_ptr - cmd_line->str;
> +        g_string_erase(cmd_line, pos, strlen(placeholder));
> +        g_string_insert(cmd_line, pos, global_path_out);
> +    }
> +    return true;
> +}
>
>  /* Sometimes called by libfuzzer to mutate two inputs into one */
>  size_t LLVMFuzzerCustomCrossOver(const uint8_t *data1, size_t size1,
> @@ -213,6 +253,31 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>      g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
>                             getenv("QTEST_LOG") ? "" : "-qtest-log none");
>
> +    /*
> +     * For the VNC fuzzer, we replace placeholders for both the standard
> +     * and WebSocket VNC listeners with unique socket paths.
> +     */
> +    if (strcmp(fuzz_target->name, "generic-fuzz-vnc") == 0) {

Can generic_fuzz_config.argfunc be used here, instead?
We use  it for virtio_9p to create/share temp directories in
generic_fuzzer_virtio_9p_args. I would rather have one way of
dynamically generating arguments.

-Alex

> +        bool success = true;
> +        success &= replace_socket_placeholder(cmd_line, "VNC_SOCKET_PATH",
> +                                              "/tmp/qemu-vnc.XXXXXX", g_vnc_socket_path);
> +        success &= replace_socket_placeholder(cmd_line, "VNC_WS_SOCKET_PATH",
> +                                              "/tmp/qemu-vnc-ws.XXXXXX", g_vnc_ws_socket_path);
> +
> +        if (!success) {
> +            exit(1);
> +        }
> +
> +        /* Check that placeholders were actually found and replaced */
> +        if (g_vnc_socket_path[0] == '\0' || g_vnc_ws_socket_path[0] == '\0') {
> +            fprintf(stderr, "ERROR: VNC fuzzer is missing a socket placeholder\n");
> +            exit(1);
> +        }
> +
> +        /* Register a single cleanup handler for both sockets */
> +        atexit(cleanup_vnc_sockets);
> +    }
> +



>      /* Split the runcmd into an argv and argc */
>      wordexp_t result;
>      wordexp(cmd_line->str, &result, 0);
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> index ef0ad95712..bd2d875dd8 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -247,6 +247,11 @@ const generic_fuzz_config predefined_configs[] = {
>          .args = "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects = "parallel*",
> +    },{
> +        .name = "vnc",
> +        .args = "-machine q35 -nodefaults "
> +		"-vnc vnc=unix:VNC_SOCKET_PATH,websocket=unix:VNC_WS_SOCKET_PATH",
> +        .objects = "*",
>      }
>  };
>
> --
> 2.51.0.760.g7b8bcc2412-goog
>

