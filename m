Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51212F4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwUX-00035m-Cx; Tue, 24 Feb 2026 12:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwUV-000352-Qq
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:35 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuwUU-0005PI-Cb
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:35 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so916948666b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955193; x=1772559993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DK2zKsczUyQIQqJ5sM7bAY5q0K2fSiJ4Fv/FtOZJzCw=;
 b=oQKbPwpDE2PFDG+hF4PyKQYh7h2wbc0sjo//jEI0EVVescus0Bn8QhdQnYxnpAi3jg
 CNFUkQrX2fkJHaZ7Mih4JOkvtbp7tSlrdDLmNdhDZ44RYChR6Ncx8G/4xgL5nr2eVVqB
 8Ovsh+d/ea7BaHEOnIysmlvkgcnX1ygoYd1fA3wfoPY9oqjp35VP0Bh1V99ERWss6dde
 /vHoFUN+kJS1jbTc7xXapdGnsd9GfpVNwXYaMvzGJ4PzfeOYcb1yJoYFCkdZ2R+mVMpP
 0SjnxVJozP62JPqyhCB5mpr9a8xBBBbwSHPbn1SW6SeQ6VNbcEPpyFHTXtBNHIkiXng2
 GAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955193; x=1772559993;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DK2zKsczUyQIQqJ5sM7bAY5q0K2fSiJ4Fv/FtOZJzCw=;
 b=rKUZO48ZPH4f7iN6tn53aWR/vKhGYcJA9BaW8tdFDdZq5Li+iN8Y+YI7TIRNZhuydP
 yMD8+KPdLxfDMh8HHUNnYRdXRXI5IMSPf+9DWUJt22psLql9RWST5DCHn4IZ0xhqDQvJ
 +2ZTTTmwilVPPssV3J98XHOYbcTR3lBI79QttcUSNDdMPuQXJA9gZQKB2MnHHXG7pi/B
 lduhY4XYzF31aAzudmNyVENzSkYtv0AQTWLiMzlxXsREMp8pNkyxRHtTVSIbJobm9XFb
 VnJmv+WwKUNH+YRpHSwNs0+z7PzPQQTdI5YIAy/ypok15zrb7pUCFR4XrHGTYK/AbI+I
 tOVQ==
X-Gm-Message-State: AOJu0Yw5vPxG4oNko2BXQ/L98PbM6GQkLT0aa5o7vQxYsJVsv4HGXaWb
 96Z0upbgsPy7+WDnVH/Hvoj8TZ7gIBkW05ONPRtEYLhMY1RPBge5Kvl0PCOwqWCxJsg=
X-Gm-Gg: AZuq6aKLcMn6w+hkfd4pHPh+0NMacCxf8YhXvBYChSaIaZ5NbgOF/kOt2zIMMAYPN0v
 EH388e6AFzQcUTcKqy3bxMzJfEa961xZyOu+hTKMYBhlDTCoSjDzuo23l1vU6/EpcIcj1++vc1U
 lcrSNC5j1hkaEnwgaMpoACksmgqw7KimqJQixlkeVSUYd6P/KAlvm+YwZGSoifGVGELnlQmJ//e
 niC7t7yADXlIWWHqvbOgXx8XKTaoMiM/KPFNaq8yQtvkcO5zrXgD/0hLn6rh3cP4WHgZPZaN2N5
 UzRc8WNwwKbOTDDr6tuhZ/t6dBkc+kDWkINwy03rNZ/75o2bezcevez6HPKQbJHYNwY9czw9dfS
 CH+KcHLLaCiIBBofjFEtbAevlLRsU5hQ9K4RGT+5LrUzkelFpXNM6NXqU36ihk71H+ViVmvJKrZ
 P6soFhekKebQrM5apcwmYoCiY5JEP8REfiMA==
X-Received: by 2002:a17:906:fe4d:b0:b88:504a:f381 with SMTP id
 a640c23a62f3a-b9081a52158mr824754966b.23.1771955192625; 
 Tue, 24 Feb 2026 09:46:32 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9084e4bebcsm436218666b.36.2026.02.24.09.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:46:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52F025F7B4;
 Tue, 24 Feb 2026 17:46:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v4 5/7] plugins: add read-only property for registers
In-Reply-To: <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch> (Florian
 Hofhammer's message of "Tue, 24 Feb 2026 16:53:03 +0100")
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Tue, 24 Feb 2026 17:46:31 +0000
Message-ID: <87qzqa2fwo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> Some registers should be marked as read-only from a plugin API
> perspective, as writing to them via qemu_plugin_write_register has no
> effect. This includes the program counter, and we expose this fact to
> the plugins with this patch.
>
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

