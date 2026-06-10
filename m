Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836ABCD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXG5B-0002WR-G7; Wed, 10 Jun 2026 06:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXG5A-0002VF-BE
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXG58-0007HZ-N7
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFB/ObjHPAnJc5QswfRNKCS4+BR0D4qsn13IjvxU0+4=;
 b=eTB/nTUc8BiPfKAn5qHDvKtWZP9q7hzeS0NoKXxHcoxpi0jnP/8H53klNz0FwUjuq/2eY5
 x/dcSmZ7XH0b/TT75I2m6kn1Qrb+Sk142ucXdkwwQcoA667wkkF3V1X5QW/JOKOS1jth6P
 BHhKsbPRrmmHIRxn1fvQQgYNrV8x1ts=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-ra3UsfOjPnm6wTbx-oQFBA-1; Wed, 10 Jun 2026 06:22:43 -0400
X-MC-Unique: ra3UsfOjPnm6wTbx-oQFBA-1
X-Mimecast-MFC-AGG-ID: ra3UsfOjPnm6wTbx-oQFBA_1781086963
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-beddb45de58so572777266b.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781086962; x=1781691762; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zFB/ObjHPAnJc5QswfRNKCS4+BR0D4qsn13IjvxU0+4=;
 b=Ufy3XLLE/LMsjPjWOPQYp5YGL1+6jSK0RpcPzi/wNxOzPGpi6vPqmfI2eZIx0gVEw1
 dX33/QE6CEsa8VTttVFHji4GlxkNrmbbikke6qB+1KiJCNBwsTnyK2dbx6fUgwUpniDK
 5PD/ZCf+S4wS9bCT6qY3py2eoyNG8i8PdspKPmqOIttUgZVU8Cewg/ES5Zj+DFVxXAI5
 mHWR+bILCfiF/sGzF5B22xJMhP7bfhCh5dEbmrvdnoqPu907G1ud3CTuy5E9pOk+6MJQ
 Q5xVZlhNm6h+EbZwFI/Zh9FQgKKLOOAyQMx51F6lO8oQUJxqPVOe3elP30XKULSd9IRC
 kQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086962; x=1781691762;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zFB/ObjHPAnJc5QswfRNKCS4+BR0D4qsn13IjvxU0+4=;
 b=LDSIYfI9N8a3ea8bVCGjwgKQ2euaI9hSVQnenbthcQqrgUItClAluU5IQRCIOmkOi5
 7+j5rryIblH/uYZ13GfL23bTWh3RGsvYxPhryy9LFoQ2XjDqZD7ar5Yl5o+nEyQXDIb/
 R9f6DDrSXcsOJ4INCwfJ/hMcrmNJvNO7V7luhTMp1jaUGOySbvzC4RCkBfDpIuBHJ2s6
 fiF58vcAZSCSblorwWCA7wjkPQ/ibfnYhISpUbj3PKfU3W0pCDUXGVkwbcSJfCC1paKU
 8HPpqIJiXi6F+YJCE5LRPd4VGirkX15LXSvB5HVwfCaFYOH7kgrlb3TJDS/xK1Zemjtr
 Cqbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96s57y6vahe3jT1sdlinNsZgzdv6TxLwhednMUHC9pSzlZQlJxCiMHQoxOKNBWkONtw34cpdcBsea6@nongnu.org
X-Gm-Message-State: AOJu0YxFsCQqrZOWlpkTkmaIkJr0ClEqNIvE/RuIdUOLmg/hUdW/f9TZ
 d1PpJv8szlwQwECW21d3/WP8GisXOfNVyyAKUCTu2+HnKyj2JnRN3xyGq+LUg4czw3zyiSjQx+V
 67qyg5s9a52skCxVJuYejYiGMsXTS+5V6Q9fcuZFDqj2t15khwk8tmrL6
X-Gm-Gg: Acq92OFy34iD8SuKavHobLRErzXQP16xu7Sj8AiwTkWucXU4Gjfoc8qyNO9GXEvvkot
 3ddVCEtQ5ULFXI7hwTAfUv2xdEllPY/rvDCephqXC7ai0eHDIzmasdaYCIRR6g5gdPcsqCPI+xk
 orLIVQWopAOcbVbTrTfU4skIrYH/BmgTuma9wJriAvOmJUDxzAlTvi8ii6rznPfyvnsTGV0tMa7
 F8VcHMfcW3N5uAyy8Rbgy20xBtiwaYrGzXeOodMSauaBJVxGXJbdnxcZTCJrIak790sTHB0SopT
 ND2MTNciyG0Aie7xpBbw87yeaA3XdjhqPJs93aY/NfKh0ZKTsklXFJ2pS1DeQJsHky3TvQozsYY
 aSDr3iqPDomdozmjqyeMCG6ZVyz2A7mp4UPB4Uk6v8Oku2AyZdX+0nw==
X-Received: by 2002:a17:906:8444:b0:bec:4a86:938d with SMTP id
 a640c23a62f3a-bf36cecd439mr944155366b.0.1781086962474; 
 Wed, 10 Jun 2026 03:22:42 -0700 (PDT)
X-Received: by 2002:a17:906:8444:b0:bec:4a86:938d with SMTP id
 a640c23a62f3a-bf36cecd439mr944153866b.0.1781086961794; 
 Wed, 10 Jun 2026 03:22:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05208e897sm1155911766b.25.2026.06.10.03.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:22:40 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:22:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
Message-ID: <20260610061846-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
 <CAFEAcA_4sKbosaDRSStAWdD73jTvXGnEraRDR1FbfWXun7oLkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_4sKbosaDRSStAWdD73jTvXGnEraRDR1FbfWXun7oLkg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 02:39:06PM +0100, Peter Maydell wrote:
> On Thu, 4 Jun 2026 at 17:51, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > It is no longer viable to handle the incredible volumes of
> > AI assisted security disclosures via email, nor are extended
> > embargos practical or useful.
> >
> > Remove all information about the current security process and
> > instruct reporters to use 'confidential' issues. In contrast
> > to the old highly restrictive "need to know" approach, the
> > new approach makes all security issues visible to all QEMU
> > maintainers immediately.
> >
> > The focus is on making issues public as soon as possible with
> > a viable patch. Co-ordinated disclosure will no longer be
> > attempted and nor will requests to embargoes be accepted.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Since I'm not directly involved with the security process, I
> don't have a strong view here and I trust your judgement that
> this is going to work better. I have a couple of minor
> suggestions below.
> 
> > +## How to disclosure a potential issues
> 
> "How to disclose potential issues"
> 
> > +
> > +**The QEMU project no longer accepts security issue disclosures via email.**
> > +
> > +New disclosures must follow the [report a bug](report-a-bug.html)
> > +process to file a GitLab work item for each potential issue, ***marking
> > +it as "*confidential*" prior to submission.***
> > +
> > +If unsure of the security implications of an issue, err on the side
> > +of caution and mark it as "*confidential*" initially.
> 
> "err on the side of caution" doesn't seem to me to interact
> very well with "we get a ton of not very well filtered AI reports".
> I think we should probably emphasise here that we expect the
> submitter to read our description of the virtualization vs
> non-virtualization use cases and not report bugs that clearly
> don't fall under the virtualization case as confidential.


Sadly it seems that only maintainers of specific piece of code
really know if it's non-virtualization use case.

E.g. nvme emulation is non virtualization, I find out.
Wouldn't have guessed.

> At the moment the text below says that it's the people on the
> receiving end that do that as part of triage.
> 
> The old text started up-front with:
> 
> -Note that not all areas of QEMU are considered to provide a security
> -boundary. Consult the guidance [...]
> 
> "People who send us bad security reports" and "people who don't
> read the documentation about our security process and policy"
> probably has a strong overlap, but I think it's still worth
> making sure we have the emphasis pretty strongly on "you as
> the submitter are expected to not report things we're going to
> instantly triage out as not-security-bugs".
> 
> > +## Triage process
> > +
> > + * A maintainer will evaluate the circumstances of the issue
> > +   to determine if it can be misused for malicious purposes.
> > +
> > + * If there is no potential for meaningful exploit, the disclosure
> > +   should be switched to the public bug report process by removing
> > +   the "*confidential*" marker.
> > +
> > + * If confirmed as a security flaw, a maintainer will request
> 
> "request" seems a stray word here ?
> 
> > +   add the **"cve::required"** GitLab label to the GitLab work item,
> > +   which indicates the need for a CNA to allocate a CVE.
> 
> thanks
> -- PMM


