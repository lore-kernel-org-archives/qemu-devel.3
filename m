Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40930FF8850
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 21:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGOE5-0001Ig-WD; Fri, 24 Apr 2026 17:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wGOE1-0001G0-5h
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 17:38:14 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucaaamaral@gmail.com>)
 id 1wGODz-0001s6-5X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 17:38:12 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2eadb000b8cso2794863eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777066689; x=1777671489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4RNtRIOGWI9bNPduMVxre8fY8FEj8JvBgHLA2T5q3s=;
 b=E92ZHRZf1dPI/Duag95ANGJedi1apEYeCW8sshJKFr8oyN+VyeyjdHgBIUcD5RL7ce
 q0kyryvAs4igcsUlzvULtxol/WQOSIrbr3GMUge/riCpw6h9xNVMxaKpMQp5QdswwYHa
 GIlv/T4XW6Mlc/8v3WWTTCt2Iy0zTXelYpz7KPGtNCrSl+jCKGUy0U2unIyk7VUcCW2Q
 piR/we9U3QL/SKqms5z0sY3cESy8n9IC7tXT6jJXwxX+ugvoPsBBQHGUTCUgLlxira7e
 c/DSTAOmlpHMim8rRBEZKU+0HkTXNajNkeNTJXyphEw5vg9JrOKcfor4u9oRXdzx+0PW
 doCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777066689; x=1777671489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U4RNtRIOGWI9bNPduMVxre8fY8FEj8JvBgHLA2T5q3s=;
 b=gXN84CiMFiU+0r5itKZEFDTqcHH7IuFYAIkfU0H9b8P75ubmZVWZCgNf6YGn9b8ZMo
 iF+w4ANXlY8JKkiY2oONoeUO0HxKZ1AOQIsdiGonivViFjXvRfKopRYpdtrUH4sS0MPj
 t0+8oGaFE/0aIR04tN+NLEPrek59SLuR0X/e/WiX0q92mPNzTIVTluKmapWWZDgrH1zL
 rYbKqao0L47+t2UV8lc8BKLTffbe3fwBJsKyqO05fNyP6LKI4sN89MshSPpCvGrMTzNQ
 idsuVGrHF034IKaEorpoOV/3wMzOdOvHjm4QVMR6gM4xEooYlQtoKHHH2Fbwn5wD8ANf
 JXig==
X-Gm-Message-State: AOJu0Yx31GIsUl5CswAMGNeaMpbzY4qpKlXFUj+3KD4xYf17iIqFVPMS
 Gy9RfXd6gHC/YEOVpRmvug1aLbGrROy5wOQu6xcZpSvnMo8Qb3Qep1C5
X-Gm-Gg: AeBDievyrM0KNjn7h335oAeoJajMyk4FxfU8YFzSmkptmNzD/RiHZ94YKHYPCd0Usm5
 6a1aCSYU4zN4eM/kn6qYSUVi3AFR0Wq3CTnMtweIOiVm4JbMx5NG5AcLEXc83je2BAJ2r0bxPOw
 D4/p9daM53VKW8ixwirUfx6SwQtVIEnW6oRg9GKKwLOQK8mRt8/or8fU16jDMVZKtxtW0/BkXJf
 SRyZInXNX0OQ2YL7t1XPunEw6/Vbnt9XJhg7i+E8BmoSeoJNuxKMpmaMzgAWr45HQsq+2BguVSk
 cbOtVdiqeQazA9qFcm1yiSZs/Tc4xKI8KWxMxw9KJw+ldoUzALVfzKovZH3RyHB/ppaMraFgq5r
 F+AbqoIbIwbaGuFwN1+mRviE8oadmbY6RZjh9xGA7/Gpa5qGAvq0cv8ZVZjyCoIsdIWokUlV2Jf
 Yoz2Cn4SjGL41UKnlASO5mQoimw/1sngxJFc5jBPxtzg2O6MR1NkErSv0dQWqVyTQh7LOIL11oc
 w==
X-Received: by 2002:a05:7300:f193:b0:2da:1874:f39c with SMTP id
 5a478bee46e88-2e4657728eamr18454732eec.12.1777066688781; 
 Fri, 24 Apr 2026 14:38:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:c030:44a8:6c9a:9faa:5f6e:c92f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e539fa5c86sm40814517eec.1.2026.04.24.14.38.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 14:38:08 -0700 (PDT)
From: Lucas Amaral <lucaaamaral@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Subject: Re: [PATCH v4 0/3] hvf: map granule abstraction, configurable IPA,
 and MAP_FIXED alignment fix
Date: Fri, 24 Apr 2026 18:38:02 -0300
Message-ID: <20260424213802.45423-1-lucaaamaral@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <8ef0c812-0dfe-4972-b68b-2afa570e838d@linaro.org>
References: <20260317175744.32469-1-lucaaamaral@gmail.com>
 <20260423172210.51760-1-lucaaamaral@gmail.com>
 <8ef0c812-0dfe-4972-b68b-2afa570e838d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=lucaaamaral@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-04-24, Philippe Mathieu-Daudé wrote:
> If using a generic approach, the property added in the previous
> patch should go into AccelState, at a glance registering the QOM
> property in accel_ops_class_init() in accel/accel-system.c.
>
> Also HVFState::ipa_granule -> AccelState::guest_page_size?

Would you prefer the AccelState lift bundled into v6 of this series,
or done as the separate follow-up after v5 lands?

Thanks,
Lucas

