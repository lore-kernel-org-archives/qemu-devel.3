Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D23DCE7B1E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:20:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvZt-0004jP-Ha; Fri, 14 Nov 2025 10:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vJvKM-0006Ck-7S
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:03:15 -0500
Received: from esa3.hc2706-39.iphmx.com ([68.232.154.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vJvKF-0005Oc-Nk
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:03:05 -0500
X-CSE-ConnectionGUID: 6gbJ0jy0Rj+24iPmYtPMBQ==
X-CSE-MsgGUID: oJWuWsL7SMOH9i79QsZvFg==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.222.71
X-IronPort-MID: 89931031
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ha/2hqlSuxvUBnJs6phM2EXo5gzWJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJUGnSafmPYGr0fownbovj8k0G7ZHQyoQwGwo6+HxhES4T+ZvOCOrCEkqhZCn6wu8v7a5EA
 2fyTvGacajYm1eF/k/F3oDJ9Cc6jefTAOKgVIYoAwgpLSd8UiAtlBl/rOAwh49skLCRDhiE/
 Nj/uKUzAnf8s9JPGjxSsvPrRC9H5qyo5WpB5wBmP5ingXeF/5UrJMNHTU2OByagKmVkNrbSb
 /rOyri/4lTY838FYvu5kqz2e1E9WbXbOw6DkBJ+A8BOVTAb+0Teeo5iXBYtQR4/Zwehxrid+
 /0U3XCEcjrFC4WX8Agrv7u0JAklVUFO0OevzXFSKqV/xWWfG5fn66wG4E3boeT0Uwu4aI1D3
 aVwFdwDUvyMr7y5ypDjSPg0vMZgdpXqBIYupklF5wiMWJ7KQbibK0nLzdpR3TN1m8kXWPiBP
 owWbj1gaBmGaBpKUrsVIMhmzaH42z+lKWce9wv9SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jKXrj+gWkpDXDCZ4T2nzW+TncuQpgbceNMTS+yB7cx0rlLGkwT/DzVTDzNXu8KRk0O7RpdTJ
 lIZ/gIoqq498lHtScPyNyBUu1aBtx8YHsdZSqg0t1jLxa3T7AKUQGMDS1atdeAbiSP/fhRzv
 nehlc6vCDBy2IB5g1rDpt94cRva1fApEFI/
IronPort-HdrOrdr: A9a23:6th9r676n8xzYTYJQgPXwDLXdLJyesId70hD6qm+c20oTiX4rb
 HQoB1/73XJYVkqKQgdcLy7Scy9qDbnhPhICOoqTNCftWvdyRCVxehZhOOIsl6QeREWtNQtsZ
 uIGJIOcuEYY2IK8PrS0U2XF5IOzNGb7Luln47lvg9QZDAvRaUlwQkRMGmm+45NKDWux6BVKH
 NR3Kt6jgvlX0grReKGIVRAd9T/hrTw5ezbiNc9aX4a1DU=
X-Talos-CUID: 9a23:sOF4gW2sKf0lJ+MK/YmCx7xfRM8vUCXf3S/qIQziVWdRTYyJcXq6wfYx
X-Talos-MUID: 9a23:nLRsJAlaiDPPAAmDxWxrdnplFvh13L+KV3sotrVXupbVDDdCJRmS2WE=
Received: from mail-ua1-f71.google.com ([209.85.222.71])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 14 Nov 2025 10:02:34 -0500
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9371b5e8035so1527560241.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1763132554; x=1763737354; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Eqeh0h8Y1gcFAqww7tf21PacAjZhZoRuYPpXriXHp6A=;
 b=KX88IRfKBlQjZvrCR/QbE32JcZz7H7iUYH2TP2CPsPdyOVOQxb7UYfeLe2JLpGLOfe
 bQdbrW/EkNi6+rX8f/SmQ8FreLEZHQq80z6+ZYF6uEXcpFCkrmuqS3Z/RYgkBfMxJsPq
 ITJrKNUGbqC/+sLCE7tWNY9UJjDDvFTgbuCIZJ2+gdhgbpCfE9Ohc4UqR9pCRmqd76Ix
 D2N7FOEFKM5+YE7ThbDyPRubKZ5MlI/iDoQ+G7UlUFSm0SFeRZY6qVimTbNXXyvCYB34
 xYPNzaORlBzL0vkZGKh1lowNMarbIJnQ97Ti0re3uSI0//WEG2yWMAWcA1oTiXW7MEs3
 mzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763132554; x=1763737354;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eqeh0h8Y1gcFAqww7tf21PacAjZhZoRuYPpXriXHp6A=;
 b=tyHxVpdVI4y2Kb1wjP+pCaAs2bl7iNEA+Uq+CESUXNPfdbERxj/Op1yyAANj12fOaY
 SyeDdGAcOcGiXgyyWnbS7/KqaCKklgz7qb30wbgJHxcKoQLBMc4ZkDg/cqIFyWle2WbZ
 4abYUjs380+uqsNjIwPz54K8MGlwoaqsYZBYEs0uxWOhBeXpF0XeKg98iJJnSqKJ0Gxo
 dxlrGdqbaNTcJFzEVm/WhD50NVd2fc6inaIwFFSzBVSjYpyNuSTbGyZLY3lKVlBZ928I
 gnOeSYn57/CmJ1L1nGQkh4a3/p6L4e1clt0sZxy8501xjCSVWY6zol4qsgAqN46fdUjx
 BGMA==
X-Gm-Message-State: AOJu0Yzne0RUhI1qXlpfBr2c4SGcZwsfuQaTTeB1ONVYB0dVaK83bbHb
 XYUNHogzbKAqaK27z+30PIaCimHqfo6xne3MwKR1FcD5JyfkZ4VbvMVNJ9oYg1kT7tD4yM4oY8r
 23c4VybcSH6ZVvR+aHFsgLTUcKQZtPoVc9Hj931AsJcts5IMZIdOUZ+9wAjQ55m1hwWk/ZqU8PG
 3ct05wzU35SVIu4SXvBl6qb3Vz7bSb+et4Mto9gaOMVBmC
X-Gm-Gg: ASbGncs9BnLPdZD9L2/ZP9igD7KvZbVt8mcvPDB4CDaWpXYfMhi53KDFcH00ogqUGQM
 nQUwA3bh/DmG5L/uYN+zqnUtM4HonuQLPKIS5c8ihLy0yyp+9gYNEbBCs8D1z+mlQhneyGWvQhX
 uwdUt1CECZ7pn0WOEmRzjkWhaoMmmU7TXm8LzOYJaQkR2sSn3zKnTZOSeR3Xuati/u8w==
X-Received: by 2002:a05:6102:50a0:b0:5df:c15b:4feb with SMTP id
 ada2fe7eead31-5dfc5b6fe6dmr1256108137.26.1763132535271; 
 Fri, 14 Nov 2025 07:02:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFkP8Xo8a35ChJsyj2CRpolPJ9GTZpcDFIJl8+KcLaKpCFrmzmLi1gTQjFXp876LrRXFSbWxcriD5bAEhIK9k=
X-Received: by 2002:a05:6102:50a0:b0:5df:c15b:4feb with SMTP id
 ada2fe7eead31-5dfc5b6fe6dmr1254661137.26.1763132527120; Fri, 14 Nov 2025
 07:02:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Nov 2025 09:02:06 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Nov 2025 09:02:06 -0600
From: Alexander Bulekov <alxndr@bu.edu>
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
 <20251112003637.1984547-1-navidem@google.com>
 <20251112003637.1984547-2-navidem@google.com>
MIME-Version: 1.0
In-Reply-To: <20251112003637.1984547-2-navidem@google.com>
Date: Fri, 14 Nov 2025 09:02:06 -0600
X-Gm-Features: AWmQ_bnAMNnWizwZbsCYUMf_Ck2zXPE4eFQLYxE0zgrz_KB6cbf_xuC8gFcGDSc
Message-ID: <CAHUE=o8u1snmMBGHExoZix3vFY6Y8J_jWdYKNDiuMd6jvw0qzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com, 
 bsd@redhat.com, stefanha@redhat.com, farosas@suse.de, darren.kenny@oracle.com, 
 Qiuhao.Li@outlook.com, lvivier@redhat.com, zsm@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=68.232.154.118; envelope-from=alxndr@bu.edu;
 helo=esa3.hc2706-39.iphmx.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_LOW=-0.7,
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

On 251112 0036, Navid Emamdoost wrote:
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

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

> ---
>  tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> index ef0ad95712..9c46e106a4 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -29,6 +29,52 @@ static inline gchar *generic_fuzzer_virtio_9p_args(void){
>      "writeout=immediate,fmode=0600,dmode=0700", tmpdir);
>  }
>
> +/*
> + * Global variables and cleanup handler for VNC fuzzer sockets.
> + * These are needed because the socket paths must be available at exit.
> + */
> +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
> +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
> +
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
> +/*
> + * Dynamically generate VNC arguments with unique unix socket paths.
> + * This allows multiple fuzzing jobs to run in parallel without conflict.
> + */
> +static inline gchar *generic_fuzzer_vnc_args(void)
> +{
> +    static bool cleanup_registered = false;
> +    int fd;
> +
> +    strcpy(g_vnc_socket_path, "/tmp/qemu-vnc.XXXXXX");
> +    fd = g_mkstemp(g_vnc_socket_path);
> +    g_assert_cmpint(fd, !=, -1);
> +    close(fd);
> +
> +    strcpy(g_vnc_ws_socket_path, "/tmp/qemu-vnc-ws.XXXXXX");
> +    fd = g_mkstemp(g_vnc_ws_socket_path);
> +    g_assert_cmpint(fd, !=, -1);
> +    close(fd);
> +
> +    if (!cleanup_registered) {
> +        atexit(cleanup_vnc_sockets);
> +        cleanup_registered = true;
> +    }
> +
> +    return g_strdup_printf("-machine q35 -nodefaults "
> +                           "-vnc vnc=unix:%s,websocket=unix:%s",
> +                           g_vnc_socket_path, g_vnc_ws_socket_path);
> +}
> +
>  const generic_fuzz_config predefined_configs[] = {
>      {
>          .name = "virtio-net-pci-slirp",
> @@ -247,6 +293,10 @@ const generic_fuzz_config predefined_configs[] = {
>          .args = "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects = "parallel*",
> +    },{
> +        .name = "vnc",
> +        .argfunc = generic_fuzzer_vnc_args,
> +        .objects = "*",
>      }
>  };
>
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
>

