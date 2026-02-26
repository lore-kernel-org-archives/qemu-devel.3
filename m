Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB79FCE074
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 13:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvb6i-0006Mn-4I; Thu, 26 Feb 2026 08:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvb6d-0006Ma-GO
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:08:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvb6b-0004wk-Rp
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 08:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772111316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVQk/59HD4dRHeGD5AO77X7A3XovayUTypn+utiS27g=;
 b=ELdZpnoAQjCmLi6S69sfg5yLV+036UIeTT7oBz21D/xxcfnXcxPpeQyOwywkUJ8yssznvm
 Hbxrl+IblWT4+ONJlf15Rcxii1AMMhvE2c7t8IgfbZZv/5Hi45Po79ny6Xi40JYluJSPtc
 Y6SDw+c2xwocqXx4apqvnUcv22bMeb4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-6xwgbOW6Pb6YORpVQOXO_A-1; Thu, 26 Feb 2026 08:08:35 -0500
X-MC-Unique: 6xwgbOW6Pb6YORpVQOXO_A-1
X-Mimecast-MFC-AGG-ID: 6xwgbOW6Pb6YORpVQOXO_A_1772111314
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c70b6a5821so528293885a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772111314; x=1772716114; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JVQk/59HD4dRHeGD5AO77X7A3XovayUTypn+utiS27g=;
 b=BSDZ9a4hvgSl44eU/gNYRNtAQnbdITGCqVXIIwp91Oyl4VTS7tyjDSRGNqAbDFtV66
 a4GHpcJ7X6PFzdaKDMSYoene7yvcKqNNNgfrG2rSMBIG2ErGviriWdUktNH1ltHEFeDG
 3FlDSLBVyfLmQUNKpfNRBOvUDsHGT8NP2sjEwPRU3ErTg4H/elId7Ohj40wXthbpTyCf
 H/9KxTtjL9VFO8BSAxJ4b4dt0u+C+0kwhTqxw6TEJm5uGQzXp9qik2/8D+ZtHiZMdSIF
 2mN4c627HX8HiLlwgM2RpwbTJVwOz0/Vmf3LUWrxfvB0a87f40Ecb+wWRlf1F2CsiY1a
 PcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772111314; x=1772716114;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JVQk/59HD4dRHeGD5AO77X7A3XovayUTypn+utiS27g=;
 b=i2dcm7i/YKCMb0jWjZxniz12msxfRvFXY7nLNQG6i4acElS3NI00LaB9iAuo7YNcIp
 AWfWWJcjHbHM4e4sP5S/RLd0z5Q1Sz6xSzBZf+u6jeqXIUwuaXefdNrln49HtQo1wzE3
 WbHi97T2/6sA5aXyj7mg9BNIuq1NOi1juNcmikLgs+yYLvNsX6M5El/vK7SdP1Dj0yqm
 ar1AWCoMX+AcSfgFr1fs+5FhUf2ViD2qLguBRsh5sNw6+zFXjY5cE3aXwYAJuzDkW/Dw
 X31Fo4kkeShWAucSLeNo52Yc09Shd0lLt+OfaOyuQp3v9up3vY7otu8ylf2GX/rCaWVl
 IHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU39xcJREXZ6GYxbrcw5vwOjCAVv/tjxpSWAqLKOS/ofMgmRphK4px1IHHrwT1Mn/2kvqQU2VHVF/2r@nongnu.org
X-Gm-Message-State: AOJu0Yz0kuZCY1Axsxuh3rbgPTk68khdh9DekWDEoUUpZFKa0oH73jcN
 edZZooexyz3LJbHbI6Hap2u6T5BvQ/2mEbPgb0ec6ISLk27H88u1DNEfr/D8cq0kLbXorYd+ot8
 EWYFE9KwrraDt1Z9h+36Tu34q6jKymtNOUgYl/4cyN5TaScym/TJ9KIO3
X-Gm-Gg: ATEYQzwuSVvvZoBneHuOeoiRe0EeGn50Ub2U7KfR0+5VJIN3taTJv5q7lAIzShhyeUG
 DzVnvUEzyFIo4HeG/47mv6BlihEl8nKV4K8Y2BYmtSDiyc41LhPKJFdqjvu5UG1L6oToPcUftkj
 q379H842hdaUkjmCpgqdOKvPbzzJU55To2DmlHEFSvgpVM8tT/vyjf+Z2JwFyHMon7ZfSqHolS3
 xNZ6xr1DBRd2jGKBxEmZpOROmXW0+QZVIBwYYsexwALkyEZkk4Fs/8laYIjZN6WCMrbh9HwQeaq
 fI/5tIyS7CQ+/WuXFr8mLNrBA32byeFCX1VcndICH5qvWoJSK6kxRDou8L73MTQSlRt10hEyD2H
 y2M3lknUl/eCdUg==
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id
 af79cd13be357-8cb8ca18f95mr1521793585a.34.1772111314546; 
 Thu, 26 Feb 2026 05:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:4045:b0:8c0:cbd8:20b0 with SMTP id
 af79cd13be357-8cb8ca18f95mr1521788285a.34.1772111313908; 
 Thu, 26 Feb 2026 05:08:33 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf7161fcsm191836285a.33.2026.02.26.05.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 05:08:33 -0800 (PST)
Date: Thu, 26 Feb 2026 08:08:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
Message-ID: <aaBFxY6PUsNrAYft@x1.local>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <aZ8xlrL2xQtoN9MI@x1.local>
 <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C486617D-2B20-4904-A87B-81CC5FA84153@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 09:16:43AM +0530, Ani Sinha wrote:
> 
> 
> > On 25 Feb 2026, at 10:59 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > Hi, Ani,
> > 
> > On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
> >> Currently the code that adds a migration blocker does not check if the same
> >> blocker already exists. Return an EEXIST error code if there is an attempt to
> >> add the same migration blocker again. This way the same migration blocker will
> >> not get added twice.
> > 
> > Could you help explain why it will inject two identical errors in the first
> > place, and why the caller cannot make sure it won't be injected twice?
> 
> Likely due to a bug in the code. For example if the init function that
> adds the blocker is called again and the caller does not handle the
> second init call properly.  This came up as a part of the coco reset work
> where migration blockers are added in init methods. They need not be
> added again when init methods are again called during the reset
> process. The caller can handle it of course but adding a check further
> down the call stack makes things more robust.

IMHO if we want to make it more robust, we shouldn't return an error
because the caller may not always check for errors.

Would assertion suites more here?  Because migration blockers are not
something the user can manipulate, so it's a solid bug to fix when
triggered.

Thanks,

-- 
Peter Xu


