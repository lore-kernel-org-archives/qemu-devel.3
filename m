Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C820606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BnN0ViPf;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=txVnZ0YT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWRG-0008GY-8K; Thu, 26 Nov 2026 05:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1xWWRD-0008FD-OH
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:10:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1xWWR7-0001SE-Qp
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DW7KrPQ0a6tty0pbOJQyeevcMCVnerst5a1iHW3B+3A=;
 b=BnN0ViPfg9ProKH3ZZuBIQfJR8YrGCmVF4us8DGJTpgcS+hR//FM8X3MZGFECMKGnE4nsr
 LTUBokpqNFOrP+JpFYzDhOh5PuIxFoDyWgS69DA4VHSJHAin49f3tnKu6/Q9wbSi1jqoI6
 9MN3P9DJm6TqyWeoBPZp/Sgfs4CnKnQ=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Jn0jjY-7M9ShSR2S86yK6A-1; Thu, 26 Nov 2026 10:09:17 +0000
X-MC-Unique: Jn0jjY-7M9ShSR2S86yK6A-1
X-Mimecast-MFC-AGG-ID: Jn0jjY-7M9ShSR2S86yK6A_1795687756
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so7858547eec.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 02:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795687756; x=1796292556; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DW7KrPQ0a6tty0pbOJQyeevcMCVnerst5a1iHW3B+3A=;
 b=txVnZ0YTq5ZLzzTQgNWolf6nRvVuGRDSKwxbwKvWyKw8p+cRa0OPKlL/nIhpYcirZI
 019zr43xEDljIy18sDTFFXPKAy+m+2YavuqK3MLtphrrMg11rJ37cFiQU9vNBlzsIwrz
 f2K7bHVez2rFGmvh3Jpj2i7llm1Tm2OQFHQKtNUNpqWc8bbreaJYvzAO7OyBhNyjgfUN
 tVu2FNgeY3gDaEXO6YDdyYGuD+n04EPuLVGnVz2LOaeOeJoIqxHcIPa1WtoW6whMkcjC
 uBTLSdoMIw7YM3X7aLhgfK05IDPcvyl2IqCIjGmezN262rQf71uYh9+kDDjazPPKDHgn
 Ir/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687756; x=1796292556;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DW7KrPQ0a6tty0pbOJQyeevcMCVnerst5a1iHW3B+3A=;
 b=MueHYehxnPnlBx6V8QE4ks/5SUciCI37n3QWL9raHzrYw3/H6sSV1S+FoNPJza33ki
 xMBV+92mRpACOrcLEYbOIANES01KOwxgebuQsxKNvSfeYL3nKsEUp06k3r4lYWIrwsJ0
 /KMTga8rR90m3qcVWnz5R+59obrq+IgMZpQWda7iYPsC0BLu5mCGfnydQGZDN+joQIvj
 HcO7KM58V/mXU0WyQVreU9pRD0kk4KgchTFQf0WrRm6prJ+ArxqFxz+0bkBIK4IbE9NQ
 hEmzBbuB4tqBSo+4aCoPrfmnNFW3bSyoc85DB/VaMKj2r16Wid9Bv93O/Rlu+gtJAC7p
 YFMQ==
X-Gm-Message-State: APuU4Z8fNqvwbVSu6kboxwSNiHHKWPD7UHe24plvAGzzqCyMVQPlNbzG
 gkH3c5SWwWt8Bjyifb/EAXBcDW4R1UPOMxO/PEiKTYl64J+lnV2l/ASjtqgzhwuZAiUhmm3MV/w
 26mRrji1+LSD+nXoLBh6NOUUb0994u+Et+l3Ive6YpXdwhFGJyYkvjjvZ
X-Gm-Gg: AZFdTZcJT/vGh6ebFi8P+5K5cYZdl40jsaAQ4ZCV7oo5dX5NTh3tMjMsTjwuC4sxPAo
 IGD2gR4z81AhULO6FxXuuuxHTZ0VSUZS6RUeR9dCAQcITYtNcB4YWDhb8P+JfSTf9fqM6yf1OmA
 S/OfQ45Q6slu17acSAIYX56ls8k2rE1sbcUzs1vjGKbzqf+Ij8JeTb6qh1IHv0NMuyS7M/1pXf9
 /L4fHF4VUmlLJnxlsmW/9CvQ1b/eLeyhURdhYdPe6T8+xKBDbd5dk/iJ3XL/CeABeTpucOuHtBB
 qn6BToGcR2yIoZbfvD+7TO9q/JgzwkkspPZc5W4/kKSKBuSz+cw+CPUtSPjqkCFS7yTsiDvMZ7L
 lxaYpimxXU2uXuP2jVuE+kcN3umwB0UArCxJcz/k6nqrKbSrKa/UVvCo4IzvuQrLlnAqUvSd4Jf
 DnhCeMMY9JQCMq63oVpPQnACxV0Ug=
X-Received: by 2002:a05:7301:5f84:b0:385:f410:fe74 with SMTP id
 5a478bee46e88-385f4110110mr28071203eec.26.1795687756385; 
 Thu, 26 Nov 2026 02:09:16 -0800 (PST)
X-Received: by 2002:a05:7301:5f84:b0:385:f410:fe74 with SMTP id
 5a478bee46e88-385f4110110mr28071184eec.26.1795687755892; 
 Thu, 26 Nov 2026 02:09:15 -0800 (PST)
Received: from smtpclient.apple ([106.219.133.110])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm48521060eec.1.2026.11.26.02.09.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Nov 2026 02:09:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.4\))
Subject: Re: [PATCH 0/1] qom: Really add 'confidential-guest-reset' feature
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87se0o3tak.fsf@pond.sub.org>
Date: Thu, 26 Nov 2026 15:39:01 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Daniel Berrange <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33D7FAE9-2495-4F08-AACD-A711F0EDB032@redhat.com>
References: <20261124154310.2569390-1-armbru@redhat.com>
 <87se0o3tak.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3864.700.51.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26 Nov 2026, at 1:42=E2=80=AFPM, Markus Armbruster =
<armbru@redhat.com> wrote:
>=20
> Ping for 11.2.0-rc3
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Feature 'confidential-guest-reset' was added two releases ago broken.
>> Nobody noticed so far.  My patch fixes it, but I wonder whether we
>> should just drop the feature entirely.
>>=20
>> Either way, is it worth doing for 11.2?  I'm leaning towards yes.

Let=E2=80=99s just fix what is broken. I suppose libvirt side has not =
been changed to look for this QEMU feature.=20=


