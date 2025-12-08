Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4848D3B7F3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vScoU-0006wW-MN; Mon, 08 Dec 2025 10:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vScoT-0006vq-65
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:06:09 -0500
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vScoN-00085C-IN
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1765206358; x=1765811158; i=laurent@vivier.eu;
 bh=TrZFtie3FRb0mS/17jmATt4fSHdM9wZ5ZRdTLWKGXpg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=JV1p2KRd/iURZsvYcOQ2naWOfAjjyKqpf2s4gYovZ8Z7A/ySNvYxsTYlRKXm3yxg
 +jF907vPz2JzlPlD6yKGOExXE8bTJiRDkIKdkMXnQ1VSZzmse0mRfk6bQ4tBAVAJY
 H/NH/zV3iliNrqcyOfPZ4XdukvKzBkePZ/UPVW5LtYmg++rqvDyUeewxfljp0n0cL
 g7xBymFmx6uZ+OFP31EIZnCTRYwV2EjxcZrr3PPUSKbcgRWemXeb9ybguHWtuJzkM
 7U6Aeb+bjyjWQjMOxAd3ZGTjpjt64JNOLjpWnFWGVctX/FKurNQG7C13AV1RIudJf
 +C6ec2uAIymq4T7j0A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MvJs9-1wJUPf1sGH-014Wbi; Mon, 08 Dec 2025 16:05:58 +0100
Message-ID: <4943a0c3-4b3a-463d-93e0-7edbef72e621@vivier.eu>
Date: Mon, 8 Dec 2025 16:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] linux-user: update statx emulation
To: Andreas Schwab <schwab@suse.de>
Cc: qemu-devel@nongnu.org
References: <mvmwm2xum6n.fsf@suse.de>
Content-Language: fr
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <mvmwm2xum6n.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BAyZxdGLDOgTVQjvNg0o/WSNodSz3oh7n170Z3R6tQd2Hfb462q
 KVbMZVcpjYXMbo/fBvGIbz/M9KomKvBaDdz93ZeVGQtU2r9eUZ/xOCsdKC8WMDI1fcGMAFG
 N8wV/lkxAcPbEvDvQ5y9zBgtpbBwZLxV64fJFPa9SV7bpzvhtDMSESuqxaPUC8xXRe/2I8R
 K7FZl3PPxMD6s0UslIiFg==
UI-OutboundReport: notjunk:1;M01:P0:rwK/7S4OLkk=;MPJoP/ilc4nfU+3v6J3piaBxEoV
 1aOS+SqzhVPz+tC73PPKD6kxAQMA5oXhnLvfZWfwOGhCZR5EChFfFnIjglqHq0Un6I0JAhDpJ
 hE8klb/MgreD6xcU24sG4XhSZjxmzSqonZyd1kAeuB30bHke29fW+VUq8NTnaOwXHDMx3PfQ+
 LcvfTl4lxfDkOrNjG3v9GSSnGVchcphUz8v8fsdsZYrXqP4MbGjStfWVpt6dRY16RVDlPslZv
 MUNsPzoqPw28V5VUor6AS6lLgg9Zmac+rhredAZFvldLPAvOB91poN24Ka4CZ7Amh4rIUblQ2
 19qih7hDC9w5qfAlPvuYDffsZKPS5ua9kP/vaGXTlKeyIC7xIkdtNPz9cCFd8NE1HGzW2EMnh
 L2Dahm7wFxUAPZvdeyNfr/Uo4IkB1cHMER6p7ZS0xkz9XdRAAwj6jhdyzufT36Jg+wncF+7+p
 R5Ds8AmsNvw+b56fjA4ITNY5Yf2jobVmnQ+xMtSd+AmM+3hOrGMUv7veM8JX0JcW5H5iFM+zQ
 UBe1d4dUKvwGdxYS93YwQNxgKQ8Dk5b/WzTZ88EEDcshyTODJFtWLOAwRDlI4upa565yqBTcc
 uejm2KQq/9dtT6YnTTYIE/CTpiOIAMkUHQBhyl/lCOKXJX1idHYkrUiXJj7FQwqfbRn+qLmk+
 5CovUliJFn48J2l2m/WFeLGNjtqEfzmMZ6e/TmYi+6L9Ht/qOUZvz+q3300Y7iA0jsvNBjUom
 UogEtpQlUMRW7oOChkqKl7qYmkdsuPT6uCt6DJjvCfYjZFX9zkdUZ6kFTo4C4xs3SHaGsfNiK
 o69rKI/npFuLimlehGzOniRgJaSQ5/h+7Ct/u5Zefb7AEvIa5lDwJJl+U/d6iTNiYk/Ks18m+
 wLolMhHagKaGtzqJM0uuMno+WHegIL0NIoBes6FcsSvCSPUx42DGFJ2B/2kxjC1V09iDVZRYD
 fIVWjNW/vfYK6z6kcc/UgT2X8+UtAMTv4IbfNn7uPoXF9jB2ZL1xeDF9qf80PrlHdT+VKNPgn
 t+G1+R45982jDeal1B2C7a3c93PLMFTeYYTa/p87GFxF3K7wQGn3S4sAxVG05g+iBo63KQlbc
 MsVOLz71N9S4hWWU5wd6CJjrOLs9itElRYT7oGFt1+5aNc3fyqArkkQP2rKrfWT+NFqbzkQ4R
 gIiL9TXEc9e5ggUcIYtf6tAGOjqAuMjZsUglW8WQu3pcCiLR5mffi0u9xa5XzV7r6Q6/rifXo
 jE2Wj3zFSsWZ20yetRzYY9FD93P2cGtpswJYoDAeQFHZDp9TjFmr+GltT28PPZJvhY72v2Vtc
 0Rj+p3wlO6dlPPZ/27i9Fabvxhyt8o+rmSIzNqOG53Oz3AwwGsW966h1ybdouQhxOW72CHNM/
 ICpjwJxUODO8DCZzZhNcdDgb5V0rLJpuUHTaezzpwZMu9SPVwW9X8UU7Q89sV+SSy5rRJ2mip
 Tw9e16mZXe65ijNPWejUEyzEUJ31M9MbK6eOjmwL3J5ymZKePC9f60SsraGrARN8c9HP1MlzJ
 sWFnwGUTB2q2cqiEWAfkKoAhEG2AKOB739fy4wVdSHS+j6wnqVlSopFW3GRWNGArqkrwhsS+v
 kUxDwRr/Ob1GMC/MeJSKn3iZcYHC3xrLuXe8ekVnQt0z7Gp1UGz8ubTfz+MpV20f5TWWTi55p
 UtP89jt9kO1UMSQrbFSrhoo2Wqu5Nx8OEO68bIpIV3YbUGqAjB5faTHQrVveEG/8PfPrUwL9g
 TqGJrWlz0WN62nutmj0mO2Dh47z7/Qu7fw9towFkPeep+TUrMNGsP3wcdD2NaLlpCKPkryojv
 oRr+
Received-SPF: pass client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Andreas,

On Mon, 08 Dec 2025 14:40:00 +0100 Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c      | 3 +++
>  linux-user/syscall_defs.h | 6 +++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e379ddb1b7..248c5b5f7c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8049,6 +8049,9 @@ static inline abi_long host_to_target_statx(struct=
 target_statx *host_stx,
>      __put_user(host_stx->stx_rdev_minor, &target_stx->stx_rdev_minor);
>      __put_user(host_stx->stx_dev_major, &target_stx->stx_dev_major);
>      __put_user(host_stx->stx_dev_minor, &target_stx->stx_dev_minor);
> +    __put_user(host_stx->stx_mnt_id, &target_stx->stx_mnt_id);
> +    __put_user(host_stx->stx_dio_mem_align, &target_stx->stx_dio_mem_al=
ign);
> +    __put_user(host_stx->stx_dio_offset_align, &target_stx->stx_dio_off=
set_align);
> =20
>      unlock_user_struct(target_stx, target_addr, 1);
> =20
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index cd9ff709b8..6ae6e1fa13 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2734,7 +2734,11 @@ struct target_statx {
>      abi_uint stx_dev_major; /* ID of device containing file [uncond] */
>      abi_uint stx_dev_minor;
>      /* 0x90 */
> -    abi_ullong __spare2[14]; /* Spare space for future expansion */
> +    abi_ullong stx_mnt_id;
> +    abi_uint stx_dio_mem_align;
> +    abi_uint stx_dio_offset_align;
> +    /* 0xa0 */
> +    abi_ullong __spare2[12]; /* Spare space for future expansion */
>      /* 0x100 */
>  };

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

