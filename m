Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AEEC54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQgJ-0005DY-5Q; Tue, 20 Feb 2024 09:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcQgG-0005D5-2Q
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rcQgC-00082M-Tj
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 09:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708437663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNQOrREmmc7fW4KUko02bOVeoRrX7si9lnTdwGFk91g=;
 b=VQbYa8raW739CRLwyP0PcLKJ/Y9fwNJWgEMoNIsR3Eq9bNcsMGM165JMGwoS872bHm94O1
 hRtE87jzv8bimqa/wA8tEbKVcD/HlcUTR6TBVbZdKRUivgftW+OMJzh7ivfYlZmfL8LqO5
 tNqSerkW2i72vTZuyCTVP+qPFBl6bOk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-sKwuGdmgPBacPzPnLHRZpQ-1; Tue, 20 Feb 2024 09:01:01 -0500
X-MC-Unique: sKwuGdmgPBacPzPnLHRZpQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-36516d55c5fso26610055ab.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 06:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708437660; x=1709042460;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNQOrREmmc7fW4KUko02bOVeoRrX7si9lnTdwGFk91g=;
 b=O9f34ITAEHdCXkE6KV218w3t03V45YHkyPehWohQB3CeK5Q3qVSXidVxMc0vY787SF
 hFIGZuCiO2gl4uYFe3jUN1sCR5qlW9Qf1e5Ra9A0wTJeVdAQR5W8WCkli9taGoLv51U5
 juB+qa6Pr6PvEzhijwx9f5OaUfGzeHyPGZPBrH8TaxO5QE6CEAT+J1FJsq4DPonl/BAi
 pTCPBiCQW4Nttp/KPw23Hs8ZGnd8578T1Ke7f/mH1Cf0r/lKSBO/Z63c/MKfKI17HzZE
 D3F3BXS9OIUPSiVrGgOXSjQ0rAxuEwdV73fKIVAgmpRJaejco9E6inz7R8iJKxntFm5x
 Jfew==
X-Forwarded-Encrypted: i=1;
 AJvYcCViUgi5chOHEWoBtRmhBcDpGy2yWZF+q61NKQw7fa3yDDACjGYL3Oz1t7NUo3aeX3225/x9RvsqMWQOflcZb0fS/+fsYAk=
X-Gm-Message-State: AOJu0Yw7DqHxCHynX5C7uopB8DkcphQabAQaqgrZkA9jpo87O9f+uHfB
 t2vGbzWCqFlOIqZBNQ2RBr92BmghFXS7PrmibdGubb5PZ9oj40MMoWBAv01dNXLqgBWbNQcP/93
 7NBhAgLo2VV45z0uPD3pak4ArSGlNRhYeDio9OcbkfV9aiVxhQtry
X-Received: by 2002:a05:6e02:1206:b0:365:1d36:91d7 with SMTP id
 a6-20020a056e02120600b003651d3691d7mr7359760ilq.27.1708437659825; 
 Tue, 20 Feb 2024 06:00:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWEfLjlT68vft3NEd96QXnHLiIeJqMUYv5G0C/jbBvCzvdlq74unJ68dDtGQiB61l+3Hze5w==
X-Received: by 2002:a05:6e02:1206:b0:365:1d36:91d7 with SMTP id
 a6-20020a056e02120600b003651d3691d7mr7359717ilq.27.1708437659381; 
 Tue, 20 Feb 2024 06:00:59 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a02cad0000000b004742452a382sm1259870jap.45.2024.02.20.06.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 06:00:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 15:00:56 +0100
Message-Id: <CZ9YLSITF57Y.2WGV9XEFH7755@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <Zbf8hradcHeeEXae@redhat.com>
In-Reply-To: <Zbf8hradcHeeEXae@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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

Daniel P. Berrang=C3=A9, Jan 29, 2024 at 20:29:
> On Thu, Jan 25, 2024 at 08:22:14AM +0100, Anthony Harivel wrote:
> > diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
> > new file mode 100644
> > index 000000000000..04d27c198fc0
> > --- /dev/null
> > +++ b/docs/specs/rapl-msr.rst
> > @@ -0,0 +1,133 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +RAPL MSR support
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> > +
> > +Current Limitations
> > +-------------------
> > +
> > +- Works only on Intel host CPUs because AMD CPUs are using different M=
SR
> > +  addresses.
>
> The privileged helper program is validating an allow list of MSRs.
>
> If those MSRs are only correct on Intel hosts, then the validation
> is incomplete, and it could be allowing unprivileged processes on
> AMD hosts to access forbidden MSRS whose address happen to clash
> with the Intel RAPL MSRs.
>
> IOW, the privileged helper needs to call cpuid() and validate that
> the current host vendor is Intel.
>
> I suspect we also need a feature check of some kind to validate
> that the intel processor supports this features, since old ones
> definitely didn't, and we shouldn't assume all future ones will
> either.
>

To validate that the processor supports the RAPL feature I propose
to check this on the Host:

$ cat /sys/class/powercap/intel-rapl/enabled
1


The only down side is that INTEL RAPL drivers needs to be
mounted then. We don't need it because we directly read the MSRs.

Regards,
Anthony


