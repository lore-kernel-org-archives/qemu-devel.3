Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1D3ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfVM-0006lj-4T; Mon, 09 Sep 2024 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfVK-0006gu-SN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfVJ-0005TZ-Eh
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725892592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Ef4QoxE3QAJzscplEqH66V5tSSx0MxDMa9K/rpUmFI=;
 b=ebVbnW7AQ+GgUru90f2OX4eQBxlPsBaQm/CW38PvXt3c3mmQqODqSCJdZkRB60sj+Z8xIv
 ifnnIO4JmhV4wPEFoXgn39fa7ShJTdMcDSIWSdEw12ujabHA+jgSUoKqoaJXHkHxWOePeJ
 UHUBcT8AWKp+Reu3zNXQIPSEma56GkY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-jlkwyuBpOQe_7eBhgHS7Rg-1; Mon, 09 Sep 2024 10:36:31 -0400
X-MC-Unique: jlkwyuBpOQe_7eBhgHS7Rg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45826823bb0so24856351cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725892590; x=1726497390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Ef4QoxE3QAJzscplEqH66V5tSSx0MxDMa9K/rpUmFI=;
 b=KqUYmozqdqPGTUycS52lR8bXt39ebjBi6TYazBdCSZGEVh320csPTL0Io7467R5GX5
 V2zNS0VGhrSt7ZbjyZZsCofa6pW8eTS7bYeNQlSLZXlaFeQc26Kg/zP7zDlVQp2xoNlS
 TNSNDJNFCi7riX95TrAuwt2wJGUylQ6loD4cg8FDl665kM5y9asLj25/m7bAZkTgNo4T
 abmBs8N3RfsWo1lZi1G1nj/rG8CSxw25/W85vzhpqG6jRgpCO63z5HKG8Tx6OvjKEuZ4
 Z9Oyd5+ki9/FMBJ/oDP52+q5nFEcnxmqofJwrMNv7qOzxGj9lNHggiB49lycov6Whjvq
 /m6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvb0DbZgj7CKYfJ6WkMeTDLN4+K4tERz6JwIuONWZsAVI1m9mP1CCG/stSchBviP7vzR9GIe8nME0+@nongnu.org
X-Gm-Message-State: AOJu0Ywn4DEY8D5cv7qcGdNvI6QljEuCGaKx5EAg7Eu8eL2Pz4nHRJ3d
 efLS094D2tCyVGafUqwc1Fb8HCOWLy79BGOye1y7frCOCntyNwwUq5+QXIDHXhFVDQHKt6w5CTO
 X0oDljDqDUNWIVaSyok9UkjmixAhVLb6szJ3ZYEpAzuPQKZjVyd/s
X-Received: by 2002:a05:622a:7281:b0:458:232f:87e5 with SMTP id
 d75a77b69052e-458232f92fbmr71348611cf.10.1725892590667; 
 Mon, 09 Sep 2024 07:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCaqvylkGiUA9BgU0baF7wL6UBwTXdkWRUzVhRfHxdxYZWB1USh0/lq/agOBL7IOlWH+VeA==
X-Received: by 2002:a05:622a:7281:b0:458:232f:87e5 with SMTP id
 d75a77b69052e-458232f92fbmr71348291cf.10.1725892590172; 
 Mon, 09 Sep 2024 07:36:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e772b8sm20936501cf.21.2024.09.09.07.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:36:29 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:36:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Message-ID: <Zt8H6pC2yQ2DD7DV@x1n>
References: <cover.1725889277.git.yong.huang@smartx.com>
 <96eeea4efd3417212d6e2639bc118b90d4dcf926.1725889277.git.yong.huang@smartx.com>
 <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 09, 2024 at 03:02:57PM +0100, Peter Maydell wrote:
> On Mon, 9 Sept 2024 at 14:51, Hyman Huang <yong.huang@smartx.com> wrote:
> >
> > Despite the fact that the responsive CPU throttle is enabled,
> > the dirty sync count may not always increase because this is
> > an optimization that might not happen in any situation.
> >
> > This test case just making sure it doesn't interfere with any
> > current functionality.
> >
> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> 
> tests/qtest/migration-test already runs 75 different
> subtests, takes up a massive chunk of our "make check"
> time, and is very commonly a "times out" test on some
> of our CI jobs. It runs on five different guest CPU
> architectures, each one of which takes between 2 and
> 5 minutes to complete the full migration-test.
> 
> Do we really need to make it even bigger?

I'll try to find some time in the next few weeks looking into this to see
whether we can further shrink migration test times after previous attemps
from Dan.  At least a low hanging fruit is we should indeed put some more
tests into g_test_slow(), and this new test could also be a candidate (then
we can run "-m slow" for migration PRs only).

Thanks,

-- 
Peter Xu


