Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79211C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8yG7-0006Vl-OQ; Mon, 20 May 2024 04:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8yEy-00069u-42; Mon, 20 May 2024 04:19:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s8yEr-0007Cv-3o; Mon, 20 May 2024 04:19:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f2ecea41deso57723535ad.1; 
 Mon, 20 May 2024 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716193157; x=1716797957; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PAYpCWwcQATvupcV2tgualSPZZA5rb1LW0+/UfgwQkI=;
 b=ZpYWxL35cYZWe4v6pBZF4i4tPTyQCWkkt1ilewM0nsUMzobs24X4D6VBfAfvf7UDnE
 1osX+qvzWHtKqsLFy2cQcLCM0VUNNel+GZxzSQBRfa3+7ud1Tq/9A2FM2RzotTAWQMtJ
 FC31dYjlfTTpglRWiFXsIwsyIxoWG5S+BhUj6ElWneBYfRHciVZtH8Hh96p/Jy7MlKRi
 QRCmkDexu1D/Xh19Xmu5GNLxDpVBkU3QIFu2bQzY2ASZedSwrd98oGyWK51TPPAgdoKV
 Dv79u+DuZCIjVF8lWB9yn5g1h1ae+kqlVIxdKFnQSk9jNX6MeVhjqrhIGygP+Hwil3DM
 CCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716193157; x=1716797957;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PAYpCWwcQATvupcV2tgualSPZZA5rb1LW0+/UfgwQkI=;
 b=hsK05ogDR+c96wP4mAmpCVjPTSbk9WPRM/I+KyVH5xqNtF1d6uSu6ZBA33MQX9Rn0+
 7Qlk4CG1UFAOzljMwUWQc0IeAr+AHWo9i3ImOjQNyoOe9ffx6ZziKM/pCTwaO7hKNGja
 3Pi4n0hA0Wwydh9dTbWUiWjWpv9U3jqz0boO8QbHX4UrBRAcPIRlVY2BexmA7PSjA9mw
 NiBhaQ7oUdsY8fD6hzIOngiqIcheBxdCPDKqmBxYpo2MidVr1iUkWyBMHq/z1lBbqMcv
 oj/bUM89d92NjmPKJOcM2Rbbsz/oo6j4PmGrzutabiihLTlh8c5hb6OZbwPkTKbgZmf5
 PD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5KF7HZcfesYg0PY1kBYZyC3tFiHaczpIyXvXU0Rc3FtebA/5/UNcvJ2SOHRaiYjX69FpdcLPnbZYog5X4IGmM8ODulCPbE8fmLrcLbWXf12segtNeN5CubYo=
X-Gm-Message-State: AOJu0Yxm0fNP9kzvd6h2v0z7W5o/6vUEnceaEi76Gpw2jVKO8uO6aXpi
 ssoFJw3wSF4mA1bdaUhqFk6I18qrgEGUg4UQ5D3B5tN3ffIpbwne
X-Google-Smtp-Source: AGHT+IH1YapN3itLGtuVif1hmKwKiLGRpJyAjinPbWn72IB64uqS8WyjzVwvjTmXGZwe3vrNltRyKw==
X-Received: by 2002:a05:6a00:1887:b0:6ed:cd4c:cc21 with SMTP id
 d2e1a72fcca58-6f4e02ac739mr34767891b3a.13.1716193156109; 
 Mon, 20 May 2024 01:19:16 -0700 (PDT)
Received: from localhost ([1.146.114.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2ade27fsm18605744b3a.108.2024.05.20.01.19.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 01:19:15 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 May 2024 18:18:58 +1000
Message-Id: <D1EBOZTRN8SZ.Q9F4CFDZ8VYW@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>
Cc: <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <harshpb@linux.ibm.com>, <linuxarm@huawei.com>, "Shaoqin Huang"
 <shahuang@redhat.com>
Subject: Re: [PATCH V9 6/8] physmem: Add helper function to destroy CPU
 AddressSpace
X-Mailer: aerc 0.17.0
References: <20240519210620.228342-1-salil.mehta@huawei.com>
 <20240519210620.228342-7-salil.mehta@huawei.com>
In-Reply-To: <20240519210620.228342-7-salil.mehta@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon May 20, 2024 at 7:06 AM AEST, Salil Mehta wrote:
> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.

Patches 6,7 seem okay to me. I would like to see a series where they get
used. Would it be possible to include at least a TCG user in your
series? That would make it easier to review and test.

Thanks,
Nick

