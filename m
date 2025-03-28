Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB73C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 07:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ty44i-0002yK-KM; Fri, 28 Mar 2025 03:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty44g-0002xw-Vp; Fri, 28 Mar 2025 03:24:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=v09i=WP=kaod.org=clg@ozlabs.org>)
 id 1ty44e-000203-CG; Fri, 28 Mar 2025 03:24:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZPBps31kYz4x8R;
 Fri, 28 Mar 2025 18:24:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZPBpp6yMfz4x04;
 Fri, 28 Mar 2025 18:24:02 +1100 (AEDT)
Message-ID: <1c786c2f-1773-43d2-a4ea-531e0373df43@kaod.org>
Date: Fri, 28 Mar 2025 08:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Deprecate Power8E and Power8NVL
To: Aditya Gupta <adityag@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20250328040608.1580515-1-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSBDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQGthb2Qub3JnPsLBeAQTAQIAIgUCW7yjdQIbAwYLCQgHAwIGFQgCCQoL
 BBYCAwECHgECF4AACgkQUaNDx8/77KGRSxAAuMJJMhJdj7acTcFtwof7CDSfoVX0owE2FJdd
 M43hNeTwPWlV5oLCj1BOQo0MVilIpSd9Qu5wqRD8KnN2Bv/rllKPqK2+i8CXymi9hsuzF56m
 76wiPwbsX54jhv/VYY9Al7NBknh6iLYJiC/pgacRCHtSj/wofemSCM48s61s1OleSPSSvJE/
 jYRa0jMXP98N5IEn8rEbkPua/yrm9ynHqi4dKEBCq/F7WDQ+FfUaFQb4ey47A/aSHstzpgsl
 TSDTJDD+Ms8y9x2X5EPKXnI3GRLaCKXVNNtrvbUd9LsKymK3WSbADaX7i0gvMFq7j51P/8yj
 neaUSKSkktHauJAtBNXHMghWm/xJXIVAW8xX5aEiSK7DNp5AM478rDXn9NZFUdLTAScVf7LZ
 VzMFKR0jAVG786b/O5vbxklsww+YXJGvCUvHuysEsz5EEzThTJ6AC5JM2iBn9/63PKiS3ptJ
 QAqzasT6KkZ9fKLdK3qtc6yPaSm22C5ROM3GS+yLy6iWBkJ/nEYh/L/du+TLw7YNbKejBr/J
 ml+V3qZLfuhDjW0GbeJVPzsENuxiNiBbyzlSnAvKlzda/sBDvxmvWhC+nMRQCf47mFr8Xx3w
 WtDSQavnz3zTa0XuEucpwfBuVdk4RlPzNPri6p2KTBhPEvRBdC9wNOdRBtsP9rAPjd52d73O
 wU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhWpOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNL
 SoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZKXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVU
 cP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwpbV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+
 S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc
 9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFUCSLB2AE4wXQkJbApye48qnZ09zc929df5gU6
 hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iSYBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616d
 tb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6gLxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/
 t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1c
 OY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0SdujWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475
 KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/JxIqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8
 o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoX
 ywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjKyKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0
 IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9jhQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Ta
 d2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yops302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it
 +OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/pLHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1n
 HzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBUwYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVIS
 l73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lUXOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY
 3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfAHQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4Pls
 ZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQizDiU6iOrUzBThaMhZO3i927SG2DwWDVzZlt
 KrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gDuVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250328040608.1580515-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=v09i=WP=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.083, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/28/25 05:06, Aditya Gupta wrote:
> Power8E and Power8NVL variants are not of much use in QEMU now, and not
> being maintained either.
> 
> Deprecate the 8E and 8NVL variants.
> 
> After deprecation, QEMU will print a warning like below when the
> CPU/Chips are used:
> 
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8nvl -nographic
>      qemu-system-ppc64: warning: CPU model power8nvl_v1.0-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M powernv8 --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
>      $ ./build/qemu-system-ppc64 -M pseries --cpu power8e -nographic
>      qemu-system-ppc64: warning: CPU model power8e_v2.1-powerpc64-cpu is deprecated -- CPU is unmaintained.
>      ...
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Please update the documentation too.

https://qemu.readthedocs.io/en/v9.2.0/about/deprecated.html


> 
> ---
> Cover Letter
> ============
> 
> For me, Power8NVL won't even boot, getting stuck somewhere in early boot
> in OPAL.

Looks like a skiboot issue. skiboot-v6.4 works fine.

> 
> No direct way to deprecate the pnv chips, a field like deprecation_note
> could be added, but felt not needed as the chip will only get used if
> the user requests corresponding 8E / 8NVL CPU, which will print
> deprecation warning.
> 
> Also, no separate pnv machine for 8E and 8NVL, user has to pass --cpu,
> which will throw the deprecation warning. So just deprecating CPUs should
> be enough.
> 
> Power8 itself also can be a candidate for deprecation if not needed ?

That's a bit early.

run 'qemu-system-ppc64  -cpu ?' to see which CPUs are currently
available.


Thanks,

C.



> Will follow up if decided.
> ---
> ---
>   target/ppc/cpu-models.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index ece348178188..6f2062e2c484 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -32,17 +32,22 @@
>   /* PowerPC CPU definitions                                                 */
>   #define POWERPC_DEF_PREFIX(pvr, svr, type)                                  \
>       glue(glue(glue(glue(pvr, _), svr), _), type)
> -#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +#define POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, _is_deprecated) \
>       static void                                                             \
>       glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_init)            \
>       (ObjectClass *oc, void *data)                                           \
>       {                                                                       \
>           DeviceClass *dc = DEVICE_CLASS(oc);                                 \
> +        CPUClass *cc    = CPU_CLASS(oc);                                    \
>           PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);                       \
>                                                                               \
>           pcc->pvr          = _pvr;                                           \
>           pcc->svr          = _svr;                                           \
>           dc->desc          = _desc;                                          \
> +                                                                            \
> +        if (_is_deprecated) {                                               \
> +            cc->deprecation_note = "CPU is unmaintained.";                  \
> +        }                                                                   \
>       }                                                                       \
>                                                                               \
>       static const TypeInfo                                                   \
> @@ -63,6 +68,12 @@
>       type_init(                                                              \
>           glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_register_types))
>   
> +#define POWERPC_DEF_SVR(_name, _desc, _pvr, _svr, _type)                    \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, _svr, _type, false)
> +
> +#define POWERPC_DEPRECATED_CPU(_name, _pvr, _type, _desc)                   \
> +    POWERPC_DEF_SVR_DEPR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type, true)
> +
>   #define POWERPC_DEF(_name, _pvr, _type, _desc)                              \
>       POWERPC_DEF_SVR(_name, _desc, _pvr, POWERPC_SVR_NONE, _type)
>   
> @@ -722,11 +733,11 @@
>                   "POWER7 v2.3")
>       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
> -    POWERPC_DEF("power8e_v2.1",  CPU_POWERPC_POWER8E_v21,            POWER8,
> +    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
>                   "POWER8E v2.1")
>       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
>                   "POWER8 v2.0")
> -    POWERPC_DEF("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10,         POWER8,
> +    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
>                   "POWER8NVL v1.0")
>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")


