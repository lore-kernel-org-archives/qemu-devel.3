Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAFACD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYaY-0001Us-4T; Thu, 11 Jun 2026 02:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYaJ-0001Td-E6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:08:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wXYaI-0008Nl-0b
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:08:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso3916022f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781158088; x=1781762888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qlCu/b7AY5nQCpqp1+2x7acIdpnrvXROwBiJaZvmHFU=;
 b=sLlGz2O/7Z18+yw3ylIIVJc5cPSnoBQdBxnAlmhkypMnED7/CONANphOrYMBypUWw5
 SGmd9W33MjLiJfh9BEUee9nuROH2QUBgg5vMGNvjLfC6gnkq9MsRAr1WL5rWgTvL6ugX
 thM/mJjHp9ZLPTvwnme9dK86HJZjLarGF5HosACaN/LxAobF6kpUR+Gn9F2MOtOgt0jG
 zIiUrjA37upBu8dO+BRvl+SZTHiCQKVAZIgjJuos60dMuEvx5AFT8X+aJH3u3AuzN8RW
 8rQQsCTEO5JCctE1jqrvjDkYV+iVb9nwkUegWhG4UXuYlzbYovDrQtsTIp4+XyVSD1YB
 8DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781158088; x=1781762888;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlCu/b7AY5nQCpqp1+2x7acIdpnrvXROwBiJaZvmHFU=;
 b=pwkhaiVdkgCRhcAusJuNXdgbVqCopHlsDV+Y50OHP6eo6VDKYXwDB0gZyCb1dSJ7iP
 b3k76lVkaDXJ+3XGcksa9x7zm0ctdgNQdMXrQDFXp6jC2mD0x/duWuxSmHAEfrgKi0IH
 m8GXgVOanURCcKvm1Ioc1P45DIUb4irOcBPQzBAtg68YKdJig8+9tDiLei62yzlBTmaz
 P+89HYLBEWiFFafSyhmFvidOPye/nvh8ni5i4jGqaiuE0cPEVle5Pecm3+/1E/T3jez3
 i8trotB9Hi/pZoB5fQNWgyC3VfqBHP5UrJ9DaOMEv8GSoFL6/C6jfJGw6ian2O3t52/f
 Ghdg==
X-Gm-Message-State: AOJu0Ywnjfhy0C+H/lLUHijz9NDdVPvtigRCNNrp2Nq1b13BiTz0Fcoa
 6xuIY0chLpyDZf+sfWNLQceDrw4QCpL6YD2lTMew6ocBKsyjAm/QWAaxnCsAM5++i7JehCIqZvm
 j3ELF278=
X-Gm-Gg: Acq92OEzqm8rNsJ+MQQrGT3L0yX60VvT7r/CEQ8j3RDnmqbr06MOfdJdbbDj1wooMEc
 QHV6KXJfWX6tBLvCnc+8jo12WbKzwqr10ZOkc7B+k9phZ1NUIf/6tsWo/++01/qXwzXuE7mCOaS
 PtCCLS+JdggnYDJjiO6J+RKQgfGR0mUwRdhDMzUP9ek+H38yr3mg+hUQQDwDeV14UgfB4mKQnuX
 uP+BuAxm2DO1px2U87IPiu4WxxjDlnyC07NP3ZnBCpZz+E817jagD+AoEMhegIbHwi0yb3I/E1F
 ELP0fKU1JZsGUH6fkEnCjxz2iR80iXE4gzWUKR+RHF7yI6SeXCpJ46rizfOPALTiFLaRMk3HEH5
 hjAFmD/633ty1iTAX7nA0WfXJcCQ38WdovSIIE3oJs9LfdJpGAm4uTQm+9JUS3eUMPUMqDvQRbP
 lALzitajNdO2PrZFoyCGkxhmI1gNMG1YN90gBMtMqNmbZiArIYLUw6skRgYLPLY/wSFJb5AVj+b
 lpeKMa5DHXBKV1u5wKaAtZ1Mi9uI4fpIC+FgTSg2ypCYxfVBMYIwSjh0HJe+w==
X-Received: by 2002:a05:6000:4b11:b0:460:660a:3647 with SMTP id
 ffacd0b85a97d-460677c111emr1897678f8f.25.1781158087678; 
 Wed, 10 Jun 2026 23:08:07 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-135-61.home.otenet.gr. [2.86.135.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dce6sm70496752f8f.30.2026.06.10.23.08.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:08:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:07:44 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 24/25] scripts/checkpatch: remove check on forbidden space
 before '[' in C++
User-Agent: meli/0.8.13
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
Message-ID: <tggedi.3834rhzuw09kn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

On Wed, 03 Jun 2026 23:51, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>Lambdas are very confusing for checkpatch, so just relax this check.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>---

cpp lambdas are confusing for a lot of people I guess

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> scripts/checkpatch.pl | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index c74ec070c53..d90aca6fcbf 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -2423,7 +2423,8 @@ sub process {
> #  3. inside a curly brace -- = { [0...10] = 5 }
> #  4. after a comma -- [1] = 5, [2] = 6
> #  5. in a macro definition -- #define abc(x) [x] = y
>-		while ($line =~ /(.*?\s)\[/g) {
>+		my $cpp = $realfile =~ /(\.cpp)$/;
>+		while (!$cpp && $line =~ /(.*?\s)\[/g) {
> 			my ($where, $prefix) = ($-[1], $1);
> 			if ($prefix !~ /$Type\s+$/ &&
> 			    ($where != 0 || $prefix !~ /^.\s+$/) &&
>-- 
>2.43.0
>
>

