Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4E7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVr1-0000Re-HD; Mon, 26 Feb 2024 02:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reVqz-0000R9-B9
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:56:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1reVqv-0008K2-Ah
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:56:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708934204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uGsOqpTP6osYG8FaocPDaPvgSl2PY/mJXXIgeUP4uG4=;
 b=hGhOMAejon02l2Stue10AP4X4PgdD7isIagVdS3kccolQBFrYU0dpTAR5WRXu5ct3sH+P3
 1gOHrUyT5xl3YEzpkuIVgKqtYBXgPi0AjgwWdXgyoEztz0pdmfomicGKaHBc7TEGSB2Ybb
 9qmM5Qvf6LmhfeJCuS+lTE1mTaRSrSs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-Lyv2Yhh2M9aYOaSE9LHoWg-1; Mon, 26 Feb 2024 02:56:40 -0500
X-MC-Unique: Lyv2Yhh2M9aYOaSE9LHoWg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d2892cf396so6854121fa.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 23:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708934199; x=1709538999;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uGsOqpTP6osYG8FaocPDaPvgSl2PY/mJXXIgeUP4uG4=;
 b=JdHI+6lcxTNsAYG2pCWEM470SDsUxTWg4EMURS5mV9Nle5NbxONr+U8mVG1zqx4ERh
 KWZ7+f+Yz98vhinmCvWSA0hTXTgVn4tR429Z011RTb8WE6E2xGt2D5UhItxG8+f1TFjx
 ed0aT4P0lC3b7m6V9ncgz0zltlk6qdAtwvFbXRjAZJvvMI9UsPTcimyVXjIMdWNMyupG
 G3jt2xR7KIuob/yPSuQDSzL9ulY7GsDATNLYD85D/jaJJSOc7pIPDrm1fzYkhiYCOnBI
 FbNrRUOHM38vYZKjn0OxwYExJUTnIW4v1SJNB/afRy22TJCoa7x5A6y+6BSigexBmsyo
 RP5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUATO57CA48MRIR/o2uEVSGSyA4UVTE6o1VA+7zXWS3NSOW8SxhGV2Wa1TY36uUZq/l92NFn5q9DHSPG3UHyi1XIvmqFaw=
X-Gm-Message-State: AOJu0YyFlBjW22pf1v98D8FatJ17gjfyOvsS5wLZo5qcZJgHp3arg0j0
 lw24UEwWOgaMRSQ4lJeDVqRRikJrRmnm+of4J0NUkz7My06yF4KVjvapjRvd3MLGNDWCNhhhLrd
 kIKJMh9tBzPMWGGBldagP/LEPRZajleBRZVdmc50JR1E2zpiIo8eb
X-Received: by 2002:a05:651c:128d:b0:2d2:3186:4597 with SMTP id
 13-20020a05651c128d00b002d231864597mr3001048ljc.25.1708934199323; 
 Sun, 25 Feb 2024 23:56:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVrJSl69NMMP8r1bTCd+IjVtKrAhRz6foZ6r7p7ogRatD8nW7X9xz4hmsdYa+SSOzNbeXSWQ==
X-Received: by 2002:a05:651c:128d:b0:2d2:3186:4597 with SMTP id
 13-20020a05651c128d00b002d231864597mr3001039ljc.25.1708934198999; 
 Sun, 25 Feb 2024 23:56:38 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 g6-20020a7bc4c6000000b0040d5ae2906esm11033407wmk.30.2024.02.25.23.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 23:56:38 -0800 (PST)
Message-ID: <ef2f00bc-e920-485f-ba6c-c94c5aa5d615@redhat.com>
Date: Mon, 26 Feb 2024 08:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tests/qtest: Reorganize common code in ivshmem-test
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org
Cc: lvivier@redhat.com, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 pbonzini@redhat.com, anton.kochkov@proton.me, richard.henderson@linaro.org,
 peter.maydell@linaro.org
References: <20240222222218.2261956-1-gustavo.romero@linaro.org>
 <20240222222218.2261956-6-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240222222218.2261956-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/02/2024 23.22, Gustavo Romero wrote:
> This commit reorganizes the ivshmem-test qtest by moving common structs,
> functions, and code that can be utilized by other ivshmem qtests into
> two new files: ivshmem-utils.h and ivshmem-utils.c.
> 
> Enum Reg, struct ServerThread, and mktempshm() have been relocated to
> these new files. Two new functions have been introduced to handle the
> ivshmem server start/stop: test_ivshmem_server_{start,stop}.
> 
> To accommodate the new way for starting/stopping the ivshmem server,
> struct ServerThread now includes two new members: 'server', previously
> present but not a member of any struct; and 'status', a new member of a
> new type, ServerStartStatus, used to track and handle service
> termination properly.
> 
> Additionally, a new function, mktempsocket(), has been added to help
> create a unix socket filename, similar to what mktempshm() does for the
> creation of a shm file.
> 
> Finally, the ivshmem-test qtest has been adapted to use the new ivhsmem
> utils. Adjustments in that sense have also been made to meson.build;
> also 'rt' have been removed as a lib dependency for ivhsmem-test.c.
> 
> Two lines unrelated to these changes have had their line indentation
> also fixed in meson.build.
> 
> Message-ID: <20231127052024.435743-3-gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
...
> diff --git a/tests/qtest/ivshmem-utils.c b/tests/qtest/ivshmem-utils.c
> new file mode 100644
> index 0000000000..c2fc3463dd
> --- /dev/null
> +++ b/tests/qtest/ivshmem-utils.c
> @@ -0,0 +1,156 @@
> +/*
> + * Common utilities for testing ivshmem devices
> + *
> + * SPDX-FileCopyrightText: 2012 SUSE LINUX Products GmbH
> + * SPDX-FileCopyrightText: 2021 Red Hat, Inc.
> + * SPDX-FileCopyrightText: 2023 Linaro Ltd.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "ivshmem-utils.h"
> +
> +gchar *mktempshm(int size, int *fd)
> +{
> +    while (true) {
> +        /* Relative path to the shm filesystem, e.g. '/dev/shm'. */
> +        gchar *shm_rel_path;
> +
> +        shm_rel_path = g_strdup_printf("/ivshmem_qtest-%u-%u", getpid(),
> +                                       g_test_rand_int());
> +        *fd = shm_open(shm_rel_path, O_CREAT | O_RDWR | O_EXCL,
> +                       S_IRWXU | S_IRWXG | S_IRWXO);
> +        if (*fd > 0) {
> +            g_assert(ftruncate(*fd, size) == 0);
> +            return shm_rel_path;
> +        }
> +
> +        g_free(shm_rel_path);
> +
> +        if (errno != EEXIST) {
> +            perror("shm_open");
> +            return NULL;
> +        }
> +    }
> +}
> +
> +gchar *mktempsocket(void)
> +{
> +    gchar *server_socket_path;
> +
> +    server_socket_path = g_strdup_printf("%s/ivshmem_socket_qtest-%u-%u",
> +                                         g_get_tmp_dir(), getpid(),
> +                                         g_test_rand_int());
> +    return server_socket_path;
> +}

You could simplify that to:

     return g_strdup_printf("%s/ivshmem_socket_qtest-%u-%u",
                            g_get_tmp_dir(), getpid(),
                            g_test_rand_int());

Anyway:
Acked-by: Thomas Huth <thuth@redhat.com>


