Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AA3FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSI8-0007lQ-HS; Mon, 27 Apr 2026 16:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSI5-0007kA-VU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:10:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHSI4-00064E-FL
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:10:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso53198545e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777320647; x=1777925447; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=676q3tKBzroxPyJ5VaG99Wl7rDEGBdpq2QwCd3Ad60g=;
 b=dPsJQwCPNJylbkJ1+XOE9yOklo6z/rFzOjIbIbbaICJUIioDXla7EvqbE2VxJzqa8+
 xd1VZlrJNorcDAU8yWOsMjKjMIUkSIv5GM6UmpOzymFEI6TVwGTeB9zhJyTTfPRXdsdi
 WlDW1nKNX2w/3ztBwWK0MfTaGoUzAVSBcarXGpEn2EHyJZygyPrsEj2qdA96KK8ZB5Me
 iV6Cie22PMdlOsrES5tVPVbCJIOzRQRUzqrYFHekxwselNly7+zFWMuDCL6LiBfBalHK
 ee3YXmEpKnikOxEg7RV2q8T48CMGOs0s9TjXKLRBZbcg/cUon4RkxFkC58oawLsvxYUl
 4TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777320647; x=1777925447;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=676q3tKBzroxPyJ5VaG99Wl7rDEGBdpq2QwCd3Ad60g=;
 b=XekTdoYNITHWnxcTXy7nO26BZUl8Y7YXfB1CuP9S8HzSNeb1d3ehK0HHjbCOYYQ2Ir
 KzBsrxwq0O2dXFJuMrhQjR8H7N0Xj+1Fjuy7m1ClWKUCpRNRRZSkZSWjYb+t5fURSuqO
 TEGi/O55SGDnyHY9jNcWmhL02iAjkberCiS6wfDZIDCaAviahvJVIf/F+5U98b36B2Jy
 azo5j8tYS3yYqgH1XaoG9i4A3yVjwFPLnZD1LHeoJdZXQU0WW60PsFXQ4wcdcwxsFFAc
 stwaOsAKYBeN7l2XcCT0ODfRnEBh+Bbh4/tytv9M06PUpSv4MFmGnygxTSvuIDFxL7tD
 En+A==
X-Gm-Message-State: AOJu0YyihZgpelMPhFdSfRTLGnro9SL50XeADNSLYbTTa3drAHjR/bqJ
 U6wq5zbkJ8HTUYV8IwjdiXEcvN0ufY1rniKs5QDUuFIVo8rg3IPTM6N8
X-Gm-Gg: AeBDietrd1FstJRdam4++35R4yh6IAU/JJO1W47RPyxKbfl/IsApVwvBTraOIKbFell
 bBTiviNeGPNjkfWxeQBP47DHW7ciPFAw7iN3gVBhqjisi6xqvNunMqDf/CKImEym+TD+tfuz800
 VznSzg1PGP+5dx0kL5/cSk/vk8uiQH1AoVJnENRqUWRfEVl1H3crLy5Boj53H/gRglTOXeE2O/t
 cNnDkSpNcGDXr1wy4+ledBYvgtXOLeLfn7tY/Iv7DoYIduxCqZMx+7apSZY+ef5y4vBSwf9rTzt
 ReT1D5fenM7O3slEZb6V+NtICCI5rO0U5o5pApSG+D+PVMCbm0XKNqci1zn4gp4jYldjJekMvK1
 /ugQReOXSo0Q/UsdVXauk7m8Vn2FoYAdhDwGGkUfHCUNDOW6WREE/P49pfSs4P4S2T+ObomBKcj
 k14iallBqr4QUdTycvvcJRX2L6zff/qvvvVknMVtXOGlHWsfHymXE=
X-Received: by 2002:a05:600c:1393:b0:488:fd7e:1063 with SMTP id
 5b1f17b1804b1-48a77b270efmr1889125e9.29.1777320646670; 
 Mon, 27 Apr 2026 13:10:46 -0700 (PDT)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773ba1ccsm8592645e9.8.2026.04.27.13.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 13:10:46 -0700 (PDT)
Message-ID: <2fa2ec352a8a1be0c93276f554c4d530e3ea2a7a.camel@gmail.com>
Subject: Re: [PATCH v3 0/2] Fix and re-enable GTK clipboard
From: Jindrich Makovicka <makovick@gmail.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 22:10:46 +0200
In-Reply-To: <ae8ktG9zNOKXHgSu@redhat.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <ae8ktG9zNOKXHgSu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

On Mon, 2026-04-27 at 09:56 +0100, Daniel P. Berrang=C3=A9 wrote:
> I notice that the current code in git does not provide any command
> line
> option to turn on/off the GTK clipboard sync.=C2=A0 Considering that VMs
> are
> often used for untrusted workloads, or workloads that are less
> trusted
> then the host OS, I would consider this GTK impl to be a security
> flaw
> in QEMU if re-enabled as-is.
>=20
> IMHO, before we remove the ifdefs in the code, the "DisplayGTK"=C2=A0
> struct
> needs to gain settings to control the clipboard synchronization, and
> it
> should default to disabled.

I added the option to the second patch in v5. Qemu now needs

-display gtk,clipboard=3Don

to turn the clipboard sharing on.

Regards,
--=20
Jindrich Makovicka

