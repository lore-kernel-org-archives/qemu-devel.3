Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9FAD149C7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4NJp-0001FY-QY; Fri, 25 Oct 2024 12:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t4NJn-0001Dz-I3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t4NJm-0000bK-1u
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729874260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Da7GDmZUn8gruG8aVhjMbCtU/J+mOjPpY2hCBfKeE+I=;
 b=DL09d3iEbaaHL94NsmJPp6nY1TcqY69ZEKR+teY5Lpz0EqV6/HSARplWoVr/b5DSLWjYjJ
 cfGfSa09t87EueueaXfADn+hGyoke8sZ+PXTVtRltI3ZPwVY/fSsGs1GB9pkGV5HoGzEk1
 Xw0v3XfTiyPsGHy4LOgLCUdZejgUFco=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-6PcZQ_KqMQibIGoAusmCQA-1; Fri, 25 Oct 2024 12:37:38 -0400
X-MC-Unique: 6PcZQ_KqMQibIGoAusmCQA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-71e5a1eefeeso2555944b3a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729874257; x=1730479057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Da7GDmZUn8gruG8aVhjMbCtU/J+mOjPpY2hCBfKeE+I=;
 b=cxrEgtkCR1yG6z6er5B7WKDrIucyv6PR/hzVJOaZaW3gFiPFdkE5wTMiBq8s4VBJ2h
 zoYWVHyego6WBd6GysW6Z6J2Mkh9IFJL8R7MFvh+XxMLgNZhhdOBruIlC1kdEBifESKk
 YnWJJ+CHEb38G71jYhxBknnB6KmLja4hdnfEEiAY0i5/tazzf3xaMgv2G9meWyXYqImw
 Ji7puvL5rk7elQWRbfKcUHH1unli5Z96ECWFIQySUCjLlSWfjEvhUHwfVjakDwFj1YkU
 2mHw9G5bl2A+GzahUuEwT4Se+7K6O361s9lBIX22eiCJFnUgaDHxaEPpsajN5YR+/Ih7
 8Png==
X-Gm-Message-State: AOJu0YxV585VHRuGXUmy+EM+AWXHBP6pvyxytoK8cvpx2aYjidzHOCQk
 8KvKZJktQmVQMBVYxr3Mfp4p4X8dsK2EPEOqX+Q5GzI9PP70KQRyNY0fuX7dMKoM/J1sNGUUVd+
 ZDR2o8b7VjnNTinb6tUehXE5XQuOyl1PEykmVE+VLdnJ1Q2uJNOAAhx8Mpkh4hsQYuPqgzSBVBJ
 DChKtS0+kBNTRoOl33x4CNTttYpDc=
X-Received: by 2002:a05:6a00:178d:b0:71e:427a:68de with SMTP id
 d2e1a72fcca58-7206306efb3mr168446b3a.24.1729874256931; 
 Fri, 25 Oct 2024 09:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGegNvqy8/U85V9CT3g1B8jb2KJobKgfV0g9RU94Wv6JCi17g9EQsu1EICBNlhY+MZSDS5FbN8jrLZJ2MZvzDc=
X-Received: by 2002:a05:6a00:178d:b0:71e:427a:68de with SMTP id
 d2e1a72fcca58-7206306efb3mr168413b3a.24.1729874256549; Fri, 25 Oct 2024
 09:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20241024165627.1372621-1-peterx@redhat.com>
 <20241024165627.1372621-2-peterx@redhat.com>
 <ZxtqGQbd4Hq4APtm@redhat.com>
In-Reply-To: <ZxtqGQbd4Hq4APtm@redhat.com>
From: Peter Xu <peterx@redhat.com>
Date: Fri, 25 Oct 2024 12:37:24 -0400
Message-ID: <CADLectmPdjyp7WwjSTDNtjj==zmrkmKLiDJQ+hsYhRN-K2bONQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] qom: TYPE_SINGLETON interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, 
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000917c6006254fbc92"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000917c6006254fbc92
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024, 5:51=E2=80=AFa.m. Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Oct 24, 2024 at 12:56:24PM -0400, Peter Xu wrote:
>
> Adding significant new functionality to QOM should really come
> with a commit message explaining the rationale and the design
> choices
>

Ohh i definitely missed it, my bad.  Luckily i still wrote the cover
letter. I'll prepare that if there is v2.

>

--000000000000917c6006254fbc92
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Oct 25, 2024, 5:51=E2=80=AFa.m. Daniel P. Berr=
ang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Thu, Oct 24, 2024 a=
t 12:56:24PM -0400, Peter Xu wrote:<br>
<br>
Adding significant new functionality to QOM should really come<br>
with a commit message explaining the rationale and the design<br>
choices<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Ohh i definitely missed it, my bad.=C2=A0 Luckily i still wrote the =
cover letter. I&#39;ll prepare that if there is v2.</div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"></blockquote></di=
v></div></div>

--000000000000917c6006254fbc92--


