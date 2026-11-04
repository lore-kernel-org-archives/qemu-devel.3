Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D4D606A326
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FY/zDLad
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOe3X-0005Fa-Ot; Wed, 04 Nov 2026 11:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOe3U-0005FE-L5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:41:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xOe3S-0000ZD-Jy
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 11:41:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso9861285e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 08:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793810500; x=1794415300; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IjWM0BaWW87DG5hx9FSgbs3odCmDLsC8SSa0dQGfPjQ=;
 b=FY/zDLadmiJa98SWreyhRZruenqHyqMqiTr/mtK9h+5teXGcM9Ii0EOlxGsH6UpWlR
 kPT+ViZ09jFaOzlfF1oFL3qvHKFVCgzncFEi+wQ7R9LE6B5I+dbacbLGDwxUTO/XsAF7
 BEu6sq2gDTJFQnLSvAMVotIhYDT3qg7Pxq1kNtY63UvXRuVc6EwW23nflfc2v1+NrECe
 ssWDIXJvCAPFNZ+ggNymLl3SB77U9X0CgvMH1k2D0kJPqzpLdkzi2igpwxFSvg+qJMn5
 7XhB6Xl/IEk4aPL43rpBBt98IPPHXyxPJGf7w3ewPt2cgbNsubI22NgjwbVaESGY0Tjs
 5rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810500; x=1794415300;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IjWM0BaWW87DG5hx9FSgbs3odCmDLsC8SSa0dQGfPjQ=;
 b=QCSR8yEmND0xjI5K7IK9sb4f7K5/c472D3BYoTX0qf65kyB7XitnTDwmqjdVAJ8Qsf
 k3EJqHB/jOXvQVm4ibXM4jqy0Fv18+fhiwMwIwkJBg5kFcMXjV/0UcdSVkLw4PXMzV6f
 kNjBs9yk6l+1nsLgRypTTV4bwY3Fuprqx5lMoT680g/8TNNEtA3FoMQrTdG/yG75paZi
 pDtvuab7ngHg2oH7rIolnfKBdbqt57Uz1Cqq1z4/yu0/F11bfW6n9H+D5aJArz/pgZEJ
 ml5juMtQoVEazlUbno5kZ1t7V43XTbAkYSQpuzGDe1vLZMKUYmjNZGStrCJ7e+exWyC+
 bknA==
X-Gm-Message-State: APuU4Z+Wd/odxGJ5Z8tBL7497EOdWwXJ5SCieijoz3tkRJ9WbkC8ztGh
 OXSuvnZxWNA5Aw0XQyYL8aBUcSuzZ9C1StaXkYegybiFuAIKbCJzcuwfnnRMD4kdhGi/n3BfmDV
 k3xrE
X-Gm-Gg: AYBFou26mP3r81L+kZJqviqcZs4eLA/Dhu2+7IoRlA5ef4C8jwOoUc04zpuLXhhoeXY
 P3YhMPTgn4ShuXhrEAqFqPHvAEFX3vvsj7BhNK6YnjGzh6V8qiNqWb92eo//wahdpAXMmwEcvWK
 ZYUqgJts0R4cqaEjJHqlPjadIH/+ppVJb90EnPJ5JSV9K4VhGBXQY68ftw6EkNo9sHPJ7WqTEJc
 vXHEbSDaMo3NTf61Q77nrjGIxo0j3Dqts/iomMJoX43HYtH2vlvvtfPdjHy1D6pcZxsyVbTqrJE
 fdF6z/YWyBtY4+9WDFignTDVR5wKRWFCg/08kpwviKyOy1WFLWibyraDN4eSz0bHc06dxYt3YBu
 032IuWIGQMsAibdNP6pD38S8D/fle5YOqvE1p4X2nfhYtUBqi7/Ge3+2BjBn+lFNj5FE6DX83m8
 7rk+oQsqRFO1hhSDp5k858geJCGc1TOeCf9tticYXJ3vl+vxpWGRrHmK85lllgVtajWGvkj1REK
 Jn9kT5G/7JEJAGHKRgyH9coaMyzS+XRJI0sfohS3toe/JKWu8W9fRDJO6WDeQLa7jE/LcJXa8vK
 ok5liO/DwsEz0mDix0VVJp03uGPs
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id
 5b1f17b1804b1-4b2612d90d4mr149567265e9.34.1793810500357; 
 Wed, 04 Nov 2026 08:41:40 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feeb51a9csm4801342f8f.59.2026.11.04.08.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:41:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B0AE5F83D;
 Wed, 04 Nov 2026 16:41:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  brian.cain@oss.qualcomm.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Justin Sapp <jsapp@qti.qualcomm.com>
Subject: Re: [PATCH] gdbstub: reset supported features on Supported request
In-Reply-To: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Fri, 30 Oct 2026 15:21:46 -0700")
References: <20261030222146.558366-1-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Wed, 04 Nov 2026 16:41:37 +0000
Message-ID: <87v76c7dmm.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> From: Justin Sapp <jsapp@qti.qualcomm.com>
>
> https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-Pack=
ets.html#qSupported
> ```
> Whenever the stub receives a =E2=80=98qSupported=E2=80=99 request, the su=
pplied set
> of GDB features should override any previous request. This allows GDB to
> put the stub in a known state, even if the stub had previously been
> communicating with a different version of GDB.
> ```
>
> We exposed this by connecting to gdbstub using a gdb client first, and
> then WinDbg (EXDI) for windows kernel debugging. Since they both
> differ in their multiprocess support, this was confusing EXDI.
>
> While we are here, fix the same for fork_events in user mode.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  gdbstub/gdbstub.c | 6 ++++++
>  gdbstub/user.c    | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 0a328b0dd48..dbb2000c817 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1679,6 +1679,12 @@ void gdb_extend_qsupported_features(char *qflags)
>=20=20
>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
> +    /*
> +     * Reset multiprocess support as a new gdb client may have different=
 support
> +     * than a previous one.
> +     */
> +    gdbserver_state.multiprocess =3D false;
> +

This looks fine to me based on the commit write-up. Although it does
highlight that struct GDBState is due a clean-up to separate what is
negotiated features, temporary workspace and accelerator supported
features. Currently its just a random collection of stuff.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      g_string_printf(gdbserver_state.str_buf, "PacketSize=3D%x", MAX_PACK=
ET_LENGTH);
>      if (gdb_get_core_xml_file(first_cpu)) {
>          g_string_append(gdbserver_state.str_buf, ";qXfer:features:read+"=
);
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index d810f0f38c3..9b6d42d210a 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -701,6 +701,7 @@ fail:
>=20=20
>  void gdb_handle_query_supported_user(const char *gdb_supported)
>  {
> +    gdbserver_user_state.fork_events =3D false;
>      if (strstr(gdb_supported, "fork-events+")) {
>          gdbserver_user_state.fork_events =3D true;
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

