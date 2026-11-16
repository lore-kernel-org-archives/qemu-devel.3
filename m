Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F72606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cbO5UC6z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSuAe-0003Br-RT; Mon, 16 Nov 2026 05:42:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adrien.kohlbecker@gmail.com>)
 id 1xSuAc-00034J-Vc
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 05:42:42 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adrien.kohlbecker@gmail.com>)
 id 1xSuAb-0004q3-DH
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 05:42:42 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b7221c0f2cso5074536a12.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794825759; x=1795430559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:subject:references
 :in-reply-to:message-id:cc:to:from:date:mime-version:feedback-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zWuNoqeoSh1vAyLBGQhX7dwfcuJ56wLP+t1fp3dSgsU=;
 b=cbO5UC6zf5p39aQkXC05ydHpUnP0Wud5cf0aNXYGV/mpk2xUVSJzjwHYuMI7e+vVdr
 1LYQTznLkjVXYkMNQO27ik0gK8xb2Gpx+PF7yJnUVLf5G2lKxuiejeFjUMMdEnKz9YTI
 zCQBafUNlsov0v8Ei6juPFnxgN3xjOmoIXPlNwSJEzTtZkU2BzUd91pACo778SsruEW+
 kdCs4rP8MZ/G04ma6ozEuXWn85GnOvEUY8uUUxWjkQtM/m0XtARvu43B/e6IYqdtxpKr
 uVzsMcilOih3iGSxzC36tsR82m4MwHMeMRuX0v0ZwLiwefBjf8QGbVh4en/Vh2TDzUAx
 e6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794825759; x=1795430559;
 h=content-transfer-encoding:content-type:subject:references
 :in-reply-to:message-id:cc:to:from:date:mime-version:feedback-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zWuNoqeoSh1vAyLBGQhX7dwfcuJ56wLP+t1fp3dSgsU=;
 b=kHkEkuhyR2LkCgTfGn5ufnr0Mt1G0xsg295dEXJ1zYmIeuc1XNX3LF8lIq9AXB2bAg
 PgQawPI0yLfKgMmBSjC7hcw2z3+/jz5KrOtV0KRgn884Mx20Bg/HydqPTcIbkysANMy1
 XU0gRXBH/HpSc6V8qC1F0HLaJIUMZAc/aUCMQPyvE+AH5ETzfCqOPU7FIWQgpWak3Muh
 Y895b47u0hmaKcNsV9YMIrUJYZB/NqeKnAvRx7XV6yUpuevN76WlRvj9Ht6H645vVeAh
 BGRMv7V8of7JGWL+FdnFigVsff2dBgBm3tjsvnx6+dmAX3Tg9Ff9q2qNAGO4WOmRzi/I
 n/XA==
X-Forwarded-Encrypted: i=1;
 AL+hErGOBH/1Le2DcQI92J1fxzQjh2WM2LRw8BrdmNK8a6+xAvB8yQLm0J12674smdH8cljllmOOcCU/Hvj1@nongnu.org
X-Gm-Message-State: APuU4Z8q05swsYmO7W88P6TDbJn1Ty/YOmB/027EOHHEb5sx+kCiwXg6
 MUA+uNOxnHHBQxDCIFYhvyNHrKz6Np2K5OAd7AikHXm0odiXsbWpsa+w
X-Gm-Gg: AYBFou3YW70YDe7JLEH7jiApcc70LePIwRWeDoBspskk23yWZeN/7yi42q/vOmj2nJ2
 xKj+xvEopMaGCC9wMpg2v3jfXuy5jW2JvnOXF0tFWAJQ0RKA1ai3c2Ondg/AQq9x501GuyvWszm
 Q1+JANMdnm1Fk2Rm8jIy+9xDz9rjx7fUkAziwUCCX26HGM3DWrUZA+i3olQVnEucUP8gCbXXfEN
 +d7w3hFQqEkFwjcPa0TqYLEb75gnZKLht4Ni+RPFCOAPpzNifUFaD1f5c7ZpHzZaOBchTWQ0w0q
 04cxUyB4GvLNvDKjVjgTR/eUyrKj7N0asBaB8t1hFPJjiV5llvRSXhij0zGlGzKiVshFwnLJlK2
 LKNoLou3JFlHUWSzDckhgPD2Q0tEi2T5CXkYZNJp0+WxHkfIMPUMwHre271O+3oYsfNI1LHiU/a
 OzKFwFVSpxYldF0FUIZvT43wVghuVN09S4b3+SRCPNS7oqba49wpGliFgmHHFYrjNUZpHxxnqZm
 UYBBRMyKcVvD8aTY1VSdd7b51cwVaykSAOH65oJbrvnxVV203UaadaJy8mHp33fuMCYvaRahsVN
 ICV2cuLWx8dmsBQkvg/E96vXS98khMp+nqA84zVPRJU0HkGlyXAAtWcsA4D3m9U3T8rS4wlq80i
 hMhgNaMakPw23QENvQXNXgJ+x
X-Received: by 2002:aa7:ca50:0:b0:6b3:e89b:126a with SMTP id
 4fb4d7f45d1cf-6b7c0957c29mr5924746a12.12.1794825759082; 
 Mon, 16 Nov 2026 02:42:39 -0800 (PST)
Received: from fauth-c2-smtp.messagingengine.com
 (fauth-c2-smtp.messagingengine.com. [204.75.18.201])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c266cf12sm4533813a12.37.2026.11.16.02.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 02:42:38 -0800 (PST)
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
 by mailfauth.ams.internal (Postfix) with ESMTP id 3CD52198003A;
 Mon, 16 Nov 2026 05:42:38 -0500 (EST)
Received: from ams-imap-01 ([10.64.2.21])
 by ams-compute-01.internal (MEProxy); Mon, 16 Nov 2026 05:42:38 -0500
X-ME-Sender: <xms:HN76arIVQu5DCRbiA4syYH3A-imZ7L7J1LSY4wfAIgSFpFNHRhWBZA>
 <xme:HN76ap_8RwnjvVUhSFd2SlLo1Ij7LBMD9AAILidfdPvVaCXjP6KrpKetbJIualWio
 Jan5tjL2fF7cesJyBu4k7tb9Xbl4RCS3XLcSEFM9wnxT_slKi7hcMij>
X-ME-Proxy-Cause: dmFkZTErGIIJQ65Ao5wFtRlXnsVKPxgOHygiz0gL8HlMpsed8ZNjY+1LJ9qak/QXyzfUkW
 CSZVRxzIHqTRG3lQBvnqRzTONYKHS63yYmjLHymQCOb8Y72pn2nSs8A6lrwzHKUawbBnQN
 Nbu3F7xqGkGafmXWTNGFuufDZaGhkCH7CxXdewgKArYZhS/Z8MYu4S5qKyWWWDspxOGUXd
 p+bEdt044/BnoAu0co4xsV15yw+R8Knak8/tGvSg7Sj4TzgFm4UbdAuBmqCvxALLij31Qf
 0JKvCU5PMsoNuD5BalJpsBM80c/8E5s7i+7cDOhCIR1+sYE+6ravMpWCcsRt7D3eaIzUXV
 ypPSNPAwhRcb7G4xizCXaNDOivXlHMKmQJlSjAVk6duRhY64SrJ6puejfscugMHeaBrY2j
 6zop3UQLbmwCg+MIZZkeVi5yDTXyOGjbH9qDU30NPSnw0RxxkJI7PDKjGwh0kafQuJxpYF
 94t5UM7PxmV57lRlBuSR9ESeKEFtu1buo1MwRruBHBCJvpT4QyIfHUJx2sjqU2NnC5GU0I
 rKHLhU6s9NRSH3lFyLcRlXOWSCA96UtqCoOYRXn/Z4LZWbCXu8iN5K0nkV0yDCgB/wbcXZ
 bKYIEoF2g6PZgkwVP9M7W0dJduLmA4MZLDNCd/7XCB64rvudkqHwROPubH2A
X-ME-Proxy: <xmx:Ht76ak3xEMKhbxu9C20sw8QUOh_5-trEt0ccKbjtEZdpqVhibQPFTQ>
 <xmx:Ht76al_SKi6sIlBaujnwH05bGmgdF5L7gt0SMYYaRlfQ6E25Rps2eA>
 <xmx:Ht76alN_4xWo1kt7BEWz026LuHak4qRYtjo6lkdoykTaPdDRIvpiWQ>
 <xmx:Ht76apfyZpZXpFRqdpL_dhqCdTR2_PrLF0T5EzOD3PGTwidzN7yqaw>
 <xmx:Ht76akWxElJCnBcUN-2Dq1EJwh44nNPZMmiIeyH0DX2dZ_XCgtzy9xLh>
Feedback-ID: i51ae481e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id C470BFA0090; Mon, 16 Nov 2026 05:42:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 11:42:16 +0100
From: "Adrien Kohlbecker" <adrien.kohlbecker@gmail.com>
To: "Mohamed Mediouni" <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "Alexander Graf" <agraf@csgraf.de>,
 "Peter Maydell" <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Message-Id: <23f4fade-46b5-4169-9e96-0adb724bcc8d@app.fastmail.com>
In-Reply-To: <20261027120135.53048-7-mohamed@unpredictable.fr>
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <20261027120135.53048-7-mohamed@unpredictable.fr>
Subject: Re: [PATCH v2 6/6] hvf: arm: sync vCPU state on PSCI reset
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=adrien.kohlbecker@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mohamed,

I gave this a try with the CPU hotplug reproducer from my earlier
mail: the Ubuntu 24.04 arm64 cloud image on an M2 Pro (macOS 15.7),
"-M virt -accel hvf -cpu host -smp 2", then as root:

  echo 0 > /sys/devices/system/cpu/cpu1/online
  echo 1 > /sys/devices/system/cpu/cpu1/online

On current master (e9fa1f6) the guest still panics on the second
command ("kernel BUG at arch/arm64/kernel/smp.c:388"), 3 out of 3
runs. With this patch on top, CPU1 comes back online and the guest
carries on, 3 out of 3 runs.

I can't judge Peter's question about which sync call is the right
one, but if it helps:

Tested-by: Adrien Kohlbecker <adrien.kohlbecker@gmail.com>

I'm happy to test a v3 too.

Thanks,
Adrien

On Tue, Oct 27, 2026, at 13:01, Mohamed Mediouni wrote:
> In case of PSCI off followed by a PSCI on which
> is a scenario that happens notably during kexec,
> what happens today is that the state sync does
> not happen and the vCPU becomes in an unexpected state.
>
> Address this via marking the vCPU as dirty during a PSCI power on.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index e1ddfe14c7..7ce2e38df1 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1651,6 +1651,14 @@ static bool hvf_handle_psci_call(CPUState *cpu, 
> int *excp_ret)
>          context_id = param[3];
>          ret = arm_set_cpu_on(mpidr, entry, context_id,
>                               hvf_psci_get_target_el(), target_aarch64);
> +
> +        /*
> +         * Mark state as dirty for HVF to sync context
> +         * when the vCPU runs. arm_set_cpu_on() does not
> +         * do it by itself.
> +         */
> +        arm_get_cpu_by_id(mpidr)->vcpu_dirty = true;
> +
>          break;
>      case QEMU_PSCI_0_1_FN_CPU_OFF:
>      case QEMU_PSCI_0_2_FN_CPU_OFF:
> -- 
> 2.54.0 (Apple Git-157)

