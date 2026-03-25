Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BBA109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5PzH-0004Ue-KB; Wed, 25 Mar 2026 11:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5Pz0-0004MS-Aa
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:30 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5Pyw-0007bu-9q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:21 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso842409666b.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451836; x=1775056636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZs/hvIfCpprmX34meJcRXFThk4XvZZHpYyVW4sTj88=;
 b=wFfdUuVwROA8aqSF5tnkxEeEuVJ/13LbI74Jwtx/AO3vA8kfwx+INvbahM2cIJMIgF
 1hN5mqk3+qzz0X5d/2dZKUxfLzbGZohY+y2BEUbLgDo+brGzQCiSfznbv+hKqu8JgMvR
 7akxxTJMwSyUiuCv8uLLNEyKf3vayQT8F7CMy4JfmcS/y6krgjHDiPo30n3qsop9MF50
 CCoLqP5XoEYVXi1TaODgH63//B+a9EqUvuVpoLBklOxoH71W8EcmSilwQtTk1cbLOUyi
 EuWtWnhiUVVNlAuHBP8ZrPWtwmCBYThoIa+lri3ibVolP+AGLsbVesL2hDFMOFkkPfFC
 HO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451836; x=1775056636;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZs/hvIfCpprmX34meJcRXFThk4XvZZHpYyVW4sTj88=;
 b=dE2RCvWN0xb4dZekM0TQlgqcZXPRos+fiTjTlndAhVixXX5qRb0uObp/i3eE6SCHfE
 ZuuOFX2nBsnefZsJ3s/zYIXtoS55cou/V3jxoiy//e+7iSljMQ58a0wXv3PyvF/Lj7WA
 89QtjQ76xwa/9j/lUAR+yBSFcbCjOjfPmejEhe0KeCO09y8c8QfABayfquaMIfEYAd+1
 MLcONys4pQs5aeAw+tWtbDdtdR1HC5EGh7UfeRlL2i+p7z4N9Zyds/QSLAvNFYz3U+wr
 Gs1k4UkeFwwfgkBj+O9t2dNX9kxEEytFLqfFYt6WK+K5kNxVUqIz5AimsViF5MXrqaxn
 1JuQ==
X-Gm-Message-State: AOJu0YzCKy2U3fnVCPI2N+Cwsp8ZrpZ9ApK4N0wRhn+v8sOM5qwnSNGF
 Smzmd3nKKAW1Vpt3muwVFcvStndAtyuDp10sUupD1/KEZuHy96ex1EXBBwuX4046E7M=
X-Gm-Gg: ATEYQzx+7hXK9uoyd/vmnRzUkV4k2Zm49ov7t89sqmVpA6+POcIbflXv7Anox8VCKm+
 UeXpt51D0eigNgtinLaqn4siyT1f5vDUrPsYJ+5ml1Giy3y3WIp9Mbn5gaMyBFt620Gw+KAWsbH
 /CEoxVHKxk06SaL9OMqrDn8DGvhH/C7jFYlmbWttxJlDVWGm7xiJaPEBPCC2QFM6WN9ggtIoS+8
 m2+o/OqlDFcU5ixZTESTDdwZ0NKKde8VbWC6oYfNrARFvyPWTdXz+GltgPZRlXzFwhDPImJTK8X
 LNUe6KJqAE2Icp2n2TGmK54kURHH6n+bSvCur3jCTVwPGBJ8r83aQLpJ40zll7wsOIwKduCJSHq
 3RwGPiQgzAqSDY+CHoQhLMSPwPfbrfA5SA1wGOTznjgKYXA02+a39Y+rEKmNxk9Al+Ayimom23G
 PWprMlaz92islD8TVRx3vTaUE=
X-Received: by 2002:a17:907:7b8e:b0:b97:2a5:8a4d with SMTP id
 a640c23a62f3a-b9a5424075bmr267642166b.26.1774451835821; 
 Wed, 25 Mar 2026 08:17:15 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dc51sm811623466b.22.2026.03.25.08.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 08:17:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6B45E5F878;
 Wed, 25 Mar 2026 15:17:14 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 2/3] include/plugins/qemu-plugin.h: add note about
 endianness of value returned by qemu_plugin_mem_get_value
In-Reply-To: <20260325024252.3369186-3-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 24 Mar 2026 19:42:51 -0700")
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
 <20260325024252.3369186-3-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Wed, 25 Mar 2026 15:17:14 +0000
Message-ID: <87wlz02b2d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/plugins/qemu-plugin.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
> index 2ce7a7fb6c3..4eb1d2cd85c 100644
> --- a/include/plugins/qemu-plugin.h
> +++ b/include/plugins/qemu-plugin.h
> @@ -374,7 +374,8 @@ enum qemu_plugin_mem_value_type {
>   *
>   * @type: the memory access size
>   * @data: the value accessed during the memory operation (value after
> - *        read/write)
> + *        read/write). It's directly stored following host endianness, s=
o no
> + *        further swap is needed.
>   */
>  typedef struct {
>      enum qemu_plugin_mem_value_type type;
> @@ -682,7 +683,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t i=
nfo);
>   * qemu_plugin_mem_get_value() - return last value loaded/stored
>   * @info: opaque memory transaction handle
>   *
> - * Returns: memory value
> + * Returns: memory value in host-endian order (no further swap is necess=
ary).
>   */
>  QEMU_PLUGIN_API
>  qemu_plugin_mem_value qemu_plugin_mem_get_value(qemu_plugin_meminfo_t in=
fo);

I'd be tempted to fold this into the change that makes it happen in 1/3.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

