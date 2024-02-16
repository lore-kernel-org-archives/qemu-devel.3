Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85431C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb2Hr-00057W-IS; Fri, 16 Feb 2024 12:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2Hp-000572-Ee
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:46:10 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb2Hk-0000ak-Ou
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:46:08 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4125296400cso4050015e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708105562; x=1708710362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhSiKCQ1RmgHuvil9uZNh0ePOacWjZjT3xeQu/2aX1E=;
 b=SKPMg+qagveJW0vLqLL5SJHbD+rhSU0DKLK/gNsv0IeGRgwF96V6W3OBna7c/z6msF
 I/zxnqkGUqaxe3dl+muUEQKvZRwIFNkmcsB3GeoNio+0UYWf25epTHqfwq8I23XjTui1
 yN1XMZJ5PwdwNXea5aOk35ow2UMmA5M3n1GAxQtM1M0hC4MJvWZFU4UifE9/44A1N3ru
 mxw7Jm9NMa5ykKinqWnE+FLqYeOOOWYtJaXxCag8n2dGt7ssUaUV8sVbFSUV7rGfUsS9
 MpfVmRdrkVQHZz2nnf48zIa9dXIgjIoMIcLm4+I67mCPb7Maviyu5opTEFiU6f6aTiVQ
 rPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708105562; x=1708710362;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mhSiKCQ1RmgHuvil9uZNh0ePOacWjZjT3xeQu/2aX1E=;
 b=ZatQVIulGO0GMRuYzc3bejD9QsoNJSBVWPTu38k/1o92yn9+WZm1GpREuRDAmuATnw
 e/tCRmka3IiB9S+N/qtoCZKkR4wwJr5vRxnIH/pM8ZHGJH2zyAM9hzbpCi1sMlujrVvh
 KFi1QEvVmnK236j3KDEff9ezVYv/ipeydNe7RxdKXKXlicHAb+vIS0MFtsNEFvj6KlLQ
 6sVJ/W9T7bp8XkAZ4LAHZdreQDtv1ZTTODtKRMplh/OkpcKNInkavTJVUm98Em5NvDNR
 mcclHLD4e6FkjZ3WeA2pDP3XztDHj/Z455KcaxqIuW3Gbx9nqx6yMFrpWl3Q5pKjF1lU
 +y/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO8LRbeUHrBE9H98mzWzhpgq4X4t+1lfHmz1YfBdj8qcyVOJjPvkkkIviYMSM4p6oIAajZyjN5a3JZytVjjdL2HLSc334=
X-Gm-Message-State: AOJu0YyjjNp5XQA8iY0HYs89VX6Ipd2+ZGTwMAE2h7xxpKJ5JagVgtMf
 FgdcRuEkQKSYUO/cXCqYGjuKUQrKogFUmfti9/ytj8kvYExS23UfUlewODYwQ+g=
X-Google-Smtp-Source: AGHT+IE5ayReP1WyyCXmkedsK3KeVUQMqUAiU/xuitYpKwYxaZlU7PCsG8wMil631PBq2ye2bqsFPA==
X-Received: by 2002:a05:600c:45ca:b0:412:2c76:fc3 with SMTP id
 s10-20020a05600c45ca00b004122c760fc3mr3072408wmo.34.1708105561952; 
 Fri, 16 Feb 2024 09:46:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c290500b00410ebcf8180sm2899511wmd.43.2024.02.16.09.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:46:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57FD25F83F;
 Fri, 16 Feb 2024 17:46:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/11] gdbstub: Introduce gdbserver_fork_start()
In-Reply-To: <20240216130817.369377-4-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 16 Feb 2024 14:05:30 +0100")
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-4-iii@linux.ibm.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 17:46:01 +0000
Message-ID: <87o7cg2tgm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> The upcoming follow-fork-mode child support requires knowing when
> fork() is about to happen in order to initialize its state. Add a hook
> for that.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

