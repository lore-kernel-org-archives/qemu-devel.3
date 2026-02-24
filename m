Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DA2F3C991
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuOO-0004jy-NO; Tue, 24 Feb 2026 10:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuuOM-0004jn-Jn
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:32:06 -0500
Received: from mail-yx1-f45.google.com ([74.125.224.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuuOK-000475-MV
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:32:05 -0500
Received: by mail-yx1-f45.google.com with SMTP id
 956f58d0204a3-64c9fcc24b3so624325d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947123; x=1772551923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQKaRpM6M/Os8FE/PKiFqgnm7GlguflgokeaDHIlEIg=;
 b=n/BfmChQZe2MSHXaRirU9DGjkR1QgwQu1Hw5pvJ7HruO5AlgUhF549MnuCT11E8qrv
 Iz2bA7dOuUJVJr8p3Lv/y+VcpbTP/Lt6gsdZ9Cjm3YSMHcKZIBZU2UO1QtM//VZeDaw+
 3NFFsUVen8ltcAYcpbnsnIrzknRaMlgB2ycRW7G2thMW9scI5Pnd9k5K1HnuryaKeCKE
 4COL5nZQExqRoAT57Gjw3ZM8XlWT/xDPg+rDzbrB6jV7fm9B5ZjE8HBffHK9rtVcy3kO
 6bM73JrmsScuucZaZNDPeDAlqM5Nji2yaiULEIAyvJ/nlOS/3Rew2TKikiFEMtVr0V/K
 7T4A==
X-Gm-Message-State: AOJu0Yy8H0MwRalnzGE1UTRLH11jR5ztLKE52miEhAeWrCVS6pG2CuvM
 ia7RAtuXknl1RxNBOuhafn7gZHnvgPHUSJ6hjrYc55bC07ufB6hwZ1QuwMwe1IXZ7K0=
X-Gm-Gg: ATEYQzwtbuZIyA4pkQc0Ftkz2MHscVMErpcUdT6RTyvSbprEXitx04J9wUVPGGBrxNl
 IrfIqJX1i5pxQwLFILCvRNE+CUwgzKY8rs7BU+OakjQzRji9SzW3Ph8wIEtm6RsjpL5/mUeZmk7
 cbO9pcq88FoVZ/5Gxof7Fo7yztjEOmM5+HNrjYPpEeXi2A7Do/ELIydnx9xkSsD5Vu3GB4FXpmd
 +2br/D6m5qR7pLxuxbcELSwNb/pX4AH4NFL11yQ3VAkwPvdwLNUYAFCgA2oNc4ypA/W47n9LATW
 HrtFUyXZSdEUdb28Sukd/EbrMVvGiCi47EQIK9urb47IhBO4HomgiNZKK9R69z6uo92evlvu8pq
 yPYV6N7X/k1kd6xYstkHc+RJK1Fj0E5U9moCLxcNni33RtNrWmGqbDtLAAvMKAHbCQUb4yiCnhL
 iJxPAqRpAzINxYiR6ZTeIig3yBFNPWDpOknjCdVk+Rzd5bzAUyKldAI21qnNuvvISm5gdS+YTiH
 8ZNqjPvTQMaKrYF3q2SGUtUte0bA5Ti7b+1VBTcN/3xQTG41b5HbQpoilrQbBYVYyIWGtCxNvTW
 kqDY6cw=
X-Received: by 2002:a05:690e:d81:b0:63f:b444:da92 with SMTP id
 956f58d0204a3-64c789d2777mr9184597d50.31.1771947123250; 
 Tue, 24 Feb 2026 07:32:03 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com.
 [209.85.128.172]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-64c7a27069asm4551121d50.8.2026.02.24.07.32.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 07:32:03 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-79860421382so3734947b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:32:03 -0800 (PST)
X-Received: by 2002:a05:690c:c4e5:b0:798:5cab:cb70 with SMTP id
 00721157ae682-7985cabcd4bmr17302077b3.21.1771947122762; Tue, 24 Feb 2026
 07:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20260224-bsd-user-claude-v4-0-8ee5ae17056f@bsdimp.com>
 <20260224-bsd-user-claude-v4-3-8ee5ae17056f@bsdimp.com>
In-Reply-To: <20260224-bsd-user-claude-v4-3-8ee5ae17056f@bsdimp.com>
From: Gleb Popov <arrowd@freebsd.org>
Date: Tue, 24 Feb 2026 18:31:36 +0300
X-Gmail-Original-Message-ID: <CALH631=ZoTDp3FzfKVoJ1orqdigPmw9gS8iR0BhKG9J4pVZkNQ@mail.gmail.com>
X-Gm-Features: AaiRm515OCtZZYs5klarOm5NAM0fsOiRXA6hqx9gRK1U-bpFacBTX8y5l1lth6M
Message-ID: <CALH631=ZoTDp3FzfKVoJ1orqdigPmw9gS8iR0BhKG9J4pVZkNQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/24] bsd-user: Add target_semid_ds and
 target_msqid_ds structures
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=74.125.224.45; envelope-from=6yearold@gmail.com;
 helo=mail-yx1-f45.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 24, 2026 at 5:42=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:
>
> +
> +/*
> + * sys/msg.h
> + */
> +struct target_msqid_ds {
> +    struct  target_ipc_perm msg_perm; /* msg queue permission bits */
> +    abi_ptr     msg_first;  /* first message in the queue */
> +    abi_ptr     msg_last;   /* last message in the queue */
> +    abi_ulong   msg_cbytes; /* # of bytes in use on the queue */
> +    abi_ulong   msg_qnum;   /* number of msgs in the queue */
> +    abi_ulong   msg_qbytes; /* max # of bytes on the queue */
> +    int32_t     msg_lspid;  /* pid of last msgsnd() */
> +    int32_t     msg_lrpid;  /* pid of last msgrcv() */
> +    target_time_t   msg_stime;  /* time of last msgsnd() */
> +    target_time_t   msg_rtime;  /* time of last msgrcv() */
> +    target_time_t   msg_ctime;  /* time of last msgctl() */
> +};
> +
> +struct target_msgbuf {

You might want to put

/*
 * sys/msgbuf.h
 */

before the struct target_msgbuf definition, just like it is done for
struct target_msqid_ds

