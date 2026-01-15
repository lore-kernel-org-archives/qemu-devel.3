Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A574DD44C73
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQO1-0000lL-3c; Thu, 15 Jan 2026 11:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgQNg-0000gC-RN
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:39:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vgQNe-000147-Gk
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:39:32 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb03c3cf2so822563f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768495168; x=1769099968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YKyqcYpQlpsGw+rw48wZ3ZbsmYrAVtuJTBV3oDTMb8=;
 b=HP173Hs3q3x+oWqabWlbE5+LCzN2lXkRwfDGisXcgoQMhIvv7+wzYYMhXBOReu2ab2
 JXNsGkCUtbT0NbTSBty+j5RMRLVHDbTSRCO/cyJSADbLhAtumCPu28O/BxN+AmFSuda0
 vlhZjMw8ki5KaaqP3sOOKCbvs6HkJYwtMyUOzXmZs8yN99cPEmSOUmz0shl121OAWrnQ
 qCnGmBHGpCRImwyFTW99EgbvuvLzspWCHgDsm24O5zxHx+H6EaqcLKkKkxS1MBSyRDGy
 yVP6XF4T/8mTVqGJQUbwLTTgBPRigrKUMPQyhq592FXC6HvPZUaDm1W8JfTvOQW++bNE
 nNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495168; x=1769099968;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9YKyqcYpQlpsGw+rw48wZ3ZbsmYrAVtuJTBV3oDTMb8=;
 b=p+AaBDSbEjXBxyMpOUIAIoCMEBzErFkIIcSY+gxc7QB2dTVxwl2dTEvUh5TSKD5Ah5
 be8UVOsWgV/WTF8kosncHcH6uxGk/yXmSI88LjUE9DcSy/RFJWXBFyNJhtMCAaiGTcFN
 IpRh3Rc2Kt2VnNMlL7calqzdGFO3Bq9PgilctVqoWZ5wFmlefXj7jeo4lAydHLvngIZw
 bKYt2lNvMoRTgSIY09/vzb9MCpIFc61kEDvzLtGMwDK7LJUJctk7kW0UvsU/LYIJleIH
 A4a877OPn6uOhcssFB7OQuhvZ74dzbtGZnLbuUkcF7SRpVmw6kJmwjvXESk4BBOe3jMG
 VkIQ==
X-Gm-Message-State: AOJu0YwX/RrjRk7kM8Cr28Q2eDEPanfBE3i5Rns4aYQNpiD21C2tSJR3
 QwCpAUg/yP0aFSpRGckqZKNv2qWuGa3NWd8FoHY1tiut27cMFc1eKF/yFiPcLmLcUCc=
X-Gm-Gg: AY/fxX7NG6njTsnegjsXoKA8bvKCPkYqxZwthkDWAbxzR76IjKlPlHKkFOBKhMvM1VN
 4slLD3LsrSh+oUarcadqQPep2R27DYSl8/MA4T1lcXhCnRiXSqtFW0QS1IYq4E6oJJ3D+N/lyhB
 07tWDaRKepOTTVcQE5qRZFdUtx9mn9a8t+t+2nxCC5p5ChIEWeNisoI7Llxhmd020v60aCgG0Hk
 Mjs0YLzSU1EHKNA7ELbcDOuea8at9fvmIrCOP28Se1j0dR/dFlitEayD6cQYdnO3XDF6UtGN+do
 TFe9vBJUtCKRXSnVNfyaz3K03H02XPvmQLJ5MxMXb590XH8hrDEx9fX26d5W2Nsi5Ipge4xI8T3
 NyfhySFcqdJCYymihirtGHvlxOfd3r/EVzI6TXAYk8tQwHLtkX+qden402+ZKqZkG8LNX+gtqua
 wsuWkmXtDxMBQ=
X-Received: by 2002:a05:6000:22c4:b0:432:4c01:db15 with SMTP id
 ffacd0b85a97d-4342c4f3969mr7591095f8f.2.1768495167862; 
 Thu, 15 Jan 2026 08:39:27 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569927007sm691f8f.16.2026.01.15.08.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 08:39:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5774B5F88E;
 Thu, 15 Jan 2026 16:39:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Pavel Dovgalyuk
 <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH] tests/functional: Require TCG to run reverse debugging
 tests
In-Reply-To: <20260115161029.24116-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 15 Jan 2026 17:10:29
 +0100")
References: <20260115161029.24116-1-philmd@linaro.org>
User-Agent: mu4e 1.12.15-pre1; emacs 30.1
Date: Thu, 15 Jan 2026 16:39:26 +0000
Message-ID: <87y0lyhltt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Record/replay is specific to TCG. Require it to avoid failure
> when using a HVF-only build on Darwin:
>
>   qemu-system-aarch64: -icount shift=3D7,rr=3Drecord,rrfile=3D/scratch/re=
play.bin,rrsnapshot=3Dinit: cannot configure icount, TCG support not availa=
ble
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

