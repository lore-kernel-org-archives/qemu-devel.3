Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F63FC3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 10:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAo1U-0002IN-EH; Fri, 02 May 2025 06:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAo1O-0002BR-BL
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAo1L-0005n6-Ne
 for qemu-devel@nongnu.org; Fri, 02 May 2025 06:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746183208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvPeAOUjN/2G8r8d702zIIMXpkYXw6rozy6jk2q02Cc=;
 b=cK7aOx8LfZRejWkWNfg7aQLdyV0VcxBYHs2IKcUcefltdkhegMGP9YgUF/0F+3hH/MkFU9
 /E1QaxRky61QWSoFNonP0shpQccvskOcj0533nTr0gnRpQPvrtX7HfSwTrphFkcwD1MIOE
 umSYuOe3+EPN0MlRzeLrtNdS7NR+KQY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-DSL6a46zOySk6ud_WU5nrA-1; Fri, 02 May 2025 06:53:27 -0400
X-MC-Unique: DSL6a46zOySk6ud_WU5nrA-1
X-Mimecast-MFC-AGG-ID: DSL6a46zOySk6ud_WU5nrA_1746183206
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so7463595e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 03:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746183205; x=1746788005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvPeAOUjN/2G8r8d702zIIMXpkYXw6rozy6jk2q02Cc=;
 b=cVVWVfXizgF9JIxiIz7MB457HdqdNQyF+s9lrB9ieKQmlvWPnWCsm2AZl3z/+xYz5J
 mEeyfIc3DyQqkYO81trOOWm2/zl5zCobTxmIhJrynHepQiC/W4wmdWRO2F0ERWpt0w3f
 N1YVzSnCZx+ULfzWYYbE2qZ0215msqCOulAiEou6Q1GWKZdpuuIqbHpPmuPbWU5C3EFV
 WO/O4GC0eg7NYAJL8h17tLdiHuJmHwGgu2TH4T7sF3bNRdbHl+ft3rSxoIcCO37kGTZd
 jNaCnuxeP3ZkJJhOcj0l0iHVLFtKEBEq+aMn1r1FABjvcA1Ki9OgjOwPu/6hakSC5GM8
 IRUQ==
X-Gm-Message-State: AOJu0Yw/RXRv9vgM7mh+RsLJJ0CTHNtsml1ee5NFs44M8ppsp2U8Au3K
 As3cSqxgXXEBTBgY/COruAdhbE2e9rdkH3Lj1aUB8qD3srNeLz5nDHMdGfY4OJ0avPpKqsqKoew
 1W1KjJXtYlRta3ltzI4jN8t7Chpi3LdKb20Q2UYPnNzTLpCKaQgbR4NolNjSwXu+P/QMlv2Mh5M
 2+zHf4F1HoSSM6NVmBweO8VmjZYzSZQ61S5Xw=
X-Gm-Gg: ASbGncsQ2/gn+oOoNU8er2Jwzo5Y5us04Nz6fkijJjwqpCVuQTeoIypLD0v+esBZYr/
 BdXiRfGLoPM+IumJ3SqDrDzIw/JMfvNWvS8nu9wnMu22sh4WmZCnlxI749BUad9PD+XR/
X-Received: by 2002:a05:600c:5022:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-441bbf34052mr16078005e9.26.1746183205668; 
 Fri, 02 May 2025 03:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQPxHCxUTnCuCE+rVzGRuyw6wJlcEfWcdfh3/4glaTpsiXDj7Dc5Y4Y4ZZgMwe8q5OytOIl+FQUcKfCpjioiU=
X-Received: by 2002:a05:600c:5022:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-441bbf34052mr16077865e9.26.1746183205364; Fri, 02 May 2025
 03:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250502102323.104815-1-pbonzini@redhat.com>
 <20250502102323.104815-8-pbonzini@redhat.com>
 <svmrjd.2xrfuqhgty9pb@linaro.org>
In-Reply-To: <svmrjd.2xrfuqhgty9pb@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 2 May 2025 12:53:08 +0200
X-Gm-Features: ATxdqUEH3DDusdJiUF44Ge6r2iRfaZJfN_8dzW9sWwYeyPVdeNrzJPSyZR7OXTY
Message-ID: <CABgObfaBcG5XA+_hwZ27xhdB-6g0AZ-vx7sBcPzG3K3c3930zg@mail.gmail.com>
Subject: Re: [PATCH 7/9] rust: replace c_str! with c"" literals
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, May 2, 2025 at 12:52=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
> This looks like it should go in the previous patch ("rust: remove
> offset_of replacement")
>
> Otherwise,
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

You're right! Thanks for the review, and welcome back.

Paolo


