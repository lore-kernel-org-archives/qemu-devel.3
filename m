Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74DDC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4K7-00010x-4a; Fri, 31 May 2024 11:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD4K4-00010H-TW
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:37:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD4K3-0001V0-7d
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717169857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lRY8EaNTOP3RKgAAY+bW552VmvXSSymUs3S+NhhY50=;
 b=Hrdpd76xvPVy8DlQ7cSN70QISrVW044ExtuIGUrrCkJfg3FqQz2KsYj9BZsw4LqIxQe1rM
 cN5SzLf8BAPZ/YHiqq7tlxELbJKTBLab4E+NaURv9I/YDfnc09VRYhQGcgrezn7gMt37IG
 H+duMy8BojLAUmvB3CieTR6E9k7wnh8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-QLCryCylOzOhmPi343DDGQ-1; Fri, 31 May 2024 11:37:36 -0400
X-MC-Unique: QLCryCylOzOhmPi343DDGQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-35dca4a8f2dso1122014f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717169855; x=1717774655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lRY8EaNTOP3RKgAAY+bW552VmvXSSymUs3S+NhhY50=;
 b=ggTVz7r6P1Qg0CjEMYktJ2zA7avbFAkyOfsbeApYWfKXjU/LR7mnBfCIQdA51SptHo
 vzr2gnx8hvlyeb1snpunnLC2H4D6st9DddE6YGAkvSSFddKmOAf1v87DgPdwiY7+Ixn3
 E8cuyUPmEIZCw1M+SKJkVh3CVN66cb1ns1ZToAA3q2flu2dokkBVtEeGGOKODH+bCKlq
 uWUnUiLgGN8TQr8uHxWw4J/drzgr49J0NApBEcb8CluyNon4zXijvZpX9T891XWDfZvT
 9VxDMJH2yEvkOiGYAqPw/s57Z8whVA+zB1f9gvIZbVkJgY0P7kMoQUvje6ASXT3hyQTh
 BLFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWVvl6eKbehSBpuS32dniDu2JW7rd3s7UyESlI2PanuU/7SZ0DBgls6nFSDa0ypKEVsA4USN2IxOQcsMn4T8UjxD8dcPk=
X-Gm-Message-State: AOJu0YwO5OPD0dFNDPBlQKuOCJAsxzA+7hzABwKDBJZHfeV8hva6UOpH
 HQ9ZVD+DlUnzuHI2j/6XQ7VjUNmoYTRvjjPHcDKCWNIvjlw/clsOlBiivJsHlXclfHGCZT1eF8G
 1YcKY5C189xHSqkKWKrnV5Ppw/+cGsicpM/bGosKjCE/u9eREFpP19Yp+uOoXS7RKLm2qCfsRbs
 ebFpodPx/IG05LCwG5Aauntthr8HA=
X-Received: by 2002:a5d:5392:0:b0:34c:6629:9962 with SMTP id
 ffacd0b85a97d-35e0f284638mr1714898f8f.30.1717169855253; 
 Fri, 31 May 2024 08:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFduiW52sGnR6g6gdSst7zYUAfFkyt3TRq9RsSXiitRrzNyhRAnnzGTi0mhW37ETjIqjH5sjaGYHYT6IhsX+a4=
X-Received: by 2002:a5d:5392:0:b0:34c:6629:9962 with SMTP id
 ffacd0b85a97d-35e0f284638mr1714881f8f.30.1717169854851; Fri, 31 May 2024
 08:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-3-pankaj.gupta@amd.com>
 <774b70fc-992b-47bc-84ef-c5a22b96c63a@oracle.com>
In-Reply-To: <774b70fc-992b-47bc-84ef-c5a22b96c63a@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 17:37:22 +0200
Message-ID: <CABgObfbtWSbL9zY1yMCmqsycRnF74=bOQBqrKitOnQpL2ZKN8w@mail.gmail.com>
Subject: Re: [PATCH v4 02/31] linux-headers: Update to current kvm/next
To: Liam Merwick <liam.merwick@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>, 
 "armbru@redhat.com" <armbru@redhat.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>, 
 "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Fri, May 31, 2024 at 4:38=E2=80=AFPM Liam Merwick <liam.merwick@oracle.c=
om>
wrote:
> > --- a/linux-headers/asm-x86/kvm.h
> > +++ b/linux-headers/asm-x86/kvm.h
> > @@ -870,5 +919,6 @@ struct kvm_hyperv_eventfd {
> >   #define KVM_X86_SW_PROTECTED_VM     1
> >   #define KVM_X86_SEV_VM              2
> >   #define KVM_X86_SEV_ES_VM   3
> > +#define KVM_X86_SNP_VM               4
>
> I'm not sure which is the best patch, but there needs to be an array entr=
y
> added for vm_type_name[KVM_X86_SNP_VM] in target/i386/kvm/kvm.c

Probably "i386/sev: Add a class method to determine KVM VM type for
SNP guests", which is where KVM_X86_SNP_VM appears in the code.


Paolo


