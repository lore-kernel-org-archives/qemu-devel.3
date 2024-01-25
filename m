Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F0BC48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 10:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSx4z-0007Bu-Cr; Thu, 25 Jan 2024 05:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSx4y-0007Bk-Jb
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 05:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rSx4x-0008Rw-6S
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 05:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706178925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WXbukULcZGxPqy+ujGoBzvY0xC7CpaYaknZ7/WaEmEPbtqmO8CBurohmcHp29s5wwZ3852
 cuQ9Kx1ipEp78w2jxZ/8iUaZkjjOuLwLKUb9tUSmu5By20kXWKDigiSP3Vu/dBDkcvfIwK
 j71YPO1bcv9zzp0SoNyr1yIZJnv/d2w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-xV_vCJ7GNCGFMRxLnPBSAw-1; Thu, 25 Jan 2024 05:35:24 -0500
X-MC-Unique: xV_vCJ7GNCGFMRxLnPBSAw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2c653c7b35so360151466b.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 02:35:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706178923; x=1706783723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=C26NPZbfvwRvdMBGGk3/DzhoEhq2ZWvWTNsBqoc6zXfsAGnSFwS/q7wm4uzHL6klFQ
 N6Nuu8Pu8Swzr+4kaFAxGPYCg8c16J8+QA0Au+vsjpbRqz7kAwSDCF8NKPbRpWzmGSjl
 rTyg/8SMXvZOp2Ua8okJencmDM2Sigr0MH6/rFg8HfAtT/SVJi9dY+cg4dPvLjia+i4a
 oWvFpDN9TMJ6vwLHjaJurJ1hVm30DXvDmw13fdEQEew1e6LkaiB8Ajxx5XVJ2K8j4UsV
 DFsEPBA6amWw6IMy+va3KVq4QQiSwV8MuqftQXKstUYo7HUmOcVC3yDt85gspM6jcfE3
 Uyzg==
X-Gm-Message-State: AOJu0YyepQWIHT+U1hWM20UmO1SQuJuyxuM7rqnuDlEtnCLSxZEmutwJ
 r14D8AIs1vdiW73Skp1r+Zi/+pXROwzS9tW95kYA411qfBa4OZjC5Hggzu37GJDKIsWlUUB+tM8
 z5Ok3bb4V/5/G28/Lf3ICsgOxMIJ7WPWy7LbFrz7VugWKfncJKLvY
X-Received: by 2002:a17:906:4693:b0:a30:3cc6:b64f with SMTP id
 a19-20020a170906469300b00a303cc6b64fmr208739ejr.161.1706178923303; 
 Thu, 25 Jan 2024 02:35:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMuWcRdBgXuisXYHg/eHAwCM5wQ4PnlerB1BR+42KAK65pvvS7mFZ3DYP5B6OWhOh8wfL7ag==
X-Received: by 2002:a17:906:4693:b0:a30:3cc6:b64f with SMTP id
 a19-20020a170906469300b00a303cc6b64fmr208728ejr.161.1706178922947; 
 Thu, 25 Jan 2024 02:35:22 -0800 (PST)
Received: from [192.168.1.174] ([151.48.72.171])
 by smtp.gmail.com with ESMTPSA id
 op20-20020a170906bcf400b00a1df4387f16sm879401ejb.95.2024.01.25.02.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 02:35:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] i386/pc: Drop pc_machine_kvm_type()
Date: Thu, 25 Jan 2024 11:35:20 +0100
Message-ID: <20240125103520.788984-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231007065819.27498-1-xiaoyao.li@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001,
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

Queued, thanks.

Paolo


