Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A402BC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 13:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7tK-0000yo-6t; Mon, 03 Jun 2024 09:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7tI-0000yL-Jf
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sE7tH-00033X-22
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 09:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717421901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjMv9CFvpHk7tfifO6Qm6g2Eis2FqvFOwC0BzsjHgnE=;
 b=W6f5+YUFLEJ8PA5XWD+F9obXPTN1y55XlBrrgZulqEV+dStfRUQyCFLyg5krRcpVHeiQwh
 ghvVqCkbrMZJq0TlQhwt3PTgDOjfi24vTV8WjrzaDLwbI8Dj2/Dsrtt20zmJW2O9XtI6sZ
 HN3dSp/VvkJlRdph3oph593XBU9WBJE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-umFh5IuOOWWzMyXLRJ0QRQ-1; Mon, 03 Jun 2024 09:38:20 -0400
X-MC-Unique: umFh5IuOOWWzMyXLRJ0QRQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c1e6a08555so2194372a91.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 06:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717421899; x=1718026699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjMv9CFvpHk7tfifO6Qm6g2Eis2FqvFOwC0BzsjHgnE=;
 b=uL7chNxvfHKDOHFtHKJulcEvNKvRbkseWswa+9x1PfLhf6oxGtujWpg8alKj5OohNl
 iEduFGWT/KqCeLzKsZMT8qFNqTRX2XoRNlOvAEYJ//6LEjPuHF8YY4M0GbcpKc89h2fJ
 GUb1+F/7J5RfSYl9SwClrstZ1geOrsBzEV6UKT6yYKzotG+f0o4TNyDR+vVMJtSkHCce
 nqirTM1Nsko2Uye545Wg6YlNk+j7Iqg6bZApLHYdB60bqrnOBEBtTQIKBxTuPO3TapNw
 WC0+cDF5+HLjLafkjg6vGHo8ftJAefaJidW2GGj6eZPUZ8T0SuPm0R3mGG8SvZSfsE7b
 iC0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwj4k0fZAvHh0K723G/IMSIoeUtzkoDZ70I2QLLKW3n/7ZcTWULyhD437lTVqb7q3cRafPykXYBwJVvBlImrwXeljLwH4=
X-Gm-Message-State: AOJu0YyhylSwJPRTpXoKaH6ASWOhQWamkkILFWPfNVtU9MXa+69BFT23
 Kv568ROHHyYIp7WiaCPideuZAiQC7tDzUImpnWGoepg1i94wD5mVN20Kxnre2P4GNxS8kKEnzTY
 oeWrNaPzcFQSVSdqpIdF7EOMiradGhUQKcywk+w2nT9xLqPFbMSQqZ6ci77qRwmJFPt6FVVpGm3
 rGIkxBlIT4TfY+n0Juijke3bhgxOw=
X-Received: by 2002:a17:90a:d243:b0:2c2:53f:132e with SMTP id
 98e67ed59e1d1-2c2053f135emr8436191a91.13.1717421898856; 
 Mon, 03 Jun 2024 06:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER4XLCvU+B4tTVK/M8kIPNe//eWnQO5yFMNUEPRxUbXBqnAJ6G0Q/SYq0FNt1Q54CXUqKiF03D6Ea4otyOXS8=
X-Received: by 2002:a17:90a:d243:b0:2c2:53f:132e with SMTP id
 98e67ed59e1d1-2c2053f135emr8436157a91.13.1717421898412; Mon, 03 Jun 2024
 06:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-30-pankaj.gupta@amd.com> <Zl2vP9hohrgaPMTs@redhat.com>
In-Reply-To: <Zl2vP9hohrgaPMTs@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Jun 2024 15:38:05 +0200
Message-ID: <CABgObfapGXenv8MZv5wnMkESQMJveZvP-kqUj=EwMszTkg0EsA@mail.gmail.com>
Subject: Re: [PATCH v4 29/31] hw/i386/sev: Allow use of pflash in conjunction
 with -bios
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Hoffmann, Gerd" <kraxel@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, 
 dovmurik@linux.ibm.com, armbru@redhat.com, michael.roth@amd.com, 
 xiaoyao.li@intel.com, thomas.lendacky@amd.com, isaku.yamahata@intel.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 3, 2024 at 1:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
> I really wish we didn't have to introduce this though - is there really
> no way to make it possible to use pflash for both CODE & VARS with SNP,
> as is done with traditional VMs, so we don't diverge in setup, needing
> yet more changes up the mgmt stack ?

No, you cannot use pflash for CODE in either SNP or TDX. The hardware
does not support it.

One possibility is to only support non-pflash-based variable store.
This is not yet in QEMU, but it is how both AWS and Google implemented
UEFI variables and I think Gerd was going to work on it for QEMU.


Paolo


