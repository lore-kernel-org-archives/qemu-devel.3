Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CD6C25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD07D-0005CR-6O; Fri, 31 May 2024 07:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD07B-0005Bb-8o
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD06y-0000o5-AM
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iH6814M6CLVqBXpSPkd18wok9isfcryqNjvd+sAwqaY=;
 b=hykQcx0FflC76HhM6/dbIZWRAyuvg3NwQkBDgoPwmXJifE017cSSq2ldnnhidTbhn8V3wl
 zna+V3zYVtULbsoSrq2cccG/rXSUgeN0nPLruMHEzlou53E/ScEYW9bxPilwPA7bRrcMaJ
 Im/u/1xFhM1h8WGGB0yxqnbwu/unkIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-01caSaF8PV-wpITuCT2lmw-1; Fri, 31 May 2024 07:07:49 -0400
X-MC-Unique: 01caSaF8PV-wpITuCT2lmw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212a921370so9472495e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153668; x=1717758468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iH6814M6CLVqBXpSPkd18wok9isfcryqNjvd+sAwqaY=;
 b=Oq014yVEB7P83gfq58pXHv2oSpOv7IIRek3kAyxONWATXIQU/JrbaMAC8WwMREWY5A
 Zg/NKaRiBVMGlbSc1gghyXgeslIRTdJu0QVZwxAiZnGTso+QRpUVW4rc2h7BIcZf5cJ2
 dyyDi1igL4DJhxK/07UBhIdKcoRxItzfszkhshUVZ8+EeJwaiN60PwcZbLawwh3o74I7
 Q+U2dIsvAxChJpUML+8/kdrjtMhcD7S+70k8CgMmOsa4Bl8UlcS05GnGUcpZmlSqhIr+
 cVs0IuYbPx/bhGLXmj9OhdteNymVJ0JnB9bI5yIvKPj5HAc9jNPkwZp81auZlIOpoeBk
 gh3A==
X-Gm-Message-State: AOJu0YxqD8+VSYjp9ikqJvzYDGQgk7BHfFK7b9enaGHZvtyazpI1CZhM
 rxsGhrbGbda5DPy65gDMaCzCybLUJM0ef+dWkxi0djWFn1jY9JjA/cLWMFtBoL/DX+eIc0nk9ng
 T8B5krBI7KQ5rk6lomJMpqXGmzoF8CKvaXijpL4b5ek0r+C3sJ7apA5gvIxFBXuUvWsSQ/cOxcY
 IR971ouQ0RHKW4jnszB8DofYjUY4E=
X-Received: by 2002:a05:600c:1e1d:b0:421:20ac:1244 with SMTP id
 5b1f17b1804b1-4212e075a15mr15889795e9.22.1717153668174; 
 Fri, 31 May 2024 04:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFVCeTTmAfeZhjXbft+R7KCnt8s4Sg0ltsofJKok1rn+6rz5ca0Uta7glnMolOcpc/ztFG2ZKzqyLSx+s0DH8=
X-Received: by 2002:a05:600c:1e1d:b0:421:20ac:1244 with SMTP id
 5b1f17b1804b1-4212e075a15mr15889535e9.22.1717153667821; Fri, 31 May 2024
 04:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-11-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-11-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:07:36 +0200
Message-ID: <CABgObfbVb-=QiyDMKBHarrmr5pxs2NudKPCLZZgvCX14as2SDA@mail.gmail.com>
Subject: Re: [PATCH v4 10/31] i386/sev: Add snp_kvm_init() override for SNP
 class
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
> +    } else if (x86ms->smm =3D=3D ON_OFF_AUTO_ON) {
> +        error_setg(errp, "SEV-SNP does not support SMM.");
> +        ram_block_discard_disable(false);

Unnecessary line, there is no matching ram_block_discard_disable(true).

Paolo


