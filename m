Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739CFCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGBg-0004RS-HB; Wed, 10 Jun 2026 06:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGBe-0004R1-EH
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXGBd-0001Xk-2d
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781087367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxWRPH30fCnIImTOASgUJQGJdhBnCgAor5rptcOPLwY=;
 b=XIQV7cQKGDhYiPl5ui/akuJmX3bUBgsXLMgcmR2tf/72/fX2/Z9e1HIqhq8OmZLPHshRSj
 0S9p5aRBYX78ZPiSaaixW9zBAPPXqvfJdzlrgQ6tlaE5HdBB2/8tINX6hqjWBRVf9dBETl
 p9daPsphMO42XBZktNlIhMwYoTHEN3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-ieEIQ3OpMXGc3VVdeu-72w-1; Wed, 10 Jun 2026 06:29:24 -0400
X-MC-Unique: ieEIQ3OpMXGc3VVdeu-72w-1
X-Mimecast-MFC-AGG-ID: ieEIQ3OpMXGc3VVdeu-72w_1781087363
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b37e1ebfso32306175e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781087363; x=1781692163; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uxWRPH30fCnIImTOASgUJQGJdhBnCgAor5rptcOPLwY=;
 b=YWJROdAPkoqmK322undrmrBTIgybI8rP/MuvtJtGtme4gsLS0eFGU0bF/8OMfMEryE
 MQRIEN8+eVuGxu/6nfqKn930KxLPDwuimaYrsnEvooL0u8fnJc5qkzLH1yupdE/vbX04
 SC6gqvZnwbJoZd6jjjyPkSEV75zW/MEr1CxeJXVA7b2mkE9kBoicxNBmY88Cdrqlq2cS
 TYg3tOyq0/7oOnr0lpTQk1dDITnM+BbOchygLM+65ar9GkCF2TmzbBHoO4N4YwJ1LPIu
 hRbhDomkoJ7LgaLkoBvIMnkbW6P2M8ERRyzJAdvTUoOTRHG7nqbDRkp3XTmBnPXnHWaO
 dJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781087363; x=1781692163;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uxWRPH30fCnIImTOASgUJQGJdhBnCgAor5rptcOPLwY=;
 b=dO6lp0rJ1s/MIdWEmRkak9GYPIrNUiPnzUTLu8OPePjEpkECV9iNbEqdq4nOtjqPWw
 7hMKr7tmLgjSsoxCdgBME0LPS7xJhzUDyA6LSYDPwwu/e0Pdw2EN+XY/3KQTMyHWJU/j
 d6H+CT85GlkDhrHwNE+tauy1bud+/UY2m6alRadCizqoK9noAzLuWmSvAFoPEKdkNR+D
 bOtW4LO40r76Hni7iFPP0tizt8Bb4fhlbQcVg6Zv9mYQdVy8wtNjT9L+YttTSOCZ7l7H
 QNl3IT7Jr46d5h9BiIViK24bjsVS4vDt0IwbpfGwKTtwkulcGw+gfqMoyi+6PXoUXpKW
 E/+g==
X-Gm-Message-State: AOJu0YyMzHe5HuV2L07Dy9zBR8PpsARC1vuYjtvQHicSkHQemIPDuFcq
 B2DBkxRRQuw1tmL3wtYX9XELr7jw7p4CVXSXbufE5/gvbam3x484WPJ+Mcej5kLGCPgj2Ln7MyV
 mRa+ioHj/5AWKMBhUZ09dkbo4JIXAXV8KsyncizLtw4GlG7dBktoZS59x
X-Gm-Gg: Acq92OEON/BPuzSJFvWxdABd2qPNdlQO8bumcHhnxjgNBOCmbjf6CUZrtHNdAHKzWkL
 IWl+PbtvfGww+kG3f9OMGW7VDXTfeltL93IjkSbBAhQsYklm1fUvhISXs3ksfZH63pdOE2Q9ttK
 Q1IdZWTzOjxwdwhhtzv0O9j4W9CC6yhHEDnvxMFthCBQJdJm1NsZSHBAk4F4hQ8L/sM5azN5U3S
 r/B1C5LWshWKIcT1ioV8PgMCIjJlOtt+5T/XD971aPpeMSasM/0CMS3X+FmoFho1VWt0OxUilYI
 Ci7pjnAK6G6cqDIganWsJffE4laYn5YueYk/P+lE8xJ+cIJLEegVPzZ70/ksfYN4zQ6A/z4CCdo
 lLvx4de3kHyb1KZn8quU3naaRmebGqwoGnH5POnh5FD2JbHvX9ViHrg==
X-Received: by 2002:a05:600c:1d27:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490c25e10f9mr410221205e9.20.1781087363249; 
 Wed, 10 Jun 2026 03:29:23 -0700 (PDT)
X-Received: by 2002:a05:600c:1d27:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490c25e10f9mr410220785e9.20.1781087362766; 
 Wed, 10 Jun 2026 03:29:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e59f5sm584432435e9.14.2026.06.10.03.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:29:21 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:29:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 2/3] contribute: add automate tool disclosure to
 bug reporting
Message-ID: <20260610062841-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604165048.457860-3-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 05:50:47PM +0100, Daniel P. Berrangé wrote:
> A while back we added a requirement to declare the use of any
> automated tooling used in discover of security issues, and set
> a rule that the reporter must perform triage before submission
> rather than blindly reporting issues. This applies equally
> well to normal issue reporting, so copy it over from the
> security process guidance.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Maybe .gitlab/issue_templates/bug.md should be updated then?

> ---
>  contribute/report-a-bug.md | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index 6071837..fd3bc6b 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -20,6 +20,13 @@ on GitLab, taking into account the following guidance.
>    to the vendor's own bug tracker instead, or reproduced with
>    an upstream QEMU build prior to submission.
>  
> +* If any automated tools (AI/LLM based, traditional static
> +  analysis, or fuzzers) were used to discover the issue, the
> +  reporter is required to declare this at the start of the
> +  bug report. Users of such tools are required to perform
> +  triage of their output to validate all findings and reproducer
> +  scenarios prior to submitting a bug report.
> +
>  * Reproduce the problem directly with a QEMU command-line. Avoid
>    frontends and management stacks, to ensure that the bug is in
>    QEMU itself and not in a frontend and make it easier for
> -- 
> 2.54.0


