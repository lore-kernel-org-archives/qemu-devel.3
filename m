Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C11DC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkwP-0002wg-5f; Wed, 07 Feb 2024 11:38:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwL-0002t0-Bp
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXkwH-000683-UI
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 11:38:25 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41008ab427fso7700515e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 08:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707323900; x=1707928700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sv6+6UUCSeP9lDN9ptL/PjxKqIdnYqTvePhCbUVP8t0=;
 b=N5jsd9Eebr4ArqWnSXBa9iaQ438x/q7V8XQAXZEXZr1qRsRkuUIT9r4XRVJRMznGpw
 bPYjyLsg1CPxy68OLFmbUZfkVmFW4Gxe6+kLYlRvwYnNB8/xU+S9eny/2f711ncfeZhX
 OdQTdY/pDa8d7npNbnbkpNrQ7FJIiozpOkWifmhYo0KiYf0aPo1KaZUXbluiF9AY9pKz
 NwNJ3sdF1JGfFUpZw1CtfOzMWp9afn5yYlAqN/fyXROzznq5R58r/FVV8xWV8XUIBhEm
 HmGWMiFk229VY1THL6xMgikWUAPzLNyYziZCJklrHnY8jawzvBuHu5UYMxq4c7Ne/t3u
 kvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707323900; x=1707928700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sv6+6UUCSeP9lDN9ptL/PjxKqIdnYqTvePhCbUVP8t0=;
 b=pL1DVB+CfnUWy38uYYkBSnpSXSA2xo4GQPWPwbW9WH4js1EsC44fUWh+R+Ii3yrZPg
 jSREkY+T+isJyEjnTo93/XU2mcEmIzRosewSeUxIt5Fq9Kk1c/4kLhsbbARSZHL/nqHD
 xnW9p0zKvw8NiiJ8p7EHTHYvmiqdEubLwa1PvkpKb+CTR/FZ1U4hcalLvgjZzLCrQINm
 WBJ4HNtK4zTRzCg6S+XLgi20KPxzBA+QIa+sxIjROu48SC2W/Gdql8zvKC/7IHQdRnvQ
 WLyw0imJDB0qa+wv+hSTF8pG4IpJzSmK+YG9xgX68KawX8J9T46qrSoUnT6Mo8DVJQx7
 LYSQ==
X-Gm-Message-State: AOJu0YyvQnKWTqJX9nBdUOiYl50VVtmrXGt/bxiu5MWOoIdRHfohWGxe
 33eaXr04Tp2FW2VA8nbJoFLYNWK6eXd5oatMfv8CuYtJB0okAVQesfX4Xls5SXs=
X-Google-Smtp-Source: AGHT+IELwPIEg9gWx3ouz5N0hWJp20glM2q6RyKduffMLrY91xLqU1zUfcajWqOsQhUxRG1mZbaNtw==
X-Received: by 2002:a05:600c:3b97:b0:410:8f2:262a with SMTP id
 n23-20020a05600c3b9700b0041008f2262amr2251051wms.13.1707323900427; 
 Wed, 07 Feb 2024 08:38:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUc+/g0VBasm2gywElwD8kgkQjRnvf+5mxqMQ475EaW3HDaBUlVqVt7TNQPLz7Hzmn8LVcnhGm48FKUkWT9Pxg90l511VSDBEDsWrCWkasgdcXw2uF/eFqZNlY+XfQgKAolJE5FqBu5ABTssn0oGjz+Y/3BWQqkJyrVTJTXX4Z6/x/2/9KbSYmyBiz4FmqQ363UhlfE4q3VKzNNFGZzSSWtswqqFwn3goXrqLR+XbFGBizgh6JIDHcE6obEgc7AYd50t8cyQlePKyCCRUKYRdUMR2OWOZJ6r2nvtxvfmGLLEgJDuxjBfdg40MQ5MKtt4Fk0ObLAbeh34lu/Uc17ZrNsXOVWNqHFLmdrRO8w5DtLsc/Nn8uikVkWvliX33qA3FWnf/sp7FcWGluRcx/bnhE+sxNldnp25XZVgj9A0WbPFJ8+oif1EJW+MWknZ2JSXMP6whEmMxI1eu7kEpS5cfD9JqFm0Qd86btp0eO0sAPmJB1TVau8Xp+SU4Kg3Qthdrp/HNbERDE8ngelmfVlf4d0yhnrk+qzxZTcb1PvdnSZYtacNCAAdjw5kN7W96s/ufqW7xBl+oKvGLtFQvXkOlP+nsqmVkJlZLmLYTjSDf7Vxy/IYj/M7DRYIDhmxPJDy+mhxGMScrSfWL5Yb1hfbpAV7pvZcQ2GyNP7N1bzy77WybqmciVkxjq+v3OYdgSuMv8d570ta7ZkgdBHga4DqgCqhaZJxxKON5bg+JgLjED+9ws8xYElslpGRrqgPjCqHjjd3i+ieb+LyxpOSVaKpbb7Fi0K720kVgDJ9DNX71gVWGXAvsea1gYMi9KrSsOmoPOT+55TOQGpfRt7kNRixr3RZekv/ga8mFZEzZ51
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m14-20020a05600c3b0e00b004100826da82sm2653265wms.21.2024.02.07.08.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 08:38:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A44A85F8E1;
 Wed,  7 Feb 2024 16:38:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Chris Wulff <crwulff@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Marek Vasut <marex@denx.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 06/14] tests/vm/freebsd: Reload the sshd configuration
Date: Wed,  7 Feb 2024 16:38:04 +0000
Message-Id: <20240207163812.3231697-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163812.3231697-1-alex.bennee@linaro.org>
References: <20240207163812.3231697-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

After console_sshd_config(), the SSH server needs to be nudged to pick
up the new configs. The scripts for the other BSD flavors already do
this with a reboot, but a simple reload is sufficient.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240206002344.12372-3-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/freebsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b581bd17fb7..1247f40a385 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -108,6 +108,7 @@ class FreeBSDVM(basevm.BaseVM):
         prompt = "root@freebsd:~ #"
         self.console_ssh_init(prompt, "root", self._config["root_pass"])
         self.console_sshd_config(prompt)
+        self.console_wait_send(prompt, "service sshd reload\n")
 
         # setup virtio-blk #1 (tarfile)
         self.console_wait(prompt)
-- 
2.39.2


