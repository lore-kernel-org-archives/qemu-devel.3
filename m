Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A18CC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 10:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl44g-0005vU-UX; Thu, 20 Feb 2025 05:46:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl44O-0005uY-8M
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:46:25 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tl44L-0000CR-Jo
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 05:46:15 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MK3a4-1u3Hfc3XSQ-00Hkxy; Thu, 20 Feb 2025 11:46:06 +0100
Message-ID: <f92dc2c0-eca2-4a14-a024-d0287c619b77@vivier.eu>
Date: Thu, 20 Feb 2025 11:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] binfmt: Shuffle things around
To: Andrea Bolognani <abologna@redhat.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 David Abdurachmanov <davidlt@rivosinc.com>
References: <20250127182924.103510-1-abologna@redhat.com>
 <20250127182924.103510-2-abologna@redhat.com>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 xsFNBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABzSJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+wsF4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +c7BTQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAcLBXwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
In-Reply-To: <20250127182924.103510-2-abologna@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JVe0ZHeFQHii7TcK7KthgJ0wF/m/Ybd3SV2h9emh/0pyuB8duDM
 2tj6jcv9ltvXXWucRmyli6nZyWGLiceZ/9ENRgC4m3XvUARdVQJP9/xoiHQFnVTC3CPWgAu
 3DCq6fRHCsssCYN3gOihG5YqzH1Fm/tNkfKEuFywDVRMcCehrk9lY3zUNbEaIyCM3nNntqQ
 2j/Dt93ayIiWVjcHxjVrQ==
UI-OutboundReport: notjunk:1;M01:P0:9ZoF9LQM4U0=;v/FA9SUvDMeGBbzGrOYksRBUV/D
 oRrjjeAH/wTMqtKo6VePaPLux2N5UVWRfSqyANkxrziDa4pV7yzj3EtqbjTT8KSsYmkbnhGTi
 3wG4qDtkEG7v6UQ/+Lehb3CKer30rhpfQiGPHUXo8FvLwVcwLnoX6UGPKwSvGZyZ8P6JFy2Ew
 PV/BmstjPX8ueiw6aw2oigZeZcXW9BKfDVM+dgnWWTigUBcOxhzqVodyDX/2OKYQ8Hd4X8UkR
 klqxSa9B5Mrr49YsExZYj8u/dc7ddkHE8mE8tnsPS0Ya3xn9BQj2LGItK766zRpNDPZbAhZqK
 X+Ne+xcxY12JQBKeZ/OxJCBOsoz5uqC4CjS2rfnS7gs4PahvpLv8SwTDgo5/3Ays8M0HaCzX2
 pLwLBr4UNp46tqVbsKvhZJZoPtpdvXPsbp70S0pC60xOnplViEt2JNR0gOgONhyQlS0Z47k49
 4GF6iyOKqfyo1N/LVZ4no5hRy/XO0O2KELElZk4ZPjDj7l+wUxFrkS0exEC8bDRVm9BE5jmZH
 nQINEB/o9edpuRd6GBMRasDEphUskm91VWuCs82Jmt39Mon/LD2sGe0jZ4mi6e9e0RIGBohT/
 vXKcEI2QjF5wy85Ro9rl+UepJaCM7NjskWBWjhRNH2vMUE1XIxAL2c/p1NdXJ2UGjixl1GW6v
 bootiw3lpKlzSYuKo0vypiUe4GDG29JrWmUbrM4mvGWAFIB6LJSnwEq2/soz83TKo3Sk1uCFr
 dsxuXv17vd+Ku58w3VV/P3/xzjLEwmxmhIoDCXvcUH23fKPAURpRZa1+mHlSnPt8Z2Sm6jfs1
 L3X9yIz6YfyAhZb4uO+r1fI3X88HM16BJ8D0ZgN5Spsdyu450DYsSdg1jrR47ea5DvUyQ0FNn
 HbOUUtypwlZJEQKVbLPQAFQ2rxBhDvGT5MG9r7WEnVCcUoO0ICr/uQW4Dbk4SbLfuB82mBslY
 DXc4hRtQmvzwXP6VeBz4tbJuE1t3GJ2BG3So5EXuXciPvTUoADiZXgQ8xr62Ah/Ci4jOpIqg9
 rm71ETzFqerjYkK/Tdh5gKwJDkKTpegtTyNBCedd+OqFX02Ecy28CO3HEMcqzg6HaVnrWR34K
 eWSUF7b9FxdXrnA/y35ic1BYbwnszGvGbtQeOUPQX1tzqYcskAbXkKTFmfQmwITtKOAJSxM+m
 1CvwYqg9a3vyubChMTCHtZnv+6FYNKF9OkLKCONWEsK1p2C4DjE53X8g0J5YWauiNUMuQSs+T
 o8/etDpyms/3t95KaT/+6mvIeNTM2IwQvVXdadF4N5tD3C5WSsAIsweyiFRr00hBREgQnhdj8
 /UB167oi84pANOvbRO5X1LhasqkTN6YOEAA5whtDh49y+A9XxmA+VRdPIZYPEDxlbfw
Received-SPF: pass client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Le 27/01/2025 à 19:29, Andrea Bolognani a écrit :
> This should make no difference from the functional point of
> view and it's just preparation for upcoming changes.
> 
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>   scripts/qemu-binfmt-conf.sh | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
> index 6ef9f118d9..426f075e31 100755
> --- a/scripts/qemu-binfmt-conf.sh
> +++ b/scripts/qemu-binfmt-conf.sh
> @@ -318,20 +318,23 @@ qemu_set_binfmts() {
>           mask=$(eval echo \$${cpu}_mask)
>           family=$(eval echo \$${cpu}_family)
>   
> +        target="$cpu"
> +        if [ "$cpu" = "i486" ] ; then
> +            target="i386"
> +        fi
> +
> +        qemu="$QEMU_PATH/qemu-$target$QEMU_SUFFIX"
> +
>           if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ] ; then
>               echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
>               continue
>           fi
>   
> -        qemu="$QEMU_PATH/qemu-$cpu"
> -        if [ "$cpu" = "i486" ] ; then
> -            qemu="$QEMU_PATH/qemu-i386"
> +        if [ "$host_family" = "$family" ] ; then
> +            continue
>           fi
>   
> -        qemu="$qemu$QEMU_SUFFIX"
> -        if [ "$host_family" != "$family" ] ; then
> -            $BINFMT_SET
> -        fi
> +        $BINFMT_SET
>       done
>   }
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

