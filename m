Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A6606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pCOMgIpi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPJzx-0000oZ-51; Fri, 06 Nov 2026 08:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xPJzZ-0000mz-Gc
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:28:32 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1xPJzX-0000B4-Pu
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 08:28:29 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so975577a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 05:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793971706; cv=none;
 d=google.com; s=arc-20260327;
 b=XMIYxL4U14fCYns/ugwXh2Ueyv2E5nUawVjC4Pck0R9kiqisjWTMfC9mzMC92+6B+N
 fHVBRvfTGClBMt01HZEMsL2EKpx0LxibZcXR3w8v83dxVrhGCcsqUcBII5cyhALNen18
 v3OWFnvKAr/K9Uc2texGgUojVdfcd1C3gMk39kIQ4FSF7wPxtjkE5v7jcE4TczhDVHnu
 y5vlUR3Kp3Bz56jXK7zHpMaI5DUiM+3+grPQpnwtgRpl6i+DwX/4fKkn3gNPdP2MU9jX
 LKJp+qlxeNX2r2BhCCp195DUJb96uMAgSeHTs6R7dq8qw4q0pftQjH/7JyZL7xn6Gh3O
 6iCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nCKtuhATgubjXTBv/MJQxWs69P2cLQLu7w0XOGgjWJY=;
 fh=EwZUVP3qlf6D2JK/qqF20iXkymNg5w1dH3WEEnLnoVo=;
 b=M2S7lzLqIpbE2smjoVc+62/LPRUy4mui0LiwYySiYRCZSFEYa49XM+aWd3xnh40HSs
 BjeXQkJWkTz9YM+KaF2O2U5E4hl3F6iDKeynleH+xdv/QAGmj4Eg6uBYd3w8t9ALxjqu
 Y4i9ZVY685Awfw7SpHo7la7hPEtskwTbYC5NXaLNJZfqRxD/tr1b+jkKoRj5N0qae9Du
 BwuNUCERLRL+cHzEMkMktuBDgYDOpiv+Pmf1vLAiZHTBk26ZLeQA3asAmYjpAKCzww9c
 V4tdG2LdiaPCS9UdareZupmv4VD6idE0q6YDSrLkGA+ex2FsRng3jhWDgsopGcaH8xCx
 wmag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793971706; x=1794576506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nCKtuhATgubjXTBv/MJQxWs69P2cLQLu7w0XOGgjWJY=;
 b=pCOMgIpimLTu25Dd+ZYhrMUo3t4k4rqMLqeLQ/yOzE6TRnFj1ZIHGGFKiEtTnaHz0w
 XHX0ME0MjAHG+5rm4Z9OaTVP9sRAYCSSgF8F6plW20IMg1VGN02/+r8U+RaaF6i4s7C1
 zzx0q9/oXg7JU+qXmbRogR6/in71INR7EVdMLwaV8WCKrDSCdD8kiffrH6HQqZGMdr0X
 8W6CmhB4W/x5HJBU8YknjL3gxBNKrB2gTHKbupwP5rU213+aM71yyna0vb4bT+4k8ysN
 hQg2i8dFj1/Hife81tmG0IPA9lO2+ewXm0lZnPYbENPghvHtnYgjXSj1hDD8xXIj8YHs
 i09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793971706; x=1794576506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nCKtuhATgubjXTBv/MJQxWs69P2cLQLu7w0XOGgjWJY=;
 b=tF/EI7kwmiy/qIsg8wKYR4gw069sKKMiSGZb2MLqTQPhL3YaZr+NphedKBvzxJpCgl
 41zcGX51jFPIMm7OncrDu3ziR7LUQ85ctpvn2uYMcEMLzmqYriZDOPOzY6bsc6G1avoB
 DDoZYzv7p+0vKtICQcSa0c+C+rg9Ml7vlmVPTTLbf4zlaOAAG/2z59jvEMAq0aBE0Hhq
 SjIavNGn4ru3fJLt5q3kZPvC8DRpC7Si24S3ELyYJTbvAQsubJIXweuj4oSwZydtJnsk
 nhYzNPzQLmTtOA1PKMEdICTRg/G7hz1RQbMJ+ndQA48Iy1nX33dhklajRC1nIsbx9N0p
 yI8w==
X-Gm-Message-State: APuU4Z8glWrH8kr8lZnqH2Ns+1reK/JAGIC5B60EMJ0K7XsvBO/Ac6pf
 7XkVmJVrt6IC+qevy1uzdBJiZiIBOqjXmYQ2Ys2+3vt4fdcpzE80YCWmT4Th+jqKIws6F9MVL1X
 gwsBc2tCmx9jwxEayg9HsUcXf2ZECe3I=
X-Gm-Gg: AYBFou0ct9FidqU2Cn6mAT31RzLQz6CB7yqc/XrWLNnzzzHJY6mBnI/1jUR3eH+CItz
 RpIiazgDTJA9Oj3M2aYz82A6moGoLVRPOMS5sYmSqQ3XQJAWPKx9BOaCmaXKGYsTm5+vhMe2R0v
 DmaKhQ49M+5DPtK3UYEwR8iLsbqxh5s3xXRDS+VLNKkuwttEzgadkRXItZP2FeZ2k99npvzS0qD
 9a7I4XsyK0e7Qi1P8eQd/TESR1NXXeVlpFTP//MOz6GML3S9SbiOc03A223EQw+wn57MlWo4aWf
 yA8iybhGOZu5rgxnJbSP5LBISMBD4ZCtin/39mv/oNxeTNmoXiG8Jo2b4n7qd8AYN6N5wVBNmmz
 0M/gwPVjfgxAHuyS5ynxZf24vdOtkErAARVCrms+05FWp3fkr1ks6Ai/7YXDju3IZGfnNpKwldZ
 Ck
X-Received: by 2002:a05:6402:270c:b0:6b5:9640:20ac with SMTP id
 4fb4d7f45d1cf-6b5977ac823mr1769486a12.14.1793971706091; Fri, 06 Nov 2026
 05:28:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <5059a259-f66a-47fc-b42b-b8118730e469@oss.qualcomm.com>
In-Reply-To: <5059a259-f66a-47fc-b42b-b8118730e469@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 6 Nov 2026 08:28:14 -0500
X-Gm-Features: AclHuK9RZXG_E-ZAeV9rvo5LSYZCbK3ZrlYT4nzKLjX3UgssQNCS0jxKBUpQ9O8
Message-ID: <CAJSP0QXby0SFKdvyor_XSu_ixwa0x56UeWDLVbiYNpfqFuEhAQ@mail.gmail.com>
Subject: Re: new roms/ mirror request: hexagonMVM
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 2:48=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
> Could you also create a mirror for the "minivm" hypervisor repo "main"
> branch, similar to what was done for hexagon-hypervisor?
>
> https://github.com/qualcomm/hexagonMVM.git

Done:
https://gitlab.com/qemu-project/hexagonMVM.git

Stefan

