Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1655FD6409B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 14:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA8eZ-00044h-74; Sun, 10 Nov 2024 09:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1tA8eW-00044W-VS
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:10:57 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <j.neuschaefer@gmx.net>)
 id 1tA8eV-0002Hy-BA
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 09:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1731247851; x=1731852651; i=j.neuschaefer@gmx.net;
 bh=3HZ8tIoD2v6/CwNMCE0bOIZhoFfD4wTlSJqw6RyLhh4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oMTq2KacR0T+r68fXo1aVovihfWtRsQBDHzJJJ6GIaR+qB7ToqUuGTuw/elMyNdI
 EFVQnbU26YwX6xKON6/IiZlp+72C27XsTbyEpPLx0qMFRKq63u8hp32oizipkfluI
 lRzcEEeez51nYZoqZMa8ia6J1EzPuJcWdEc47LN6MdkXLILWFzNKnm94AEo95wavK
 GZYKTXTlSA9Z+mzc+kmYM+GjMbkNQRSE5+pT35dmtQUtilLb0y6Ct6QecVYEnV1Yx
 YofHEGeSLiUzRPm7oqtm37hS7wz03AqPvTvV2PuMbDEDLbvbKqFJVVHx76q5LKzEt
 PVlpd0vibfXsA/diGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.58.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1tKLMs3iBZ-00Tniy; Sun, 10
 Nov 2024 15:10:51 +0100
Date: Sun, 10 Nov 2024 15:10:49 +0100
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: Laurent Vivier <laurent@vivier.eu>,
 All patches CC here <qemu-devel@nongnu.org>
Subject: Re: [PATCH] linux-user/strace: show TID instead of PID
Message-ID: <ZzC-6Yg6XwUoWHbS@probook>
References: <20241024-strace-v1-1-56c4161431cd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241024-strace-v1-1-56c4161431cd@gmx.net>
X-Provags-ID: V03:K1:FUI2R5OzNdhz41n+v9oqWKfEpmmaml9B6dSun40kMzfDXRoq/kR
 45fOmQ46aubkNY+TjsSM6q673snfqESgpEQLHq7rjQvmfuF5UoP4hA/3bisdob/DVsBcVaD
 ZV19od7bCyGFpk2X0bVCQoGc/z+DnEbCIYGhj9dQSfL+7gXylkPpXgHjidVVBQraqqonZEw
 SkmRBl4LIAHXhPbaCA0Hg==
UI-OutboundReport: notjunk:1;M01:P0:aw0YIyBvumA=;NqyYpooOg4iJpMOjIe2dNFC0Rrn
 sdLLimJCKLPBdITVwPBAtxTHtuOgLH2jBf8lcqMs3ILEFIQnqkId24lKeO9g148pw5ZYI9raR
 GwAI68CM797TAScjGK1Rto7FL+h9loK37nx+CvoIkE9OYs/+CggX/fSOtC+FQNRm5EW7eGvYT
 SKmnwqEQp7/mPhW6A8hnDXas1ta3Z297BWHYsPgFPAHbWxKJwVgEPE3nHp1ueJak5nfey9zls
 CHLltKHG1jNDxNEIp5qCbiaieTmjnLdV53+MtaDTUDmxZ/rbibJnyGUsP9uSC4vqsbhEX55jX
 33us9On9S3R/q+IAznGIBc0qXbE4qlC+DTivl3XTrN2uF+y4o7Z5jxJnXekCKG1vDAX6xKXUK
 5tQluu5RVYKKnHzd2FLYy3yNoMGh308NRjX4Es/rokTUDwtUrFo6B/JRZ2LAsAviwuJt8H7o8
 GZXwjgr2H6JvEdYR768muqZanu+3ItrvL/Q6BOAuK+g3Oe0SAk8IRpUp+m05n70mwvuhtrn2f
 ssRg0ppK7etOoiURmUjP+/G5ZBfGlkuCIj3w+FCkaUwOxsY4Bzcx0hA2VvYONwi/qj5bWnN1D
 bPpnp9u7jIQ3cUoOQ84qO4UQ9Op1ARGrrpWuef+2ui3Mh3SFdicwr0qwOmt896BReq20fNhXi
 M//K18IFIfdzpejy+nvbifRoEzGATOdT1VvyYIxuUCcAjFvwcqxoD2EpAlqCd4VnLa8LrcJLV
 p80FqDaJjqMGs2i9NV1FhejEXvqU1lGps7xw/wRKIggPqvd7WyXifFY7IVwOzSN7P3F4QGUKv
 4qnTsxlaQetWgcA9kHq2ukrSAliOMCUctay7nQedFRLUJsnxVOWHii5ABpVAdnezCA0ta3sCV
 IqwNZASByQvNADariLbRolK+xydcYH7yxbt6y4hoZL5Q/yhJ5CNqGQfitam6Ww6Muy9QYuRUP
 Y8oWKQ==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=j.neuschaefer@gmx.net;
 helo=mout.gmx.net
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Oct 24, 2024 at 01:47:31AM +0200, J. Neusch=C3=A4fer wrote:
> This aligns with strace, and is very useful when tracing multi-threaded
> programs. The result is the same in single-threaded programs.
>
> gettid() requires the _GNU_SOURCE feature test macro, so it might be
> unavailable in rare cases. I don't expect it to be a problem though,
> because it's implemented by both glibc and musl.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Ping!  Any opinions on this patch?

Best regards,
J. Neusch=C3=A4fer

>  linux-user/strace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index c3eb3a2706a93fdcaf693b3413b13921a3c97e8e..93e8c73de8a4a307e6e0df55=
55bee4c769e41e64 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4337,7 +4337,7 @@ print_syscall(CPUArchState *cpu_env, int num,
>      if (!f) {
>          return;
>      }
> -    fprintf(f, "%d ", getpid());
> +    fprintf(f, "%d ", gettid());
>
>      for (i =3D 0; i < nsyscalls; i++) {
>          if (scnames[i].nr =3D=3D num) {
>
> ---
> base-commit: 6f625ce2f21d6a1243065d236298277c56f972d5
> change-id: 20241024-strace-a52bd8e3d305
>
> Best regards,
> --
> J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>
>

