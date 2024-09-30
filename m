Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA81CF6499
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFNA-0006AM-E5; Mon, 30 Sep 2024 08:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1svFN8-00068O-3W; Mon, 30 Sep 2024 08:19:26 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1svFN6-0001uf-4K; Mon, 30 Sep 2024 08:19:25 -0400
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MBmI6-1slO08014m-00HLUf; Mon, 30 Sep 2024 14:18:36 +0200
Message-ID: <c1eff411-53f7-483c-83e1-ac09cb6b4c89@vivier.eu>
Date: Mon, 30 Sep 2024 14:18:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/22] linux-user/hppa: fix -Werror=maybe-uninitialized
 false-positive
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jesper Devantier <foss@defmacro.it>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Helge Deller <deller@gmx.de>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-16-marcandre.lureau@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20240930081458.1926382-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kwnG7blrFh+JrRgtBuVHxmx+jyBViv1CBKH9SHdP9TISfwxvd0H
 JRA9bUOoDYRLr9uXqd2FSGFk7VCbQX7Ow8pZigCuQQY5IQG1wNvUXAZG+zZLMKQShXXHZZB
 f9a5IvjchGP6pTB75kHB4E0jw1wwuMjWo1zlbYs/W5QiqQI0+9jNWrJxhvF3luVcBP8mcED
 g/zocLGWJbTiDTJfZD5dA==
UI-OutboundReport: notjunk:1;M01:P0:NaN3JudD2w8=;J4d1S52otg5qA+cV+zx8WbhAzze
 dct1u1bNvVCa+g3sMForsYSKvYhyZo8mq3CREuGsNB/aU+j5yEAowlOksiEWlSWc0Ha6Xoj5d
 o1fZjXnjPSPE+bY01rqVfom+kUV/s3X3ENjgzX7wMmrelPOFzRgRF76Pm8mOVs7x5lJyDdgHe
 AbPPdqb+oeOHk+hi2jP68lEH7WTZW3pDN/zBykmjlmlbgN+dNHBIg1+I06RQQ4Xnw5YC6iGHd
 VLW/giS8Hwlq3OIR70JaBQ9yxZuu1za/wG6eUOd/6hjNlhW8WuddPpzML6U4CiWr38GsulOBc
 ss9eHghds9hQfca+KnTSV/KOqJRBgTBYNMxo1AQ5SWjXZ75MIz8DsNHwXhru9WOClvxT5A2WU
 pZu8mG0mrnGAZgs+l2gxM6b/bRyxyVABFRMfpRU1f1/0dAVjFyWAqsEFwQC9Wrcndhyj79hCO
 VXzbxY+idfQ2oRKzjakIldPR0S/rZ3Q1HnPK1tUhxEfbrDBGOM89LQ+fTVPFXUaLQuj0pbEaX
 KQmtaJeWAHIfFVm4YHXKig4iGRRYg0ipb3C8pNRKiv2n9kiQ0pGJSQwTwnRh/Y+eXmi54V0uw
 BTlRAc5N6FjJOXVgK2xSAHCFY+UHcptagi8o7sT+dbaN5VmJxj86rEcWTOXEEyDd8cbf6LP0a
 bWO979TjG1K9jnBuuCDs37frc3oVWLLxzwEDDbsQV1PDjGsno0wwVwfz6S5lOBU4orWVIS4mX
 uPPR4nck1fZ5JBcjF5BVHfiPuVk41qV0A==
Received-SPF: pass client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

CC Helge Deller

Le 30/09/2024 à 10:14, marcandre.lureau@redhat.com a écrit :
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ../linux-user/hppa/cpu_loop.c: In function ‘hppa_lws’:
> ../linux-user/hppa/cpu_loop.c:106:17: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>    106 |     env->gr[28] = ret;
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   linux-user/hppa/cpu_loop.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
> index bc093b8fe8..f4da95490e 100644
> --- a/linux-user/hppa/cpu_loop.c
> +++ b/linux-user/hppa/cpu_loop.c
> @@ -43,7 +43,7 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
>           old = tswap32(old);
>           new = tswap32(new);
>           ret = qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, new);
> -        ret = tswap32(ret);
> +        env->gr[28] = tswap32(ret);
>           break;
>   
>       case 2: /* elf32 atomic "new" cmpxchg */
> @@ -64,19 +64,19 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
>               old = *(uint8_t *)g2h(cs, old);
>               new = *(uint8_t *)g2h(cs, new);
>               ret = qatomic_cmpxchg((uint8_t *)g2h(cs, addr), old, new);
> -            ret = ret != old;
> +            env->gr[28] = ret != old;
>               break;
>           case 1:
>               old = *(uint16_t *)g2h(cs, old);
>               new = *(uint16_t *)g2h(cs, new);
>               ret = qatomic_cmpxchg((uint16_t *)g2h(cs, addr), old, new);
> -            ret = ret != old;
> +            env->gr[28] = ret != old;
>               break;
>           case 2:
>               old = *(uint32_t *)g2h(cs, old);
>               new = *(uint32_t *)g2h(cs, new);
>               ret = qatomic_cmpxchg((uint32_t *)g2h(cs, addr), old, new);
> -            ret = ret != old;
> +            env->gr[28] = ret != old;
>               break;
>           case 3:
>               {
> @@ -97,13 +97,13 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
>                   }
>                   end_exclusive();
>   #endif
> +                env->gr[28] = ret;
>               }
>               break;
>           }
>           break;
>       }
>   
> -    env->gr[28] = ret;
>       return 0;
>   }
>   

Did you try to put a g_assert_not_reached() in a "default:" for "switch(size)"?
This should help the compiler to know that "env->gr[28] = ret;" will not be reached if ret is not set.

Thanks,
Laurent


