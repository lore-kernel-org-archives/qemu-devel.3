Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A538CC54E69
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 20:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmJkM-0004uv-Ha; Mon, 18 Mar 2024 16:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJkJ-0004s3-Lk
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:38:12 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rmJk7-0003d0-18
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 16:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710794274; x=1711399074; i=deller@gmx.de;
 bh=6mRGcJbchJZP/Ou/8LVNgj8pHdGBYCYeBzVwGkTRE4U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=jTcLxkcXtHgHpwekOzhg7exdpz8GBuZ1yCd4+88YmN+FXteK2BRbBaaIGyyl+gSd
 /nq5k8Xe+XgKQb897ouukRqWRsF2OZMXAC2rodooyUNcsxl0bgdTRCc60t/u0hDUc
 CNkzZuP325UwmyuFOnXUMM7YC4bZGT3heidIV9IFvWVs2yOpbrta/WZEUAMDNPPCt
 p9DR1XtvhVG+jEMZXH7gJTmvkb1fwtzK4negVhhKg2paYXm8heTaPbTMcN12aEopi
 2Aegi+Jv4HC46rPQFbAJnQCX+gB4rEfYfqaR6Ckxz3iJhm3CanAwfYIbwgB1gNnU/
 +zulXYIQ1NjZ3R1JUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.237]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1rQx8q0ihu-00MaDj; Mon, 18
 Mar 2024 21:37:54 +0100
Message-ID: <2318429f-c8f5-41ed-b21b-e47f5d8f3759@gmx.de>
Date: Mon, 18 Mar 2024 21:37:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/hppa: fix access_id check
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-4-svens@stackframe.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240317221431.251515-4-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YsZeHSQOPsSE1FITuxlIU5uDhHBHxZcu6N21zyjjClvohdgbjN8
 vmIQXEdBm80uC3iXhJvb/+oizT6vbQICJTVUjP175+vxYGiJ6yIFvqrBfwJPbF0vIx8kbTa
 Eue2axABxUipzedANPPWJIlIyxpOgL9E6rCnmb2Bgs7bz8H5/0iLHVAfpMIdOObQvj5iFde
 +O4VYJRLQq1XakHyYfV8Q==
UI-OutboundReport: notjunk:1;M01:P0:gSKgVNjkUNE=;se2pOlCWYrf4lPzrYrQaCnEn8Z/
 tPN8USJ5AK4d/rnW1w3W16I7Z9j6tZnkgui0Y6SLfXSaWeZX2EmAZeAVdFzMpBzFQ/W4pM0RI
 NhjX8Clk3KLWv7bDuVvbPL1eYFdRBtNrrtQKuxwfz3QBfmDQVYMohSSWp/mb9mN6EmGJeNFHt
 BUD+90KyVe0rlQwRJgWsmREhuTqGFCE+56oD3MPMafEatCf4h+7RgWLOVGw6uJybckStCs68C
 y+CmBsQRFz4RNUHzRPim6rKaK58dNbMVwtv6lrhbP9zNHQvrRnKNjFdZiWG2WtVNWp9mkMYRX
 /phWGSUHhVxI0EyE6m+mrLOzmighTZz3I67+Tdtv2o0e/OvnYo745FxtFGSIsRoGVCOBU+1Xw
 hoKVq+0TSVjxhAXg0rGv1sX35c0j/bhh/BXh6PkmQJ0ZyCrnPd3kRW3qgIWwvlL7xt4qddMqM
 XIYVtG50cPboheDj3PP9EdQQ97YpMoU8+y+nrI+tcQWMZxsw/vcc9+izahdW+CUp0VNsKoFVX
 e/+AV1Div41YoZDKam7CKdUCtXzLP+ZbDZJdhDMPyB1EX+9TauWcDoaSsT2lG0AWga/8+ngMk
 h8qIzEr7HD/Ury3qO+kbqEq/blxRrSNhJKPr84gTc8lMTiyknXd8WraK0owVzO/DwC1aLmUlU
 n8f3SztnXz3pri4zgzWEZYsIPgqiWARlGc68wrX7rfgTF9cevUHCsI9l7mn1qt9XziYdNcZ1f
 NcmWqq3/Yc/ui7keyGu8/aNvixjBnA/uB5RoF+aJDQ13Ajcwr1X5GFKnD1g5UfjL1MkgOru6f
 g9KVW0tGo9aiNh0Wx8TBcAXme4zdttU8B3+1v59v67s90=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/17/24 23:14, Sven Schnelle wrote:
> PA2.0 provides 8 instead of 4 PID registers.
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>

Reviewed-by: Helge Deller <deller@gmx.de>
with a few comments below...

Helge

> ---
>   roms/SLOF                |  2 +-
>   target/hppa/mem_helper.c | 67 +++++++++++++++++++++++++++++++++++-----
>   2 files changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/roms/SLOF b/roms/SLOF
> index 3a259df244..6b6c16b4b4 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
> +Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d

this doesn't belong here.


> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index 80f51e753f..e4e3f6cdbe 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -152,6 +152,59 @@ static HPPATLBEntry *hppa_alloc_tlb_ent(CPUHPPAStat=
e *env)
>       return ent;
>   }
>
> +static uint32_t get_pid(CPUHPPAState *env, int num)
> +{
> +    const struct pid_map {
> +        int reg;
> +        bool shift;

does it makes sense to condense it, e.g.:
  +        unsigned char reg:7,
  +        unsigned char shift:1;

Helge


> +    } *pid;
> +
> +    const struct pid_map pids64[] =3D {
> +        { .reg =3D 8,  .shift =3D true  },
> +        { .reg =3D 8,  .shift =3D false },
> +        { .reg =3D 9,  .shift =3D true  },
> +        { .reg =3D 9,  .shift =3D false },
> +        { .reg =3D 12, .shift =3D true  },
> +        { .reg =3D 12, .shift =3D false },
> +        { .reg =3D 13, .shift =3D true  },
> +        { .reg =3D 13, .shift =3D false }
> +    };
> +
> +    const struct pid_map pids32[] =3D {
> +        { .reg =3D 8,  .shift =3D false  },
> +        { .reg =3D 9,  .shift =3D false  },
> +        { .reg =3D 12, .shift =3D false  },
> +        { .reg =3D 13, .shift =3D false  },
> +    };
> +
> +    if (hppa_is_pa20(env)) {
> +        pid =3D pids64 + num;
> +    } else {
> +        pid =3D pids32 + num;
> +    }
> +    uint64_t cr =3D env->cr[pid->reg];
> +    if (pid->shift) {
> +        cr >>=3D 32;
> +    } else {
> +        cr &=3D 0xffffffff;
> +    }
> +    return cr;
> +}
> +
> +#define ACCESS_ID_MASK 0xffff
> +
> +static bool match_prot_id(CPUHPPAState *env, uint32_t access_id, uint32=
_t *_pid)
> +{
> +    for (int i =3D 0; i < 8; i++) {
> +        uint32_t pid =3D get_pid(env, i);
> +        if ((access_id & ACCESS_ID_MASK) =3D=3D ((pid >> 1) & ACCESS_ID=
_MASK)) {
> +            *_pid =3D pid;
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>   int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_i=
dx,
>                                 int type, hwaddr *pphys, int *pprot,
>                                 HPPATLBEntry **tlb_entry)
> @@ -227,15 +280,13 @@ int hppa_get_physical_address(CPUHPPAState *env, v=
addr addr, int mmu_idx,
>       /* access_id =3D=3D 0 means public page and no check is performed =
*/
>       if (ent->access_id && MMU_IDX_TO_P(mmu_idx)) {
>           /* If bits [31:1] match, and bit 0 is set, suppress write.  */
> -        int match =3D ent->access_id * 2 + 1;
> -
> -        if (match =3D=3D env->cr[CR_PID1] || match =3D=3D env->cr[CR_PI=
D2] ||
> -            match =3D=3D env->cr[CR_PID3] || match =3D=3D env->cr[CR_PI=
D4]) {
> -            prot &=3D PAGE_READ | PAGE_EXEC;
> -            if (type =3D=3D PAGE_WRITE) {
> -                ret =3D EXCP_DMPI;
> -                goto egress;
> +        uint32_t pid;
> +        if (match_prot_id(env, ent->access_id, &pid)) {
> +            if ((pid & 1) && (prot & PROT_WRITE)) {
> +                prot &=3D ~PROT_WRITE;
>               }
> +        } else {
> +            prot =3D 0;
>           }
>       }
>


