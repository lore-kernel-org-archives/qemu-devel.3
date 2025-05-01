Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410CFC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 05:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAMCM-0004mN-0s; Thu, 01 May 2025 01:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAMCK-0004lz-8w
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uAMCH-0003Xu-Ew
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746076255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=iZ8YucsSATUgeLbdee4FEJWjim0TMSxWhg2+2TQmDU8=;
 b=XUoqtjHmukvArNCcN7+x3ERGGBorok88DMcdkcfs0xbKNFXGlx0tN/FYlEv/hVquC8pdrQ
 NVFSNJD56Hs0IM/iTOvoUHCRs9dOtUluxOf1/adZQmgaYHLsJrbW5AF+EwmGAyyRHtaqED
 Ot3wPors4oLoQlOnGa+OT78lTSKkdnU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-GzGkNyxyPualC5Bs06iWgg-1; Thu, 01 May 2025 01:10:53 -0400
X-MC-Unique: GzGkNyxyPualC5Bs06iWgg-1
X-Mimecast-MFC-AGG-ID: GzGkNyxyPualC5Bs06iWgg_1746076252
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so133468f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 22:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746076252; x=1746681052;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ8YucsSATUgeLbdee4FEJWjim0TMSxWhg2+2TQmDU8=;
 b=PyLXltm2wTsNKC1uiEQgvX7PwAO5Bwdq2ODgCH8hsnhPe0UnDDGSm1qHHoqi78GbWG
 ist6ys8iPUQbnghFJ/9S8S98ZHSv+QQKz6tvo9ifrDU2qGR2egL3ynHiOzr+rPURbxvi
 ddiiXGGUQLPAjCVA3E5GvhWApEuYxdCtk6DQbY5mHMio1j5FD+z/vKpPGY1Sh6krYEvh
 SpjwGighnec3oUm9vRo9f0m+SPrh25nly/NnOkQ7s2ibh93AvU03RpNkXiYIADE4xDsz
 fv39k1XX0pqSHq7tzS/pkUjnYDaq+/V19jda5578nDqlkVQak/8zqdXtzmaCZ9GDqMPA
 L/fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBLR2M+9wpTIzmtQnb86wWweiametYaG3kxt8F1WVWwOJG2oSyQNsyhjQeXRTH8j6MH9kHIGhSIQsR@nongnu.org
X-Gm-Message-State: AOJu0Yx0bQuzrd56FAn8OUYL90h3CMpD9uAQTdnU79SLyTAobrVM0tLM
 puUuIt6pKkwVIsvB0MnwGkFFBSa+GqyGL8/vnwFVgmsJL4sSAR91HvUhL8BHJL4jUCZNP5eBA6A
 Dx1SdbyKbWzAzwBDNeQF9kdd8eoDAfpsAPcf54u/a2dVt0tGwrua1eIs612CXrRK1bVTl75rQtu
 BQQe2Qds6X//KxMu0VV8K1BvEm8mk=
X-Gm-Gg: ASbGncu+pU3g1B2IQkgoAUSjPkPjiWkz4Ux5Ujf+itIbiB8aIFhkOPgfKZnEvGeagGS
 3Vo3coFEl0/jq+1Hfu3e87DpfrxdGyZPdIvrzryfg9ZPbZykiKbbzpcqVsx1se9iJ3iVC
X-Received: by 2002:a5d:4e8b:0:b0:3a0:831a:42b3 with SMTP id
 ffacd0b85a97d-3a093073f47mr903029f8f.40.1746076252516; 
 Wed, 30 Apr 2025 22:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTFEvLMlEBvjAq9rZg/sHRGpLYC2QEayjz0bHNy2HDAC4Y8/iYOpT55OZ1dbTsZI/yRsaQZ5TBhfDqbrIQtJ4=
X-Received: by 2002:a5d:4e8b:0:b0:3a0:831a:42b3 with SMTP id
 ffacd0b85a97d-3a093073f47mr903016f8f.40.1746076252190; Wed, 30 Apr 2025
 22:10:52 -0700 (PDT)
MIME-Version: 1.0
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 May 2025 07:10:40 +0200
X-Gm-Features: ATxdqUE6vwWTo3A30XQ11hCQ8Yup5aBwBrdwZsDBazmn9KmL3Hut56D7h91hsog
Message-ID: <CABgObfa-ViHvve=oqV-Y88ghXGkevu1wTug=+24E4dKuG54c3Q@mail.gmail.com>
Subject: OSUOSL in trouble
To: "Hajnoczi, Stefan" <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c3549506340c0e81"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c3549506340c0e81
Content-Type: text/plain; charset="UTF-8"

From LWN

> Lance Albertson writes that the Oregon State University Open Source Lab,
the home of many prominent free-software projects over the years, has run
into financial trouble:
>
> I am writing to inform you about a critical and time-sensitive situation
facing the Open Source Lab. Over the past several years, we have been
operating at a deficit due to a decline in corporate donations. While OSU's
College of Engineering (CoE) has generously filled this gap, recent changes
in university funding have led to a significant reduction in CoE's budget.
As a result, our current funding model is no longer sustainable and CoE
needs to find ways to cut programs.
> Earlier this week, I was informed that unless we secure $250,000 in
committed funds, the OSL will be forced to shut down later this year.

I propose migrating the two VMs we have to Digital Ocean and scrapping the
DO Kubernetes cluster. However that means we need to move CI to Amazon in
the next 1-2 months, before the Microsoft credits expire.

Paolo

--000000000000c3549506340c0e81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">From LWN</div><div dir=3D"auto"><br></d=
iv>&gt; Lance Albertson writes that the Oregon State University Open Source=
 Lab, the home of many prominent free-software projects over the years, has=
 run into financial trouble:<div dir=3D"auto">&gt;</div><div dir=3D"auto">&=
gt; I am writing to inform you about a critical and time-sensitive situatio=
n facing the Open Source Lab. Over the past several years, we have been ope=
rating at a deficit due to a decline in corporate donations. While OSU&#39;=
s College of Engineering (CoE) has generously filled this gap, recent chang=
es in university funding have led to a significant reduction in CoE&#39;s b=
udget. As a result, our current funding model is no longer sustainable and =
CoE needs to find ways to cut programs.</div><div dir=3D"auto">&gt; Earlier=
 this week, I was informed that unless we secure $250,000 in committed fund=
s, the OSL will be forced to shut down later this year.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I propose migrating the two VMs we have to =
Digital Ocean and scrapping the DO Kubernetes cluster. However that means w=
e need to move CI to Amazon in the next 1-2 months, before the Microsoft cr=
edits expire.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div=
></div>

--000000000000c3549506340c0e81--


