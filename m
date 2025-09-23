Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7ADCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 11:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1198-0008KK-NC; Tue, 23 Sep 2025 07:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v1195-0008JH-ME
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:25:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v118w-00066D-Nl
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 07:25:19 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1403131f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 04:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758626705; x=1759231505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qphk+y/nf5t0zQGEMW8vPfUD+5qK/36RpDrK0y9TPYA=;
 b=x9eJZCAIosO195WsuPCNBrlSlvuaPXvY0coDyNZDMk4PkyXdRBclbCY8VUlC/UAFUE
 CEeGzjZ1ZkfBVCZgMwgQS+cQNpVz/IHQFcp2wsW+bkscVpJH8ZB0v1AvDKS7tvDlJNfq
 zdq15Am/td2/xxIcTCTcJDiJiQ+yYLSxCbeMPG2SJdhxdPf+HKSzx4qC+xBoacSAPTWA
 7ZtwYDSGxWQ4icN8Rxcf3ayM/sBhovqe00Zsfm75LRZYSVYb0sVmSYumiwDO493bAiS0
 SRGONJ+iVC9DVoqBW0A32gCOzGrpYYoyg5vbh3nKdkBZeVWeLse42www7LEOcDEIkp96
 U8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758626705; x=1759231505;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qphk+y/nf5t0zQGEMW8vPfUD+5qK/36RpDrK0y9TPYA=;
 b=V7uPE0TJWHw1IaFw+NAlRgpL3e8ea1FOOABUrkpNayvsqHgbsc6DGGzgOdLAeQD1ol
 f3+QIJR9+SQBKa1MlHmr8WizRvMbeatur/DhTvUEMYrhJOfPNE4gsdaKz1yBKbRnZpnT
 bBhaH/18TfunVl1K7V6B1BdokRKTmnJpx/B0CKFj9lkiPQ+yRR0KTHdrG6mawlQzxtiE
 Q/z7ZpDro3fKE7OpOhOB9igSgIp3TWh3RTlvO7zT+t2PCYP4HlavQ6FZJkCJAoJ1EiSm
 8BlN4o80zFDIsZ6+zSUvrCXdS3i1nz9Nq+/C+DacMP/5rF/UYknqKb/R0RR9GnOomPjY
 hOlQ==
X-Gm-Message-State: AOJu0YwrXAWTQidIu88BNjiXecvzvu87d5z1kxdexvL/wRkyjIaT2ea0
 6D7h+8CEQUZDh1NIJGsV4JAFM3f83Osu15imptCBpdDGW0aa0lhNuaoOmPuu5K/HW9yA2Fmb0zo
 V7TW+ZeY=
X-Gm-Gg: ASbGnct7UKqu95dSYpdlVMlOEgArZB7bywVqp7XeShUR4/W7yO95mUDtWS9xPRUigJC
 JXh4a1FDXOAaATugeHXXorrA8ndtJbwczzbXyKzucwIkUunImhb1HAAw9pUglwIT6wQWw2Io+Mc
 kSzhJfFil0KF9rgiCMBf2hGyfhM4eIvTqs/y98l3KP/iaDx/4P15FVKou058KVyqjuRWP6OP8+2
 CIYE3tpb07cf0MLx9ffIyhgryeXNwJIolLCflq9dIwz1lvpCE2r6vmmKtnq8xE3zNbQfeVH/7Y1
 a4GK9sQtNgZmS7i2ie2RYVem/0eOxISHhsIc6aLZHgbFWz/JSqlZwHb5IV1tOgGIJKHSsqa5geT
 xUWGAEEbq3RJa30L4AFQ6UUI=
X-Google-Smtp-Source: AGHT+IFcebgSOZXw7pl8V3D4YezfQlXvjumyFcD5E5jTZCFqFPQzYXJVSFIZ/wmXDknYMiHF0gbs5Q==
X-Received: by 2002:a05:6000:2384:b0:3f5:3578:e538 with SMTP id
 ffacd0b85a97d-405d090c99cmr1793930f8f.21.1758626705125; 
 Tue, 23 Sep 2025 04:25:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d14d564sm316435265e9.14.2025.09.23.04.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 04:25:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 897A75F8AD;
 Tue, 23 Sep 2025 12:25:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  stefanha@redhat.com,
 mads@ynddal.dk
Subject: Re: [PATCH v2] tracing: deprecate "ust" tracing backend
In-Reply-To: <20250923074418.87716-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 23 Sep 2025 09:44:18 +0200")
References: <20250923074418.87716-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Tue, 23 Sep 2025 12:25:03 +0100
Message-ID: <87h5wtmmwg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> The "ust" backend is complex (tracetool contains two output formats just
> for that backend).  It is not clear if if it has any users, and LTTng
> anyway can use the uprobe tracepoints provided by the "dtrace" backend,
> therefore deprecate "ust".
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

