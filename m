Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B5606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SwVfuua5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJUNz-0002pQ-El; Wed, 21 Oct 2026 07:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJUNu-0002os-7l
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:21:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJUNs-0000aW-L7
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 07:21:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1efc90e7cso9840355e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792581687; x=1793186487; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rw/INhfuWCPgD4AuN+UhyTo7azUXIasj96bKDH/6Qhw=;
 b=SwVfuua5qD01gmHan7RRdZw1EGcNnmKwRSu1UcT6kiC9XHobaCPxBuvfPTrIljmR3X
 dfRCrsgWAkSWB7WHdLLN8mD0lYtEVIWc0fLxqhPgtq49CZkRToaMPD0qNpGTPpg+gE8x
 jSPTRLDA8AByPLNTwWalP4c/uu1/T7uVBFN+rAqRv4pkFJgjR1USAxXUW7n6pFiUs+K9
 kLdahyc33bksZnn3v578beNQ8WRAoDugYtggktEtBvqBl7MdualDX9EZmK+epEQCELc0
 dtjRx4m+UmzvZ93Va4W2W9CF/0BIVkDV3ZH2TF7IVxMqGg8aV03cBhrgi7T0akBFTEEM
 WtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792581687; x=1793186487;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rw/INhfuWCPgD4AuN+UhyTo7azUXIasj96bKDH/6Qhw=;
 b=hdCwykJBbinbmsuTF4alABLXyQyo7DiqhZeZ29cLZCXEvYdPcIvPa592kHx6wlbCrX
 y+JPcs6RwFF4uJhxUKE3GGuqIa0TBW7gn1p7VefooL6PFpx+D1IjqjxUwfs2zF1kdynD
 LREx3kvHCbpS8KuUXTmfb3IcZtvqWyDCMgB5r9/7SIaoszmgOFUj+ohLI7Usrz+dWXcs
 p+0Qccfw1auSRZkqVCayKoc3CcYq5lxhlicWg13UDrMYOyhfdowTR+XrgjhgbbWbXud/
 kVxErye/KenC/t4h19UMVpyOj/2eKxYTMDLldPT6dQCyPMI4pRy9/8i8RPSnbZEPYWkc
 Bx6A==
X-Gm-Message-State: AFq9FYIeF1WP/ryLrfk+vqBRqaeHjuP+BH3dpWLfc7s0xykFeQlzMyhF
 dOap3XvbWs3eHg1LXyM3H6QqsQbUdhmFVu4wS4Icbi5ySVmrZwCZCM8BmMTJiuh9WJY=
X-Gm-Gg: AYBFou1Bk+oulPaBSkH2IN+rlyDPHNzT/C3QMF4/K9GZqb09RVgZ9eu6kb6uLDJ4jYW
 8uDpoxOMOaL4X9ndIhkPHecOe1E6HsQN1yuqhNAAQxhkmVSu7jHsSN1VSeLCY1UqY/7oYhdHwNg
 x6/RGNtvYIwdbp/o3JSNV2+SUsyPEwQ6cDyVpinTw8GCPD+ErPRoerICv1IGeoJywLOAPri3NKY
 ByJoZQEw6oWSIFHis5RIsL6Sy6q1gxfnwtsI+RTWsWDHQqqo6QQKGpfPT5Nasa8tUZte+JXe59i
 s6y3jeazCzH7jC519+Ush/z5q+gdZ82tU7YTmUuEoTSBl8FsvrplrhcgRZV0Cvv5Nf0nv5o1t16
 v9znurc26W0S1j/ycW/P1kLgb2Q8ieDQOtaHrqe8fq2PwfLy/8VufiS/O/0FcKb4vPXm9PMIhp5
 AkSbjz/UtI5hC3yOhiD9iCL1wwsO/qleTueY+wQTYPgPQF+uZDksmovGKjbVTE0PSwpE4CVdWx4
 pZNHfATs0NYgC+KGxVMZQ5uu5GERqHX484Bxdwi+Mi5L0Nfd7X06gc=
X-Received: by 2002:a05:600c:3103:b0:4a1:e57b:667e with SMTP id
 5b1f17b1804b1-4a1fdb155bbmr37861335e9.4.1792581686988; 
 Wed, 21 Oct 2026 04:21:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd2eff9sm44109515e9.4.2026.10.21.04.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:21:26 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6784C5F828;
 Wed, 21 Oct 2026 12:21:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Gerd Hoffman
 <kraxel@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Jason Herne <jjherne@linux.ibm.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Bin Meng <bmeng.cn@gmail.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 8/9] tests/exynos4210_uart_fifo-test: fix buffer leaks
In-Reply-To: <20261021-nohmp-next-v2-8-85471fca83db@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Wed, 21 Oct 2026 11:51:11 +0400")
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
 <20261021-nohmp-next-v2-8-85471fca83db@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Wed, 21 Oct 2026 12:21:25 +0100
Message-ID: <874ief1eq2.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Reported by ASAN.
>
> Fixes: 6d459c75cfc4 ("tests/qtest: add test for exynos4210 uart fifo over=
flow bug")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/exynos4210_uart_fifo-test.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qtest/exynos4210_uart_fifo-test.c b/tests/qtest/exynos=
4210_uart_fifo-test.c
> index 54c09a6de723..c336ed22b028 100644
> --- a/tests/qtest/exynos4210_uart_fifo-test.c
> +++ b/tests/qtest/exynos4210_uart_fifo-test.c
> @@ -52,8 +52,8 @@ static void enable_uart_fifo(QTestState *qts)
>   */
>  static void test_recv_large_str(void)
>  {
> -    int sock_fd;
> -    char *sendbuf, *recvbuf;
> +    g_autofd int sock_fd =3D -1;
> +    g_autofree char *sendbuf =3D NULL, *recvbuf =3D NULL;
>      QTestState *qts =3D qtest_init_with_serial("-M smdkc210", &sock_fd);
>=20=20
>      enable_uart_fifo(qts);
> @@ -71,8 +71,6 @@ static void test_recv_large_str(void)
>      g_assert_true(TEST_BUFFER_LEN - 1 =3D=3D strlen(recvbuf));
>      g_assert_true(strcmp(sendbuf, recvbuf) =3D=3D 0);
>=20=20
> -    close(sock_fd);
> -

Did the close(sock_fd) fail or is this just adding another auto free
while cleaning up the buffer pointers? Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>      qtest_quit(qts);
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

