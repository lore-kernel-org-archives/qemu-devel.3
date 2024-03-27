Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B1DC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 13:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpTTH-0007AJ-Bf; Wed, 27 Mar 2024 09:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpTTF-00079P-Bb
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:37:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpTTC-0007fX-Tm
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 09:37:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41494714fd1so4271215e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711546653; x=1712151453; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=smTZluOGn/fUn3D+QqeEnI8LdPKMkXjE5Ourcjod5Ew=;
 b=g1BvFbmzc2RYSH/PbCW0RAiD2CQ2MgNWg9gk8tqiZLK/2ABehKOmoAz3o55W6zqXqD
 mkRDBws4ua9Zjq1A3m6pvIKJJBGV8CULG2Q7gcXMhonnc4273n43SgQo3eeKMmAgMR77
 se8OHgenuxSwQdj2Lbt1zg0ibkcadn6ZH58Lw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711546653; x=1712151453;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=smTZluOGn/fUn3D+QqeEnI8LdPKMkXjE5Ourcjod5Ew=;
 b=i6Kjm/weVIkyKuOTwkrw0wYApW2q+6k2f1x3Tkqh5E72DXx6SVyx85zGknuyieYYey
 qsaUO8HBE9dP9RPwJ7Ndp+5D14qvlM/FxVeeEm1VJcne6MpV/nH9dsKlQP/1F4htjZtn
 2FUC2DqzkYOr0/iKWZlXjxr+CLBcR9tT2eV0Ye6u17+tcxJzgXWjXM3796xvIPDqjNLh
 ogQJ9zlFQapoyMmEn75jPfn4Ro5bOVj4mr/K4oNSM1kbrTte/UlLr2gCrBHN4Zhtt2FL
 dNhPpAwGpmcJddprMo67LXUce24zBm/JDrzuMTAnHpsdPSUI4cMGGy3iWzApw6qFFE8C
 C88g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOPWSoWzatFMTLb97vxfyKwJXiJ22+rZBcINcR9AjbEq5X6LmQ7iHCm5Xb0QYPQ+beWDn8OVwfn8bxexPHeBPZ8fXhZAM=
X-Gm-Message-State: AOJu0YyvTgob9uRgZO/90nZUK8kgE9WEBl6QNbOA4si6iW5if5TBf+94
 YO04h1c91qTcmVbEyKoW9aUJbXOtJ6mu0HZp4Szy92NcoAfi2as0Pkd5AUZJZK4=
X-Google-Smtp-Source: AGHT+IHmCd6Z7pLRTa8judRkvI7RAqt4OfBOEutc0X/kcSqKXxmUpEJ5ND/lGGVRsxmC7KvW/3fTRQ==
X-Received: by 2002:a05:600c:1c8f:b0:414:669b:aa9 with SMTP id
 k15-20020a05600c1c8f00b00414669b0aa9mr9727wms.28.1711546653009; 
 Wed, 27 Mar 2024 06:37:33 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 q18-20020a05600c46d200b0041488978873sm2166371wmo.44.2024.03.27.06.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 06:37:32 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:37:31 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.0 v2 11/19] hw/xen/xen_arch_hvm: Rename prototypes
 using 'xen_arch_' prefix
Message-ID: <3c553c67-c54c-4156-8d69-bef3476b63a2@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-12-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-12-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 14, 2023 at 03:38:07PM +0100, Philippe Mathieu-Daudé wrote:
> Use a common 'xen_arch_' prefix for architecture-specific functions.
> Rename xen_arch_set_memory() and xen_arch_handle_ioreq().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

