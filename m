Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5229C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 07:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMNVx-00039C-QM; Wed, 26 Jun 2024 03:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMNVu-00038i-7b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMNVr-0000ue-Ui
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 03:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719388578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lc+8tpstCxKuaDLFboxOa1Sphy42QqqTVBQf87MMQo4=;
 b=VxrtwE5ONa7anz7uQilCnaY+aKOtkh7hVvh37LKa8dqMv3WNminu8MbE5KIlOFYR/UnwCR
 pZrCbHdscEthB200Wyi0aQjB2pNhDjBnSat2ZpU0FYmeiAfHAlhlL9fS4fTk80niq7vLVK
 39c+DYxzelsqmJ6XAvVePbJbYNIuNt8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-cfQuKlQrOEiteQlXDiUWpg-1; Wed, 26 Jun 2024 03:56:16 -0400
X-MC-Unique: cfQuKlQrOEiteQlXDiUWpg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42181c64596so39929035e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 00:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719388575; x=1719993375;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lc+8tpstCxKuaDLFboxOa1Sphy42QqqTVBQf87MMQo4=;
 b=t4WRMHHNBv8IQDbTQxkaxvyHkXB3rpJKQpK9UZFoukQDIPyq1otqChy7Z8P+rq0njM
 RCUku9L+yrrHLo7G8ILzPRdNB5eNNsFsK8+tyFytypdOi8zgEsvNl1jv/AQFECyNxB1h
 KoNa/WJ5T1gPTX9dBIN0EuE3qwex2B9Uo42jlROxtn1Qof+pZsDZMhujkKYLLaTkxw5b
 AutNO+g28VncLNViNpKYwq7zXF2/uSBZ3WiHc82ylRp6hkcOeg9KKOiJphv33JDlhEmV
 XegIMP7ABXsv6iZRBNKqw3yUXsLE593NYLxVt95KHYIeyHj9wQ5tejjdJlmtPub1L1cC
 Nf9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5QFRGYZYTeplOpVKtnCIamEsg/ryIALh5DMWjzAt4qHXvQlk8RxGmSwZ4X4kIPMPbkzraN/OFQeIzKnGnx1EIaDbKn9U=
X-Gm-Message-State: AOJu0YwjRTPwl7RyTHrtxU8JK4+QJtfSgsuJQ2EePaLAE3Ra7Z7n6xfE
 AmrEqDQGxEuRyxgKD07C/rxim2vgcm7ha7G58UPS94LkErrvKVKS1K5wWf6JvonjeowQ8aBtOl3
 EhNQ8/glqIpd3lpFXW5cNENET9jQOLrRGyFOeVNz1jvb6EHCVSOBy
X-Received: by 2002:a05:6000:14a:b0:360:96d8:ab7c with SMTP id
 ffacd0b85a97d-366e9464825mr5795132f8f.11.1719388574908; 
 Wed, 26 Jun 2024 00:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+uaF7ObksEzepJy2WqaNit9jFXznnxZ0wsXdNbUKA+ZuchsIqrHY3tfffW4Zw7aSPk7uISA==
X-Received: by 2002:a05:6000:14a:b0:360:96d8:ab7c with SMTP id
 ffacd0b85a97d-366e9464825mr5795118f8f.11.1719388574499; 
 Wed, 26 Jun 2024 00:56:14 -0700 (PDT)
Received: from [10.33.192.191] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a8c8f07sm15018639f8f.110.2024.06.26.00.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 00:56:14 -0700 (PDT)
Message-ID: <c9d65417-0235-4452-8dd5-a756dd2ae9e9@redhat.com>
Date: Wed, 26 Jun 2024 09:56:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 1/2] target/riscv: Add RISC-V CSR qtest support
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, lvivier@redhat.com, pbonzini@redhat.com
References: <20240625153555.104088-1-ivan.klokov@syntacore.com>
 <20240625153555.104088-2-ivan.klokov@syntacore.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240625153555.104088-2-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/06/2024 17.35, Ivan Klokov wrote:
> The RISC-V architecture supports the creation of custom
> CSR-mapped devices. It would be convenient to test them in the same way
> as MMIO-mapped devices. To do this, a new call has been added
> to read/write CSR registers.
> 
> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---
>   target/riscv/cpu.c     | 14 +++++++++++
>   target/riscv/cpu.h     |  3 +++
>   target/riscv/csr.c     | 53 +++++++++++++++++++++++++++++++++++++++++-
>   tests/qtest/libqtest.c | 27 +++++++++++++++++++++
>   tests/qtest/libqtest.h | 14 +++++++++++
>   5 files changed, 110 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 69a08e8c2c..55cc01bfb3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1148,7 +1148,17 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>           }
>       }
>   }
> +#ifndef CONFIG_USER_ONLY
> +static void riscv_cpu_register_csr_qtest_callback(void)
> +{
> +    static gsize reinit_done;
> +    if (g_once_init_enter(&reinit_done)) {
> +        qtest_set_command_cb(csr_qtest_callback);
>   
> +        g_once_init_leave(&reinit_done, 1);
> +    }
> +}
> +#endif
>   static void riscv_cpu_realize(DeviceState *dev, Error **errp)

Could you please add an empty line before the #ifndef and after the #endif 
line? Thanks!


> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c7f6897d78..f8c3ff15a9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1205,6 +1205,33 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>       return 0;
>   }
>   
> +static void qtest_rsp_csr(QTestState *s, uint64_t *val)
> +{
> +    gchar **args;
> +    uint64_t ret;
> +    int rc;
> +
> +    args = qtest_rsp_args(s, 3);
> +
> +    rc = qemu_strtou64(args[1], NULL, 16, &ret);
> +    g_assert(rc == 0);
> +    rc = qemu_strtou64(args[2], NULL, 16, val);
> +    g_assert(rc == 0);
> +
> +    g_strfreev(args);
> +}
> +
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         uint64_t *val)
> +{
> +    qtest_sendf(s, "csr %s 0x%"PRIx64" %d 0x%"PRIx64"\n",
> +                    name, cpu, csr, *val);
> +
> +    qtest_rsp_csr(s, val);
> +    return 0;
> +}
> +
>   void qtest_add_func(const char *str, void (*fn)(void))
>   {
>       gchar *path = g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index c261b7e0b3..53cd8fe9f0 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -577,6 +577,20 @@ uint64_t qtest_rtas_call(QTestState *s, const char *name,
>                            uint32_t nargs, uint64_t args,
>                            uint32_t nret, uint64_t ret);
>   
> +/**
> + * qtest_csr_call:
> + * @s: #QTestState instance to operate on.
> + * @name: name of the command to call.
> + * @cpu: hart number.
> + * @csr: CSR number.
> + * @val: Value for reading/writing.
> + *
> + * Call an CSR function

Maybe mention RISC-V here in the comment?

> + */
> +uint64_t qtest_csr_call(QTestState *s, const char *name,
> +                         uint64_t cpu, int csr,
> +                         unsigned long *val);
> +
>   /**
>    * qtest_bufread:
>    * @s: #QTestState instance to operate on.

For the tests/qtest part:
Acked-by: Thomas Huth <thuth@redhat.com>


